Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C19DC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBAD021A8F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TGVsT3oG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBAD021A8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933635AbeGDKuq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:50:46 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36334 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932594AbeGDKun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:50:43 -0400
Received: by mail-io0-f195.google.com with SMTP id k3-v6so4490468iog.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 03:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CA05o+lJLwmbfK9MOLNm802NKMoWIVN3DNGkoR6VQpk=;
        b=TGVsT3oG3AkPWffefRbhLKVr4C/BAS5sx3ebbvVGtU+MNoOcxGqcZkUCiRpZao0qHS
         C97TIwO/VyhO8M5DF7zt9btrkoF2FtTwkaT9+51Xq9YYoQjxud6s0qbL17jXwTcW9SGA
         rPzTRkG3nHDMfMMe46R290/ifgk/t7chLezMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CA05o+lJLwmbfK9MOLNm802NKMoWIVN3DNGkoR6VQpk=;
        b=BEo/LWyvx9eDBOvN7l0/ID3Cpk3579C3ideTUXFqaWQJ8/MiFOGlo6367fp/K5kAKD
         Vx2oyHqUrCRPlP0HNxQd3yTKkJ/PS/jZU8nzPzX8bNCMp+bLNjR/1ZmMWNREDq5rStD6
         0rHDrIqRdw61pHOQZWTS2FF5NmKuOt0+0KyezeO9RoRzos9BdtAUMKEtwqLl5LFZl11x
         oDayZWZOQLLtKkXLhoSHwy6FOoHgQF6gJMeqR9KHFXVNPZ8wbQ8QJh5QONbhC4TFYPJ4
         yXUCyvBBudDNYKTjERKHIWr87CDyZbdSgaqYgNOXEuxlo6sB5FXqM63r+77Aq77b+mB2
         rRsQ==
X-Gm-Message-State: AOUpUlG1Id4Rq+OFKaSUNM6haDUVYWqmbqCUl70SgK7rscRbJMV1JhI9
        WwxIbdFM5IU8024EmrPKKiq7Ze4ikU2G/JPBcsam5Q==
X-Google-Smtp-Source: AAOMgpftV0Gdu/lsKu70KM8nYtDWWwROoBz48XCRBuKqQwRWoJkFQnXymwufYOPEGoQ0bQzAnXiATi5ltdZRk+6eVxY=
X-Received: by 2002:a6b:c997:: with SMTP id z145-v6mr1156715iof.266.1530701443070;
 Wed, 04 Jul 2018 03:50:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 03:50:42 -0700 (PDT)
In-Reply-To: <1530685741-20604-1-git-send-email-stefan@olimex.com>
References: <1530685741-20604-1-git-send-email-stefan@olimex.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Jul 2018 12:50:42 +0200
Message-ID: <CAPDyKFo_fadfNbt8YMS3MMjaxjt1B54DtZJ+-LoH9y5JeRi5pQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mmc: sunxi: Disable irq during pm_suspend
To:     Stefan Mavrodiev <stefan@olimex.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." 
        <linux-mmc@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Marc

On 4 July 2018 at 08:28, Stefan Mavrodiev <stefan@olimex.com> wrote:
> When mmc host controller enters suspend state, the clocks are
> disabled, but irqs are not. For some reason the irqchip emits
> false interrupts, which causes system lock loop.
>
> Debug log is:
>   ...
>   sunxi-mmc 1c11000.mmc: setting clk to 52000000, rounded 51200000
>   sunxi-mmc 1c11000.mmc: enabling the clock
>   sunxi-mmc 1c11000.mmc: cmd 13(8000014d) arg 10000 ie 0x0000bbc6 len 0
>   sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00000004 idi 00000000
>   sunxi-mmc 1c11000.mmc: cmd 6(80000146) arg 3210101 ie 0x0000bbc6 len 0
>   sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00000004 idi 00000000
>   sunxi-mmc 1c11000.mmc: cmd 13(8000014d) arg 10000 ie 0x0000bbc6 len 0
>   sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00000004 idi 00000000
>   mmc1: new DDR MMC card at address 0001
>   mmcblk1: mmc1:0001 AGND3R 14.6 GiB
>   mmcblk1boot0: mmc1:0001 AGND3R partition 1 4.00 MiB
>   mmcblk1boot1: mmc1:0001 AGND3R partition 2 4.00 MiB
>   sunxi-mmc 1c11000.mmc: cmd 18(80003352) arg 0 ie 0x0000fbc2 len 409
>   sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00004000 idi 00000002
>    mmcblk1: p1
>   sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
>   sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
>   sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
>   sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
> and so on...
>
> This issue apears on eMMC cards, routed on MMC2 slot. The patch is
> tested with A20-OLinuXino-MICRO/LIME/LIME2 boards.
>
> Fixes: 9a8e1e8cc2c0 ("mmc: sunxi: Add runtime_pm support")
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> ---
>  Changes in v2:
>   - Add comment why disable_irq() is necessary
>
> ---
>  drivers/mmc/host/sunxi-mmc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index e747259..8e7f3e3 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1446,6 +1446,7 @@ static int sunxi_mmc_runtime_resume(struct device *dev)
>         sunxi_mmc_init_host(host);
>         sunxi_mmc_set_bus_width(host, mmc->ios.bus_width);
>         sunxi_mmc_set_clk(host, &mmc->ios);
> +       enable_irq(host->irq);
>
>         return 0;
>  }
> @@ -1455,6 +1456,12 @@ static int sunxi_mmc_runtime_suspend(struct device *dev)
>         struct mmc_host *mmc = dev_get_drvdata(dev);
>         struct sunxi_mmc_host *host = mmc_priv(mmc);
>
> +       /*
> +        * When clocks are off, it's possible receiving
> +        * fake interrupts, which will stall the system.
> +        * Disabling the irq  will prevent this.
> +        */
> +       disable_irq(host->irq);

No, this doesn't work for shared IRQs.

>         sunxi_mmc_reset_host(host);
>         sunxi_mmc_disable(host);
>
> --
> 2.7.4
>

The only option today is to use free_irq() in runtime suspend and then
re-request the irq to re-install the handler at runtime resume.

That's not an optimal solution, which is pointed out in the below
discussion as well. Moreover, it has also turned out using free_irq()
is also problematic in cases threaded handlers are used.

Here's the link to the discussion, it's not the only one I know of, so
this is common problem.
https://lkml.org/lkml/2016/1/28/213

Care to have a hack on the "common" solution, which in principle means
adding APIs to genirq that can disable/enable handlers from being
called, rather than the entire IRQ line.

Kind regards
Uffe
