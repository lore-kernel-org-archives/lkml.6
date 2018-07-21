Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500FCECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 17:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1664020849
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 17:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1664020849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbeGUSns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 14:43:48 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50084 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbeGUSns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 14:43:48 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 34CEA206F3; Sat, 21 Jul 2018 19:50:15 +0200 (CEST)
Received: from bbrezillon (unknown [37.173.79.60])
        by mail.bootlin.com (Postfix) with ESMTPSA id CEFB02093C;
        Sat, 21 Jul 2018 19:49:17 +0200 (CEST)
Date:   Sat, 21 Jul 2018 19:49:16 +0200
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
Subject: Re: [PATCH v4 20/35] mtd: rawnand: sh_flctl: convert driver to
 nand_scan()
Message-ID: <20180721194916.169f5651@bbrezillon>
In-Reply-To: <20180720151527.16038-21-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
        <20180720151527.16038-21-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 17:15:12 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Two helpers have been added to the core to make ECC-related
> configuration between the detection phase and the final NAND scan. Use
> these hooks and convert the driver to just use nand_scan() instead of
> both nand_scan_ident() and nand_scan_tail().
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/mtd/nand/raw/sh_flctl.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
> index d37d1d3ccbf9..663c75005ac9 100644
> --- a/drivers/mtd/nand/raw/sh_flctl.c
> +++ b/drivers/mtd/nand/raw/sh_flctl.c
> @@ -1002,10 +1002,10 @@ static void flctl_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
>  	flctl->index += len;
>  }
>  
> -static int flctl_chip_init_tail(struct mtd_info *mtd)
> +static int flctl_chip_attach_chip(struct nand_chip *chip)
>  {
> +	struct mtd_info *mtd = nand_to_mtd(chip);
>  	struct sh_flctl *flctl = mtd_to_flctl(mtd);
> -	struct nand_chip *chip = &flctl->chip;
>  
>  	if (chip->options & NAND_BUSWIDTH_16) {
>  		/*
> @@ -1073,6 +1073,10 @@ static int flctl_chip_init_tail(struct mtd_info *mtd)
>  	return 0;
>  }
>  
> +static const struct nand_controller_ops flctl_nand_controller_ops = {
> +	.attach_chip = flctl_chip_attach_chip,
> +};
> +
>  static irqreturn_t flctl_handle_flste(int irq, void *dev_id)
>  {
>  	struct sh_flctl *flctl = dev_id;
> @@ -1200,15 +1204,8 @@ static int flctl_probe(struct platform_device *pdev)
>  
>  	flctl_setup_dma(flctl);
>  
> -	ret = nand_scan_ident(flctl_mtd, 1, NULL);
> -	if (ret)
> -		goto err_chip;
> -
> -	ret = flctl_chip_init_tail(flctl_mtd);
> -	if (ret)
> -		goto err_chip;
> -
> -	ret = nand_scan_tail(flctl_mtd);
> +	nand->dummy_controller.ops = &flctl_nand_controller_ops;
> +	ret = nand_scan(flctl_mtd, 1);
>  	if (ret)
>  		goto err_chip;
>  

