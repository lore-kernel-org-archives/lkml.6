Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756954AbeEJKh4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 06:37:56 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33132 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756820AbeEJKhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 06:37:43 -0400
X-Google-Smtp-Source: AB8JxZqnei3tS0yO081Yjyzpnt9lah2SaCNMfMOduoo+7tblWxa2eUXFvWDyxdg4r98OuA46lFkZQMQSyjhn8EGL3VQ=
MIME-Version: 1.0
In-Reply-To: <51e1b2f3-4dd7-3513-2148-649372775130@microchip.com>
References: <1521726700-22634-1-git-send-email-harinikatakamlinux@gmail.com>
 <1521726700-22634-6-git-send-email-harinikatakamlinux@gmail.com> <51e1b2f3-4dd7-3513-2148-649372775130@microchip.com>
From: Harini Katakam <harinik@xilinx.com>
Date: Thu, 10 May 2018 16:07:41 +0530
X-Google-Sender-Auth: zcnEROJVfKXlvRdlA8rYz8Lonnc
Message-ID: <CAFcVECKA6J-c4KYPZS05Ooj4x5+AARcxCdJfV2uHOHNOVXZaOQ@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] net: macb: Add WOL support with ARP
To: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, michals@xilinx.com, appanad@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

On Fri, May 4, 2018 at 5:47 PM, Claudiu Beznea
<Claudiu.Beznea@microchip.com> wrote:
>
>
> On 22.03.2018 15:51, harinikatakamlinux@gmail.com wrote:
>> From: Harini Katakam <harinik@xilinx.com>
>>
>> This patch enables ARP wake event support in GEM through the following:
>>
>> -> WOL capability can be selected based on the SoC/GEM IP version rather
>> than a devictree property alone. Hence add a new capability property and
>> set device as "wakeup capable" in probe in this case.
>> -> Wake source selection can be done via ethtool or by enabling wakeup
>> in /sys/devices/platform/..../ethx/power/
>> This patch adds default wake source as ARP and the existing selection of
>> WOL using magic packet remains unchanged.
>> -> When GEM is the wake device with ARP as the wake event, the current
>> IP address to match is written to WOL register along with other
>> necessary confuguration required for MAC to recognize an ARP event.
>> -> While RX needs to remain enabled, there is no need to process the
>> actual wake packet - hence tie off all RX queues to avoid unnecessary
>> processing by DMA in the background.
>
> Why is this different for magic packet vs ARP packet?

This should ideally be the same whether it is a magic packet or ARP on
the version of the IP we use (more details in my comment below).
I simply did not alter the magic packet code for now to avoid breaking
others' flow.

<snip>
>> +#define MACB_CAPS_WOL                                0x00000080
>
> I think would be better to have this as part of bp->wol and use it properly
> in suspend/resume hooks.

I think a capability flag as part of config structure is better
because this is clearly an SoC related feature and there is no need
to have a devicetree property.

<snip>
> Wouldn't it work if you will change it in something like this:
>
>         u32 wolmask, arpipmask = 0;
>
>         if (bp->wol & MACB_WOL_ENABLED) {
>                 macb_writel(bp, IER, MACB_BIT(WOL));
>
>                 if (bp->wol & MACB_WOL_HAS_ARP_PACKET) {
>                         /* Enable broadcast. */
>                         gem_writel(bp, NCFGR, gem_readl(bp, NCFGR) & ~MACB_BIT(NBC));
>                         arpipmask = cpu_to_be32p(&bp->dev->ip_ptr->ifa_list->ifa_local) & 0xFFFF;
>                         wolmask = arpipmask | MACB_BIT(ARP);
>                 } else {
>                         wolmask = MACB_BIT(MAG);
>                 }
>
>                 macb_writel(bp, WOL, wolmask);
>                 enable_irq_wake(bp->queues[0].irq);

The above would work. But I'd still have to add the RX BD changes
and then stop the phy, disable interrupt etc., for most optimal power
down state - the idea is to keep only is essential to detect a wake event.

>                 netif_device_detach(netdev);
>         }
>
> I cannot find anything particular for ARP WOL events in datasheet. Also,
> I cannot find something related to DMA activity while WOL is active

Can you please let me know which version you are referring to?
ZynqMP uses the IP version r1p06 or 07.

There is a clear set of rules for ARP wake event to be recognized.

About the DMA activity, it is not explicitly mentioned but we have
observed that the DMA will continue to process incoming packets
and try to write them to the memory and Cadence has confirmed
the same. Later versions of the IP may have some provision to
stop DMA activity on RX channel but unfortunately in this version,
using a dummy RX buffer descriptor is the only way.

I'm looking into your other suggestions.
Thanks, will get back to you.

Regards,
Harini
