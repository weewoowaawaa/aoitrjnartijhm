local GetName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)

local ok = {"Moving", "Tween", "TP"}

local function Notif(title, text, dur)
local CoreGui = game:GetService("StarterGui")
        CoreGui:SetCore("SendNotification", {
        Title = title;
        Text = text;
        Duration = dur
        })
end


local function Quest()
for i,v in pairs(game:GetService("Workspace").Resources.Teleports:GetChildren()) do
        if v.ClassName == "Folder" then
            local A_1 = v.Name
            local Event = game:GetService("ReplicatedStorage").Packages.Knit.Services.QuestService.RF.ActionQuest
            Event:InvokeServer(A_1)
        end
    end
end

local function getNearest()
    local Closest, Distance = nil, 99999
    for _, v in pairs(game:GetService("Workspace").Live.NPCs.Client:GetChildren()) do
        for i,l in pairs(v:GetChildren()) do
              if l:FindFirstChild("Head") then
                local Mag = (game:GetService("Players").LocalPlayer.Character.Head.Position - v.Head.Position).magnitude
                if Mag < Distance then
                Distance = Mag
                Closest = v
            end
        end
    end
    end
    return Closest
end

local function questNearest()
    local quest = game:GetService("Players").LocalPlayer.PlayerGui.RightSidebar.Background.Frame.Window.Items.CurrentQuest.ProgressLabel.Text
    local newText = quest:gsub('[%d%p]', "")
    local better = newText:gsub('^%s*', "")
    local Closest, Distance = nil, 99999
    for i,v in pairs(game:GetService("Workspace").Live.NPCs.Client:GetChildren()) do
            if v.HumanoidRootPart.NPCTag.NameLabel.Text == better then
              if v:FindFirstChild("Head") then
                local Mag = (game:GetService("Players").LocalPlayer.Character.Head.Position - v.Head.Position).magnitudedd
                if Mag < Distance then
                Distance = Mag
                Closest = v
            end
        end
    end
    end
    return Closest
end

local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

local player = game.Players.LocalPlayer

local DiscordLib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/discord%20lib.txt")()

local win = DiscordLib:Window(GetName.Name)

local serv = win:Server("Capysploit", "")

local tgls = serv:Channel("AutoFarm")

tgls:Label("Made by heqds <3")

local selectedautofarm
local drop = tgls:Dropdown("Pick a way to farm", ok, function(v)
print(v)
selectedautofarm = v
end)

tgls:Toggle("Autoclick",false, function(state)
    getgenv().ac = state
    
    while wait() do
        if getgenv().ac == true then 
        local A_1 = getNearest().Name
        local Event = game:GetService("ReplicatedStorage").Packages.Knit.Services.ClickService.RF.Click
        Event:InvokeServer(A_1)
        end
    end
    end)

tgls:Toggle("AutoFarm Nearest",false, function(state)
getgenv().af = state

while wait() do
    if getgenv().af == true then
        if selectedautofarm == nil then
            Notif("Warning", "No selected way to farm", 10)
            getgenv().af = false
            break;
        elseif selectedautofarm == "Moving" then
            player.Character.Humanoid:MoveTo(getNearest().HumanoidRootPart.Position)
        elseif selectedautofarm == "Tween" then
            local CFrameEnd = CFrame.new(getNearest().HumanoidRootPart.Position)
            local Time = 1
            local tween =  game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(Time), {CFrame = CFrameEnd})
            tween:Play()
        elseif selectedautofarm == "TP" then
            player.Character.HumanoidRootPart.CFrame = getNearest().Head.CFrame * CFrame.new(0, 2, 0)
        elseif getgenv().af == false then
               getgenv().af = false
               break;
        end
    end
    end
end)

tgls:Toggle("Auto Collect Coins",false, function(state)
getgenv().acc = state

while wait() do
    if getgenv().acc == true then 
        for i,v in pairs(game:GetService("Workspace").Live.Pickups:GetChildren()) do
            if v.Name == "Currency" then
                v.CFrame = player.Character.HumanoidRootPart.CFrame
            end
        end        
    end
end
end)

tgls:Toggle("Auto Ascend (Auto Rebirth)",false, function(state)
getgenv().aa = state

while wait() do
    if getgenv().aa == true then 
        local Event = game:GetService("ReplicatedStorage").Packages.Knit.Services.AscendService.RF.Ascend
        Event:InvokeServer()
        end
    end
end)

local pon = serv:Channel("Upgrades")

local selectedupg
local drop = pon:Dropdown("Pick Upgrade", {"Crit Multiplier", "More Storage", "WalkSpeed", "Crit Chance", "Power Gain"} , function(v)
print(v)
selectedupg = v
end)

pon:Toggle("Auto Upgrade",false, function(state)
getgenv().au = state

while au do
   if selectedupg == nil then
        Notif("Warning", "No upgrade has been selected.", 10)
        getgenv().au = false
        break;
     
   else
        for i,v in pairs(game:GetService("Workspace").Resources.Teleports:GetChildren()) do
            if v.ClassName == "Folder" then
                local A_1 = v.Name
                local A_2 = selectedupg
                local Event = game:GetService("ReplicatedStorage").Packages.Knit.Services.UpgradeService.RF.Upgrade
                Event:InvokeServer(A_1, A_2)
                wait()
            end
        end
    end
end
end)


local egg = serv:Channel("Utilities")

itemTable = {}
for _,v in pairs(game:GetService("Workspace").Resources.EggStands:GetChildren()) do
   if not table.find(itemTable, v.Name) then
       table.insert(itemTable, v.Name)
   end
end

egg:Label("Pets")

egg:Toggle("Auto Equip Best Pet",false, function(state)
getgenv().aep = state
while aep do
    local Event = game:GetService("ReplicatedStorage").Packages.Knit.Services.PetInvService.RF.EquipBest
    Event:InvokeServer()
    wait()
    end
end)

egg:Label("Sword")

egg:Toggle("Auto Equip Best Sword",false, function(state)
getgenv().aes = state

while aes do
    local Event = game:GetService("ReplicatedStorage").Packages.Knit.Services.WeaponInvService.RF.EquipBest
    Event:InvokeServer()
    wait()
    end
end)

local textbs = serv:Channel("Misc")

textbs:Textbox("Speed", "Enter Custom Speed", true, function(v)
while true do
player.Character.Humanoid.WalkSpeed = v
wait()
end
end)

textbs:Button("Infinite Jump", function()
local InfiniteJumpEnabled = true
game:GetService("UserInputService").JumpRequest:connect(function()
	if InfiniteJumpEnabled then
		game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
	end
end)
end)
