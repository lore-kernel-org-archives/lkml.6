Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01EFC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8250220870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548163152;
	bh=P28iCts/NHFf8we79w3QoPT8Vh/DZbxcqNjaPRIQCf4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=HIc75eUv3BqSSUdAy8qbqw9cVgSQ9lmTePCJNf0K0lkke3/O80dFoCkipB+MpJnPm
	 2b3AvyRyGSBQsqr/glmK58mEycrree6w2YLLnVMKNf/y8tVcL+/EQPLjxyN/me0t5O
	 0YxVUwPBP5A4MLmPRbCqSL51mooI30PYzda6KNZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbfAVNTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:19:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:51358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728239AbfAVNTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:19:10 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1C7E20870;
        Tue, 22 Jan 2019 13:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548163148;
        bh=P28iCts/NHFf8we79w3QoPT8Vh/DZbxcqNjaPRIQCf4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t7fW8G4PcSbNK2cA6ls1tpM4qG3Mv0LBr7XPQKzpWXtAnMbR7oXjJ9CZ2j5CEHaNn
         BIDC7XiPjg7MCACgGJLTXVyon22cntdAb+kIZTz60AdeZlDX8sikUo43N+AjNLxR8D
         dFw3s98+Gg+vun3WarkvFF7UDnhqp66EIHEOgd2E=
Date:   Tue, 22 Jan 2019 14:18:57 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] mtd: nand: Always store info about bad block
 markers in chip struct
Message-ID: <20190122141857.53329d61@bbrezillon>
In-Reply-To: <20190122112258.20042-2-frieder.schrempf@kontron.de>
References: <20190122112258.20042-1-frieder.schrempf@kontron.de>
        <20190122112258.20042-2-frieder.schrempf@kontron.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2019 11:23:29 +0000
Schrempf Frieder <frieder.schrempf@kontron.de> wrote:

> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> The information about where the manufacturer puts the bad block
> markers inside the bad block and in the OOB data is stored in
> different places. Let's move this information to nand_chip.options
> and nand_chip.badblockpos.
> 
> As this chip-specific information is not directly related to the
> bad block table (BBT) and to make them more flexible, we also rename
> the flags and create separate flags for storing the BBM in the first
> and the second page instead of the combined flag.

The separation for first and second page flags should IMO be done in a
separate patch. Looks good otherwise.

