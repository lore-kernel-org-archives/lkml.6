Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2173C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5429B21773
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="BFypSXu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfAJJvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:51:01 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52186 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727916AbfAJJvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 04:51:01 -0500
Received: from zn.tnic (p200300EC2BC5CF005460B1C1902C795E.dip0.t-ipconnect.de [IPv6:2003:ec:2bc5:cf00:5460:b1c1:902c:795e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C2D711EC0432;
        Thu, 10 Jan 2019 10:50:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547113859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=USKNxGLVJqTNYi+QPbxaKogCPLc78Z89nLrCpriTqU0=;
        b=BFypSXu0pJOYlhGP0qSEYyfv76XVQSWLEVFE3lHOKyjhRrdYcKbyPx+BvY25q84q3CPt5/
        HFrbWlbBaArAp65kY94q5DrKeO0GJYjopCsOJ/yqRGrzo0sP3fdAMV6ruYP7B3xwu0LzKx
        1thkZKzMsFbEfc66t2YkRrMH4BV4nZM=
Date:   Thu, 10 Jan 2019 10:50:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Stefan Schaeckeler <schaecsn@gmx.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-edac@vger.kernel.org,
        Stefan M Schaeckeler <sschaeck@cisco.com>
Subject: Re: [PATCH 1/2] EDAC: Add Aspeed AST2500 EDAC driver
Message-ID: <20190110095049.GB17621@zn.tnic>
References: <1545026517-64069-1-git-send-email-schaecsn@gmx.net>
 <1545026517-64069-2-git-send-email-schaecsn@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1545026517-64069-2-git-send-email-schaecsn@gmx.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 10:01:56PM -0800, Stefan Schaeckeler wrote:
> From: Stefan M Schaeckeler <sschaeck@cisco.com>
> 
> Add support for the Aspeed AST2500 SoC EDAC driver.
> 
> Signed-off-by: Stefan M Schaeckeler <sschaeck@cisco.com>
> ---
>  MAINTAINERS                      |   6 +
>  arch/arm/boot/dts/aspeed-g5.dtsi |   7 +
>  drivers/edac/Kconfig             |   7 +
>  drivers/edac/Makefile            |   1 +
>  drivers/edac/aspeed_edac.c       | 457 +++++++++++++++++++++++++++++++
>  5 files changed, 478 insertions(+)
>  create mode 100644 drivers/edac/aspeed_edac.c

I couldn't see anything out of the ordinary - only nitpicks below.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3318f30903b2..1feb92b14029 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5315,6 +5315,12 @@ L:	linux-edac@vger.kernel.org
>  S:	Maintained
>  F:	drivers/edac/amd64_edac*
>  
> +EDAC-AST2500
> +M:	Stefan Schaeckeler <sschaeck@cisco.com>
> +S:	Supported
> +F:	drivers/edac/aspeed_edac.c
> +F:	Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
> +
>  EDAC-CALXEDA
>  M:	Robert Richter <rric@kernel.org>
>  L:	linux-edac@vger.kernel.org
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index d107459fc0f8..b4e479ab5a2d 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -47,6 +47,13 @@
>  		reg = <0x80000000 0>;
>  	};
>  
> +	edac: sdram@1e6e0000 {
> +		compatible = "aspeed,ast2500-sdram-edac";
> +		reg = <0x1e6e0000 0x174>;
> +		interrupts = <0>;
> +		status = "disabled";
> +	};
> +
>  	ahb {
>  		compatible = "simple-bus";
>  		#address-cells = <1>;
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 41c9ccdd20d6..67834430b0a1 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -475,4 +475,11 @@ config EDAC_QCOM
>  	  For debugging issues having to do with stability and overall system
>  	  health, you should probably say 'Y' here.
>  
> +config EDAC_ASPEED
> +	tristate "Aspeed AST 2500 SoC"
> +	depends on MACH_ASPEED_G5
> +	help
> +	  Support for error detection and correction on the
> +	  Aspeed AST 2500 SoC.
> +
>  endif # EDAC
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index 716096d08ea0..e1f23d4ff860 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -78,3 +78,4 @@ obj-$(CONFIG_EDAC_SYNOPSYS)		+= synopsys_edac.o
>  obj-$(CONFIG_EDAC_XGENE)		+= xgene_edac.o
>  obj-$(CONFIG_EDAC_TI)			+= ti_edac.o
>  obj-$(CONFIG_EDAC_QCOM)			+= qcom_edac.o
> +obj-$(CONFIG_EDAC_ASPEED)		+= aspeed_edac.o
> diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
> new file mode 100644
> index 000000000000..d6ed119909eb
> --- /dev/null
> +++ b/drivers/edac/aspeed_edac.c
> @@ -0,0 +1,457 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2018 Cisco Systems
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.

You have the SPDX license identifier - no need for that text.

> + */
> +
> +#include <linux/edac.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/stop_machine.h>
> +#include <linux/io.h>
> +#include <linux/of_address.h>
> +#include <linux/regmap.h>
> +#include <asm/page.h>
> +#include "edac_module.h"
> +
> +
> +#define DRV_NAME "aspeed-edac"
> +
> +
> +/* registers */

no need for that comment

> +#define ASPEED_MCR_PROT        0x00 /* protection key register */
> +#define ASPEED_MCR_CONF        0x04 /* configuration register */
> +#define ASPEED_MCR_INTR_CTRL   0x50 /* interrupt control/status register */
> +#define ASPEED_MCR_ADDR_UNREC  0x58 /* address of first un-recoverable error */
> +#define ASPEED_MCR_ADDR_REC    0x5c /* address of last recoverable error */
> +#define ASPEED_MCR_LAST        ASPEED_MCR_ADDR_REC
> +
> +
> +/* bits and masks */

ditto

> +#define ASPEED_MCR_PROT_PASSWD	            0xfc600309
> +#define ASPEED_MCR_CONF_DRAM_TYPE               BIT(4)
> +#define ASPEED_MCR_CONF_ECC                     BIT(7)
> +#define ASPEED_MCR_INTR_CTRL_CLEAR             BIT(31)
> +#define ASPEED_MCR_INTR_CTRL_CNT_REC   GENMASK(23, 16)
> +#define ASPEED_MCR_INTR_CTRL_CNT_UNREC GENMASK(15, 12)
> +#define ASPEED_MCR_INTR_CTRL_ENABLE  (BIT(0) | BIT(1))
> +
> +
> +
> +static int aspeed_edac_regmap_reg_write(void *context, unsigned int reg,
> +					unsigned int val)

All the static functions don't need the "aspeed_edac" prefix.

> +{
> +	void __iomem *regs = (void __iomem *)context;
> +
> +	/* enable write to MCR register set */
> +	writel(ASPEED_MCR_PROT_PASSWD, regs + ASPEED_MCR_PROT);
> +
> +	writel(val, regs + reg);
> +
> +	/* disable write to MCR register set */
> +	writel(~ASPEED_MCR_PROT_PASSWD, regs + ASPEED_MCR_PROT);
> +
> +	return 0;
> +}
> +
> +
> +static int aspeed_edac_regmap_reg_read(void *context, unsigned int reg,
> +				       unsigned int *val)
> +{
> +	void __iomem *regs = (void __iomem *)context;
> +
> +	*val = readl(regs + reg);
> +
> +	return 0;
> +}
> +
> +static bool aspeed_edac_regmap_is_volatile(struct device *dev,
> +					   unsigned int reg)
> +{
> +	switch (reg) {
> +	case ASPEED_MCR_PROT:
> +	case ASPEED_MCR_INTR_CTRL:
> +	case ASPEED_MCR_ADDR_UNREC:
> +	case ASPEED_MCR_ADDR_REC:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +
> +static const struct regmap_config aspeed_edac_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = ASPEED_MCR_LAST,
> +	.reg_write = aspeed_edac_regmap_reg_write,
> +	.reg_read = aspeed_edac_regmap_reg_read,
> +	.volatile_reg = aspeed_edac_regmap_is_volatile,
> +	.fast_io = true,
> +};
> +
> +
> +static struct regmap *aspeed_edac_regmap;

Put that definition at the top of the file, under the #defines.

> +
> +
> +static void aspeed_edac_count_rec(struct mem_ctl_info *mci,
> +				  u8 rec_cnt,
> +				  u32 rec_addr)
> +{
> +	struct csrow_info *csrow = mci->csrows[0];
> +	u32 page, offset, syndrome;
> +
> +	if (rec_cnt > 0) {

Save an indentation level:

	if (!rec_cnt)
		return;

> +		/* report first few errors (if there are) */
> +		/* note: no addresses are recorded */
> +		if (rec_cnt > 1) {
> +			page = 0; /* not available */
> +			offset = 0;  /* not available */
> +			syndrome = 0; /* not available */

Do a single comment, over the lines, not sideways. Ditto for the rest of
the driver - side comments make the code harder to read.

> +			edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
> +					     rec_cnt-1, page, offset,
> +					     syndrome, 0, 0, -1,
> +					     "address(es) not available", "");
> +		}
> +
> +		/* report last error */
> +		/* note: rec_addr is the last recoverable error addr */
> +		page = rec_addr >> PAGE_SHIFT;
> +		offset = rec_addr & ~PAGE_MASK;
> +		syndrome = 0; /* not available */
> +		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, 1,
> +				     csrow->first_page + page, offset, syndrome,
> +				     0, 0, -1, "", "");
> +	}
> +}
> +
> +
> +static void aspeed_edac_count_un_rec(struct mem_ctl_info *mci,
> +				     u8 un_rec_cnt,
> +				     u32 un_rec_addr)
> +{
> +	struct csrow_info *csrow = mci->csrows[0];
> +	u32 page, offset, syndrome;
> +
> +	if (un_rec_cnt > 0) {

As above: save an indentation level by flipping the check.

> +		/* report 1. error */
> +		/* note: un_rec_addr is the first unrecoverable error addr */
> +		page = un_rec_addr >> PAGE_SHIFT;
> +		offset = un_rec_addr & ~PAGE_MASK;
> +		syndrome = 0; /* not available */
> +		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, 1,
> +				     csrow->first_page + page, offset, syndrome,
> +				     0, 0, -1, "", "");
> +
> +		/* report further errors (if there are) */
> +		/* note: no addresses are recorded */
> +		if (un_rec_cnt > 1) {
> +			page = 0;  /* not available */
> +			offset = 0;  /* not available */
> +			syndrome = 0; /* not available */
> +			edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
> +					     un_rec_cnt-1, page, offset,
> +					     syndrome, 0, 0, -1,
> +					     "address(es) not available", "");
> +		}
> +	}
> +}
> +
> +
> +static void aspeed_edac_enable_interrupts(void)
> +{
> +
> +	regmap_update_bits(aspeed_edac_regmap, ASPEED_MCR_INTR_CTRL,
> +			   ASPEED_MCR_INTR_CTRL_ENABLE,
> +			   ASPEED_MCR_INTR_CTRL_ENABLE);
> +}

