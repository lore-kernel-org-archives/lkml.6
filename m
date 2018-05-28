Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425031AbeE1MlO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:41:14 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:52134 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165068AbeE1MlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 08:41:07 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Mon, 28 May 2018 14:41:05 +0200
From: Stefan Agner <stefan@agner.ch>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: boris.brezillon@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, thierry.reding@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, dev@lynxeye.de,
        richard@nod.at, marcel@ziswiler.com, krzk@kernel.org, digetx@gmail.com,
        benjamin.lindqvist@endian.se, jonathanh@nvidia.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, mirza.krak@gmail.com,
        linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 3/6] mtd: rawnand: add NVIDIA Tegra NAND Flash
 controller driver
In-Reply-To: <20180528001940.7f54caff@xps13>
References: <20180527215442.14760-4-stefan@agner.ch>
 <20180528001940.7f54caff@xps13>
Message-ID: <fc2900acfbcdeeef0a3a9c8339aedada@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-3.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[25];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.05.2018 00:19, Miquel Raynal wrote:
> Hi Stefan,
> 
> A few more comments here.
> 
> On Sun, 27 May 2018 23:54:39 +0200, Stefan Agner <stefan@agner.ch>
> wrote:
> 
>> Add support for the NAND flash controller found on NVIDIA
>> Tegra 2 SoCs. This implementation does not make use of the
>> command queue feature. Regular operations/data transfers are
>> done in PIO mode. Page read/writes with hardware ECC make
>> use of the DMA for data transfer.
>>
>> Signed-off-by: Lucas Stach <dev@lynxeye.de>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  MAINTAINERS                       |   7 +
>>  drivers/mtd/nand/raw/Kconfig      |   6 +
>>  drivers/mtd/nand/raw/Makefile     |   1 +
>>  drivers/mtd/nand/raw/tegra_nand.c | 999 ++++++++++++++++++++++++++++++
>>  4 files changed, 1013 insertions(+)
>>  create mode 100644 drivers/mtd/nand/raw/tegra_nand.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 58b9861ccf99..8cbbb7111742 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -13844,6 +13844,13 @@ M:	Laxman Dewangan <ldewangan@nvidia.com>
>>  S:	Supported
>>  F:	drivers/input/keyboard/tegra-kbc.c
>>
>> +TEGRA NAND DRIVER
>> +M:	Stefan Agner <stefan@agner.ch>
>> +M:	Lucas Stach <dev@lynxeye.de>
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/mtd/nvidia,tegra20-nand.txt
> 
> I think most MTD bindings use '-' instead of ','. I don't have a
> preference, it's just for coherence.
> 

Sure, will use a dash.

>> +F:	drivers/mtd/nand/raw/tegra_nand.c
>> +
>>  TEGRA PWM DRIVER
>>  M:	Thierry Reding <thierry.reding@gmail.com>
>>  S:	Supported
>> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
>> index 19a2b283fbbe..012c63c6ab47 100644
>> --- a/drivers/mtd/nand/raw/Kconfig
>> +++ b/drivers/mtd/nand/raw/Kconfig
>> @@ -534,4 +534,10 @@ config MTD_NAND_MTK
>>  	  Enables support for NAND controller on MTK SoCs.
>>  	  This controller is found on mt27xx, mt81xx, mt65xx SoCs.
>>
>> +config MTD_NAND_TEGRA
>> +	tristate "Support for NAND on NVIDIA Tegra"
>> +	depends on ARCH_TEGRA || COMPILE_TEST
>> +	help
>> +	  Enables support for NAND flash on NVIDIA Tegra SoC based boards.
> 
> Please make the term "controller" appear because it's mostly a
> controller driver that you're adding.
> 

Ok.

