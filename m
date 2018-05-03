Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751283AbeECK6y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 06:58:54 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:44682 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbeECK6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 06:58:52 -0400
X-Google-Smtp-Source: AB8JxZoBdF4YK2+gEIjayi0jIQ7LKAc+i3JcldocmY1mjGft8nymu85GxhJzrSgrIRbcmLPkU2oNLbP47g8vQzhTxYE=
MIME-Version: 1.0
In-Reply-To: <81b5b276-e59c-79d8-1616-79ff0e9c5f17@microchip.com>
References: <1521726700-22634-1-git-send-email-harinikatakamlinux@gmail.com>
 <1521726700-22634-2-git-send-email-harinikatakamlinux@gmail.com> <81b5b276-e59c-79d8-1616-79ff0e9c5f17@microchip.com>
From: Harini Katakam <harinik@xilinx.com>
Date: Thu, 3 May 2018 16:28:51 +0530
X-Google-Sender-Auth: CQs2ZTewbkAGoCF-C21zjhQqyis
Message-ID: <CAFcVECJNKHJwF+o=kgZb=fVvLB5TCPzvRUqZXVY3zGOe1DCdsA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] net: macb: Check MDIO state before read/write and
 use timeouts
To: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, michals@xilinx.com, appanad@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

On Thu, May 3, 2018 at 3:38 PM, Claudiu Beznea
<Claudiu.Beznea@microchip.com> wrote:
>
>
> On 22.03.2018 15:51, harinikatakamlinux@gmail.com wrote:
>> From: Harini Katakam <harinik@xilinx.com>
>>
<snip>
>> +     ulong timeout;
>> +
>> +     timeout = jiffies + msecs_to_jiffies(1000);
>> +     /* wait for end of transfer */
>> +     do {
>> +             if (MACB_BFEXT(IDLE, macb_readl(bp, NSR)))
>> +                     break;
>> +
>> +             cpu_relax();
>> +     } while (!time_after_eq(jiffies, timeout));
>> +
>> +     if (time_after_eq(jiffies, timeout)) {
>> +             netdev_err(bp->dev, "wait for end of transfer timed out\n");
>> +             return -ETIMEDOUT;
>> +     }
>
> Wouldn't be cleaner to keep it in this way:
>
>         while (!MACB_BFEXT(IDLE, macb_readl(bp, NSR))) {
>                 if (time_after_eq(jiffies, timeout) {
>                         netdev_err(bp->dev, "wait for end of transfer timed out\n");
>                         return -ETIMEDOUT;
>                 }
>                 cpu_relax();
>         }
>

Thanks for the review.
Sure, will update in next version.

Regards,
Harini
