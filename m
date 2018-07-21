Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4D9ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 06:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7D72084A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 06:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7D72084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeGUHpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 03:45:10 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42837 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbeGUHpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 03:45:10 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E3AC5207B4; Sat, 21 Jul 2018 08:53:29 +0200 (CEST)
Received: from bbrezillon (unknown [37.170.141.1])
        by mail.bootlin.com (Postfix) with ESMTPSA id B235D2069C;
        Sat, 21 Jul 2018 08:53:27 +0200 (CEST)
Date:   Sat, 21 Jul 2018 08:53:25 +0200
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
Subject: Re: [PATCH v4 06/35] mtd: rawnand: fsl_ifc: convert driver to
 nand_scan()
Message-ID: <20180721085325.0d9dbf2f@bbrezillon>
In-Reply-To: <20180720151527.16038-7-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
        <20180720151527.16038-7-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 17:14:58 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Two helpers have been added to the core to make ECC-related
> configuration between the detection phase and the final NAND scan. Use
> these hooks and convert the driver to just use nand_scan() instead of
> both nand_scan_ident() and nand_scan_tail().
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/mtd/nand/raw/fsl_ifc_nand.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/fsl_ifc_nand.c
> index 96130d91e32c..24f59d0066af 100644
> --- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
> +++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
> @@ -714,9 +714,9 @@ static int fsl_ifc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
>  	return nand_prog_page_end_op(chip);
>  }
>  
> -static int fsl_ifc_chip_init_tail(struct mtd_info *mtd)
> +static int fsl_ifc_attach_chip(struct nand_chip *chip)
>  {
> -	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct mtd_info *mtd = nand_to_mtd(chip);
>  	struct fsl_ifc_mtd *priv = nand_get_controller_data(chip);
>  
>  	dev_dbg(priv->dev, "%s: nand->numchips = %d\n", __func__,
> @@ -757,6 +757,10 @@ static int fsl_ifc_chip_init_tail(struct mtd_info *mtd)
>  	return 0;
>  }
>  
> +static const struct nand_controller_ops fsl_ifc_controller_ops = {
> +	.attach_chip = fsl_ifc_attach_chip,
> +};
> +
>  static void fsl_ifc_sram_init(struct fsl_ifc_mtd *priv)
>  {
>  	struct fsl_ifc_ctrl *ctrl = priv->ctrl;
> @@ -1046,15 +1050,8 @@ static int fsl_ifc_nand_probe(struct platform_device *dev)
>  	if (ret)
>  		goto err;
>  
> -	ret = nand_scan_ident(mtd, 1, NULL);
> -	if (ret)
> -		goto err;
> -
> -	ret = fsl_ifc_chip_init_tail(mtd);
> -	if (ret)
> -		goto err;
> -
> -	ret = nand_scan_tail(mtd);
> +	priv->chip.controller->ops = &fsl_ifc_controller_ops;
> +	ret = nand_scan(mtd, 1);
>  	if (ret)
>  		goto err;
>  

