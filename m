Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751975AbeECMXP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:23:15 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:62848 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751360AbeECMXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:23:11 -0400
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="11659498"
Subject: Re: [RFC PATCH 4/5] net: macb: Add support for suspend/resume with
 full power down
To: Harini Katakam <harinik@xilinx.com>
CC: Nicolas Ferre <nicolas.ferre@atmel.com>,
        David Miller <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michals@xilinx.com>,
        <appanad@xilinx.com>
References: <1521726700-22634-1-git-send-email-harinikatakamlinux@gmail.com>
 <1521726700-22634-5-git-send-email-harinikatakamlinux@gmail.com>
 <35d980af-b9d5-495e-88af-c4fc911b8429@microchip.com>
 <CAFcVECK3UO+tckXnTKvLpWe3+RiZ7fyDmS+3JjgOdeQTRwy_FQ@mail.gmail.com>
From: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Message-ID: <585eabe8-aae4-cfd3-01aa-bad17197a28d@microchip.com>
Date: Thu, 3 May 2018 15:23:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAFcVECK3UO+tckXnTKvLpWe3+RiZ7fyDmS+3JjgOdeQTRwy_FQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03.05.2018 14:20, Harini Katakam wrote:
> Hi Claudiu,
> 
> On Thu, May 3, 2018 at 3:39 PM, Claudiu Beznea
> <Claudiu.Beznea@microchip.com> wrote:
>>
>>
>> On 22.03.2018 15:51, harinikatakamlinux@gmail.com wrote:
>>> From: Harini Katakam <harinik@xilinx.com>
>>>
>>> When macb device is suspended and system is powered down, the clocks
>>> are removed and hence macb should be closed gracefully and restored
>>> upon resume.
>>
>> Is this a power saving mode which shut down the core?
> 
> The Ethernet IP is suspended and a majority of the SoC is shut down, yes.
> 
> <snip>
>>> +             netif_device_detach(netdev);
>>> +     } else {
>>> +             netif_device_detach(netdev);
>>> +             for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
>>> +                     napi_disable(&queue->napi);
>>> +             phy_stop(netdev->phydev);
>>> +             phy_suspend(netdev->phydev);
>>> +             spin_lock_irqsave(&bp->lock, flags);
>>> +             macb_reset_hw(bp);
>>> +             spin_unlock_irqrestore(&bp->lock, flags);
>>
>> Wouldn't be simple to just call macb_close() here?
> 
> <snip>
>>
>> Wouln't be simpler to call macb_open() here?
> 
> No, I think that would be excessive for suspend. This does just
> enough to put the IP into suspend and cut off clocks.
> For ex., the RX and TX buffers are not freed and allocated again
> in this cycle, just the buffer descriptors.
> 

For me looks simpler to just call macb_close()/macb_open() in suspend/resume
hooks. Maybe this doesn't fit to your needs... But most of the code you
added in suspend/resume hooks is already present in macb_open()/macb_close(),
except the TX/RX buffers alloc/free.

SAMA5D2 also uses this IP. SAMA5d2 has a power saving mode where core power is cut
off (including this IP). We are using macb_open()/macb_close() + restoring all
few other registers after this (by calling macb_set_rx_mode() and a variant of
macb_set_features() and few other registers). This is not yet mainlined. I was
intending to send soon a version.

Thank you,
Claudiu

> Regards,
> Harini
> 
