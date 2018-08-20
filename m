Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13090C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BC120C0F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96BC120C0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbeHTT4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:56:39 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47352 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbeHTT4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:56:39 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3352F2072D; Mon, 20 Aug 2018 18:40:14 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id BEFC520618;
        Mon, 20 Aug 2018 18:40:13 +0200 (CEST)
Date:   Mon, 20 Aug 2018 18:40:13 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <kyungmin.park@samsung.com>,
        <absahu@codeaurora.org>, <peterpandong@micron.com>,
        <frieder.schrempf@exceet.de>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <michals@xilinx.com>,
        <nagasureshkumarrelli@gmail.com>
Subject: Re: [LINUX PATCH v10 2/2] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Message-ID: <20180820184013.57fd7b5c@bbrezillon>
In-Reply-To: <1534511964-20342-3-git-send-email-naga.sureshkumar.relli@xilinx.com>
References: <1534511964-20342-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1534511964-20342-3-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naga,

On Fri, 17 Aug 2018 18:49:24 +0530
Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote:

>  
> +config MTD_NAND_ARASAN
> +	tristate "Support for Arasan Nand Flash controller"
> +	depends on HAS_IOMEM
> +	depends on HAS_DMA

Just nitpicking, but you can place them on the same line:

	depends on HAS_IOMEM && HAS_DMA

> +	help
> +	  Enables the driver for the Arasan Nand Flash controller on
> +	  Zynq Ultrascale+ MPSoC.
> +
>  endif # MTD_NAND
> diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
> index d5a5f98..ccb8d56 100644
> --- a/drivers/mtd/nand/raw/Makefile
> +++ b/drivers/mtd/nand/raw/Makefile
> @@ -57,6 +57,7 @@ obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= brcmnand/
>  obj-$(CONFIG_MTD_NAND_QCOM)		+= qcom_nandc.o
>  obj-$(CONFIG_MTD_NAND_MTK)		+= mtk_ecc.o mtk_nand.o
>  obj-$(CONFIG_MTD_NAND_TEGRA)		+= tegra_nand.o
> +obj-$(CONFIG_MTD_NAND_ARASAN)		+= arasan_nand.o
>  
>  nand-objs := nand_base.o nand_bbt.o nand_timings.o nand_ids.o
>  nand-objs += nand_amd.o
> diff --git a/drivers/mtd/nand/raw/arasan_nand.c b/drivers/mtd/nand/raw/arasan_nand.c
> new file mode 100644
> index 0000000..e4f1f80
> --- /dev/null
> +++ b/drivers/mtd/nand/raw/arasan_nand.c
> @@ -0,0 +1,1350 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Arasan NAND Flash Controller Driver
> + *
> + * Copyright (C) 2014 - 2017 Xilinx, Inc.
> + * Author: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
> + * Author: Naga Sureshkumar Relli <nagasure@xilinx.com>
> + *
> + */
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/interrupt.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/module.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/rawnand.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>

Blank line missing here.

> +#define DRIVER_NAME			"arasan_nand"

Please define drop this definition and pass the string directly to
driver->name. The driver is for a nand controller, so make it clear,
also, it's just a detail but I prefer '-' to '_', so, how about
"arasan-nand-controller"?

> +#define EVNT_TIMEOUT_MSEC		1000

It's unusual to have EVNT, it's usually EVT or EVENT.

> +#define STATUS_TIMEOUT			2000

Is it in milliseconds? Please add the proper _<UNIT> prefix here.

