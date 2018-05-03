Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751484AbeECLUC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 07:20:02 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:40724 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbeECLUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 07:20:01 -0400
X-Google-Smtp-Source: AB8JxZootJlnfaiU1RV9puaTune/qmBSIERphHhIICuBxwdsfJo2unKdrEx2KyNpRvpMwh6ud/thF+ehn4K0TL08YIo=
MIME-Version: 1.0
In-Reply-To: <35d980af-b9d5-495e-88af-c4fc911b8429@microchip.com>
References: <1521726700-22634-1-git-send-email-harinikatakamlinux@gmail.com>
 <1521726700-22634-5-git-send-email-harinikatakamlinux@gmail.com> <35d980af-b9d5-495e-88af-c4fc911b8429@microchip.com>
From: Harini Katakam <harinik@xilinx.com>
Date: Thu, 3 May 2018 16:50:00 +0530
X-Google-Sender-Auth: Yb2vFKdIcjw5NMtILdraWTu-X-M
Message-ID: <CAFcVECK3UO+tckXnTKvLpWe3+RiZ7fyDmS+3JjgOdeQTRwy_FQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] net: macb: Add support for suspend/resume with
 full power down
To: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, michals@xilinx.com, appanad@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

On Thu, May 3, 2018 at 3:39 PM, Claudiu Beznea
<Claudiu.Beznea@microchip.com> wrote:
>
>
> On 22.03.2018 15:51, harinikatakamlinux@gmail.com wrote:
>> From: Harini Katakam <harinik@xilinx.com>
>>
>> When macb device is suspended and system is powered down, the clocks
>> are removed and hence macb should be closed gracefully and restored
>> upon resume.
>
> Is this a power saving mode which shut down the core?

The Ethernet IP is suspended and a majority of the SoC is shut down, yes.

<snip>
>> +             netif_device_detach(netdev);
>> +     } else {
>> +             netif_device_detach(netdev);
>> +             for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
>> +                     napi_disable(&queue->napi);
>> +             phy_stop(netdev->phydev);
>> +             phy_suspend(netdev->phydev);
>> +             spin_lock_irqsave(&bp->lock, flags);
>> +             macb_reset_hw(bp);
>> +             spin_unlock_irqrestore(&bp->lock, flags);
>
> Wouldn't be simple to just call macb_close() here?

<snip>
>
> Wouln't be simpler to call macb_open() here?

No, I think that would be excessive for suspend. This does just
enough to put the IP into suspend and cut off clocks.
For ex., the RX and TX buffers are not freed and allocated again
in this cycle, just the buffer descriptors.

Regards,
Harini