> 
> Signed-off-by: Frieder.Schrempf <frieder.schrempf@kontron.de>
> ---
>  drivers/mtd/nand/onenand/onenand_base.c |  2 +-
>  drivers/mtd/nand/onenand/onenand_bbt.c  |  2 +-
>  drivers/mtd/nand/raw/nand_amd.c         |  2 +-
>  drivers/mtd/nand/raw/nand_base.c        | 14 ++++++++------
>  drivers/mtd/nand/raw/nand_bbt.c         |  5 +++--
>  drivers/mtd/nand/raw/nand_esmt.c        |  2 +-
>  drivers/mtd/nand/raw/nand_hynix.c       |  4 ++--
>  drivers/mtd/nand/raw/nand_macronix.c    |  2 +-
>  drivers/mtd/nand/raw/nand_micron.c      |  2 +-
>  drivers/mtd/nand/raw/nand_samsung.c     |  4 ++--
>  drivers/mtd/nand/raw/nand_toshiba.c     |  2 +-
>  drivers/mtd/nand/raw/sh_flctl.c         |  4 ++--
>  include/linux/mtd/bbm.h                 | 14 +-------------
>  include/linux/mtd/rawnand.h             | 16 ++++++++++++++++
>  14 files changed, 41 insertions(+), 34 deletions(-)
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
>  
>  	/* Set erase shift */
>  	bbm->bbt_erase_shift = this->erase_shift;
> diff --git a/drivers/mtd/nand/raw/nand_amd.c b/drivers/mtd/nand/raw/nand_amd.c
> index 890c5b43e03c..6202cbf7ee8d 100644
> --- a/drivers/mtd/nand/raw/nand_amd.c
> +++ b/drivers/mtd/nand/raw/nand_amd.c
> @@ -40,7 +40,7 @@ static void amd_nand_decode_id(struct nand_chip *chip)
>  static int amd_nand_init(struct nand_chip *chip)
>  {
>  	if (nand_is_slc(chip))
> -		chip->bbt_options |= NAND_BBT_SCAN2NDPAGE;
> +		chip->options |= NAND_BBM_FIRSTPAGE | NAND_BBM_SECONDPAGE;
>  
>  	return 0;
>  }
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index cca4b24d2ffa..9ef7b86cdc42 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -298,11 +298,12 @@ static int nand_block_bad(struct nand_chip *chip, loff_t ofs)
>  	int page, page_end, res;
>  	u8 bad;
>  
> -	if (chip->bbt_options & NAND_BBT_SCANLASTPAGE)
> +	if (chip->options & NAND_BBM_LASTPAGE)
>  		ofs += mtd->erasesize - mtd->writesize;
>  
>  	page = (int)(ofs >> chip->page_shift) & chip->pagemask;
> -	page_end = page + (chip->bbt_options & NAND_BBT_SCAN2NDPAGE ? 2 : 1);
> +	page_end = page + (((chip->options & NAND_BBM_FIRSTPAGE) &&
> +			    (chip->options & NAND_BBM_SECONDPAGE)) ? 2 : 1);
>  
>  	for (; page < page_end; page++) {
>  		res = chip->ecc.read_oob(chip, page);
> @@ -541,7 +542,7 @@ static int nand_default_block_markbad(struct nand_chip *chip, loff_t ofs)
>  	ops.mode = MTD_OPS_PLACE_OOB;
>  
>  	/* Write to first/last page(s) if necessary */
> -	if (chip->bbt_options & NAND_BBT_SCANLASTPAGE)
> +	if (chip->options & NAND_BBM_LASTPAGE)
>  		ofs += mtd->erasesize - mtd->writesize;
>  	do {
>  		res = nand_do_write_oob(chip, ofs, &ops);
> @@ -550,7 +551,8 @@ static int nand_default_block_markbad(struct nand_chip *chip, loff_t ofs)
>  
>  		i++;
>  		ofs += mtd->writesize;
> -	} while ((chip->bbt_options & NAND_BBT_SCAN2NDPAGE) && i < 2);
> +	} while ((chip->options & NAND_BBM_FIRSTPAGE) &&
> +		 (chip->options & NAND_BBM_SECONDPAGE) && i < 2);
>  
>  	return ret;
>  }
> @@ -4576,9 +4578,9 @@ static void nand_decode_bbm_options(struct nand_chip *chip)
>  
>  	/* Set the bad block position */
>  	if (mtd->writesize > 512 || (chip->options & NAND_BUSWIDTH_16))
> -		chip->badblockpos = NAND_LARGE_BADBLOCK_POS;
> +		chip->badblockpos = NAND_BBM_POS_LARGE;
>  	else
> -		chip->badblockpos = NAND_SMALL_BADBLOCK_POS;
> +		chip->badblockpos = NAND_BBM_POS_SMALL;
>  }
>  
>  static inline bool is_full_id_nand(struct nand_flash_dev *type)
> diff --git a/drivers/mtd/nand/raw/nand_bbt.c b/drivers/mtd/nand/raw/nand_bbt.c
> index 1b722fe9213c..c095c04d566d 100644
> --- a/drivers/mtd/nand/raw/nand_bbt.c
> +++ b/drivers/mtd/nand/raw/nand_bbt.c
> @@ -466,7 +466,8 @@ static int create_bbt(struct nand_chip *this, uint8_t *buf,
>  
>  	pr_info("Scanning device for bad blocks\n");
>  
> -	if (bd->options & NAND_BBT_SCAN2NDPAGE)
> +	if ((this->options & NAND_BBM_FIRSTPAGE) &&
> +	    (this->options & NAND_BBM_SECONDPAGE))
>  		numpages = 2;
>  	else
>  		numpages = 1;
> @@ -487,7 +488,7 @@ static int create_bbt(struct nand_chip *this, uint8_t *buf,
>  		from = (loff_t)startblock << this->bbt_erase_shift;
>  	}
>  
> -	if (this->bbt_options & NAND_BBT_SCANLASTPAGE)
> +	if (this->bbt_options & NAND_BBM_LASTPAGE)
>  		from += mtd->erasesize - (mtd->writesize * numpages);
>  
>  	for (i = startblock; i < numblocks; i++) {
> diff --git a/drivers/mtd/nand/raw/nand_esmt.c b/drivers/mtd/nand/raw/nand_esmt.c
> index 96f039a83bc8..99a8092969a7 100644
> --- a/drivers/mtd/nand/raw/nand_esmt.c
> +++ b/drivers/mtd/nand/raw/nand_esmt.c
> @@ -36,7 +36,7 @@ static void esmt_nand_decode_id(struct nand_chip *chip)
>  static int esmt_nand_init(struct nand_chip *chip)
>  {
>  	if (nand_is_slc(chip))
> -		chip->bbt_options |= NAND_BBT_SCAN2NDPAGE;
> +		chip->options |= NAND_BBM_FIRSTPAGE | NAND_BBM_SECONDPAGE;
>  
>  	return 0;
>  }
> diff --git a/drivers/mtd/nand/raw/nand_hynix.c b/drivers/mtd/nand/raw/nand_hynix.c
> index 343f477362d1..e685d70c1618 100644
> --- a/drivers/mtd/nand/raw/nand_hynix.c
> +++ b/drivers/mtd/nand/raw/nand_hynix.c
> @@ -672,9 +672,9 @@ static int hynix_nand_init(struct nand_chip *chip)
>  	int ret;
>  
>  	if (!nand_is_slc(chip))
> -		chip->bbt_options |= NAND_BBT_SCANLASTPAGE;
> +		chip->options |= NAND_BBM_LASTPAGE;
>  	else
> -		chip->bbt_options |= NAND_BBT_SCAN2NDPAGE;
> +		chip->options |= NAND_BBM_FIRSTPAGE | NAND_BBM_SECONDPAGE;
>  
>  	hynix = kzalloc(sizeof(*hynix), GFP_KERNEL);
>  	if (!hynix)
> diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/raw/nand_macronix.c
> index 47d8cda547cf..e287e71347c5 100644
> --- a/drivers/mtd/nand/raw/nand_macronix.c
> +++ b/drivers/mtd/nand/raw/nand_macronix.c
> @@ -62,7 +62,7 @@ static void macronix_nand_fix_broken_get_timings(struct nand_chip *chip)
>  static int macronix_nand_init(struct nand_chip *chip)
>  {
>  	if (nand_is_slc(chip))
> -		chip->bbt_options |= NAND_BBT_SCAN2NDPAGE;
> +		chip->options |= NAND_BBM_FIRSTPAGE | NAND_BBM_SECONDPAGE;
>  
>  	macronix_nand_fix_broken_get_timings(chip);
>  
> diff --git a/drivers/mtd/nand/raw/nand_micron.c b/drivers/mtd/nand/raw/nand_micron.c
> index b85e1c13b79e..ca80e09783c7 100644
> --- a/drivers/mtd/nand/raw/nand_micron.c
> +++ b/drivers/mtd/nand/raw/nand_micron.c
> @@ -448,7 +448,7 @@ static int micron_nand_init(struct nand_chip *chip)
>  		goto err_free_manuf_data;
>  
>  	if (mtd->writesize == 2048)
> -		chip->bbt_options |= NAND_BBT_SCAN2NDPAGE;
> +		chip->options |= NAND_BBM_FIRSTPAGE | NAND_BBM_SECONDPAGE;
>  
>  	ondie = micron_supports_on_die_ecc(chip);
>  
> diff --git a/drivers/mtd/nand/raw/nand_samsung.c b/drivers/mtd/nand/raw/nand_samsung.c
> index e46d4c492ad8..ace50522dd19 100644
> --- a/drivers/mtd/nand/raw/nand_samsung.c
> +++ b/drivers/mtd/nand/raw/nand_samsung.c
> @@ -121,9 +121,9 @@ static int samsung_nand_init(struct nand_chip *chip)
>  		chip->options |= NAND_SAMSUNG_LP_OPTIONS;
>  
>  	if (!nand_is_slc(chip))
> -		chip->bbt_options |= NAND_BBT_SCANLASTPAGE;
> +		chip->options |= NAND_BBM_LASTPAGE;
>  	else
> -		chip->bbt_options |= NAND_BBT_SCAN2NDPAGE;
> +		chip->options |= NAND_BBM_FIRSTPAGE | NAND_BBM_SECONDPAGE;
>  
>  	return 0;
>  }
> diff --git a/drivers/mtd/nand/raw/nand_toshiba.c b/drivers/mtd/nand/raw/nand_toshiba.c
> index d068163b64b3..0031e6727193 100644
> --- a/drivers/mtd/nand/raw/nand_toshiba.c
> +++ b/drivers/mtd/nand/raw/nand_toshiba.c
> @@ -147,7 +147,7 @@ static void toshiba_nand_decode_id(struct nand_chip *chip)
>  static int toshiba_nand_init(struct nand_chip *chip)
>  {
>  	if (nand_is_slc(chip))
> -		chip->bbt_options |= NAND_BBT_SCAN2NDPAGE;
> +		chip->options |= NAND_BBM_FIRSTPAGE | NAND_BBM_SECONDPAGE;
>  
>  	/* Check that chip is BENAND and ECC mode is on-die */
>  	if (nand_is_slc(chip) && chip->ecc.mode == NAND_ECC_ON_DIE &&
> diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
> index cf6b1be1cf9c..971d9afd55e5 100644
> --- a/drivers/mtd/nand/raw/sh_flctl.c
> +++ b/drivers/mtd/nand/raw/sh_flctl.c
> @@ -101,14 +101,12 @@ static const struct mtd_ooblayout_ops flctl_4secc_oob_largepage_ops = {
>  static uint8_t scan_ff_pattern[] = { 0xff, 0xff };
>  
>  static struct nand_bbt_descr flctl_4secc_smallpage = {
> -	.options = NAND_BBT_SCAN2NDPAGE,
>  	.offs = 11,
>  	.len = 1,
>  	.pattern = scan_ff_pattern,
>  };
>  
>  static struct nand_bbt_descr flctl_4secc_largepage = {
> -	.options = NAND_BBT_SCAN2NDPAGE,
>  	.offs = 0,
>  	.len = 2,
>  	.pattern = scan_ff_pattern,
> @@ -1178,6 +1176,8 @@ static int flctl_probe(struct platform_device *pdev)
>  	if (pdata->flcmncr_val & SEL_16BIT)
>  		nand->options |= NAND_BUSWIDTH_16;
>  
> +	nand->options |= NAND_BBM_FIRSTPAGE | NAND_BBM_SECONDPAGE;
> +
>  	pm_runtime_enable(&pdev->dev);
>  	pm_runtime_resume(&pdev->dev);
>  
> diff --git a/include/linux/mtd/bbm.h b/include/linux/mtd/bbm.h
> index 3102bd754d18..010bc5544c54 100644
> --- a/include/linux/mtd/bbm.h
> +++ b/include/linux/mtd/bbm.h
> @@ -93,10 +93,7 @@ struct nand_bbt_descr {
>  #define NAND_BBT_WRITE		0x00002000
>  /* Read and write back block contents when writing bbt */
>  #define NAND_BBT_SAVECONTENT	0x00004000
> -/* Search good / bad pattern on the first and the second page */
> -#define NAND_BBT_SCAN2NDPAGE	0x00008000
> -/* Search good / bad pattern on the last page of the eraseblock */
> -#define NAND_BBT_SCANLASTPAGE	0x00010000
> +
>  /*
>   * Use a flash based bad block table. By default, OOB identifier is saved in
>   * OOB area. This option is passed to the default bad block table function.
> @@ -123,13 +120,6 @@ struct nand_bbt_descr {
>  /* The maximum number of blocks to scan for a bbt */
>  #define NAND_BBT_SCAN_MAXBLOCKS	4
>  
> -/*
> - * Constants for oob configuration
> - */
> -#define NAND_SMALL_BADBLOCK_POS		5
> -#define NAND_LARGE_BADBLOCK_POS		0
> -#define ONENAND_BADBLOCK_POS		0
> -
>  /*
>   * Bad block scanning errors
>   */
> @@ -140,7 +130,6 @@ struct nand_bbt_descr {
>  /**
>   * struct bbm_info - [GENERIC] Bad Block Table data structure
>   * @bbt_erase_shift:	[INTERN] number of address bits in a bbt entry
> - * @badblockpos:	[INTERN] position of the bad block marker in the oob area
>   * @options:		options for this descriptor
>   * @bbt:		[INTERN] bad block table pointer
>   * @isbad_bbt:		function to determine if a block is bad
> @@ -150,7 +139,6 @@ struct nand_bbt_descr {
>   */
>  struct bbm_info {
>  	int bbt_erase_shift;
> -	int badblockpos;
>  	int options;
>  
>  	uint8_t *bbt;
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index 33e240acdc6d..80bd3da06bec 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -169,6 +169,22 @@ enum nand_ecc_algo {
>  /* Macros to identify the above */
>  #define NAND_HAS_SUBPAGE_READ(chip) ((chip->options & NAND_SUBPAGE_READ))
>  
> +/*
> + * There are different places where the manufacturer stores the factory bad
> + * block markers.
> + *
> + * Position within the block: Each of these pages needs to be checked for a
> + * bad block marking pattern.
> + */
> +#define NAND_BBM_FIRSTPAGE		0x00008000
> +#define NAND_BBM_SECONDPAGE		0x00010000
> +#define NAND_BBM_LASTPAGE		0x00020000
> +
> +/* Position within the OOB data of the page */
> +#define NAND_BBM_POS_SMALL		5
> +#define NAND_BBM_POS_LARGE		0
> +#define NAND_BBM_POS_ONENAND		0
> +
>  /* Non chip related options */
>  /* This option skips the bbt scan during initialization. */
>  #define NAND_SKIP_BBTSCAN	0x00010000

