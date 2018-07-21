Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FA6ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 17:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B47020854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 17:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B47020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbeGUSMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 14:12:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49247 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728021AbeGUSMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 14:12:45 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CF7A0207B4; Sat, 21 Jul 2018 19:19:16 +0200 (CEST)
Received: from bbrezillon (unknown [37.173.79.60])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7B93120717;
        Sat, 21 Jul 2018 19:19:14 +0200 (CEST)
Date:   Sat, 21 Jul 2018 19:19:04 +0200
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
Subject: Re: [PATCH v4 15/35] mtd: rawnand: mxc: convert driver to
 nand_scan()
Message-ID: <20180721191904.541faf4d@bbrezillon>
In-Reply-To: <20180720151527.16038-16-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
        <20180720151527.16038-16-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 17:15:07 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Two helpers have been added to the core to make ECC-related
> configuration between the detection phase and the final NAND scan. Use
> these hooks and convert the driver to just use nand_scan() instead of
> both nand_scan_ident() and nand_scan_tail().
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/mtd/nand/raw/mxc_nand.c | 136 +++++++++++++++++++++-------------------
>  1 file changed, 71 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
> index c6eff61e909d..4c9214dea424 100644
> --- a/drivers/mtd/nand/raw/mxc_nand.c
> +++ b/drivers/mtd/nand/raw/mxc_nand.c
> @@ -1691,6 +1691,74 @@ static int mxcnd_probe_dt(struct mxc_nand_host *host)
>  }
>  #endif
>  
> +static int mxcnd_attach_chip(struct nand_chip *chip)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct mxc_nand_host *host = nand_get_controller_data(chip);
> +	struct device *dev = mtd->dev.parent;
> +
> +	switch (chip->ecc.mode) {
> +	case NAND_ECC_HW:
> +		chip->ecc.read_page = mxc_nand_read_page;
> +		chip->ecc.read_page_raw = mxc_nand_read_page_raw;
> +		chip->ecc.read_oob = mxc_nand_read_oob;
> +		chip->ecc.write_page = mxc_nand_write_page_ecc;
> +		chip->ecc.write_page_raw = mxc_nand_write_page_raw;
> +		chip->ecc.write_oob = mxc_nand_write_oob;
> +		break;
> +
> +	case NAND_ECC_SOFT:
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (chip->bbt_options & NAND_BBT_USE_FLASH) {
> +		chip->bbt_td = &bbt_main_descr;
> +		chip->bbt_md = &bbt_mirror_descr;
> +	}
> +
> +	/* Allocate the right size buffer now */
> +	devm_kfree(dev, (void *)host->data_buf);
> +	host->data_buf = devm_kzalloc(dev, mtd->writesize + mtd->oobsize,
> +				      GFP_KERNEL);
> +	if (!host->data_buf)
> +		return -ENOMEM;
> +
> +	/* Call preset again, with correct writesize chip time */
> +	host->devtype_data->preset(mtd);
> +
> +	if (!chip->ecc.bytes) {
> +		if (host->eccsize == 8)
> +			chip->ecc.bytes = 18;
> +		else if (host->eccsize == 4)
> +			chip->ecc.bytes = 9;
> +	}
> +
> +	/*
> +	 * Experimentation shows that i.MX NFC can only handle up to 218 oob
> +	 * bytes. Limit used_oobsize to 218 so as to not confuse copy_spare()
> +	 * into copying invalid data to/from the spare IO buffer, as this
> +	 * might cause ECC data corruption when doing sub-page write to a
> +	 * partially written page.
> +	 */
> +	host->used_oobsize = min(mtd->oobsize, 218U);
> +
> +	if (chip->ecc.mode == NAND_ECC_HW) {
> +		if (is_imx21_nfc(host) || is_imx27_nfc(host))
> +			chip->ecc.strength = 1;
> +		else
> +			chip->ecc.strength = (host->eccsize == 4) ? 4 : 8;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct nand_controller_ops mxcnd_controller_ops = {
> +	.attach_chip = mxcnd_attach_chip,
> +};
> +
>  static int mxcnd_probe(struct platform_device *pdev)
>  {
>  	struct nand_chip *this;
> @@ -1830,71 +1898,9 @@ static int mxcnd_probe(struct platform_device *pdev)
>  		host->devtype_data->irq_control(host, 1);
>  	}
>  
> -	/* first scan to find the device and get the page size */
> -	err = nand_scan_ident(mtd, is_imx25_nfc(host) ? 4 : 1, NULL);
> -	if (err)
> -		goto escan;
> -
> -	switch (this->ecc.mode) {
> -	case NAND_ECC_HW:
> -		this->ecc.read_page = mxc_nand_read_page;
> -		this->ecc.read_page_raw = mxc_nand_read_page_raw;
> -		this->ecc.read_oob = mxc_nand_read_oob;
> -		this->ecc.write_page = mxc_nand_write_page_ecc;
> -		this->ecc.write_page_raw = mxc_nand_write_page_raw;
> -		this->ecc.write_oob = mxc_nand_write_oob;
> -		break;
> -
> -	case NAND_ECC_SOFT:
> -		break;
> -
> -	default:
> -		err = -EINVAL;
> -		goto escan;
> -	}
> -
> -	if (this->bbt_options & NAND_BBT_USE_FLASH) {
> -		this->bbt_td = &bbt_main_descr;
> -		this->bbt_md = &bbt_mirror_descr;
> -	}
> -
> -	/* allocate the right size buffer now */
> -	devm_kfree(&pdev->dev, (void *)host->data_buf);
> -	host->data_buf = devm_kzalloc(&pdev->dev, mtd->writesize + mtd->oobsize,
> -					GFP_KERNEL);
> -	if (!host->data_buf) {
> -		err = -ENOMEM;
> -		goto escan;
> -	}
> -
> -	/* Call preset again, with correct writesize this time */
> -	host->devtype_data->preset(mtd);
> -
> -	if (!this->ecc.bytes) {
> -		if (host->eccsize == 8)
> -			this->ecc.bytes = 18;
> -		else if (host->eccsize == 4)
> -			this->ecc.bytes = 9;
> -	}
> -
> -	/*
> -	 * Experimentation shows that i.MX NFC can only handle up to 218 oob
> -	 * bytes. Limit used_oobsize to 218 so as to not confuse copy_spare()
> -	 * into copying invalid data to/from the spare IO buffer, as this
> -	 * might cause ECC data corruption when doing sub-page write to a
> -	 * partially written page.
> -	 */
> -	host->used_oobsize = min(mtd->oobsize, 218U);
> -
> -	if (this->ecc.mode == NAND_ECC_HW) {
> -		if (is_imx21_nfc(host) || is_imx27_nfc(host))
> -			this->ecc.strength = 1;
> -		else
> -			this->ecc.strength = (host->eccsize == 4) ? 4 : 8;
> -	}
> -
> -	/* second phase scan */
> -	err = nand_scan_tail(mtd);
> +	/* Scan the NAND device */
> +	this->dummy_controller.ops = &mxcnd_controller_ops;
> +	err = nand_scan(mtd, is_imx25_nfc(host) ? 4 : 1);
>  	if (err)
>  		goto escan;
>  

