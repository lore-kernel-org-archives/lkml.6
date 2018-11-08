Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101E3C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72E22086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72E22086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbeKHSfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:35:46 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58676 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbeKHSfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:35:46 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B65092072D; Thu,  8 Nov 2018 10:01:14 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-30-49.w90-88.abo.wanadoo.fr [90.88.15.49])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4B9FC2039F;
        Thu,  8 Nov 2018 10:01:14 +0100 (CET)
Date:   Thu, 8 Nov 2018 10:01:14 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.De>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH] mtd: nand: spi: Add initial support for Toshiba
 TC58CVG2S0H
Message-ID: <20181108100114.0874e2ec@bbrezillon>
In-Reply-To: <1541665796-21092-1-git-send-email-frieder.schrempf@kontron.de>
References: <1541665796-21092-1-git-send-email-frieder.schrempf@kontron.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nitpick: subject prefix should be "mtd: spinand" not
"mtd: nand: spi" :-).

On Thu, 8 Nov 2018 08:32:11 +0000
Schrempf Frieder <frieder.schrempf@kontron.De> wrote:

> Add minimal support for the Toshiba TC58CVG2S0H SPI NAND chip.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  drivers/mtd/nand/spi/Makefile  |   2 +-
>  drivers/mtd/nand/spi/core.c    |   1 +
>  drivers/mtd/nand/spi/toshiba.c | 136 ++++++++++++++++++++++++++++++++++++
>  include/linux/mtd/spinand.h    |   1 +
>  4 files changed, 139 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
> index b74e074..be5f735 100644
> --- a/drivers/mtd/nand/spi/Makefile
> +++ b/drivers/mtd/nand/spi/Makefile
> @@ -1,3 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
> -spinand-objs := core.o macronix.o micron.o winbond.o
> +spinand-objs := core.o macronix.o micron.o toshiba.o winbond.o
>  obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 30f8364..87bdf2a 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -766,6 +766,7 @@ static const struct nand_ops spinand_ops = {
>  static const struct spinand_manufacturer *spinand_manufacturers[] = {
>  	&macronix_spinand_manufacturer,
>  	&micron_spinand_manufacturer,
> +	&toshiba_spinand_manufacturer,
>  	&winbond_spinand_manufacturer,
>  };
>  
> diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
> new file mode 100644
> index 0000000..294bcf6
> --- /dev/null
> +++ b/drivers/mtd/nand/spi/toshiba.c
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 exceet electronics GmbH
> + * Copyright (c) 2018 Kontron Electronics GmbH
> + *
> + * Author: Frieder Schrempf <frieder.schrempf@kontron.de>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/mtd/spinand.h>
> +
> +#define SPINAND_MFR_TOSHIBA		0x98
> +
> +static SPINAND_OP_VARIANTS(read_cache_variants,
> +		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(write_cache_variants,
> +		SPINAND_PROG_LOAD(true, 0, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(update_cache_variants,
> +		SPINAND_PROG_LOAD(false, 0, NULL, 0));
> +
> +static int tc58cvg2s0h_ooblayout_ecc(struct mtd_info *mtd, int section,
> +				     struct mtd_oob_region *region)
> +{
> +	if (section > 7)
> +		return -ERANGE;
> +
> +	region->offset = 128 + 16 * section;
> +	region->length = 16;
> +
> +
> +	return 0;
> +}
> +
> +static int tc58cvg2s0h_ooblayout_free(struct mtd_info *mtd, int section,
> +				      struct mtd_oob_region *region)
> +{
> +	if (section > 7)
> +		return -ERANGE;
> +
> +	region->offset = 2 + 16 * section;
> +	region->length = 14;
> +
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops tc58cvg2s0h_ooblayout = {
> +	.ecc = tc58cvg2s0h_ooblayout_ecc,
> +	.free = tc58cvg2s0h_ooblayout_free,
> +};
> +
> +static int tc58cvg2s0h_ecc_get_status(struct spinand_device *spinand,
> +				      u8 status)
> +{
> +	struct nand_device *nand = spinand_to_nand(spinand);
> +	u8 mbf = 0;
> +	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, &mbf);
> +
> +	switch (status & STATUS_ECC_MASK) {
> +	case STATUS_ECC_NO_BITFLIPS:
> +		return 0;
> +
> +	case STATUS_ECC_UNCOR_ERROR:
> +		return -EBADMSG;
> +
> +	case STATUS_ECC_HAS_BITFLIPS:
> +		/*
> +		 * Let's try to retrieve the real maximum number of bitflips
> +		 * in order to avoid forcing the wear-leveling layer to move
> +		 * data around if it's not necessary.
> +		 */
> +		if (spi_mem_exec_op(spinand->spimem, &op))
> +			return nand->eccreq.strength;
> +
> +		mbf >>= 4;
> +
> +		if (WARN_ON(mbf > nand->eccreq.strength || !mbf))
> +			return nand->eccreq.strength;
> +
> +		return mbf;
> +
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct spinand_info toshiba_spinand_table[] = {
> +	SPINAND_INFO("TC58CVG2S0H", 0xCD,
> +		     NAND_MEMORG(1, 4096, 256, 64, 2048, 1, 1, 1),
> +		     NAND_ECCREQ(8, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     SPINAND_HAS_QE_BIT,
> +		     SPINAND_ECCINFO(&tc58cvg2s0h_ooblayout,
> +				     tc58cvg2s0h_ecc_get_status)),
> +};
> +
> +static int toshiba_spinand_detect(struct spinand_device *spinand)
> +{
> +	u8 *id = spinand->id.data;
> +	int ret;
> +
> +	/*
> +	 * Toshiba SPI NAND read ID needs a dummy byte,
> +	 * so the first byte in id is garbage.
> +	 */
> +	if (id[1] != SPINAND_MFR_TOSHIBA)
> +		return 0;
> +
> +	ret = spinand_match_and_init(spinand, toshiba_spinand_table,
> +				     ARRAY_SIZE(toshiba_spinand_table),
> +				     id[2]);
> +	if (ret)
> +		return ret;
> +
> +	return 1;
> +}
> +
> +static const struct spinand_manufacturer_ops toshiba_spinand_manuf_ops = {
> +	.detect = toshiba_spinand_detect,
> +};
> +
> +const struct spinand_manufacturer toshiba_spinand_manufacturer = {
> +	.id = SPINAND_MFR_TOSHIBA,
> +	.name = "Toshiba",
> +	.ops = &toshiba_spinand_manuf_ops,
> +};
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index 088ff96..816c4b0 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -196,6 +196,7 @@ struct spinand_manufacturer {
>  /* SPI NAND manufacturers */
>  extern const struct spinand_manufacturer macronix_spinand_manufacturer;
>  extern const struct spinand_manufacturer micron_spinand_manufacturer;
> +extern const struct spinand_manufacturer toshiba_spinand_manufacturer;
>  extern const struct spinand_manufacturer winbond_spinand_manufacturer;
>  
>  /**

