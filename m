Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeDSKFt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 06:05:49 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4179 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbeDSKFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 06:05:47 -0400
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 19 Apr 2018 03:05:46 -0700
Subject: Re: [PATCH] net: phy: marvell: clear wol event before setting it
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
CC: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jingju Hou <Jingju.Hou@synaptics.com>
References: <20180419160232.519d15be@xhacker.debian>
 <96e77eac86794bef9a5b772147527c67@bgmail102.nvidia.com>
 <20180419165351.5388021e@xhacker.debian>
 <e1409c9493f64188a71b44f69ccb24cf@bgmail102.nvidia.com>
 <20180419170932.7a0b88fb@xhacker.debian>
From: Bhadram Varka <vbhadram@nvidia.com>
Message-ID: <1c3a4b66-b10c-adc9-b7e4-57b46f5c86e5@nvidia.com>
Date: Thu, 19 Apr 2018 15:35:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180419170932.7a0b88fb@xhacker.debian>
X-Originating-IP: [10.24.193.52]
X-ClientProxiedBy: DRBGMAIL103.nvidia.com (10.18.16.22) To
 bgmail102.nvidia.com (10.25.59.11)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HiJisheng,

On 4/19/2018 2:39 PM, Jisheng Zhang wrote:
> On Thu, 19 Apr 2018 09:00:40 +0000 Bhadram Varka wrote:
>
>> Hi,
>>
>>> -----Original Message-----
>>> From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
>>> Sent: Thursday, April 19, 2018 2:24 PM
>>> To: Bhadram Varka <vbhadram@nvidia.com>
>>> Cc: Andrew Lunn <andrew@lunn.ch>; Florian Fainelli <f.fainelli@gmail.com>;
>>> David S. Miller <davem@davemloft.net>; netdev@vger.kernel.org; linux-
>>> kernel@vger.kernel.org; Jingju Hou <Jingju.Hou@synaptics.com>
>>> Subject: Re: [PATCH] net: phy: marvell: clear wol event before setting it
>>>
>>> Hi,
>>>
>>> On Thu, 19 Apr 2018 08:38:45 +0000 Bhadram Varka wrote:
>>>    
>>>> Hi,
>>>>   
>>>>> -----Original Message-----
>>>>> From: netdev-owner@vger.kernel.org <netdev-owner@vger.kernel.org> On
>>>>> Behalf Of Jisheng Zhang
>>>>> Sent: Thursday, April 19, 2018 1:33 PM
>>>>> To: Andrew Lunn <andrew@lunn.ch>; Florian Fainelli
>>>>> <f.fainelli@gmail.com>; David S. Miller <davem@davemloft.net>
>>>>> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Jingju Hou
>>>>> <Jingju.Hou@synaptics.com>
>>>>> Subject: [PATCH] net: phy: marvell: clear wol event before setting
>>>>> it
>>>>>
>>>>> From: Jingju Hou <Jingju.Hou@synaptics.com>
>>>>>
>>>>> If WOL event happened once, the LED[2] interrupt pin will not be
>>>>> cleared unless reading the CSISR register. So clear the WOL event before
>>> enabling it.
>>>>> Signed-off-by: Jingju Hou <Jingju.Hou@synaptics.com>
>>>>> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
>>>>> ---
>>>>>   drivers/net/phy/marvell.c | 9 +++++++++
>>>>>   1 file changed, 9 insertions(+)
>>>>>
>>>>> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
>>>>> index c22e8e383247..b6abe1cbc84b 100644
>>>>> --- a/drivers/net/phy/marvell.c
>>>>> +++ b/drivers/net/phy/marvell.c
>>>>> @@ -115,6 +115,9 @@
>>>>>   /* WOL Event Interrupt Enable */
>>>>>   #define MII_88E1318S_PHY_CSIER_WOL_EIE			BIT(7)
>>>>>
>>>>> +/* Copper Specific Interrupt Status Register */
>>>>> +#define MII_88E1318S_PHY_CSISR				0x13
>>>>> +
>>>> There is already macro to represent this register - MII_M1011_IEVENT. Do we
>>> need this macro ?
>>>
>>> Good point. Will use MII_M1011_IEVENT instead in v2.
>>>    
>>>>   
>>>>>   /* LED Timer Control Register */
>>>>>   #define MII_88E1318S_PHY_LED_TCR			0x12
>>>>>   #define MII_88E1318S_PHY_LED_TCR_FORCE_INT		BIT(15)
>>>>> @@ -1393,6 +1396,12 @@ static int m88e1318_set_wol(struct phy_device
>>>>> *phydev,
>>>>>   		if (err < 0)
>>>>>   			goto error;
>>>>>
>>>>> +		/* If WOL event happened once, the LED[2] interrupt pin
>>>>> +		 * will not be cleared unless reading the CSISR register.
>>>>> +		 * So clear the WOL event first before enabling it.
>>>>> +		 */
>>>>> +		phy_read(phydev, MII_88E1318S_PHY_CSISR);
>>>> This part of the operation already taken care by ack_interrupt and
>>>> did_interrupt [....] .ack_interrupt = &marvell_ack_interrupt,
>>>> .did_interrupt = &m88e1121_did_interrupt, [...]
>>>>
>>>> If at all WOL event occurred marvell_ack_interrupt will take care of clearing the
>>> interrupt status register.
>>>> Am I missing anything here ?
>>> If there's no valid irq for phy, the ack_interrupt/did_interrupt won't be called.
>> Which means that the PHY is not having Interrupt pin ?
> No valid irq doesn't mean "not having interrupt pin". they are different
Okay. If there is WoL event through magic packet then its valid irq for 
the PHY right.
Then phy_interrupt will be called from there ack/did_interrupts will be 
called. So it clears WoL interrupt.
>
>> Generally through PHY interrupt will wake up the system right. If there is no interrupt pin then how the system will wake up the from suspend for the magic packet.?
>>
> IIRC, the phy irq isn't necessary for WOL. The phy interrupt pin isn't
> necessarily taken as "interrupt"
Please correct me if I am wrong. In this case how the system will wake 
up from the SC7.There has to be wake capable irq/gpio pin to do this 
operation.

Thanks,
Bhadram.
