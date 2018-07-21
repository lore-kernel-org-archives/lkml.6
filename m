Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAA4ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 07:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F9420849
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 07:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F9420849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbeGUHvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 03:51:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43155 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbeGUHvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 03:51:40 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6B38620731; Sat, 21 Jul 2018 08:59:59 +0200 (CEST)
Received: from bbrezillon (unknown [37.170.141.1])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0415D2069C;
        Sat, 21 Jul 2018 08:59:56 +0200 (CEST)
Date:   Sat, 21 Jul 2018 08:59:56 +0200
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
Subject: Re: [PATCH v4 09/35] mtd: rawnand: hisi504: convert driver to
 nand_scan()
Message-ID: <20180721085956.743ca05d@bbrezillon>
In-Reply-To: <20180720151527.16038-10-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
        <20180720151527.16038-10-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 17:15:01 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Two helpers have been added to the core to make ECC-related
> configuration between the detection phase and the final NAND scan. Use
> these hooks and convert the driver to just use nand_scan() instead of
> both nand_scan_ident() and nand_scan_tail().
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/mtd/nand/raw/hisi504_nand.c | 78 +++++++++++++++++++++----------------
>  1 file changed, 44 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/hisi504_nand.c b/drivers/mtd/nand/raw/hisi504_nand.c
> index a1e009c8e556..950dc7789296 100644
> --- a/drivers/mtd/nand/raw/hisi504_nand.c
> +++ b/drivers/mtd/nand/raw/hisi504_nand.c
> @@ -709,9 +709,50 @@ static int hisi_nfc_ecc_probe(struct hinfc_host *host)
>  	return 0;
>  }
>  
> +static int hisi_nfc_attach_chip(struct nand_chip *chip)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct hinfc_host *host = nand_get_controller_data(chip);
> +	int flag;
> +
> +	host->buffer = dmam_alloc_coherent(host->dev,
> +					   mtd->writesize + mtd->oobsize,
> +					   &host->dma_buffer, GFP_KERNEL);
> +	if (!host->buffer)
> +		return -ENOMEM;
> +
> +	host->dma_oob = host->dma_buffer + mtd->writesize;
> +	memset(host->buffer, 0xff, mtd->writesize + mtd->oobsize);
> +
> +	flag = hinfc_read(host, HINFC504_CON);
> +	flag &= ~(HINFC504_CON_PAGESIZE_MASK << HINFC504_CON_PAGEISZE_SHIFT);
> +	switch (mtd->writesize) {
> +	case 2048:
> +		flag |= (0x001 << HINFC504_CON_PAGEISZE_SHIFT);
> +		break;
> +	/*
> +	 * TODO: add more pagesize support,
> +	 * default pagesize has been set in hisi_nfc_host_init
> +	 */
> +	default:
> +		dev_err(host->dev, "NON-2KB page size nand flash\n");
> +		return -EINVAL;

We should probably return ENOTSUPP, but that's not related to the
change you do, so let's keep that for later.

> +	}
> +	hinfc_write(host, flag, HINFC504_CON);
> +
> +	if (chip->ecc.mode == NAND_ECC_HW)
> +		hisi_nfc_ecc_probe(host);
> +
> +	return 0;
> +}
> +
> +static const struct nand_controller_ops hisi_nfc_controller_ops = {
> +	.attach_chip = hisi_nfc_attach_chip,
> +};
> +
>  static int hisi_nfc_probe(struct platform_device *pdev)
>  {
> -	int ret = 0, irq, flag, max_chips = HINFC504_MAX_CHIP;
> +	int ret = 0, irq, max_chips = HINFC504_MAX_CHIP;
>  	struct device *dev = &pdev->dev;
>  	struct hinfc_host *host;
>  	struct nand_chip  *chip;
> @@ -769,42 +810,11 @@ static int hisi_nfc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	ret = nand_scan_ident(mtd, max_chips, NULL);
> +	chip->dummy_controller.ops = &hisi_nfc_controller_ops;
> +	ret = nand_scan(mtd, max_chips);
>  	if (ret)
>  		return ret;
>  
> -	host->buffer = dmam_alloc_coherent(dev, mtd->writesize + mtd->oobsize,
> -		&host->dma_buffer, GFP_KERNEL);
> -	if (!host->buffer)
> -		return -ENOMEM;
> -
> -	host->dma_oob = host->dma_buffer + mtd->writesize;
> -	memset(host->buffer, 0xff, mtd->writesize + mtd->oobsize);
> -
> -	flag = hinfc_read(host, HINFC504_CON);
> -	flag &= ~(HINFC504_CON_PAGESIZE_MASK << HINFC504_CON_PAGEISZE_SHIFT);
> -	switch (mtd->writesize) {
> -	case 2048:
> -		flag |= (0x001 << HINFC504_CON_PAGEISZE_SHIFT); break;
> -	/*
> -	 * TODO: add more pagesize support,
> -	 * default pagesize has been set in hisi_nfc_host_init
> -	 */
> -	default:
> -		dev_err(dev, "NON-2KB page size nand flash\n");
> -		return -EINVAL;
> -	}
> -	hinfc_write(host, flag, HINFC504_CON);
> -
> -	if (chip->ecc.mode == NAND_ECC_HW)
> -		hisi_nfc_ecc_probe(host);
> -
> -	ret = nand_scan_tail(mtd);
> -	if (ret) {
> -		dev_err(dev, "nand_scan_tail failed: %d\n", ret);
> -		return ret;
> -	}
> -
>  	ret = mtd_device_register(mtd, NULL, 0);
>  	if (ret) {
>  		dev_err(dev, "Err MTD partition=%d\n", ret);

