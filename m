Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933200AbeEWOSh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 10:18:37 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41723 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932564AbeEWOSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 10:18:34 -0400
Date: Wed, 23 May 2018 16:18:10 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Stefan Agner <stefan@agner.ch>
Cc: dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
        dev@lynxeye.de, miquel.raynal@bootlin.com, richard@nod.at,
        marcel@ziswiler.com, krzk@kernel.org, digetx@gmail.com,
        benjamin.lindqvist@endian.se, jonathanh@nvidia.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, mirza.krak@gmail.com,
        linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [RESEND PATCH 2/5] mtd: rawnand: add NVIDIA Tegra NAND Flash
 controller driver
Message-ID: <20180523161810.0ed9fe80@bbrezillon>
In-Reply-To: <86fdf19ec92b732709732fb60199f16488b4b727.1526990589.git.stefan@agner.ch>
References: <cover.1526990589.git.stefan@agner.ch>
        <86fdf19ec92b732709732fb60199f16488b4b727.1526990589.git.stefan@agner.ch>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Tue, 22 May 2018 14:07:06 +0200
Stefan Agner <stefan@agner.ch> wrote:
> +
> +struct tegra_nand {
> +	void __iomem *regs;
> +	struct clk *clk;
> +	struct gpio_desc *wp_gpio;
> +
> +	struct nand_chip chip;
> +	struct device *dev;
> +
> +	struct completion command_complete;
> +	struct completion dma_complete;
> +	bool last_read_error;
> +
> +	dma_addr_t data_dma;
> +	void *data_buf;
> +	dma_addr_t oob_dma;
> +	void *oob_buf;
> +
> +	int cur_chip;
> +};

This struct should be split in 2 structures: one representing the NAND
controller and one representing the NAND chip:

struct tegra_nand_controller {
	struct nand_hw_control base;
	void __iomem *regs;
	struct clk *clk;
	struct device *dev;
	struct completion command_complete;
	struct completion dma_complete;
	bool last_read_error;
	int cur_chip;
};

struct tegra_nand {
	struct nand_chip base;
	dma_addr_t data_dma;
	void *data_buf;
	dma_addr_t oob_dma;
	void *oob_buf;
};

> +
> +static inline struct tegra_nand *to_tegra_nand(struct mtd_info *mtd)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +
> +	return nand_get_controller_data(chip);

then you can just do:

	return container_of(chip, struct tegra_nand, base);

> +}
> +
> +static int tegra_nand_ooblayout_16_ecc(struct mtd_info *mtd, int section,
> +				       struct mtd_oob_region *oobregion)
> +{
> +	if (section > 0)
> +		return -ERANGE;
> +
> +	oobregion->offset = 4;
> +	oobregion->length = 4;
> +
> +	return 0;
> +}
> +
> +static int tegra_nand_ooblayout_16_free(struct mtd_info *mtd, int section,
> +					struct mtd_oob_region *oobregion)
> +{
> +	if (section > 0)
> +		return -ERANGE;
> +
> +	oobregion->offset = 8;
> +	oobregion->length = 8;
> +
> +	return 0;
> +}

...