> +
> +#define PKT_OFST			0x00
> +#define MEM_ADDR1_OFST			0x04
> +#define MEM_ADDR2_OFST			0x08
> +#define CMD_OFST			0x0C
> +#define PROG_OFST			0x10
> +#define INTR_STS_EN_OFST		0x14
> +#define INTR_SIG_EN_OFST		0x18
> +#define INTR_STS_OFST			0x1C
> +#define READY_STS_OFST			0x20
> +#define DMA_ADDR1_OFST			0x24
> +#define FLASH_STS_OFST			0x28
> +#define DATA_PORT_OFST			0x30
> +#define ECC_OFST			0x34
> +#define ECC_ERR_CNT_OFST		0x38
> +#define ECC_SPR_CMD_OFST		0x3C
> +#define ECC_ERR_CNT_1BIT_OFST		0x40
> +#define ECC_ERR_CNT_2BIT_OFST		0x44
> +#define DMA_ADDR0_OFST			0x50
> +#define DATA_INTERFACE_OFST		0x6C
> +
> +#define PKT_CNT_SHIFT			12
> +
> +#define ECC_ENABLE			BIT(31)
> +#define DMA_EN_MASK			GENMASK(27, 26)
> +#define DMA_ENABLE			0x2
> +#define DMA_EN_SHIFT			26
> +#define REG_PAGE_SIZE_SHIFT		23
> +#define REG_PAGE_SIZE_512		0
> +#define REG_PAGE_SIZE_1K		5
> +#define REG_PAGE_SIZE_2K		1
> +#define REG_PAGE_SIZE_4K		2
> +#define REG_PAGE_SIZE_8K		3
> +#define REG_PAGE_SIZE_16K		4
> +#define CMD2_SHIFT			8
> +#define ADDR_CYCLES_SHIFT		28
> +
> +#define XFER_COMPLETE			BIT(2)
> +#define READ_READY			BIT(1)
> +#define WRITE_READY			BIT(0)
> +#define MBIT_ERROR			BIT(3)
> +
> +#define PROG_PGRD			BIT(0)
> +#define PROG_ERASE			BIT(2)
> +#define PROG_STATUS			BIT(3)
> +#define PROG_PGPROG			BIT(4)
> +#define PROG_RDID			BIT(6)
> +#define PROG_RDPARAM			BIT(7)
> +#define PROG_RST			BIT(8)
> +#define PROG_GET_FEATURE		BIT(9)
> +#define PROG_SET_FEATURE		BIT(10)
> +
> +#define PG_ADDR_SHIFT			16
> +#define BCH_MODE_SHIFT			25
> +#define BCH_EN_SHIFT			27
> +#define ECC_SIZE_SHIFT			16
> +
> +#define MEM_ADDR_MASK			GENMASK(7, 0)
> +#define BCH_MODE_MASK			GENMASK(27, 25)
> +
> +#define CS_MASK				GENMASK(31, 30)
> +#define CS_SHIFT			30
> +
> +#define PAGE_ERR_CNT_MASK		GENMASK(16, 8)
> +#define PKT_ERR_CNT_MASK		GENMASK(7, 0)
> +
> +#define NVDDR_MODE			BIT(9)
> +#define NVDDR_TIMING_MODE_SHIFT		3
> +
> +#define ONFI_ID_LEN			8
> +#define TEMP_BUF_SIZE			1024
> +#define NVDDR_MODE_PACKET_SIZE		8
> +#define SDR_MODE_PACKET_SIZE		4
> +
> +#define ONFI_DATA_INTERFACE_NVDDR      BIT(4)
> +#define EVENT_MASK	(XFER_COMPLETE | READ_READY | WRITE_READY | MBIT_ERROR)
> +
> +#define SDR_MODE_DEFLT_FREQ		80000000
> +#define COL_ROW_ADDR(pos, val)			(((val) & 0xFF) << (8 * (pos)))

Can you try to group registers offsets with their fields?

> +
> +struct anfc_op {
> +	s32 cmnds[4];

	    ^ cmds?

And why is it an s32 and not a u32?

> +	u32 type;
> +	u32 len;
> +	u32 naddrs;
> +	u32 col;
> +	u32 row;
> +	unsigned int data_instr_idx;
> +	unsigned int rdy_timeout_ms;
> +	unsigned int rdy_delay_ns;
> +	const struct nand_op_instr *data_instr;
> +};

Please make sure you actually need to redefine all these fields. Looks
like some them could be extracted directly from the nand_op_instr
objects.

> +
> +/**
> + * struct anfc_nand_chip - Defines the nand chip related information
> + * @node:		used to store NAND chips into a list.
> + * @chip:		NAND chip information structure.
> + * @bch:		Bch / Hamming mode enable/disable.
> + * @bchmode:		Bch mode.

What's the difference between bch and bchmode?

> + * @eccval:		Ecc config value.
> + * @raddr_cycles:	Row address cycle information.
> + * @caddr_cycles:	Column address cycle information.
> + * @pktsize:		Packet size for read / write operation.
> + * @csnum:		chipselect number to be used.

So that means you only support chips with a single CS, right?

> + * @spktsize:		Packet size in ddr mode for status operation.
> + * @inftimeval:		Data interface and timing mode information
> + */
> +struct anfc_nand_chip {
> +	struct list_head node;
> +	struct nand_chip chip;
> +	bool bch;
> +	u32 bchmode;
> +	u32 eccval;
> +	u16 raddr_cycles;
> +	u16 caddr_cycles;
> +	u32 pktsize;
> +	int csnum;
> +	u32 spktsize;
> +	u32 inftimeval;
> +};
> +

