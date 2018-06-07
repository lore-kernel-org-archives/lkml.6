Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id alKqODdYGVvMcwAAmS7hNA
	; Thu, 07 Jun 2018 16:07:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D3946608BA; Thu,  7 Jun 2018 16:07:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 43A1660115;
	Thu,  7 Jun 2018 16:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43A1660115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936072AbeFGQHQ convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Thu, 7 Jun 2018 12:07:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51072 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933676AbeFGQHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 12:07:13 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0731520756; Thu,  7 Jun 2018 18:07:11 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-128-7.w90-88.abo.wanadoo.fr [90.88.9.7])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8D0DD20012;
        Thu,  7 Jun 2018 18:07:10 +0200 (CEST)
Date: Thu, 7 Jun 2018 18:07:10 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc: <boris.brezillon@bootlin.com>, <richard@nod.at>,
        <wmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <f.fainelli@gmail.com>,
        <mmayer@broadcom.com>, <rogerq@ti.com>, <ladis@linux-mips.org>,
        <ada@thorsis.com>, <honghui.zhang@mediatek.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nagasureshkumarrelli@gmail.com>
Subject: Re: [LINUX PATCH v9 2/4] memory: pl353: Add driver for arm pl353
 static memory controller
Message-ID: <20180607180710.5b53e95b@xps13>
In-Reply-To: <1528271382-21690-3-git-send-email-naga.sureshkumar.relli@xilinx.com>
References: <1528271382-21690-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1528271382-21690-3-git-send-email-naga.sureshkumar.relli@xilinx.com>
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

On Wed, 6 Jun 2018 13:19:40 +0530, Naga Sureshkumar Relli
<naga.sureshkumar.relli@xilinx.com> wrote:

> Add driver for arm pl353 static memory controller. This controller is
> used in xilinx zynq soc for interfacing the nand and nor/sram memory
> devices.

Upper case: Xilinx Zynq, SoC, NAND, NOR, SRAM.

> 
> Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> ---
> Changes in v9:
>  - Addressed the comments given by Julia Cartwright to the v8 series.
> Changes in v8:
> - None
> Changes in v7:
> - Corrected the kconfig to use tristate selection
> - Corrected the GPL licence ident 
> - Added boundary checks for nand timing parameters 
> Changes in v6:
> - Fixed checkpatch.pl reported warnings
> Changes in v5:
> - Added pl353_smc_get_clkrate function, made pl353_smc_set_cycles as public
>   API
> - Removed nand timing parameter initialization and moved it to nand driver  
> Changes in v4:
> - Modified driver to support multiple instances
> - Used sleep instaed of busywait for delay
> Changes in v3:
> - None
> Changes in v2:
> - Since now the timing parameters are in nano seconds, added logic to convert
>   them to the cycles
> ---
>  drivers/memory/Kconfig                  |   8 +
>  drivers/memory/Makefile                 |   1 +
>  drivers/memory/pl353-smc.c              | 523 ++++++++++++++++++++++++++++++++
>  include/linux/platform_data/pl353-smc.h |  29 ++
>  4 files changed, 561 insertions(+)
>  create mode 100644 drivers/memory/pl353-smc.c
>  create mode 100644 include/linux/platform_data/pl353-smc.h
> 
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index 19a0e83..9517da7 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -153,6 +153,14 @@ config DA8XX_DDRCTL
>  	  Texas Instruments da8xx SoCs. It's used to tweak various memory
>  	  controller configuration options.
>  
> +config PL353_SMC
> +	tristate "ARM PL35X Static Memory Controller(SMC) driver"
> +	default y

This is not restricive at all. If this controller is only on a specific
SoC, you should add another condition to compile the driver?

> +	depends on ARM

Or here             ^

