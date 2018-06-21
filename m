Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8403C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D3A420883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D3A420883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754374AbeFULQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 07:16:41 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50658 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754178AbeFULQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 07:16:40 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6D3112072C; Thu, 21 Jun 2018 13:16:38 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 24B72206D8;
        Thu, 21 Jun 2018 13:16:28 +0200 (CEST)
Date:   Thu, 21 Jun 2018 13:16:28 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     miquel.raynal@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v4 5/6] mtd: rawnand: micron: support 8/512 on-die ECC
Message-ID: <20180621131628.07220d31@bbrezillon>
In-Reply-To: <20180621103328.28206-6-chris.packham@alliedtelesis.co.nz>
References: <20180621103328.28206-1-chris.packham@alliedtelesis.co.nz>
        <20180621103328.28206-6-chris.packham@alliedtelesis.co.nz>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2018 22:33:27 +1200
Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> Micron MT29F1G08ABAFAWP-ITE:F supports an on-die ECC with 8 bits
> per 512 bytes. Add support for this combination.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> Changes in v2:
> - New
> Changes in v3:
> - Handle reporting of corrected errors that don't require a rewrite, expand
>   comment for the ECC status bits.
> Changes in v4:
> - Use a switch statement for handling ECC status
> - Update ecc_stats.corrected
> 
>  drivers/mtd/nand/raw/nand_micron.c | 68 ++++++++++++++++++++----------
>  1 file changed, 46 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_micron.c b/drivers/mtd/nand/raw/nand_micron.c
> index d30bd4df9b12..f1ecd4986b50 100644
> --- a/drivers/mtd/nand/raw/nand_micron.c
> +++ b/drivers/mtd/nand/raw/nand_micron.c
> @@ -18,10 +18,28 @@
>  #include <linux/mtd/rawnand.h>
>  
>  /*
> - * Special Micron status bit that indicates when the block has been
> - * corrected by on-die ECC and should be rewritten
> + * Special Micron status bit 3 indicates that the block has been
> + * corrected by on-die ECC and should be rewritten.
> + *
> + * On chips with 8-bit ECC and additional bit can be used to distinguish
> + * cases where a errors were corrected without needing a rewrite
> + *
> + * Bit 4 Bit 3 Bit 0 Description
> + * ----- ----- ----- -----------
> + * 0     0     0     No Errors
> + * 0     0     1     Multiple uncorrected errors
> + * 0     1     0     4 - 6 errors corrected, recommend rewrite
> + * 0     1     1     Reserved
> + * 1     0     0     1 - 3 errors corrected
> + * 1     0     1     Reserved
> + * 1     1     0     7 - 8 errors corrected, recommend rewrite
>   */
> -#define NAND_STATUS_WRITE_RECOMMENDED	BIT(3)
> +#define NAND_STATUS_MASK		(BIT(4) | BIT(3) | BIT(0))
> +#define NAND_STATUS_NO_ERRORS		0
> +#define NAND_STATUS_UNCORRECTABLE	BIT(0)
> +#define NAND_STATUS_4_6_CORRECTED	BIT(3)
> +#define NAND_STATUS_1_3_CORRECTED	BIT(4)
> +#define NAND_STATUS_7_8_CORRECTED	(BIT(4) | BIT(3))

NAND_ECC_STATUS_ prefix would be better than NAND_STATUS_

>  
>  struct nand_onfi_vendor_micron {
>  	u8 two_plane_read;
> @@ -137,18 +155,31 @@ micron_nand_read_page_on_die_ecc(struct mtd_info *mtd, struct nand_chip *chip,
>  	if (ret)
>  		goto out;
>  
> -	if (status & NAND_STATUS_FAIL) {
> +	/*
> +	 * The internal ECC doesn't tell us the number of bitflips
> +	 * that have been corrected, but tells us if it recommends to
> +	 * rewrite the block. If it's the case, then we pretend we had
> +	 * a number of bitflips equal to the ECC strength, which will
> +	 * hint the NAND core to rewrite the block.
> +	 */
> +	switch (status & NAND_STATUS_MASK) {
> +	case NAND_STATUS_UNCORRECTABLE:

I'd recommend handling 8bit and 4bit on-die ECC separately (create on
subfunction per kind of ECC), and not using the same _MASK, just in
case unused bits value have a different meaning or are simply not set
to 0 by default.

>  		mtd->ecc_stats.failed++;
> -	} else if (status & NAND_STATUS_WRITE_RECOMMENDED) {
> -		/*
> -		 * The internal ECC doesn't tell us the number of bitflips
> -		 * that have been corrected, but tells us if it recommends to
> -		 * rewrite the block. If it's the case, then we pretend we had
> -		 * a number of bitflips equal to the ECC strength, which will
> -		 * hint the NAND core to rewrite the block.
> -		 */
> -		mtd->ecc_stats.corrected += chip->ecc.strength;
> +		break;
> +	case NAND_STATUS_1_3_CORRECTED:
> +		mtd->ecc_stats.corrected++;
> +		max_bitflips = 1;

Should you always take the max of the range, so here:

		mtd->ecc_stats.corrected += 3;
		max_bitflips = 3;

> +		break;
> +	case NAND_STATUS_4_6_CORRECTED:
> +		mtd->ecc_stats.corrected += 4;

					 += 6;

> +		/* rewrite recommended */
> +		max_bitflips = chip->ecc.strength;

Here it should be 6, not chip->ecc.strength.

> +		break;
> +	case NAND_STATUS_7_8_CORRECTED:
> +		mtd->ecc_stats.corrected += 7;

					 += 8;

> +		/* rewrite recommended */
>  		max_bitflips = chip->ecc.strength;
> +		break;
>  	}
>  
>  	ret = nand_read_data_op(chip, buf, mtd->writesize, false);
> @@ -239,13 +270,6 @@ static int micron_supports_on_die_ecc(struct nand_chip *chip)
>  	if (feature[0] & ONFI_FEATURE_ON_DIE_ECC_EN)
>  		return MICRON_ON_DIE_MANDATORY;
>  
> -	/*
> -	 * Some Micron NANDs have an on-die ECC of 4/512, some other
> -	 * 8/512. We only support the former.
> -	 */
> -	if (chip->ecc_strength_ds != 4)
> -		return MICRON_ON_DIE_UNSUPPORTED;

I'd prefer to keep an explicit check here rather than accepting
everything. See how 8 and 4 bit ECC differ, it's likely to be the case
if Micron ever has a 16bit ECC.

> -
>  	return MICRON_ON_DIE_SUPPORTED;
>  }
>  
> @@ -275,9 +299,9 @@ static int micron_nand_init(struct nand_chip *chip)
>  			return -EINVAL;
>  		}
>  
> -		chip->ecc.bytes = 8;
> +		chip->ecc.bytes = chip->ecc_strength_ds * 2;
>  		chip->ecc.size = 512;
> -		chip->ecc.strength = 4;
> +		chip->ecc.strength = chip->ecc_strength_ds;
>  		chip->ecc.algo = NAND_ECC_BCH;
>  		chip->ecc.read_page = micron_nand_read_page_on_die_ecc;
>  		chip->ecc.write_page = micron_nand_write_page_on_die_ecc;

