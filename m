Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C21ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 15:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38E020854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 15:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B38E020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbeGUQVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 12:21:03 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47983 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727737AbeGUQVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 12:21:03 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2A69020717; Sat, 21 Jul 2018 17:27:55 +0200 (CEST)
Received: from bbrezillon (unknown [37.173.79.60])
        by mail.bootlin.com (Postfix) with ESMTPSA id BFD5C206A6;
        Sat, 21 Jul 2018 17:27:52 +0200 (CEST)
Date:   Sat, 21 Jul 2018 17:27:49 +0200
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
Subject: Re: [PATCH v4 12/35] mtd: rawnand: lpc32xx_slc: convert driver to
 nand_scan()
Message-ID: <20180721172749.05529c8f@bbrezillon>
In-Reply-To: <20180720151527.16038-13-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
        <20180720151527.16038-13-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 17:15:04 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Two helpers have been added to the core to make ECC-related
> configuration between the detection phase and the final NAND scan. Use
> these hooks and convert the driver to just use nand_scan() instead of
> both nand_scan_ident() and nand_scan_tail().
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/mtd/nand/raw/lpc32xx_slc.c | 77 +++++++++++++++++++++-----------------
>  1 file changed, 42 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
> index 42820aa1abab..a4e8b7e75135 100644
> --- a/drivers/mtd/nand/raw/lpc32xx_slc.c
> +++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
> @@ -779,6 +779,46 @@ static struct lpc32xx_nand_cfg_slc *lpc32xx_parse_dt(struct device *dev)
>  	return ncfg;
>  }
>  
> +static int lpc32xx_nand_attach_chip(struct nand_chip *chip)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
> +
> +	/* OOB and ECC CPU and DMA work areas */
> +	host->ecc_buf = (uint32_t *)(host->data_buf + LPC32XX_DMA_DATA_SIZE);
> +
> +	/*
> +	 * Small page FLASH has a unique OOB layout, but large and huge
> +	 * page FLASH use the standard layout. Small page FLASH uses a
> +	 * custom BBT marker layout.
> +	 */
> +	if (mtd->writesize <= 512)
> +		mtd_set_ooblayout(mtd, &lpc32xx_ooblayout_ops);
> +
> +	/* These sizes remain the same regardless of page size */
> +	chip->ecc.size = 256;
> +	chip->ecc.bytes = LPC32XX_SLC_DEV_ECC_BYTES;
> +	chip->ecc.prepad = 0;
> +	chip->ecc.postpad = 0;
> +
> +	/*
> +	 * Use a custom BBT marker setup for small page FLASH that
> +	 * won't interfere with the ECC layout. Large and huge page
> +	 * FLASH use the standard layout.
> +	 */
> +	if ((chip->bbt_options & NAND_BBT_USE_FLASH) &&
> +	    mtd->writesize <= 512) {
> +		chip->bbt_td = &bbt_smallpage_main_descr;
> +		chip->bbt_md = &bbt_smallpage_mirror_descr;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct nand_controller_ops lpc32xx_nand_controller_ops = {
> +	.attach_chip = lpc32xx_nand_attach_chip,
> +};
> +
>  /*
>   * Probe for NAND controller
>   */
> @@ -884,41 +924,8 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Find NAND device */
> -	res = nand_scan_ident(mtd, 1, NULL);
> -	if (res)
> -		goto release_dma;
> -
> -	/* OOB and ECC CPU and DMA work areas */
> -	host->ecc_buf = (uint32_t *)(host->data_buf + LPC32XX_DMA_DATA_SIZE);
> -
> -	/*
> -	 * Small page FLASH has a unique OOB layout, but large and huge
> -	 * page FLASH use the standard layout. Small page FLASH uses a
> -	 * custom BBT marker layout.
> -	 */
> -	if (mtd->writesize <= 512)
> -		mtd_set_ooblayout(mtd, &lpc32xx_ooblayout_ops);
> -
> -	/* These sizes remain the same regardless of page size */
> -	chip->ecc.size = 256;
> -	chip->ecc.bytes = LPC32XX_SLC_DEV_ECC_BYTES;
> -	chip->ecc.prepad = chip->ecc.postpad = 0;
> -
> -	/*
> -	 * Use a custom BBT marker setup for small page FLASH that
> -	 * won't interfere with the ECC layout. Large and huge page
> -	 * FLASH use the standard layout.
> -	 */
> -	if ((chip->bbt_options & NAND_BBT_USE_FLASH) &&
> -	    mtd->writesize <= 512) {
> -		chip->bbt_td = &bbt_smallpage_main_descr;
> -		chip->bbt_md = &bbt_smallpage_mirror_descr;
> -	}
> -
> -	/*
> -	 * Fills out all the uninitialized function pointers with the defaults
> -	 */
> -	res = nand_scan_tail(mtd);
> +	chip->dummy_controller.ops = &lpc32xx_nand_controller_ops;
> +	res = nand_scan(mtd, 1);
>  	if (res)
>  		goto release_dma;
>  

