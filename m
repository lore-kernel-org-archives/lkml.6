Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754317AbeEaJhr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 05:37:47 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:58758 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754154AbeEaJhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 05:37:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Thu, 31 May 2018 11:37:41 +0200
From: Stefan Agner <stefan@agner.ch>
To: boris.brezillon@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, thierry.reding@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc: dev@lynxeye.de, miquel.raynal@bootlin.com, richard@nod.at,
        marcel@ziswiler.com, krzk@kernel.org, digetx@gmail.com,
        benjamin.lindqvist@endian.se, jonathanh@nvidia.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, mirza.krak@gmail.com,
        linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 3/6] mtd: rawnand: add NVIDIA Tegra NAND Flash
 controller driver
In-Reply-To: <20180527215442.14760-4-stefan@agner.ch>
References: <20180527215442.14760-4-stefan@agner.ch>
Message-ID: <80eb6a514e96cdbd460c6a0937a9dff9@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-3.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[25];
         BAYES_HAM(-3.00)[100.00%];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         TO_DN_NONE(0.00)[];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.05.2018 23:54, Stefan Agner wrote:
> Add support for the NAND flash controller found on NVIDIA
> Tegra 2 SoCs. This implementation does not make use of the
> command queue feature. Regular operations/data transfers are
> done in PIO mode. Page read/writes with hardware ECC make
> use of the DMA for data transfer.
> 
> Signed-off-by: Lucas Stach <dev@lynxeye.de>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  MAINTAINERS                       |   7 +
>  drivers/mtd/nand/raw/Kconfig      |   6 +
>  drivers/mtd/nand/raw/Makefile     |   1 +
>  drivers/mtd/nand/raw/tegra_nand.c | 999 ++++++++++++++++++++++++++++++
>  4 files changed, 1013 insertions(+)
>  create mode 100644 drivers/mtd/nand/raw/tegra_nand.c
> 
[...]
> +
> +	chip->ecc.read_page = tegra_nand_read_page_hwecc;
> +	chip->ecc.write_page = tegra_nand_write_page_hwecc;
> +	/* Not functional for unknown reason...
> +	chip->ecc.read_page_raw = tegra_nand_read_page;
> +	chip->ecc.write_page_raw = tegra_nand_write_page;
> +	*/

I am giving up on these raw read/write_page functions. Using DMA without
HW ECC just seems not to work.

I do not get the CMD_DONE interrupt as I do when using DMA with HW ECC.
I tried with the same settings, just not enabling DMA (HW_ECC not set,
HW_ERR_CORRECTION not set, and also with/without PIPELINE_EN).

A register dump after a successful read with HW ECC looks like this:
[  196.935199] CMD: 0x66890104
[  196.938003] STATUS: 0x00000101
[  196.941049] ISR: 0x00000000
[  196.943865] CONFIG: 0x0084000b
[  196.946914] DMA_MST_CTRL: 0x15000004
[  196.950481] DMA_CFG_A: 0x00000fff
[  196.954361] DMA_CFG_B: 0x00000000
[  196.957670] FIFO: 0x0000aa00

Whereas without HW ECC completion times out (using
wait_for_completion_timeout already):
[  226.128618] tegra-nand 70008000.nand: CMD timeout, last CMD:
0xe6890104                              
[  226.135375] CMD: 0xe6890104
[  226.138201] STATUS: 0x00000100
[  226.141280] ISR: 0x00000100
[  226.153372] CONFIG: 0x0084000b
[  226.156423] DMA_MST_CTRL: 0x95000004
[  226.159989] DMA_CFG_A: 0x00000fff
[  226.164084] DMA_CFG_B: 0x00000000
[  226.167393] FIFO: 0x0000aa00

It looks to me as if the DMA just does not start the data cycle. The
NAND seems to have read the page (RBSY0 is set).


Note that it is never explicitly stated whether DMA without HW ECC is
supported. There is some indication that it should: There are separated
bits to enable HW ECC/DMA, the reference manual states "If HW ECC is
enabled... " and a block diagram shows separate blocks for the ECC
Engine and NAND DMA control.

