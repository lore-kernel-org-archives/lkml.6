Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032672AbeCSWiN convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 18:38:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52818 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933450AbeCSWiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 18:38:03 -0400
Date: Mon, 19 Mar 2018 23:37:48 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: <nagasureshkumarrelli@gmail.com>
Cc: <boris.brezillon@bootlin.com>, <richard@nod.at>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <cyrille.pitchen@wedev4u.fr>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <michals@xilinx.com>,
        <punnaia@xilinx.com>, Naga Sureshkumar Relli <nagasure@xilinx.com>
Subject: Re: [LINUX PATCH v8 2/2] mtd: rawnand: pl353: Add basic driver for
 arm pl353 smc nand interface
Message-ID: <20180319233748.65b5a7b9@xps13>
In-Reply-To: <1521024505-30677-1-git-send-email-nagasureshkumarrelli@gmail.com>
References: <1521024505-30677-1-git-send-email-nagasureshkumarrelli@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naga,

Thanks for sending a new version supporting ->exec_op(). A few comments
below.

On Wed, 14 Mar 2018 16:18:25 +0530,
<nagasureshkumarrelli@gmail.com> wrote:

> From: Naga Sureshkumar Relli <nagasure@xilinx.com>
> 
> Add driver for arm pl353 static memory controller nand interface with
> HW ECC support. This controller is used in xilinx zynq soc for interfacing
> the nand flash memory.
> 
> Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
> ---
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
>  - Configure the nand timing parameters as per the onfi spec
> Changes in v4:
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
>  - remove dummy helper and use writel_relaxed directly
> ---
>  drivers/mtd/nand/raw/Kconfig      |    8 +
>  drivers/mtd/nand/raw/Makefile     |    1 +
>  drivers/mtd/nand/raw/pl353_nand.c | 1363 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 1372 insertions(+)
>  create mode 100644 drivers/mtd/nand/raw/pl353_nand.c
> 
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index 2c6ecb7..5e20391 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -566,4 +566,12 @@ config MTD_NAND_MTK
>  	  Enables support for NAND controller on MTK SoCs.
>  	  This controller is found on mt27xx, mt81xx, mt65xx SoCs.
>  
> +config MTD_NAND_PL353
> +	tristate "ARM Pl353 NAND flash driver"
> +	depends on MTD_NAND && ARM
> +	depends on PL35X_SMC
> +	help
> +	  This enables access to the NAND flash device on PL353
> +	  SMC controller.

What about:
          "Enables support for PrimeCell Static Memory Controller
          PL353."?

> +
>  endif # MTD_NAND
> diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
> index f16f59a..3e943f3 100644
> --- a/drivers/mtd/nand/raw/Makefile
> +++ b/drivers/mtd/nand/raw/Makefile
> @@ -57,6 +57,7 @@ obj-$(CONFIG_MTD_NAND_HISI504)	        += hisi504_nand.o
>  obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= brcmnand/
>  obj-$(CONFIG_MTD_NAND_QCOM)		+= qcom_nandc.o
>  obj-$(CONFIG_MTD_NAND_MTK)		+= mtk_ecc.o mtk_nand.o
> +obj-$(CONFIG_MTD_NAND_PL353)		+= pl353_nand.o
>  
>  nand-objs := nand_base.o nand_bbt.o nand_timings.o nand_ids.o
>  nand-objs += nand_amd.o
> diff --git a/drivers/mtd/nand/raw/pl353_nand.c b/drivers/mtd/nand/raw/pl353_nand.c
> new file mode 100644
> index 0000000..55c51e2
> --- /dev/null
> +++ b/drivers/mtd/nand/raw/pl353_nand.c
> @@ -0,0 +1,1363 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ARM PL353 NAND flash controller driver
> + *
> + * Copyright (C) 2017 Xilinx, Inc
> + * Author: Punnaiah <punnaiah@xilinx.com>
> + * Author: nagasuresh <nagasure@xilinx.com>

Please use your full names here.

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
> +#include <linux/platform_data/pl353-smc.h>
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
> +
> +/* Inline function for the NAND controller register write */
> +static inline void pl353_nand_write32(void __iomem *addr, u32 val)
> +{
> +	writel_relaxed((val), (addr));
> +}

Is there an actual need for this inline function? Why not calling
writel_relaxed() directly?

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
> + */
> +struct pl353_nand_info {
> +	struct nand_chip chip;
> +	void __iomem *nand_base;
> +	unsigned long end_cmd_pending;
> +	unsigned long end_cmd;
> +	u8 row_addr_cycles;
> +	u8 col_addr_cycles;
> +	u32 address;
> +	u32 cmd_pending;
> +};
> +
> +static int pl353_ecc_ooblayout16_ecc(struct mtd_info *mtd, int section,
> +				   struct mtd_oob_region *oobregion)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +
> +	if (section >= chip->ecc.steps)
> +		return -ERANGE;
> +
> +	oobregion->offset = (section * 16) + 0;
> +	oobregion->length = chip->ecc.bytes;
> +
> +	return 0;
> +}
> +
> +static int pl353_ecc_ooblayout16_free(struct mtd_info *mtd, int section,
> +				    struct mtd_oob_region *oobregion)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +
> +	if (section >= chip->ecc.steps)
> +		return -ERANGE;
> +
> +	oobregion->offset = (section * 16) + 8;
> +

Extra space

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
> +				   struct mtd_oob_region *oobregion)
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
> +				    struct mtd_oob_region *oobregion)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +
> +	if (section)
> +		return -ERANGE;
> +	if (section >= chip->ecc.steps)
> +		return -ERANGE;

If you can't support more than one section, the second if is useless,
and the offset is just "2".

