Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751483AbeDYIxu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 04:53:50 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:33634 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbeDYIxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 04:53:43 -0400
X-Google-Smtp-Source: AIpwx48AQVTV5B5n8IMj9mrYK2zFVYwb+BRubEafKhqHm9lJkkPt6I6W2aYq3Y+j4VxAMI84a4X+JiXP+3ZUvnwPSK0=
MIME-Version: 1.0
In-Reply-To: <20180330143051.26423-1-nsekhar@ti.com>
References: <20180330143051.26423-1-nsekhar@ti.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 25 Apr 2018 10:53:42 +0200
Message-ID: <CAMRc=Mdsqc-ZJy9WMkdh_S=ehh1CfyFtgyF6mWwFT=xnNGhieg@mail.gmail.com>
Subject: Re: [PATCH] mtd: nand: davinci: don't acquire and enable clock
To: Sekhar Nori <nsekhar@ti.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        David Lechner <david@lechnology.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-30 16:30 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
> NAND itself is an asynchronous interface, it does not have any
> clock input. DaVinci NAND driver acquires clock for AEMIF
> (asynchronous external memory interface) which is an on-chip
> IP to which NAND is connected.
>
> The same clock is also enabled in AEMIF driver (either present
> drivers/memory or from machine code for some older platforms).
> AEMIF timing must be initialized before NAND can be accessed.
> This ensures that AEMIF clock is enabled too.
>
> Remove the superfluous clock acquisition and enable in DaVinci
> NAND driver.
>
> Tested on K2L, K2HK, K2E, DA850 EVM, DA850 LCDK in device-tree
> boot and DM644x EVM in legacy boot.
>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
> Hi Boris,
>
> If/when this patch gets accepted, it will nice to put this on
> an immutable branch others can merge. There is potential cleanup
> in drivers/clock and in DaVinci machine code that will depend
> on this.
>
> Thanks,
> Sekhar
>
>  drivers/mtd/nand/raw/davinci_nand.c | 25 +------------------------
>  1 file changed, 1 insertion(+), 24 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
> index 0f09518d980f..7255a0d94374 100644
> --- a/drivers/mtd/nand/raw/davinci_nand.c
> +++ b/drivers/mtd/nand/raw/davinci_nand.c
> @@ -27,7 +27,6 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/err.h>
> -#include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/mtd/rawnand.h>
>  #include <linux/mtd/partitions.h>
> @@ -55,7 +54,6 @@ struct davinci_nand_info {
>         struct nand_chip        chip;
>
>         struct device           *dev;
> -       struct clk              *clk;
>
>         bool                    is_readmode;
>
> @@ -703,22 +701,6 @@ static int nand_davinci_probe(struct platform_device *pdev)
>         /* Use board-specific ECC config */
>         info->chip.ecc.mode     = pdata->ecc_mode;
>
> -       ret = -EINVAL;
> -
> -       info->clk = devm_clk_get(&pdev->dev, "aemif");
> -       if (IS_ERR(info->clk)) {
> -               ret = PTR_ERR(info->clk);
> -               dev_dbg(&pdev->dev, "unable to get AEMIF clock, err %d\n", ret);
> -               return ret;
> -       }
> -
> -       ret = clk_prepare_enable(info->clk);
> -       if (ret < 0) {
> -               dev_dbg(&pdev->dev, "unable to enable AEMIF clock, err %d\n",
> -                       ret);
> -               goto err_clk_enable;
> -       }
> -
>         spin_lock_irq(&davinci_nand_lock);
>
>         /* put CSxNAND into NAND mode */
> @@ -732,7 +714,7 @@ static int nand_davinci_probe(struct platform_device *pdev)
>         ret = nand_scan_ident(mtd, pdata->mask_chipsel ? 2 : 1, NULL);
>         if (ret < 0) {
>                 dev_dbg(&pdev->dev, "no NAND chip(s) found\n");
> -               goto err;
> +               return ret;
>         }
>
>         switch (info->chip.ecc.mode) {
> @@ -838,9 +820,6 @@ static int nand_davinci_probe(struct platform_device *pdev)
>         nand_cleanup(&info->chip);
>
>  err:
> -       clk_disable_unprepare(info->clk);
> -
> -err_clk_enable:
>         spin_lock_irq(&davinci_nand_lock);
>         if (info->chip.ecc.mode == NAND_ECC_HW_SYNDROME)
>                 ecc4_busy = false;
> @@ -859,8 +838,6 @@ static int nand_davinci_remove(struct platform_device *pdev)
>
>         nand_release(nand_to_mtd(&info->chip));
>
> -       clk_disable_unprepare(info->clk);
> -
>         return 0;
>  }
>
> --
> 2.16.2
>

Tested-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