There is also indication that it does not: The chapter Restrictions
reads: "HW_ERR_CORRECTION = 0/1, doesn’t alter controller hardware
behavior. Software error correction scheme with HW_ERR_CORRECTION = 0,
is deprecated in Tegra 2 Processor."

Note that the default implementations nand_(read|write)_page_raw which
use exec_op do work fine! Unfortunately, the PIO mode only allows 4
bytes in a read cycle, hence raw read/write is slow...

--
Stefan


> +	config = readl(ctrl->regs + CFG);
> +	config |= CFG_PIPE_EN | CFG_SKIP_SPARE | CFG_SKIP_SPARE_SIZE_4;
> +
> +	if (chip->options & NAND_BUSWIDTH_16)
> +		config |= CFG_BUS_WIDTH_16;
> +
> +	switch (chip->ecc.algo) {
> +	case NAND_ECC_RS:
> +		bits_per_step = BITS_PER_STEP_RS * chip->ecc.strength;
> +		mtd_set_ooblayout(mtd, &tegra_nand_oob_rs_ops);
> +		switch (chip->ecc.strength) {
> +		case 4:
> +			config |= CFG_ECC_SEL | CFG_TVAL_4;
> +			break;
> +		case 6:
> +			config |= CFG_ECC_SEL | CFG_TVAL_6;
> +			break;
> +		case 8:
> +			config |= CFG_ECC_SEL | CFG_TVAL_8;
> +			break;
> +		default:
> +			dev_err(dev, "ECC strength %d not supported\n",
> +				chip->ecc.strength);
> +			return -EINVAL;
> +		}
> +		break;
> +	case NAND_ECC_BCH:
> +		bits_per_step = BITS_PER_STEP_BCH * chip->ecc.strength;
> +		mtd_set_ooblayout(mtd, &tegra_nand_oob_bch_ops);
> +		switch (chip->ecc.strength) {
> +		case 4:
> +			bch_config = BCH_TVAL_4;
> +			break;
> +		case 8:
> +			bch_config = BCH_TVAL_8;
> +			break;
> +		case 14:
> +			bch_config = BCH_TVAL_14;
> +			break;
> +		case 16:
> +			bch_config = BCH_TVAL_16;
> +			break;
> +		default:
> +			dev_err(dev, "ECC strength %d not supported\n",
> +				chip->ecc.strength);
> +			return -EINVAL;
> +		}
> +		break;
> +	default:
> +		dev_err(dev, "ECC algorithm not supported\n");
> +		return -EINVAL;
> +	}
> +
> +	chip->ecc.bytes = DIV_ROUND_UP(bits_per_step, 8);
> +
> +	switch (mtd->writesize) {
> +	case 256:
> +		config |= CFG_PS_256;
> +		break;
> +	case 512:
> +		config |= CFG_PS_512;
> +		break;
> +	case 1024:
> +		config |= CFG_PS_1024;
> +		break;
> +	case 2048:
> +		config |= CFG_PS_2048;
> +		break;
> +	case 4096:
> +		config |= CFG_PS_4096;
> +		break;
> +	default:
> +		dev_err(dev, "unhandled writesize %d\n", mtd->writesize);
> +		return -ENODEV;
> +	}
> +
> +	writel(config, ctrl->regs + CFG);
> +	writel(bch_config, ctrl->regs + BCH_CONFIG);
> +
> +	err = nand_scan_tail(mtd);
> +	if (err)
> +		return err;
> +
> +	config |= CFG_TAG_BYTE_SIZE(mtd_ooblayout_count_freebytes(mtd) - 1);
> +	writel(config, ctrl->regs + CFG);
> +
> +	err = mtd_device_register(mtd, NULL, 0);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static int tegra_nand_probe(struct platform_device *pdev)
> +{
> +	struct reset_control *rst;
> +	struct tegra_nand_controller *ctrl;
> +	struct resource *res;
> +	unsigned long value;
> +	int irq, err = 0;
> +
> +	ctrl = devm_kzalloc(&pdev->dev, sizeof(*ctrl), GFP_KERNEL);
> +	if (!ctrl)
> +		return -ENOMEM;
> +
> +	ctrl->dev = &pdev->dev;
> +	nand_hw_control_init(&ctrl->controller);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	ctrl->regs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(ctrl->regs))
> +		return PTR_ERR(ctrl->regs);
> +
> +	rst = devm_reset_control_get(&pdev->dev, "nand");
> +	if (IS_ERR(rst))
> +		return PTR_ERR(rst);
> +
> +	ctrl->clk = devm_clk_get(&pdev->dev, "nand");
> +	if (IS_ERR(ctrl->clk))
> +		return PTR_ERR(ctrl->clk);
> +
> +	err = clk_prepare_enable(ctrl->clk);
> +	if (err)
> +		return err;
> +
> +	reset_control_reset(rst);
> +
> +	value = HWSTATUS_RDSTATUS_MASK(1) | HWSTATUS_RDSTATUS_VALUE(0) |
> +		HWSTATUS_RBSY_MASK(NAND_STATUS_READY) |
> +		HWSTATUS_RBSY_VALUE(NAND_STATUS_READY);
> +	writel(NAND_CMD_STATUS, ctrl->regs + HWSTATUS_CMD);
> +	writel(value, ctrl->regs + HWSTATUS_MASK);
> +
> +	init_completion(&ctrl->command_complete);
> +	init_completion(&ctrl->dma_complete);
> +
> +	/* clear interrupts */
> +	value = readl(ctrl->regs + ISR);
> +	writel(value, ctrl->regs + ISR);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	err = devm_request_irq(&pdev->dev, irq, tegra_nand_irq, 0,
> +			       dev_name(&pdev->dev), ctrl);
> +	if (err)
> +		goto err_disable_clk;
> +
> +	writel(DMA_CTRL_IS_DONE, ctrl->regs + DMA_CTRL);
> +
> +	/* enable interrupts */
> +	value = IER_UND | IER_OVR | IER_CMD_DONE | IER_ECC_ERR | IER_GIE;
> +	writel(value, ctrl->regs + IER);
> +
> +	/* reset config */
> +	writel(0, ctrl->regs + CFG);
> +
> +	err = tegra_nand_chips_init(ctrl->dev, ctrl);
> +	if (err)
> +		goto err_disable_clk;
> +
> +	platform_set_drvdata(pdev, ctrl);
> +
> +	return 0;
> +
> +err_disable_clk:
> +	clk_disable_unprepare(ctrl->clk);
> +	return err;
> +}
> +
> +static int tegra_nand_remove(struct platform_device *pdev)
> +{
> +	struct tegra_nand_controller *ctrl = platform_get_drvdata(pdev);
> +
> +	nand_release(nand_to_mtd(ctrl->chip));
> +
> +	clk_disable_unprepare(ctrl->clk);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id tegra_nand_of_match[] = {
> +	{ .compatible = "nvidia,tegra20-nand" },
> +	{ /* sentinel */ }
> +};
> +
> +static struct platform_driver tegra_nand_driver = {
> +	.driver = {
> +		.name = "tegra-nand",
> +		.of_match_table = tegra_nand_of_match,
> +	},
> +	.probe = tegra_nand_probe,
> +	.remove = tegra_nand_remove,
> +};
> +module_platform_driver(tegra_nand_driver);
> +
> +MODULE_DESCRIPTION("NVIDIA Tegra NAND driver");
> +MODULE_AUTHOR("Thierry Reding <thierry.reding@nvidia.com>");
> +MODULE_AUTHOR("Lucas Stach <dev@lynxeye.de>");
> +MODULE_AUTHOR("Stefan Agner <stefan@agner.ch>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DEVICE_TABLE(of, tegra_nand_of_match);