> +
> +	oobregion->offset = (section * chip->ecc.bytes) + 2;
> +
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
> +static uint8_t bbt_pattern[] = { 'B', 'b', 't', '0' };
> +static uint8_t mirror_pattern[] = { '1', 't', 'b', 'B' };
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
> + * pl353_nand_read_buf_l - read chip data into buffer
> + * @chip:	Pointer to the NAND chip info structure
> + * @in:		Pointer to the buffer to store read data
> + * @len:	Number of bytes to read
> + * Return:	Always return zero
> + */
> +static int pl353_nand_read_buf_l(struct nand_chip *chip,
> +				     uint8_t *in,
> +				     unsigned int len)
> +{
> +	int i;
> +	unsigned long *ptr = (unsigned long *)in;
> +
> +	len >>= 2;

Can you please let the compiler optimize things? I don't find this very
readable, I would prefer a division here. And if this division by 4 is
related to the size of *ptr, please use the sizeof() macro. Otherwise
please document this value.

> +	for (i = 0; i < len; i++)
> +		ptr[i] = readl(chip->IO_ADDR_R);

Space

> +	return 0;
> +}
> +
> +static void pl353_nand_write_buf_l(struct nand_chip *chip, const uint8_t *buf,
> +				int len)
> +{
> +	int i;
> +	unsigned long *ptr = (unsigned long *)buf;
> +
> +	for (i = 0; i < len; i++)
> +		writeb(ptr[i], chip->IO_ADDR_W);

Here you use writeb (as opposed to readl previously). Then, I guess you
can also read byte per byte. If so, you can drop both helpers and let
the core use its defaults ones: nand_read/write_buf().

Same for the next functions. Plus, if you don't use them inside
->exec_op() implementation, they have to be removed anyway.

> +}
> +
> +/**
> + * pl353_nand_write_buf - write buffer to chip
> + * @mtd:	Pointer to the mtd info structure
> + * @buf:	Pointer to the buffer to store read data
> + * @len:	Number of bytes to write
> + */
> +static void pl353_nand_write_buf(struct mtd_info *mtd, const uint8_t *buf,
> +				int len)
> +{
> +	int i;
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	unsigned long *ptr = (unsigned long *)buf;
> +
> +	len >>= 2;
> +
> +	for (i = 0; i < len; i++)
> +		writel(ptr[i], chip->IO_ADDR_W);
> +}
> +
> +/**
> + * pl353_nand_read_buf - read chip data into buffer
> + * @chip:	Pointer to the NAND chip info structure
> + * @in:	Pointer to the buffer to store read data
> + * @len:	Number of bytes to read
> + * Return:	0 on success or error value on failure
> + */
> +static int pl353_nand_read_buf(struct nand_chip *chip,
> +				     uint8_t *in,
> +				     unsigned int len)
> +{
> +	int i;
> +
> +	for (i = 0; i < len; i++)
> +		in[i] = readb(chip->IO_ADDR_R);
> +
> +	return 0;
> +}
> +
> +/**
> + * pl353_nand_calculate_hwecc - Calculate Hardware ECC
> + * @mtd:	Pointer to the mtd_info structure
> + * @data:	Pointer to the page data
> + * @ecc_code:	Pointer to the ECC buffer where ECC data needs to be stored

You store ECC in a variable called "code", can you please make it
consistent?

> + *
> + * This function retrieves the Hardware ECC data from the controller and returns
> + * ECC data back to the MTD subsystem.
> + *
> + * Return:	0 on success or error value on failure
> + */
> +static int pl353_nand_calculate_hwecc(struct mtd_info *mtd,
> +				const u8 *data, u8 *ecc_code)
> +{
> +	u32 ecc_value, ecc_status;
> +	u8 ecc_reg, ecc_byte;
> +	unsigned long timeout = jiffies + PL353_NAND_ECC_BUSY_TIMEOUT;
> +	/* Wait till the ECC operation is complete or timeout */
> +	do {
> +		if (pl353_smc_ecc_is_busy())

Where does this function come from?

I would rather prefer a readl_relaxed_poll_timeout() or similar, if
possible.

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

I don't have this function neither?

> +		ecc_status = (ecc_value >> 24) & 0xFF;
> +		/* ECC value valid */
> +		if (ecc_status & 0x40) {
> +			for (ecc_byte = 0; ecc_byte < 3; ecc_byte++) {
> +				/* Copy ECC bytes to MTD buffer */
> +				*ecc_code = ~ecc_value & 0xFF;
> +				ecc_value = ecc_value >> 8;
> +				ecc_code++;
> +			}
> +		} else {
> +			pr_warn("%s status failed\n", __func__);
> +			return -1;
> +		}
> +	}
> +	return 0;
> +}
> +
> +/**
> + * onehot - onehot function
> + * @value:	Value to check for onehot
> + *
> + * This function checks whether a value is onehot or not.
> + * onehot is if and only if onebit is set.

s/onebit/one bit/

But I am sure there is already a function for that in the kernel,
please don't use your own implementation for this kind of stuff.

> + *
> + * Return:	1 if it is onehot else 0
> + */
> +static int onehot(unsigned short value)
> +{
> +	return (value & (value - 1)) == 0;
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
> + *		-1 if multiple ECC errors found.
> + */
> +static int pl353_nand_correct_data(struct mtd_info *mtd, unsigned char *buf,
> +				unsigned char *read_ecc,
> +				unsigned char *calc_ecc)
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
> +	if ((ecc_odd == 0) && (ecc_even == 0))
> +		return 0;       /* no error */

What about:

        if (!ecc_odd && !ecc_even)
                return 0;

> +
> +	if (ecc_odd == (~ecc_even & 0xfff)) {
> +		/* bits [11:3] of error code is byte offset */
> +		byte_addr = (ecc_odd >> 3) & 0x1ff;
> +		/* bits [2:0] of error code is bit offset */
> +		bit_addr = ecc_odd & 0x7;
> +		/* Toggling error bit */
> +		buf[byte_addr] ^= (1 << bit_addr);

Use BIT(bit_addr) macro instead?

> +		return 1;
> +	}
> +
> +	if (onehot(ecc_odd | ecc_even) == 1)
> +		return 1; /* one error in parity */

Comment should be before the if statement here.

> +
> +	return -1; /* Uncorrectable error */

And here, before the return statement.

> +}
> +
> +static int pl353_dev_timeout(struct mtd_info *mtd, struct nand_chip *chip)
> +{
> +	unsigned long timeout = jiffies + PL353_NAND_DEV_BUSY_TIMEOUT;
> +
> +	do {
> +		if (chip->dev_ready(mtd))
> +			break;
> +		cpu_relax();
> +	} while (!time_after_eq(jiffies, timeout));
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
> +	int page, int column, int start_cmd, int end_cmd, bool read)
> +{
> +	unsigned long data_phase_addr;
> +	u32 end_cmd_valid = 0;
> +	void __iomem *cmd_addr;
> +	unsigned long cmd_phase_addr = 0, cmd_data = 0;
> +
> +	struct pl353_nand_info *xnand =
> +		container_of(chip, struct pl353_nand_info, chip);
> +
> +	if (read)
> +		end_cmd_valid = 1;
> +	else
> +		end_cmd_valid = 0;

This is a good spot to use the ternary operator :)