> +	help
> +	  This driver is for the ARM PL351/PL353 Static Memory
> +	  Controller(SMC) module.
> +
>  source "drivers/memory/samsung/Kconfig"
>  source "drivers/memory/tegra/Kconfig"
>  
> diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
> index 66f5524..58e794d 100644
> --- a/drivers/memory/Makefile
> +++ b/drivers/memory/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_TEGRA20_MC)	+= tegra20-mc.o
>  obj-$(CONFIG_JZ4780_NEMC)	+= jz4780-nemc.o
>  obj-$(CONFIG_MTK_SMI)		+= mtk-smi.o
>  obj-$(CONFIG_DA8XX_DDRCTL)	+= da8xx-ddrctl.o
> +obj-$(CONFIG_PL353_SMC)		+= pl353-smc.o
>  
>  obj-$(CONFIG_SAMSUNG_MC)	+= samsung/
>  obj-$(CONFIG_TEGRA_MC)		+= tegra/
> diff --git a/drivers/memory/pl353-smc.c b/drivers/memory/pl353-smc.c
> new file mode 100644
> index 0000000..8758930
> --- /dev/null
> +++ b/drivers/memory/pl353-smc.c
> @@ -0,0 +1,523 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ARM PL353 SMC driver
> + *
> + * Copyright (C) 2012 Xilinx, Inc
> + * Author: Punnaiah Choudary Kalluri <punnaiah@xilinx.com>
> + * Author: Naga Sureshkumar Relli <nagasure@xilinx.com>
> + *
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/platform_data/pl353-smc.h>
> +
> +/* Register definitions */
> +#define PL353_SMC_MEMC_STATUS_OFFS	0	/* Controller status reg, RO */
> +#define PL353_SMC_CFG_CLR_OFFS		0xC	/* Clear config reg, WO */
> +#define PL353_SMC_DIRECT_CMD_OFFS	0x10	/* Direct command reg, WO */
> +#define PL353_SMC_SET_CYCLES_OFFS	0x14	/* Set cycles register, WO */
> +#define PL353_SMC_SET_OPMODE_OFFS	0x18	/* Set opmode register, WO */
> +#define PL353_SMC_ECC_STATUS_OFFS	0x400	/* ECC status register */
> +#define PL353_SMC_ECC_MEMCFG_OFFS	0x404	/* ECC mem config reg */
> +#define PL353_SMC_ECC_MEMCMD1_OFFS	0x408	/* ECC mem cmd1 reg */
> +#define PL353_SMC_ECC_MEMCMD2_OFFS	0x40C	/* ECC mem cmd2 reg */
> +#define PL353_SMC_ECC_VALUE0_OFFS	0x418	/* ECC value 0 reg */
> +
> +/* Controller status register specific constants */
> +#define PL353_SMC_MEMC_STATUS_RAW_INT_1_SHIFT	6
> +
> +/* Clear configuration register specific constants */
> +#define PL353_SMC_CFG_CLR_INT_CLR_1	0x10
> +#define PL353_SMC_CFG_CLR_ECC_INT_DIS_1	0x40
> +#define PL353_SMC_CFG_CLR_INT_DIS_1	0x2
> +#define PL353_SMC_CFG_CLR_DEFAULT_MASK	(PL353_SMC_CFG_CLR_INT_CLR_1 | \
> +					 PL353_SMC_CFG_CLR_ECC_INT_DIS_1 | \
> +					 PL353_SMC_CFG_CLR_INT_DIS_1)
> +
> +/* Set cycles register specific constants */
> +#define PL353_SMC_SET_CYCLES_T0_MASK	0xF
> +#define PL353_SMC_SET_CYCLES_T0_SHIFT	0
> +#define PL353_SMC_SET_CYCLES_T1_MASK	0xF
> +#define PL353_SMC_SET_CYCLES_T1_SHIFT	4
> +#define PL353_SMC_SET_CYCLES_T2_MASK	0x7
> +#define PL353_SMC_SET_CYCLES_T2_SHIFT	8
> +#define PL353_SMC_SET_CYCLES_T3_MASK	0x7
> +#define PL353_SMC_SET_CYCLES_T3_SHIFT	11
> +#define PL353_SMC_SET_CYCLES_T4_MASK	0x7
> +#define PL353_SMC_SET_CYCLES_T4_SHIFT	14
> +#define PL353_SMC_SET_CYCLES_T5_MASK	0x7
> +#define PL353_SMC_SET_CYCLES_T5_SHIFT	17
> +#define PL353_SMC_SET_CYCLES_T6_MASK	0xF
> +#define PL353_SMC_SET_CYCLES_T6_SHIFT	20
> +
> +/* ECC status register specific constants */
> +#define PL353_SMC_ECC_STATUS_BUSY	BIT(6)
> +
> +/* ECC memory config register specific constants */
> +#define PL353_SMC_ECC_MEMCFG_MODE_MASK	0xC
> +#define PL353_SMC_ECC_MEMCFG_MODE_SHIFT	2
> +#define PL353_SMC_ECC_MEMCFG_PGSIZE_MASK	0xC
> +
> +#define PL353_SMC_DC_UPT_NAND_REGS	((4 << 23) |	/* CS: NAND chip */ \
> +				 (2 << 21))	/* UpdateRegs operation */
> +
> +#define PL353_NAND_ECC_CMD1	((0x80)       |	/* Write command */ \
> +				 (0 << 8)     |	/* Read command */ \
> +				 (0x30 << 16) |	/* Read End command */ \
> +				 (1 << 24))	/* Read End command calid */
> +
> +#define PL353_NAND_ECC_CMD2	((0x85)	      |	/* Write col change cmd */ \
> +				 (5 << 8)     |	/* Read col change cmd */ \
> +				 (0xE0 << 16) |	/* Read col change end cmd */ \
> +				 (1 << 24)) /* Read col change end cmd valid */
> +#define PL353_NAND_ECC_BUSY_TIMEOUT	(1 * HZ)
> +/**
> + * struct pl353_smc_data - Private smc driver structure
> + * @devclk:		Pointer to the peripheral clock
> + * @aperclk:		Pointer to the APER clock
> + */
> +struct pl353_smc_data {
> +	struct clk		*memclk;
> +	struct clk		*aclk;
> +};
> +
> +/* SMC virtual register base */
> +static void __iomem *pl353_smc_base;
> +
> +/**
> + * pl353_smc_set_buswidth - Set memory buswidth
> + * @bw:	Memory buswidth (8 | 16)
> + * Return: 0 on success or negative errno.
> + */
> +int pl353_smc_set_buswidth(unsigned int bw)
> +{
> +	if (bw != PL353_SMC_MEM_WIDTH_8  && bw != PL353_SMC_MEM_WIDTH_16)
> +		return -EINVAL;
> +
> +	writel(bw, pl353_smc_base + PL353_SMC_SET_OPMODE_OFFS);
> +	writel(PL353_SMC_DC_UPT_NAND_REGS, pl353_smc_base +
> +	       PL353_SMC_DIRECT_CMD_OFFS);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pl353_smc_set_buswidth);
> +
> +/**
> + * pl353_smc_set_cycles - Set memory timing parameters
> + * @t0:	t_rc		read cycle time
> + * @t1:	t_wc		write cycle time
> + * @t2:	t_rea/t_ceoe	output enable assertion delay
> + * @t3:	t_wp		write enable deassertion delay
> + * @t4:	t_clr/t_pc	page cycle time
> + * @t5:	t_ar/t_ta	ID read time/turnaround time
> + * @t6:	t_rr		busy to RE timing
> + *
> + * Sets NAND chip specific timing parameters.
> + */
> +static void pl353_smc_set_cycles(u32 t0, u32 t1, u32 t2, u32 t3, u32
> +			      t4, u32 t5, u32 t6)
> +{
> +	t0 &= PL353_SMC_SET_CYCLES_T0_MASK;
> +	t1 = (t1 & PL353_SMC_SET_CYCLES_T1_MASK) <<
> +			PL353_SMC_SET_CYCLES_T1_SHIFT;
> +	t2 = (t2 & PL353_SMC_SET_CYCLES_T2_MASK) <<
> +			PL353_SMC_SET_CYCLES_T2_SHIFT;
> +	t3 = (t3 & PL353_SMC_SET_CYCLES_T3_MASK) <<
> +			PL353_SMC_SET_CYCLES_T3_SHIFT;
> +	t4 = (t4 & PL353_SMC_SET_CYCLES_T4_MASK) <<
> +			PL353_SMC_SET_CYCLES_T4_SHIFT;
> +	t5 = (t5 & PL353_SMC_SET_CYCLES_T5_MASK) <<
> +			PL353_SMC_SET_CYCLES_T5_SHIFT;
> +	t6 = (t6 & PL353_SMC_SET_CYCLES_T6_MASK) <<
> +			PL353_SMC_SET_CYCLES_T6_SHIFT;
> +
> +	t0 |= t1 | t2 | t3 | t4 | t5 | t6;
> +
> +	writel(t0, pl353_smc_base + PL353_SMC_SET_CYCLES_OFFS);
> +	writel(PL353_SMC_DC_UPT_NAND_REGS, pl353_smc_base +
> +	       PL353_SMC_DIRECT_CMD_OFFS);
> +}
> +
> +/**
> + * pl353_smc_ecc_is_busy - Read ecc busy flag
> + * Return: the ecc_status bit from the ecc_status register. 1 = busy, 0 = idle
> + */
> +int pl353_smc_ecc_is_busy(void)
> +{
> +	return !!(readl(pl353_smc_base + PL353_SMC_ECC_STATUS_OFFS) &
> +		  PL353_SMC_ECC_STATUS_BUSY);

You can return a bool and avoid the '!!'.

> +}
> +EXPORT_SYMBOL_GPL(pl353_smc_ecc_is_busy);
> +
> +/**
> + * pl353_smc_get_ecc_val - Read ecc_valueN registers
> + * @ecc_reg:	Index of the ecc_value reg (0..3)
> + * Return: the content of the requested ecc_value register.
> + *
> + * There are four valid ecc_value registers. The argument is truncated to stay
> + * within this valid boundary.
> + */
> +u32 pl353_smc_get_ecc_val(int ecc_reg)
> +{
> +	u32 addr, reg;
> +
> +	ecc_reg &= 3;

This is not readable. Please check for the validity of ecc_reg with
standard '<' '>' operators.

> +	addr = PL353_SMC_ECC_VALUE0_OFFS + (ecc_reg << 2);

2 should be defined

> +	reg = readl(pl353_smc_base + addr);
> +
> +	return reg;
> +}
> +EXPORT_SYMBOL_GPL(pl353_smc_get_ecc_val);
> +
> +/**
> + * pl353_smc_get_nand_int_status_raw - Get NAND interrupt status bit
> + * Return: the raw_int_status1 bit from the memc_status register

If you use kernel-doc format, should be "@return".

> + */
> +int pl353_smc_get_nand_int_status_raw(void)
> +{
> +	u32 reg;
> +
> +	reg = readl(pl353_smc_base + PL353_SMC_MEMC_STATUS_OFFS);
> +	reg >>= PL353_SMC_MEMC_STATUS_RAW_INT_1_SHIFT;
> +	reg &= 1;
> +
> +	return reg;
> +}
> +EXPORT_SYMBOL_GPL(pl353_smc_get_nand_int_status_raw);
> +
> +/**
> + * pl353_smc_clr_nand_int - Clear NAND interrupt
> + */
> +void pl353_smc_clr_nand_int(void)
> +{
> +	writel(PL353_SMC_CFG_CLR_INT_CLR_1,
> +	       pl353_smc_base + PL353_SMC_CFG_CLR_OFFS);
> +}
> +EXPORT_SYMBOL_GPL(pl353_smc_clr_nand_int);
> +
> +/**
> + * pl353_smc_set_ecc_mode - Set SMC ECC mode
> + * @mode:	ECC mode (BYPASS, APB, MEM)
> + * Return: 0 on success or negative errno.
> + */
> +int pl353_smc_set_ecc_mode(enum pl353_smc_ecc_mode mode)
> +{
> +	u32 reg;
> +	int ret = 0;
> +
> +	switch (mode) {
> +	case PL353_SMC_ECCMODE_BYPASS:
> +	case PL353_SMC_ECCMODE_APB:
> +	case PL353_SMC_ECCMODE_MEM:
> +
> +		reg = readl(pl353_smc_base + PL353_SMC_ECC_MEMCFG_OFFS);
> +		reg &= ~PL353_SMC_ECC_MEMCFG_MODE_MASK;
> +		reg |= mode << PL353_SMC_ECC_MEMCFG_MODE_SHIFT;
> +		writel(reg, pl353_smc_base + PL353_SMC_ECC_MEMCFG_OFFS);
> +
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pl353_smc_set_ecc_mode);
> +
> +/**
> + * pl353_smc_set_ecc_pg_size - Set SMC ECC page size
> + * @pg_sz:	ECC page size
> + * Return: 0 on success or negative errno.
> + */
> +int pl353_smc_set_ecc_pg_size(unsigned int pg_sz)
> +{
> +	u32 reg, sz;
> +
> +	switch (pg_sz) {
> +	case 0:
> +		sz = 0;
> +		break;
> +	case SZ_512:
> +		sz = 1;
> +		break;
> +	case SZ_1K:
> +		sz = 2;
> +		break;
> +	case SZ_2K:
> +		sz = 3;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	reg = readl(pl353_smc_base + PL353_SMC_ECC_MEMCFG_OFFS);
> +	reg &= ~PL353_SMC_ECC_MEMCFG_PGSIZE_MASK;
> +	reg |= sz;
> +	writel(reg, pl353_smc_base + PL353_SMC_ECC_MEMCFG_OFFS);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pl353_smc_set_ecc_pg_size);
> +
> +static int __maybe_unused pl353_smc_suspend(struct device *dev)
> +{
> +	struct pl353_smc_data *pl353_smc = dev_get_drvdata(dev);
> +
> +	clk_disable(pl353_smc->memclk);
> +	clk_disable(pl353_smc->aclk);

Are you sure you don't need to save any of the configured registers?

> +
> +	return 0;
> +}
> +
> +static int __maybe_unused pl353_smc_resume(struct device *dev)
> +{
> +	int ret;
> +	struct pl353_smc_data *pl353_smc = dev_get_drvdata(dev);
> +
> +	ret = clk_enable(pl353_smc->aclk);
> +	if (ret) {
> +		dev_err(dev, "Cannot enable axi domain clock.\n");
> +		return ret;
> +	}
> +
> +	ret = clk_enable(pl353_smc->memclk);
> +	if (ret) {
> +		dev_err(dev, "Cannot enable memory clock.\n");
> +		clk_disable(pl353_smc->aclk);
> +		return ret;
> +	}

New line

> +	return ret;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(pl353_smc_dev_pm_ops, pl353_smc_suspend,
> +			 pl353_smc_resume);
> +
> +/**
> + * pl353_smc_init_nand_interface - Initialize the NAND interface
> + * @pdev:	Pointer to the platform_device struct
> + * @nand_node:	Pointer to the pl353_nand device_node struct
> + */
> +static void pl353_smc_init_nand_interface(struct platform_device *pdev,
> +					  struct device_node *nand_node)
> +{
> +	u32 t_rc, t_wc, t_rea, t_wp, t_clr, t_ar, t_rr;
> +	int err;
> +	unsigned long timeout = jiffies + PL353_NAND_ECC_BUSY_TIMEOUT;

Maybe this should be defined later in the code.

New line.

> +	/* nand-cycle-<X> property is refer to the NAND flash timing
> +	 * mapping between dts and the NAND flash AC timing
> +	 *  X  : AC timing name
> +	 *  t0 : t_rc
> +	 *  t1 : t_wc
> +	 *  t2 : t_rea
> +	 *  t3 : t_wp
> +	 *  t4 : t_clr
> +	 *  t5 : t_ar
> +	 *  t6 : t_rr
> +	 */
> +	err = of_property_read_u32(nand_node, "arm,nand-cycle-t0", &t_rc);
> +	if (err) {
> +		dev_warn(&pdev->dev, "arm,nand-cycle-t0 not in device tree");
> +		goto default_nand_timing;
> +	}
> +	err = of_property_read_u32(nand_node, "arm,nand-cycle-t1", &t_wc);
> +	if (err) {
> +		dev_warn(&pdev->dev, "arm,nand-cycle-t1 not in device tree");
> +		goto default_nand_timing;
> +	}
> +	err = of_property_read_u32(nand_node, "arm,nand-cycle-t2", &t_rea);
> +	if (err) {
> +		dev_warn(&pdev->dev, "arm,nand-cycle-t2 not in device tree");
> +		goto default_nand_timing;
> +	}
> +	err = of_property_read_u32(nand_node, "arm,nand-cycle-t3", &t_wp);
> +	if (err) {
> +		dev_warn(&pdev->dev, "arm,nand-cycle-t3 not in device tree");
> +		goto default_nand_timing;
> +	}
> +	err = of_property_read_u32(nand_node, "arm,nand-cycle-t4", &t_clr);
> +	if (err) {
> +		dev_warn(&pdev->dev, "arm,nand-cycle-t4 not in device tree");
> +		goto default_nand_timing;
> +	}
> +	err = of_property_read_u32(nand_node, "arm,nand-cycle-t5", &t_ar);
> +	if (err) {
> +		dev_warn(&pdev->dev, "arm,nand-cycle-t5 not in device tree");
> +		goto default_nand_timing;
> +	}
> +	err = of_property_read_u32(nand_node, "arm,nand-cycle-t6", &t_rr);
> +	if (err) {
> +		dev_warn(&pdev->dev, "arm,nand-cycle-t6 not in device tree");
> +		goto default_nand_timing;
> +	}

See the comment in the bindings about this section.

> +
> +default_nand_timing:
> +	/*
> +	 * Default assume 50MHz clock (20ns cycle time) and 3V operation
> +	 * The SET_CYCLES_REG register value depends on the flash device.
> +	 * Look in to the device datasheet and change its value, This value
> +	 * is for 2Gb Numonyx flash.

No :)

The controller is not supposed to work with only one chip, right? So it
should not embed any chip-specific information.

If this chip is not ONFI nor JEDEC and is not supported yet, the right
way to do is to write a manufacturer driver.

> +	 */
> +	if (err) {
> +		/* set default NAND flash timing property */
> +		dev_warn(&pdev->dev, "Using default timing for");
> +		dev_warn(&pdev->dev, "2Gb Numonyx MT29F2G08ABAEAWP NAND flash");
> +		dev_warn(&pdev->dev, "t_wp, t_clr, t_ar are set to 2");
> +		dev_warn(&pdev->dev, "t_rc, t_wc, t_rr are set to 4");
> +		dev_warn(&pdev->dev, "t_rea is set to 1");
> +		t_rc = 4;
> +		t_wc = 4;
> +		t_rr = 4;
> +		t_rea = 1;
> +		t_wp = 2;
> +		t_clr = 2;
> +		t_ar = 2;
> +	}
> +
> +	pl353_smc_set_buswidth(PL353_SMC_MEM_WIDTH_8);
> +	pl353_smc_set_cycles(t_rc, t_wc, t_rea, t_wp, t_clr, t_ar, t_rr);
> +	writel(PL353_SMC_CFG_CLR_INT_CLR_1,
> +	       pl353_smc_base + PL353_SMC_CFG_CLR_OFFS);
> +	writel(PL353_SMC_DC_UPT_NAND_REGS, pl353_smc_base +
> +	       PL353_SMC_DIRECT_CMD_OFFS);
> +	/* Wait till the ECC operation is complete */
> +	do {
> +		if (pl353_smc_ecc_is_busy())
> +			cpu_relax();
> +		else
> +			break;
> +	} while (!time_after_eq(jiffies, timeout));
> +
> +	if (time_after_eq(jiffies, timeout))
> +		dev_err(&pdev->dev, "nand ecc busy status timed out");
> +
> +	writel(PL353_NAND_ECC_CMD1,
> +	       pl353_smc_base + PL353_SMC_ECC_MEMCMD1_OFFS);
> +	writel(PL353_NAND_ECC_CMD2,
> +	       pl353_smc_base + PL353_SMC_ECC_MEMCMD2_OFFS);
> +}
> +
> +static const struct of_device_id pl353_smc_supported_children[] = {
> +	{ .compatible = "cfi-flash" },
> +	{ .compatible = "arm,pl353-nand-r2p1",
> +	.data = pl353_smc_init_nand_interface },

Please put the compatibles on another line and align data with them.

> +	{}
> +};
> +
> +static int pl353_smc_probe(struct platform_device *pdev)
> +{
> +	struct pl353_smc_data *pl353_smc;
> +	struct device_node *child;
> +	struct resource *res;
> +	int err;
> +	struct device_node *of_node = pdev->dev.of_node;
> +	void (*init)(struct platform_device *pdev,
> +		     struct device_node *nand_node);
> +	const struct of_device_id *match = NULL;
> +
> +	pl353_smc = devm_kzalloc(&pdev->dev, sizeof(*pl353_smc), GFP_KERNEL);
> +	if (!pl353_smc)
> +		return -ENOMEM;
> +
> +	/* Get the NAND controller virtual address */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pl353_smc_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(pl353_smc_base))
> +		return PTR_ERR(pl353_smc_base);
> +
> +	pl353_smc->aclk = devm_clk_get(&pdev->dev, "aclk");
> +	if (IS_ERR(pl353_smc->aclk)) {
> +		dev_err(&pdev->dev, "aclk clock not found.\n");
> +		return PTR_ERR(pl353_smc->aclk);
> +	}
> +
> +	pl353_smc->memclk = devm_clk_get(&pdev->dev, "memclk");
> +	if (IS_ERR(pl353_smc->memclk)) {
> +		dev_err(&pdev->dev, "memclk clock not found.\n");
> +		return PTR_ERR(pl353_smc->memclk);
> +	}
> +
> +	err = clk_prepare_enable(pl353_smc->aclk);
> +	if (err) {
> +		dev_err(&pdev->dev, "Unable to enable AXI clock.\n");
> +		return err;
> +	}
> +
> +	err = clk_prepare_enable(pl353_smc->memclk);
> +	if (err) {
> +		dev_err(&pdev->dev, "Unable to enable memory clock.\n");
> +		goto out_clk_dis_aper;
> +	}
> +
> +	platform_set_drvdata(pdev, pl353_smc);
> +
> +	/* clear interrupts */
> +	writel(PL353_SMC_CFG_CLR_DEFAULT_MASK,
> +	       pl353_smc_base + PL353_SMC_CFG_CLR_OFFS);
> +
> +	/* Find compatible children. Only a single child is supported */
> +	for_each_available_child_of_node(of_node, child) {
> +		match = of_match_node(pl353_smc_supported_children, child);
> +		if (!match) {
> +			dev_warn(&pdev->dev, "unsupported child node\n");
> +			continue;
> +		}
> +		break;
> +	}
> +	if (!match) {
> +		dev_err(&pdev->dev, "no matching children\n");
> +		goto out_clk_disable;
> +	}
> +
> +	init = match->data;
> +	if (init)
> +		init(pdev, child);
> +	of_platform_device_create(child, NULL, &pdev->dev);
> +
> +	return 0;
> +
> +out_clk_disable:
> +	clk_disable_unprepare(pl353_smc->memclk);
> +out_clk_dis_aper:
> +	clk_disable_unprepare(pl353_smc->aclk);
> +
> +	return err;
> +}
> +
> +static int pl353_smc_remove(struct platform_device *pdev)
> +{
> +	struct pl353_smc_data *pl353_smc = platform_get_drvdata(pdev);
> +
> +	clk_disable_unprepare(pl353_smc->memclk);
> +	clk_disable_unprepare(pl353_smc->aclk);
> +
> +	return 0;
> +}
> +
> +/* Match table for device tree binding */
> +static const struct of_device_id pl353_smc_of_match[] = {
> +	{ .compatible = "arm,pl353-smc-r2p1" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, pl353_smc_of_match);
> +
> +static struct platform_driver pl353_smc_driver = {
> +	.probe		= pl353_smc_probe,
> +	.remove		= pl353_smc_remove,
> +	.driver		= {
> +		.name	= "pl353-smc",
> +		.pm	= &pl353_smc_dev_pm_ops,
> +		.of_match_table = pl353_smc_of_match,
> +	},
> +};
> +
> +module_platform_driver(pl353_smc_driver);
> +
> +MODULE_AUTHOR("Xilinx, Inc.");
> +MODULE_DESCRIPTION("ARM PL353 SMC Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/platform_data/pl353-smc.h b/include/linux/platform_data/pl353-smc.h

I don't think you really need a separate file for these enums? Unless
it is really platform specific?

> new file mode 100644
> index 0000000..fc4129e
> --- /dev/null
> +++ b/include/linux/platform_data/pl353-smc.h
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ARM PL353 SMC Driver Header
> + *
> + * Copyright (C) 2017 Xilinx, Inc
> + */
> +
> +#ifndef __LINUX_MEMORY_PL353_SMC_H
> +#define __LINUX_MEMORY_PL353_SMC_H
> +
> +enum pl353_smc_ecc_mode {
> +	PL353_SMC_ECCMODE_BYPASS = 0,
> +	PL353_SMC_ECCMODE_APB = 1,
> +	PL353_SMC_ECCMODE_MEM = 2
> +};
> +
> +enum pl353_smc_mem_width {
> +	PL353_SMC_MEM_WIDTH_8 = 0,
> +	PL353_SMC_MEM_WIDTH_16 = 1
> +};
> +
> +u32 pl353_smc_get_ecc_val(int ecc_reg);
> +int pl353_smc_ecc_is_busy(void);
> +int pl353_smc_get_nand_int_status_raw(void);
> +void pl353_smc_clr_nand_int(void);
> +int pl353_smc_set_ecc_mode(enum pl353_smc_ecc_mode mode);
> +int pl353_smc_set_ecc_pg_size(unsigned int pg_sz);
> +int pl353_smc_set_buswidth(unsigned int bw);
> +#endif

Thanks,
Miquèl

-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