> +
> +static int tegra_nand_ooblayout_224_ecc(struct mtd_info *mtd, int section,
> +				       struct mtd_oob_region *oobregion)
> +{
> +	if (section > 0)
> +		return -ERANGE;
> +
> +	oobregion->offset = 4;
> +	oobregion->length = 144;
> +
> +	return 0;
> +}
> +
> +static int tegra_nand_ooblayout_224_free(struct mtd_info *mtd, int section,
> +					struct mtd_oob_region *oobregion)
> +{
> +	if (section > 0)
> +		return -ERANGE;
> +
> +	oobregion->offset = 148;
> +	oobregion->length = 76;
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops tegra_nand_oob_224_ops = {
> +	.ecc = tegra_nand_ooblayout_224_ecc,
> +	.free = tegra_nand_ooblayout_224_free,
> +};
> +

I'm pretty sure we can find a pattern here to avoid defining a new
mtd_ooblayout_ops for each OOB size.

> +static irqreturn_t tegra_nand_irq(int irq, void *data)
> +{
> +	struct tegra_nand *nand = data;
> +	u32 isr, dma;
> +
> +	isr = readl(nand->regs + ISR);
> +	dma = readl(nand->regs + DMA_CTRL);
> +	dev_dbg(nand->dev, "isr %08x\n", isr);
> +
> +	if (!isr && !(dma & DMA_CTRL_IS_DONE))
> +		return IRQ_NONE;
> +
> +	if (isr & ISR_CORRFAIL_ERR)
> +		nand->last_read_error = true;
> +
> +	if (isr & ISR_CMD_DONE)
> +		complete(&nand->command_complete);
> +
> +	if (isr & ISR_UND)
> +		dev_dbg(nand->dev, "FIFO underrun\n");
> +
> +	if (isr & ISR_OVR)
> +		dev_dbg(nand->dev, "FIFO overrun\n");
> +
> +	/* handle DMA interrupts */
> +	if (dma & DMA_CTRL_IS_DONE) {
> +		writel(dma, nand->regs + DMA_CTRL);
> +		complete(&nand->dma_complete);
> +	}
> +
> +	/* clear interrupts */
> +	writel(isr, nand->regs + ISR);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int tegra_nand_cmd(struct nand_chip *chip,
> +			 const struct nand_subop *subop)
> +{
> +	const struct nand_op_instr *instr;
> +	const struct nand_op_instr *instr_data_in = NULL;
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	struct tegra_nand *nand = to_tegra_nand(mtd);
> +	unsigned int op_id = -1, trfr_in_sz = 0, trfr_out_sz = 0, offset = 0;
> +	bool first_cmd = true;
> +	bool force8bit;
> +	u32 cmd = 0;
> +	u32 value;
> +
> +	for (op_id = 0; op_id < subop->ninstrs; op_id++) {
> +		unsigned int naddrs, i;
> +		const u8 *addrs;
> +		u32 addr1 = 0, addr2 = 0;
> +
> +		instr = &subop->instrs[op_id];
> +
> +		switch (instr->type) {
> +		case NAND_OP_CMD_INSTR:
> +			if (first_cmd) {
> +				cmd |= CMD_CLE;
> +				writel(instr->ctx.cmd.opcode, nand->regs + CMD_1);
> +			} else {
> +				cmd |= CMD_SEC_CMD;
> +				writel(instr->ctx.cmd.opcode, nand->regs + CMD_2);
> +			}
> +			first_cmd = false;
> +			break;
> +		case NAND_OP_ADDR_INSTR:
> +			offset = nand_subop_get_addr_start_off(subop, op_id);
> +			naddrs = nand_subop_get_num_addr_cyc(subop, op_id);
> +			addrs = &instr->ctx.addr.addrs[offset];
> +
> +			cmd |= CMD_ALE | CMD_ALE_SIZE(naddrs);
> +			for (i = 0; i < min_t(unsigned int, 4, naddrs); i++)
> +				addr1 |= *addrs++ << (8 * i);
> +			naddrs -= i;
> +			for (i = 0; i < min_t(unsigned int, 4, naddrs); i++)
> +				addr2 |= *addrs++ << (8 * i);
> +			writel(addr1, nand->regs + ADDR_1);
> +			writel(addr2, nand->regs + ADDR_2);
> +			break;
> +
> +		case NAND_OP_DATA_IN_INSTR:
> +			trfr_in_sz = nand_subop_get_data_len(subop, op_id);
> +			offset = nand_subop_get_data_start_off(subop, op_id);
> +
> +			cmd |= CMD_TRANS_SIZE(trfr_in_sz) | CMD_PIO | CMD_RX | CMD_A_VALID;
> +
> +			instr_data_in = instr;
> +			break;
> +
> +		case NAND_OP_DATA_OUT_INSTR:
> +			trfr_out_sz = nand_subop_get_data_len(subop, op_id);
> +			offset = nand_subop_get_data_start_off(subop, op_id);
> +			trfr_out_sz = min_t(size_t, trfr_out_sz, 4);
> +
> +			cmd |= CMD_TRANS_SIZE(trfr_out_sz) | CMD_PIO | CMD_TX | CMD_A_VALID;
> +
> +			memcpy(&value, instr->ctx.data.buf.out + offset, trfr_out_sz);
> +			writel(value, nand->regs + RESP);
> +
> +			break;
> +		case NAND_OP_WAITRDY_INSTR:
> +			cmd |= CMD_RBSY_CHK;
> +			break;
> +
> +		}
> +	}
> +
> +
> +	cmd |= CMD_GO | CMD_CE(nand->cur_chip);
> +	writel(cmd, nand->regs + CMD);
> +	wait_for_completion(&nand->command_complete);
> +
> +	if (instr_data_in) {
> +		u32 value;
> +		size_t n = min_t(size_t, trfr_in_sz, 4);
> +
> +		value = readl(nand->regs + RESP);
> +		memcpy(instr_data_in->ctx.data.buf.in + offset, &value, n);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct nand_op_parser tegra_nand_op_parser = NAND_OP_PARSER(
> +	NAND_OP_PARSER_PATTERN(tegra_nand_cmd,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(true),
> +		NAND_OP_PARSER_PAT_ADDR_ELEM(true, 8),
> +		NAND_OP_PARSER_PAT_CMD_ELEM(true),
> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(true)),
> +	NAND_OP_PARSER_PATTERN(tegra_nand_cmd,
> +		NAND_OP_PARSER_PAT_DATA_OUT_ELEM(false, 4)),
> +	NAND_OP_PARSER_PATTERN(tegra_nand_cmd,
> +		NAND_OP_PARSER_PAT_CMD_ELEM(true),
> +		NAND_OP_PARSER_PAT_ADDR_ELEM(true, 8),
> +		NAND_OP_PARSER_PAT_CMD_ELEM(true),
> +		NAND_OP_PARSER_PAT_WAITRDY_ELEM(true),
> +		NAND_OP_PARSER_PAT_DATA_IN_ELEM(true, 4)),
> +	);
> +
> +static int tegra_nand_exec_op(struct nand_chip *chip,
> +			     const struct nand_operation *op,
> +			     bool check_only)
> +{
> +	return nand_op_parser_exec_op(chip, &tegra_nand_op_parser, op,
> +				      check_only);
> +}

Missing empty line here.

> +static void tegra_nand_select_chip(struct mtd_info *mtd, int chip)
> +{
> +	struct tegra_nand *nand = to_tegra_nand(mtd);
> +
> +	nand->cur_chip = chip;
> +}

...

> +
> +static void tegra_nand_setup_chiptiming(struct tegra_nand *nand)
> +{
> +	struct nand_chip *chip = &nand->chip;
> +	int mode;
> +
> +	mode = onfi_get_async_timing_mode(chip);
> +	if (mode == ONFI_TIMING_MODE_UNKNOWN)
> +		mode = chip->onfi_timing_mode_default;
> +	else
> +		mode = fls(mode);
> +
> +	tegra_nand_setup_timing(nand, mode);

Hm, you shouldn't do that. Let the core select the timing mode for you,
and just implement the ->setup_data_interface() hook.

> +}
> +
> +static int tegra_nand_probe(struct platform_device *pdev)
> +{
> +	struct reset_control *rst;
> +	struct tegra_nand *nand;
> +	struct nand_chip *chip;
> +	struct mtd_info *mtd;
> +	struct resource *res;
> +	unsigned long value;
> +	int irq, err = 0;
> +
> +	nand = devm_kzalloc(&pdev->dev, sizeof(*nand), GFP_KERNEL);
> +	if (!nand)
> +		return -ENOMEM;
> +
> +	nand->dev = &pdev->dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	nand->regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(nand->regs))
> +		return PTR_ERR(nand->regs);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	err = devm_request_irq(&pdev->dev, irq, tegra_nand_irq, 0,
> +			       dev_name(&pdev->dev), nand);
> +	if (err)
> +		return err;
> +
> +	rst = devm_reset_control_get(&pdev->dev, "nand");
> +	if (IS_ERR(rst))
> +		return PTR_ERR(rst);
> +
> +	nand->clk = devm_clk_get(&pdev->dev, "nand");
> +	if (IS_ERR(nand->clk))
> +		return PTR_ERR(nand->clk);
> +
> +	nand->wp_gpio = gpiod_get_optional(&pdev->dev, "wp-gpios",
> +					   GPIOD_OUT_HIGH);
> +	if (IS_ERR(nand->wp_gpio))
> +		return PTR_ERR(nand->wp_gpio);
> +
> +	err = clk_prepare_enable(nand->clk);
> +	if (err)
> +		return err;
> +
> +	reset_control_assert(rst);
> +	udelay(2);
> +	reset_control_deassert(rst);
> +
> +	value = HWSTATUS_RDSTATUS_MASK(1) | HWSTATUS_RDSTATUS_VALUE(0) |
> +		HWSTATUS_RBSY_MASK(NAND_STATUS_READY) |
> +		HWSTATUS_RBSY_VALUE(NAND_STATUS_READY);
> +	writel(NAND_CMD_STATUS, nand->regs + HWSTATUS_CMD);
> +	writel(value, nand->regs + HWSTATUS_MASK);
> +
> +	init_completion(&nand->command_complete);
> +	init_completion(&nand->dma_complete);
> +
> +	/* clear interrupts */
> +	value = readl(nand->regs + ISR);
> +	writel(value, nand->regs + ISR);
> +
> +	writel(DMA_CTRL_IS_DONE, nand->regs + DMA_CTRL);
> +
> +	/* enable interrupts */
> +	value = IER_UND | IER_OVR | IER_CMD_DONE | IER_ECC_ERR | IER_GIE;
> +	writel(value, nand->regs + IER);
> +
> +	/* reset config */
> +	writel(0, nand->regs + CFG);
> +
> +	chip = &nand->chip;
> +	mtd = nand_to_mtd(chip);
> +
> +	mtd->dev.parent = &pdev->dev;
> +	mtd->name = "tegra_nand";
> +	mtd->owner = THIS_MODULE;
> +
> +	nand_set_flash_node(chip, pdev->dev.of_node);
> +	nand_set_controller_data(chip, nand);
> +
> +	chip->options = NAND_NO_SUBPAGE_WRITE;
> +	chip->exec_op = tegra_nand_exec_op;
> +	chip->select_chip = tegra_nand_select_chip;
> +	tegra_nand_setup_timing(nand, 0);
> +
> +	err = nand_scan_ident(mtd, 1, NULL);
> +	if (err)
> +		goto err_disable_clk;
> +
> +	if (chip->bbt_options & NAND_BBT_USE_FLASH)
> +		chip->bbt_options |= NAND_BBT_NO_OOB;
> +
> +	nand->data_buf = dmam_alloc_coherent(&pdev->dev, mtd->writesize,
> +					    &nand->data_dma, GFP_KERNEL);
> +	if (!nand->data_buf) {
> +		err = -ENOMEM;
> +		goto err_disable_clk;
> +	}
> +
> +	nand->oob_buf = dmam_alloc_coherent(&pdev->dev, mtd->oobsize,
> +					    &nand->oob_dma, GFP_KERNEL);
> +	if (!nand->oob_buf) {
> +		err = -ENOMEM;
> +		goto err_disable_clk;
> +	}
> +
> +	chip->ecc.mode = NAND_ECC_HW;
> +	chip->ecc.size = 512;
> +	chip->ecc.read_page = tegra_nand_read_page;
> +	chip->ecc.write_page = tegra_nand_write_page;

I'd like to have raw accessors implemented here.

That was just a quick review focusing mainly on architectural issues so
that you can start working on a v2.

Regards,

Boris
