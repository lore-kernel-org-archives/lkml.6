Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1534ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 17:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD9F20854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 17:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD9F20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbeGUScs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 14:32:48 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49717 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbeGUScs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 14:32:48 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6A22C2091A; Sat, 21 Jul 2018 19:39:11 +0200 (CEST)
Received: from bbrezillon (unknown [37.173.79.60])
        by mail.bootlin.com (Postfix) with ESMTPSA id DB3532099F;
        Sat, 21 Jul 2018 19:38:43 +0200 (CEST)
Date:   Sat, 21 Jul 2018 19:38:40 +0200
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
Subject: Re: [PATCH v4 18/35] mtd: rawnand: s3c2410: convert driver to
 nand_scan()
Message-ID: <20180721193840.05fa4e4f@bbrezillon>
In-Reply-To: <20180720151527.16038-19-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
        <20180720151527.16038-19-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 17:15:10 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Two helpers have been added to the core to make ECC-related
> configuration between the detection phase and the final NAND scan. Use
> these hooks and convert the driver to just use nand_scan() instead of
> both nand_scan_ident() and nand_scan_tail().
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/mtd/nand/raw/s3c2410.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/s3c2410.c b/drivers/mtd/nand/raw/s3c2410.c
> index e8bf64832213..c21e8892394a 100644
> --- a/drivers/mtd/nand/raw/s3c2410.c
> +++ b/drivers/mtd/nand/raw/s3c2410.c
> @@ -915,20 +915,19 @@ static void s3c2410_nand_init_chip(struct s3c2410_nand_info *info,
>  }
>  
>  /**
> - * s3c2410_nand_update_chip - post probe update
> - * @info: The controller instance.
> - * @nmtd: The driver version of the MTD instance.
> + * s3c2410_nand_attach_chip - Init the ECC engine after NAND scan
> + * @chip: The NAND chip
>   *
> - * This routine is called after the chip probe has successfully completed
> - * and the relevant per-chip information updated. This call ensure that
> + * This hook is called by the core after the identification of the NAND chip,
> + * once the relevant per-chip information is up to date.. This call ensure that
>   * we update the internal state accordingly.
>   *
>   * The internal state is currently limited to the ECC state information.
>  */
> -static int s3c2410_nand_update_chip(struct s3c2410_nand_info *info,
> -				    struct s3c2410_nand_mtd *nmtd)
> +static int s3c2410_nand_attach_chip(struct nand_chip *chip)
>  {
> -	struct nand_chip *chip = &nmtd->chip;
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct s3c2410_nand_info *info = s3c2410_nand_mtd_toinfo(mtd);
>  
>  	switch (chip->ecc.mode) {
>  
> @@ -998,6 +997,10 @@ static int s3c2410_nand_update_chip(struct s3c2410_nand_info *info,
>  	return 0;
>  }
>  
> +static const struct nand_controller_ops s3c24xx_nand_controller_ops = {
> +	.attach_chip = s3c2410_nand_attach_chip,
> +};
> +
>  static const struct of_device_id s3c24xx_nand_dt_ids[] = {
>  	{
>  		.compatible = "samsung,s3c2410-nand",
> @@ -1095,6 +1098,7 @@ static int s3c24xx_nand_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, info);
>  
>  	nand_controller_init(&info->controller);
> +	info->controller.ops = &s3c24xx_nand_controller_ops;
>  
>  	/* get the clock source and enable it */
>  
> @@ -1166,15 +1170,7 @@ static int s3c24xx_nand_probe(struct platform_device *pdev)
>  		mtd->dev.parent = &pdev->dev;
>  		s3c2410_nand_init_chip(info, nmtd, sets);
>  
> -		err = nand_scan_ident(mtd, (sets) ? sets->nr_chips : 1, NULL);
> -		if (err)
> -			goto exit_error;
> -
> -		err = s3c2410_nand_update_chip(info, nmtd);
> -		if (err < 0)
> -			goto exit_error;
> -
> -		err = nand_scan_tail(mtd);
> +		err = nand_scan(mtd, sets ? sets->nr_chips : 1);
>  		if (err)
>  			goto exit_error;
>  

