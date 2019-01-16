Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07B6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC112082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389008AbfAPKFB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:05:01 -0500
Received: from mail.bootlin.com ([62.4.15.54]:52687 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732165AbfAPKFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:05:00 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 79C652074E; Wed, 16 Jan 2019 11:04:57 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id 29E682073D;
        Wed, 16 Jan 2019 11:04:57 +0100 (CET)
Date:   Wed, 16 Jan 2019 11:04:57 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yoshio Furuyama <tmcmc-mb-yfuruyama7@ml.toshiba.co.jp>
Cc:     bbrezillon@kernel.org, richard@nod.at, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        frieder.schrempf@kontron.De, peron.clem@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spinand: Add support for all Toshiba Memory
 products
Message-ID: <20190116110457.6ca57d77@xps13>
In-Reply-To: <20190116055319.2755-1-tmcmc-mb-yfuruyama7@ml.toshiba.co.jp>
References: <20190116055319.2755-1-tmcmc-mb-yfuruyama7@ml.toshiba.co.jp>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yoshio,

Yoshio Furuyama <tmcmc-mb-yfuruyama7@ml.toshiba.co.jp> wrote on Wed, 16
Jan 2019 14:53:19 +0900:

> Add device table for Toshiba Memory products.
> Also, generalize OOB layout structure and function names.
> 
> Signed-off-by: Yoshio Furuyama <tmcmc-mb-yfuruyama7@ml.toshiba.co.jp>
> 
> ---
>  drivers/mtd/nand/spi/toshiba.c |   79 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 65 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
> index 0812655..0916962 100644
> --- a/drivers/mtd/nand/spi/toshiba.c
> +++ b/drivers/mtd/nand/spi/toshiba.c
> @@ -25,19 +25,19 @@ static SPINAND_OP_VARIANTS(write_cache_variants,
>  static SPINAND_OP_VARIANTS(update_cache_variants,
>  		SPINAND_PROG_LOAD(false, 0, NULL, 0));
>  
> -static int tc58cvg2s0h_ooblayout_ecc(struct mtd_info *mtd, int section,
> +static int tc58cxgxsx_ooblayout_ecc(struct mtd_info *mtd, int section,
>  				     struct mtd_oob_region *region)
>  {
> -	if (section > 7)
> +	if (section > 0)
>  		return -ERANGE;
>  
> -	region->offset = 128 + 16 * section;
> -	region->length = 16;
> +	region->offset = mtd->oobsize / 2;
> +	region->length = mtd->oobsize / 2;
>  
>  	return 0;
>  }
>  
> -static int tc58cvg2s0h_ooblayout_free(struct mtd_info *mtd, int section,
> +static int tc58cxgxsx_ooblayout_free(struct mtd_info *mtd, int section,
>  				      struct mtd_oob_region *region)
>  {
>  	if (section > 0)
> @@ -45,17 +45,17 @@ static int tc58cvg2s0h_ooblayout_free(struct mtd_info *mtd, int section,
>  
>  	/* 2 bytes reserved for BBM */
>  	region->offset = 2;
> -	region->length = 126;
> +	region->length = mtd->oobsize / 2 - 2;

I know this is valid C but I am always puzzled when reading such
mathematical operation, I would prefer (mtd->oobsize / 2) - 2.

I'm fine with the rest so if there is no other comment I will fix when
applying.


Thanks,
Miquèl
