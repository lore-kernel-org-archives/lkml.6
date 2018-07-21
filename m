Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68879ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 06:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DDA9206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 06:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DDA9206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbeGUH1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 03:27:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42391 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727137AbeGUH1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 03:27:21 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2FFF2207AD; Sat, 21 Jul 2018 08:35:45 +0200 (CEST)
Received: from bbrezillon (unknown [37.173.220.171])
        by mail.bootlin.com (Postfix) with ESMTPSA id 19A222069C;
        Sat, 21 Jul 2018 08:35:43 +0200 (CEST)
Date:   Sat, 21 Jul 2018 08:35:41 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Wenyou Yang <wenyou.yang@microchip.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Han Xu <han.xu@nxp.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Xiaolei Li <xiaolei.li@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>, Stefan Agner <stefan@agner.ch>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4 02/35] mtd: rawnand: cafe: convert driver to
 nand_scan()
Message-ID: <20180721083541.5a52771a@bbrezillon>
In-Reply-To: <20180720151527.16038-3-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
        <20180720151527.16038-3-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 17:14:54 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Two helpers have been added to the core to make ECC-related
> configuration between the detection phase and the final NAND scan. Use
> these hooks and convert the driver to just use nand_scan() instead of
> both nand_scan_ident() and nand_scan_tail().
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/nand/raw/cafe_nand.c | 130 +++++++++++++++++++++++----------------
>  1 file changed, 76 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/cafe_nand.c b/drivers/mtd/nand/raw/cafe_nand.c
> index ac0be933a490..c303c261dd8d 100644
> --- a/drivers/mtd/nand/raw/cafe_nand.c
> +++ b/drivers/mtd/nand/raw/cafe_nand.c
> @@ -71,7 +71,9 @@ struct cafe_priv {
>  	unsigned char *dmabuf;
>  };
>  
> -static int usedma = 1;
> +#define CAFE_DEFAULT_DMA	1
> +
> +static int usedma = CAFE_DEFAULT_DMA;

Not sure you need a macro for that.

>  module_param(usedma, int, 0644);
>  
>  static int skipbbt = 0;
> @@ -593,6 +595,76 @@ static int cafe_mul(int x)
>  	return gf4096_mul(x, 0xe01);
>  }
>  
> +static int cafe_nand_attach_chip(struct nand_chip *chip)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct cafe_priv *cafe = nand_get_controller_data(chip);
> +	int err = 0;
> +
> +	cafe->dmabuf = dma_alloc_coherent(&cafe->pdev->dev, 2112,
> +					  &cafe->dmaaddr, GFP_KERNEL);
> +	if (!cafe->dmabuf)
> +		return -ENOMEM;
> +
> +	/* Set up DMA address */
> +	cafe_writel(cafe, lower_32_bits(cafe->dmaaddr), NAND_DMA_ADDR0);
> +	cafe_writel(cafe, upper_32_bits(cafe->dmaaddr), NAND_DMA_ADDR1);
> +
> +	cafe_dev_dbg(&cafe->pdev->dev, "Set DMA address to %x (virt %p)\n",
> +		     cafe_readl(cafe, NAND_DMA_ADDR0), cafe->dmabuf);
> +
> +	/* Restore the DMA flag */
> +	usedma = CAFE_DEFAULT_DMA;

This is wrong. The user might have passed a different value to usedma
when loading the module (or on the kernel cmdline), and you're simply
ignoring it. I see 2 solutions to solve that:

1/ add a ->usedma field to the cafe_priv struct which you initialize to
   0 in the probe function (already done if you kzalloc() the struct)
   and update it here:

	cafe->usedma = usedma.

   then you have to patch all places where usedma was tested and
   replace this test by a test on cafe->usedma

2/ add a static in old_usedma which you assign to usedma value in the
   probe and then restore the usedma value here:

	usedma = old_usedma

I prefer option #1.