[...]

> +
> +static void anfc_rw_dma_op(struct mtd_info *mtd, uint8_t *buf, int len,
> +			    bool do_read, u32 prog)
> +{
> +	dma_addr_t paddr;
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
> +	struct anfc_nand_chip *achip = to_anfc_nand(chip);
> +	u32 eccintr = 0, dir;
> +	u32 pktsize = len, pktcount = 1;
> +
> +	if (((nfc->curr_cmd == NAND_CMD_READ0)) ||
> +	    (nfc->curr_cmd == NAND_CMD_SEQIN && !nfc->iswriteoob)) {

No, really, this looks wrong. If you need special handling for the
read_page() case, implement it in the chip->ecc.read_page[_raw]() hooks.

> +		pktsize = achip->pktsize;
> +		pktcount = DIV_ROUND_UP(mtd->writesize, pktsize);
> +	}
> +	anfc_setpktszcnt(nfc, pktsize, pktcount);
> +
> +	if (!achip->bch && nfc->curr_cmd == NAND_CMD_READ0)
> +		eccintr = MBIT_ERROR;

Again, this should go in chip->ecc.read_page().

> +
> +	if (do_read)
> +		dir = DMA_FROM_DEVICE;
> +	else
> +		dir = DMA_TO_DEVICE;
> +
> +	paddr = dma_map_single(nfc->dev, buf, len, dir);
> +	if (dma_mapping_error(nfc->dev, paddr)) {
> +		dev_err(nfc->dev, "Read buffer mapping error");
> +		return;
> +	}
> +	writel(paddr, nfc->base + DMA_ADDR0_OFST);
> +	writel((paddr >> 32), nfc->base + DMA_ADDR1_OFST);
> +	anfc_enable_intrs(nfc, (XFER_COMPLETE | eccintr));
> +	writel(prog, nfc->base + PROG_OFST);
> +	anfc_wait_for_event(nfc);
> +	dma_unmap_single(nfc->dev, paddr, len, dir);
> +}
> +
> +static void anfc_rw_pio_op(struct mtd_info *mtd, uint8_t *buf, int len,
> +			    bool do_read, int prog)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
> +	struct anfc_nand_chip *achip = to_anfc_nand(chip);
> +	u32 *bufptr = (u32 *)buf;
> +	u32 cnt = 0, intr = 0;
> +	u32 pktsize = len, pktcount = 1;
> +
> +	anfc_config_dma(nfc, 0);
> +
> +	if (((nfc->curr_cmd == NAND_CMD_READ0)) ||
> +	    (nfc->curr_cmd == NAND_CMD_SEQIN && !nfc->iswriteoob)) {
> +		pktsize = achip->pktsize;
> +		pktcount = DIV_ROUND_UP(mtd->writesize, pktsize);
> +	}
> +	anfc_setpktszcnt(nfc, pktsize, pktcount);
> +
> +	if (!achip->bch && nfc->curr_cmd == NAND_CMD_READ0)
> +		intr = MBIT_ERROR;
> +
> +	if (do_read)
> +		intr |= READ_READY;
> +	else
> +		intr |= WRITE_READY;
> +
> +	anfc_enable_intrs(nfc, intr);
> +	writel(prog, nfc->base + PROG_OFST);
> +	while (cnt < pktcount) {
> +
> +		anfc_wait_for_event(nfc);
> +		cnt++;
> +		if (cnt == pktcount)
> +			anfc_enable_intrs(nfc, XFER_COMPLETE);
> +		if (do_read)
> +			ioread32_rep(nfc->base + DATA_PORT_OFST, bufptr,
> +				     pktsize / 4);
> +		else
> +			iowrite32_rep(nfc->base + DATA_PORT_OFST, bufptr,
> +				      pktsize / 4);
> +		bufptr += (pktsize / 4);
> +		if (cnt < pktcount)
> +			anfc_enable_intrs(nfc, intr);
> +	}
> +	anfc_wait_for_event(nfc);
> +}
> +
> +static void anfc_read_data_op(struct mtd_info *mtd, uint8_t *buf, int len)

