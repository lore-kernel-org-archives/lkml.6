Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbeC0IbL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 04:31:11 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35079 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbeC0IbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 04:31:07 -0400
X-Google-Smtp-Source: AG47ELsc7MxpPzJYW2aPI8WlmA4iD5rkBL80XuhIcjxLCP6fqKL9veDYaAfq9XoArRiFJdY9Ye5o4w==
Message-ID: <1522139454.2632.16.camel@baylibre.com>
Subject: Re: [PATCH v2 2/7] clk: meson: aoclk: refactor common code into
 dedicated file
From: Jerome Brunet <jbrunet@baylibre.com>
To: Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 27 Mar 2018 10:30:54 +0200
In-Reply-To: <20180323143816.200573-3-yixun.lan@amlogic.com>
References: <20180323143816.200573-1-yixun.lan@amlogic.com>
         <20180323143816.200573-3-yixun.lan@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-03-23 at 22:38 +0800, Yixun Lan wrote:
> We try to refactor the common code into one dedicated file,
> while preparing to add new Meson-AXG aoclk driver, this would
> help us to better share the code by all aoclk drivers.
> 
> Suggested-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---

[...]

>  
> -	return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
> +static int gxbb_aoclkc_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	ret = meson_aoclkc_probe(pdev, AO_RTI_GEN_CNTL_REG0,
> +			gxbb_aoclk_reset,
> +			ARRAY_SIZE(gxbb_aoclk_reset),
> +			gxbb_aoclk_gate,
> +			ARRAY_SIZE(gxbb_aoclk_gate),
>  			&gxbb_aoclk_onecell_data);
> +	if (ret) {
> +		dev_err(&pdev->dev, "aoclk probe failed.\n");
> +		return ret;
> +	}
> +
> +	return gxbb_aoclkc_register_specific_clk(pdev);
>  }

This rework is going in the right direction, but I would prefer if dropped this
probe function.

Instead, store the controller data (the params of this function, more or less)
in the of_match data. You'll need to define a structure for this.

You will then be able to use the same probe function for each controller
(this is what we do in the meson pinctrl driver, if you need an example)

>  
>  static const struct of_device_id gxbb_aoclkc_match_table[] = {
> diff --git a/drivers/clk/meson/gxbb-aoclk.h b/drivers/clk/meson/gxbb-aoclk.h
> index badc4c22b4ee..b031f1a0213e 100644
> --- a/drivers/clk/meson/gxbb-aoclk.h
> +++ b/drivers/clk/meson/gxbb-aoclk.h
> @@ -8,6 +8,10 @@
>  #ifndef __GXBB_AOCLKC_H
>  #define __GXBB_AOCLKC_H
>  
> +#include "meson-aoclk.h"
> +
> +#define NR_CLKS	7
> +
>  /* AO Configuration Clock registers offsets */
>  #define AO_RTI_PWR_CNTL_REG1	0x0c
>  #define AO_RTI_PWR_CNTL_REG0	0x10
> @@ -26,4 +30,7 @@ struct aoclk_cec_32k {
>  
>  extern const struct clk_ops meson_aoclk_cec_32k_ops;
>  
> +#include <dt-bindings/clock/gxbb-aoclkc.h>
> +#include <dt-bindings/reset/gxbb-aoclkc.h>
> +
>  #endif /* __GXBB_AOCLKC_H */
> diff --git a/drivers/clk/meson/meson-aoclk.c b/drivers/clk/meson/meson-aoclk.c
> new file mode 100644
> index 000000000000..b47c4008e15b
> --- /dev/null
> +++ b/drivers/clk/meson/meson-aoclk.c
> @@ -0,0 +1,76 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Amlogic Meson-AXG Clock Controller Driver
> + *
> + * Copyright (c) 2016 BayLibre, SAS.
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + *
> + * Copyright (c) 2018 Amlogic, inc.
> + * Author: Qiufang Dai <qiufang.dai@amlogic.com>
> + * Author: Yixun Lan <yixun.lan@amlogic.com>
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/init.h>
> +#include "clk-regmap.h"
> +#include "meson-aoclk.h"
> +
> +static int meson_aoclk_do_reset(struct reset_controller_dev *rcdev,
> +			       unsigned long id)
> +{
> +	struct meson_aoclk_reset_controller *reset =
> +		container_of(rcdev, struct meson_aoclk_reset_controller, reset);
> +
> +	return regmap_write(reset->regmap, reset->reg,
> +			    BIT(reset->data[id]));
> +}
> +
> +static const struct reset_control_ops meson_aoclk_reset_ops = {
> +	.reset = meson_aoclk_do_reset,
> +};
> +
> +int meson_aoclkc_probe(struct platform_device *pdev, unsigned int reg,

s/reg/reset_reg would help understand ...

> +		unsigned int *reset, int num_reset,
> +		struct clk_regmap **clks, int num_clks,
> +		struct clk_hw_onecell_data *data)
> +{
> +	struct meson_aoclk_reset_controller *rstc;
> +	struct device *dev = &pdev->dev;
> +	struct regmap *regmap;
> +	int ret, clkid;
> +
> +	rstc = devm_kzalloc(dev, sizeof(*rstc), GFP_KERNEL);
> +	if (!rstc)
> +		return -ENOMEM;
> +
> +	regmap = syscon_node_to_regmap(of_get_parent(dev->of_node));
> +	if (IS_ERR(regmap)) {
> +		dev_err(dev, "failed to get regmap\n");
> +		return -ENODEV;
> +	}
> +
> +	/* Reset Controller */
> +	rstc->regmap = regmap;
> +	rstc->data = reset;
> +	rstc->reg = reg;
> +	rstc->reset.ops = &meson_aoclk_reset_ops;
> +	rstc->reset.nr_resets = num_reset,
> +	rstc->reset.of_node = dev->of_node;
> +	ret = devm_reset_controller_register(dev, &rstc->reset);
> +
> +	/*
> +	 * Populate regmap and register all clks
> +	 */
> +	for (clkid = 0; clkid < num_clks; clkid++) {
> +		clks[clkid]->map = regmap;
> +
> +		ret = devm_clk_hw_register(dev, data->hws[clkid]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
> +			data);

Please align

> +}
> diff --git a/drivers/clk/meson/meson-aoclk.h b/drivers/clk/meson/meson-aoclk.h
> new file mode 100644
> index 000000000000..c82bce1728b8
> --- /dev/null
> +++ b/drivers/clk/meson/meson-aoclk.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Copyright (c) 2017 BayLibre, SAS
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + *
> + * Copyright (c) 2018 Amlogic, inc.
> + * Author: Qiufang Dai <qiufang.dai@amlogic.com>
> + * Author: Yixun Lan <yixun.lan@amlogic.com>
> + */
> +
> +#ifndef __MESON_AOCLK_H__
> +#define __MESON_AOCLK_H__
> +
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +#include "clk-regmap.h"
> +
> +struct meson_aoclk_reset_controller {
> +	struct reset_controller_dev reset;
> +	unsigned int *data;
> +	unsigned int reg;

nitpick: s/reg/offset ?

> +	struct regmap *regmap;
> +};
> +
> +int meson_aoclkc_probe(struct platform_device *pdev, unsigned int reg,
> +		unsigned int *reset, int num_reset,
> +		struct clk_regmap **clks, int num_clks,
> +		struct clk_hw_onecell_data *data);

which the proposed modification, this would become

int meson_aoclkc_probe(struct platform_device *pdev) ... as usual


> +#endif
> +

Thanks for doing this rework Yixun. With the comments addressed, I think it will
be fine. 
