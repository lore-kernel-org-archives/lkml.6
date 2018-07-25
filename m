Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2911EC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840C82064D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="Emdfl/Gi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840C82064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbeGYKIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:08:25 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:43446 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728528AbeGYKIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:08:24 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 9B4395C1B32;
        Wed, 25 Jul 2018 10:57:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1532509049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5gKM8Q9du071IikwuiSFsOXSlbMTEp/EDaTJjXsfvWE=;
        b=Emdfl/GiVWDnnYcug1g+6qzHC20i/v1+TcVwXTdyNqIemIhlI7/BKx1fW3G/zrsi0KWbv2
        Y38pC+PdmL9PT3YSHxRyvVRiDBcC6jjNutdIGEUiDZiSgnrannNqHmwne/DDn5R2tBwDRG
        m+oTFQUNnMGfjUq2W5n46DbeFbTTRSk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Wed, 25 Jul 2018 10:57:29 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Wenyou Yang <wenyou.yang@microchip.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
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
        Mans Rullgard <mans@mansr.com>, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4 25/35] mtd: rawnand: vf610: convert driver to
 nand_scan()
In-Reply-To: <20180720151527.16038-26-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
 <20180720151527.16038-26-miquel.raynal@bootlin.com>
Message-ID: <5a2276ee7a79e7258234f553167bf469@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-3.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[28];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.07.2018 17:15, Miquel Raynal wrote:
> Two helpers have been added to the core to make ECC-related
> configuration between the detection phase and the final NAND scan. Use
> these hooks and convert the driver to just use nand_scan() instead of
> both nand_scan_ident() and nand_scan_tail().

Reviewed-by: Stefan Agner <stefan@agner.ch>

> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/nand/raw/vf610_nfc.c | 127 ++++++++++++++++++++-------------------
>  1 file changed, 66 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
> index d5a22fc96878..6f6dcbf9095b 100644
> --- a/drivers/mtd/nand/raw/vf610_nfc.c
> +++ b/drivers/mtd/nand/raw/vf610_nfc.c
> @@ -747,6 +747,69 @@ static void vf610_nfc_init_controller(struct
> vf610_nfc *nfc)
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
