Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABE0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B18120823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547800518;
	bh=+fsEYgJqZqt+be/BlBBzB6FF/K+psDH+09k0piwQ8mM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=rI1EMnhw3GcMbIB8Ns+Bov/2OmsXP6GTwlJH8iXiyznHmAHNcmvRS/x1QfY4FqGqi
	 F7uU333mO0a7f8RmnnD2GxUOB3JlsOYZnAlfo/DC69CxR6egOOUHZEM6pbber+OLmS
	 9bZXy8LGNh5f32lZr5PhJgRaiet0ufb7rmC68poQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfARIfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:35:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:47502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbfARIfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:35:16 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E27E32087E;
        Fri, 18 Jan 2019 08:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547800514;
        bh=+fsEYgJqZqt+be/BlBBzB6FF/K+psDH+09k0piwQ8mM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W9kzs2LsSSbGBZDqpgpi52/BOX7TK8CLTlDexKbvDePlrjMP2bdGAuTysdCVlbbiv
         eWHs8Bhbwa6g8tIShVR8osdUJBlENBE6BlnLu+LraQMrr+vSNltLsgOsSMz2AZKXHX
         xtzZzFXoMcDhxwr6Qa7lIcjSLu2pLBtKe5SWBimY=
Date:   Fri, 18 Jan 2019 09:35:00 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH 7/8] mtd: rawnand: jz4780-bch: Separate top-level and
 SoC specific code
Message-ID: <20190118093500.397d5d07@bbrezillon>
In-Reply-To: <20190118010634.27399-7-paul@crapouillou.net>
References: <20190118010634.27399-1-paul@crapouillou.net>
        <20190118010634.27399-7-paul@crapouillou.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019 22:06:33 -0300
Paul Cercueil <paul@crapouillou.net> wrote:

> The jz4780-nand driver uses an API provided by the jz4780-bch driver.
> This makes it difficult to support other SoCs in the jz4780-bch driver.
> To work around this, we separate the API functions from the SoC-specific
> code, so that these API functions are SoC-agnostic.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/mtd/nand/raw/Makefile              |   3 +-
>  drivers/mtd/nand/raw/jz4780_bch.c          | 173 +++--------------------------
>  drivers/mtd/nand/raw/jz4780_bch_common.c   | 172 ++++++++++++++++++++++++++++
>  drivers/mtd/nand/raw/jz4780_bch_internal.h |  34 ++++++

What's the overhead of having 4725b and 4780 code in the same source
file? If we really need to split that up, I'd prefer to have all jz47xx
sources placed in a subdir (drivers/mtd/nand/raw/jz47xx/).

