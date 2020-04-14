local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_ecobottles:sellBottles')
AddEventHandler('esx_ecobottles:sellBottles', function()
    local player = ESX.GetPlayerFromId(source)
    local currentBottles = player.getInventoryItem('bottle')['count']

    if currentBottles > 0 then
        math.randomseed(os.time())
        local randomMoney = math.random((Config.BottleReward[1] or 1), (Config.BottleReward[2] or 4))
        player.removeInventoryItem('bottle', currentBottles)
        player.addMoney(randomMoney * currentBottles)
        xPlayer.showNotification(('You gave the store %s bottles and got paid $%s.'):format(currentBottles, currentBottles * randomMoney))
    else
        xPlayer.showNotification('You don\'t have any bottles to give the store.')
    end
end)

RegisterServerEvent('esx_ecobottles:retrieveBottle')
AddEventHandler('esx_ecobottles:retrieveBottle', function()
    local player = ESX.GetPlayerFromId(source)
    math.randomseed(os.time())
    local luck = math.random(0, 69)
    local randomBottle = math.random((Config.BottleReceive[1] or 1), (Config.BottleReceive[2] or 6))

    if luck >= 0 and luck <= 29 then
        xPlayer.showNotification('The bin had no bottles in it.')
    else
        player.addInventoryItem('bottle', randomBottle)
        xPlayer.showNotification(('You found x%s bottles'):format(randomBottle))
    end
end)