A function which has a single statement and is called only once, looks
a bit useless to me. Just put the regmap_update_bits() call at the call
site with a comment (which you already have).

> +
> +
> +static void aspeed_edac_disable_interrupts(void)
> +{
> +	regmap_update_bits(aspeed_edac_regmap, ASPEED_MCR_INTR_CTRL,
> +			   ASPEED_MCR_INTR_CTRL_ENABLE, 0);
> +}

Ditto.

> +
> +
> +static void aspeed_edac_clear_interrupts(void)
> +{
> +	regmap_update_bits(aspeed_edac_regmap, ASPEED_MCR_INTR_CTRL,
> +			   ASPEED_MCR_INTR_CTRL_CLEAR,
> +			   ASPEED_MCR_INTR_CTRL_CLEAR);
> +
> +	regmap_update_bits(aspeed_edac_regmap, ASPEED_MCR_INTR_CTRL,
> +			   ASPEED_MCR_INTR_CTRL_CLEAR, 0);
> +}

Ditto.

> +
> +
> +static irqreturn_t aspeed_edac_isr(int irq, void *arg)
> +{
> +	u8  rec_cnt, un_rec_cnt;
> +	u32 rec_addr, un_rec_addr;
> +	struct mem_ctl_info *mci = arg;
> +	u32 reg50, reg5c, reg58;
> +
> +	regmap_read(aspeed_edac_regmap, ASPEED_MCR_INTR_CTRL, &reg50);
> +	dev_dbg(mci->pdev, "received edac interrupt w/ mmc register 50: 0x%x\n",
> +		reg50);
> +
> +	/* collect data about recoverable and unrecoverable errors */
> +	rec_cnt = (reg50 & ASPEED_MCR_INTR_CTRL_CNT_REC) >> 16;
> +	un_rec_cnt = (reg50 & ASPEED_MCR_INTR_CTRL_CNT_UNREC) >> 12;
> +
> +	dev_dbg(mci->pdev, "%d recoverable interrupts and %d unrecoverable interrupts\n",
> +		rec_cnt, un_rec_cnt);
> +
> +	regmap_read(aspeed_edac_regmap, ASPEED_MCR_ADDR_UNREC, &reg58);
> +	un_rec_addr = reg58 >> 4;
> +
> +	regmap_read(aspeed_edac_regmap, ASPEED_MCR_ADDR_REC, &reg5c);
> +	rec_addr = reg5c >> 4;
> +
> +	/* clear interrupt flags and error counters: */
> +	aspeed_edac_clear_interrupts();
> +
> +	/* process recoverable and unrecoverable errors */
> +	if (rec_cnt > 0)

You check rec_cnt here *and* in the function? One can never be sure huh? :-)

