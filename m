Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF27ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 15:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED1620854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 15:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED1620854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbeGUQQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 12:16:32 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47787 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727759AbeGUQQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 12:16:32 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 31BC22072F; Sat, 21 Jul 2018 17:23:24 +0200 (CEST)
Received: from bbrezillon (unknown [37.173.79.60])
        by mail.bootlin.com (Postfix) with ESMTPSA id E51E8206A6;
        Sat, 21 Jul 2018 17:23:21 +0200 (CEST)
Date:   Sat, 21 Jul 2018 17:23:19 +0200
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
Subject: Re: [PATCH v4 10/35] mtd: rawnand: jz4780: convert driver to
 nand_scan()
Message-ID: <20180721172250.723b4fd2@bbrezillon>
In-Reply-To: <20180720151527.16038-11-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
        <20180720151527.16038-11-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 17:15:02 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Two helpers have been added to the core to make ECC-related
> configuration between the detection phase and the final NAND scan. Use
> these hooks and convert the driver to just use nand_scan() instead of
> both nand_scan_ident() and nand_scan_tail().
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Acked-by: Harvey Hunt <harveyhuntnexus@gmail.com>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/mtd/nand/raw/jz4780_nand.c | 34 ++++++++++++++++------------------
>  1 file changed, 16 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/jz4780_nand.c b/drivers/mtd/nand/raw/jz4780_nand.c
> index 49841dad347c..db4fa60bd52a 100644
> --- a/drivers/mtd/nand/raw/jz4780_nand.c
> +++ b/drivers/mtd/nand/raw/jz4780_nand.c
> @@ -158,9 +158,8 @@ static int jz4780_nand_ecc_correct(struct mtd_info *mtd, u8 *dat,
>  	return jz4780_bch_correct(nfc->bch, &params, dat, read_ecc);
>  }
>  
> -static int jz4780_nand_init_ecc(struct jz4780_nand_chip *nand, struct device *dev)
> +static int jz4780_nand_attach_chip(struct nand_chip *chip)
>  {
> -	struct nand_chip *chip = &nand->chip;
>  	struct mtd_info *mtd = nand_to_mtd(chip);
>  	struct jz4780_nand_controller *nfc = to_jz4780_nand_controller(chip->controller);
>  	int eccbytes;
> @@ -171,7 +170,8 @@ static int jz4780_nand_init_ecc(struct jz4780_nand_chip *nand, struct device *de
>  	switch (chip->ecc.mode) {
>  	case NAND_ECC_HW:
>  		if (!nfc->bch) {
> -			dev_err(dev, "HW BCH selected, but BCH controller not found\n");
> +			dev_err(nfc->dev,
> +				"HW BCH selected, but BCH controller not found\n");
>  			return -ENODEV;
>  		}
>  
> @@ -180,15 +180,16 @@ static int jz4780_nand_init_ecc(struct jz4780_nand_chip *nand, struct device *de
>  		chip->ecc.correct = jz4780_nand_ecc_correct;
>  		/* fall through */
>  	case NAND_ECC_SOFT:
> -		dev_info(dev, "using %s (strength %d, size %d, bytes %d)\n",
> -			(nfc->bch) ? "hardware BCH" : "software ECC",
> -			chip->ecc.strength, chip->ecc.size, chip->ecc.bytes);
> +		dev_info(nfc->dev, "using %s (strength %d, size %d, bytes %d)\n",
> +			 (nfc->bch) ? "hardware BCH" : "software ECC",
> +			 chip->ecc.strength, chip->ecc.size, chip->ecc.bytes);
>  		break;
>  	case NAND_ECC_NONE:
> -		dev_info(dev, "not using ECC\n");
> +		dev_info(nfc->dev, "not using ECC\n");
>  		break;
>  	default:
> -		dev_err(dev, "ECC mode %d not supported\n", chip->ecc.mode);
> +		dev_err(nfc->dev, "ECC mode %d not supported\n",
> +			chip->ecc.mode);
>  		return -EINVAL;
>  	}
>  
> @@ -200,7 +201,7 @@ static int jz4780_nand_init_ecc(struct jz4780_nand_chip *nand, struct device *de
>  	eccbytes = mtd->writesize / chip->ecc.size * chip->ecc.bytes;
>  
>  	if (eccbytes > mtd->oobsize - 2) {
> -		dev_err(dev,
> +		dev_err(nfc->dev,
>  			"invalid ECC config: required %d ECC bytes, but only %d are available",
>  			eccbytes, mtd->oobsize - 2);
>  		return -EINVAL;
> @@ -211,6 +212,10 @@ static int jz4780_nand_init_ecc(struct jz4780_nand_chip *nand, struct device *de
>  	return 0;
>  }
>  
> +static const struct nand_controller_ops jz4780_nand_controller_ops = {
> +	.attach_chip = jz4780_nand_attach_chip,
> +};
> +
>  static int jz4780_nand_init_chip(struct platform_device *pdev,
>  				struct jz4780_nand_controller *nfc,
>  				struct device_node *np,
> @@ -280,15 +285,8 @@ static int jz4780_nand_init_chip(struct platform_device *pdev,
>  	chip->controller = &nfc->controller;
>  	nand_set_flash_node(chip, np);
>  
> -	ret = nand_scan_ident(mtd, 1, NULL);
> -	if (ret)
> -		return ret;
> -
> -	ret = jz4780_nand_init_ecc(nand, dev);
> -	if (ret)
> -		return ret;
> -
> -	ret = nand_scan_tail(mtd);
> +	chip->controller->ops = &jz4780_nand_controller_ops;
> +	ret = nand_scan(mtd, 1);
>  	if (ret)
>  		return ret;
>  

