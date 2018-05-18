Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbeERQuX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:50:23 -0400
Received: from vern.gendns.com ([206.190.152.46]:56743 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751221AbeERQuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:50:09 -0400
From: David Lechner <david@lechnology.com>
To: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v11 01/27] clk: davinci: pll: allow dev == NULL
Date: Fri, 18 May 2018 11:48:03 -0500
Message-Id: <20180518164829.27052-2-david@lechnology.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518164829.27052-1-david@lechnology.com>
References: <20180518164829.27052-1-david@lechnology.com>
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

This modifies the TI Davinci PLL clock driver to allow for the case
when dev == NULL. On some (most) SoCs that use this driver, the PLL
clock needs to be registered during early boot because it is used
for clocksource/clkevent and there will be no platform device available.

Some function declarations are moved to a public header files so that they can
be called from mach init code.

Also fix some missing @dev doc comments that would have been touched in this
patch anyway.

Signed-off-by: David Lechner <david@lechnology.com>
---

v11 changes:
- proper unwinding on errors
- add #include <linux/clk/davinci.h> to avoid W=1 warnings
- fix more @dev in doc comments to avoid sparse warning

v10 changes:
- dropped helper functions that called devm_* versions of functions.
- removed duplicate function declarations from pll.h

v9 changes:
- new patch in v9


 drivers/clk/davinci/pll-da830.c  |   5 +-
 drivers/clk/davinci/pll-da850.c  |  22 +--
 drivers/clk/davinci/pll-dm355.c  |   9 +-
 drivers/clk/davinci/pll-dm365.c  |   9 +-
 drivers/clk/davinci/pll-dm644x.c |   9 +-
 drivers/clk/davinci/pll-dm646x.c |   9 +-
 drivers/clk/davinci/pll.c        | 275 +++++++++++++++++++++----------
 drivers/clk/davinci/pll.h        |  30 ++--
 include/linux/clk/davinci.h      |  24 +++
 9 files changed, 256 insertions(+), 136 deletions(-)
 create mode 100644 include/linux/clk/davinci.h

diff --git a/drivers/clk/davinci/pll-da830.c b/drivers/clk/davinci/pll-da830.c
index 929a3d3a9adb..0a0d06fb25fd 100644
--- a/drivers/clk/davinci/pll-da830.c
+++ b/drivers/clk/davinci/pll-da830.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/clkdev.h>
+#include <linux/clk/davinci.h>
 #include <linux/bitops.h>
 #include <linux/init.h>
 #include <linux/types.h>
@@ -36,11 +37,11 @@ SYSCLK(5, pll0_sysclk5, pll0_pllen, 5, 0);
 SYSCLK(6, pll0_sysclk6, pll0_pllen, 5, SYSCLK_FIXED_DIV);
 SYSCLK(7, pll0_sysclk7, pll0_pllen, 5, 0);
 
