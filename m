Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E07C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B6025F68
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B6025F68
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965629AbeF0PXH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:23:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44110 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934324AbeF0PXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:23:02 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BDE6420DD1; Wed, 27 Jun 2018 17:22:59 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-87-188.w90-88.abo.wanadoo.fr [90.88.29.188])
        by mail.bootlin.com (Postfix) with ESMTPSA id 442B2208B3;
        Wed, 27 Jun 2018 17:22:49 +0200 (CEST)
Date:   Wed, 27 Jun 2018 17:22:49 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc:     <boris.brezillon@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <f.fainelli@gmail.com>,
        <mmayer@broadcom.com>, <rogerq@ti.com>, <ladis@linux-mips.org>,
        <ada@thorsis.com>, <honghui.zhang@mediatek.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nagasureshkumarrelli@gmail.com>, <michals@xilinx.com>
Subject: Re: [[LINUX PATCH v10] 4/4] mtd: rawnand: pl353: Add basic driver
 for arm pl353 smc nand interface
Message-ID: <20180627172249.72f878a2@xps13>
In-Reply-To: <1529563351-2241-5-git-send-email-naga.sureshkumar.relli@xilinx.com>
References: <1529563351-2241-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1529563351-2241-5-git-send-email-naga.sureshkumar.relli@xilinx.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naga,

This is not an issue at all but I think [PATCH vX Y/Z] is a preferred
and shorter suffix, you can create it automatically by using

        git format-patch -v X <first_commit>^..<last_commit> --cover-letter


On Thu, 21 Jun 2018 12:12:31 +0530, Naga Sureshkumar Relli
<naga.sureshkumar.relli@xilinx.com> wrote:

> Add driver for arm pl353 static memory controller nand interface with HW ECC
> support. This controller is used in Xilinx Zynq SoC for interfacing the NAND
> flash memory.
> 
> Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> ---
> Changes in 10:
>  - Typos correction like nand to NAND and soc to SOC etc..
>  - Defined macros for the values in pl353_nand_calculate_hwecc()
>  - Modifed ecc_status from int to char in pl353_nand_calculate_hwecc()
>  - Changed the return type form int to bool to the function
>    onehot()
>  - Removed udelay(1000) in pl353_cmd_function, as it is not required
>  - Dropped ecc->hwctl = NULL in pl353_ecc_init()
>  - Added an error message in pl353_ecc_init(), when there is no matching
>    oobsize
>  - Changed the variable from xnand to xnfc
>  - Added logic to get mtd->name from DT, if it is specified in DT
> Changes in v9:
>  - Addressed the below comments given by Miquel
>  - instead of using pl353_nand_write32, use directly writel_relaxed
>  - Fixed check patch warnings
>  - Renamed write_buf/read_buf to write_data_op/read_data_op
>  - use BIT macro instead of 1 << nr
>  - Use NAND_ROW_ADDR_3 flag
>  - Use nand_wait_ready()
>  - Removed swecc functions
>  - Use address cycles as per size, instead of reading it from Parameter page
>  - Instead of writing too many patterns, use optional property
> Changes in v8:
>  - Added exec_op() implementation
>  - Fixed the below v7 review comments
>  - removed mtd_info from pl353_nand_info struct
>  - Corrected ecc layout offsets
>  - Added on-die ecc support
> Changes in v7:
>  - Currently not implemented the memclk rate adjustments. I will
>    look into this later and once the basic driver is accepted.
>  - Fixed GPL licence ident
> Changes in v6:
>  - Fixed the checkpatch.pl reported warnings
>  - Using the address cycles information from the onfi param page
>    earlier it is hardcoded to 5 in driver
> Changes in v5:
>  - Configure the nand timing parameters as per the onfi spec Changes in v4:
>  - Updated the driver to sync with pl353_smc driver APIs
> Changes in v3:
>  - implemented the proper error codes
>  - further breakdown this patch to multiple sets
>  - added the controller and driver details to Documentation section
>  - updated the licenece to GPLv2
>  - reorganized the pl353_nand_ecc_init function
> Changes in v2:
>  - use "depends on" rather than "select" option in kconfig
>  - remove unused variable parts
> ---
>  drivers/mtd/nand/raw/Kconfig      |    7 +
>  drivers/mtd/nand/raw/Makefile     |    1 +
>  drivers/mtd/nand/raw/pl353_nand.c | 1309 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 1317 insertions(+)
>  create mode 100644 drivers/mtd/nand/raw/pl353_nand.c
> 
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index 6871ff0..1c5d528 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -530,4 +530,11 @@ config MTD_NAND_MTK
>  	  Enables support for NAND controller on MTK SoCs.
>  	  This controller is found on mt27xx, mt81xx, mt65xx SoCs.
>  
> +config MTD_NAND_PL353
> +	tristate "ARM Pl353 NAND flash driver"
> +	depends on MTD_NAND && ARM
> +	depends on PL353_SMC
> +	help
> +	  Enables support for PrimeCell Static Memory Controller PL353.
> +
>  endif # MTD_NAND
> diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
> index 165b7ef..1c702e1 100644
> --- a/drivers/mtd/nand/raw/Makefile
> +++ b/drivers/mtd/nand/raw/Makefile
> @@ -56,6 +56,7 @@ obj-$(CONFIG_MTD_NAND_HISI504)	        += hisi504_nand.o
>  obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= brcmnand/
>  obj-$(CONFIG_MTD_NAND_QCOM)		+= qcom_nandc.o
>  obj-$(CONFIG_MTD_NAND_MTK)		+= mtk_ecc.o mtk_nand.o
> +obj-$(CONFIG_MTD_NAND_PL353)		+= pl353_nand.o
>  
>  nand-objs := nand_base.o nand_bbt.o nand_timings.o nand_ids.o
>  nand-objs += nand_amd.o
> diff --git a/drivers/mtd/nand/raw/pl353_nand.c b/drivers/mtd/nand/raw/pl353_nand.c
> new file mode 100644
> index 0000000..3a0acbd
> --- /dev/null
> +++ b/drivers/mtd/nand/raw/pl353_nand.c
> @@ -0,0 +1,1309 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ARM PL353 NAND flash controller driver
> + *
> + * Copyright (C) 2017 Xilinx, Inc
> + * Author: Punnaiah chowdary kalluri <punnaiah@xilinx.com>
> + * Author: Naga Sureshkumar Relli <nagasure@xilinx.com>
> + *
> + */
> +
> +#include <linux/err.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/irq.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/rawnand.h>
> +#include <linux/mtd/nand_ecc.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/pl353-smc.h>
> +#include <linux/clk.h>
> +
> +#define PL353_NAND_DRIVER_NAME "pl353-nand"
> +
> +/* NAND flash driver defines */
> +#define PL353_NAND_CMD_PHASE	1	/* End command valid in command phase */
> +#define PL353_NAND_DATA_PHASE	2	/* End command valid in data phase */
> +#define PL353_NAND_ECC_SIZE	512	/* Size of data for ECC operation */
> +
> +/* Flash memory controller operating parameters */
> +
> +#define PL353_NAND_ECC_CONFIG	(BIT(4)  |	/* ECC read at end of page */ \
> +				 (0 << 5))	/* No Jumping */
> +
> +/* AXI Address definitions */
> +#define START_CMD_SHIFT		3
> +#define END_CMD_SHIFT		11
> +#define END_CMD_VALID_SHIFT	20
> +#define ADDR_CYCLES_SHIFT	21
> +#define CLEAR_CS_SHIFT		21
> +#define ECC_LAST_SHIFT		10
> +#define COMMAND_PHASE		(0 << 19)
> +#define DATA_PHASE		BIT(19)
> +
> +#define PL353_NAND_ECC_LAST	BIT(ECC_LAST_SHIFT)	/* Set ECC_Last */
> +#define PL353_NAND_CLEAR_CS	BIT(CLEAR_CS_SHIFT)	/* Clear chip select */
> +
> +#define ONDIE_ECC_FEATURE_ADDR	0x90
> +#define PL353_NAND_ECC_BUSY_TIMEOUT	(1 * HZ)
> +#define PL353_NAND_DEV_BUSY_TIMEOUT	(1 * HZ)
> +#define PL353_NAND_LAST_TRANSFER_LENGTH	4
> +#define PL353_NAND_ECC_VALID_SHIFT	24
> +#define PL353_NAND_ECC_VALID_MASK	0x40
> +
> +struct pl353_nfc_op {
> +	u32 cmnds[4];
> +	u32 thirdrow;
> +	u32 type;
> +	u32 end_cmd;
> +	u32 addrs;
> +	bool wait;
> +	u32 len;
> +	u32 naddrs;
> +	unsigned int data_instr_idx;
> +	const struct nand_op_instr *data_instr;
> +	unsigned int rdy_timeout_ms;
> +	unsigned int rdy_delay_ns;
> +	unsigned int data_delay_ns;
> +	unsigned int cle_ale_delay_ns;
> +	u32 addr5;
> +	u32 addr6;
> +};
> +
> +/**
> + * struct pl353_nand_info - Defines the NAND flash driver instance
> + * @chip:		NAND chip information structure
> + * @nand_base:		Virtual address of the NAND flash device
> + * @end_cmd_pending:	End command is pending
> + * @end_cmd:		End command
> + * @row_addr_cycles:	Row address cycles
> + * @col_addr_cycles:	Column address cycles
> + * @address:		Page address
> + * @cmd_pending:	More command is needed

I'm still not ok with this structure.

The NAND controller entries must be separated from the NAND chip's. You
can get some inspiration from marvell_nand.c or sunxi_nand.c.

> + */
> +struct pl353_nand_info {
> +	struct nand_chip chip;
> +	struct device *dev;
> +	void __iomem *nand_base;
> +	unsigned long end_cmd_pending;
> +	unsigned long end_cmd;
> +	u8 addr_cycles;
> +	u32 address;
> +	u32 cmd_pending;
> +	struct completion complete;
> +	struct clk *mclk;
> +

Extra space

> +};
> +
> +static int pl353_ecc_ooblayout16_ecc(struct mtd_info *mtd, int section,
> +				     struct mtd_oob_region *oobregion)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +
> +	if (section >= chip->ecc.steps)
> +		return -ERANGE;
> +
> +	oobregion->offset = (section * chip->ecc.bytes);
> +	oobregion->length = chip->ecc.bytes;
> +
> +	return 0;
> +}
> +
> +static int pl353_ecc_ooblayout16_free(struct mtd_info *mtd, int section,
> +				      struct mtd_oob_region *oobregion)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +
> +	if (section >= chip->ecc.steps)
> +		return -ERANGE;
> +
> +	oobregion->offset = (section * chip->ecc.bytes) + 8;
> +	oobregion->length = 8;
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops pl353_ecc_ooblayout16_ops = {
> +	.ecc = pl353_ecc_ooblayout16_ecc,
> +	.free = pl353_ecc_ooblayout16_free,
> +};
> +
> +static int pl353_ecc_ooblayout64_ecc(struct mtd_info *mtd, int section,
> +				     struct mtd_oob_region *oobregion)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +
> +	if (section >= chip->ecc.steps)
> +		return -ERANGE;
> +
> +	oobregion->offset = (section * chip->ecc.bytes) + 52;
> +	oobregion->length = chip->ecc.bytes;
> +
> +	return 0;
> +}
> +
> +static int pl353_ecc_ooblayout64_free(struct mtd_info *mtd, int section,
> +				      struct mtd_oob_region *oobregion)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +
> +	if (section)
> +		return -ERANGE;
> +
> +	if (section >= chip->ecc.steps)
> +		return -ERANGE;
> +
> +	oobregion->offset = (section * chip->ecc.bytes) + 2;
> +	oobregion->length = 50;
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops pl353_ecc_ooblayout64_ops = {
> +	.ecc = pl353_ecc_ooblayout64_ecc,
> +	.free = pl353_ecc_ooblayout64_free,
> +};
> +
> +/* Generic flash bbt decriptors */
> +static u8 bbt_pattern[] = { 'B', 'b', 't', '0' };
> +static u8 mirror_pattern[] = { '1', 't', 'b', 'B' };
> +
> +static struct nand_bbt_descr bbt_main_descr = {
> +	.options = NAND_BBT_LASTBLOCK | NAND_BBT_CREATE | NAND_BBT_WRITE
> +		| NAND_BBT_2BIT | NAND_BBT_VERSION | NAND_BBT_PERCHIP,
> +	.offs = 4,
> +	.len = 4,
> +	.veroffs = 20,
> +	.maxblocks = 4,
> +	.pattern = bbt_pattern
> +};
> +
> +static struct nand_bbt_descr bbt_mirror_descr = {
> +	.options = NAND_BBT_LASTBLOCK | NAND_BBT_CREATE | NAND_BBT_WRITE
> +		| NAND_BBT_2BIT | NAND_BBT_VERSION | NAND_BBT_PERCHIP,
> +	.offs = 4,
> +	.len = 4,
> +	.veroffs = 20,
> +	.maxblocks = 4,
> +	.pattern = mirror_pattern
> +};
> +
> +/**
> + * pl353_nand_read_data_op - read chip data into buffer
> + * @chip:	Pointer to the NAND chip info structure
> + * @in:		Pointer to the buffer to store read data
> + * @len:	Number of bytes to read
> + * Return:	Always return zero
> + */
> +static int pl353_nand_read_data_op(struct nand_chip *chip,
> +				   u8 *in,
> +				   unsigned int len)
> +{
> +	int i;
> +
> +	if (IS_ALIGNED((uint32_t)in, sizeof(uint32_t)) &&
> +	    IS_ALIGNED(len, sizeof(uint32_t))) {
> +		u32 *ptr = (u32 *)in;
> +
> +		len /= 4;
> +		for (i = 0; i < len; i++)
> +			ptr[i] = readl(chip->IO_ADDR_R);

Please do not use IO_ADDR_R/W, these chip structure entries are
deprecated and might be removed anytime soon. Removing them will
simplify a lot all the functions where you do kind of unreadable pointer
operations around these value. This is really bad and I already told
you about it.

Please fix this and then I'll review the rest.

> +	} else {
> +		for (i = 0; i < len; i++)
> +			in[i] = readb(chip->IO_ADDR_R);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * pl353_nand_write_buf - write buffer to chip
> + * @mtd:	Pointer to the mtd info structure
> + * @buf:	Pointer to the buffer to store write data
> + * @len:	Number of bytes to write
> + */
> +static void pl353_nand_write_data_op(struct mtd_info *mtd, const u8 *buf,
> +				     int len)
> +{
> +	int i;
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +
> +	if (IS_ALIGNED((uint32_t)buf, sizeof(uint32_t)) &&
> +	    IS_ALIGNED(len, sizeof(uint32_t))) {
> +		u32 *ptr = (u32 *)buf;
> +
> +		len /= 4;
> +		for (i = 0; i < len; i++)
> +			writel(ptr[i], chip->IO_ADDR_W);
> +	} else {
> +		for (i = 0; i < len; i++)
> +			writeb(buf[i], chip->IO_ADDR_W);
> +	}
> +}
> +
> +/**
> + * pl353_nand_calculate_hwecc - Calculate Hardware ECC
> + * @mtd:	Pointer to the mtd_info structure
> + * @data:	Pointer to the page data
> + * @ecc:	Pointer to the ECC buffer where ECC data needs to be stored
> + *
> + * This function retrieves the Hardware ECC data from the controller and returns
> + * ECC data back to the MTD subsystem.
> + *
> + * Return:	0 on success or error value on failure
> + */
> +static int pl353_nand_calculate_hwecc(struct mtd_info *mtd,
> +				      const u8 *data, u8 *ecc)
> +{
> +	u32 ecc_value;
> +	u8 ecc_reg, ecc_byte, ecc_status;
> +	unsigned long timeout = jiffies + PL353_NAND_ECC_BUSY_TIMEOUT;

New line

> +	/* Wait till the ECC operation is complete or timeout */
> +	do {
> +		if (pl353_smc_ecc_is_busy())
> +			cpu_relax();
> +		else
> +			break;
> +	} while (!time_after_eq(jiffies, timeout));
> +
> +	if (time_after_eq(jiffies, timeout)) {
> +		pr_err("%s timed out\n", __func__);
> +		return -ETIMEDOUT;
> +	}
> +
> +	for (ecc_reg = 0; ecc_reg < 4; ecc_reg++) {
> +		/* Read ECC value for each block */
> +		ecc_value = pl353_smc_get_ecc_val(ecc_reg);
> +		ecc_status = (ecc_value >> PL353_NAND_ECC_VALID_SHIFT);
> +		/* ECC value valid */
> +		if (ecc_status & PL353_NAND_ECC_VALID_MASK) {
> +			for (ecc_byte = 0; ecc_byte < 3; ecc_byte++) {
> +				/* Copy ECC bytes to MTD buffer */
> +				*ecc = ~ecc_value & 0xFF;
> +				ecc_value = ecc_value >> 8;
> +				ecc++;
> +			}
> +		} else {
> +			pr_warn("%s status failed\n", __func__);
> +			return -1;
> +		}
> +	}

New line

> +	return 0;
> +}
> +
> +/**
> + * onehot - onehot function
> + * @value:	Value to check for onehot
> + *
> + * This function checks whether a value is onehot or not.
> + * onehot is if and only if onebit is set.
> + *
> + * Return:	1 if it is onehot else 0
> + */
> +static bool onehot(unsigned short value)
> +{
> +	return (value & (value - 1)) == 0;

Please use something from bitmap.c or bitops.h to do this.

> +}
> +
> +/**
> + * pl353_nand_correct_data - ECC correction function
> + * @mtd:	Pointer to the mtd_info structure
> + * @buf:	Pointer to the page data
> + * @read_ecc:	Pointer to the ECC value read from spare data area
> + * @calc_ecc:	Pointer to the calculated ECC value
> + *
> + * This function corrects the ECC single bit errors & detects 2-bit errors.
> + *
> + * Return:	0 if no ECC errors found
> + *		1 if single bit error found and corrected.
> + *		-1 if multiple uncorrectable ECC errors found.
> + */
> +static int pl353_nand_correct_data(struct mtd_info *mtd, unsigned char *buf,
> +				   unsigned char *read_ecc,
> +				   unsigned char *calc_ecc)
> +{
> +	unsigned char bit_addr;
> +	unsigned int byte_addr;
> +	unsigned short ecc_odd, ecc_even, read_ecc_lower, read_ecc_upper;
> +	unsigned short calc_ecc_lower, calc_ecc_upper;
> +
> +	read_ecc_lower = (read_ecc[0] | (read_ecc[1] << 8)) & 0xfff;
> +	read_ecc_upper = ((read_ecc[1] >> 4) | (read_ecc[2] << 4)) & 0xfff;
> +
> +	calc_ecc_lower = (calc_ecc[0] | (calc_ecc[1] << 8)) & 0xfff;
> +	calc_ecc_upper = ((calc_ecc[1] >> 4) | (calc_ecc[2] << 4)) & 0xfff;
> +
> +	ecc_odd = read_ecc_lower ^ calc_ecc_lower;
> +	ecc_even = read_ecc_upper ^ calc_ecc_upper;
> +
> +	/* no error */
> +	if (!ecc_odd && !ecc_even)
> +		return 0;
> +
> +	if (ecc_odd == (~ecc_even & 0xfff)) {
> +		/* bits [11:3] of error code is byte offset */
> +		byte_addr = (ecc_odd >> 3) & 0x1ff;

You might want to define these values.

> +		/* bits [2:0] of error code is bit offset */
> +		bit_addr = ecc_odd & 0x7;

Same here.

> +		/* Toggling error bit */
> +		buf[byte_addr] ^= (BIT(bit_addr));
> +		return 1;
> +	}

New line

> +	/* one error in parity */
> +	if (onehot(ecc_odd | ecc_even) == 1)
> +		return 1;
> +
> +	/* Uncorrectable error */
> +	return -1;
> +}
> +
> +static int pl353_dev_timeout(struct mtd_info *mtd, struct nand_chip *chip,
> +			     unsigned long timeout)
> +{
> +	if (timeout)
> +		timeout = jiffies + msecs_to_jiffies(timeout);
> +	else
> +		timeout = jiffies + PL353_NAND_DEV_BUSY_TIMEOUT;
> +
> +	do {
> +		if (chip->dev_ready(mtd))
> +			break;
> +		cpu_relax();
> +	} while (!time_after_eq(jiffies, timeout));

Isn't this a nand_wait_ready() equivalent?

> +
> +	if (time_after_eq(jiffies, timeout)) {
> +		pr_err("%s timed out\n", __func__);
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static void pl353_prepare_cmd(struct mtd_info *mtd, struct nand_chip *chip,
> +			      int page, int column, int start_cmd, int end_cmd,
> +			      bool read)
> +{
> +	unsigned long data_phase_addr;
> +	u32 end_cmd_valid = 0;
> +	void __iomem *cmd_addr;
> +	unsigned long cmd_phase_addr = 0, cmd_data = 0;
> +
> +	struct pl353_nand_info *xnfc =
> +		container_of(chip, struct pl353_nand_info, chip);
> +
> +	end_cmd_valid = read ? 1 : 0;
> +
> +	cmd_phase_addr = (unsigned long __force)xnfc->nand_base +
> +			 ((xnfc->addr_cycles
> +			 << ADDR_CYCLES_SHIFT) |
> +			 (end_cmd_valid << END_CMD_VALID_SHIFT) |
> +			 (COMMAND_PHASE) |
> +			 (end_cmd << END_CMD_SHIFT) |
> +			 (start_cmd << START_CMD_SHIFT));
> +	cmd_addr = (void __iomem * __force)cmd_phase_addr;
> +
> +	/* Get the data phase address */
> +	data_phase_addr = (unsigned long __force)xnfc->nand_base +
> +			  ((0x0 << CLEAR_CS_SHIFT) |
> +			  (0 << END_CMD_VALID_SHIFT) |
> +			  (DATA_PHASE) |
> +			  (end_cmd << END_CMD_SHIFT) |
> +			  (0x0 << ECC_LAST_SHIFT));
> +
> +	chip->IO_ADDR_R = (void __iomem * __force)data_phase_addr;
> +	chip->IO_ADDR_W = chip->IO_ADDR_R;
> +	if (chip->options & NAND_BUSWIDTH_16)
> +		column /= 2;
> +	cmd_data = column;
> +	if (mtd->writesize > PL353_NAND_ECC_SIZE) {
> +		cmd_data |= page << 16;
> +		/* Another address cycle for devices > 128MiB */
> +		if (chip->options & NAND_ROW_ADDR_3) {
> +			writel_relaxed(cmd_data, cmd_addr);
> +			cmd_data = (page >> 16);
> +		}
> +	} else {
> +		cmd_data |= page << 8;
> +	}
> +
> +	writel_relaxed(cmd_data, cmd_addr);
> +}
> +
> +/**
> + * pl353_nand_read_oob - [REPLACEABLE] the most common OOB data read function
> + * @mtd:	Pointer to the mtd info structure
> + * @chip:	Pointer to the NAND chip info structure
> + * @page:	Page number to read
> + *
> + * Return:	Always return zero
> + */
> +static int pl353_nand_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
> +			       int page)
> +{
> +	unsigned long data_phase_addr;
> +	u8 *p;
> +	struct pl353_nand_info *xnfc =
> +		container_of(chip, struct pl353_nand_info, chip);
> +	unsigned long nand_offset = (unsigned long __force)xnfc->nand_base;
> +
> +	chip->pagebuf = -1;
> +	if (mtd->writesize < PL353_NAND_ECC_SIZE)
> +		return 0;
> +
> +	pl353_prepare_cmd(mtd, chip, page, mtd->writesize, NAND_CMD_READ0,
> +			  NAND_CMD_READSTART, 1);
> +
> +	ndelay(100);
> +	pl353_dev_timeout(mtd, chip, 0);
> +
> +	p = chip->oob_poi;
> +	pl353_nand_read_data_op(chip, p,
> +				(mtd->oobsize -
> +				PL353_NAND_LAST_TRANSFER_LENGTH));
> +	p += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +	data_phase_addr = (unsigned long __force)chip->IO_ADDR_R;
> +	data_phase_addr -= nand_offset;
> +	data_phase_addr |= PL353_NAND_CLEAR_CS;
> +	data_phase_addr += nand_offset;
> +	chip->IO_ADDR_R = (void __iomem * __force)data_phase_addr;
> +	pl353_nand_read_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	return 0;
> +}
> +
> +/**
> + * pl353_nand_write_oob - [REPLACEABLE] the most common OOB data write function
> + * @mtd:	Pointer to the mtd info structure
> + * @chip:	Pointer to the NAND chip info structure
> + * @page:	Page number to write
> + *
> + * Return:	Zero on success and EIO on failure
> + */
> +static int pl353_nand_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
> +				int page)
> +{
> +	const u8 *buf = chip->oob_poi;
> +	unsigned long data_phase_addr;
> +	struct pl353_nand_info *xnfc =
> +		container_of(chip, struct pl353_nand_info, chip);
> +	unsigned long nand_offset = (unsigned long __force)xnfc->nand_base;
> +	u32 addrcycles = 0;
> +
> +	chip->pagebuf = -1;
> +	addrcycles = xnfc->addr_cycles;
> +	pl353_prepare_cmd(mtd, chip, page, mtd->writesize, NAND_CMD_SEQIN,
> +			  NAND_CMD_PAGEPROG, 0);
> +	ndelay(100);
> +	pl353_nand_write_data_op(mtd, buf,
> +				 (mtd->oobsize -
> +				 PL353_NAND_LAST_TRANSFER_LENGTH));
> +	buf += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	data_phase_addr = (unsigned long __force)chip->IO_ADDR_W;
> +	data_phase_addr -= nand_offset;
> +	data_phase_addr |= PL353_NAND_CLEAR_CS;
> +	data_phase_addr |= (1 << END_CMD_VALID_SHIFT);
> +	data_phase_addr += nand_offset;
> +	chip->IO_ADDR_W = (void __iomem * __force)data_phase_addr;
> +	pl353_nand_write_data_op(mtd, buf, PL353_NAND_LAST_TRANSFER_LENGTH);
> +	nand_wait_ready(mtd);
> +
> +	return 0;
> +}
> +
> +/**
> + * pl353_nand_read_page_raw - [Intern] read raw page data without ecc
> + * @mtd:		Pointer to the mtd info structure
> + * @chip:		Pointer to the NAND chip info structure
> + * @buf:		Pointer to the data buffer
> + * @oob_required:	Caller requires OOB data read to chip->oob_poi
> + * @page:		Page number to read
> + *
> + * Return:	Always return zero
> + */
> +static int pl353_nand_read_page_raw(struct mtd_info *mtd,
> +				    struct nand_chip *chip,
> +				    u8 *buf, int oob_required, int page)
> +{
> +	unsigned long data_phase_addr;
> +	u8 *p;
> +	struct pl353_nand_info *xnfc =
> +		container_of(chip, struct pl353_nand_info, chip);
> +	unsigned long nand_offset = (unsigned long __force)xnfc->nand_base;
> +
> +	pl353_nand_read_data_op(chip, buf, mtd->writesize);
> +	p = chip->oob_poi;
> +	pl353_nand_read_data_op(chip, p,
> +				(mtd->oobsize -
> +				PL353_NAND_LAST_TRANSFER_LENGTH));
> +	p += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	data_phase_addr = (unsigned long __force)chip->IO_ADDR_R;
> +	data_phase_addr -= nand_offset;
> +	data_phase_addr |= PL353_NAND_CLEAR_CS;
> +	data_phase_addr += nand_offset;
> +	chip->IO_ADDR_R = (void __iomem * __force)data_phase_addr;
> +
> +	pl353_nand_read_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	return 0;
> +}
> +
> +/**
> + * pl353_nand_write_page_raw - [Intern] raw page write function
> + * @mtd:		Pointer to the mtd info structure
> + * @chip:		Pointer to the NAND chip info structure
> + * @buf:		Pointer to the data buffer
> + * @oob_required:	Caller requires OOB data read to chip->oob_poi
> + * @page:		Page number to write
> + *
> + * Return:	Always return zero
> + */
> +static int pl353_nand_write_page_raw(struct mtd_info *mtd,
> +				     struct nand_chip *chip,
> +				     const u8 *buf, int oob_required,
> +				     int page)
> +{
> +	unsigned long data_phase_addr;
> +	u8 *p;
> +
> +	struct pl353_nand_info *xnfc =
> +		container_of(chip, struct pl353_nand_info, chip);
> +	unsigned long nand_offset = (unsigned long __force)xnfc->nand_base;
> +
> +	pl353_nand_write_data_op(mtd, buf, mtd->writesize);
> +	p = chip->oob_poi;
> +	pl353_nand_write_data_op(mtd, p,
> +				 (mtd->oobsize -
> +				 PL353_NAND_LAST_TRANSFER_LENGTH));
> +	p += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	data_phase_addr = (unsigned long __force)chip->IO_ADDR_W;
> +	data_phase_addr -= nand_offset;
> +	data_phase_addr |= PL353_NAND_CLEAR_CS;
> +	data_phase_addr |= (1 << END_CMD_VALID_SHIFT);
> +	data_phase_addr += nand_offset;
> +	chip->IO_ADDR_W = (void __iomem * __force)data_phase_addr;
> +
> +	pl353_nand_write_data_op(mtd, p, PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	return 0;
> +}
> +
> +/**
> + * nand_write_page_hwecc - Hardware ECC based page write function
> + * @mtd:		Pointer to the mtd info structure
> + * @chip:		Pointer to the NAND chip info structure
> + * @buf:		Pointer to the data buffer
> + * @oob_required:	Caller requires OOB data read to chip->oob_poi
> + * @page:		Page number to write
> + *
> + * This functions writes data and hardware generated ECC values in to the page.
> + *
> + * Return:	Always return zero
> + */
> +static int pl353_nand_write_page_hwecc(struct mtd_info *mtd,
> +				       struct nand_chip *chip,
> +				       const u8 *buf, int oob_required,
> +				       int page)
> +{
> +	int eccsize = chip->ecc.size;
> +	int eccsteps = chip->ecc.steps;
> +	u8 *ecc_calc = chip->ecc.calc_buf;
> +	u8 *oob_ptr;
> +	const u8 *p = buf;
> +	u32 ret;
> +	unsigned long data_phase_addr;
> +	struct pl353_nand_info *xnfc =
> +		container_of(chip, struct pl353_nand_info, chip);
> +	unsigned long nand_offset = (unsigned long __force)xnfc->nand_base;
> +
> +	pl353_prepare_cmd(mtd, chip, page, 0, NAND_CMD_SEQIN,
> +			  NAND_CMD_PAGEPROG, 0);
> +	ndelay(100);
> +	for ( ; (eccsteps - 1); eccsteps--) {
> +		pl353_nand_write_data_op(mtd, p, eccsize);
> +		p += eccsize;
> +	}
> +	pl353_nand_write_data_op(mtd, p,
> +				 (eccsize - PL353_NAND_LAST_TRANSFER_LENGTH));
> +	p += (eccsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	/* Set ECC Last bit to 1 */
> +	data_phase_addr = (unsigned long __force)chip->IO_ADDR_W;
> +	data_phase_addr -= nand_offset;
> +	data_phase_addr |= PL353_NAND_ECC_LAST;
> +	data_phase_addr += nand_offset;
> +	chip->IO_ADDR_W = (void __iomem * __force)data_phase_addr;
> +	pl353_nand_write_data_op(mtd, p, PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	p = buf;
> +	chip->ecc.calculate(mtd, p, &ecc_calc[0]);
> +
> +	/* Wait for ECC to be calculated and read the error values */
> +	ret = mtd_ooblayout_set_eccbytes(mtd, ecc_calc, chip->oob_poi,
> +					 0, chip->ecc.total);
> +	if (ret)
> +		return ret;
> +	/* Clear ECC last bit */
> +	data_phase_addr = (unsigned long __force)chip->IO_ADDR_W;
> +	data_phase_addr -= nand_offset;
> +	data_phase_addr &= ~PL353_NAND_ECC_LAST;
> +	data_phase_addr += nand_offset;
> +	chip->IO_ADDR_W = (void __iomem * __force)data_phase_addr;
> +
> +	/* Write the spare area with ECC bytes */
> +	oob_ptr = chip->oob_poi;
> +	pl353_nand_write_data_op(mtd, oob_ptr,
> +				 (mtd->oobsize -
> +				 PL353_NAND_LAST_TRANSFER_LENGTH));
> +
> +	data_phase_addr = (unsigned long __force)chip->IO_ADDR_W;
> +	data_phase_addr -= nand_offset;
> +	data_phase_addr |= PL353_NAND_CLEAR_CS;
> +	data_phase_addr |= (1 << END_CMD_VALID_SHIFT);
> +	data_phase_addr += nand_offset;
> +	chip->IO_ADDR_W = (void __iomem * __force)data_phase_addr;
> +	oob_ptr += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +	pl353_nand_write_data_op(mtd, oob_ptr, PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	/*
> +	 * Apply this short delay always to ensure that we do wait tWB in any
> +	 * case on any machine.
> +	 */
> +	ndelay(100);

Please use sdr timings tWB_min value

> +	nand_wait_ready(mtd);
> +
> +	return 0;
> +}
> +
> +/**
> + * pl353_nand_read_page_hwecc - Hardware ECC based page read function
> + * @mtd:		Pointer to the mtd info structure
> + * @chip:		Pointer to the NAND chip info structure
> + * @buf:		Pointer to the buffer to store read data
> + * @oob_required:	Caller requires OOB data read to chip->oob_poi
> + * @page:		Page number to read
> + *
> + * This functions reads data and checks the data integrity by comparing hardware
> + * generated ECC values and read ECC values from spare area.
> + *
> + * Return:	0 always and updates ECC operation status in to MTD structure
> + */
> +static int pl353_nand_read_page_hwecc(struct mtd_info *mtd,
> +				      struct nand_chip *chip,
> +				      u8 *buf, int oob_required, int page)
> +{
> +	int i, stat, eccsize = chip->ecc.size;
> +	int eccbytes = chip->ecc.bytes;
> +	int eccsteps = chip->ecc.steps;
> +	u8 *p = buf;
> +	u8 *ecc_calc = chip->ecc.calc_buf;
> +	u8 *ecc = chip->ecc.code_buf;
> +	unsigned int max_bitflips = 0;
> +	u8 *oob_ptr;
> +	u32 ret;
> +	unsigned long data_phase_addr;
> +	struct pl353_nand_info *xnfc =
> +		container_of(chip, struct pl353_nand_info, chip);
> +	unsigned long nand_offset = (unsigned long __force)xnfc->nand_base;
> +
> +	pl353_prepare_cmd(mtd, chip, page, 0, NAND_CMD_READ0,
> +			  NAND_CMD_READSTART, 1);
> +	ndelay(100);

What is this delay for?

> +	pl353_dev_timeout(mtd, chip, 0);
> +
> +	for ( ; (eccsteps - 1); eccsteps--) {
> +		pl353_nand_read_data_op(chip, p, eccsize);
> +		p += eccsize;
> +	}
> +	pl353_nand_read_data_op(chip, p,
> +				(eccsize - PL353_NAND_LAST_TRANSFER_LENGTH));
> +	p += (eccsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	/* Set ECC Last bit to 1 */
> +	data_phase_addr = (unsigned long __force)chip->IO_ADDR_R;
> +	data_phase_addr -= nand_offset;
> +	data_phase_addr |= PL353_NAND_ECC_LAST;
> +	data_phase_addr += nand_offset;
> +	chip->IO_ADDR_R = (void __iomem * __force)data_phase_addr;
> +	pl353_nand_read_data_op(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	/* Read the calculated ECC value */
> +	p = buf;
> +	chip->ecc.calculate(mtd, p, &ecc_calc[0]);
> +
> +	/* Clear ECC last bit */
> +	data_phase_addr = (unsigned long __force)chip->IO_ADDR_R;
> +	data_phase_addr -= nand_offset;
> +	data_phase_addr &= ~PL353_NAND_ECC_LAST;
> +	data_phase_addr += nand_offset;
> +	chip->IO_ADDR_R = (void __iomem * __force)data_phase_addr;
> +
> +	/* Read the stored ECC value */
> +	oob_ptr = chip->oob_poi;
> +	pl353_nand_read_data_op(chip, oob_ptr,
> +				(mtd->oobsize -
> +				PL353_NAND_LAST_TRANSFER_LENGTH));
> +
> +	/* de-assert chip select */
> +	data_phase_addr = (unsigned long __force)chip->IO_ADDR_R;
> +	data_phase_addr -= nand_offset;
> +	data_phase_addr |= PL353_NAND_CLEAR_CS;
> +	data_phase_addr += nand_offset;
> +	chip->IO_ADDR_R = (void __iomem * __force)data_phase_addr;
> +
> +	oob_ptr += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +	pl353_nand_read_data_op(chip, oob_ptr, PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	ret = mtd_ooblayout_get_eccbytes(mtd, ecc, chip->oob_poi, 0,
> +					 chip->ecc.total);
> +	if (ret)
> +		return ret;
> +
> +	eccsteps = chip->ecc.steps;
> +	p = buf;
> +
> +	/* Check ECC error for all blocks and correct if it is correctable */
> +	for (i = 0 ; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
> +		stat = chip->ecc.correct(mtd, p, &ecc[i], &ecc_calc[i]);
> +		if (stat < 0) {
> +			mtd->ecc_stats.failed++;
> +		} else {
> +			mtd->ecc_stats.corrected += stat;
> +			max_bitflips = max_t(unsigned int, max_bitflips, stat);
> +		}
> +	}
> +
> +	return max_bitflips;
> +}
> +
> +/**
> + * pl353_nand_select_chip - Select the flash device
> + * @mtd:	Pointer to the mtd info structure
> + * @chip:	Pointer to the NAND chip info structure
> + *
> + * This function is empty as the NAND controller handles chip select line
> + * internally based on the chip address passed in command and data phase.

So why aren't you saving the current chip/die for later use?

> + */
> +static void pl353_nand_select_chip(struct mtd_info *mtd, int chip)
> +{

You should probably save/restore timing registers somewhere now that
you support ->setup_data_interface().

> +}
> +
> +/* NAND framework ->exec_op() hooks and related helpers */
> +static void pl353_nfc_parse_instructions(struct nand_chip *chip,
> +					 const struct nand_subop *subop,
> +					 struct pl353_nfc_op *nfc_op)
> +{
> +	const struct nand_op_instr *instr = NULL;
> +	unsigned int op_id, offset, naddrs;
> +	int i, len;
> +	const u8 *addrs;
> +
> +	memset(nfc_op, 0, sizeof(struct pl353_nfc_op));
> +	for (op_id = 0; op_id < subop->ninstrs; op_id++) {
> +		nfc_op->len = nand_subop_get_data_len(subop, op_id);
> +		len = nand_subop_get_data_len(subop, op_id);
> +		instr = &subop->instrs[op_id];
> +		//if (subop->ninstrs == 1)
> +			//nfc_op->cmnds[0] = -1;
> +		switch (instr->type) {
> +		case NAND_OP_CMD_INSTR:
> +			nfc_op->type = NAND_OP_CMD_INSTR;
> +			if (op_id)
> +				nfc_op->cmnds[1] = instr->ctx.cmd.opcode;
> +			else
> +				nfc_op->cmnds[0] = instr->ctx.cmd.opcode;
> +			nfc_op->cle_ale_delay_ns = instr->delay_ns;
> +			break;
> +
> +		case NAND_OP_ADDR_INSTR:
> +			offset = nand_subop_get_addr_start_off(subop, op_id);
> +			naddrs = nand_subop_get_num_addr_cyc(subop, op_id);
> +			addrs = &instr->ctx.addr.addrs[offset];
> +			nfc_op->addrs = instr->ctx.addr.addrs[offset];
> +			for (i = 0; i < min_t(unsigned int, 4, naddrs); i++) {
> +				nfc_op->addrs |= instr->ctx.addr.addrs[i] <<
> +						 (8 * i);
> +			}
> +
> +			if (naddrs >= 5)
> +				nfc_op->addr5 = addrs[4];
> +			if (naddrs >= 6)
> +				nfc_op->addr6 = addrs[5];
> +			nfc_op->naddrs = nand_subop_get_num_addr_cyc(subop,
> +								     op_id);
> +			nfc_op->cle_ale_delay_ns = instr->delay_ns;
> +			break;
> +
> +		case NAND_OP_DATA_IN_INSTR:
> +			nfc_op->data_instr = instr;
> +			nfc_op->type = NAND_OP_DATA_IN_INSTR;
> +			nfc_op->data_instr_idx = op_id;
> +			nfc_op->data_delay_ns = instr->delay_ns;
> +			break;
> +
> +		case NAND_OP_DATA_OUT_INSTR:
> +			nfc_op->data_instr = instr;
> +			nfc_op->type = NAND_OP_DATA_IN_INSTR;
> +			nfc_op->data_instr_idx = op_id;
> +			nfc_op->data_delay_ns = instr->delay_ns;
> +			break;
> +
> +		case NAND_OP_WAITRDY_INSTR:
> +			nfc_op->rdy_timeout_ms = instr->ctx.waitrdy.timeout_ms;
> +			nfc_op->rdy_delay_ns = instr->delay_ns;
> +			nfc_op->wait = true;
> +			break;
> +		}
> +	}
> +}
> +
> +static void cond_delay(unsigned int ns)
> +{
> +	if (!ns)
> +		return;
> +
> +	if (ns < 10000)
> +		ndelay(ns);
> +	else
> +		udelay(DIV_ROUND_UP(ns, 1000));
> +}
> +
> +/**
> + * pl353_nand_cmd_function - Send command to NAND device
> + * @chip:	Pointer to the NAND chip info structure
> + * @subop:	Pointer to array of instructions
> + * Return:	Always return zero
> + */
> +static int pl353_nand_cmd_function(struct nand_chip *chip,
> +				   const struct nand_subop *subop)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	const struct nand_op_instr *instr;
> +	struct pl353_nfc_op nfc_op = {};
> +	struct pl353_nand_info *xnfc =
> +		container_of(chip, struct pl353_nand_info, chip);
> +	void __iomem *cmd_addr;
> +	unsigned long cmd_data = 0, end_cmd_valid = 0;
> +	unsigned long cmd_phase_addr, data_phase_addr, end_cmd;
> +	unsigned int op_id, len, offset;
> +	bool reading;
> +
> +	pl353_nfc_parse_instructions(chip, subop, &nfc_op);
> +	instr = nfc_op.data_instr;
> +	op_id = nfc_op.data_instr_idx;
> +	len = nand_subop_get_data_len(subop, op_id);
> +	offset = nand_subop_get_data_start_off(subop, op_id);
> +
> +	pl353_smc_clr_nand_int();
> +	/* Get the command phase address */
> +	if (nfc_op.cmnds[1] != 0) {
> +		if (nfc_op.cmnds[0] == NAND_CMD_SEQIN)
> +			end_cmd_valid = 0;
> +		else
> +			end_cmd_valid = 1;
> +		end_cmd = nfc_op.cmnds[1];
> +	}  else {
> +		end_cmd = 0x0;
> +	}
> +	cmd_phase_addr = (unsigned long __force)xnfc->nand_base +
> +			 ((nfc_op.naddrs << ADDR_CYCLES_SHIFT) |
> +			 (end_cmd_valid << END_CMD_VALID_SHIFT) |
> +			 (COMMAND_PHASE) |
> +			 (end_cmd << END_CMD_SHIFT) |
> +			 (nfc_op.cmnds[0] << START_CMD_SHIFT));
> +
> +	cmd_addr = (void __iomem * __force)cmd_phase_addr;
> +	/* Get the data phase address */
> +	end_cmd_valid = 0;
> +
> +	data_phase_addr = (unsigned long __force)xnfc->nand_base +
> +			  ((0x0 << CLEAR_CS_SHIFT) |
> +			  (end_cmd_valid << END_CMD_VALID_SHIFT) |
> +			  (DATA_PHASE) |
> +			  (end_cmd << END_CMD_SHIFT) |
> +			  (0x0 << ECC_LAST_SHIFT));
> +	chip->IO_ADDR_R = (void __iomem * __force)data_phase_addr;
> +	chip->IO_ADDR_W = chip->IO_ADDR_R;
> +	/* Command phase AXI Read & Write */
> +	if (nfc_op.naddrs >= 5) {
> +		if (mtd->writesize > PL353_NAND_ECC_SIZE) {
> +			cmd_data = nfc_op.addrs;
> +			/* Another address cycle for devices > 128MiB */
> +			if (chip->options & NAND_ROW_ADDR_3) {
> +				writel_relaxed(cmd_data, cmd_addr);
> +				cmd_data = nfc_op.addr5;
> +				if (nfc_op.naddrs >= 6)
> +					cmd_data |= (nfc_op.addr6 << 8);
> +			}
> +		}
> +	}  else {
> +		if (nfc_op.addrs != -1) {
> +			int column = nfc_op.addrs;
> +			/*
> +			 * Change read/write column, read id etc
> +			 * Adjust columns for 16 bit bus width
> +			 */
> +			if ((chip->options & NAND_BUSWIDTH_16) &&
> +			    (nfc_op.cmnds[0] == NAND_CMD_READ0 ||
> +				nfc_op.cmnds[0] == NAND_CMD_SEQIN ||
> +				nfc_op.cmnds[0] == NAND_CMD_RNDOUT ||
> +				nfc_op.cmnds[0] == NAND_CMD_RNDIN)) {
> +				column >>= 1;
> +			}
> +			cmd_data = column;
> +		}
> +	}
> +	writel_relaxed(cmd_data, cmd_addr);
> +	ndelay(100);
> +
> +	cond_delay(nfc_op.cle_ale_delay_ns);
> +	if (!nfc_op.data_instr) {
> +		msleep(nfc_op.rdy_timeout_ms);
> +		cond_delay(nfc_op.rdy_delay_ns);
> +		return 0;
> +	}
> +
> +	reading = (nfc_op.data_instr->type == NAND_OP_DATA_IN_INSTR);
> +
> +	if (!reading) {
> +		if (nfc_op.cmnds[0] == NAND_CMD_SEQIN &&
> +		    nfc_op.cmnds[1] == NAND_CMD_PAGEPROG) {
> +			pl353_nand_write_page_raw(mtd, chip,
> +						  instr->ctx.data.buf.out, 0,
> +						  nfc_op.addrs);
> +		} else {
> +			pl353_nand_write_data_op(mtd, instr->ctx.data.buf.out,
> +						 len);
> +		}
> +		if (nfc_op.rdy_timeout_ms)
> +			pl353_dev_timeout(mtd, chip, nfc_op.rdy_timeout_ms);
> +		cond_delay(nfc_op.rdy_delay_ns);
> +
> +	}
> +
> +	else if (reading) {
> +		if (nfc_op.rdy_timeout_ms)
> +			pl353_dev_timeout(mtd, chip, nfc_op.rdy_timeout_ms);
> +		cond_delay(nfc_op.rdy_delay_ns);
> +		pl353_nand_read_data_op(chip, instr->ctx.data.buf.in, len);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct nand_op_parser pl353_nfc_op_parser = NAND_OP_PARSER
> +	(NAND_OP_PARSER_PATTERN
> +		(pl353_nand_cmd_function,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(true),
> +		NAND_OP_PARSER_PAT_ADDR_ELEM(true, 7),
> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(true),
> +		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 2048)),
> +	NAND_OP_PARSER_PATTERN
> +		(pl353_nand_cmd_function,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 7),
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false),
> +		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 2048)),
> +	NAND_OP_PARSER_PATTERN
> +		(pl353_nand_cmd_function,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +		NAND_OP_PARSER_PAT_ADDR_ELEM(true, 7),
> +		NAND_OP_PARSER_PAT_CMD_ELEM(true),
> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
> +	NAND_OP_PARSER_PATTERN
> +		(pl353_nand_cmd_function,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 8),
> +		NAND_OP_PARSER_PAT_DATA_OUT_ELEM(false, 2048),
> +		NAND_OP_PARSER_PAT_CMD_ELEM(true),
> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(true)),
> +	NAND_OP_PARSER_PATTERN
> +		(pl353_nand_cmd_function,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false)),
> +	);
> +
> +static int pl353_nfc_exec_op(struct nand_chip *chip,
> +			     const struct nand_operation *op,
> +			     bool check_only)
> +{
> +	return nand_op_parser_exec_op(chip, &pl353_nfc_op_parser,
> +					      op, check_only);
> +}
> +
> +/**
> + * pl353_nand_device_ready - Check device ready/busy line
> + * @mtd:	Pointer to the mtd_info structure
> + *
> + * Return:	0 on busy or 1 on ready state
> + */
> +static int pl353_nand_device_ready(struct mtd_info *mtd)
> +{
> +	if (pl353_smc_get_nand_int_status_raw()) {
> +		pl353_smc_clr_nand_int();
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * pl353_nand_ecc_init - Initialize the ecc information as per the ecc mode
> + * @mtd:	Pointer to the mtd_info structure
> + * @ecc:	Pointer to ECC control structure
> + * @ecc_mode:	ondie ecc status
> + *
> + * This function initializes the ecc block and functional pointers as per the
> + * ecc mode
> + */
> +static int pl353_nand_ecc_init(struct mtd_info *mtd, struct nand_ecc_ctrl *ecc,
> +				int ecc_mode)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct pl353_nand_info *xnfc =
> +		container_of(chip, struct pl353_nand_info, chip);
> +	u32 err = 0;
> +
> +	if (ecc_mode == NAND_ECC_ON_DIE) {
> +		pl353_smc_set_ecc_mode(PL353_SMC_ECCMODE_BYPASS);
> +		/*
> +		 * On-Die ECC spare bytes offset 8 is used for ECC codes
> +		 * Use the BBT pattern descriptors
> +		 */
> +		chip->bbt_td = &bbt_main_descr;
> +		chip->bbt_md = &bbt_mirror_descr;
> +		bitmap_set(chip->parameters.get_feature_list,
> +			   ONFI_FEATURE_ON_DIE_ECC, ONFI_FEATURE_ON_DIE_ECC_EN);
> +		bitmap_set(chip->parameters.set_feature_list,
> +			   ONFI_FEATURE_ON_DIE_ECC, ONFI_FEATURE_ON_DIE_ECC_EN);
> +	} else {
> +		ecc->read_oob = pl353_nand_read_oob;
> +		ecc->write_oob = pl353_nand_write_oob;
> +
> +		ecc->mode = NAND_ECC_HW;
> +		/* Hardware ECC generates 3 bytes ECC code for each 512 bytes */
> +		ecc->bytes = 3;
> +		ecc->strength = 1;
> +		ecc->calculate = pl353_nand_calculate_hwecc;
> +		ecc->correct = pl353_nand_correct_data;
> +		ecc->read_page = pl353_nand_read_page_hwecc;
> +		ecc->size = PL353_NAND_ECC_SIZE;
> +		ecc->write_page = pl353_nand_write_page_hwecc;
> +		pl353_smc_set_ecc_pg_size(mtd->writesize);
> +		switch (mtd->writesize) {
> +		case SZ_512:
> +		case SZ_1K:
> +		case SZ_2K:
> +			pl353_smc_set_ecc_mode(PL353_SMC_ECCMODE_APB);
> +			break;
> +		default:
> +			/*
> +			 * The software ECC routines won't work with the
> +			 * SMC controller
> +			 */
> +			ecc->calculate = nand_calculate_ecc;
> +			ecc->correct = nand_correct_data;
> +			ecc->size = 256;
> +			break;
> +		}
> +		if (mtd->writesize <= SZ_512)
> +			xnfc->addr_cycles = 1;
> +		else
> +			xnfc->addr_cycles = 2;
> +
> +		if (chip->options & NAND_ROW_ADDR_3)
> +			xnfc->addr_cycles += 3;
> +		else
> +			xnfc->addr_cycles += 2;
> +
> +		if (mtd->oobsize == 16) {
> +			mtd_set_ooblayout(mtd, &pl353_ecc_ooblayout16_ops);
> +		} else if (mtd->oobsize == 64) {
> +			mtd_set_ooblayout(mtd, &pl353_ecc_ooblayout64_ops);
> +		} else {
> +			err = ENXIO;

Errors are always negative values

> +			dev_err(xnfc->dev, "Unsupported oob Layout\n");
> +		}
> +	}

Space

> +	return err;
> +}
> +static int pl353_setup_data_interface(struct mtd_info *mtd, int csline,
> +				       const struct nand_data_interface *conf)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct pl353_nand_info *xnfc =
> +		container_of(chip, struct pl353_nand_info, chip);
> +	const struct nand_sdr_timings *sdr;
> +	u32 timigs[7], mckperiodps;

s/timigs/timings/

Please use C coding style with '_' instead of a bulk of characters like
mckperiodps.

> +
> +	if (csline == NAND_DATA_IFACE_CHECK_ONLY)
> +		return -EINVAL;

Why?

> +
> +	sdr = nand_get_sdr_timings(conf);
> +	if (IS_ERR(sdr))
> +		return PTR_ERR(sdr);
> +	/*
> +	 * SDR timings are given in pico-seconds while NFC timings must be
> +	 * expressed in NAND controller clock cycles.
> +	 */
> +	mckperiodps = NSEC_PER_SEC / clk_get_rate(xnfc->mclk);
> +	mckperiodps *= 1000;
> +	timigs[0] = DIV_ROUND_UP(sdr->tRC_min, mckperiodps);
> +	timigs[1] = DIV_ROUND_UP(sdr->tWC_min, mckperiodps);
> +	timigs[2] = DIV_ROUND_UP(sdr->tREA_max, mckperiodps);
> +	timigs[3] = DIV_ROUND_UP(sdr->tWP_min, mckperiodps);
> +	timigs[4] = DIV_ROUND_UP(sdr->tCLR_min, mckperiodps);
> +	timigs[5] = DIV_ROUND_UP(sdr->tAR_min, mckperiodps);
> +	timigs[6] = DIV_ROUND_UP(sdr->tRR_min, mckperiodps);
> +	pl353_smc_set_cycles(timigs[0], timigs[1], timigs[2], timigs[3],
> +			     timigs[4], timigs[5], timigs[6]);

You could just give an array of timings instead of 7 values?

This would also simplify the code in the smc driver.

> +
> +	return 0;
> +}
> +/**
> + * pl353_nand_probe - Probe method for the NAND driver
> + * @pdev:	Pointer to the platform_device structure
> + *
> + * This function initializes the driver data structures and the hardware.
> + *
> + * Return:	0 on success or error value on failure
> + */
> +static int pl353_nand_probe(struct platform_device *pdev)
> +{
> +	struct pl353_nand_info *xnfc;
> +	struct mtd_info *mtd;
> +	struct nand_chip *chip;
> +	struct resource *res;
> +	struct device_node *np;
> +	u32 ret;
> +
> +	xnfc = devm_kzalloc(&pdev->dev, sizeof(*xnfc), GFP_KERNEL);
> +	if (!xnfc)
> +		return -ENOMEM;
> +	xnfc->dev = &pdev->dev;
> +	/* Map physical address of NAND flash */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	xnfc->nand_base = devm_ioremap_resource(xnfc->dev, res);
> +	if (IS_ERR(xnfc->nand_base))
> +		return PTR_ERR(xnfc->nand_base);
> +
> +	chip = &xnfc->chip;
> +	mtd = nand_to_mtd(chip);
> +	chip->exec_op = pl353_nfc_exec_op;
> +	nand_set_controller_data(chip, xnfc);
> +	mtd->priv = chip;
> +	mtd->owner = THIS_MODULE;
> +	if (!mtd->name) {
> +		/*
> +		 * If the new bindings are used and the bootloader has not been
> +		 * updated to pass a new mtdparts parameter on the cmdline, you
> +		 * should define the following property in your NAND node, ie:
> +		 *
> +		 *	label = "pl353-nand";
> +		 *
> +		 * This way, mtd->name will be set by the core when
> +		 * nand_set_flash_node() is called.
> +		 */
> +		mtd->name = devm_kasprintf(xnfc->dev, GFP_KERNEL,
> +					   "%s", PL353_NAND_DRIVER_NAME);
> +		if (!mtd->name) {
> +			dev_err(xnfc->dev, "Failed to allocate mtd->name\n");
> +			return -ENOMEM;
> +		}
> +	}
> +	nand_set_flash_node(chip, xnfc->dev->of_node);
> +
> +	/* Set address of NAND IO lines */
> +	chip->IO_ADDR_R = xnfc->nand_base;
> +	chip->IO_ADDR_W = xnfc->nand_base;
> +	/* Set the driver entry points for MTD */
> +	chip->dev_ready = pl353_nand_device_ready;
> +	chip->select_chip = pl353_nand_select_chip;
> +	/* If we don't set this delay driver sets 20us by default */
> +	np = of_get_next_parent(xnfc->dev->of_node);
> +	xnfc->mclk = of_clk_get(np, 0);
> +	if (IS_ERR(xnfc->mclk)) {
> +		dev_err(xnfc->dev, "Failed to retrieve MCK clk\n");
> +		return PTR_ERR(xnfc->mclk);
> +	}
> +	chip->chip_delay = 30;
> +	/* Set the device option and flash width */
> +	chip->options = NAND_BUSWIDTH_AUTO;
> +	chip->bbt_options = NAND_BBT_USE_FLASH;
> +	platform_set_drvdata(pdev, xnfc);
> +	chip->setup_data_interface = pl353_setup_data_interface;
> +	/* first scan to find the device and get the page size */
> +	if (nand_scan_ident(mtd, 1, NULL)) {
> +		dev_err(xnfc->dev, "nand_scan_ident for NAND failed\n");
> +		return -ENXIO;
> +	}
> +	ret = pl353_nand_ecc_init(mtd, &chip->ecc, chip->ecc.mode);
> +	if (chip->options & NAND_BUSWIDTH_16)
> +		pl353_smc_set_buswidth(PL353_SMC_MEM_WIDTH_16);
> +	/* second phase scan */
> +	if (nand_scan_tail(mtd)) {
> +		dev_err(xnfc->dev, "nand_scan_tail for NAND failed\n");
> +		return -ENXIO;
> +	}
> +
> +	mtd_device_register(mtd, NULL, 0);

Check the returned code

> +
> +	return 0;
> +}
> +
> +/**
> + * pl353_nand_remove - Remove method for the NAND driver
> + * @pdev:	Pointer to the platform_device structure
> + *
> + * This function is called if the driver module is being unloaded. It frees all
> + * resources allocated to the device.
> + *
> + * Return:	0 on success or error value on failure
> + */
> +static int pl353_nand_remove(struct platform_device *pdev)
> +{
> +	struct pl353_nand_info *xnfc = platform_get_drvdata(pdev);
> +	struct mtd_info *mtd = nand_to_mtd(&xnfc->chip);
> +
> +	/* Release resources, unregister device */
> +	nand_release(mtd);

What about MTD core deregistration?

> +
> +	return 0;
> +}
> +
> +/* Match table for device tree binding */
> +static const struct of_device_id pl353_nand_of_match[] = {
> +	{ .compatible = "arm,pl353-nand-r2p1" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, pl353_nand_of_match);
> +
> +/*
> + * pl353_nand_driver - This structure defines the NAND subsystem platform driver
> + */
> +static struct platform_driver pl353_nand_driver = {
> +	.probe		= pl353_nand_probe,
> +	.remove		= pl353_nand_remove,
> +	.driver		= {
> +		.name	= PL353_NAND_DRIVER_NAME,
> +		.of_match_table = pl353_nand_of_match,
> +	},
> +};
> +
> +module_platform_driver(pl353_nand_driver);
> +
> +MODULE_AUTHOR("Xilinx, Inc.");
> +MODULE_ALIAS("platform:" PL353_NAND_DRIVER_NAME);
> +MODULE_DESCRIPTION("ARM PL353 NAND Flash Driver");
> +MODULE_LICENSE("GPL");

Thanks for your efforts,
Miquèl
