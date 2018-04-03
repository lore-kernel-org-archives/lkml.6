Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752480AbeDCQu6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 12:50:58 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:36748 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751270AbeDCQu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 12:50:56 -0400
Date: Tue, 3 Apr 2018 11:50:42 -0500
From: Julia Cartwright <julia@ni.com>
To: <nagasureshkumarrelli@gmail.com>
CC: <boris.brezillon@bootlin.com>, <rogerq@ti.com>, <lee.jones@linaro.org>,
        <alexandre.belloni@free-electrons.com>, <nicolas.ferre@microchip.com>,
        <ladis@linux-mips.org>, <ada@thorsis.com>,
        <linux-kernel@vger.kernel.org>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>
Subject: Re: [LINUX PATCH v8 2/2] memory: pl353: Add driver for arm pl353
 static memory controller
Message-ID: <20180403165042.GE7654@jcartwri.amer.corp.natinst.com>
References: <1521024235-30374-1-git-send-email-nagasureshkumarrelli@gmail.com>
 <1521024274-30467-1-git-send-email-nagasureshkumarrelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1521024274-30467-1-git-send-email-nagasureshkumarrelli@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-03_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello-

On Wed, Mar 14, 2018 at 04:14:34PM +0530, nagasureshkumarrelli@gmail.com wrote:
> From: Naga Sureshkumar Relli <nagasure@xilinx.com>

I'm pleased to see this patchset revived and resubmitted!

It would be easier to follow if you constructed your two patchsets with
git format-patch --thread.

Or, merge them into a single patchset, especially considering the
dependency between patches.

Some code review comments below:

> Add driver for arm pl353 static memory controller. This controller is
> used in xilinx zynq soc for interfacing the nand and nor/sram memory
> devices.
> 
> Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
> ---
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
>  drivers/memory/Kconfig                  |   7 +
>  drivers/memory/Makefile                 |   1 +
>  drivers/memory/pl353-smc.c              | 548 ++++++++++++++++++++++++++++++++
>  include/linux/platform_data/pl353-smc.h |  34 ++
>  4 files changed, 590 insertions(+)
>  create mode 100644 drivers/memory/pl353-smc.c
>  create mode 100644 include/linux/platform_data/pl353-smc.h
> 
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index 19a0e83..d70d6db 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -152,6 +152,13 @@ config DA8XX_DDRCTL
>  	  This driver is for the DDR2/mDDR Memory Controller present on
>  	  Texas Instruments da8xx SoCs. It's used to tweak various memory
>  	  controller configuration options.
> +config PL35X_SMC
> +	bool "ARM PL35X Static Memory Controller(SMC) driver"

Is there any reason why this can't be tristate?

[..]
> +++ b/drivers/memory/pl353-smc.c
[..]
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

While it's true that the Zynq chips only have a single instance of this
IP, there is no real reason why an SoC can't instantiate more than one.
I'm a bit uncomfortable with the fact that this has been designed out.

