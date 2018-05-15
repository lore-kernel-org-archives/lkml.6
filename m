Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752551AbeEOIjM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 04:39:12 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:49025 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752396AbeEOIjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 04:39:10 -0400
X-IronPort-AV: E=Sophos;i="5.49,403,1520924400";
   d="scan'208";a="14261108"
Subject: Re: [RFC PATCH 5/5] net: macb: Add WOL support with ARP
To: Harini Katakam <harinik@xilinx.com>
CC: Nicolas Ferre <nicolas.ferre@atmel.com>,
        David Miller <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michals@xilinx.com>,
        <appanad@xilinx.com>
References: <1521726700-22634-1-git-send-email-harinikatakamlinux@gmail.com>
 <1521726700-22634-6-git-send-email-harinikatakamlinux@gmail.com>
 <51e1b2f3-4dd7-3513-2148-649372775130@microchip.com>
 <CAFcVECKA6J-c4KYPZS05Ooj4x5+AARcxCdJfV2uHOHNOVXZaOQ@mail.gmail.com>
From: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Message-ID: <a1f253bd-b2f2-943f-2653-45019d344886@microchip.com>
Date: Tue, 15 May 2018 11:39:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAFcVECKA6J-c4KYPZS05Ooj4x5+AARcxCdJfV2uHOHNOVXZaOQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harini,

On 10.05.2018 13:37, Harini Katakam wrote:
> Hi Claudiu,
> 
> On Fri, May 4, 2018 at 5:47 PM, Claudiu Beznea
> <Claudiu.Beznea@microchip.com> wrote:
>>
>>
>> On 22.03.2018 15:51, harinikatakamlinux@gmail.com wrote:
>>> From: Harini Katakam <harinik@xilinx.com>
>>>
>>> This patch enables ARP wake event support in GEM through the following:
>>>
>>> -> WOL capability can be selected based on the SoC/GEM IP version rather
>>> than a devictree property alone. Hence add a new capability property and
>>> set device as "wakeup capable" in probe in this case.
>>> -> Wake source selection can be done via ethtool or by enabling wakeup
>>> in /sys/devices/platform/..../ethx/power/
>>> This patch adds default wake source as ARP and the existing selection of
>>> WOL using magic packet remains unchanged.
>>> -> When GEM is the wake device with ARP as the wake event, the current
>>> IP address to match is written to WOL register along with other
>>> necessary confuguration required for MAC to recognize an ARP event.
>>> -> While RX needs to remain enabled, there is no need to process the
>>> actual wake packet - hence tie off all RX queues to avoid unnecessary
>>> processing by DMA in the background.
>>
>> Why is this different for magic packet vs ARP packet?
> 
> This should ideally be the same whether it is a magic packet or ARP on
> the version of the IP we use (more details in my comment below).
> I simply did not alter the magic packet code for now to avoid breaking
> others' flow.

I see your point. But in the end the code should be nice and clean.

>
> <snip>
>>> +#define MACB_CAPS_WOL                                0x00000080
>>
>> I think would be better to have this as part of bp->wol and use it properly
>> in suspend/resume hooks.
> 
> I think a capability flag as part of config structure is better
> because this is clearly an SoC related feature and there is no need
> to have a devicetree property.

Since there is no difference b/w ARP and magic packet in term of SoC,
I mean, there is no special treatment b/w them, I think we should treat
them both in the same way. This was my point.

> 
> <snip>
>> Wouldn't it work if you will change it in something like this:
>>
>>         u32 wolmask, arpipmask = 0;
>>
>>         if (bp->wol & MACB_WOL_ENABLED) {
>>                 macb_writel(bp, IER, MACB_BIT(WOL));
>>
>>                 if (bp->wol & MACB_WOL_HAS_ARP_PACKET) {
>>                         /* Enable broadcast. */
>>                         gem_writel(bp, NCFGR, gem_readl(bp, NCFGR) & ~MACB_BIT(NBC));
>>                         arpipmask = cpu_to_be32p(&bp->dev->ip_ptr->ifa_list->ifa_local) & 0xFFFF;
>>                         wolmask = arpipmask | MACB_BIT(ARP);
>>                 } else {
>>                         wolmask = MACB_BIT(MAG);
>>                 }
>>
>>                 macb_writel(bp, WOL, wolmask);
>>                 enable_irq_wake(bp->queues[0].irq);
> 
> The above would work. But I'd still have to add the RX BD changes
> and then stop the phy, disable interrupt etc., for most optimal power
> down state - the idea is to keep only is essential to detect a wake event.
> 

Also, with your approach the suspend/resume time will be longer.

>>                 netif_device_detach(netdev);
>>         }
>>
>> I cannot find anything particular for ARP WOL events in datasheet. Also,
>> I cannot find something related to DMA activity while WOL is active
> 
> Can you please let me know which version you are referring to?
> ZynqMP uses the IP version r1p06 or 07.

I have user guide revision 15
.

> 
> There is a clear set of rules for ARP wake event to be recognized.
> 
> About the DMA activity, it is not explicitly mentioned but we have
> observed that the DMA will continue to process incoming packets
> and try to write them to the memory and Cadence has confirmed
> the same. Later versions of the IP may have some provision to
> stop DMA activity on RX channel but unfortunately in this version,
> using a dummy RX buffer descriptor is the only way.>
> I'm looking into your other suggestions.
> Thanks, will get back to you.
> 
> Regards,
> Harini
> 
