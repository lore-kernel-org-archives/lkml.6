Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753252AbeE1FcT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 01:32:19 -0400
Received: from vps01.wiesinger.com ([46.36.37.179]:53374 "EHLO
        vps01.wiesinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbeE1FcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 01:32:15 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com w4S5WADJ008891
Subject: Re: B53 DSA switch problem on Banana Pi-R1 on Fedora 26 -
 systemd-networkd problem
To: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        initramfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <3bdb712d-38bd-e2ca-63cf-8406a7b5689d@wiesinger.com>
 <20180522201632.GB4396@lunn.ch>
 <59d6b55f-d50a-063c-90a9-31a758e01383@gmail.com>
 <fa5c2615-40b3-62bc-3dda-59f9ef574686@wiesinger.com>
 <76c3f5ec-0ab2-c06d-98e8-277284bb1a8e@gmail.com>
 <779f2be3-3e74-e650-5240-efaf1003d77c@wiesinger.com>
 <4f7c5173-019d-ba0e-70b3-addf64a6a9fa@gmail.com>
 <aba2788a-ba54-dbc8-dd60-e862ba31d66d@wiesinger.com>
 <53c9272a-0e1a-e8fb-a3e4-b4e23e77be10@gmail.com>
 <ba1a6179-48ff-ca2b-bb3c-f99f8376df50@wiesinger.com>
 <18ca17a1-4673-2ace-7142-d4aef6854bc4@wiesinger.com>
 <219eaac0-3d76-005a-f8d6-c54ea21f205e@wiesinger.com>
 <80a5da81-0ed3-14bc-2e62-bd25f05de792@gmail.com>
From: Gerhard Wiesinger <lists@wiesinger.com>
Message-ID: <8ffb6309-3d08-3043-43d9-49aa3a686bf6@wiesinger.com>
Date: Mon, 28 May 2018 07:32:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <80a5da81-0ed3-14bc-2e62-bd25f05de792@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.05.2018 22:31, Florian Fainelli wrote:
> Le 05/27/18 à 12:01, Gerhard Wiesinger a écrit :
>> On 24.05.2018 08:22, Gerhard Wiesinger wrote:
>>> On 24.05.2018 07:29, Gerhard Wiesinger wrote:
>>>> After some analysis with Florian (thnx) we found out that the current
>>>> implementation is broken:
>>>>
>>>> https://patchwork.ozlabs.org/patch/836538/
>>>> https://github.com/torvalds/linux/commit/c499696e7901bda18385ac723b7bd27c3a4af624#diff-a2b6f8d89e18de600e873ac3ac43fa1d
>>>>
>>>>
>>>> Florians comment:
>>>>
>>>> c499696e7901bda18385ac723b7bd27c3a4af624 ("net: dsa: b53: Stop using
>>>> dev->cpu_port incorrectly") since it would result in no longer setting
>>>> the CPU port as tagged for a specific VLAN. Easiest way for you right
>>>> now is to just revert it, but this needs some more thoughts for a proper
>>>> upstream change. I will think about it some more.
>>> Can confirm 4.14.18-200.fc26.armv7hl works, 4.15.x should be broken.
>>>
>>> # Kernel 4.14.x ok
>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/log/drivers/net/dsa/b53?h=v4.14.43
>>>
>>> # Kernel 4.15.x should be NOT ok
>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/log/drivers/net/dsa/b53?h=v4.15.18
>>>
>> Kernel 4.14.18-300.fc27.armv7hl works well so far, even with FC28
>> update. Florian send me a patch to try for 4.16.x
> So does my patch make 4.16 work correctly for you now? If so, can I just
> submit it and copy you?
>
>> I got the  commands below to work with manual script commands.
>> Afterwards I wrote systemd-networkd config where I've a strage problem
>> when IPv6 sends a multicast broadcast from another machine to the bridge
>> this will be sent back via the network interface, but with the source
>> MAC of the bridge of the other machine. dmesg from the other machine:
>> [117768.330444] br0: received packet on lan0 with own address as source
>> address (addr:a0:36:9f:ab:cd:ef, vlan:0)
>> [117768.334887] br0: received packet on lan0 with own address as source
>> address (addr:a0:36:9f:ab:cd:ef, vlan:0)
>> [117768.339281] br0: received packet on lan0 with own address as source
>> address (addr:a0:36:9f:ab:cd:ef, vlan:0)
>>
>> And: If I just enter this command after e.g. a systemd-network restart
>> everything is fine forever:
>> # Not OK (dmesg message above is triggered on a remote computer, whole
>> switching network gets unstable, ssh terminals close, packet loss, etc.)
>> systemctl restart systemd-networkd
>> # OK again when this command is entered
>> bridge vlan add dev wan vid 102 pvid untagged
>>
>> brctl show, ip link, bridge vlan, bridge link commands, etc. look all
>> the same, also /sys/class/net/br0/bridge, /sys/class/net/br1/bridge
>> settings
>>
>> Systemd config correct?
>> Any ideas?
> You should not have eth0.101 and eth0.102 to be enslaved in a bridge at
> all, this is what is causing the bridge to be confused. Remember what I
> wrote to you before, with the current b53 driver that does not have any
> tagging enabled the lanX interfaces and brX interfaces are only used for
> control and should not be used for passing any data. The only network
> device that will be passing data is eth0, which is why we need to set-up
> VLAN interfaces to pop/push the VLAN id accordingly.
>
> I have no idea why manual vs. systemd does not work but you can most
> certainly troubleshoot that by comparing the bridge/ip outputs.

So is that then the correct structure?

br1
- lan1 (with VID 101)
- lan2 (with VID 101)
- lan3 (with VID 101)
- lan4 (with VID 101)

brlan
- eth0.101
- wlan0 (currently not active, could be optimized without bridge but for 
future comfort)

br2
- wan (with VID 102) (could be optimized without bridge but for future 
comfort)
- future1

brwan
- eth0.102 (could be optimized without bridge but for future comfort)
- future2

Ad systemd vs. manual config: As I said I didn't find any difference in 
the bridge/ip outputs. As they are broken (see other message) maybe 
something else is broken, too.

Thnx.

Ciao,
Gerhard
