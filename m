Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932367AbeBSUZp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:25:45 -0500
Received: from vern.gendns.com ([206.190.152.46]:58564 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932184AbeBSUXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:23:07 -0500
From: David Lechner <david@lechnology.com>
To: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org,
        David Lechner <david@lechnology.com>
Subject: [PATCH v7 19/42] clk: davinci: cfgchip: Add TI DA8XX USB PHY clocks
Date: Mon, 19 Feb 2018 14:21:40 -0600
Message-Id: <1519071723-31790-20-git-send-email-david@lechnology.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519071723-31790-1-git-send-email-david@lechnology.com>
References: <1519071723-31790-1-git-send-email-david@lechnology.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new driver for the USB PHY clocks in the CFGCHIP2 syscon
register on TI DA8XX-type SoCs.

The USB0 (USB 2.0) PHY clock is an interesting case because it calls
clk_enable() in a reentrant way. The USB 2.0 PSC only has to be enabled
temporarily while we are locking the PLL, which takes place during the
clk_enable() callback.

Signed-off-by: David Lechner <david@lechnology.com>
---

v7 changes:
- convert to platform device
- rename clk local variable to usb0/usb1
- put code in da8xx-cfgchip.c instead of creating a new file

v6 changes:
- rename clocks to usb{0,1}_clk48
- rename USB 2.0 PSC clock to "fck"
- simplify {s,g}et_parent implementations
- use pr_fmt macro


 drivers/clk/davinci/da8xx-cfgchip.c | 351 ++++++++++++++++++++++++++++++++++++
 1 file changed, 351 insertions(+)

diff --git a/drivers/clk/davinci/da8xx-cfgchip.c b/drivers/clk/davinci/da8xx-cfgchip.c
index 386da99..7d5cf16 100644
--- a/drivers/clk/davinci/da8xx-cfgchip.c
+++ b/drivers/clk/davinci/da8xx-cfgchip.c
@@ -339,6 +339,349 @@ static int __init of_da850_async3_init(struct device *dev, struct regmap *regmap
 	return of_da8xx_cfgchip_init_mux_clock(dev, &da850_async3_info, regmap);
 }
 
+/* --- USB 2.0 PHY clock --- */
+
+struct da8xx_usb0_clk48 {
+	struct clk_hw hw;
+	struct clk *fck;
+	struct regmap *regmap;
+};
+
+#define to_da8xx_usb0_clk48(_hw) \
+	container_of((_hw), struct da8xx_usb0_clk48, hw)
+
+static int da8xx_usb0_clk48_prepare(struct clk_hw *hw)
+{
+	struct da8xx_usb0_clk48 *usb0 = to_da8xx_usb0_clk48(hw);
+
+	/* The USB 2.0 PSC clock is only needed temporarily during the USB 2.0
+	 * PHY clock enable, but since clk_prepare() can't be called in an
+	 * atomic context (i.e. in clk_enable()), we have to prepare it here.
+	 */
+	return clk_prepare(usb0->fck);
+}
+
+static void da8xx_usb0_clk48_unprepare(struct clk_hw *hw)
+{
+	struct da8xx_usb0_clk48 *usb0 = to_da8xx_usb0_clk48(hw);
+
+	clk_unprepare(usb0->fck);
+}
+
+static int da8xx_usb0_clk48_enable(struct clk_hw *hw)
+{
+	struct da8xx_usb0_clk48 *usb0 = to_da8xx_usb0_clk48(hw);
+	unsigned int mask, val;
+	int ret;
+
+	/* Locking the USB 2.O PLL requires that the USB 2.O PSC is enabled
+	 * temporaily. It can be turned back off once the PLL is locked.
+	 */
+	clk_enable(usb0->fck);
+
+	/* Turn on the USB 2.0 PHY, but just the PLL, and not OTG. The USB 1.1
+	 * PHY may use the USB 2.0 PLL clock without USB 2.0 OTG being used.
+	 */
+	mask = CFGCHIP2_RESET | CFGCHIP2_PHYPWRDN | CFGCHIP2_PHY_PLLON;
+	val = CFGCHIP2_PHY_PLLON;
+
+	regmap_write_bits(usb0->regmap, CFGCHIP(2), mask, val);
+	ret = regmap_read_poll_timeout(usb0->regmap, CFGCHIP(2), val,
+				       val & CFGCHIP2_PHYCLKGD, 0, 500000);
+
+	clk_disable(usb0->fck);
+
+	return ret;
+}
+
+static void da8xx_usb0_clk48_disable(struct clk_hw *hw)
+{
+	struct da8xx_usb0_clk48 *usb0 = to_da8xx_usb0_clk48(hw);
+	unsigned int val;
+
+	val = CFGCHIP2_PHYPWRDN;
+	regmap_write_bits(usb0->regmap, CFGCHIP(2), val, val);
+}
+
+static int da8xx_usb0_clk48_is_enabled(struct clk_hw *hw)
+{
+	struct da8xx_usb0_clk48 *usb0 = to_da8xx_usb0_clk48(hw);
+	unsigned int val;
+
+	regmap_read(usb0->regmap, CFGCHIP(2), &val);
+
+	return !!(val & CFGCHIP2_PHYCLKGD);
+}
+
+static unsigned long da8xx_usb0_clk48_recalc_rate(struct clk_hw *hw,
+						  unsigned long parent_rate)
+{
+	struct da8xx_usb0_clk48 *usb0 = to_da8xx_usb0_clk48(hw);
+	unsigned int mask, val;
+
+	/* The parent clock rate must be one of the following */
+	mask = CFGCHIP2_REFFREQ_MASK;
+	switch (parent_rate) {
+	case 12000000:
+		val = CFGCHIP2_REFFREQ_12MHZ;
+		break;
+	case 13000000:
+		val = CFGCHIP2_REFFREQ_13MHZ;
+		break;
+	case 19200000:
+		val = CFGCHIP2_REFFREQ_19_2MHZ;
+		break;
+	case 20000000:
+		val = CFGCHIP2_REFFREQ_20MHZ;
+		break;
+	case 24000000:
+		val = CFGCHIP2_REFFREQ_24MHZ;
+		break;
+	case 26000000:
+		val = CFGCHIP2_REFFREQ_26MHZ;
+		break;
+	case 38400000:
+		val = CFGCHIP2_REFFREQ_38_4MHZ;
+		break;
+	case 40000000:
+		val = CFGCHIP2_REFFREQ_40MHZ;
+		break;
+	case 48000000:
+		val = CFGCHIP2_REFFREQ_48MHZ;
+		break;
+	default:
+		return 0;
+	}
+
+	regmap_write_bits(usb0->regmap, CFGCHIP(2), mask, val);
+
+	/* USB 2.0 PLL always supplies 48MHz */
+	return 48000000;
+}
+
+static long da8xx_usb0_clk48_round_rate(struct clk_hw *hw, unsigned long rate,
+					unsigned long *parent_rate)
+{
+	return 48000000;
+}
+
+static int da8xx_usb0_clk48_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct da8xx_usb0_clk48 *usb0 = to_da8xx_usb0_clk48(hw);
+
+	return regmap_write_bits(usb0->regmap, CFGCHIP(2),
+				 CFGCHIP2_USB2PHYCLKMUX,
+				 index ? CFGCHIP2_USB2PHYCLKMUX : 0);
+}
+
+static u8 da8xx_usb0_clk48_get_parent(struct clk_hw *hw)
+{
+	struct da8xx_usb0_clk48 *usb0 = to_da8xx_usb0_clk48(hw);
+	unsigned int val;
+
+	regmap_read(usb0->regmap, CFGCHIP(2), &val);
+
+	return (val & CFGCHIP2_USB2PHYCLKMUX) ? 1 : 0;
+}
+
+static const struct clk_ops da8xx_usb0_clk48_ops = {
+	.prepare	= da8xx_usb0_clk48_prepare,
+	.unprepare	= da8xx_usb0_clk48_unprepare,
+	.enable		= da8xx_usb0_clk48_enable,
+	.disable	= da8xx_usb0_clk48_disable,
+	.is_enabled	= da8xx_usb0_clk48_is_enabled,
+	.recalc_rate	= da8xx_usb0_clk48_recalc_rate,
+	.round_rate	= da8xx_usb0_clk48_round_rate,
+	.set_parent	= da8xx_usb0_clk48_set_parent,
+	.get_parent	= da8xx_usb0_clk48_get_parent,
+};
+
+static struct da8xx_usb0_clk48 *
+da8xx_cfgchip_register_usb0_clk48(struct device *dev,
+				  struct regmap *regmap)
+{
+	const char * const parent_names[] = { "usb_refclkin", "pll0_auxclk" };
+	struct clk *fck_clk;
+	struct da8xx_usb0_clk48 *usb0;
+	struct clk_init_data init;
+	int ret;
+
+	fck_clk = devm_clk_get(dev, "fck");
+	if (IS_ERR(fck_clk)) {
+		if (PTR_ERR(fck_clk) != -EPROBE_DEFER)
+			dev_err(dev, "Missing fck clock\n");
+		return ERR_CAST(fck_clk);
+	}
+
+	usb0 = devm_kzalloc(dev, sizeof(*usb0), GFP_KERNEL);
+	if (!usb0)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = "usb0_clk48";
+	init.ops = &da8xx_usb0_clk48_ops;
+	init.parent_names = parent_names;
+	init.num_parents = 2;
+
+	usb0->hw.init = &init;
+	usb0->fck = fck_clk;
+	usb0->regmap = regmap;
+
+	ret = devm_clk_hw_register(dev, &usb0->hw);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	return usb0;
+}
+
+/* --- USB 1.1 PHY clock --- */
+
+struct da8xx_usb1_clk48 {
+	struct clk_hw hw;
+	struct regmap *regmap;
+};
+
+#define to_da8xx_usb1_clk48(_hw) \
+	container_of((_hw), struct da8xx_usb1_clk48, hw)
+
+static int da8xx_usb1_clk48_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct da8xx_usb1_clk48 *usb1 = to_da8xx_usb1_clk48(hw);
+
+	return regmap_write_bits(usb1->regmap, CFGCHIP(2),
+				 CFGCHIP2_USB1PHYCLKMUX,
+				 index ? CFGCHIP2_USB1PHYCLKMUX : 0);
+}
+
+static u8 da8xx_usb1_clk48_get_parent(struct clk_hw *hw)
+{
+	struct da8xx_usb1_clk48 *usb1 = to_da8xx_usb1_clk48(hw);
+	unsigned int val;
+
+	regmap_read(usb1->regmap, CFGCHIP(2), &val);
+
+	return (val & CFGCHIP2_USB1PHYCLKMUX) ? 1 : 0;
+}
+
+static const struct clk_ops da8xx_usb1_clk48_ops = {
+	.set_parent	= da8xx_usb1_clk48_set_parent,
+	.get_parent	= da8xx_usb1_clk48_get_parent,
+};
+
+/**
+ * da8xx_cfgchip_register_usb1_clk48 - Register a new USB 1.1 PHY clock
+ * @regmap: The CFGCHIP regmap
+ */
+static struct da8xx_usb1_clk48 *
+da8xx_cfgchip_register_usb1_clk48(struct device *dev,
+				  struct regmap *regmap)
+{
+	const char * const parent_names[] = { "usb0_clk48", "usb_refclkin" };
+	struct da8xx_usb1_clk48 *usb1;
+	struct clk_init_data init;
+	int ret;
+
+	usb1 = devm_kzalloc(dev, sizeof(*usb1), GFP_KERNEL);
+	if (!usb1)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = "usb1_clk48";
+	init.ops = &da8xx_usb1_clk48_ops;
+	init.parent_names = parent_names;
+	init.num_parents = 2;
+
+	usb1->hw.init = &init;
+	usb1->regmap = regmap;
+
+	ret = devm_clk_hw_register(dev, &usb1->hw);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	return usb1;
+}
+
+static int da8xx_cfgchip_register_usb_phy_clk(struct device *dev,
+					      struct regmap *regmap)
+{
+	struct da8xx_usb0_clk48 *usb0;
+	struct da8xx_usb1_clk48 *usb1;
+	struct clk_hw *parent;
+
+	usb0 = da8xx_cfgchip_register_usb0_clk48(dev, regmap);
+	if (IS_ERR(usb0))
+		return PTR_ERR(usb0);
+
+	/*
+	 * All existing boards use pll0_auxclk as the parent and new boards
+	 * should use device tree, so hard-coding the value (1) here.
+	 */
+	parent = clk_hw_get_parent_by_index(&usb0->hw, 1);
+	if (parent)
+		clk_set_parent(usb0->hw.clk, parent->clk);
+	else
+		dev_warn(dev, "Failed to find usb0 parent clock\n");
+
+	usb1 = da8xx_cfgchip_register_usb1_clk48(dev, regmap);
+	if (IS_ERR(usb1))
+		return PTR_ERR(usb1);
+
+	/*
+	 * All existing boards use usb0_clk48 as the parent and new boards
+	 * should use device tree, so hard-coding the value (0) here.
+	 */
+	parent = clk_hw_get_parent_by_index(&usb1->hw, 0);
+	if (parent)
+		clk_set_parent(usb1->hw.clk, parent->clk);
+	else
+		dev_warn(dev, "Failed to find usb1 parent clock\n");
+
+	clk_hw_register_clkdev(&usb0->hw, "usb0_clk48", "da8xx-usb-phy");
+	clk_hw_register_clkdev(&usb1->hw, "usb1_clk48", "da8xx-usb-phy");
+
+	return 0;
+}
+
+static int of_da8xx_usb_phy_clk_init(struct device *dev, struct regmap *regmap)
+{
+	struct clk_hw_onecell_data *clk_data;
+	struct da8xx_usb0_clk48 *usb0;
+	struct da8xx_usb1_clk48 *usb1;
+
+	clk_data = devm_kzalloc(dev, sizeof(*clk_data) + 2 *
+				sizeof(*clk_data->hws), GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+
+	clk_data->num = 2;
+
+	usb0 = da8xx_cfgchip_register_usb0_clk48(dev, regmap);
+	if (IS_ERR(usb0)) {
+		if (PTR_ERR(usb0) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		dev_warn(dev, "Failed to register usb0_clk48 (%ld)\n",
+			 PTR_ERR(usb0));
+
+		clk_data->hws[0] = ERR_PTR(-ENOENT);
+	} else {
+		clk_data->hws[0] = &usb0->hw;
+	}
+
+	usb1 = da8xx_cfgchip_register_usb1_clk48(dev, regmap);
+	if (IS_ERR(usb1)) {
+		if (PTR_ERR(usb0) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		dev_warn(dev, "Failed to register usb1_clk48 (%ld)\n",
+			 PTR_ERR(usb1));
+
+		clk_data->hws[1] = ERR_PTR(-ENOENT);
+	} else {
+		clk_data->hws[1] = &usb1->hw;
+	}
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_data);
+}
+
 /* --- platform device --- */
 
 static const struct of_device_id da8xx_cfgchip_of_match[] = {
@@ -358,6 +701,10 @@ static const struct of_device_id da8xx_cfgchip_of_match[] = {
 		.compatible = "ti,da850-async3-clksrc",
 		.data = of_da850_async3_init,
 	},
+	{
+		.compatible = "ti,da830-usb-phy-clocks",
+		.data = of_da8xx_usb_phy_clk_init,
+	},
 	{ }
 };
 
@@ -378,6 +725,10 @@ static const struct platform_device_id da8xx_cfgchip_id_table[] = {
 		.name = "da850-async3-clksrc",
 		.driver_data = (kernel_ulong_t)da850_cfgchip_register_async3,
 	},
+	{
+		.name = "da830-usb-phy-clks",
+		.driver_data = (kernel_ulong_t)da8xx_cfgchip_register_usb_phy_clk,
+	},
 	{ }
 };
 
-- 
2.7.4
