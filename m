Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B91C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D1B2171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbfABKo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 05:44:58 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57637 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728677AbfABKo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 05:44:58 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1gee1A-0001lh-R5; Wed, 02 Jan 2019 11:44:56 +0100
Message-ID: <1546425895.3457.1.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] reset: Add Broadcom STB SW_INIT reset controller
 driver
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 02 Jan 2019 11:44:55 +0100
In-Reply-To: <20181221013409.14324-3-f.fainelli@gmail.com>
References: <20181221013409.14324-1-f.fainelli@gmail.com>
         <20181221013409.14324-3-f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Thu, 2018-12-20 at 17:34 -0800, Florian Fainelli wrote:
> Add support for resetting blocks through the Linux reset controller
> subsystem when reset lines are provided through a SW_INIT-style reset
> controller on Broadcom STB SoCs.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Thank you, this looks mostly good to me. I just have a few small
nitpicks and I'm curious about the mdelays, see below.

> ---
>  drivers/reset/Kconfig         |   7 ++
>  drivers/reset/Makefile        |   1 +
>  drivers/reset/reset-brcmstb.c | 121 ++++++++++++++++++++++++++++++++++
>  3 files changed, 129 insertions(+)
>  create mode 100644 drivers/reset/reset-brcmstb.c
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 2e01bd833ffd..1ca03c57e049 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -40,6 +40,13 @@ config RESET_BERLIN
>  	help
>  	  This enables the reset controller driver for Marvell Berlin SoCs.
>  
> +config RESET_BRCMSTB
> +	bool "Broadcom STB reset controller" if COMPILE_TEST
> +	default ARCH_BRCMSTB
> +	help
> +	  This enables the reset controller driver for Broadcom STB SoCs using
> +	  a SUN_TOP_CTRL_SW_INIT style controller.
> +
>  config RESET_HSDK
>  	bool "Synopsys HSDK Reset Driver"
>  	depends on HAS_IOMEM
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index dc7874df78d9..7395db2cb1dd 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_RESET_A10SR) += reset-a10sr.o
>  obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
>  obj-$(CONFIG_RESET_AXS10X) += reset-axs10x.o
>  obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
> +obj-$(CONFIG_RESET_BRCMSTB) += reset-brcmstb.o
>  obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
>  obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
>  obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
> diff --git a/drivers/reset/reset-brcmstb.c b/drivers/reset/reset-brcmstb.c
> new file mode 100644
> index 000000000000..17a0bcdd6c9a
> --- /dev/null
> +++ b/drivers/reset/reset-brcmstb.c
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Broadcom STB generic reset controller for SW_INIT style reset controller
> + *
> + * Copyright (C) 2018 Broadcom
> + *
> + */
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +#include <linux/types.h>
> +
> +struct brcmstb_reset {
> +	void __iomem *base;

> +	unsigned int n_words;
> +	struct device *dev;

These two variables are not used anywhere.

> +	struct reset_controller_dev rcdev;
> +};
> +
> +#define SW_INIT_SET		0x00
> +#define SW_INIT_CLEAR		0x04
> +#define SW_INIT_STATUS		0x08
> +
> +#define SW_INIT_BIT(id)		BIT((id) & 0x1f)
> +#define SW_INIT_BANK(id)	(id >> 5)

Checkpatch suggests to use ((id) >> 5) here.

> +
> +#define SW_INIT_BANK_SIZE	0x18
> +
> +static inline
> +struct brcmstb_reset *to_brcmstb(struct reset_controller_dev *rcdev)
> +{
> +	return container_of(rcdev, struct brcmstb_reset, rcdev);
> +}
> +
> +static int brcmstb_reset_assert(struct reset_controller_dev *rcdev,
> +				unsigned long id)
> +{
> +	unsigned int off = SW_INIT_BANK(id) * SW_INIT_BANK_SIZE;
> +	struct brcmstb_reset *priv = to_brcmstb(rcdev);
> +
> +	writel_relaxed(SW_INIT_BIT(id), priv->base + off + SW_INIT_SET);
> +	msleep(10);

What is the purpose of the msleep(10)? Is it guaranteed that the writel
takes effect before the msleep, or could it be lingering in some store
buffer for (a part of) the duration? Also, checkpatch warns about this
being < 20 ms. You could increase the delay or use usleep_range.

> +	return 0;
> +}
> +
> +static int brcmstb_reset_deassert(struct reset_controller_dev *rcdev,
> +				  unsigned long id)
> +{
> +	unsigned int off = SW_INIT_BANK(id) * SW_INIT_BANK_SIZE;
> +	struct brcmstb_reset *priv = to_brcmstb(rcdev);
> +
> +	writel_relaxed(SW_INIT_BIT(id), priv->base + off + SW_INIT_CLEAR);
> +	msleep(10);

Same as above, what has to be delayed for 10 ms after deasserting the
reset? Is this the same for all reset lines handled by this controller?

> +
> +	return 0;
> +}
> +
> +static int brcmstb_reset_status(struct reset_controller_dev *rcdev,
> +				unsigned long id)
> +{
> +	unsigned int off = SW_INIT_BANK(id) * SW_INIT_BANK_SIZE;
> +	struct brcmstb_reset *priv = to_brcmstb(rcdev);
> +
> +	return readl_relaxed(priv->base + off + SW_INIT_STATUS);

Should this be

+	return readl_relaxed(priv->base + off + SW_INIT_STATUS) &
+	       SW_INIT_BANK(id);

i.e. do the SW_INIT_STATUS registers contain 32 status bits, one for
each reset line?

> +}
> +
> +static const struct reset_control_ops brcmstb_reset_ops = {
> +	.assert	= brcmstb_reset_assert,
> +	.deassert = brcmstb_reset_deassert,
> +	.status = brcmstb_reset_status,
> +};
> +
> +static int brcmstb_reset_probe(struct platform_device *pdev)
> +{
> +	struct device *kdev = &pdev->dev;
> +	struct brcmstb_reset *priv;
> +	struct resource *res;
> +
> +	priv = devm_kzalloc(kdev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	priv->base = devm_ioremap_resource(kdev, res);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	dev_set_drvdata(kdev, priv);
> +
> +	priv->rcdev.owner = THIS_MODULE;
> +	priv->rcdev.nr_resets = (resource_size(res) / SW_INIT_BANK_SIZE) * 32;
> +	priv->rcdev.ops = &brcmstb_reset_ops;
> +	priv->rcdev.of_node = kdev->of_node;
> +	/* Use defaults: 1 cell and simple xlate function */
> +	priv->dev = kdev;

priv->dev could be removed.

> +
> +	return devm_reset_controller_register(kdev, &priv->rcdev);
> +}
> +
> +static const struct of_device_id brcmstb_reset_of_match[] = {
> +	{ .compatible = "brcm,brcmstb-reset" },
> +	{ /* sentinel */ }
> +};
> +
> +static struct platform_driver brcmstb_reset_driver = {
> +	.probe	= brcmstb_reset_probe,
> +	.driver	= {
> +		.name = "brcmstb-reset",
> +		.of_match_table = brcmstb_reset_of_match,
> +	},
> +};
> +module_platform_driver(brcmstb_reset_driver);
> +
> +MODULE_AUTHOR("Broadcom");
> +MODULE_DESCRIPTION("Broadcom STB reset controller");
> +MODULE_LICENSE("GPL");

regards
Philipp
