Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8D7C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1F52084A
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548854933;
	bh=qavFVLHOnztYwoAr490K7QpDJg81d45YuBOQPHprG6k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=IzXocQG0zjg7VKP2Ez32jdS1ABCMSqXAr3PAXEfbJezCsD9HlPlF/8zpd9TBMXFk9
	 GalfRcdS263IZqYkZPQxgoBGKmBoGgomVurkk7nSu00wTZUTc2gv4wAU+pE8pOieNY
	 /9lfJBL3rU83b5CBbgqvjdO+rK0H09maL2s9n5KM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbfA3N2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:28:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:51786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbfA3N2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:28:51 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF82920989;
        Wed, 30 Jan 2019 13:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548854929;
        bh=qavFVLHOnztYwoAr490K7QpDJg81d45YuBOQPHprG6k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=udQRjtYqYAV3tiBLoPP6EeR8oRLUeKGt9IiKjpyIDwcCZkXEvDg5yzIJQhuXwJ05m
         R2QWjJ/P14lwKTeinjzUVce5lp3havNOTTOSW1jy+uUl3jti/Q5VvVHQI4xVGyaqhk
         RhEJnhFTTMANOINH4gdtgDb3PKmP/x2g6WHh5MoQ=
Date:   Wed, 30 Jan 2019 14:28:38 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        "Marek Vasut" <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] mtd: nand: Always store info about bad block
 markers in chip struct
Message-ID: <20190130142838.5590f8b4@bbrezillon>
In-Reply-To: <20190130130111.32724-2-frieder.schrempf@kontron.de>
References: <20190130130111.32724-1-frieder.schrempf@kontron.de>
        <20190130130111.32724-2-frieder.schrempf@kontron.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 13:01:44 +0000
Schrempf Frieder <frieder.schrempf@kontron.de> wrote:

> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> The information about where the manufacturer puts the bad block
> markers inside the bad block and in the OOB data is stored in
> different places. Let's move this information to nand_chip.options
> and nand_chip.badblockpos.
> 
> As this chip-specific information is not directly related to the
> bad block table (BBT), we also rename the flags to NAND_BBM_*.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  drivers/mtd/nand/onenand/onenand_base.c |  2 +-
>  drivers/mtd/nand/onenand/onenand_bbt.c  |  2 +-
>  drivers/mtd/nand/raw/nand_amd.c         |  2 +-
>  drivers/mtd/nand/raw/nand_base.c        | 12 ++++++------
>  drivers/mtd/nand/raw/nand_bbt.c         |  4 ++--
>  drivers/mtd/nand/raw/nand_esmt.c        |  2 +-
>  drivers/mtd/nand/raw/nand_hynix.c       |  4 ++--
>  drivers/mtd/nand/raw/nand_macronix.c    |  2 +-
>  drivers/mtd/nand/raw/nand_micron.c      |  2 +-
>  drivers/mtd/nand/raw/nand_samsung.c     |  4 ++--
>  drivers/mtd/nand/raw/nand_toshiba.c     |  2 +-
>  drivers/mtd/nand/raw/sh_flctl.c         |  4 ++--
>  include/linux/mtd/bbm.h                 | 14 +-------------
>  include/linux/mtd/rawnand.h             | 15 +++++++++++++++

Might be better to split that in 2 patches:
- update onenand logic
- update rawnand logic

>  14 files changed, 37 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
> index 4ca4b194e7d7..d6701b8f031f 100644
> --- a/drivers/mtd/nand/onenand/onenand_base.c
> +++ b/drivers/mtd/nand/onenand/onenand_base.c
> @@ -2458,7 +2458,7 @@ static int onenand_default_block_markbad(struct mtd_info *mtd, loff_t ofs)
>                  bbm->bbt[block >> 2] |= 0x01 << ((block & 0x03) << 1);
>  
>          /* We write two bytes, so we don't have to mess with 16-bit access */
> -        ofs += mtd->oobsize + (bbm->badblockpos & ~0x01);
> +        ofs += mtd->oobsize + (this->badblockpos & ~0x01);

Looks like the ->badblockpos field does not exist in struct
onenand_chip, which means you didn't compile test this part ;-).

>  	/* FIXME : What to do when marking SLC block in partition
>  	 * 	   with MLC erasesize? For now, it is not advisable to
>  	 *	   create partitions containing both SLC and MLC regions.
> diff --git a/drivers/mtd/nand/onenand/onenand_bbt.c b/drivers/mtd/nand/onenand/onenand_bbt.c
> index dde20487937d..880b0abd36c8 100644
> --- a/drivers/mtd/nand/onenand/onenand_bbt.c
> +++ b/drivers/mtd/nand/onenand/onenand_bbt.c
> @@ -191,7 +191,7 @@ static int onenand_scan_bbt(struct mtd_info *mtd, struct nand_bbt_descr *bd)
>  		return -ENOMEM;
>  
>  	/* Set the bad block position */
> -	bbm->badblockpos = ONENAND_BADBLOCK_POS;
> +	this->badblockpos = NAND_BBM_POS_ONENAND;

This should be done in onenand_base.c not onenand_bbt.c.

>  
>  	/* Set erase shift */
>  	bbm->bbt_erase_shift = this->erase_shift;

...

> diff --git a/drivers/mtd/nand/raw/nand_bbt.c b/drivers/mtd/nand/raw/nand_bbt.c
> index 1b722fe9213c..862eaa3a0552 100644
> --- a/drivers/mtd/nand/raw/nand_bbt.c
> +++ b/drivers/mtd/nand/raw/nand_bbt.c
> @@ -466,7 +466,7 @@ static int create_bbt(struct nand_chip *this, uint8_t *buf,
>  
>  	pr_info("Scanning device for bad blocks\n");
>  
> -	if (bd->options & NAND_BBT_SCAN2NDPAGE)
> +	if (this->options & NAND_BBM_SECONDPAGE)
>  		numpages = 2;
>  	else
>  		numpages = 1;
> @@ -487,7 +487,7 @@ static int create_bbt(struct nand_chip *this, uint8_t *buf,
>  		from = (loff_t)startblock << this->bbt_erase_shift;
>  	}
>  
> -	if (this->bbt_options & NAND_BBT_SCANLASTPAGE)
> +	if (this->bbt_options & NAND_BBM_LASTPAGE)

You're not checking the right field here:

	if (this->options & NAND_BBM_LASTPAGE)

>  		from += mtd->erasesize - (mtd->writesize * numpages);
>  
>  	for (i = startblock; i < numblocks; i++) {