> +
> +	cmd_phase_addr = (unsigned long __force)xnand->nand_base + (
> +			 (((xnand->row_addr_cycles) + (xnand->col_addr_cycles))
> +			 << ADDR_CYCLES_SHIFT) |
> +			 (end_cmd_valid << END_CMD_VALID_SHIFT)		|
> +			 (COMMAND_PHASE)				|
> +			 (end_cmd << END_CMD_SHIFT)			|

Please don't align the '|'

> +			 (start_cmd << START_CMD_SHIFT));
> +	cmd_addr = (void __iomem * __force)cmd_phase_addr;
> +
> +	/* Get the data phase address */
> +	data_phase_addr = (unsigned long __force)xnand->nand_base + (
> +			  (0x0 << CLEAR_CS_SHIFT)			|
> +			  (0 << END_CMD_VALID_SHIFT)	|
> +			  (DATA_PHASE)					|
> +			  (end_cmd << END_CMD_SHIFT)			|
> +			  (0x0 << ECC_LAST_SHIFT));
> +
> +	chip->IO_ADDR_R = (void __iomem * __force)data_phase_addr;
> +	chip->IO_ADDR_W = chip->IO_ADDR_R;
> +	if (chip->options & NAND_BUSWIDTH_16)
> +		column >>= 1;

 / 2

> +	cmd_data = column;
> +	if (mtd->writesize > PL353_NAND_ECC_SIZE) {
> +		cmd_data |= page << 16;
> +		/* Another address cycle for devices > 128MiB */
> +		if (chip->chipsize > (128 << 20)) {

Now there is a flag for that in the core, called NAND_ROW_ADDR_3.

> +			pl353_nand_write32(cmd_addr, cmd_data);
> +			cmd_data = (page >> 16);
> +		}
> +	} else {
> +		cmd_data |= page << 8;
> +	}

Space

