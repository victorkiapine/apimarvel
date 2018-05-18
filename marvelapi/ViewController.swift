//
//  ViewController.swift
//  marvelapi
//
//  Created by Victor Kiapine on 19/04/2018.
//  Copyright © 2018 Victor Kiapine. All rights reserved.
//

import UIKit

struct Character : Decodable {
    let name : String
    let description : String
    let thumbnail : String
}

class ViewController: UIViewController {
    
    var character = [Character]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseURL(url:"https://gateway.marvel.com/v1/public/characters?ts=1&apikey=4c019a427008cb8ea8e8290ba8711c94&hash=91a0086988d44171a2252a85796a1bbd")
    }
        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parseURL(url:String) {
        
        let url = URL(string: url)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                print("Não funcionou, \(String(describing: error))")
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    
                }
            } else {
                do {
                    if let parsedData = try? JSONSerialization.jsonObject(with: data!) as? NSDictionary {
                        let dataJson = parsedData?.value(forKey: "data") as? NSDictionary
                        
                        if let resultsArray = dataJson?.value(forKey: "results") as? NSArray {
                            self.createCharacter(resultsArray: resultsArray)
                        }
                    }
                
                } catch let error as NSError {
                 print(error)
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        
                    }
                }
            }
        }.resume()
        
    }
    
    func createCharacter(resultsArray:NSArray) {

        for name in resultsArray {
            if let nameDict = name as? NSDictionary {
                if let nameArray = nameDict.value(forKey: "name") {
                    print (nameArray)
                }
            }
        }

        for description in resultsArray {
            if let descDict = description as? NSDictionary {
                if let descArray = descDict.value(forKey: "description") {
                    print(descArray)
                }
            }
        }

        for thumbnail in resultsArray {
            if let thumbDict = thumbnail as? NSDictionary {
                if let thumbArray = thumbDict.value(forKey: "thumbnail") {
                    print(thumbArray)

                }
            }
        }
    }
}