Pass a nand_chip object directly and use u8 instead of uint8_t. This
applies to all other internal functions you define.

> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
> +
> +	if (nfc->dma && !is_vmalloc_addr(buf))

You should use virt_is_valid() not is_vmalloc_addr(). Alternatively,
you can just set the NAND_USE_BOUNCE_BUFFER flag in chip->options, and
you'll be guaranteed to have a DMA-able buffer passed to the
chip->ecc.read/write_page_[raw]() hooks.

> +		anfc_rw_dma_op(mtd, buf, len, 1, PROG_PGRD);
> +	else
> +		anfc_rw_pio_op(mtd, buf, len, 1, PROG_PGRD);
> +}
> +
> +static void anfc_write_data_op(struct mtd_info *mtd, const uint8_t *buf,
> +			       int len)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
> +
> +	if (nfc->dma && !is_vmalloc_addr(buf))
> +		anfc_rw_dma_op(mtd, (char *)buf, len, 0, PROG_PGPROG);
> +	else
> +		anfc_rw_pio_op(mtd, (char *)buf, len, 0, PROG_PGPROG);
> +}
> +
> +static int anfc_prep_nand_instr(struct mtd_info *mtd, int cmd,
> +				struct nand_chip *chip,  int col, int page)
> +{
> +	u8 addrs[5];
> +
> +	struct nand_op_instr instrs[] = {
> +		NAND_OP_CMD(cmd, PSEC_TO_NSEC(1)),

Where do you get that delay from? Please don't use random delays.

> +		NAND_OP_ADDR(3, addrs, 0),
> +	};
> +	struct nand_operation op = NAND_OPERATION(instrs);
> +
> +	if (mtd->writesize <= 512) {
> +		addrs[0] = col;
> +		if (page != -1) {
> +			addrs[1] = page;
> +			addrs[2] = page >> 8;
> +			instrs[1].ctx.addr.naddrs = 3;
> +			if (chip->options & NAND_ROW_ADDR_3) {
> +				addrs[3] = page >> 16;
> +				instrs[1].ctx.addr.naddrs += 1;
> +			}
> +		} else {
> +			instrs[1].ctx.addr.naddrs = 1;
> +		}
> +	} else {
> +		addrs[0] = col;
> +		addrs[1] = col >> 8;
> +		if (page != -1) {
> +			addrs[2] = page;
> +			addrs[3] = page >> 8;
> +			instrs[1].ctx.addr.naddrs = 4;
> +			if (chip->options & NAND_ROW_ADDR_3) {
> +				addrs[4] = page >> 16;
> +				instrs[1].ctx.addr.naddrs += 1;
> +			}
> +		} else {
> +			instrs[1].ctx.addr.naddrs = 2;
> +		}
> +	}

Hm, why do you need to do that? The core already provide appropriate
helpers abstracting that for you. What's missing?

> +
> +	return nand_exec_op(chip, &op);
> +}
> +
> +static int anfc_nand_wait(struct mtd_info *mtd, struct nand_chip *chip)
> +{
> +	u8 status;
> +	int ret;
> +	unsigned long timeo;
> +
> +	/*
> +	 * Apply this short delay always to ensure that we do wait tWB in any
> +	 * case on any machine.
> +	 */
> +	ndelay(100);
> +	timeo = jiffies + msecs_to_jiffies(STATUS_TIMEOUT);
> +	do {
> +		ret = nand_status_op(chip, &status);
> +		if (ret)
> +			return ret;
> +
> +		if (status & NAND_STATUS_READY)
> +			break;
> +		cond_resched();
> +	} while (time_before(jiffies, timeo));

We have an helper doing that for you. Plus, ->waitfunc() should not be
implemented when ->exec_op() is implemented.

> +
> +
> +	return status;
> +}
> +
> +static int anfc_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
> +			  int page)
> +{
> +	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
> +
> +	nfc->iswriteoob = true;
> +	anfc_prep_nand_instr(mtd, NAND_CMD_SEQIN, chip, mtd->writesize, page);
> +	anfc_write_data_op(mtd, chip->oob_poi, mtd->oobsize);
> +	nfc->iswriteoob = false;

I'm really not a big fan of this ->iswriteoob var. Not sure why it's
used for.

> +
> +	return 0;
> +}


