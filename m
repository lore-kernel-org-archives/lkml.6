Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbeBZQYW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 11:24:22 -0500
Received: from mailoutvs4.siol.net ([213.250.19.137]:37657 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751550AbeBZQYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 11:24:20 -0500
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To: maxime.ripard@free-electrons.com
Cc: wens@csie.org, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 11/15] drm/sun4i: Add support for H3 HDMI PHY variant
Date: Mon, 26 Feb 2018 17:24:13 +0100
Message-ID: <5983773.Yp6r9qpA8a@jernej-laptop>
In-Reply-To: <20180224214545.3740-12-jernej.skrabec@siol.net>
References: <20180224214545.3740-1-jernej.skrabec@siol.net> <20180224214545.3740-12-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Dne sobota, 24. februar 2018 ob 22:45:41 CET je Jernej Skrabec napisal(a):
> While A83T HDMI PHY seems to be just customized Synopsys HDMI PHY, H3
> HDMI PHY is completely custom PHY.
> 
> However, they still have many things in common like clock and reset
> setup, setting sync polarity and more.
> 
> Add support for H3 HDMI PHY variant.
> 
> While documentation exists for this PHY variant, it doesn't go in great
> details. Because of that, almost all settings are copied from BSP linux
> 4.4. Interestingly, those settings are slightly different to those found
> in a older BSP with Linux 3.4. For now, no user visible difference was
> found between them.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/Makefile             |   1 +
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h      |   6 +
>  drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c     | 263
> ++++++++++++++++++++++++++++- drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c |
> 130 ++++++++++++++
>  4 files changed, 397 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c
> 
[...]
> diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c
> b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c new file mode 100644
> index 000000000000..3c34ec5ff4af
> --- /dev/null
> +++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c
> @@ -0,0 +1,130 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2018 Jernej Skrabec <jernej.skrabec@siol.net>
> + */
> +
> +#include <linux/clk-provider.h>
> +
> +#include "sun8i_dw_hdmi.h"
> +
> +struct sun8i_phy_clk {
> +	struct clk_hw		hw;
> +	struct sun8i_hdmi_phy	*phy;
> +};
> +
> +static inline struct sun8i_phy_clk *hw_to_phy_clk(struct clk_hw *hw)
> +{
> +	return container_of(hw, struct sun8i_phy_clk, hw);
> +}
> +
> +static int sun8i_phy_clk_determine_rate(struct clk_hw *hw,
> +					struct clk_rate_request *req)
> +{
> +	unsigned long rate = req->rate;
> +	unsigned long best_rate = 0;
> +	struct clk_hw *parent;
> +	int best_div = 1;
> +	int i;
> +
> +	parent = clk_hw_get_parent(hw);
> +
> +	for (i = 1; i <= 16; i++) {
> +		unsigned long ideal = rate * i;
> +		unsigned long rounded;
> +
> +		rounded = clk_hw_round_rate(parent, ideal);
> +
> +		if (rounded == ideal) {
> +			best_rate = rounded;
> +			best_div = i;
> +			break;
> +		}
> +
> +		if (abs(rate - rounded) < abs(rate - best_rate / best_div)) {

Here is a bug. Above line should be:
if (abs(rate - rounded / i) < abs(rate - best_rate / best_div)) {

I guess this could solve the issue described in cover letter.

Best regards,
Jernej

> +			best_rate = rounded;
> +			best_div = i;
> +		}
> +	}
> +
> +	req->rate = best_rate / best_div;
> +	req->best_parent_rate = best_rate;
> +	req->best_parent_hw = parent;
> +
> +	return 0;
> +}
> +
> +static unsigned long sun8i_phy_clk_recalc_rate(struct clk_hw *hw,
> +					       unsigned long parent_rate)
> +{
> +	struct sun8i_phy_clk *priv = hw_to_phy_clk(hw);
> +	u32 reg;
> +
> +	regmap_read(priv->phy->regs, SUN8I_HDMI_PHY_PLL_CFG2_REG, &reg);
> +	reg = ((reg >> SUN8I_HDMI_PHY_PLL_CFG2_PREDIV_SHIFT) &
> +		SUN8I_HDMI_PHY_PLL_CFG2_PREDIV_MSK) + 1;
> +
> +	return parent_rate / reg;
> +}
> +
> +static int sun8i_phy_clk_set_rate(struct clk_hw *hw, unsigned long rate,
> +				  unsigned long parent_rate)
> +{
> +	struct sun8i_phy_clk *priv = hw_to_phy_clk(hw);
> +	unsigned long best_rate = 0;
> +	u8 best_m = 0, m;
> +
> +	for (m = 1; m <= 16; m++) {
> +		unsigned long tmp_rate = parent_rate / m;
> +
> +		if (tmp_rate > rate)
> +			continue;
> +
> +		if (!best_rate ||
> +		    (rate - tmp_rate) < (rate - best_rate)) {
> +			best_rate = tmp_rate;
> +			best_m = m;
> +		}
> +	}
> +
> +	regmap_update_bits(priv->phy->regs, SUN8I_HDMI_PHY_PLL_CFG2_REG,
> +			   SUN8I_HDMI_PHY_PLL_CFG2_PREDIV_MSK,
> +			   SUN8I_HDMI_PHY_PLL_CFG2_PREDIV(best_m));
> +
> +	return 0;
> +}
> +
> +static const struct clk_ops sun8i_phy_clk_ops = {
> +	.determine_rate	= sun8i_phy_clk_determine_rate,
> +	.recalc_rate	= sun8i_phy_clk_recalc_rate,
> +	.set_rate	= sun8i_phy_clk_set_rate,
> +};
> +
> +int sun8i_phy_clk_create(struct sun8i_hdmi_phy *phy, struct device *dev)
> +{
> +	struct clk_init_data init;
> +	struct sun8i_phy_clk *priv;
> +	const char *parents[1];
> +
> +	parents[0] = __clk_get_name(phy->clk_pll0);
> +	if (!parents[0])
> +		return -ENODEV;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	init.name = "hdmi-phy-clk";
> +	init.ops = &sun8i_phy_clk_ops;
> +	init.parent_names = parents;
> +	init.num_parents = 1;
> +	init.flags = CLK_SET_RATE_PARENT;
> +
> +	priv->phy = phy;
> +	priv->hw.init = &init;
> +
> +	phy->clk_phy = devm_clk_register(dev, &priv->hw);
> +	if (IS_ERR(phy->clk_phy))
> +		return PTR_ERR(phy->clk_phy);
> +
> +	return 0;
> +}
> --
> 2.16.2
