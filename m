Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1900ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851EA20849
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 851EA20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbeGUTAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 15:00:06 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50765 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727542AbeGUTAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 15:00:06 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1B62B207E8; Sat, 21 Jul 2018 20:06:30 +0200 (CEST)
Received: from bbrezillon (unknown [37.173.79.60])
        by mail.bootlin.com (Postfix) with ESMTPSA id 28BD92093C;
        Sat, 21 Jul 2018 20:05:07 +0200 (CEST)
Date:   Sat, 21 Jul 2018 20:05:06 +0200
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
Subject: Re: [PATCH v4 25/35] mtd: rawnand: vf610: convert driver to
 nand_scan()
Message-ID: <20180721200506.069e948a@bbrezillon>
In-Reply-To: <20180720151527.16038-26-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
        <20180720151527.16038-26-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 17:15:17 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Two helpers have been added to the core to make ECC-related
> configuration between the detection phase and the final NAND scan. Use
> these hooks and convert the driver to just use nand_scan() instead of
> both nand_scan_ident() and nand_scan_tail().
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/mtd/nand/raw/vf610_nfc.c | 127 ++++++++++++++++++++-------------------
>  1 file changed, 66 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
> index d5a22fc96878..6f6dcbf9095b 100644
> --- a/drivers/mtd/nand/raw/vf610_nfc.c
> +++ b/drivers/mtd/nand/raw/vf610_nfc.c
> @@ -747,6 +747,69 @@ static void vf610_nfc_init_controller(struct vf610_nfc *nfc)
>  	}
>  }
>  
> +static int vf610_nfc_attach_chip(struct nand_chip *chip)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
> +
> +	vf610_nfc_init_controller(nfc);
> +
> +	/* Bad block options. */
> +	if (chip->bbt_options & NAND_BBT_USE_FLASH)
> +		chip->bbt_options |= NAND_BBT_NO_OOB;
> +
> +	/* Single buffer only, max 256 OOB minus ECC status */
> +	if (mtd->writesize + mtd->oobsize > PAGE_2K + OOB_MAX - 8) {
> +		dev_err(nfc->dev, "Unsupported flash page size\n");
> +		return -ENXIO;
> +	}
> +
> +	if (chip->ecc.mode != NAND_ECC_HW)
> +		return 0;
> +
> +	if (mtd->writesize != PAGE_2K && mtd->oobsize < 64) {
> +		dev_err(nfc->dev, "Unsupported flash with hwecc\n");
> +		return -ENXIO;
> +	}
> +
> +	if (chip->ecc.size != mtd->writesize) {
> +		dev_err(nfc->dev, "Step size needs to be page size\n");
> +		return -ENXIO;
> +	}
> +
> +	/* Only 64 byte ECC layouts known */
> +	if (mtd->oobsize > 64)
> +		mtd->oobsize = 64;
> +
> +	/* Use default large page ECC layout defined in NAND core */
> +	mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
> +	if (chip->ecc.strength == 32) {
> +		nfc->ecc_mode = ECC_60_BYTE;
> +		chip->ecc.bytes = 60;
> +	} else if (chip->ecc.strength == 24) {
> +		nfc->ecc_mode = ECC_45_BYTE;
> +		chip->ecc.bytes = 45;
> +	} else {
> +		dev_err(nfc->dev, "Unsupported ECC strength\n");
> +		return -ENXIO;
> +	}
> +
> +	chip->ecc.read_page = vf610_nfc_read_page;
> +	chip->ecc.write_page = vf610_nfc_write_page;
> +	chip->ecc.read_page_raw = vf610_nfc_read_page_raw;
> +	chip->ecc.write_page_raw = vf610_nfc_write_page_raw;
> +	chip->ecc.read_oob = vf610_nfc_read_oob;
> +	chip->ecc.write_oob = vf610_nfc_write_oob;
> +
> +	chip->ecc.size = PAGE_2K;
> +
> +	return 0;
> +}
> +
> +static const struct nand_controller_ops vf610_nfc_controller_ops = {
> +	.attach_chip = vf610_nfc_attach_chip,
> +};
> +
>  static int vf610_nfc_probe(struct platform_device *pdev)
>  {
>  	struct vf610_nfc *nfc;
> @@ -827,67 +890,9 @@ static int vf610_nfc_probe(struct platform_device *pdev)
>  
>  	vf610_nfc_preinit_controller(nfc);
>  
> -	/* first scan to find the device and get the page size */
> -	err = nand_scan_ident(mtd, 1, NULL);
> -	if (err)
> -		goto err_disable_clk;
> -
> -	vf610_nfc_init_controller(nfc);
> -
> -	/* Bad block options. */
> -	if (chip->bbt_options & NAND_BBT_USE_FLASH)
> -		chip->bbt_options |= NAND_BBT_NO_OOB;
> -
> -	/* Single buffer only, max 256 OOB minus ECC status */
> -	if (mtd->writesize + mtd->oobsize > PAGE_2K + OOB_MAX - 8) {
> -		dev_err(nfc->dev, "Unsupported flash page size\n");
> -		err = -ENXIO;
> -		goto err_disable_clk;
> -	}
> -
> -	if (chip->ecc.mode == NAND_ECC_HW) {
> -		if (mtd->writesize != PAGE_2K && mtd->oobsize < 64) {
> -			dev_err(nfc->dev, "Unsupported flash with hwecc\n");
> -			err = -ENXIO;
> -			goto err_disable_clk;
> -		}
> -
> -		if (chip->ecc.size != mtd->writesize) {
> -			dev_err(nfc->dev, "Step size needs to be page size\n");
> -			err = -ENXIO;
> -			goto err_disable_clk;
> -		}
> -
> -		/* Only 64 byte ECC layouts known */
> -		if (mtd->oobsize > 64)
> -			mtd->oobsize = 64;
> -
> -		/* Use default large page ECC layout defined in NAND core */
> -		mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
> -		if (chip->ecc.strength == 32) {
> -			nfc->ecc_mode = ECC_60_BYTE;
> -			chip->ecc.bytes = 60;
> -		} else if (chip->ecc.strength == 24) {
> -			nfc->ecc_mode = ECC_45_BYTE;
> -			chip->ecc.bytes = 45;
> -		} else {
> -			dev_err(nfc->dev, "Unsupported ECC strength\n");
> -			err = -ENXIO;
> -			goto err_disable_clk;
> -		}
> -
> -		chip->ecc.read_page = vf610_nfc_read_page;
> -		chip->ecc.write_page = vf610_nfc_write_page;
> -		chip->ecc.read_page_raw = vf610_nfc_read_page_raw;
> -		chip->ecc.write_page_raw = vf610_nfc_write_page_raw;
> -		chip->ecc.read_oob = vf610_nfc_read_oob;
> -		chip->ecc.write_oob = vf610_nfc_write_oob;
> -
> -		chip->ecc.size = PAGE_2K;
> -	}
> -
> -	/* second phase scan */
> -	err = nand_scan_tail(mtd);
> +	/* Scan the NAND chip */
> +	chip->dummy_controller.ops = &vf610_nfc_controller_ops;
> +	err = nand_scan(mtd, 1);
>  	if (err)
>  		goto err_disable_clk;
>  