> +static int anfc_write_page_hwecc(struct mtd_info *mtd,
> +				 struct nand_chip *chip, const uint8_t *buf,
> +				 int oob_required, int page)
> +{
> +	int ret;
> +	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
> +	struct anfc_nand_chip *achip = to_anfc_nand(chip);
> +	u8 status;
> +	u8 *ecc_calc = chip->ecc.calc_buf;
> +
> +	ret = nand_prog_page_begin_op(chip, page, 0, NULL, 0);
> +	if (ret)
> +		return ret;
> +
> +	anfc_set_eccsparecmd(nfc, achip, NAND_CMD_RNDIN, 0);
> +	anfc_config_ecc(nfc, true);
> +	anfc_write_data_op(mtd, buf, mtd->writesize);
> +
> +	if (oob_required) {
> +		status = anfc_nand_wait(mtd, chip);
> +		if (status & NAND_STATUS_FAIL)
> +			return -EIO;
> +
> +		anfc_prep_nand_instr(mtd, NAND_CMD_READOOB, chip, 0, page);
> +		anfc_read_data_op(mtd, ecc_calc, mtd->oobsize);
> +		ret = mtd_ooblayout_set_eccbytes(mtd, ecc_calc, chip->oob_poi,
> +						 0, chip->ecc.total);
> +		if (ret)
> +			return ret;

No, that's not how we do. Just take the OOB bytes placed in
chip->oob_poi.

> +
> +		chip->ecc.write_oob(mtd, chip, page);
> +	}
> +	status = anfc_nand_wait(mtd, chip);
> +	if (status & NAND_STATUS_FAIL)
> +		return -EIO;
> +
> +	anfc_config_ecc(nfc, false);
> +
> +	return 0;
> +}
> +
> +/**
> + * anfc_get_mode_frm_timings - Converts sdr timing values to respective modes
> + * @sdr: SDR NAND chip timings structure
> + * Arasan NAND controller has Data Interface Register (0x6C)
> + * which has timing mode configurations and need to program only the modes but
> + * not timings. So this function returns SDR timing mode from SDR timing values
> + *
> + * Return: 	SDR timing mode on success, a negative error code otherwise.
> + */
> +static int anfc_get_mode_frm_timings(const struct nand_sdr_timings *sdr)
> +{
> +	if (sdr->tRC_min <= 20000)
> +		return 5;
> +	else if (sdr->tRC_min <= 25000)
> +		return 4;
> +	else if (sdr->tRC_min <= 30000)
> +		return 3;
> +	else if (sdr->tRC_min <= 35000)
> +		return 2;
> +	else if (sdr->tRC_min <= 50000)
> +		return 1;
> +	else if (sdr->tRC_min <= 100000)
> +		return 0;
> +	else
> +		return -1;
> +}

I'm sure we can add an onfi_timing_mode field in nand_sdr_timings so
that you don't have to guess it based on ->tRC.

> +static int anfc_erase_function(struct nand_chip *chip,
> +				   struct anfc_op nfc_op)
> +{
> +
> +	struct anfc_nand_chip *achip = to_anfc_nand(chip);
> +	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
> +
> +	nfc->prog = PROG_ERASE;
> +	anfc_prepare_cmd(nfc, nfc_op.cmnds[0], NAND_CMD_ERASE2, 0, 0,

Please don't guess the opcodes. The pattern descriptors are just here
to describe a sequence of CMD, ADDR and DATA cycles, nothing more. The
CMD opcodes can be tweaked if needed as long as the sequence is the
same.

> +			 achip->raddr_cycles);
> +	nfc_op.col = nfc_op.row & 0xffff;
> +	nfc_op.row = (nfc_op.row >> PG_ADDR_SHIFT) & 0xffff;
> +	anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
> +
> +	anfc_enable_intrs(nfc, XFER_COMPLETE);
> +	writel(nfc->prog, nfc->base + PROG_OFST);
> +	anfc_wait_for_event(nfc);
> +
> +	return 0;
> +}

