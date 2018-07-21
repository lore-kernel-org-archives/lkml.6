Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F89ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 06:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F7D2084A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 06:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06F7D2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeGUHfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 03:35:50 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42512 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbeGUHfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 03:35:50 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 989BA207AD; Sat, 21 Jul 2018 08:44:12 +0200 (CEST)
Received: from bbrezillon (unknown [37.173.220.171])
        by mail.bootlin.com (Postfix) with ESMTPSA id B48022072F;
        Sat, 21 Jul 2018 08:44:09 +0200 (CEST)
Date:   Sat, 21 Jul 2018 08:44:08 +0200
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
Subject: Re: [PATCH v4 03/35] mtd: rawnand: davinci: convert driver to
 nand_scan()
Message-ID: <20180721084408.1d32d5b7@bbrezillon>
In-Reply-To: <20180720151527.16038-4-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
        <20180720151527.16038-4-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 17:14:55 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Two helpers have been added to the core to make ECC-related
> configuration between the detection phase and the final NAND scan. Use
> these hooks and convert the driver to just use nand_scan() instead of
> both nand_scan_ident() and nand_scan_tail().
> 
> Also change the unused "struct device *dev" parameter of the driver
> structure into a platform device to reuse it in the ->attach_chip()
> hook.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/nand/raw/davinci_nand.c | 195 +++++++++++++++++++-----------------
>  1 file changed, 102 insertions(+), 93 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
> index 626c9363e460..40145e206a6b 100644
> --- a/drivers/mtd/nand/raw/davinci_nand.c
> +++ b/drivers/mtd/nand/raw/davinci_nand.c
> @@ -53,7 +53,7 @@
>  struct davinci_nand_info {
>  	struct nand_chip	chip;
>  
> -	struct device		*dev;
> +	struct platform_device	*pdev;

For the record, there's a to_platform_device() macro you can use to get
a platform_device object from a device one, so this change was not
really needed. Actually, you should not even need a ->dev field here
because it can be retrieved from mtd->dev.parent. Anyway, if you
patched all places using davinci->dev to now use &davinci->pdev->dev
we should be good.

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

>  
>  	bool			is_readmode;
>  
> @@ -605,6 +605,104 @@ static struct davinci_nand_pdata
>  }
>  #endif
>  
> +static int davinci_nand_attach_chip(struct nand_chip *chip)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct davinci_nand_info *info = to_davinci_nand(mtd);
> +	struct davinci_nand_pdata *pdata = nand_davinci_get_pdata(info->pdev);
> +	int ret = 0;
> +
> +	if (IS_ERR(pdata))
> +		return PTR_ERR(pdata);
> +
> +	switch (info->chip.ecc.mode) {
> +	case NAND_ECC_NONE:
> +		pdata->ecc_bits = 0;
> +		break;
> +	case NAND_ECC_SOFT:
> +		pdata->ecc_bits = 0;
> +		/*
> +		 * This driver expects Hamming based ECC when ecc_mode is set
> +		 * to NAND_ECC_SOFT. Force ecc.algo to NAND_ECC_HAMMING to
> +		 * avoid adding an extra ->ecc_algo field to
> +		 * davinci_nand_pdata.
> +		 */
> +		info->chip.ecc.algo = NAND_ECC_HAMMING;
> +		break;
> +	case NAND_ECC_HW:
> +		if (pdata->ecc_bits == 4) {
> +			/*
> +			 * No sanity checks:  CPUs must support this,
> +			 * and the chips may not use NAND_BUSWIDTH_16.
> +			 */
> +
> +			/* No sharing 4-bit hardware between chipselects yet */
> +			spin_lock_irq(&davinci_nand_lock);
> +			if (ecc4_busy)
> +				ret = -EBUSY;
> +			else
> +				ecc4_busy = true;
> +			spin_unlock_irq(&davinci_nand_lock);
> +
> +			if (ret == -EBUSY)
> +				return ret;
> +
> +			info->chip.ecc.calculate = nand_davinci_calculate_4bit;
> +			info->chip.ecc.correct = nand_davinci_correct_4bit;
> +			info->chip.ecc.hwctl = nand_davinci_hwctl_4bit;
> +			info->chip.ecc.bytes = 10;
> +			info->chip.ecc.options = NAND_ECC_GENERIC_ERASED_CHECK;
> +			info->chip.ecc.algo = NAND_ECC_BCH;
> +		} else {
> +			/* 1bit ecc hamming */
> +			info->chip.ecc.calculate = nand_davinci_calculate_1bit;
> +			info->chip.ecc.correct = nand_davinci_correct_1bit;
> +			info->chip.ecc.hwctl = nand_davinci_hwctl_1bit;
> +			info->chip.ecc.bytes = 3;
> +			info->chip.ecc.algo = NAND_ECC_HAMMING;
> +		}
> +		info->chip.ecc.size = 512;
> +		info->chip.ecc.strength = pdata->ecc_bits;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Update ECC layout if needed ... for 1-bit HW ECC, the default
> +	 * is OK, but it allocates 6 bytes when only 3 are needed (for
> +	 * each 512 bytes).  For the 4-bit HW ECC, that default is not
> +	 * usable:  10 bytes are needed, not 6.
> +	 */
> +	if (pdata->ecc_bits == 4) {
> +		int chunks = mtd->writesize / 512;
> +
> +		if (!chunks || mtd->oobsize < 16) {
> +			dev_dbg(&info->pdev->dev, "too small\n");
> +			return -EINVAL;
> +		}
> +
> +		/* For small page chips, preserve the manufacturer's
> +		 * badblock marking data ... and make sure a flash BBT
> +		 * table marker fits in the free bytes.
> +		 */
> +		if (chunks == 1) {
> +			mtd_set_ooblayout(mtd, &hwecc4_small_ooblayout_ops);
> +		} else if (chunks == 4 || chunks == 8) {
> +			mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
> +			info->chip.ecc.mode = NAND_ECC_HW_OOB_FIRST;
> +		} else {
> +			return -EIO;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct nand_controller_ops davinci_nand_controller_ops = {
> +	.attach_chip = davinci_nand_attach_chip,
> +};
> +
>  static int nand_davinci_probe(struct platform_device *pdev)
>  {
>  	struct davinci_nand_pdata	*pdata;
> @@ -658,7 +756,7 @@ static int nand_davinci_probe(struct platform_device *pdev)
>  		return -EADDRNOTAVAIL;
>  	}
>  
> -	info->dev		= &pdev->dev;
> +	info->pdev		= pdev;
>  	info->base		= base;
>  	info->vaddr		= vaddr;
>  
> @@ -708,97 +806,13 @@ static int nand_davinci_probe(struct platform_device *pdev)
>  	spin_unlock_irq(&davinci_nand_lock);
>  
>  	/* Scan to find existence of the device(s) */
> -	ret = nand_scan_ident(mtd, pdata->mask_chipsel ? 2 : 1, NULL);
> +	info->chip.dummy_controller.ops = &davinci_nand_controller_ops;
> +	ret = nand_scan(mtd, pdata->mask_chipsel ? 2 : 1);
>  	if (ret < 0) {
>  		dev_dbg(&pdev->dev, "no NAND chip(s) found\n");
>  		return ret;
>  	}
>  
> -	switch (info->chip.ecc.mode) {
> -	case NAND_ECC_NONE:
> -		pdata->ecc_bits = 0;
> -		break;
> -	case NAND_ECC_SOFT:
> -		pdata->ecc_bits = 0;
> -		/*
> -		 * This driver expects Hamming based ECC when ecc_mode is set
> -		 * to NAND_ECC_SOFT. Force ecc.algo to NAND_ECC_HAMMING to
> -		 * avoid adding an extra ->ecc_algo field to
> -		 * davinci_nand_pdata.
> -		 */
> -		info->chip.ecc.algo = NAND_ECC_HAMMING;
> -		break;
> -	case NAND_ECC_HW:
> -		if (pdata->ecc_bits == 4) {
> -			/* No sanity checks:  CPUs must support this,
> -			 * and the chips may not use NAND_BUSWIDTH_16.
> -			 */
> -
> -			/* No sharing 4-bit hardware between chipselects yet */
> -			spin_lock_irq(&davinci_nand_lock);
> -			if (ecc4_busy)
> -				ret = -EBUSY;
> -			else
> -				ecc4_busy = true;
> -			spin_unlock_irq(&davinci_nand_lock);
> -
> -			if (ret == -EBUSY)
> -				return ret;
> -
> -			info->chip.ecc.calculate = nand_davinci_calculate_4bit;
> -			info->chip.ecc.correct = nand_davinci_correct_4bit;
> -			info->chip.ecc.hwctl = nand_davinci_hwctl_4bit;
> -			info->chip.ecc.bytes = 10;
> -			info->chip.ecc.options = NAND_ECC_GENERIC_ERASED_CHECK;
> -			info->chip.ecc.algo = NAND_ECC_BCH;
> -		} else {
> -			/* 1bit ecc hamming */
> -			info->chip.ecc.calculate = nand_davinci_calculate_1bit;
> -			info->chip.ecc.correct = nand_davinci_correct_1bit;
> -			info->chip.ecc.hwctl = nand_davinci_hwctl_1bit;
> -			info->chip.ecc.bytes = 3;
> -			info->chip.ecc.algo = NAND_ECC_HAMMING;
> -		}
> -		info->chip.ecc.size = 512;
> -		info->chip.ecc.strength = pdata->ecc_bits;
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	/* Update ECC layout if needed ... for 1-bit HW ECC, the default
> -	 * is OK, but it allocates 6 bytes when only 3 are needed (for
> -	 * each 512 bytes).  For the 4-bit HW ECC, that default is not
> -	 * usable:  10 bytes are needed, not 6.
> -	 */
> -	if (pdata->ecc_bits == 4) {
> -		int	chunks = mtd->writesize / 512;
> -
> -		if (!chunks || mtd->oobsize < 16) {
> -			dev_dbg(&pdev->dev, "too small\n");
> -			ret = -EINVAL;
> -			goto err;
> -		}
> -
> -		/* For small page chips, preserve the manufacturer's
> -		 * badblock marking data ... and make sure a flash BBT
> -		 * table marker fits in the free bytes.
> -		 */
> -		if (chunks == 1) {
> -			mtd_set_ooblayout(mtd, &hwecc4_small_ooblayout_ops);
> -		} else if (chunks == 4 || chunks == 8) {
> -			mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
> -			info->chip.ecc.mode = NAND_ECC_HW_OOB_FIRST;
> -		} else {
> -			ret = -EIO;
> -			goto err;
> -		}
> -	}
> -
> -	ret = nand_scan_tail(mtd);
> -	if (ret < 0)
> -		goto err;
> -
>  	if (pdata->parts)
>  		ret = mtd_device_register(mtd, pdata->parts, pdata->nr_parts);
>  	else
> @@ -815,11 +829,6 @@ static int nand_davinci_probe(struct platform_device *pdev)
>  err_cleanup_nand:
>  	nand_cleanup(&info->chip);
>  
> -err:
> -	spin_lock_irq(&davinci_nand_lock);
> -	if (info->chip.ecc.mode == NAND_ECC_HW_SYNDROME)
> -		ecc4_busy = false;
> -	spin_unlock_irq(&davinci_nand_lock);
>  	return ret;
>  }
>  

