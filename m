Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751695AbeFDU4Z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 16:56:25 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:52236 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751103AbeFDU4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 16:56:22 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Mon, 04 Jun 2018 22:56:20 +0200
From: Stefan Agner <stefan@agner.ch>
To: =?UTF-8?Q?Randolph_Maa=C3=9Fen?= <gaireg@gaireg.de>
Cc: boris.brezillon@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, thierry.reding@gmail.com, dev@lynxeye.de,
        miquel.raynal@bootlin.com, richard@nod.at, marcel@ziswiler.com,
        krzk@kernel.org, digetx@gmail.com, benjamin.lindqvist@endian.se,
        jonathanh@nvidia.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mirza.krak@gmail.com, linux-mtd@lists.infradead.org,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] mtd: rawnand: add NVIDIA Tegra NAND Flash
 controller driver
In-Reply-To: <1528132590.3048.4.camel@gaireg.de>
References: <20180531221637.6017-1-stefan@agner.ch>
 <20180531221637.6017-5-stefan@agner.ch> <1528132590.3048.4.camel@gaireg.de>
Message-ID: <1702074adb9105a61971a3cb5867b7ed@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-3.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[23];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randolph,

On 04.06.2018 19:16, Randolph Maaßen wrote:
> Am Freitag, den 01.06.2018, 00:16 +0200 schrieb Stefan Agner:
>> Add support for the NAND flash controller found on NVIDIA
>> Tegra 2 SoCs. This implementation does not make use of the
>> command queue feature. Regular operations/data transfers are
>> done in PIO mode. Page read/writes with hardware ECC make
>> use of the DMA for data transfer.
>>
>> Signed-off-by: Lucas Stach <dev@lynxeye.de>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  MAINTAINERS                       |    7 +
>>  drivers/mtd/nand/raw/Kconfig      |    6 +
>>  drivers/mtd/nand/raw/Makefile     |    1 +
>>  drivers/mtd/nand/raw/tegra_nand.c | 1143
>> +++++++++++++++++++++++++++++
>>  4 files changed, 1157 insertions(+)
>>  create mode 100644 drivers/mtd/nand/raw/tegra_nand.c
>>
[...]
>> +static int tegra_nand_chips_init(struct device *dev,
>> +				 struct tegra_nand_controller *ctrl)
>> +{
>> +	struct device_node *np = dev->of_node;
>> +	struct device_node *np_nand;
>> +	int nchips = of_get_child_count(np);
>> +	struct tegra_nand_chip *nand;
>> +	struct mtd_info *mtd;
>> +	struct nand_chip *chip;
>> +	unsigned long config, bch_config = 0;
>> +	int bits_per_step;
>> +	int ret;
>> +
>> +	if (nchips != 1) {
>> +		dev_err(dev, "Currently only one NAND chip
>> supported\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	np_nand = of_get_next_child(np, NULL);
>> +
>> +	nand = devm_kzalloc(dev, sizeof(*nand), GFP_KERNEL);
>> +	if (!nand)
>> +		return -ENOMEM;
>> +
>> +	nand->wp_gpio = devm_gpiod_get_optional(dev, "wp",
>> GPIOD_OUT_LOW);
>> +
>> +	if (IS_ERR(nand->wp_gpio)) {
>> +		ret = PTR_ERR(nand->wp_gpio);
>> +		dev_err(dev, "Failed to request WP GPIO: %d\n",
>> ret);
>> +		return ret;
>> +	}
>> +
>> +	chip = &nand->chip;
>> +	chip->controller = &ctrl->controller;
>> +
>> +	mtd = nand_to_mtd(chip);
>> +
>> +	mtd->dev.parent = dev;
>> +	if (!mtd->name)
>> +		mtd->name = "tegra_nand";
>> +	mtd->owner = THIS_MODULE;
>> +
>> +	nand_set_flash_node(chip, np_nand);
> 
> Hi,
> i just tried this driver and it works great so far, thanks.
> I just found, that assigning the of node after setting the mtd->name
> makes it impossible to assign a name via devicetree label. I have read
> the discussion about the label on this list, so I'm curious if this is
> intentional? Setting mtd->name after nand_set_flash_node() enables the
> label parameter.
> 

Hm, good catch. No that was not intentional. The name indeed should be
assigned after the call to nand_set_flash_node. Will fix this in the
next revision.

>> +
>> +	chip->options = NAND_NO_SUBPAGE_WRITE |
>> NAND_USE_BOUNCE_BUFFER;
>> +	chip->exec_op = tegra_nand_exec_op;
>> +	chip->select_chip = tegra_nand_select_chip;
>> +	chip->setup_data_interface =
>> tegra_nand_setup_data_interface;
>> +
>> +	ret = nand_scan_ident(mtd, 1, NULL);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (chip->bbt_options & NAND_BBT_USE_FLASH)
>> +		chip->bbt_options |= NAND_BBT_NO_OOB;
>> +
>> +	chip->ecc.mode = NAND_ECC_HW;
>> +	chip->ecc.size = 512;
>> +	chip->ecc.steps = mtd->writesize / chip->ecc.size;
>> +	if (chip->ecc_step_ds != 512) {
>> +		dev_err(dev, "Unsupported step size %d\n", chip-
>> >ecc_step_ds);
>> +		return -EINVAL;
>> +	}
>> +
>> +	chip->ecc.read_page = tegra_nand_read_page_hwecc;
>> +	chip->ecc.write_page = tegra_nand_write_page_hwecc;
>> +
>> +	config = readl_relaxed(ctrl->regs + CFG);
>> +	config |= CFG_PIPE_EN | CFG_SKIP_SPARE |
>> CFG_SKIP_SPARE_SIZE_4;
>> +
>> +	if (chip->options & NAND_BUSWIDTH_16)
>> +		config |= CFG_BUS_WIDTH_16;
>> +
>> +	if (chip->ecc.algo == NAND_ECC_UNKNOWN) {
>> +		if (mtd->writesize < 2048)
>> +			chip->ecc.algo = NAND_ECC_RS;
>> +		else
>> +			chip->ecc.algo = NAND_ECC_BCH;
>> +	}
>> +
>> +	if (chip->ecc.algo == NAND_ECC_BCH && mtd->writesize < 2048)
>> {
>> +		dev_err(dev, "BCH supportes 2K or 4K page size
>> only\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!chip->ecc.strength) {
>> +		ret = tegra_nand_select_strength(chip, mtd-
>> >oobsize);
>> +		if (ret < 0) {
>> +			dev_err(dev, "No valid strenght found,
>> minimum %d\n",
>> +				chip->ecc_strength_ds);
>> +			return ret;
>> +		}
>> +
>> +		chip->ecc.strength = ret;
>> +	}
>> +
>> +	switch (chip->ecc.algo) {
>> +	case NAND_ECC_RS:
>> +		bits_per_step = BITS_PER_STEP_RS * chip-
>> >ecc.strength;
>> +		mtd_set_ooblayout(mtd, &tegra_nand_oob_rs_ops);
>> +		switch (chip->ecc.strength) {
>> +		case 4:
>> +			config |= CFG_ECC_SEL | CFG_TVAL_4;
>> +			break;
>> +		case 6:
>> +			config |= CFG_ECC_SEL | CFG_TVAL_6;
>> +			break;
>> +		case 8:
>> +			config |= CFG_ECC_SEL | CFG_TVAL_8;
>> +			break;
>> +		default:
>> +			dev_err(dev, "ECC strength %d not
>> supported\n",
>> +				chip->ecc.strength);
>> +			return -EINVAL;
>> +		}
>> +		break;
>> +	case NAND_ECC_BCH:
>> +		bits_per_step = BITS_PER_STEP_BCH * chip-
>> >ecc.strength;
>> +		mtd_set_ooblayout(mtd, &tegra_nand_oob_bch_ops);
>> +		switch (chip->ecc.strength) {
>> +		case 4:
>> +			bch_config = BCH_TVAL_4;
>> +			break;
>> +		case 8:
>> +			bch_config = BCH_TVAL_8;
>> +			break;
>> +		case 14:
>> +			bch_config = BCH_TVAL_14;
>> +			break;
>> +		case 16:
>> +			bch_config = BCH_TVAL_16;
>> +			break;
>> +		default:
>> +			dev_err(dev, "ECC strength %d not
>> supported\n",
>> +				chip->ecc.strength);
>> +			return -EINVAL;
>> +		}
>> +		break;
>> +	default:
>> +		dev_err(dev, "ECC algorithm not supported\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	dev_info(dev, "Using %s with strength %d per 512 byte
>> step\n",
>> +			chip->ecc.algo == NAND_ECC_BCH ? "BCH" :
>> "RS",
>> +			chip->ecc.strength);
>> +
>> +	chip->ecc.bytes = DIV_ROUND_UP(bits_per_step,
>> BITS_PER_BYTE);
>> +
>> +	switch (mtd->writesize) {
>> +	case 256:
>> +		config |= CFG_PS_256;
>> +		break;
>> +	case 512:
>> +		config |= CFG_PS_512;
>> +		break;
>> +	case 1024:
>> +		config |= CFG_PS_1024;
>> +		break;
>> +	case 2048:
>> +		config |= CFG_PS_2048;
>> +		break;
>> +	case 4096:
>> +		config |= CFG_PS_4096;
>> +		break;
>> +	default:
>> +		dev_err(dev, "Unsupported writesize %d\n", mtd-
>> >writesize);
>> +		return -ENODEV;
>> +	}
>> +
>> +	writel_relaxed(config, ctrl->regs + CFG);
>> +	writel_relaxed(bch_config, ctrl->regs + BCH_CONFIG);
>> +
>> +	ret = nand_scan_tail(mtd);
>> +	if (ret)
>> +		return ret;
>> +
>> +	mtd_ooblayout_free(mtd, 0, &nand->tag);
>> +
>> +	config |= CFG_TAG_BYTE_SIZE(nand->tag.length - 1);
>> +	writel_relaxed(config, ctrl->regs + CFG);
>> +
>> +	ret = mtd_device_register(mtd, NULL, 0);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to register mtd device: %d\n",
>> ret);
>> +		nand_cleanup(chip);
>> +		return ret;
>> +	}
>> +
>> +	ctrl->chip = chip;
>> +
>> +	return 0;
>> +}
>> +
>> +static int tegra_nand_probe(struct platform_device *pdev)
>> +{
>> +	struct reset_control *rst;
>> +	struct tegra_nand_controller *ctrl;
>> +	struct resource *res;
>> +	unsigned long reg;
>> +	int irq, err = 0;
>> +
>> +	ctrl = devm_kzalloc(&pdev->dev, sizeof(*ctrl), GFP_KERNEL);
>> +	if (!ctrl)
>> +		return -ENOMEM;
>> +
>> +	ctrl->dev = &pdev->dev;
>> +	nand_hw_control_init(&ctrl->controller);
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	ctrl->regs = devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(ctrl->regs))
>> +		return PTR_ERR(ctrl->regs);
>> +
>> +	rst = devm_reset_control_get(&pdev->dev, "nand");
>> +	if (IS_ERR(rst))
>> +		return PTR_ERR(rst);
>> +
>> +	ctrl->clk = devm_clk_get(&pdev->dev, "nand");
>> +	if (IS_ERR(ctrl->clk))
>> +		return PTR_ERR(ctrl->clk);
>> +
>> +	err = clk_prepare_enable(ctrl->clk);
>> +	if (err)
>> +		return err;
>> +
>> +	err = reset_control_reset(rst);
>> +	if (err)
>> +		goto err_disable_clk;
>> +
>> +	reg = HWSTATUS_RDSTATUS_MASK(1) | HWSTATUS_RDSTATUS_VALUE(0)
>> |
>> +		HWSTATUS_RBSY_MASK(NAND_STATUS_READY) |
>> +		HWSTATUS_RBSY_VALUE(NAND_STATUS_READY);
>> +	writel_relaxed(NAND_CMD_STATUS, ctrl->regs + HWSTATUS_CMD);
>> +	writel_relaxed(reg, ctrl->regs + HWSTATUS_MASK);
>> +
>> +	init_completion(&ctrl->command_complete);
>> +	init_completion(&ctrl->dma_complete);
>> +
>> +	/* clear interrupts */
>> +	reg = readl_relaxed(ctrl->regs + ISR);
>> +	writel_relaxed(reg, ctrl->regs + ISR);
>> +
>> +	irq = platform_get_irq(pdev, 0);
>> +	err = devm_request_irq(&pdev->dev, irq, tegra_nand_irq, 0,
>> +			       dev_name(&pdev->dev), ctrl);
>> +	if (err)
>> +		goto err_disable_clk;
>> +
>> +	writel_relaxed(DMA_CTRL_IS_DONE, ctrl->regs + DMA_CTRL);
>> +
>> +	/* enable interrupts */
>> +	reg = IER_UND | IER_OVR | IER_CMD_DONE | IER_GIE;
>> +	writel_relaxed(reg, ctrl->regs + IER);
>> +
>> +	/* reset config */
>> +	writel_relaxed(0, ctrl->regs + CFG);
>> +
>> +	err = tegra_nand_chips_init(ctrl->dev, ctrl);
>> +	if (err)
>> +		goto err_disable_clk;
>> +
>> +	platform_set_drvdata(pdev, ctrl);
>> +
>> +	return 0;
>> +
>> +err_disable_clk:
>> +	clk_disable_unprepare(ctrl->clk);
>> +	return err;
>> +}
>> +
>> +static int tegra_nand_remove(struct platform_device *pdev)
>> +{
>> +	struct tegra_nand_controller *ctrl =
>> platform_get_drvdata(pdev);
>> +
>> +	nand_release(nand_to_mtd(ctrl->chip));
>> +
>> +	clk_disable_unprepare(ctrl->clk);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id tegra_nand_of_match[] = {
>> +	{ .compatible = "nvidia,tegra20-nand" },
>> +	{ /* sentinel */ }
>> +};
>> +
>> +static struct platform_driver tegra_nand_driver = {
>> +	.driver = {
>> +		.name = "tegra-nand",
>> +		.of_match_table = tegra_nand_of_match,
>> +	},
>> +	.probe = tegra_nand_probe,
>> +	.remove = tegra_nand_remove,
>> +};
>> +module_platform_driver(tegra_nand_driver);
>> +
>> +MODULE_DESCRIPTION("NVIDIA Tegra NAND driver");
>> +MODULE_AUTHOR("Thierry Reding <thierry.reding@nvidia.com>");
>> +MODULE_AUTHOR("Lucas Stach <dev@lynxeye.de>");
>> +MODULE_AUTHOR("Stefan Agner <stefan@agner.ch>");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DEVICE_TABLE(of, tegra_nand_of_match);
> 
> Sorry for any noise/mistake, I'm new to kernel development

That was constructive feedback! Thanks for pointing out!

--
Stefan
