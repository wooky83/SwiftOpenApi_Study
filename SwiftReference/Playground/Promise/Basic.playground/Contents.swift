//: Playground - noun: a place where people can play

import UIKit
import PromiseKit

enum CSError: Error {
    case unkwon
}

func timeOut1() -> Promise<Bool> {
    print("timeOut1")
    return Promise { seal in
        seal.fulfill(true)
    }
}

func timeOut2(_ b: Bool) -> Promise<Int> {
    print("timeOut2")
    return Promise { seal in
        if (Int.random(in: 1..<10) % 2) == 0 {
            seal.fulfill(7)
        } else {
            seal.reject(CSError.unkwon)
        }
    }
}

func typeChange(name: Int) -> String {
    "Good Luck! \(name)"
}

firstly {
    timeOut1()
}
.then {
    timeOut2($0)
}
.map(typeChange)
.done { value in
    print(value)
}
.ensure {
    print("ensure")
}
.catch { error in
    print(error)
}
.finally {
    print("finally")
}


