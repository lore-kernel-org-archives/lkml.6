Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4021EC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E7520693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E7520693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730998AbeGSIsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 04:48:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54035 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727528AbeGSIso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 04:48:44 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B8F87207AD; Thu, 19 Jul 2018 10:06:47 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id 736AA206EE;
        Thu, 19 Jul 2018 10:06:47 +0200 (CEST)
Date:   Thu, 19 Jul 2018 10:06:47 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] mtd: nand: toshiba: Add support for Toshiba Memory
 BENAND (Built-in ECC NAND)
Message-ID: <20180719100647.6c2d5851@bbrezillon>
In-Reply-To: <1531986813-18701-1-git-send-email-yoshitake.kobayashi@toshiba.co.jp>
References: <1531986813-18701-1-git-send-email-yoshitake.kobayashi@toshiba.co.jp>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jul 2018 16:53:33 +0900
KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp> wrote:

> From: yoshitake.kobayashi@toshiba.co.jp
> 
> This patch is a patch to support TOSHIBA MEMORY CORPORATION BENAND
> memory devices.  Check the status of the built-in ECC with the Read
> Status command without using the vendor specific command.  The Read
> Status command only knows whether there was bitflips above the
> threshold and can not get accurate bitflips.  For now, I set
> max_bitflips mtd->bitflip_threshold.
> 
> Signed-off-by: KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp>
> ---
>  drivers/mtd/nand/raw/nand_toshiba.c | 84 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/nand_toshiba.c b/drivers/mtd/nand/raw/nand_toshiba.c
> index ab43f02..6cec923 100644
> --- a/drivers/mtd/nand/raw/nand_toshiba.c
> +++ b/drivers/mtd/nand/raw/nand_toshiba.c
> @@ -17,6 +17,86 @@
>  
>  #include <linux/mtd/rawnand.h>
>  
> +/* Recommended to rewrite for BENAND */
> +#define TOSHIBA_NAND_STATUS_REWRITE_RECOMMENDED	BIT(3)
> +
> +static int toshiba_nand_benand_eccstatus(struct mtd_info *mtd,
> +					 struct nand_chip *chip)
> +{
> +	int ret;
> +	unsigned int max_bitflips = 0;
> +	u8 status;
> +
> +	/* Check Status */
> +	ret = nand_status_op(chip, &status);
> +	if (ret)
> +		return ret;
> +
> +	if (status & NAND_STATUS_FAIL) {
> +		/* uncorrected */
> +		mtd->ecc_stats.failed++;
> +	} else if (status & TOSHIBA_NAND_STATUS_REWRITE_RECOMMENDED) {
> +		/* corrected */
> +		max_bitflips = mtd->bitflip_threshold;
> +		mtd->ecc_stats.corrected += max_bitflips;
> +	}
> +
> +	return max_bitflips;
> +}
> +
> +static int
> +toshiba_nand_read_page_benand(struct mtd_info *mtd,
> +			      struct nand_chip *chip, uint8_t *buf,
> +			      int oob_required, int page)
> +{
> +	int ret;
> +
> +	ret = nand_read_page_raw(mtd, chip, buf, oob_required, page);
> +	if (ret)
> +		return ret;
> +
> +	return toshiba_nand_benand_eccstatus(mtd, chip);
> +}
> +
> +static int
> +toshiba_nand_read_subpage_benand(struct mtd_info *mtd,
> +				 struct nand_chip *chip, uint32_t data_offs,
> +				 uint32_t readlen, uint8_t *bufpoi, int page)
> +{
> +	int ret;
> +
> +	ret = nand_read_page_op(chip, page, data_offs,
> +				bufpoi + data_offs, readlen);
> +	if (ret)
> +		return ret;
> +
> +	return toshiba_nand_benand_eccstatus(mtd, chip);
> +}
> +
> +static void toshiba_nand_benand_init(struct nand_chip *chip)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +
> +	/*
> +	 * On BENAND, the entire OOB region can be used by the MTD user.
> +	 * The calculated ECC bytes are stored into other isolated
> +	 * area which is not accessible to users.
> +	 * This is why chip->ecc.bytes = 0.
> +	 */
> +	chip->ecc.bytes = 0;
> +	chip->ecc.size = 512;
> +	chip->ecc.strength = 8;
> +	chip->ecc.read_page = toshiba_nand_read_page_benand;
> +	chip->ecc.read_subpage = toshiba_nand_read_subpage_benand;
> +	chip->ecc.write_page = nand_write_page_raw;
> +	chip->ecc.read_page_raw = nand_read_page_raw;
> +	chip->ecc.write_page_raw = nand_write_page_raw;

Well, in this case raw accesses are not supported since you can't
disabled ECC. I just introduced nand_{read,write}_page_raw_notsupp(),
so you should probably use them.

> +
> +	chip->options |= NAND_SUBPAGE_READ;
> +
> +	mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
> +}
> +
>  static void toshiba_nand_decode_id(struct nand_chip *chip)
>  {
>  	struct mtd_info *mtd = nand_to_mtd(chip);
> @@ -68,6 +148,10 @@ static int toshiba_nand_init(struct nand_chip *chip)
>  	if (nand_is_slc(chip))
>  		chip->bbt_options |= NAND_BBT_SCAN2NDPAGE;
>  
> +	if (nand_is_slc(chip) && (chip->id.data[4] & 0x80) /* BENAND */ &&

Please put the /* BENAND */ comment above the if () block.
Maybe you should have a macro for the 0x80 value

#define TOSHIBA_NAND_ID4_IS_BENAND		BIT(7)

and then test

	chip->id.data[4] & TOSHIBA_NAND_ID4_IS_BENAND

> +	    (chip->ecc.mode == NAND_ECC_ON_DIE))

Unneeded parens around chip->ecc.mode == NAND_ECC_ON_DIE and
chip->id.data[4] & 0x80 tests.

> +		toshiba_nand_benand_init(chip);
> +
>  	return 0;
>  }
>  