> +
> +/**
> + * pl353_smc_set_buswidth - Set memory buswidth
> + * @bw:	Memory buswidth (8 | 16)
> + * Return: 0 on success or negative errno.
> + */
> +int pl353_smc_set_buswidth(unsigned int bw)
> +{
> +
> +	if (bw != PL353_SMC_MEM_WIDTH_8  && bw != PL353_SMC_MEM_WIDTH_16)
> +		return -EINVAL;
> +
> +	writel(bw, pl353_smc_base + PL353_SMC_SET_OPMODE_OFFS);

There should be no reason not to use the _relaxed() accessor variants.

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
> + * pl353_smc_ecc_is_busy_noirq - Read ecc busy flag
> + * Return: the ecc_status bit from the ecc_status register. 1 = busy, 0 = idle
> + */
> +static int pl353_smc_ecc_is_busy_noirq(void)

_noirq() is intended to convey some warning to a user of a function
about this functions behavior w.r.t. interrupts, but this function
doesn't do anything with interrupts ...

> +{
> +	return !!(readl(pl353_smc_base + PL353_SMC_ECC_STATUS_OFFS) &
> +		  PL353_SMC_ECC_STATUS_BUSY);
> +}
> +
> +/**
> + * pl353_smc_ecc_is_busy - Read ecc busy flag
> + * Return: the ecc_status bit from the ecc_status register. 1 = busy, 0 = idle
> + */
> +int pl353_smc_ecc_is_busy(void)
> +{
> +	int ret;
> +
> +	ret = pl353_smc_ecc_is_busy_noirq();

In fact, why even have pl353_smc_ecc_is_busy_noirq and
pl353_smc_ecc_is_busy as separate functions?

> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pl353_smc_ecc_is_busy);
> +
[..]
> +/**
> + * pl353_smc_init_nand_interface - Initialize the NAND interface
> + * @pdev:	Pointer to the platform_device struct
> + * @nand_node:	Pointer to the pl353_nand device_node struct
> + */
> +static void pl353_smc_init_nand_interface(struct platform_device *pdev,
> +				       struct device_node *nand_node)
> +{
> +	u32 t_rc, t_wc, t_rea, t_wp, t_clr, t_ar, t_rr;
> +	int err;
> +	unsigned long timeout = jiffies + PL353_NAND_ECC_BUSY_TIMEOUT;
> +
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
> +
> +default_nand_timing:
> +	if (err) {
> +		/* set default NAND flash timing property */
> +		dev_warn(&pdev->dev, "Using default timing for");
> +		dev_warn(&pdev->dev, "2Gb Numonyx MT29F2G08ABAEAWP NAND flash");
> +		dev_warn(&pdev->dev, "t_wp, t_clr, t_ar are set to 2");
> +		dev_warn(&pdev->dev, "t_rc, t_wc, t_rr are set to 4");
> +		dev_warn(&pdev->dev, "t_rea is set to 1");
> +		t_rc = t_wc = t_rr = 4;
> +		t_rea = 1;
> +		t_wp = t_clr = t_ar = 2;
> +	}
> +
> +	pl353_smc_set_buswidth(PL353_SMC_MEM_WIDTH_8);
> +
> +	/*
> +	 * Default assume 50MHz clock (20ns cycle time) and 3V operation
> +	 * The SET_CYCLES_REG register value depends on the flash device.
> +	 * Look in to the device datasheet and change its value, This value
> +	 * is for 2Gb Numonyx flash.
> +	 */

This comment should go above, with the default assignments.

> +	pl353_smc_set_cycles(t_rc, t_wc, t_rea, t_wp, t_clr, t_ar, t_rr);
> +	writel(PL353_SMC_CFG_CLR_INT_CLR_1,
> +		pl353_smc_base + PL353_SMC_CFG_CLR_OFFS);
> +	writel(PL353_SMC_DC_UPT_NAND_REGS, pl353_smc_base +
> +	       PL353_SMC_DIRECT_CMD_OFFS);
> +	/* Wait till the ECC operation is complete */
> +	do {
> +		if (pl353_smc_ecc_is_busy_noirq())
> +			cpu_relax();
> +		else
> +			break;
> +	} while (!time_after_eq(jiffies, timeout));
> +
> +	if (time_after_eq(jiffies, timeout))
> +		dev_err(&pdev->dev, "nand ecc busy status timed out");
> +	/* Set the command1 and command2 register */

This comment is useless.

> +	writel(PL353_NAND_ECC_CMD1,
> +			pl353_smc_base + PL353_SMC_ECC_MEMCMD1_OFFS);
> +	writel(PL353_NAND_ECC_CMD2,
> +			pl353_smc_base + PL353_SMC_ECC_MEMCMD2_OFFS);
> +}
> +
> +static const struct of_device_id matches_nor[] = {
> +	{ .compatible = "cfi-flash" },
> +	{}
> +};
> +
> +static const struct of_device_id matches_nand[] = {
> +	{ .compatible = "arm,pl353-nand-r2p1" },
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
> +	const struct of_device_id *matches = NULL;
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
> +		pl353_smc_base + PL353_SMC_CFG_CLR_OFFS);
> +
> +	/* Find compatible children. Only a single child is supported */
> +	for_each_available_child_of_node(of_node, child) {
> +		if (of_match_node(matches_nand, child)) {
> +			pl353_smc_init_nand_interface(pdev, child);
> +			if (!matches) {
> +				matches = matches_nand;
> +			} else {
> +				dev_err(&pdev->dev,
> +					"incompatible configuration\n");
> +				goto out_clk_disable;
> +			}

If the comment stating that only a single available child is supported
is true, then these checks are insufficient to guarantee that.  It's
only counting nor devices; multiple NAND devices would be probed.

I would suggest cleaning this all up with something like:

	static const struct of_device_id pl353_supported_children[] = {
		{ .compatible = "cfi-flash" },
		{ .compatible = "arm,pl353-nand-r2p1",
		  .data = pl353_smc_init_nand_interface },
		{},
	};

	void (*init)(struct platform_device *pdev,
		     struct device_node *nand_node);
	const struct of_device_id *match = NULL;

	for_each_available_child_of_node(of_node, child) {
		match = of_match_node(pl353_supported_children, child);
		if (!match) {
			dev_warn(&pdev->err, "unsupported child node\n");
			continue;
		}

		break;
	}

	if (!match) {
		dev_err(&pdev->dev, "no matching children\n");
		goto err_clk_disable;
	}

	init = match->data;
	if (init)
		init();

	return of_platform_device_create(child, NULL, &pdev->dev);

   Julia