> +	pl353_nand_write32(cmd_addr, cmd_data);
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
> +			    int page)
> +{
> +
> +	unsigned long data_phase_addr;
> +	uint8_t *p;
> +
> +	chip->pagebuf = -1;
> +	if (mtd->writesize < PL353_NAND_ECC_SIZE)
> +		return 0;
> +
> +	pl353_prepare_cmd(mtd, chip, page, mtd->writesize, NAND_CMD_READ0,
> +		NAND_CMD_READSTART, 1);

Alignment

> +
> +	ndelay(100);
> +	pl353_dev_timeout(mtd, chip);
> +
> +	p = chip->oob_poi;
> +	pl353_nand_read_buf_l(chip, p,
> +		(mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH));

Alignment

> +	p += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	data_phase_addr = (unsigned long __force)chip->IO_ADDR_R;
> +	data_phase_addr |= PL353_NAND_CLEAR_CS;
> +	chip->IO_ADDR_R = (void __iomem * __force)data_phase_addr;
> +	pl353_nand_read_buf_l(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH);
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

Comments inside this function would be welcome!

> +static int pl353_nand_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
> +			     int page)
> +{
> +

Extra space

> +	const uint8_t *buf = chip->oob_poi;
> +	unsigned long data_phase_addr;
> +	struct pl353_nand_info *xnand =
> +		container_of(chip, struct pl353_nand_info, chip);
> +	u32 addrcycles = 0, ret;
> +	unsigned long timeout = jiffies + PL353_NAND_DEV_BUSY_TIMEOUT;
> +	u8 status;
> +
> +	chip->pagebuf = -1;
> +	addrcycles = xnand->row_addr_cycles + xnand->col_addr_cycles;
> +	pl353_prepare_cmd(mtd, chip, page, mtd->writesize, NAND_CMD_SEQIN,
> +		NAND_CMD_PAGEPROG, 0);
> +	ndelay(100);
> +	pl353_nand_write_buf(mtd, buf,
> +			(mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH));
> +	buf += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	data_phase_addr = (unsigned long __force)chip->IO_ADDR_W;
> +	data_phase_addr |= PL353_NAND_CLEAR_CS;
> +	data_phase_addr |= (1 << END_CMD_VALID_SHIFT);
> +	chip->IO_ADDR_W = (void __iomem * __force)data_phase_addr;
> +	pl353_nand_write_buf(mtd, buf, PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	/* Send command to program the OOB data */
> +	ret = nand_status_op(chip, &status);

Doing this without exiting the status state is broken.

> +	timeout = jiffies + msecs_to_jiffies(timeout);
> +	do {
> +		if (chip->dev_ready) {
> +			if (chip->dev_ready(mtd))
> +				break;
> +		} else {

You give your own implementation of ->dev_ready(). So this is dead code.

> +			if (status & NAND_STATUS_READY)

You don't update "status", while you wait for it to change.

> +				break;
> +		}
> +		cond_resched();
> +	} while (time_before(jiffies, timeout));
> +
> +	/* This can happen if in case of timeout or buggy dev_ready */
> +	WARN_ON(!(status & NAND_STATUS_READY));

I think the whole block has to be replaced by a simple nand_wait_ready()
call.

> +
> +	return (status & NAND_STATUS_FAIL) ? -EIO : 0;
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
> +				struct nand_chip *chip,
> +				uint8_t *buf, int oob_required, int page)

Do you really need raw accessors?

Not sure this is needed.

> +{
> +	unsigned long data_phase_addr;
> +	uint8_t *p;
> +
> +	pl353_nand_read_buf_l(chip, buf, mtd->writesize);
> +	p = chip->oob_poi;
> +	pl353_nand_read_buf_l(chip, p,
> +		(mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH));
> +	p += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	data_phase_addr = (unsigned long __force)chip->IO_ADDR_R;
> +	data_phase_addr |= PL353_NAND_CLEAR_CS;
> +	chip->IO_ADDR_R = (void __iomem * __force)data_phase_addr;
> +
> +	pl353_nand_read_buf_l(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH);
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
> +				    struct nand_chip *chip,
> +				    const uint8_t *buf, int oob_required,
> +				    int page)
> +{
> +	unsigned long data_phase_addr;
> +	uint8_t *p;
> +
> +	pl353_prepare_cmd(mtd, chip, page, 0, NAND_CMD_SEQIN,
> +		NAND_CMD_PAGEPROG, 0);
> +	pl353_nand_write_buf(mtd, buf, mtd->writesize);
> +	p = chip->oob_poi;
> +	pl353_nand_write_buf(mtd, p,
> +			(mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH));
> +	p += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	data_phase_addr = (unsigned long __force)chip->IO_ADDR_W;
> +	data_phase_addr |= PL353_NAND_CLEAR_CS;
> +	data_phase_addr |= (1 << END_CMD_VALID_SHIFT);
> +	chip->IO_ADDR_W = (void __iomem * __force)data_phase_addr;
> +
> +	pl353_nand_write_buf(mtd, p, PL353_NAND_LAST_TRANSFER_LENGTH);
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
> +				    struct nand_chip *chip, const uint8_t *buf,
> +				    int oob_required, int page)
> +{
> +
> +	int eccsize = chip->ecc.size;
> +	int eccsteps = chip->ecc.steps;
> +	uint8_t *ecc_calc = chip->ecc.calc_buf;
> +	const uint8_t *p = buf;
> +	uint8_t *oob_ptr;
> +	u32 ret;
> +	unsigned long data_phase_addr, timeo;
> +	u8 status;
> +
> +	pl353_prepare_cmd(mtd, chip, page, 0, NAND_CMD_SEQIN,
> +		NAND_CMD_PAGEPROG, 0);
> +	ndelay(100);
> +	for ( ; (eccsteps - 1); eccsteps--) {
> +		pl353_nand_write_buf(mtd, p, eccsize);
> +		p += eccsize;
> +	}
> +	pl353_nand_write_buf(mtd, p,
> +		(eccsize - PL353_NAND_LAST_TRANSFER_LENGTH));
> +	p += (eccsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	/* Set ECC Last bit to 1 */
> +	data_phase_addr = (unsigned long __force)chip->IO_ADDR_W;
> +	data_phase_addr |= PL353_NAND_ECC_LAST;
> +	chip->IO_ADDR_W = (void __iomem * __force)data_phase_addr;
> +	pl353_nand_write_buf(mtd, p, PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	p = buf;
> +	chip->ecc.calculate(mtd, p, &ecc_calc[0]);
> +
> +	/* Wait for ECC to be calculated and read the error values */
> +	ret = mtd_ooblayout_set_eccbytes(mtd, ecc_calc, chip->oob_poi,
> +						0, chip->ecc.total);
> +	if (ret)
> +		return ret;
> +	/* Clear ECC last bit */
> +	data_phase_addr = (unsigned long __force)chip->IO_ADDR_W;
> +	data_phase_addr &= ~PL353_NAND_ECC_LAST;
> +	chip->IO_ADDR_W = (void __iomem * __force)data_phase_addr;
> +
> +	/* Write the spare area with ECC bytes */
> +	oob_ptr = chip->oob_poi;
> +	pl353_nand_write_buf(mtd, oob_ptr,
> +			(mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH));
> +
> +	data_phase_addr = (unsigned long __force)chip->IO_ADDR_W;
> +	data_phase_addr |= PL353_NAND_CLEAR_CS;
> +	data_phase_addr |= (1 << END_CMD_VALID_SHIFT);
> +	chip->IO_ADDR_W = (void __iomem * __force)data_phase_addr;
> +	oob_ptr += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +	pl353_nand_write_buf(mtd, oob_ptr, PL353_NAND_LAST_TRANSFER_LENGTH);

Once using ->exec_op(), you should use something like
nand_write_data_op().
> +
> +	/*
> +	 * Apply this short delay always to ensure that we do wait tWB in any
> +	 * case on any machine.
> +	 */
> +	ndelay(100);
> +	ret = nand_status_op(chip, &status);
> +	timeo = jiffies + msecs_to_jiffies(400);
> +	do {
> +		if (chip->dev_ready) {
> +			if (chip->dev_ready(mtd))
> +				break;
> +		} else {
> +			if (status & NAND_STATUS_READY)
> +				break;
> +		}
> +		cond_resched();
> +	} while (time_before(jiffies, timeo));
> +
> +	/* This can happen if in case of timeout or buggy dev_ready */
> +	WARN_ON(!(status & NAND_STATUS_READY));
> +

Same here about ->dev_ready().

> +	return (status & NAND_STATUS_FAIL) ? -EIO : 0;
> +}
> +
> +/**
> + * pl353_nand_write_page_swecc - [REPLACEABLE] software ecc based page write
> + *				function
> + * @mtd:		Pointer to the mtd info structure
> + * @chip:		Pointer to the NAND chip info structure
> + * @buf:		Pointer to the data buffer
> + * @oob_required:	Caller requires OOB data read to chip->oob_poi
> + * @page:		Page number to write
> + *
> + * Return:	Always return zero
> + */
> +static int pl353_nand_write_page_swecc(struct mtd_info *mtd,
> +				    struct nand_chip *chip, const uint8_t *buf,
> +				    int oob_required, int page)
> +{

This is an exact copy of the core's function, you probably don't need
it.

> +	int i, eccsize = chip->ecc.size;
> +	int eccbytes = chip->ecc.bytes;
> +	int eccsteps = chip->ecc.steps;
> +	uint8_t *ecc_calc = chip->ecc.calc_buf;
> +	const uint8_t *p = buf;
> +	u32 ret;
> +
> +	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize)
> +		chip->ecc.calculate(mtd, p, &ecc_calc[0]);
> +
> +	ret = mtd_ooblayout_set_eccbytes(mtd, ecc_calc, chip->oob_poi,
> +						0, chip->ecc.total);
> +	if (ret)
> +		return ret;
> +	chip->ecc.write_page_raw(mtd, chip, buf, 1, page);
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
> +				 struct nand_chip *chip,
> +				 uint8_t *buf, int oob_required, int page)
> +{
> +	int i, stat, eccsize = chip->ecc.size;
> +	int eccbytes = chip->ecc.bytes;
> +	int eccsteps = chip->ecc.steps;
> +	uint8_t *p = buf;
> +	uint8_t *ecc_calc = chip->ecc.calc_buf;
> +	uint8_t *ecc_code = chip->ecc.code_buf;
> +
> +	uint8_t *oob_ptr;
> +	u32 ret;
> +	unsigned long data_phase_addr;
> +	unsigned long timeout = jiffies + PL353_NAND_DEV_BUSY_TIMEOUT;
> +
> +	pl353_prepare_cmd(mtd, chip, page, 0, NAND_CMD_READ0,
> +		NAND_CMD_READSTART, 1);
> +	ndelay(100);
> +	do {
> +		if (chip->dev_ready(mtd))
> +			break;
> +		cpu_relax();
> +	} while (!time_after_eq(jiffies, timeout));
> +
> +	if (time_after_eq(jiffies, timeout)) {
> +		pr_err("%s timed out\n", __func__);
> +		return -1;
> +	}
> +	for ( ; (eccsteps - 1); eccsteps--) {
> +		pl353_nand_read_buf_l(chip, p, eccsize);
> +		p += eccsize;
> +	}
> +	pl353_nand_read_buf_l(chip, p,
> +		(eccsize - PL353_NAND_LAST_TRANSFER_LENGTH));
> +	p += (eccsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	/* Set ECC Last bit to 1 */
> +	data_phase_addr = (unsigned long __force)chip->IO_ADDR_R;
> +	data_phase_addr |= PL353_NAND_ECC_LAST;
> +	chip->IO_ADDR_R = (void __iomem * __force)data_phase_addr;
> +	pl353_nand_read_buf_l(chip, p, PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	/* Read the calculated ECC value */
> +	p = buf;
> +	chip->ecc.calculate(mtd, p, &ecc_calc[0]);
> +
> +	/* Clear ECC last bit */
> +	data_phase_addr = (unsigned long __force)chip->IO_ADDR_R;
> +	data_phase_addr &= ~PL353_NAND_ECC_LAST;
> +	chip->IO_ADDR_R = (void __iomem * __force)data_phase_addr;
> +
> +	/* Read the stored ECC value */
> +	oob_ptr = chip->oob_poi;
> +	pl353_nand_read_buf_l(chip, oob_ptr,
> +		(mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH));
> +
> +	/* de-assert chip select */
> +	data_phase_addr = (unsigned long __force)chip->IO_ADDR_R;
> +	data_phase_addr |= PL353_NAND_CLEAR_CS;
> +	chip->IO_ADDR_R = (void __iomem * __force)data_phase_addr;
> +
> +	oob_ptr += (mtd->oobsize - PL353_NAND_LAST_TRANSFER_LENGTH);
> +	pl353_nand_read_buf_l(chip, oob_ptr,  PL353_NAND_LAST_TRANSFER_LENGTH);
> +
> +	ret = mtd_ooblayout_get_eccbytes(mtd, ecc_code, chip->oob_poi, 0,
> +						 chip->ecc.total);
> +	if (ret)
> +		return ret;
> +
> +	eccsteps = chip->ecc.steps;
> +	p = buf;
> +
> +	/* Check ECC error for all blocks and correct if it is correctable */
> +	for (i = 0 ; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {

In this loop you should monitore a max_bitflips value and return it
instead of zero at the end of the function.

> +		stat = chip->ecc.correct(mtd, p, &ecc_code[i], &ecc_calc[i]);
> +		if (stat < 0)
> +			mtd->ecc_stats.failed++;
> +		else
> +			mtd->ecc_stats.corrected += stat;
> +	}
> +	return 0;
> +}
> +
> +/**
> + * pl353_nand_read_page_swecc - [REPLACEABLE] software ecc based page read
> + *				function
> + * @mtd:		Pointer to the mtd info structure
> + * @chip:		Pointer to the NAND chip info structure
> + * @buf:		Pointer to the buffer to store read data
> + * @oob_required:	Caller requires OOB data read to chip->oob_poi
> + * @page:		Page number to read
> + *
> + * Return:	Always return zero
> + */
> +static int pl353_nand_read_page_swecc(struct mtd_info *mtd,
> +				     struct nand_chip *chip,
> +				     uint8_t *buf,  int oob_required, int page)
> +{

Same, you probably don't need this function.

> +	int i, eccsize = chip->ecc.size;
> +	int eccbytes = chip->ecc.bytes;
> +	int eccsteps = chip->ecc.steps;
> +	uint8_t *p = buf;
> +	uint8_t *ecc_calc = chip->ecc.calc_buf;
> +	uint8_t *ecc_code = chip->ecc.code_buf;
> +	u32 ret;
> +
> +	chip->ecc.read_page_raw(mtd, chip, buf, page, 1);
> +
> +	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize)
> +		chip->ecc.calculate(mtd, p, &ecc_calc[i]);
> +
> +	ret = mtd_ooblayout_get_eccbytes(mtd, ecc_calc, chip->oob_poi,
> +						0, chip->ecc.total);
> +
> +	eccsteps = chip->ecc.steps;
> +	p = buf;
> +
> +	for (i = 0 ; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
> +		int stat;
> +
> +		stat = chip->ecc.correct(mtd, p, &ecc_code[i], &ecc_calc[i]);
> +		if (stat < 0)
> +			mtd->ecc_stats.failed++;
> +		else
> +			mtd->ecc_stats.corrected += stat;
> +	}
> +	return 0;
> +}
> +
> +/**
> + * pl353_nand_select_chip - Select the flash device
> + * @mtd:	Pointer to the mtd info structure
> + * @chip:	Pointer to the NAND chip info structure
> + *
> + * This function is empty as the NAND controller handles chip select line
> + * internally based on the chip address passed in command and data phase.
> + */
> +static void pl353_nand_select_chip(struct mtd_info *mtd, int chip)
> +{
> +}
> +
> +/* NAND framework ->exec_op() hooks and related helpers */
> +static void pl353_nfc_parse_instructions(struct nand_chip *chip,
> +					   const struct nand_subop *subop,
> +					   struct pl353_nfc_op *nfc_op)
> +{
> +	const struct nand_op_instr *instr = NULL;
> +	unsigned int op_id, offset, naddrs;
> +	int i;
> +	const u8 *addrs;
> +
> +	memset(nfc_op, 0, sizeof(struct pl353_nfc_op));
> +	for (op_id = 0; op_id < subop->ninstrs; op_id++) {
> +

What is this for-loop for? I don't get it as you break the switch in
every case?

> +		nfc_op->len = nand_subop_get_data_len(subop, op_id);
> +
> +		instr = &subop->instrs[op_id];
> +		if (subop->ninstrs == 1)
> +			nfc_op->cmnds[0] = -1;
> +		switch (instr->type) {
> +		case NAND_OP_CMD_INSTR:
> +			nfc_op->type = NAND_OP_CMD_INSTR;
> +			nfc_op->end_cmd = op_id - 1;
> +			if (op_id)

You should put { } on the if also if the else statement needs braces.

> +				nfc_op->cmnds[1] = instr->ctx.cmd.opcode;
> +			else {
> +				nfc_op->cmnds[0] = instr->ctx.cmd.opcode;
> +				nfc_op->cmnds[1] = -1;
> +			}
> +			break;
> +
> +		case NAND_OP_ADDR_INSTR:
> +			offset = nand_subop_get_addr_start_off(subop, op_id);
> +			naddrs = nand_subop_get_num_addr_cyc(subop, op_id);
> +			addrs = &instr->ctx.addr.addrs[offset];
> +			nfc_op->addrs = instr->ctx.addr.addrs[offset];
> +			for (i = 0; i < min_t(unsigned int, 4, naddrs); i++)
> +				nfc_op->addrs |= instr->ctx.addr.addrs[i] <<
> +						 (8 * i);
> +
> +			if (naddrs >= 5) {
> +				nfc_op->addrs >>= 16;
> +				nfc_op->addrs |= (addrs[4] << 16);
> +				nfc_op->thirdrow = 1;
> +			}
> +			nfc_op->naddrs = nand_subop_get_num_addr_cyc
> +						(subop, op_id);

Don't put the parameters of a function on the next line like that?

> +			break;
> +
> +		case NAND_OP_DATA_IN_INSTR:
> +			nfc_op->data_instr = instr;
> +			nfc_op->type = NAND_OP_DATA_IN_INSTR;
> +			nfc_op->data_instr_idx = op_id;
> +			break;
> +
> +		case NAND_OP_DATA_OUT_INSTR:
> +			nfc_op->data_instr = instr;
> +			nfc_op->type = NAND_OP_DATA_IN_INSTR;
DATA_OUT_INSTR?

Is this really tested?

> +			nfc_op->data_instr_idx = op_id;
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
> +/**
> + * pl353_nand_cmd_function - Send command to NAND device
> + * @chip:	Pointer to the NAND chip info structure
> + * @subop:	Pointer to array of instructions
> + * Return:	Always return zero
> + */
> +static int pl353_nand_cmd_function(struct nand_chip *chip,
> +					      const struct nand_subop *subop)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	const struct nand_op_instr *instr;
> +	struct pl353_nfc_op nfc_op;

nfc_op = {}; to initialize to 0.

> +	struct pl353_nand_info *xnand =
> +		container_of(chip, struct pl353_nand_info, chip);
> +	void __iomem *cmd_addr;
> +	unsigned long cmd_data = 0, end_cmd_valid = 0;
> +	unsigned long cmd_phase_addr, data_phase_addr, end_cmd;
> +	unsigned long timeout = jiffies + PL353_NAND_DEV_BUSY_TIMEOUT;
> +	u32 addrcycles = 0;
> +	unsigned int op_id, len, offset;
> +
> +	pl353_nfc_parse_instructions(chip, subop, &nfc_op);
> +	instr = nfc_op.data_instr;
> +	op_id = nfc_op.data_instr_idx;
> +	len = nand_subop_get_data_len(subop, op_id);
> +	offset = nand_subop_get_data_start_off(subop, op_id);
> +
> +	if (nfc_op.cmnds[0] != -1) {
> +		if (xnand->end_cmd_pending) {
> +			/*
> +			 * Check for end command if this command request is
> +			 * same as the pending command then return
> +			 */
> +			if (xnand->end_cmd == nfc_op.cmnds[0]) {
> +				xnand->end_cmd = 0;
> +				xnand->end_cmd_pending = 0;
> +				return 0;
> +			}
> +		}
> +
> +		/* Clear interrupt */
> +		pl353_smc_clr_nand_int();
> +		end_cmd_valid = 0;

Space

> +		/* Get the command phase address */
> +		if (nfc_op.cmnds[1] != -1) {
> +			end_cmd_valid = 1;
> +		} else {
> +			if (nfc_op.cmnds[0] == NAND_CMD_READ0)
> +				return 0;
> +		}
> +		if (nfc_op.end_cmd == NAND_CMD_NONE)
> +			end_cmd = 0x0;
> +		else
> +			end_cmd = nfc_op.cmnds[1];
> +
> +		addrcycles = nfc_op.naddrs;
> +		if (nfc_op.cmnds[0] == NAND_CMD_READ0 ||
> +			nfc_op.cmnds[0] == NAND_CMD_SEQIN)
> +			addrcycles = xnand->row_addr_cycles +
> +					xnand->col_addr_cycles;
> +		else if ((nfc_op.cmnds[0] == NAND_CMD_ERASE1) ||
> +			(nfc_op.cmnds[0] == NAND_CMD_ERASE2))
> +			addrcycles = xnand->row_addr_cycles;
> +		else
> +			addrcycles = nfc_op.naddrs;

A switch block would probably be appropriate.

> +		cmd_phase_addr = (unsigned long __force)xnand->nand_base + (
> +				 (addrcycles << ADDR_CYCLES_SHIFT)	|
> +				 (end_cmd_valid << END_CMD_VALID_SHIFT)	|
> +				 (COMMAND_PHASE)			|
> +				 (end_cmd << END_CMD_SHIFT)		|
> +				 (nfc_op.cmnds[0] << START_CMD_SHIFT));
> +
> +		cmd_addr = (void __iomem * __force)cmd_phase_addr;

Space

> +		/* Get the data phase address */
> +		end_cmd_valid = 0;
> +
> +		data_phase_addr = (unsigned long __force)xnand->nand_base + (
> +				  (0x0 << CLEAR_CS_SHIFT)		|
> +				  (end_cmd_valid << END_CMD_VALID_SHIFT)|
> +				  (DATA_PHASE)				|
> +				  (end_cmd << END_CMD_SHIFT)		|
> +				  (0x0 << ECC_LAST_SHIFT));
> +		chip->IO_ADDR_R = (void __iomem * __force)data_phase_addr;

Do you really need this "__force" ?

> +		chip->IO_ADDR_W = chip->IO_ADDR_R;
> +		/* Command phase AXI write */
> +		/* Read & Write */
> +		if (nfc_op.thirdrow) {
> +			nfc_op.thirdrow = 0;
> +			if (mtd->writesize > PL353_NAND_ECC_SIZE) {
> +				cmd_data |= nfc_op.addrs << 16;
> +				/* Another address cycle for devices > 128MiB */
> +				if (chip->chipsize > (128 << 20)) {
> +					pl353_nand_write32(cmd_addr, cmd_data);
> +					cmd_data = (nfc_op.addrs >> 16);
> +				}
> +			}
> +		}  else {
> +			if (nfc_op.addrs != -1) {
> +				int column = nfc_op.addrs;
> +				/*
> +				 * Change read/write column, read id etc
> +				 * Adjust columns for 16 bit bus width
> +				 */
> +				if ((chip->options & NAND_BUSWIDTH_16) &&
> +				((nfc_op.cmnds[0] == NAND_CMD_READ0) ||
> +				(nfc_op.cmnds[0] == NAND_CMD_SEQIN) ||
> +				(nfc_op.cmnds[0] == NAND_CMD_RNDOUT) ||
> +				(nfc_op.cmnds[0] == NAND_CMD_RNDIN))) {

Alignment.

> +					column >>= 1;
> +				}
> +				cmd_data = nfc_op.addrs;
> +			}
> +		}
> +		pl353_nand_write32(cmd_addr, cmd_data);
> +		if (nfc_op.type != 0) {
> +			xnand->end_cmd = nfc_op.end_cmd;
> +			xnand->end_cmd_pending = 1;
> +		}
> +		ndelay(100);

Why?

> +		if (nfc_op.cmnds[0] == 0xef)
> +			nfc_op.wait = false;
> +		if (nfc_op.wait) {
> +			nfc_op.wait = false;

You can remove this line.

> +			do {
> +				if (chip->dev_ready(mtd))
> +					break;
> +				cpu_relax();
> +			} while (!time_after_eq(jiffies, timeout));
> +			if (time_after_eq(jiffies, timeout)) {
> +				pr_err("%s timed out\n", __func__);
> +				return -ETIMEDOUT;
> +			}

Same comment about the wait.

> +			return 0;
> +		}
> +	}
> +
> +	if (instr == NULL)

if (!instr)

> +		return 0;
> +	if (instr->type == NAND_OP_DATA_IN_INSTR)
> +		return pl353_nand_read_buf(chip, instr->ctx.data.buf.in, len);
> +
> +	if (instr->type == NAND_OP_DATA_OUT_INSTR) {
> +		if ((nfc_op.cmnds[0] == NAND_CMD_PAGEPROG) ||
> +			(nfc_op.cmnds[0] == NAND_CMD_SEQIN))
> +			pl353_nand_write_page_raw(mtd, chip,
> +			instr->ctx.data.buf.out, 0, nfc_op.addrs);
> +		else
> +			pl353_nand_write_buf_l(chip, instr->ctx.data.buf.out,
> +				len);
> +		return 0;
> +	}
> +	return 0;
> +}
> +
> +static const struct nand_op_parser pl353_nfc_op_parser = NAND_OP_PARSER(
> +	NAND_OP_PARSER_PATTERN(
> +		pl353_nand_cmd_function,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 7),
> +		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 8)),
> +	 NAND_OP_PARSER_PATTERN(
> +		pl353_nand_cmd_function,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 7),
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
> +	NAND_OP_PARSER_PATTERN(
> +		pl353_nand_cmd_function,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 8)),
> +	 NAND_OP_PARSER_PATTERN(
> +		pl353_nand_cmd_function,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 7),
> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
> +	NAND_OP_PARSER_PATTERN(
> +		pl353_nand_cmd_function,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 8),
> +		NAND_OP_PARSER_PAT_DATA_OUT_ELEM(false, 2048),
> +		NAND_OP_PARSER_PAT_CMD_ELEM(true),
> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(true)),
> +	NAND_OP_PARSER_PATTERN(
> +		pl353_nand_cmd_function,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),
> +	NAND_OP_PARSER_PATTERN(
> +		pl353_nand_cmd_function,
> +		NAND_OP_PARSER_PAT_DATA_IN_ELEM(false, 2048)),
> +	NAND_OP_PARSER_PATTERN(
> +		pl353_nand_cmd_function,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false)),

I am pretty sure you can factorize all these patterns now. Use the
"optional" parameter for that.

> +	);
> +
> +static int pl353_nfc_exec_op(struct nand_chip *chip,
> +			       const struct nand_operation *op,
> +			       bool check_only)
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

I don't understand where this new function is declared.

> +		pl353_smc_clr_nand_int();
> +		return 1;
> +	}
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
> +static void pl353_nand_ecc_init(struct mtd_info *mtd, struct nand_ecc_ctrl *ecc,
> +	int ecc_mode)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +
> +	ecc->read_oob = pl353_nand_read_oob;
> +	ecc->read_page_raw = pl353_nand_read_page_raw;
> +	ecc->write_oob = pl353_nand_write_oob;
> +	ecc->write_page_raw = pl353_nand_write_page_raw;
> +
> +	if (ecc_mode == NAND_ECC_ON_DIE) {
> +		pl353_smc_set_ecc_mode(PL353_SMC_ECCMODE_BYPASS);
> +
> +		/*
> +		 * The software ECC routines won't work with the
> +		 * SMC controller
> +		 */
> +		ecc->read_page = pl353_nand_read_page_raw;
> +		ecc->write_page = pl353_nand_write_page_raw;
> +		/*
> +		 * On-Die ECC spare bytes offset 8 is used for ECC codes
> +		 * Use the BBT pattern descriptors
> +		 */
> +		chip->bbt_td = &bbt_main_descr;
> +		chip->bbt_md = &bbt_mirror_descr;
> +	} else {
> +		ecc->mode = NAND_ECC_HW;
> +		/* Hardware ECC generates 3 bytes ECC code for each 512 bytes */
> +		ecc->bytes = 3;
> +		ecc->strength = 1;
> +		ecc->calculate = pl353_nand_calculate_hwecc;
> +		ecc->correct = pl353_nand_correct_data;
> +		ecc->hwctl = NULL;

You can drop this.

> +		ecc->read_page = pl353_nand_read_page_hwecc;
> +		ecc->size = PL353_NAND_ECC_SIZE;
> +		ecc->write_page = pl353_nand_write_page_hwecc;
> +		pl353_smc_set_ecc_pg_size(mtd->writesize);
> +		switch (mtd->writesize) {
> +		case 512:
> +		case 1024:
> +		case 2048:

I prefer SZ_512, SZ_1K, SZ_2K.

> +			pl353_smc_set_ecc_mode(PL353_SMC_ECCMODE_APB);
> +			break;
> +		default:
> +			/*
> +			 * The software ECC routines won't work with the
> +			 * SMC controller
> +			 */
> +			ecc->calculate = nand_calculate_ecc;
> +			ecc->correct = nand_correct_data;
> +			ecc->read_page = pl353_nand_read_page_swecc;
> +			ecc->write_page = pl353_nand_write_page_swecc;
> +			ecc->size = 256;
> +			break;
> +		}
> +
> +		if (mtd->oobsize == 16)
> +			mtd_set_ooblayout(mtd, &pl353_ecc_ooblayout16_ops);
> +		else if (mtd->oobsize == 64)
> +			mtd_set_ooblayout(mtd, &pl353_ecc_ooblayout64_ops);
> +	}
> +}
> +
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
> +	struct pl353_nand_info *xnand;
> +	struct mtd_info *mtd;
> +	struct nand_chip *nand_chip;
> +	struct resource *res;
> +
> +	xnand = devm_kzalloc(&pdev->dev, sizeof(*xnand), GFP_KERNEL);
> +	if (!xnand)
> +		return -ENOMEM;
> +
> +	/* Map physical address of NAND flash */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	xnand->nand_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(xnand->nand_base))
> +		return PTR_ERR(xnand->nand_base);
> +
> +	nand_chip = &xnand->chip;
> +	mtd = nand_to_mtd(nand_chip);
> +	nand_chip->exec_op = pl353_nfc_exec_op;
> +	nand_set_controller_data(nand_chip, xnand);
> +	mtd->priv = nand_chip;
> +	mtd->owner = THIS_MODULE;
> +	mtd->name = PL353_NAND_DRIVER_NAME;
> +	nand_set_flash_node(nand_chip, pdev->dev.of_node);
> +
> +	/* Set address of NAND IO lines */
> +	nand_chip->IO_ADDR_R = xnand->nand_base;
> +	nand_chip->IO_ADDR_W = xnand->nand_base;
> +	/* Set the driver entry points for MTD */
> +	nand_chip->dev_ready = pl353_nand_device_ready;
> +	nand_chip->select_chip = pl353_nand_select_chip;
> +	/* If we don't set this delay driver sets 20us by default */
> +	nand_chip->chip_delay = 30;
> +
> +	/* Set the device option and flash width */
> +	nand_chip->options = NAND_BUSWIDTH_AUTO;
> +	nand_chip->bbt_options = NAND_BBT_USE_FLASH;
> +	platform_set_drvdata(pdev, xnand);
> +
> +	/* first scan to find the device and get the page size */
> +	if (nand_scan_ident(mtd, 1, NULL)) {
> +		dev_err(&pdev->dev, "nand_scan_ident for NAND failed\n");
> +		return -ENXIO;
> +	}
> +
> +	xnand->row_addr_cycles = nand_chip->onfi_params.addr_cycles & 0xF;
> +	xnand->col_addr_cycles =
> +				(nand_chip->onfi_params.addr_cycles >> 4) & 0xF;
> +
> +	pl353_nand_ecc_init(mtd, &nand_chip->ecc, nand_chip->ecc.mode);
> +	if (nand_chip->options & NAND_BUSWIDTH_16)
> +		pl353_smc_set_buswidth(PL353_SMC_MEM_WIDTH_16);
> +	/* second phase scan */
> +	if (nand_scan_tail(mtd)) {
> +		dev_err(&pdev->dev, "nand_scan_tail for NAND failed\n");
> +		return -ENXIO;
> +	}
> +
> +	mtd_device_register(mtd, NULL, 0);
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
> +	struct pl353_nand_info *xnand = platform_get_drvdata(pdev);
> +	struct mtd_info *mtd = nand_to_mtd(&xnand->chip);
> +
> +	/* Release resources, unregister device */
> +	nand_release(mtd);
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

Thanks,
Miquèl

-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
