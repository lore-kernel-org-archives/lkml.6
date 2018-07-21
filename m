Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDDEECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 06:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4282C2084A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 06:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4282C2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeGUHmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 03:42:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42740 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbeGUHmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 03:42:07 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8B634207B4; Sat, 21 Jul 2018 08:50:28 +0200 (CEST)
Received: from bbrezillon (unknown [37.170.141.1])
        by mail.bootlin.com (Postfix) with ESMTPSA id 95DFC2072F;
        Sat, 21 Jul 2018 08:50:26 +0200 (CEST)
Date:   Sat, 21 Jul 2018 08:50:25 +0200
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
Subject: Re: [PATCH v4 05/35] mtd: rawnand: fsl_elbc: convert driver to
 nand_scan()
Message-ID: <20180721085025.27439bcb@bbrezillon>
In-Reply-To: <20180720151527.16038-6-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
        <20180720151527.16038-6-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 17:14:57 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Two helpers have been added to the core to make ECC-related
> configuration between the detection phase and the final NAND scan. Use
> these hooks and convert the driver to just use nand_scan() instead of
> both nand_scan_ident() and nand_scan_tail().
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/nand/raw/fsl_elbc_nand.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/fsl_elbc_nand.c b/drivers/mtd/nand/raw/fsl_elbc_nand.c
> index 0aa54a949653..44893e49b386 100644
> --- a/drivers/mtd/nand/raw/fsl_elbc_nand.c
> +++ b/drivers/mtd/nand/raw/fsl_elbc_nand.c
> @@ -637,9 +637,9 @@ static int fsl_elbc_wait(struct mtd_info *mtd, struct nand_chip *chip)
>  	return (elbc_fcm_ctrl->mdr & 0xff) | NAND_STATUS_WP;
>  }
>  
> -static int fsl_elbc_chip_init_tail(struct mtd_info *mtd)
> +static int fsl_elbc_attach_chip(struct nand_chip *chip)
>  {
> -	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct mtd_info *mtd = nand_to_mtd(chip);
>  	struct fsl_elbc_mtd *priv = nand_get_controller_data(chip);
>  	struct fsl_lbc_ctrl *ctrl = priv->ctrl;
>  	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
> @@ -706,6 +706,10 @@ static int fsl_elbc_chip_init_tail(struct mtd_info *mtd)

Looks like fsl_elbc_chip_init_tail() was returning -1 here [1]. Please
change that for a -ENOTSUPP. With that fixed:

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

>  	return 0;
>  }
>  
> +static const struct nand_controller_ops fsl_elbc_controller_ops = {
> +	.attach_chip = fsl_elbc_attach_chip,
> +};
> +
>  static int fsl_elbc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
>  			      uint8_t *buf, int oob_required, int page)
>  {
> @@ -910,15 +914,8 @@ static int fsl_elbc_nand_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err;
>  
> -	ret = nand_scan_ident(mtd, 1, NULL);
> -	if (ret)
> -		goto err;
> -
> -	ret = fsl_elbc_chip_init_tail(mtd);
> -	if (ret)
> -		goto err;
> -
> -	ret = nand_scan_tail(mtd);
> +	priv->chip.controller->ops = &fsl_elbc_controller_ops;
> +	ret = nand_scan(mtd, 1);
>  	if (ret)
>  		goto err;
>  

[1]https://elixir.bootlin.com/linux/v4.18-rc5/source/drivers/mtd/nand/raw/fsl_elbc_nand.c#L699