> +		aspeed_edac_count_rec(mci, rec_cnt, rec_addr);
> +
> +	if (un_rec_cnt > 0)
> +		aspeed_edac_count_un_rec(mci, un_rec_cnt, un_rec_addr);

Ditto. Just do the checks in the respective functions.

> +
> +	if ((rec_cnt == 0) && (un_rec_cnt == 0))

Do
	if (!rec_cnt && !un_rec_cnt)

> +		dev_dbg(mci->pdev, "received edac interrupt, but did not find any ecc counters\n");

s/ecc/ECC/g

> +
> +	regmap_read(aspeed_edac_regmap, ASPEED_MCR_INTR_CTRL, &reg50);
> +	dev_dbg(mci->pdev, "edac interrupt handled. mmc reg 50 is now: 0x%x\n",
> +		reg50);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +
> +static int aspeed_edac_config_irq(void *ctx,
> +				  struct platform_device *pdev)

Let that line stick out.

> +{
> +	int irq;
> +	int rc;
> +
> +	/* register interrupt handler */
> +
> +	irq = platform_get_irq(pdev, 0);
> +	dev_dbg(&pdev->dev, "got irq %d\n", irq);
> +	if (!irq)
> +		return -ENODEV;
> +
> +	rc = devm_request_irq(&pdev->dev, irq, aspeed_edac_isr,
> +			      IRQF_TRIGGER_HIGH, DRV_NAME, ctx);
> +	if (rc) {
> +		dev_err(&pdev->dev, "unable to request irq %d\n", irq);
> +		return rc;
> +	}
> +
> +	/* enable interrupts */
> +	aspeed_edac_enable_interrupts();
> +
> +	return 0;
> +}
> +
> +
> +static int aspeed_edac_init_csrows(struct mem_ctl_info *mci)
> +{
> +	struct csrow_info *csrow = mci->csrows[0];
> +	struct dimm_info *dimm;
> +	struct device_node *np;
> +	u32 nr_pages, dram_type;
> +	struct resource r;
> +	u32 reg04;
> +	int rc;
> +
> +	/* retrieve info about physical memory from device tree */
> +	np = of_find_node_by_path("/memory");
> +

Superfluous new line.

> +	if (!np) {
> +		dev_err(mci->pdev, "dt: missing /memory node\n");
> +		return -ENODEV;
> +	};
> +
> +	rc = of_address_to_resource(np, 0, &r);
> +
> +	of_node_put(np);
> +
> +	if (rc) {
> +		dev_err(mci->pdev, "dt: failed requesting resource for /memory node\n");
> +		return rc;
> +	};
> +
> +	dev_dbg(mci->pdev, "dt: /memory node resources: first page r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
> +		r.start, resource_size(&r), PAGE_SHIFT);
> +
> +	csrow->first_page = r.start >> PAGE_SHIFT;
> +	nr_pages = resource_size(&r) >> PAGE_SHIFT;
> +	csrow->last_page = csrow->first_page + nr_pages - 1;
> +
> +	regmap_read(aspeed_edac_regmap, ASPEED_MCR_CONF, &reg04);
> +	dram_type = (reg04 & ASPEED_MCR_CONF_DRAM_TYPE) ? MEM_DDR4 : MEM_DDR3;
> +
> +	dimm = csrow->channels[0]->dimm;
> +	dimm->mtype = dram_type;
> +	dimm->edac_mode = EDAC_SECDED;
> +	dimm->nr_pages = nr_pages / csrow->nr_channels;
> +
> +	dev_dbg(mci->pdev, "initialized dimm with first_page=0x%lx and nr_pages=0x%x\n",
> +		csrow->first_page, nr_pages);
> +
> +	return 0;
> +}
> +
> +
> +static int aspeed_edac_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	void __iomem *regs;
> +	struct resource *res;
> +	struct mem_ctl_info *mci;
> +	struct edac_mc_layer layers[2];
> +	struct device_node *np;
> +	u32 reg04;
> +	int rc;

