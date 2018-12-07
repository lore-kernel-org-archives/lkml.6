Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4485AC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D8B20838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D8B20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbeLGIAz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 03:00:55 -0500
Received: from mail.bootlin.com ([62.4.15.54]:44313 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725952AbeLGIAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 03:00:55 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7719520CC3; Fri,  7 Dec 2018 09:00:52 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 26C362073D;
        Fri,  7 Dec 2018 09:00:42 +0100 (CET)
Date:   Fri, 7 Dec 2018 09:00:41 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peron.clem@gmail.com" <peron.clem@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v3] mtd: spinand: Fix ECC status and OOB layout for
 Toshiba TC58CVG2S0H
Message-ID: <20181207090041.6b8d9731@xps13>
In-Reply-To: <1543823821-18352-1-git-send-email-frieder.schrempf@kontron.de>
References: <1543823821-18352-1-git-send-email-frieder.schrempf@kontron.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Schrempf, Clément,

Schrempf Frieder <frieder.schrempf@kontron.de> wrote on Mon, 3 Dec 2018
08:01:38 +0000:

> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> When reading the status of the on-chip ECC, the Toshiba chip returns
> two different states for reporting corrected bitflips. We should check
> for both of them.
> 
> Also return the free OOB bytes as one contiguous area, instead of
> multiple sections.
> 
> Suggested-by: Clément Péron <peron.clem@gmail.com>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Acked-by: Clément Péron <peron.clem@gmail.com>
> ---
> Changes for v3:
> ===============
> * Add Acked-by
> * Add comment for BBM in OOB layout
> 
> Changes for v2:
> ===============
> * Remove the changes to the ECC bytes in the OOB layout
> ---
>  drivers/mtd/nand/spi/toshiba.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
> index 294bcf6..0812655 100644
> --- a/drivers/mtd/nand/spi/toshiba.c
> +++ b/drivers/mtd/nand/spi/toshiba.c
> @@ -11,6 +11,7 @@
>  #include <linux/mtd/spinand.h>
>  
>  #define SPINAND_MFR_TOSHIBA		0x98
> +#define TOSH_STATUS_ECC_HAS_BITFLIPS_T	(3 << 4)
>  
>  static SPINAND_OP_VARIANTS(read_cache_variants,
>  		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> @@ -33,19 +34,18 @@ static int tc58cvg2s0h_ooblayout_ecc(struct mtd_info *mtd, int section,
>  	region->offset = 128 + 16 * section;
>  	region->length = 16;
>  
> -
>  	return 0;
>  }
>  
>  static int tc58cvg2s0h_ooblayout_free(struct mtd_info *mtd, int section,
>  				      struct mtd_oob_region *region)
>  {
> -	if (section > 7)
> +	if (section > 0)
>  		return -ERANGE;
>  
> -	region->offset = 2 + 16 * section;
> -	region->length = 14;
> -
> +	/* 2 bytes reserved for BBM */
> +	region->offset = 2;
> +	region->length = 126;
>  
>  	return 0;
>  }
> @@ -70,6 +70,7 @@ static int tc58cvg2s0h_ecc_get_status(struct spinand_device *spinand,
>  		return -EBADMSG;
>  
>  	case STATUS_ECC_HAS_BITFLIPS:
> +	case TOSH_STATUS_ECC_HAS_BITFLIPS_T:
>  		/*
>  		 * Let's try to retrieve the real maximum number of bitflips
>  		 * in order to avoid forcing the wear-leveling layer to move

If you don't mind, I would like to squash this with the original patch.
What about also adding Clement's Acked-by to it?


Thanks,
Miquèl
