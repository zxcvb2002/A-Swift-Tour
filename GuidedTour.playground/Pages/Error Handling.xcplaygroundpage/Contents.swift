//: ## Error Handling
//:
//: You represent errors using any type that adopts the `Error` protocol.
//:
enum PrinterError: Error {
    case outOfPaper
    case noToner
    case onFire
}

//: Use `throw` to throw an error and `throws` to mark a function that can throw an error. If you throw an error in a function, the function returns immediately and the code that called the function handles the error.
//:
func send(job: Int, toPrinter printerName: String) throws -> String {
    if printerName == "Never Has Toner" {
        throw PrinterError.noToner
    }
    return "Job sent"
}

//: There are several ways to handle errors. One way is to use `do`-`catch`. Inside the `do` block, you mark code that can throw an error by writing `try` in front of it. Inside the `catch` block, the error is automatically given the name `error` unless you give it a different name.
//:
do {
    let printerResponse = try send(job: 1040, toPrinter: "Bi Sheng")
    // print(printerResponse)
} catch {
    // print(error)
}



do {
    let printerResponse = try send(job: 1040, toPrinter: "Never Has Toner")
    // print(printerResponse)
} catch {
    // print(error)
}

//: - Experiment:
//: Change the printer name to `"Never Has Toner"`, so that the `send(job:toPrinter:)` function throws an error.
//:
//: You can provide multiple `catch` blocks that handle specific errors. You write a pattern after `catch` just as you do after `case` in a switch.
//:
/*
func send(job: Int, toPrinter printerName: String) throws -> String {
    if printerName == "Never Has Toner" {
        throw PrinterError.noToner
    } else if printerName == "Gutenberg" {
        throw PrinterError.onFire
    }
    return "Job sent"
}
*/



do {
    let printerResponse = try send(job: 1440, toPrinter: "Gutenberg")
    // print(printerResponse)
} catch PrinterError.onFire {
    // print("I'll just put this over here, with the rest of the fire.")
} catch let printerError as PrinterError {
    // print("Printer error: \(printerError).")
} catch {
    // print(error)
}



// # 1 - first block

/*
do {
    throw PrinterError.onFire
    let printerResponse = try send(job: 1440, toPrinter: "Gutenberg")
    // print(printerResponse)
} catch PrinterError.onFire {
    // print("I'll just put this over here, with the rest of the fire.")
} catch let printerError as PrinterError {
    // print("Printer error: \(printerError).")
} catch {
    // print(error)
}
*/

// # 2 - second block

/*
do {
    let printerResponse = try send(job: 1440, toPrinter: "Never Has Toner")
    // print(printerResponse)
} catch PrinterError.onFire {
    // print("I'll just put this over here, with the rest of the fire.")
} catch let printerError as PrinterError {
    // print("Printer error: \(printerError).")
} catch {
    // print(error)
}
*/

// # 3 - third block

/*
enum anotherEnum: ErrorType {
    case someCase
}

do {
    throw anotherEnum.someCase
    let printerResponse = try send(job: 1440, toPrinter: "Gutenberg")
    // print(printerResponse)
} catch PrinterError.onFire {
    // print("I'll just put this over here, with the rest of the fire.")
} catch let printerError as PrinterError {
    // print("Printer error: \(printerError).")
} catch {
    // print(error)
}
*/

//: - Experiment:
//: Add code to throw an error inside the `do` block. What kind of error do you need to throw so that the error is handled by the first `catch` block? What about the second and third blocks?
//:
//: Another way to handle errors is to use `try?` to convert the result to an optional. If the function throws an error, the specific error is discarded and the result is `nil`. Otherwise, the result is an optional containing the value that the function returned.
//:
let printerSuccess = try? send(job: 1884, toPrinter: "Mergenthaler")
let printerFailure = try? send(job: 1885, toPrinter: "Never Has Toner")

//: Use `defer` to write a block of code that’s executed after all other code in the function, just before the function returns. The code is executed regardless of whether the function throws an error. You can use `defer` to write setup and cleanup code next to each other, even though they need to be executed at different times.
//:
var fridgeIsOpen = false
let fridgeContent = ["milk", "eggs", "leftovers"]

func fridgeContains(_ food: String) -> Bool {
    fridgeIsOpen = true
    defer {
        fridgeIsOpen = false
    }

    let result = fridgeContent.contains(food)
    return result
}
fridgeContains("banana")
// print(fridgeIsOpen)



//: [Previous](@previous) | [Next](@next)
