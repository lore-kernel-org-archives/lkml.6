Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbeECLNz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 07:13:55 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:46728 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751065AbeECLNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 07:13:51 -0400
X-Google-Smtp-Source: AB8JxZpoMyho5z8jg6GSy2oT2dh0VCd0SLbMzZfmIzznDJecp5yCbYt+A4zIx5wsC85/tT7n9xBy5HyVhtyUvTixE5w=
MIME-Version: 1.0
In-Reply-To: <48b8ea24-52be-c314-f674-1a6cae4d95f4@microchip.com>
References: <1521726700-22634-1-git-send-email-harinikatakamlinux@gmail.com>
 <1521726700-22634-4-git-send-email-harinikatakamlinux@gmail.com> <48b8ea24-52be-c314-f674-1a6cae4d95f4@microchip.com>
From: Harini Katakam <harinik@xilinx.com>
Date: Thu, 3 May 2018 16:43:50 +0530
X-Google-Sender-Auth: xK7adr4wlQX40TWErPAIRirp0ek
Message-ID: <CAFcVECKWz6bGZpg7UF=4hObUjca12Oq5NbE0SBL+v=1grJP8YA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] net: macb: Add pm runtime support
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

On Thu, May 3, 2018 at 3:39 PM, Claudiu Beznea
<Claudiu.Beznea@microchip.com> wrote:
>
>
> On 22.03.2018 15:51, harinikatakamlinux@gmail.com wrote:
>> From: Harini Katakam <harinik@xilinx.com>
<snip>
> I would use a "goto" instruction, e.g.:
>                 value = -ETIMEDOUT;
>                 goto out;
>

Will do

>
> Below, in macb_open() you have a return err; case:
>         err = macb_alloc_consistent(bp);
>         if (err) {
>                 netdev_err(dev, "Unable to allocate DMA memory (error %d)\n",
>                            err);
>                 return err;
>         }
>
> You have to undo pm_runtime_get_sync() with pm_runtime_put_sync() or something
> similar to decrement dev->power.usage_count.

Will do

<snip>
>> @@ -4104,11 +4145,16 @@ static int macb_remove(struct platform_device *pdev)
>>               mdiobus_free(bp->mii_bus);
>>
>>               unregister_netdev(dev);
>> -             clk_disable_unprepare(bp->tx_clk);
>> -             clk_disable_unprepare(bp->hclk);
>> -             clk_disable_unprepare(bp->pclk);
>> -             clk_disable_unprepare(bp->rx_clk);
>> -             clk_disable_unprepare(bp->tsu_clk);
>> +             pm_runtime_disable(&pdev->dev);
>> +             pm_runtime_dont_use_autosuspend(&pdev->dev);
>> +             if (!pm_runtime_suspended(&pdev->dev)) {
>> +                     clk_disable_unprepare(bp->tx_clk);
>> +                     clk_disable_unprepare(bp->hclk);
>> +                     clk_disable_unprepare(bp->pclk);
>> +                     clk_disable_unprepare(bp->rx_clk);
>> +                     clk_disable_unprepare(bp->tsu_clk);
>> +                     pm_runtime_set_suspended(&pdev->dev);
>
> This is driver remove function. Shouldn't clocks be removed?

clk_disable_unprepare IS being done here.
The check for !pm_runtime_suspended is just to make sure the
clocks are not already removed (in runtime_suspend).

Regards,
Harini