> +static int anfc_reset_type_exec(struct nand_chip *chip,
> +				   const struct nand_subop *subop)
> +{
> +	struct anfc_op nfc_op = {};
> +	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
> +
> +	anfc_parse_instructions(chip, subop, &nfc_op);
> +	anfc_prepare_cmd(nfc, nfc_op.cmnds[0], 0, 0, 0, 0);
> +	nfc->prog = PROG_RST;
> +	anfc_enable_intrs(nfc, XFER_COMPLETE);
> +	writel(nfc->prog, nfc->base + PROG_OFST);
> +	anfc_wait_for_event(nfc);
> +
> +	return 0;
> +}

This one looks correct.

> +
> +static const struct nand_op_parser anfc_op_parser = NAND_OP_PARSER
> +	(NAND_OP_PARSER_PATTERN
> +		(anfc_exec_op_cmd,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 7),
> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false),
> +		NAND_OP_PARSER_PAT_DATA_IN_ELEM(true, 2048)),
> +	NAND_OP_PARSER_PATTERN
> +		(anfc_exec_op_cmd,
> +		NAND_OP_PARSER_PAT_DATA_IN_ELEM(true, 2048)),
> +	NAND_OP_PARSER_PATTERN
> +		(anfc_exec_op_cmd,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 7),
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false),
> +		NAND_OP_PARSER_PAT_DATA_IN_ELEM(true, 2048)),
> +	NAND_OP_PARSER_PATTERN
> +		(anfc_exec_op_cmd,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 8),
> +		NAND_OP_PARSER_PAT_DATA_OUT_ELEM(false, 2048),
> +		//NAND_OP_PARSER_PAT_CMD_ELEM(true),
> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(true)),
> +	NAND_OP_PARSER_PATTERN
> +		(anfc_exec_op_cmd,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +		NAND_OP_PARSER_PAT_ADDR_ELEM(false, 8),
> +		NAND_OP_PARSER_PAT_CMD_ELEM(true),
> +		NAND_OP_PARSER_PAT_DATA_IN_ELEM(true, 2048)),
> +	NAND_OP_PARSER_PATTERN
> +		(anfc_reset_type_exec,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(false)),

And the reset pattern desc looks correct too.

> +	NAND_OP_PARSER_PATTERN
> +		(anfc_status_type_exec,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(false),
> +		NAND_OP_PARSER_PAT_DATA_IN_ELEM(true, 1)),
> +	);
> +

> +
> +static void anfc_select_chip(struct mtd_info *mtd, int num)
> +{
> +
> +	u32 val;
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct anfc_nand_chip *achip = to_anfc_nand(chip);
> +	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
> +
> +	if (num == -1)
> +		return;

You only support one CS per chip, so maybe you should check that
num < 1.

> +
> +	val = readl(nfc->base + MEM_ADDR2_OFST);
> +	val &= (val & ~(CS_MASK | BCH_MODE_MASK));
> +	val |= (achip->csnum << CS_SHIFT) | (achip->bchmode << BCH_MODE_SHIFT);
> +	writel(val, nfc->base + MEM_ADDR2_OFST);
> +	nfc->csnum = achip->csnum;
> +	writel(achip->eccval, nfc->base + ECC_OFST);
> +	writel(achip->inftimeval, nfc->base + DATA_INTERFACE_OFST);
> +}
> +
> +static irqreturn_t anfc_irq_handler(int irq, void *ptr)
> +{
> +	struct anfc_nand_controller *nfc = ptr;
> +	u32 status;
> +
> +	status = readl(nfc->base + INTR_STS_OFST);
> +	if (status & EVENT_MASK) {
> +		complete(&nfc->event);
> +		writel((status & EVENT_MASK), nfc->base + INTR_STS_OFST);

			^ parens uneeded here

> +		writel(0, nfc->base + INTR_STS_EN_OFST);
> +		writel(0, nfc->base + INTR_SIG_EN_OFST);
> +		return IRQ_HANDLED;
> +	}
> +
> +	return IRQ_NONE;
> +}

I haven't finished reviewing the driver but there are still a bunch of
things that look strange, for instance, your ->read/write_page()
implementation looks suspicious. Let's discuss that before you send a
new version.

Also, please run checkpatch --strict and fix all errors and warnings
(unless you have a good reason not to).

Thanks,

Boris
