Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F66DC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0362175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbfBENzB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:55:01 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:60259 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfBENzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:55:01 -0500
X-Originating-IP: 90.88.22.177
Received: from xps13 (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 3A043E0003;
        Tue,  5 Feb 2019 13:54:55 +0000 (UTC)
Date:   Tue, 5 Feb 2019 14:54:54 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Mathieu Malaterre <malat@debian.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/9] mtd: rawnand: ingenic: Add support for the
 JZ4740
Message-ID: <20190205145454.377eb309@xps13>
In-Reply-To: <20190204190426.11618-7-paul@crapouillou.net>
References: <20190204190426.11618-1-paul@crapouillou.net>
        <20190204190426.11618-7-paul@crapouillou.net>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Paul Cercueil <paul@crapouillou.net> wrote on Mon,  4 Feb 2019 16:04:24
-0300:

> Add support for probing the ingenic-nand driver on the JZ4740 SoC from
> Ingenic, and the jz4740-ecc driver to support the JZ4740-specific
> ECC hardware.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Changes:
> 
> v2: New patch
> 
> v3: Also add support for the hardware ECC of the JZ4740 in this patch
> 
>  drivers/mtd/nand/raw/ingenic/Kconfig        |  10 ++
>  drivers/mtd/nand/raw/ingenic/Makefile       |   1 +
>  drivers/mtd/nand/raw/ingenic/ingenic_nand.c |  48 +++++--
>  drivers/mtd/nand/raw/ingenic/jz4740_ecc.c   | 192 ++++++++++++++++++++++++++++
>  4 files changed, 240 insertions(+), 11 deletions(-)
>  create mode 100644 drivers/mtd/nand/raw/ingenic/jz4740_ecc.c
> 
> diff --git a/drivers/mtd/nand/raw/ingenic/Kconfig b/drivers/mtd/nand/raw/ingenic/Kconfig
> index 4bf7d7af3b0a..cc663cc15119 100644
> --- a/drivers/mtd/nand/raw/ingenic/Kconfig
> +++ b/drivers/mtd/nand/raw/ingenic/Kconfig
> @@ -17,6 +17,16 @@ if MTD_NAND_JZ4780
>  config MTD_NAND_INGENIC_ECC
>  	tristate
>  
> +config MTD_NAND_JZ4740_ECC
> +	tristate "Hardware BCH support for JZ4740 SoC"
> +	select MTD_NAND_INGENIC_ECC
> +	help
> +	  Enable this driver to support the Reed-Solomon error-correction
> +	  hardware present on the JZ4740 SoC from Ingenic.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called jz4740-ecc.
> +
>  config MTD_NAND_JZ4780_BCH
>  	tristate "Hardware BCH support for JZ4780 SoC"
>  	select MTD_NAND_INGENIC_ECC
> diff --git a/drivers/mtd/nand/raw/ingenic/Makefile b/drivers/mtd/nand/raw/ingenic/Makefile
> index f3c3c0f230b0..563b7effcf59 100644
> --- a/drivers/mtd/nand/raw/ingenic/Makefile
> +++ b/drivers/mtd/nand/raw/ingenic/Makefile
> @@ -2,4 +2,5 @@ obj-$(CONFIG_MTD_NAND_JZ4740) += jz4740_nand.o
>  obj-$(CONFIG_MTD_NAND_JZ4780) += ingenic_nand.o
>  
>  obj-$(CONFIG_MTD_NAND_INGENIC_ECC) += ingenic_ecc.o
> +obj-$(CONFIG_MTD_NAND_JZ4740_ECC) += jz4740_ecc.o
>  obj-$(CONFIG_MTD_NAND_JZ4780_BCH) += jz4780_bch.o
> diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_nand.c b/drivers/mtd/nand/raw/ingenic/ingenic_nand.c
> index 0f51fd15fe79..3fd078920b17 100644
> --- a/drivers/mtd/nand/raw/ingenic/ingenic_nand.c
> +++ b/drivers/mtd/nand/raw/ingenic/ingenic_nand.c
> @@ -13,6 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/of_device.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> @@ -26,13 +27,15 @@
>  
>  #define DRV_NAME	"ingenic-nand"
>  
> -#define OFFSET_DATA	0x00000000
> -#define OFFSET_CMD	0x00400000
> -#define OFFSET_ADDR	0x00800000
> -
>  /* Command delay when there is no R/B pin. */
>  #define RB_DELAY_US	100
>  
> +struct jz_soc_info {
> +	unsigned long data_offset;
> +	unsigned long addr_offset;
> +	unsigned long cmd_offset;
> +};
> +
>  struct ingenic_nand_cs {
>  	unsigned int bank;
>  	void __iomem *base;
> @@ -41,6 +44,7 @@ struct ingenic_nand_cs {
>  struct ingenic_nfc {
>  	struct device *dev;
>  	struct ingenic_ecc *ecc;
> +	const struct jz_soc_info *soc_info;
>  	struct nand_controller controller;
>  	unsigned int num_banks;
>  	struct list_head chips;
> @@ -100,9 +104,9 @@ static void ingenic_nand_cmd_ctrl(struct nand_chip *chip, int cmd,
>  		return;
>  
>  	if (ctrl & NAND_ALE)
> -		writeb(cmd, cs->base + OFFSET_ADDR);
> +		writeb(cmd, cs->base + nfc->soc_info->addr_offset);
>  	else if (ctrl & NAND_CLE)
> -		writeb(cmd, cs->base + OFFSET_CMD);
> +		writeb(cmd, cs->base + nfc->soc_info->cmd_offset);
>  }
>  
>  static int ingenic_nand_dev_ready(struct nand_chip *chip)
> @@ -160,8 +164,13 @@ static int ingenic_nand_attach_chip(struct nand_chip *chip)
>  	struct ingenic_nfc *nfc = to_ingenic_nfc(chip->controller);
>  	int eccbytes;
>  
> -	chip->ecc.bytes = fls((1 + 8) * chip->ecc.size)	*
> -				(chip->ecc.strength / 8);
> +	if (chip->ecc.strength == 4) {
> +		/* JZ4740 uses 9 bytes of ECC to correct maximum 4 errors */
> +		chip->ecc.bytes = 9;
> +	} else {
> +		chip->ecc.bytes = fls((1 + 8) * chip->ecc.size)	*
> +				  (chip->ecc.strength / 8);
> +	}
>  
>  	switch (chip->ecc.mode) {
>  	case NAND_ECC_HW:
> @@ -270,8 +279,8 @@ static int ingenic_nand_init_chip(struct platform_device *pdev,
>  		return -ENOMEM;
>  	mtd->dev.parent = dev;
>  
> -	chip->legacy.IO_ADDR_R = cs->base + OFFSET_DATA;
> -	chip->legacy.IO_ADDR_W = cs->base + OFFSET_DATA;
> +	chip->legacy.IO_ADDR_R = cs->base + nfc->soc_info->data_offset;
> +	chip->legacy.IO_ADDR_W = cs->base + nfc->soc_info->data_offset;
>  	chip->legacy.chip_delay = RB_DELAY_US;
>  	chip->options = NAND_NO_SUBPAGE_WRITE;
>  	chip->legacy.select_chip = ingenic_nand_select_chip;
> @@ -353,6 +362,10 @@ static int ingenic_nand_probe(struct platform_device *pdev)
>  	if (!nfc)
>  		return -ENOMEM;
>  
> +	nfc->soc_info = device_get_match_data(dev);
> +	if (!nfc->soc_info)
> +		return -EINVAL;
> +
>  	/*
>  	 * Check for ECC HW before we call nand_scan_ident, to prevent us from
>  	 * having to call it again if the ECC driver returns -EPROBE_DEFER.
> @@ -390,8 +403,21 @@ static int ingenic_nand_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct jz_soc_info jz4740_soc_info = {
> +	.data_offset = 0x00000000,
> +	.cmd_offset  = 0x00008000,

Please don't align   ^

> +	.addr_offset = 0x00010000,
> +};
> +
> +static const struct jz_soc_info jz4780_soc_info = {
> +	.data_offset = 0x00000000,
> +	.cmd_offset  = 0x00400000,
> +	.addr_offset = 0x00800000,
> +};
> +
>  static const struct of_device_id ingenic_nand_dt_match[] = {
> -	{ .compatible = "ingenic,jz4780-nand" },
> +	{ .compatible = "ingenic,jz4740-nand", .data = &jz4740_soc_info },
> +	{ .compatible = "ingenic,jz4780-nand",  .data = &jz4780_soc_info  },

Just an extra space                           ^

Otherwise looks fine.


Thanks,
Miquèl