Please sort function local variables declaration in a reverse christmas
tree order:

	<type A> longest_variable_name;
	<type B> shorter_var_name;
	<type C> even_shorter;
	<type D> i;

Do that in all functions.

> +
> +	/* setup regmap */
> +	np = dev->of_node;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENOENT;
> +
> +	regs = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +
> +	aspeed_edac_regmap = devm_regmap_init(dev, NULL, (__force void *)regs,
> +					       &aspeed_edac_regmap_config);
> +	if (IS_ERR(aspeed_edac_regmap))
> +		return PTR_ERR(aspeed_edac_regmap);
> +
> +	/* bail out if ECC mode is not configured */
> +	regmap_read(aspeed_edac_regmap, ASPEED_MCR_CONF, &reg04);
> +	if (!(reg04 & ASPEED_MCR_CONF_ECC)) {
> +		dev_err(&pdev->dev, "ECC mode is not configured in u-boot\n");
> +		return -EPERM;
> +	}
> +
> +	edac_op_state = EDAC_OPSTATE_INT;
> +
> +	/* allocate & init EDAC MC data structure */
> +	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
> +	layers[0].size = 1;
> +	layers[0].is_virt_csrow = true;
> +	layers[1].type = EDAC_MC_LAYER_CHANNEL;
> +	layers[1].size = 1;
> +	layers[1].is_virt_csrow = false;
> +
> +	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, 0);
> +	if (mci == NULL)

	if (!mci)