>> +
>>  endif # MTD_NAND
>> diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
>> index 165b7ef9e9a1..d5a5f9832b88 100644
>> --- a/drivers/mtd/nand/raw/Makefile
>> +++ b/drivers/mtd/nand/raw/Makefile
>> @@ -56,6 +56,7 @@ obj-$(CONFIG_MTD_NAND_HISI504)	        += hisi504_nand.o
>>  obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= brcmnand/
>>  obj-$(CONFIG_MTD_NAND_QCOM)		+= qcom_nandc.o
>>  obj-$(CONFIG_MTD_NAND_MTK)		+= mtk_ecc.o mtk_nand.o
>> +obj-$(CONFIG_MTD_NAND_TEGRA)		+= tegra_nand.o
>>
>>  nand-objs := nand_base.o nand_bbt.o nand_timings.o nand_ids.o
>>  nand-objs += nand_amd.o
> 
> [...]
> 
>> +static int tegra_nand_setup_data_interface(struct mtd_info *mtd, int csline,
>> +					   const struct nand_data_interface *conf)
>> +{
>> +	struct nand_chip *chip = mtd_to_nand(mtd);
>> +	struct tegra_nand_controller *ctrl = to_tegra_ctrl(chip->controller);
>> +	const struct nand_sdr_timings *timings;
>> +
>> +	timings = nand_get_sdr_timings(conf);
>> +	if (IS_ERR(timings))
>> +		return PTR_ERR(timings);
>> +
>> +	if (csline == NAND_DATA_IFACE_CHECK_ONLY)
>> +		return 0;
>> +
>> +	tegra_nand_setup_timing(ctrl, timings);
> 
> Is this indirection really needed?
> 

This evolved due to historic reasons, will get rid of it.

>> +
>> +	return 0;
>> +}
>> +
>> +static int tegra_nand_chips_init(struct device *dev,
>> +				 struct tegra_nand_controller *ctrl)
>> +{
>> +	struct device_node *np = dev->of_node;
>> +	struct device_node *np_nand;
>> +	int nchips = of_get_child_count(np);
>> +	struct tegra_nand_chip *nand;
>> +	struct mtd_info *mtd;
>> +	struct nand_chip *chip;
>> +	unsigned long config, bch_config = 0;
>> +	int bits_per_step;
>> +	int err;
>> +
>> +	if (nchips != 1) {
>> +		dev_err(dev, "currently only one NAND chip supported\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	np_nand = of_get_next_child(np, NULL);
>> +
>> +	nand = devm_kzalloc(dev, sizeof(*nand), GFP_KERNEL);
>> +	if (!nand) {
>> +		dev_err(dev, "could not allocate chip structure\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	nand->wp_gpio = devm_gpiod_get_optional(dev, "wp", GPIOD_OUT_LOW);
>> +
>> +	if (IS_ERR(nand->wp_gpio)) {
>> +		err = PTR_ERR(nand->wp_gpio);
>> +		dev_err(dev, "failed to request WP GPIO: %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	chip = &nand->chip;
>> +	chip->controller = &ctrl->controller;
>> +	ctrl->chip = chip;
>> +
>> +	mtd = nand_to_mtd(chip);
>> +
>> +	mtd->dev.parent = dev;
>> +	mtd->name = "tegra_nand";
>> +	mtd->owner = THIS_MODULE;
>> +
>> +	nand_set_flash_node(chip, np_nand);
>> +
>> +	chip->options = NAND_NO_SUBPAGE_WRITE | NAND_USE_BOUNCE_BUFFER;
>> +	chip->exec_op = tegra_nand_exec_op;
>> +	chip->select_chip = tegra_nand_select_chip;
>> +	chip->setup_data_interface = tegra_nand_setup_data_interface;
>> +
>> +	err = nand_scan_ident(mtd, 1, NULL);
>> +	if (err)
>> +		return err;
>> +
>> +	if (chip->bbt_options & NAND_BBT_USE_FLASH)
>> +		chip->bbt_options |= NAND_BBT_NO_OOB;
>> +
>> +	chip->ecc.mode = NAND_ECC_HW;
>> +	if (!chip->ecc.size)
>> +		chip->ecc.size = 512;
>> +	if (chip->ecc.size != 512)
>> +		return -EINVAL;
> 
> This is useless. You can force ecc.size to 512 and forget about the DT
> property (please update the DT bindings).
> 

Ok.

>> +
>> +	chip->ecc.read_page = tegra_nand_read_page_hwecc;
>> +	chip->ecc.write_page = tegra_nand_write_page_hwecc;
>> +	/* Not functional for unknown reason...
>> +	chip->ecc.read_page_raw = tegra_nand_read_page;
>> +	chip->ecc.write_page_raw = tegra_nand_write_page;
> 
> Please add the _raw suffix to these helpers.
> 

They are also used from tegra_nand_read_page_hwecc, that is why I was
hesitant to add _raw...

>> +	*/
>> +	config = readl(ctrl->regs + CFG);
>> +	config |= CFG_PIPE_EN | CFG_SKIP_SPARE | CFG_SKIP_SPARE_SIZE_4;
>> +
>> +	if (chip->options & NAND_BUSWIDTH_16)
>> +		config |= CFG_BUS_WIDTH_16;
>> +
>> +	switch (chip->ecc.algo) {
>> +	case NAND_ECC_RS:
>> +		bits_per_step = BITS_PER_STEP_RS * chip->ecc.strength;
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
>> +			dev_err(dev, "ECC strength %d not supported\n",
>> +				chip->ecc.strength);
>> +			return -EINVAL;
>> +		}
>> +		break;
>> +	case NAND_ECC_BCH:
>> +		bits_per_step = BITS_PER_STEP_BCH * chip->ecc.strength;
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
>> +			dev_err(dev, "ECC strength %d not supported\n",
>> +				chip->ecc.strength);
>> +			return -EINVAL;
>> +		}
>> +		break;
>> +	default:
>> +		dev_err(dev, "ECC algorithm not supported\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	chip->ecc.bytes = DIV_ROUND_UP(bits_per_step, 8);
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
>> +		dev_err(dev, "unhandled writesize %d\n", mtd->writesize);
>> +		return -ENODEV;
>> +	}
>> +
>> +	writel(config, ctrl->regs + CFG);
>> +	writel(bch_config, ctrl->regs + BCH_CONFIG);
>> +
>> +	err = nand_scan_tail(mtd);
>> +	if (err)
>> +		return err;
>> +
>> +	config |= CFG_TAG_BYTE_SIZE(mtd_ooblayout_count_freebytes(mtd) - 1);
>> +	writel(config, ctrl->regs + CFG);
>> +
>> +	err = mtd_device_register(mtd, NULL, 0);
>> +	if (err)
> 
> Missing nand_cleanup() in the error path.
> 

Ok.

--
Stefan


>> +		return err;
>> +
>> +	return 0;
>> +}
>> +
> 
> [...]
