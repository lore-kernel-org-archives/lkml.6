Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993E9C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397A327D56
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 397A327D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934417AbeF2KxJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 06:53:09 -0400
Received: from mx.socionext.com ([202.248.49.38]:44775 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932890AbeF2KxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 06:53:07 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 29 Jun 2018 19:53:06 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 45B0C1800FC;
        Fri, 29 Jun 2018 19:53:06 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Fri, 29 Jun 2018 19:53:06 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id B371C4036B;
        Fri, 29 Jun 2018 19:53:05 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 7F1A1120141;
        Fri, 29 Jun 2018 19:53:05 +0900 (JST)
Date:   Fri, 29 Jun 2018 19:53:04 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 2/2] reset: uniphier: add USB3 controller reset control
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
In-Reply-To: <1530266124.5549.3.camel@pengutronix.de>
References: <1530259891-18822-3-git-send-email-hayashi.kunihiko@socionext.com> <1530266124.5549.3.camel@pengutronix.de>
Message-Id: <20180629195304.DD7B.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,
Thank you for your comments.

On Fri, 29 Jun 2018 11:55:24 +0200 <p.zabel@pengutronix.de> wrote:

> Hi Kunihiko,
> 
> thank you for the patch. I just have a few small comments below:
> 
> On Fri, 2018-06-29 at 17:11 +0900, Kunihiko Hayashi wrote:
> > Add reset lines for USB3 controller implemented in UniPhier SoCs.
> > 
> > This reuses only the reset operations in reset-simple, because
> > the reset-simple doesn't handle any SoC-dependent clocks and resets.
> > This reset lines is included in the USB3 glue layer, and it's necessary
> > to enable clocks and deassert resets of the layer before using this
> > reset lines.
> > 
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > ---
> >  drivers/reset/Kconfig               |  10 ++
> >  drivers/reset/Makefile              |   1 +
> >  drivers/reset/reset-uniphier-usb3.c | 183 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 194 insertions(+)
> >  create mode 100644 drivers/reset/reset-uniphier-usb3.c
> > 
> > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> > index c0b292b..851c9c3 100644
> > --- a/drivers/reset/Kconfig
> > +++ b/drivers/reset/Kconfig
> > @@ -138,6 +138,16 @@ config RESET_UNIPHIER
> >  	  Say Y if you want to control reset signals provided by System Control
> >  	  block, Media I/O block, Peripheral Block.
> >  
> > +config RESET_UNIPHIER_USB3
> > +	tristate "USB3 reset driver for UniPhier SoCs"
> > +	depends on (ARCH_UNIPHIER || COMPILE_TEST) && OF
> > +	default ARCH_UNIPHIER
> > +	select RESET_SIMPLE
> > +	help
> > +	  Support for USB3 reset controllers on UniPhier SoCs.
> > +	  Say Y if you want to control reset signals provided by
> > +	  USB3 controller block.
> > +
> >  config RESET_ZYNQ
> >  	bool "ZYNQ Reset Driver" if COMPILE_TEST
> >  	default ARCH_ZYNQ
> > diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> > index c1261dc..2638ac4 100644
> > --- a/drivers/reset/Makefile
> > +++ b/drivers/reset/Makefile
> > @@ -20,5 +20,6 @@ obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
> >  obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
> >  obj-$(CONFIG_RESET_TI_SYSCON) += reset-ti-syscon.o
> >  obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
> > +obj-$(CONFIG_RESET_UNIPHIER_USB3) += reset-uniphier-usb3.o
> >  obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
> >  
> > diff --git a/drivers/reset/reset-uniphier-usb3.c b/drivers/reset/reset-uniphier-usb3.c
> > new file mode 100644
> > index 0000000..397e6c9
> > --- /dev/null
> > +++ b/drivers/reset/reset-uniphier-usb3.c
> > @@ -0,0 +1,183 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * reset-uniphier-usb3.c - USB3 reset driver for UniPhier
> > + * Copyright 2018 Socionext Inc.
> > + * Author: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/reset.h>
> > +
> > +#include "reset-simple.h"
> > +
> > +#define MAX_CLKS	2
> > +#define MAX_RSTS	2
> > +
> > +struct uniphier_usb3_reset_soc_data {
> > +	const char *clock_names[MAX_CLKS];
> > +	const char *reset_names[MAX_RSTS];
> > +};
> > +
> > +struct uniphier_usb3_reset_priv {
> 
> I'd embed a struct reset_simple_data here ...
> 
> > +	int nclks;
> > +	struct clk *clk[MAX_CLKS];
> > +	int nrsts;
> > +	struct reset_control *rst[MAX_RSTS];
> > +	const struct uniphier_usb3_reset_soc_data *data;
> > +};
> > +
> > +static int uniphier_usb3_reset_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct uniphier_usb3_reset_priv *priv;
> > +	struct reset_simple_data *rst_data;
> > +	struct resource *res;
> > +	resource_size_t size;
> > +	const char *name;
> > +	int i, ret, nc, nr;
> > +
> > +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->data = of_device_get_match_data(dev);
> > +	if (WARN_ON(!priv->data))
> > +		return -EINVAL;
> > +
> > +	rst_data = devm_kzalloc(dev, sizeof(*rst_data), GFP_KERNEL);
> > +	if (!rst_data)
> > +		return -ENOMEM;
> 
> ... that way there's no need for two separate allocations.

Indeed. I'll embed reset_simple_data in uniphier_usb3_reset_priv,
and remove this.

> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	size = resource_size(res);
> > +	rst_data->membase = devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(rst_data->membase))
> > +		return PTR_ERR(rst_data->membase);
> > +
> > +	for (i = 0; i < MAX_CLKS; i++) {
> > +		name = priv->data->clock_names[i];
> > +		if (!name)
> > +			break;
> > +		priv->clk[i] = devm_clk_get(dev, name);
> > +		if (IS_ERR(priv->clk[i]))
> > +			return PTR_ERR(priv->clk[i]);
> > +		priv->nclks++;
> > +	}
> > +
> > +	for (i = 0; i < MAX_RSTS; i++) {
> > +		name = priv->data->reset_names[i];
> > +		if (!name)
> > +			break;
> > +		priv->rst[i] = devm_reset_control_get_shared(dev, name);
> > +		if (IS_ERR(priv->rst[i]))
> > +			return PTR_ERR(priv->rst[i]);
> > +		priv->nrsts++;
> > +	}
> > +
> > +	for (nc = 0; nc < priv->nclks; nc++) {
> > +		ret = clk_prepare_enable(priv->clk[nc]);
> > +		if (ret)
> > +			goto out_clk_disable;
> > +	}
> > +
> > +	for (nr = 0; nr < priv->nrsts; nr++) {
> > +		ret = reset_control_deassert(priv->rst[nr]);
> > +		if (ret)
> > +			goto out_rst_assert;
> > +	}
> 
> Have you seen the clk_bulk_* APIs? Those could possibly simplify the
> code a bit.

Okay. I'll try to apply it.

> Unfortunately we don't have the equivalent reset bulk API.

Yes. And although the reset array API can get multiple resets,
it can't specify each reset with its name.

> > +
> > +	spin_lock_init(&rst_data->lock);
> > +	rst_data->rcdev.owner = THIS_MODULE;
> > +	rst_data->rcdev.nr_resets = size * BITS_PER_BYTE;
> > +	rst_data->rcdev.ops = &reset_simple_ops;
> > +	rst_data->rcdev.of_node = dev->of_node;
> > +	rst_data->active_low = true;
> > +
> > +	platform_set_drvdata(pdev, priv);
> > +
> > +	ret = devm_reset_controller_register(dev, &rst_data->rcdev);
> > +	if (ret)
> > +		goto out_rst_assert;
> > +
> > +	return 0;
> > +
> > +out_rst_assert:
> > +	while (nr--)
> > +		reset_control_assert(priv->rst[nr]);
> > +out_clk_disable:
> > +	while (nc--)
> > +		clk_disable_unprepare(priv->clk[nc]);
> > +
> > +	return ret;
> > +}
> > +
> > +static int uniphier_usb3_reset_remove(struct platform_device *pdev)
> > +{
> > +	struct uniphier_usb3_reset_priv *priv = platform_get_drvdata(pdev);
> > +	int i;
> > +
> > +	for (i = 0; i < priv->nrsts; i++)
> > +		reset_control_assert(priv->rst[i]);
> > +	for (i = 0; i < priv->nclks; i++)
> > +		clk_disable_unprepare(priv->clk[i]);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct uniphier_usb3_reset_soc_data uniphier_pro4_data = {
> > +	.clock_names = { "gio", "link", },
> > +	.reset_names = { "gio", "link", },
> > +};
> > +
> > +static const struct uniphier_usb3_reset_soc_data uniphier_pxs2_data = {
> > +	.clock_names = { "link", },
> > +	.reset_names = { "link", },
> > +};
> > +
> > +static const struct uniphier_usb3_reset_soc_data uniphier_ld20_data = {
> > +	.clock_names = { "link", },
> > +	.reset_names = { "link", },
> > +};
> > +
> > +static const struct uniphier_usb3_reset_soc_data uniphier_pxs3_data = {
> > +	.clock_names = { "link", },
> > +	.reset_names = { "link", },
> > +};
> 
> Could you reuse the same SoC data for pxs2, ld20 and pxs3?

Sure, I'll rewrite it.

Thank you,

> > +static const struct of_device_id uniphier_usb3_reset_match[] = {
> > +	{
> > +		.compatible = "socionext,uniphier-pro4-usb3-reset",
> > +		.data = &uniphier_pro4_data,
> > +	},
> > +	{
> > +		.compatible = "socionext,uniphier-pxs2-usb3-reset",
> > +		.data = &uniphier_pxs2_data,
> > +	},
> > +	{
> > +		.compatible = "socionext,uniphier-ld20-usb3-reset",
> > +		.data = &uniphier_ld20_data,
> > +	},
> > +	{
> > +		.compatible = "socionext,uniphier-pxs3-usb3-reset",
> > +		.data = &uniphier_pxs3_data,
> > +	},
> > +	{ /* Sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, uniphier_usb3_reset_match);
> > +
> > +static struct platform_driver uniphier_usb3_reset_driver = {
> > +	.probe = uniphier_usb3_reset_probe,
> > +	.remove = uniphier_usb3_reset_remove,
> > +	.driver = {
> > +		.name = "uniphier-usb3-reset",
> > +		.of_match_table = uniphier_usb3_reset_match,
> > +	},
> > +};
> > +module_platform_driver(uniphier_usb3_reset_driver);
> > +
> > +MODULE_AUTHOR("Kunihiko Hayashi <hayashi.kunihiko@socionext.com>");
> > +MODULE_DESCRIPTION("UniPhier USB3 Reset Driver");
> > +MODULE_LICENSE("GPL");
> 
> regards
> Philipp

---
Best Regards,
Kunihiko Hayashi