> +		return -ENOMEM;
> +
> +	mci->pdev = &pdev->dev;
> +	mci->mtype_cap = MEM_FLAG_DDR3 | MEM_FLAG_DDR4;
> +	mci->edac_ctl_cap = EDAC_FLAG_SECDED;
> +	mci->edac_cap = EDAC_FLAG_SECDED;
> +	mci->scrub_cap = SCRUB_FLAG_HW_SRC;
> +	mci->scrub_mode = SCRUB_HW_SRC;
> +	mci->mod_name = DRV_NAME;
> +	mci->ctl_name = "MIC";
> +	mci->dev_name = dev_name(&pdev->dev);
> +
> +	rc = aspeed_edac_init_csrows(mci);
> +	if (rc) {
> +		dev_err(&pdev->dev, "failed to init csrows\n");
> +		goto probe_exit02;
> +	}
> +
> +	platform_set_drvdata(pdev, mci);
> +
> +	/* register with edac core */
> +	rc = edac_mc_add_mc(mci);
> +	if (rc) {
> +		dev_err(&pdev->dev, "failed to register with EDAC core\n");
> +		goto probe_exit02;
> +	}
> +
> +	/* register interrupt handler and enable interrupts */
> +	rc = aspeed_edac_config_irq(mci, pdev);
> +	if (rc) {
> +		dev_err(&pdev->dev, "failed setting up irq\n");
> +		goto probe_exit01;
> +	}
> +
> +	return 0;
> +
> +probe_exit01:
> +	edac_mc_del_mc(&pdev->dev);
> +probe_exit02:
> +	edac_mc_free(mci);
> +	return rc;
> +}

...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