-int da830_pll_init(struct device *dev, void __iomem *base)
+int da830_pll_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
 {
 	struct clk *clk;
 
-	davinci_pll_clk_register(dev, &da830_pll_info, "ref_clk", base);
+	davinci_pll_clk_register(dev, &da830_pll_info, "ref_clk", base, cfgchip);
 
 	clk = davinci_pll_sysclk_register(dev, &pll0_sysclk2, base);
 	clk_register_clkdev(clk, "pll0_sysclk2", "da830-psc0");
diff --git a/drivers/clk/davinci/pll-da850.c b/drivers/clk/davinci/pll-da850.c
index 2a038b7908cc..59cc2e3733f9 100644
--- a/drivers/clk/davinci/pll-da850.c
+++ b/drivers/clk/davinci/pll-da850.c
@@ -7,7 +7,9 @@
 
 #include <linux/bitops.h>
 #include <linux/clk-provider.h>
+#include <linux/clk/davinci.h>
 #include <linux/clkdev.h>
+#include <linux/device.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/mfd/da8xx-cfgchip.h>
@@ -81,11 +83,11 @@ static const struct davinci_pll_obsclk_info da850_pll0_obsclk_info = {
 	.ocsrc_mask = GENMASK(4, 0),
 };
 
-int da850_pll0_init(struct device *dev, void __iomem *base)
+int da850_pll0_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
 {
 	struct clk *clk;
 
-	davinci_pll_clk_register(dev, &da850_pll0_info, "ref_clk", base);
+	davinci_pll_clk_register(dev, &da850_pll0_info, "ref_clk", base, cfgchip);
 
 	clk = davinci_pll_sysclk_register(dev, &pll0_sysclk1, base);
 	clk_register_clkdev(clk, "pll0_sysclk1", "da850-psc0");
@@ -134,11 +136,11 @@ static const struct davinci_pll_sysclk_info *da850_pll0_sysclk_info[] = {
 	NULL
 };
 
-int of_da850_pll0_init(struct device *dev, void __iomem *base)
+int of_da850_pll0_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
 {
-	return of_davinci_pll_init(dev, &da850_pll0_info,
+	return of_davinci_pll_init(dev, dev->of_node, &da850_pll0_info,
 				   &da850_pll0_obsclk_info,
-				   da850_pll0_sysclk_info, 7, base);
+				   da850_pll0_sysclk_info, 7, base, cfgchip);
 }
 
 static const struct davinci_pll_clk_info da850_pll1_info = {
@@ -179,11 +181,11 @@ static const struct davinci_pll_obsclk_info da850_pll1_obsclk_info = {
 	.ocsrc_mask = GENMASK(4, 0),
 };
 
-int da850_pll1_init(struct device *dev, void __iomem *base)
+int da850_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
 {
 	struct clk *clk;
 
-	davinci_pll_clk_register(dev, &da850_pll1_info, "oscin", base);
+	davinci_pll_clk_register(dev, &da850_pll1_info, "oscin", base, cfgchip);
 
 	davinci_pll_sysclk_register(dev, &pll1_sysclk1, base);
 
@@ -204,9 +206,9 @@ static const struct davinci_pll_sysclk_info *da850_pll1_sysclk_info[] = {
 	NULL
 };
 
-int of_da850_pll1_init(struct device *dev, void __iomem *base)
+int of_da850_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
 {
-	return of_davinci_pll_init(dev, &da850_pll1_info,
+	return of_davinci_pll_init(dev, dev->of_node, &da850_pll1_info,
 				   &da850_pll1_obsclk_info,
-				   da850_pll1_sysclk_info, 3, base);
+				   da850_pll1_sysclk_info, 3, base, cfgchip);
 }
diff --git a/drivers/clk/davinci/pll-dm355.c b/drivers/clk/davinci/pll-dm355.c
index 93f4a53d6b44..505aed80be9a 100644
--- a/drivers/clk/davinci/pll-dm355.c
+++ b/drivers/clk/davinci/pll-dm355.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/clk/davinci.h>
 #include <linux/clkdev.h>
 #include <linux/init.h>
 #include <linux/types.h>
@@ -27,11 +28,11 @@ SYSCLK(2, pll1_sysclk2, pll1_pllen, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED)
 SYSCLK(3, pll1_sysclk3, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED);
 SYSCLK(4, pll1_sysclk4, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED);
 
-int dm355_pll1_init(struct device *dev, void __iomem *base)
+int dm355_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
 {
 	struct clk *clk;
 
-	davinci_pll_clk_register(dev, &dm355_pll1_info, "ref_clk", base);
+	davinci_pll_clk_register(dev, &dm355_pll1_info, "ref_clk", base, cfgchip);
 
 	clk = davinci_pll_sysclk_register(dev, &pll1_sysclk1, base);
 	clk_register_clkdev(clk, "pll1_sysclk1", "dm355-psc");
@@ -64,9 +65,9 @@ static const struct davinci_pll_clk_info dm355_pll2_info = {
 
 SYSCLK(1, pll2_sysclk1, pll2_pllen, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
 
-int dm355_pll2_init(struct device *dev, void __iomem *base)
+int dm355_pll2_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
 {
-	davinci_pll_clk_register(dev, &dm355_pll2_info, "oscin", base);
+	davinci_pll_clk_register(dev, &dm355_pll2_info, "oscin", base, cfgchip);
 
 	davinci_pll_sysclk_register(dev, &pll2_sysclk1, base);
 
diff --git a/drivers/clk/davinci/pll-dm365.c b/drivers/clk/davinci/pll-dm365.c
index 5f8d9f42d0f3..2d29712753a3 100644
--- a/drivers/clk/davinci/pll-dm365.c
+++ b/drivers/clk/davinci/pll-dm365.c
@@ -7,6 +7,7 @@
 
 #include <linux/bitops.h>
 #include <linux/clkdev.h>
+#include <linux/clk/davinci.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
@@ -56,11 +57,11 @@ static const struct davinci_pll_obsclk_info dm365_pll1_obsclk_info = {
 	.ocsrc_mask = BIT(4),
 };
 
-int dm365_pll1_init(struct device *dev, void __iomem *base)
+int dm365_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
 {
 	struct clk *clk;
 
-	davinci_pll_clk_register(dev, &dm365_pll1_info, "ref_clk", base);
+	davinci_pll_clk_register(dev, &dm365_pll1_info, "ref_clk", base, cfgchip);
 
 	clk = davinci_pll_sysclk_register(dev, &pll1_sysclk1, base);
 	clk_register_clkdev(clk, "pll1_sysclk1", "dm365-psc");
@@ -119,11 +120,11 @@ static const struct davinci_pll_obsclk_info dm365_pll2_obsclk_info = {
 	.ocsrc_mask = BIT(4),
 };
 
-int dm365_pll2_init(struct device *dev, void __iomem *base)
+int dm365_pll2_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
 {
 	struct clk *clk;
 
-	davinci_pll_clk_register(dev, &dm365_pll2_info, "oscin", base);
+	davinci_pll_clk_register(dev, &dm365_pll2_info, "oscin", base, cfgchip);
 
 	davinci_pll_sysclk_register(dev, &pll2_sysclk1, base);
 
diff --git a/drivers/clk/davinci/pll-dm644x.c b/drivers/clk/davinci/pll-dm644x.c
index 69bf785377cf..7650fadfaac8 100644
--- a/drivers/clk/davinci/pll-dm644x.c
+++ b/drivers/clk/davinci/pll-dm644x.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/clk/davinci.h>
 #include <linux/clkdev.h>
 #include <linux/init.h>
 #include <linux/types.h>
@@ -27,11 +28,11 @@ SYSCLK(2, pll1_sysclk2, pll1_pllen, 4, SYSCLK_FIXED_DIV);
 SYSCLK(3, pll1_sysclk3, pll1_pllen, 4, SYSCLK_FIXED_DIV);
 SYSCLK(5, pll1_sysclk5, pll1_pllen, 4, SYSCLK_FIXED_DIV);
 
-int dm644x_pll1_init(struct device *dev, void __iomem *base)
+int dm644x_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
 {
 	struct clk *clk;
 
-	davinci_pll_clk_register(dev, &dm644x_pll1_info, "ref_clk", base);
+	davinci_pll_clk_register(dev, &dm644x_pll1_info, "ref_clk", base, cfgchip);
 
 	clk = davinci_pll_sysclk_register(dev, &pll1_sysclk1, base);
 	clk_register_clkdev(clk, "pll1_sysclk1", "dm644x-psc");
@@ -66,9 +67,9 @@ static const struct davinci_pll_clk_info dm644x_pll2_info = {
 SYSCLK(1, pll2_sysclk1, pll2_pllen, 4, 0);
 SYSCLK(2, pll2_sysclk2, pll2_pllen, 4, 0);
 
-int dm644x_pll2_init(struct device *dev, void __iomem *base)
+int dm644x_pll2_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
 {
-	davinci_pll_clk_register(dev, &dm644x_pll2_info, "oscin", base);
+	davinci_pll_clk_register(dev, &dm644x_pll2_info, "oscin", base, cfgchip);
 
 	davinci_pll_sysclk_register(dev, &pll2_sysclk1, base);
 
diff --git a/drivers/clk/davinci/pll-dm646x.c b/drivers/clk/davinci/pll-dm646x.c
index 0ae827e3ce80..26982970df0e 100644
--- a/drivers/clk/davinci/pll-dm646x.c
+++ b/drivers/clk/davinci/pll-dm646x.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/clk/davinci.h>
 #include <linux/clkdev.h>
 #include <linux/init.h>
 #include <linux/types.h>
@@ -29,11 +30,11 @@ SYSCLK(6, pll1_sysclk6, pll1_pllen, 4, 0);
 SYSCLK(8, pll1_sysclk8, pll1_pllen, 4, 0);
 SYSCLK(9, pll1_sysclk9, pll1_pllen, 4, 0);
 
-int dm646x_pll1_init(struct device *dev, void __iomem *base)
+int dm646x_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
 {
 	struct clk *clk;
 
-	davinci_pll_clk_register(dev, &dm646x_pll1_info, "ref_clk", base);
+	davinci_pll_clk_register(dev, &dm646x_pll1_info, "ref_clk", base, cfgchip);
 
 	clk = davinci_pll_sysclk_register(dev, &pll1_sysclk1, base);
 	clk_register_clkdev(clk, "pll1_sysclk1", "dm646x-psc");
@@ -74,9 +75,9 @@ static const struct davinci_pll_clk_info dm646x_pll2_info = {
 
 SYSCLK(1, pll2_sysclk1, pll2_pllen, 4, SYSCLK_ALWAYS_ENABLED);
 
-int dm646x_pll2_init(struct device *dev, void __iomem *base)
+int dm646x_pll2_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
 {
-	davinci_pll_clk_register(dev, &dm646x_pll2_info, "oscin", base);
+	davinci_pll_clk_register(dev, &dm646x_pll2_info, "oscin", base, cfgchip);
 
 	davinci_pll_sysclk_register(dev, &pll2_sysclk1, base);
 
diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
index 23a24c944f1d..ae5f966b503f 100644
--- a/drivers/clk/davinci/pll.c
+++ b/drivers/clk/davinci/pll.c
@@ -11,6 +11,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/clk.h>
+#include <linux/clk/davinci.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
@@ -223,6 +224,7 @@ static const struct clk_ops dm365_pll_ops = {
 
 /**
  * davinci_pll_div_register - common *DIV clock implementation
+ * @dev: The PLL platform device or NULL
  * @name: the clock name
  * @parent_name: the parent clock name
  * @reg: the *DIV register
@@ -240,17 +242,21 @@ static struct clk *davinci_pll_div_register(struct device *dev,
 	const struct clk_ops *divider_ops = &clk_divider_ops;
 	struct clk_gate *gate;
 	struct clk_divider *divider;
+	struct clk *clk;
+	int ret;
 
-	gate = devm_kzalloc(dev, sizeof(*gate), GFP_KERNEL);
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
 	if (!gate)
 		return ERR_PTR(-ENOMEM);
 
 	gate->reg = reg;
 	gate->bit_idx = DIV_ENABLE_SHIFT;
 
-	divider = devm_kzalloc(dev, sizeof(*divider), GFP_KERNEL);
-	if (!divider)
-		return ERR_PTR(-ENOMEM);
+	divider = kzalloc(sizeof(*divider), GFP_KERNEL);
+	if (!divider) {
+		ret = -ENOMEM;
+		goto err_free_gate;
+	}
 
 	divider->reg = reg;
 	divider->shift = DIV_RATIO_SHIFT;
@@ -261,9 +267,22 @@ static struct clk *davinci_pll_div_register(struct device *dev,
 		divider_ops = &clk_divider_ro_ops;
 	}
 
-	return clk_register_composite(dev, name, parent_names, num_parents,
-				      NULL, NULL, &divider->hw, divider_ops,
-				      &gate->hw, &clk_gate_ops, flags);
+	clk = clk_register_composite(dev, name, parent_names, num_parents,
+				     NULL, NULL, &divider->hw, divider_ops,
+				     &gate->hw, &clk_gate_ops, flags);
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		goto err_free_divider;
+	}
+
+	return clk;
+
+err_free_divider:
+	kfree(divider);
+err_free_gate:
+	kfree(gate);
+
+	return ERR_PTR(ret);
 }
 
 struct davinci_pllen_clk {
@@ -321,36 +340,17 @@ static int davinci_pllen_rate_change(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-static struct davinci_pll_platform_data *davinci_pll_get_pdata(struct device *dev)
-{
-	struct davinci_pll_platform_data *pdata = dev_get_platdata(dev);
-
-	/*
-	 * Platform data is optional, so allocate a new struct if one was not
-	 * provided. For device tree, this will always be the case.
-	 */
-	if (!pdata)
-		pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
-		return NULL;
-
-	/* for device tree, we need to fill in the struct */
-	if (dev->of_node)
-		pdata->cfgchip =
-			syscon_regmap_lookup_by_compatible("ti,da830-cfgchip");
-
-	return pdata;
-}
-
 static struct notifier_block davinci_pllen_notifier = {
 	.notifier_call = davinci_pllen_rate_change,
 };
 
 /**
  * davinci_pll_clk_register - Register a PLL clock
+ * @dev: The PLL platform device or NULL
  * @info: The device-specific clock info
  * @parent_name: The parent clock name
  * @base: The PLL's memory region
+ * @cfgchip: CFGCHIP syscon regmap for info->unlock_reg or NULL
  *
  * This creates a series of clocks that represent the PLL.
  *
@@ -366,9 +366,9 @@ static struct notifier_block davinci_pllen_notifier = {
 struct clk *davinci_pll_clk_register(struct device *dev,
 				     const struct davinci_pll_clk_info *info,
 				     const char *parent_name,
-				     void __iomem *base)
+				     void __iomem *base,
+				     struct regmap *cfgchip)
 {
-	struct davinci_pll_platform_data *pdata;
 	char prediv_name[MAX_NAME_SIZE];
 	char pllout_name[MAX_NAME_SIZE];
 	char postdiv_name[MAX_NAME_SIZE];
@@ -376,11 +376,12 @@ struct clk *davinci_pll_clk_register(struct device *dev,
 	struct clk_init_data init;
 	struct davinci_pll_clk *pllout;
 	struct davinci_pllen_clk *pllen;
-	struct clk *pllout_clk, *clk;
-
-	pdata = davinci_pll_get_pdata(dev);
-	if (!pdata)
-		return ERR_PTR(-ENOMEM);
+	struct clk *oscin_clk = NULL;
+	struct clk *prediv_clk = NULL;
+	struct clk *pllout_clk;
+	struct clk *postdiv_clk = NULL;
+	struct clk *pllen_clk;
+	int ret;
 
 	if (info->flags & PLL_HAS_CLKMODE) {
 		/*
@@ -392,10 +393,10 @@ struct clk *davinci_pll_clk_register(struct device *dev,
 		 * a number of different things. In this driver we use it to
 		 * mean the signal after the PLLCTL[CLKMODE] switch.
 		 */
-		clk = clk_register_fixed_factor(dev, OSCIN_CLK_NAME,
-						parent_name, 0, 1, 1);
-		if (IS_ERR(clk))
-			return clk;
+		oscin_clk = clk_register_fixed_factor(dev, OSCIN_CLK_NAME,
+						      parent_name, 0, 1, 1);
+		if (IS_ERR(oscin_clk))
+			return oscin_clk;
 
 		parent_name = OSCIN_CLK_NAME;
 	}
@@ -411,30 +412,34 @@ struct clk *davinci_pll_clk_register(struct device *dev,
 
 		/* Some? DM355 chips don't correctly report the PREDIV value */
 		if (info->flags & PLL_PREDIV_FIXED8)
-			clk = clk_register_fixed_factor(dev, prediv_name,
-						parent_name, flags, 1, 8);
+			prediv_clk = clk_register_fixed_factor(dev, prediv_name,
+							parent_name, flags, 1, 8);
 		else
-			clk = davinci_pll_div_register(dev, prediv_name,
+			prediv_clk = davinci_pll_div_register(dev, prediv_name,
 				parent_name, base + PREDIV, fixed, flags);
-		if (IS_ERR(clk))
-			return clk;
+		if (IS_ERR(prediv_clk)) {
+			ret = PTR_ERR(prediv_clk);
+			goto err_unregister_oscin;
+		}
 
 		parent_name = prediv_name;
 	}
 
 	/* Unlock writing to PLL registers */
 	if (info->unlock_reg) {
-		if (IS_ERR_OR_NULL(pdata->cfgchip))
+		if (IS_ERR_OR_NULL(cfgchip))
 			dev_warn(dev, "Failed to get CFGCHIP (%ld)\n",
-				 PTR_ERR(pdata->cfgchip));
+				 PTR_ERR(cfgchip));
 		else
-			regmap_write_bits(pdata->cfgchip, info->unlock_reg,
+			regmap_write_bits(cfgchip, info->unlock_reg,
 					  info->unlock_mask, 0);
 	}
 
-	pllout = devm_kzalloc(dev, sizeof(*pllout), GFP_KERNEL);
-	if (!pllout)
-		return ERR_PTR(-ENOMEM);
+	pllout = kzalloc(sizeof(*pllout), GFP_KERNEL);
+	if (!pllout) {
+		ret = -ENOMEM;
+		goto err_unregister_prediv;
+	}
 
 	snprintf(pllout_name, MAX_NAME_SIZE, "%s_pllout", info->name);
 
@@ -456,9 +461,11 @@ struct clk *davinci_pll_clk_register(struct device *dev,
 	pllout->pllm_min = info->pllm_min;
 	pllout->pllm_max = info->pllm_max;
 
-	pllout_clk = devm_clk_register(dev, &pllout->hw);
-	if (IS_ERR(pllout_clk))
-		return pllout_clk;
+	pllout_clk = clk_register(dev, &pllout->hw);
+	if (IS_ERR(pllout_clk)) {
+		ret = PTR_ERR(pllout_clk);
+		goto err_free_pllout;
+	}
 
 	clk_hw_set_rate_range(&pllout->hw, info->pllout_min_rate,
 			      info->pllout_max_rate);
@@ -474,17 +481,21 @@ struct clk *davinci_pll_clk_register(struct device *dev,
 		if (info->flags & PLL_POSTDIV_ALWAYS_ENABLED)
 			flags |= CLK_IS_CRITICAL;
 
-		clk = davinci_pll_div_register(dev, postdiv_name, parent_name,
-					       base + POSTDIV, fixed, flags);
-		if (IS_ERR(clk))
-			return clk;
+		postdiv_clk = davinci_pll_div_register(dev, postdiv_name,
+				parent_name, base + POSTDIV, fixed, flags);
+		if (IS_ERR(postdiv_clk)) {
+			ret = PTR_ERR(postdiv_clk);
+			goto err_unregister_pllout;
+		}
 
 		parent_name = postdiv_name;
 	}
 
-	pllen = devm_kzalloc(dev, sizeof(*pllout), GFP_KERNEL);
-	if (!pllen)
-		return ERR_PTR(-ENOMEM);
+	pllen = kzalloc(sizeof(*pllout), GFP_KERNEL);
+	if (!pllen) {
+		ret = -ENOMEM;
+		goto err_unregister_postdiv;
+	}
 
 	snprintf(pllen_name, MAX_NAME_SIZE, "%s_pllen", info->name);
 
@@ -497,17 +508,35 @@ struct clk *davinci_pll_clk_register(struct device *dev,
 	pllen->hw.init = &init;
 	pllen->base = base;
 
-	clk = devm_clk_register(dev, &pllen->hw);
-	if (IS_ERR(clk))
-		return clk;
+	pllen_clk = clk_register(dev, &pllen->hw);
+	if (IS_ERR(pllen_clk)) {
+		ret = PTR_ERR(pllen_clk);
+		goto err_free_pllen;
+	}
 
-	clk_notifier_register(clk, &davinci_pllen_notifier);
+	clk_notifier_register(pllen_clk, &davinci_pllen_notifier);
 
 	return pllout_clk;
+
+err_free_pllen:
+	kfree(pllen);
+err_unregister_postdiv:
+	clk_unregister(postdiv_clk);
+err_unregister_pllout:
+	clk_unregister(pllout_clk);
+err_free_pllout:
+	kfree(pllout);
+err_unregister_prediv:
+	clk_unregister(prediv_clk);
+err_unregister_oscin:
+	clk_unregister(oscin_clk);
+
+	return ERR_PTR(ret);
 }
 
 /**
  * davinci_pll_auxclk_register - Register bypass clock (AUXCLK)
+ * @dev: The PLL platform device or NULL
  * @name: The clock name
  * @base: The PLL memory region
  */
@@ -521,6 +550,7 @@ struct clk *davinci_pll_auxclk_register(struct device *dev,
 
 /**
  * davinci_pll_sysclkbp_clk_register - Register bypass divider clock (SYSCLKBP)
+ * @dev: The PLL platform device or NULL
  * @name: The clock name
  * @base: The PLL memory region
  */
@@ -535,6 +565,7 @@ struct clk *davinci_pll_sysclkbp_clk_register(struct device *dev,
 
 /**
  * davinci_pll_obsclk_register - Register oscillator divider clock (OBSCLK)
+ * @dev: The PLL platform device or NULL
  * @info: The clock info
  * @base: The PLL memory region
  */
@@ -546,9 +577,11 @@ davinci_pll_obsclk_register(struct device *dev,
 	struct clk_mux *mux;
 	struct clk_gate *gate;
 	struct clk_divider *divider;
+	struct clk *clk;
 	u32 oscdiv;
+	int ret;
 
-	mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
 	if (!mux)
 		return ERR_PTR(-ENOMEM);
 
@@ -556,16 +589,20 @@ davinci_pll_obsclk_register(struct device *dev,
 	mux->table = info->table;
 	mux->mask = info->ocsrc_mask;
 
-	gate = devm_kzalloc(dev, sizeof(*gate), GFP_KERNEL);
-	if (!gate)
-		return ERR_PTR(-ENOMEM);
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate) {
+		ret = -ENOMEM;
+		goto err_free_mux;
+	}
 
 	gate->reg = base + CKEN;
 	gate->bit_idx = CKEN_OBSCLK_SHIFT;
 
-	divider = devm_kzalloc(dev, sizeof(*divider), GFP_KERNEL);
-	if (!divider)
-		return ERR_PTR(-ENOMEM);
+	divider = kzalloc(sizeof(*divider), GFP_KERNEL);
+	if (!divider) {
+		ret = -ENOMEM;
+		goto err_free_gate;
+	}
 
 	divider->reg = base + OSCDIV;
 	divider->shift = DIV_RATIO_SHIFT;
@@ -576,11 +613,27 @@ davinci_pll_obsclk_register(struct device *dev,
 	oscdiv |= BIT(DIV_ENABLE_SHIFT);
 	writel(oscdiv, base + OSCDIV);
 
-	return clk_register_composite(dev, info->name, info->parent_names,
-				      info->num_parents,
-				      &mux->hw, &clk_mux_ops,
-				      &divider->hw, &clk_divider_ops,
-				      &gate->hw, &clk_gate_ops, 0);
+	clk = clk_register_composite(dev, info->name, info->parent_names,
+				     info->num_parents,
+				     &mux->hw, &clk_mux_ops,
+				     &divider->hw, &clk_divider_ops,
+				     &gate->hw, &clk_gate_ops, 0);
+
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		goto err_free_divider;
+	}
+
+	return clk;
+
+err_free_divider:
+	kfree(divider);
+err_free_gate:
+	kfree(gate);
+err_free_mux:
+	kfree(mux);
+
+	return ERR_PTR(ret);
 }
 
 /* The PLL SYSCLKn clocks have a mechanism for synchronizing rate changes. */
@@ -616,6 +669,7 @@ static struct notifier_block davinci_pll_sysclk_notifier = {
 
 /**
  * davinci_pll_sysclk_register - Register divider clocks (SYSCLKn)
+ * @dev: The PLL platform device or NULL
  * @info: The clock info
  * @base: The PLL memory region
  */
@@ -630,6 +684,7 @@ davinci_pll_sysclk_register(struct device *dev,
 	struct clk *clk;
 	u32 reg;
 	u32 flags = 0;
+	int ret;
 
 	/* PLLDIVn registers are not entirely consecutive */
 	if (info->id < 4)
@@ -637,16 +692,18 @@ davinci_pll_sysclk_register(struct device *dev,
 	else
 		reg = PLLDIV4 + 4 * (info->id - 4);
 
-	gate = devm_kzalloc(dev, sizeof(*gate), GFP_KERNEL);
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
 	if (!gate)
 		return ERR_PTR(-ENOMEM);
 
 	gate->reg = base + reg;
 	gate->bit_idx = DIV_ENABLE_SHIFT;
 
-	divider = devm_kzalloc(dev, sizeof(*divider), GFP_KERNEL);
-	if (!divider)
-		return ERR_PTR(-ENOMEM);
+	divider = kzalloc(sizeof(*divider), GFP_KERNEL);
+	if (!divider) {
+		ret = -ENOMEM;
+		goto err_free_gate;
+	}
 
 	divider->reg = base + reg;
 	divider->shift = DIV_RATIO_SHIFT;
@@ -668,22 +725,31 @@ davinci_pll_sysclk_register(struct device *dev,
 	clk = clk_register_composite(dev, info->name, &info->parent_name, 1,
 				     NULL, NULL, &divider->hw, divider_ops,
 				     &gate->hw, &clk_gate_ops, flags);
-	if (IS_ERR(clk))
-		return clk;
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		goto err_free_divider;
+	}
 
 	clk_notifier_register(clk, &davinci_pll_sysclk_notifier);
 
 	return clk;
+
+err_free_divider:
+	kfree(divider);
+err_free_gate:
+	kfree(gate);
+
+	return ERR_PTR(ret);
 }
 
-int of_davinci_pll_init(struct device *dev,
+int of_davinci_pll_init(struct device *dev, struct device_node *node,
 			const struct davinci_pll_clk_info *info,
 			const struct davinci_pll_obsclk_info *obsclk_info,
 			const struct davinci_pll_sysclk_info **div_info,
 			u8 max_sysclk_id,
-			void __iomem *base)
+			void __iomem *base,
+			struct regmap *cfgchip)
 {
-	struct device_node *node = dev->of_node;
 	struct device_node *child;
 	const char *parent_name;
 	struct clk *clk;
@@ -693,7 +759,7 @@ int of_davinci_pll_init(struct device *dev,
 	else
 		parent_name = OSCIN_CLK_NAME;
 
-	clk = davinci_pll_clk_register(dev, info, parent_name, base);
+	clk = davinci_pll_clk_register(dev, info, parent_name, base, cfgchip);
 	if (IS_ERR(clk)) {
 		dev_err(dev, "failed to register %s\n", info->name);
 		return PTR_ERR(clk);
@@ -711,11 +777,11 @@ int of_davinci_pll_init(struct device *dev,
 		int n_clks =  max_sysclk_id + 1;
 		int i;
 
-		clk_data = devm_kzalloc(dev, sizeof(*clk_data), GFP_KERNEL);
+		clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
 		if (!clk_data)
 			return -ENOMEM;
 
-		clks = devm_kmalloc_array(dev, n_clks, sizeof(*clks), GFP_KERNEL);
+		clks = kmalloc_array(n_clks, sizeof(*clks), GFP_KERNEL);
 		if (!clks)
 			return -ENOMEM;
 
@@ -770,6 +836,27 @@ int of_davinci_pll_init(struct device *dev,
 	return 0;
 }
 
+static struct davinci_pll_platform_data *davinci_pll_get_pdata(struct device *dev)
+{
+	struct davinci_pll_platform_data *pdata = dev_get_platdata(dev);
+
+	/*
+	 * Platform data is optional, so allocate a new struct if one was not
+	 * provided. For device tree, this will always be the case.
+	 */
+	if (!pdata)
+		pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return NULL;
+
+	/* for device tree, we need to fill in the struct */
+	if (dev->of_node)
+		pdata->cfgchip =
+			syscon_regmap_lookup_by_compatible("ti,da830-cfgchip");
+
+	return pdata;
+}
+
 static const struct of_device_id davinci_pll_of_match[] = {
 	{ .compatible = "ti,da850-pll0", .data = of_da850_pll0_init },
 	{ .compatible = "ti,da850-pll1", .data = of_da850_pll1_init },
@@ -791,11 +878,13 @@ static const struct platform_device_id davinci_pll_id_table[] = {
 	{ }
 };
 
-typedef int (*davinci_pll_init)(struct device *dev, void __iomem *base);
+typedef int (*davinci_pll_init)(struct device *dev, void __iomem *base,
+				struct regmap *cfgchip);
 
 static int davinci_pll_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct davinci_pll_platform_data *pdata;
 	const struct of_device_id *of_id;
 	davinci_pll_init pll_init = NULL;
 	struct resource *res;
@@ -812,12 +901,18 @@ static int davinci_pll_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	pdata = davinci_pll_get_pdata(dev);
+	if (!pdata) {
+		dev_err(dev, "missing platform data\n");
+		return -EINVAL;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	return pll_init(dev, base);
+	return pll_init(dev, base, pdata->cfgchip);
 }
 
 static struct platform_driver davinci_pll_driver = {
diff --git a/drivers/clk/davinci/pll.h b/drivers/clk/davinci/pll.h
index b1b6fb23f972..562652fc0759 100644
--- a/drivers/clk/davinci/pll.h
+++ b/drivers/clk/davinci/pll.h
@@ -11,6 +11,7 @@
 #include <linux/bitops.h>
 #include <linux/clk-provider.h>
 #include <linux/of.h>
+#include <linux/regmap.h>
 #include <linux/types.h>
 
 #define PLL_HAS_CLKMODE			BIT(0) /* PLL has PLLCTL[CLKMODE] */
@@ -94,7 +95,8 @@ struct davinci_pll_obsclk_info {
 struct clk *davinci_pll_clk_register(struct device *dev,
 				     const struct davinci_pll_clk_info *info,
 				     const char *parent_name,
-				     void __iomem *base);
+				     void __iomem *base,
+				     struct regmap *cfgchip);
 struct clk *davinci_pll_auxclk_register(struct device *dev,
 					const char *name,
 					void __iomem *base);
@@ -110,32 +112,24 @@ davinci_pll_sysclk_register(struct device *dev,
 			    const struct davinci_pll_sysclk_info *info,
 			    void __iomem *base);
 
-int of_davinci_pll_init(struct device *dev,
+int of_davinci_pll_init(struct device *dev, struct device_node *node,
 			const struct davinci_pll_clk_info *info,
 			const struct davinci_pll_obsclk_info *obsclk_info,
 			const struct davinci_pll_sysclk_info **div_info,
 			u8 max_sysclk_id,
-			void __iomem *base);
+			void __iomem *base,
+			struct regmap *cfgchip);
 
 /* Platform-specific callbacks */
 
-int da830_pll_init(struct device *dev, void __iomem *base);
+int da850_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
+int of_da850_pll0_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
+int of_da850_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
 
-int da850_pll0_init(struct device *dev, void __iomem *base);
-int da850_pll1_init(struct device *dev, void __iomem *base);
-int of_da850_pll0_init(struct device *dev, void __iomem *base);
-int of_da850_pll1_init(struct device *dev, void __iomem *base);
+int dm355_pll2_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
 
-int dm355_pll1_init(struct device *dev, void __iomem *base);
-int dm355_pll2_init(struct device *dev, void __iomem *base);
+int dm644x_pll2_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
 
-int dm365_pll1_init(struct device *dev, void __iomem *base);
-int dm365_pll2_init(struct device *dev, void __iomem *base);
-
-int dm644x_pll1_init(struct device *dev, void __iomem *base);
-int dm644x_pll2_init(struct device *dev, void __iomem *base);
-
-int dm646x_pll1_init(struct device *dev, void __iomem *base);
-int dm646x_pll2_init(struct device *dev, void __iomem *base);
+int dm646x_pll2_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
 
 #endif /* __CLK_DAVINCI_PLL_H___ */
diff --git a/include/linux/clk/davinci.h b/include/linux/clk/davinci.h
new file mode 100644
index 000000000000..ebdd9df1c0ef
--- /dev/null
+++ b/include/linux/clk/davinci.h
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Clock drivers for TI DaVinci PLL and PSC controllers
+ *
+ * Copyright (C) 2018 David Lechner <david@lechnology.com>
+ */
+
+#ifndef __LINUX_CLK_DAVINCI_PLL_H___
+#define __LINUX_CLK_DAVINCI_PLL_H___
+
+#include <linux/device.h>
+#include <linux/regmap.h>
+
+/* function for registering clocks in early boot */
+
+int da830_pll_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
+int da850_pll0_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
+int dm355_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
+int dm365_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
+int dm365_pll2_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
+int dm644x_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
+int dm646x_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
+
+#endif /* __LINUX_CLK_DAVINCI_PLL_H___ */
-- 
2.17.0
