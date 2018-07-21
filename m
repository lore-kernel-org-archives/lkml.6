Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656F6ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F5920849
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F5920849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbeGUS5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 14:57:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50656 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727458AbeGUS5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 14:57:53 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 52E2420717; Sat, 21 Jul 2018 20:04:17 +0200 (CEST)
Received: from bbrezillon (unknown [37.173.79.60])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8F366203D9;
        Sat, 21 Jul 2018 20:04:05 +0200 (CEST)
Date:   Sat, 21 Jul 2018 20:04:04 +0200
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
Subject: Re: [PATCH v4 24/35] mtd: rawnand: txx9ndfmc: convert driver to
 nand_scan()
Message-ID: <20180721200404.419fad90@bbrezillon>
In-Reply-To: <20180720151527.16038-25-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
        <20180720151527.16038-25-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 17:15:16 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Two helpers have been added to the core to make ECC-related
> configuration between the detection phase and the final NAND scan. Use
> these hooks and convert the driver to just use nand_scan() instead of
> both nand_scan_ident() and nand_scan_tail().
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/nand/raw/txx9ndfmc.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/txx9ndfmc.c b/drivers/mtd/nand/raw/txx9ndfmc.c
> index 9019022774f7..0134beb1136d 100644
> --- a/drivers/mtd/nand/raw/txx9ndfmc.c
> +++ b/drivers/mtd/nand/raw/txx9ndfmc.c
> @@ -254,23 +254,23 @@ static void txx9ndfmc_initialize(struct platform_device *dev)
>  #define TXX9NDFMC_NS_TO_CYC(gbusclk, ns) \
>  	DIV_ROUND_UP((ns) * DIV_ROUND_UP(gbusclk, 1000), 1000000)
>  
> -static int txx9ndfmc_nand_scan(struct mtd_info *mtd)
> +static int txx9ndfmc_attach_chip(struct nand_chip *chip)
>  {
> -	struct nand_chip *chip = mtd_to_nand(mtd);
> -	int ret;
> +	struct mtd_info *mtd = nand_to_mtd(chip);
>  
> -	ret = nand_scan_ident(mtd, 1, NULL);
> -	if (!ret) {
> -		if (mtd->writesize >= 512) {
> -			/* Hardware ECC 6 byte ECC per 512 Byte data */
> -			chip->ecc.size = 512;
> -			chip->ecc.bytes = 6;
> -		}
> -		ret = nand_scan_tail(mtd);
> +	if (mtd->writesize >= 512) {
> +		/* Hardware ECC 6 byte ECC per 512 Byte data */
> +		chip->ecc.size = 512;
> +		chip->ecc.bytes = 6;
>  	}
> -	return ret;
> +
> +	return 0;
>  }
>  
> +static const struct nand_controller_ops txx9ndfmc_controller_ops = {
> +	.attach_chip = txx9ndfmc_attach_chip,
> +};
> +
>  static int __init txx9ndfmc_probe(struct platform_device *dev)
>  {
>  	struct txx9ndfmc_platform_data *plat = dev_get_platdata(&dev->dev);
> @@ -304,6 +304,7 @@ static int __init txx9ndfmc_probe(struct platform_device *dev)
>  		 (gbusclk + 500000) / 1000000, hold, spw);
>  
>  	nand_controller_init(&drvdata->controller);
> +	drvdata->controller.ops = &txx9ndfmc_controller_ops;
>  
>  	platform_set_drvdata(dev, drvdata);
>  	txx9ndfmc_initialize(dev);
> @@ -332,7 +333,7 @@ static int __init txx9ndfmc_probe(struct platform_device *dev)
>  		chip->ecc.correct = txx9ndfmc_correct_data;
>  		chip->ecc.hwctl = txx9ndfmc_enable_hwecc;
>  		chip->ecc.mode = NAND_ECC_HW;
> -		/* txx9ndfmc_nand_scan will overwrite ecc.size and ecc.bytes */
> +		/* nand_scan() will overwrite ecc.size and ecc.bytes */
>  		chip->ecc.size = 256;
>  		chip->ecc.bytes = 3;

I had a hard time understanding what was the point of assigning
values that would later be overwritten. Actually the comment is
inaccurate, it's only overwritten if mtd->writesize >= 512. Can you had
a patch that moves this block in txx9ndfmc_nand_scan() before doing the
->attach_chip() conversion?

>  		chip->ecc.strength = 1;
> @@ -359,7 +360,7 @@ static int __init txx9ndfmc_probe(struct platform_device *dev)
>  		if (plat->wide_mask & (1 << i))
>  			chip->options |= NAND_BUSWIDTH_16;
>  
> -		if (txx9ndfmc_nand_scan(mtd)) {
> +		if (nand_scan(mtd, 1)) {
>  			kfree(txx9_priv->mtdname);
>  			kfree(txx9_priv);
>  			continue;