>  4 files changed, 222 insertions(+), 160 deletions(-)
>  create mode 100644 drivers/mtd/nand/raw/jz4780_bch_common.c
>  create mode 100644 drivers/mtd/nand/raw/jz4780_bch_internal.h
> 
> diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
> index 57159b349054..6dacc9cf38d5 100644
> --- a/drivers/mtd/nand/raw/Makefile
> +++ b/drivers/mtd/nand/raw/Makefile
> @@ -46,7 +46,8 @@ obj-$(CONFIG_MTD_NAND_MPC5121_NFC)	+= mpc5121_nfc.o
>  obj-$(CONFIG_MTD_NAND_VF610_NFC)	+= vf610_nfc.o
>  obj-$(CONFIG_MTD_NAND_RICOH)		+= r852.o
>  obj-$(CONFIG_MTD_NAND_JZ4740)		+= jz4740_nand.o
> -obj-$(CONFIG_MTD_NAND_JZ4780)		+= jz4780_nand.o jz4780_bch.o
> +obj-$(CONFIG_MTD_NAND_JZ4780)		+= jz4780_nand.o jz4780_bch_common.o \
> +					   jz4780_bch.o
>  obj-$(CONFIG_MTD_NAND_GPMI_NAND)	+= gpmi-nand/
>  obj-$(CONFIG_MTD_NAND_XWAY)		+= xway_nand.o
>  obj-$(CONFIG_MTD_NAND_BCM47XXNFLASH)	+= bcm47xxnflash/
> diff --git a/drivers/mtd/nand/raw/jz4780_bch.c b/drivers/mtd/nand/raw/jz4780_bch.c
> index 161d3821e1c4..1dfc960067b3 100644
> --- a/drivers/mtd/nand/raw/jz4780_bch.c
> +++ b/drivers/mtd/nand/raw/jz4780_bch.c
> @@ -1,25 +1,19 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * JZ4780 BCH controller
> + * JZ4780 backend code for the jz4780-bch driver
>   *
>   * Copyright (c) 2015 Imagination Technologies
>   * Author: Alex Smith <alex.smith@imgtec.com>
>   */
>  
>  #include <linux/bitops.h>
> -#include <linux/clk.h>
> -#include <linux/delay.h>
> -#include <linux/init.h>
>  #include <linux/iopoll.h>
> -#include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/of.h>
> -#include <linux/of_platform.h>
> -#include <linux/platform_device.h>
> -#include <linux/sched.h>
> -#include <linux/slab.h>
> +#include <linux/device.h>
>  
>  #include "jz4780_bch.h"
> +#include "jz4780_bch_internal.h"
>  
>  #define BCH_BHCR			0x0
>  #define BCH_BHCCR			0x8
> @@ -60,13 +54,6 @@
>  /* Timeout for BCH calculation/correction. */
>  #define BCH_TIMEOUT_US			100000
>  
> -struct jz4780_bch {
> -	struct device *dev;
> -	void __iomem *base;
> -	struct clk *clk;
> -	struct mutex lock;
> -};
> -
>  static void jz4780_bch_init(struct jz4780_bch *bch,
>  			    struct jz4780_bch_params *params, bool encode)
>  {
> @@ -165,18 +152,9 @@ static bool jz4780_bch_wait_complete(struct jz4780_bch *bch, unsigned int irq,
>  	return true;
>  }
>  
> -/**
> - * jz4780_bch_calculate() - calculate ECC for a data buffer
> - * @bch: BCH device.
> - * @params: BCH parameters.
> - * @buf: input buffer with raw data.
> - * @ecc_code: output buffer with ECC.
> - *
> - * Return: 0 on success, -ETIMEDOUT if timed out while waiting for BCH
> - * controller.
> - */
> -int jz4780_bch_calculate(struct jz4780_bch *bch, struct jz4780_bch_params *params,
> -			 const u8 *buf, u8 *ecc_code)
> +static int jz4780_calculate(struct jz4780_bch *bch,
> +			    struct jz4780_bch_params *params,
> +			    const u8 *buf, u8 *ecc_code)
>  {
>  	int ret = 0;
>  
> @@ -195,23 +173,10 @@ int jz4780_bch_calculate(struct jz4780_bch *bch, struct jz4780_bch_params *param
>  	mutex_unlock(&bch->lock);
>  	return ret;
>  }
> -EXPORT_SYMBOL(jz4780_bch_calculate);
> -
> -/**
> - * jz4780_bch_correct() - detect and correct bit errors
> - * @bch: BCH device.
> - * @params: BCH parameters.
> - * @buf: raw data read from the chip.
> - * @ecc_code: ECC read from the chip.
> - *
> - * Given the raw data and the ECC read from the NAND device, detects and
> - * corrects errors in the data.
> - *
> - * Return: the number of bit errors corrected, -EBADMSG if there are too many
> - * errors to correct or -ETIMEDOUT if we timed out waiting for the controller.
> - */
> -int jz4780_bch_correct(struct jz4780_bch *bch, struct jz4780_bch_params *params,
> -		       u8 *buf, u8 *ecc_code)
> +
> +static int jz4780_correct(struct jz4780_bch *bch,
> +			  struct jz4780_bch_params *params,
> +			  u8 *buf, u8 *ecc_code)
>  {
>  	u32 reg, mask, index;
>  	int i, ret, count;
> @@ -257,119 +222,9 @@ int jz4780_bch_correct(struct jz4780_bch *bch, struct jz4780_bch_params *params,
>  	mutex_unlock(&bch->lock);
>  	return ret;
>  }
> -EXPORT_SYMBOL(jz4780_bch_correct);
> -
> -/**
> - * jz4780_bch_get() - get the BCH controller device
> - * @np: BCH device tree node.
> - *
> - * Gets the BCH controller device from the specified device tree node. The
> - * device must be released with jz4780_bch_release() when it is no longer being
> - * used.
> - *
> - * Return: a pointer to jz4780_bch, errors are encoded into the pointer.
> - * PTR_ERR(-EPROBE_DEFER) if the device hasn't been initialised yet.
> - */
> -static struct jz4780_bch *jz4780_bch_get(struct device_node *np)
> -{
> -	struct platform_device *pdev;
> -	struct jz4780_bch *bch;
> -
> -	pdev = of_find_device_by_node(np);
> -	if (!pdev || !platform_get_drvdata(pdev))
> -		return ERR_PTR(-EPROBE_DEFER);
> -
> -	get_device(&pdev->dev);
> -
> -	bch = platform_get_drvdata(pdev);
> -	clk_prepare_enable(bch->clk);
> -
> -	return bch;
> -}
> -
> -/**
> - * of_jz4780_bch_get() - get the BCH controller from a DT node
> - * @of_node: the node that contains a bch-controller property.
> - *
> - * Get the bch-controller property from the given device tree
> - * node and pass it to jz4780_bch_get to do the work.
> - *
> - * Return: a pointer to jz4780_bch, errors are encoded into the pointer.
> - * PTR_ERR(-EPROBE_DEFER) if the device hasn't been initialised yet.
> - */
> -struct jz4780_bch *of_jz4780_bch_get(struct device_node *of_node)
> -{
> -	struct jz4780_bch *bch = NULL;
> -	struct device_node *np;
>  
> -	np = of_parse_phandle(of_node, "ingenic,bch-controller", 0);
> -
> -	if (np) {
> -		bch = jz4780_bch_get(np);
> -		of_node_put(np);
> -	}
> -	return bch;
> -}
> -EXPORT_SYMBOL(of_jz4780_bch_get);
> -
> -/**
> - * jz4780_bch_release() - release the BCH controller device
> - * @bch: BCH device.
> - */
> -void jz4780_bch_release(struct jz4780_bch *bch)
> -{
> -	clk_disable_unprepare(bch->clk);
> -	put_device(bch->dev);
> -}
> -EXPORT_SYMBOL(jz4780_bch_release);
> -
> -static int jz4780_bch_probe(struct platform_device *pdev)
> -{
> -	struct device *dev = &pdev->dev;
> -	struct jz4780_bch *bch;
> -	struct resource *res;
> -
> -	bch = devm_kzalloc(dev, sizeof(*bch), GFP_KERNEL);
> -	if (!bch)
> -		return -ENOMEM;
> -
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	bch->base = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(bch->base))
> -		return PTR_ERR(bch->base);
> -
> -	jz4780_bch_disable(bch);
> -
> -	bch->clk = devm_clk_get(dev, NULL);
> -	if (IS_ERR(bch->clk)) {
> -		dev_err(dev, "failed to get clock: %ld\n", PTR_ERR(bch->clk));
> -		return PTR_ERR(bch->clk);
> -	}
> -
> -	mutex_init(&bch->lock);
> -
> -	bch->dev = dev;
> -	platform_set_drvdata(pdev, bch);
> -
> -	return 0;
> -}
> -
> -static const struct of_device_id jz4780_bch_dt_match[] = {
> -	{ .compatible = "ingenic,jz4780-bch" },
> -	{},
> +const struct jz4780_bch_ops jz4780_bch_jz4780_ops = {
> +	.disable = jz4780_bch_disable,
> +	.calculate = jz4780_calculate,
> +	.correct = jz4780_correct,
>  };
> -MODULE_DEVICE_TABLE(of, jz4780_bch_dt_match);
> -
> -static struct platform_driver jz4780_bch_driver = {
> -	.probe		= jz4780_bch_probe,
> -	.driver	= {
> -		.name	= "jz4780-bch",
> -		.of_match_table = of_match_ptr(jz4780_bch_dt_match),
> -	},
> -};
> -module_platform_driver(jz4780_bch_driver);
> -
> -MODULE_AUTHOR("Alex Smith <alex@alex-smith.me.uk>");
> -MODULE_AUTHOR("Harvey Hunt <harveyhuntnexus@gmail.com>");
> -MODULE_DESCRIPTION("Ingenic JZ4780 BCH error correction driver");
> -MODULE_LICENSE("GPL v2");
> diff --git a/drivers/mtd/nand/raw/jz4780_bch_common.c b/drivers/mtd/nand/raw/jz4780_bch_common.c
> new file mode 100644
> index 000000000000..573b079e6cbe
> --- /dev/null
> +++ b/drivers/mtd/nand/raw/jz4780_bch_common.c
> @@ -0,0 +1,172 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * JZ4780 BCH controller
> + *
> + * Copyright (c) 2015 Imagination Technologies
> + * Author: Alex Smith <alex.smith@imgtec.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +
> +#include "jz4780_bch_internal.h"
> +#include "jz4780_bch.h"
> +
> +/**
> + * jz4780_bch_calculate() - calculate ECC for a data buffer
> + * @bch: BCH device.
> + * @params: BCH parameters.
> + * @buf: input buffer with raw data.
> + * @ecc_code: output buffer with ECC.
> + *
> + * Return: 0 on success, -ETIMEDOUT if timed out while waiting for BCH
> + * controller.
> + */
> +int jz4780_bch_calculate(struct jz4780_bch *bch, struct jz4780_bch_params *params,
> +			 const u8 *buf, u8 *ecc_code)
> +{
> +	return bch->ops->calculate(bch, params, buf, ecc_code);
> +}
> +EXPORT_SYMBOL(jz4780_bch_calculate);
> +
> +/**
> + * jz4780_bch_correct() - detect and correct bit errors
> + * @bch: BCH device.
> + * @params: BCH parameters.
> + * @buf: raw data read from the chip.
> + * @ecc_code: ECC read from the chip.
> + *
> + * Given the raw data and the ECC read from the NAND device, detects and
> + * corrects errors in the data.
> + *
> + * Return: the number of bit errors corrected, -EBADMSG if there are too many
> + * errors to correct or -ETIMEDOUT if we timed out waiting for the controller.
> + */
> +int jz4780_bch_correct(struct jz4780_bch *bch, struct jz4780_bch_params *params,
> +		       u8 *buf, u8 *ecc_code)
> +{
> +	return bch->ops->correct(bch, params, buf, ecc_code);
> +}
> +EXPORT_SYMBOL(jz4780_bch_correct);
> +
> +/**
> + * jz4780_bch_get() - get the BCH controller device
> + * @np: BCH device tree node.
> + *
> + * Gets the BCH controller device from the specified device tree node. The
> + * device must be released with jz4780_bch_release() when it is no longer being
> + * used.
> + *
> + * Return: a pointer to jz4780_bch, errors are encoded into the pointer.
> + * PTR_ERR(-EPROBE_DEFER) if the device hasn't been initialised yet.
> + */
> +static struct jz4780_bch *jz4780_bch_get(struct device_node *np)
> +{
> +	struct platform_device *pdev;
> +	struct jz4780_bch *bch;
> +
> +	pdev = of_find_device_by_node(np);
> +	if (!pdev || !platform_get_drvdata(pdev))
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	get_device(&pdev->dev);
> +
> +	bch = platform_get_drvdata(pdev);
> +	clk_prepare_enable(bch->clk);
> +
> +	return bch;
> +}
> +
> +/**
> + * of_jz4780_bch_get() - get the BCH controller from a DT node
> + * @of_node: the node that contains a bch-controller property.
> + *
> + * Get the bch-controller property from the given device tree
> + * node and pass it to jz4780_bch_get to do the work.
> + *
> + * Return: a pointer to jz4780_bch, errors are encoded into the pointer.
> + * PTR_ERR(-EPROBE_DEFER) if the device hasn't been initialised yet.
> + */
> +struct jz4780_bch *of_jz4780_bch_get(struct device_node *of_node)
> +{
> +	struct jz4780_bch *bch = NULL;
> +	struct device_node *np;
> +
> +	np = of_parse_phandle(of_node, "ingenic,bch-controller", 0);
> +
> +	if (np) {
> +		bch = jz4780_bch_get(np);
> +		of_node_put(np);
> +	}
> +	return bch;
> +}
> +EXPORT_SYMBOL(of_jz4780_bch_get);
> +
> +/**
> + * jz4780_bch_release() - release the BCH controller device
> + * @bch: BCH device.
> + */
> +void jz4780_bch_release(struct jz4780_bch *bch)
> +{
> +	clk_disable_unprepare(bch->clk);
> +	put_device(bch->dev);
> +}
> +EXPORT_SYMBOL(jz4780_bch_release);
> +
> +static int jz4780_bch_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct jz4780_bch *bch;
> +	struct resource *res;
> +
> +	bch = devm_kzalloc(dev, sizeof(*bch), GFP_KERNEL);
> +	if (!bch)
> +		return -ENOMEM;
> +
> +	bch->ops = device_get_match_data(dev);
> +	if (!bch->ops)
> +		return -EINVAL;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	bch->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(bch->base))
> +		return PTR_ERR(bch->base);
> +
> +	bch->ops->disable(bch);
> +
> +	bch->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(bch->clk)) {
> +		dev_err(dev, "failed to get clock: %ld\n", PTR_ERR(bch->clk));
> +		return PTR_ERR(bch->clk);
> +	}
> +
> +	mutex_init(&bch->lock);
> +
> +	bch->dev = dev;
> +	platform_set_drvdata(pdev, bch);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id jz4780_bch_dt_match[] = {
> +	{ .compatible = "ingenic,jz4780-bch", .data = &jz4780_bch_jz4780_ops },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, jz4780_bch_dt_match);
> +
> +static struct platform_driver jz4780_bch_driver = {
> +	.probe		= jz4780_bch_probe,
> +	.driver	= {
> +		.name	= "jz4780-bch",
> +		.of_match_table = of_match_ptr(jz4780_bch_dt_match),
> +	},
> +};
> +module_platform_driver(jz4780_bch_driver);
> +
> +MODULE_AUTHOR("Alex Smith <alex@alex-smith.me.uk>");
> +MODULE_AUTHOR("Harvey Hunt <harveyhuntnexus@gmail.com>");
> +MODULE_DESCRIPTION("Ingenic JZ4780 BCH error correction driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/mtd/nand/raw/jz4780_bch_internal.h b/drivers/mtd/nand/raw/jz4780_bch_internal.h
> new file mode 100644
> index 000000000000..7162e4f872f4
> --- /dev/null
> +++ b/drivers/mtd/nand/raw/jz4780_bch_internal.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __DRIVERS_MTD_NAND_JZ4780_BCH_INTERNAL_H__
> +#define __DRIVERS_MTD_NAND_JZ4780_BCH_INTERNAL_H__
> +
> +#include <linux/compiler_types.h>
> +#include <linux/mutex.h>
> +#include <linux/types.h>
> +
> +struct jz4780_bch_params;
> +struct jz4780_bch;
> +struct device;
> +struct clk;
> +
> +struct jz4780_bch_ops {
> +	void (*disable)(struct jz4780_bch *bch);
> +	int (*calculate)(struct jz4780_bch *bch,
> +			 struct jz4780_bch_params *params,
> +			 const u8 *buf, u8 *ecc_code);
> +	int (*correct)(struct jz4780_bch *bch,
> +			struct jz4780_bch_params *params,
> +			u8 *buf, u8 *ecc_code);
> +};
> +
> +struct jz4780_bch {
> +	struct device *dev;
> +	const struct jz4780_bch_ops *ops;
> +	void __iomem *base;
> +	struct clk *clk;
> +	struct mutex lock;
> +};
> +
> +extern const struct jz4780_bch_ops jz4780_bch_jz4780_ops;
> +
> +#endif /* __DRIVERS_MTD_NAND_JZ4780_BCH_INTERNAL_H__ */

