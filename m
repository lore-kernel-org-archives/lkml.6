Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752074AbeEROr2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:47:28 -0400
Received: from mailout3.siol.net ([213.250.19.130]:45708 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751971AbeEROrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:47:25 -0400
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 12/26] drm/sun4i: Add support for multiple DW HDMI PHY clock parents
Date: Fri, 18 May 2018 16:46:41 +0200
Message-ID: <4909574.Q3IFWM0xt6@jernej-laptop>
In-Reply-To: <20180518100116.4bf2qcffg7ekxa7u@flea>
References: <20180518094536.17201-1-jagan@amarulasolutions.com> <20180518094536.17201-13-jagan@amarulasolutions.com> <20180518100116.4bf2qcffg7ekxa7u@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Dne petek, 18. maj 2018 ob 12:01:16 CEST je Maxime Ripard napisal(a):
> On Fri, May 18, 2018 at 03:15:22PM +0530, Jagan Teki wrote:
> > From: Jernej Skrabec <jernej.skrabec@siol.net>
> > 
> > Some SoCs with DW HDMI have multiple possible clock parents, like A64
> > and R40.
> > 
> > Expand HDMI PHY clock driver to support second clock parent.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> > Changes for v2:
> > - new patch
> > 
> >  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h      |  9 ++-
> >  drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c     | 33 ++++++++---
> >  drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c | 89
> >  ++++++++++++++++++++++-------- 3 files changed, 96 insertions(+), 35
> >  deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> > b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h index 79154f0f674a..303189d6602c
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> > +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> > @@ -98,7 +98,8 @@
> > 
> >  #define SUN8I_HDMI_PHY_PLL_CFG1_LDO2_EN		BIT(29)
> >  #define SUN8I_HDMI_PHY_PLL_CFG1_LDO1_EN		BIT(28)
> >  #define SUN8I_HDMI_PHY_PLL_CFG1_HV_IS_33	BIT(27)
> > 
> > -#define SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL	BIT(26)
> > +#define SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK	BIT(26)
> > +#define SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_SHIFT	26
> > 
> >  #define SUN8I_HDMI_PHY_PLL_CFG1_PLLEN		BIT(25)
> >  #define SUN8I_HDMI_PHY_PLL_CFG1_LDO_VSET(x)	((x) << 22)
> >  #define SUN8I_HDMI_PHY_PLL_CFG1_UNKNOWN(x)	((x) << 20)
> > 
> > @@ -146,7 +147,7 @@
> > 
> >  struct sun8i_hdmi_phy;
> >  
> >  struct sun8i_hdmi_phy_variant {
> > 
> > -	bool has_phy_clk;
> > +	int  phy_clk_num;
> > 
> >  	void (*phy_init)(struct sun8i_hdmi_phy *phy);
> >  	void (*phy_disable)(struct dw_hdmi *hdmi,
> >  	
> >  			    struct sun8i_hdmi_phy *phy);
> > 
> > @@ -160,6 +161,7 @@ struct sun8i_hdmi_phy {
> > 
> >  	struct clk			*clk_mod;
> >  	struct clk			*clk_phy;
> >  	struct clk			*clk_pll0;
> > 
> > +	struct clk			*clk_pll1;
> > 
> >  	unsigned int			rcal;
> >  	struct regmap			*regs;
> >  	struct reset_control		*rst_phy;
> > 
> > @@ -188,6 +190,7 @@ void sun8i_hdmi_phy_remove(struct sun8i_dw_hdmi
> > *hdmi);
> > 
> >  void sun8i_hdmi_phy_init(struct sun8i_hdmi_phy *phy);
> >  const struct dw_hdmi_phy_ops *sun8i_hdmi_phy_get_ops(void);
> > 
> > -int sun8i_phy_clk_create(struct sun8i_hdmi_phy *phy, struct device *dev);
> > +int sun8i_phy_clk_create(struct sun8i_hdmi_phy *phy, struct device *dev,
> > +			 int clk_num);
> > 
> >  #endif /* _SUN8I_DW_HDMI_H_ */
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> > b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c index 5a52fc489a9d..0eadf087fc46
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> > @@ -183,7 +183,13 @@ static int sun8i_hdmi_phy_config_h3(struct dw_hdmi
> > *hdmi,> 
> >  	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_ANA_CFG1_REG,
> >  	
> >  			   SUN8I_HDMI_PHY_ANA_CFG1_TXEN_MASK, 0);
> > 
> > -	regmap_write(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG, pll_cfg1_init);
> > +	/*
> > +	 * NOTE: We have to be careful not to overwrite PHY parent
> > +	 * clock selection bit and clock divider.
> > +	 */
> > +	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG,
> > +			   (u32)~SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK,
> > +			   pll_cfg1_init);
> > 
> >  	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_PLL_CFG2_REG,
> >  	
> >  			   (u32)~SUN8I_HDMI_PHY_PLL_CFG2_PREDIV_MSK,
> >  			   pll_cfg2_init);
> > 
> > @@ -232,7 +238,7 @@ static int sun8i_hdmi_phy_config(struct dw_hdmi *hdmi,
> > void *data,> 
> >  	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_DBG_CTRL_REG,
> >  	
> >  			   SUN8I_HDMI_PHY_DBG_CTRL_POL_MASK, val);
> > 
> > -	if (phy->variant->has_phy_clk)
> > +	if (phy->variant->phy_clk_num)
> > 
> >  		clk_set_rate(phy->clk_phy, mode->crtc_clock * 1000);
> >  	
> >  	return phy->variant->phy_config(hdmi, phy, mode->crtc_clock * 1000);
> > 
> > @@ -393,7 +399,7 @@ static const struct sun8i_hdmi_phy_variant
> > sun8i_a83t_hdmi_phy = {> 
> >  };
> >  
> >  static const struct sun8i_hdmi_phy_variant sun8i_h3_hdmi_phy = {
> > 
> > -	.has_phy_clk = true,
> > +	.phy_clk_num = 1,
> > 
> >  	.phy_init = &sun8i_hdmi_phy_init_h3,
> >  	.phy_disable = &sun8i_hdmi_phy_disable_h3,
> >  	.phy_config = &sun8i_hdmi_phy_config_h3,
> > 
> > @@ -464,7 +470,7 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi *hdmi,
> > struct device_node *node)> 
> >  		goto err_put_clk_bus;
> >  	
> >  	}
> > 
> > -	if (phy->variant->has_phy_clk) {
> > +	if (phy->variant->phy_clk_num) {
> > 
> >  		phy->clk_pll0 = of_clk_get_by_name(node, "pll-0");
> >  		if (IS_ERR(phy->clk_pll0)) {
> >  		
> >  			dev_err(dev, "Could not get pll-0 clock\n");
> > 
> > @@ -472,7 +478,16 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi *hdmi,
> > struct device_node *node)> 
> >  			goto err_put_clk_mod;
> >  		
> >  		}
> > 
> > -		ret = sun8i_phy_clk_create(phy, dev);
> > +		if (phy->variant->phy_clk_num) {
> > +			phy->clk_pll1 = of_clk_get_by_name(node, "pll-1");
> > +			if (IS_ERR(phy->clk_pll1)) {
> > +				dev_err(dev, "Could not get pll-1 clock\n");
> > +				ret = PTR_ERR(phy->clk_pll1);
> > +				goto err_put_clk_mod;
> > +			}
> > +		}
> > +
> 
> You have a bug here. If phy_clk_num == 1, you'll still try to lookup
> pll-1.

This is actually WIP patch taken from my github. This issue was fixed already 
locally on disk. I thought Jagan will not use it until SRAM C patches land.

> 
> And this is a bit sloppy, since if phy_clk_num == 3, you won't try to
> lookup pll-2 either.

It is highly unlikely this will be higher than 2, at least for this HDMI PHY, 
since it has only 1 bit reserved for parent selection. But since I have to fix 
it, I'll add ">= 2"

> 
> > +		ret = sun8i_phy_clk_create(phy, dev, phy->variant->phy_clk_num);
> > 
> >  		if (ret) {
> >  		
> >  			dev_err(dev, "Couldn't create the PHY clock\n");
> >  			goto err_put_clk_pll0;
> > 
> > @@ -515,8 +530,8 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi *hdmi,
> > struct device_node *node)> 
> >  err_put_rst_phy:
> >  	reset_control_put(phy->rst_phy);
> >  
> >  err_put_clk_pll0:
> > -	if (phy->variant->has_phy_clk)
> > -		clk_put(phy->clk_pll0);
> > +	clk_put(phy->clk_pll0);
> > +	clk_put(phy->clk_pll1);
> > 
> >  err_put_clk_mod:
> >  	clk_put(phy->clk_mod);
> >  
> >  err_put_clk_bus:
> > @@ -536,8 +551,8 @@ void sun8i_hdmi_phy_remove(struct sun8i_dw_hdmi *hdmi)
> > 
> >  	reset_control_put(phy->rst_phy);
> > 
> > -	if (phy->variant->has_phy_clk)
> > -		clk_put(phy->clk_pll0);
> > +	clk_put(phy->clk_pll0);
> > +	clk_put(phy->clk_pll1);
> > 
> >  	clk_put(phy->clk_mod);
> >  	clk_put(phy->clk_bus);
> >  
> >  }
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c
> > b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c index
> > faea449812f8..85b12fc96dbc 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c
> > @@ -22,29 +22,36 @@ static int sun8i_phy_clk_determine_rate(struct clk_hw
> > *hw,> 
> >  {
> >  
> >  	unsigned long rate = req->rate;
> >  	unsigned long best_rate = 0;
> > 
> > -	struct clk_hw *parent;
> > +	struct clk_hw *best_parent = NULL;
> > +	struct clk_hw *parent = NULL;
> > 
> >  	int best_div = 1;
> > 
> > -	int i;
> > +	int i, p;
> > 
> > -	parent = clk_hw_get_parent(hw);
> > -
> > -	for (i = 1; i <= 16; i++) {
> > -		unsigned long ideal = rate * i;
> > -		unsigned long rounded;
> > -
> > -		rounded = clk_hw_round_rate(parent, ideal);
> > -
> > -		if (rounded == ideal) {
> > -			best_rate = rounded;
> > -			best_div = i;
> > -			break;
> > -		}
> > +	for (p = 0; p < clk_hw_get_num_parents(hw); p++) {
> > +		parent = clk_hw_get_parent_by_index(hw, p);
> > +		if (!parent)
> > +			continue;
> > 
> > -		if (!best_rate ||
> > -		    abs(rate - rounded / i) <
> > -		    abs(rate - best_rate / best_div)) {
> > -			best_rate = rounded;
> > -			best_div = i;
> > +		for (i = 1; i <= 16; i++) {
> > +			unsigned long ideal = rate * i;
> > +			unsigned long rounded;
> > +
> > +			rounded = clk_hw_round_rate(parent, ideal);
> > +
> > +			if (rounded == ideal) {
> > +				best_rate = rounded;
> > +				best_div = i;
> > +				best_parent = parent;
> > +				break;
> > +			}
> > +
> > +			if (!best_rate ||
> > +			    abs(rate - rounded / i) <
> > +			    abs(rate - best_rate / best_div)) {
> > +				best_rate = rounded;
> > +				best_div = i;
> > +				best_parent = parent;
> > +			}
> > 
> >  		}
> >  	
> >  	}
> > 
> > @@ -95,22 +102,58 @@ static int sun8i_phy_clk_set_rate(struct clk_hw *hw,
> > unsigned long rate,> 
> >  	return 0;
> >  
> >  }
> > 
> > +static u8 sun8i_phy_clk_get_parent(struct clk_hw *hw)
> > +{
> > +	struct sun8i_phy_clk *priv = hw_to_phy_clk(hw);
> > +	u32 reg;
> > +
> > +	regmap_read(priv->phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG, &reg);
> > +	reg = (reg & SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK) >>
> > +	      SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_SHIFT;
> > +
> > +	return reg;
> > +}
> > +
> > +static int sun8i_phy_clk_set_parent(struct clk_hw *hw, u8 index)
> > +{
> > +	struct sun8i_phy_clk *priv = hw_to_phy_clk(hw);
> > +
> > +	if (index > 1)
> > +		return -EINVAL;
> > +
> > +	regmap_update_bits(priv->phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG,
> > +			   SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK,
> > +			   index << SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_SHIFT);
> > +
> > +	return 0;
> > +}
> > +
> 
> The DT bindings changes and the clk changes should be part of separate
> patches.

By DT bindings changes you mean code which reads DT and not DT documentation, 
right?

Ok, I'll split it.

BTW, I'll resend fixed version of this patch for my R40 HDMI series, since 
there is nothing to hold it back, unlike for this.

Best regards,
Jernej
