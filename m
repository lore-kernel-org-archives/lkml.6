Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965206AbeEIRbg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:31:36 -0400
Received: from vern.gendns.com ([206.190.152.46]:51990 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965786AbeEIR1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:27:02 -0400
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
Subject: [PATCH v10 01/27] clk: davinci: pll: allow dev == NULL
Date: Wed,  9 May 2018 12:25:40 -0500
Message-Id: <20180509172606.29387-2-david@lechnology.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180509172606.29387-1-david@lechnology.com>
References: <20180509172606.29387-1-david@lechnology.com>
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

Some function declarations are moved to a public header file so that they can
be called from mach init code.

Signed-off-by: David Lechner <david@lechnology.com>
---

v10 changes:
- dropped helper functions that called devm_* versions of functions.
- removed duplicate function declarations from pll.h

v9 changes:
- new patch in v9


 drivers/clk/davinci/pll-da830.c  |   4 +-
 drivers/clk/davinci/pll-da850.c  |  21 +++---
 drivers/clk/davinci/pll-dm355.c  |   8 +--
 drivers/clk/davinci/pll-dm365.c  |   8 +--
 drivers/clk/davinci/pll-dm644x.c |   8 +--
 drivers/clk/davinci/pll-dm646x.c |   8 +--
 drivers/clk/davinci/pll.c        | 106 +++++++++++++++++--------------
 drivers/clk/davinci/pll.h        |  30 ++++-----
 include/linux/clk/davinci.h      |  24 +++++++
 9 files changed, 122 insertions(+), 95 deletions(-)
 create mode 100644 include/linux/clk/davinci.h

diff --git a/drivers/clk/davinci/pll-da830.c b/drivers/clk/davinci/pll-da830.c
index 929a3d3a9adb..76f62f2e5ccb 100644
--- a/drivers/clk/davinci/pll-da830.c
+++ b/drivers/clk/davinci/pll-da830.c
@@ -36,11 +36,11 @@ SYSCLK(5, pll0_sysclk5, pll0_pllen, 5, 0);
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
index 2a038b7908cc..00a6ece7b524 100644
--- a/drivers/clk/davinci/pll-da850.c
+++ b/drivers/clk/davinci/pll-da850.c
@@ -8,6 +8,7 @@
 #include <linux/bitops.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
+#include <linux/device.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/mfd/da8xx-cfgchip.h>
@@ -81,11 +82,11 @@ static const struct davinci_pll_obsclk_info da850_pll0_obsclk_info = {
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
@@ -134,11 +135,11 @@ static const struct davinci_pll_sysclk_info *da850_pll0_sysclk_info[] = {
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
@@ -179,11 +180,11 @@ static const struct davinci_pll_obsclk_info da850_pll1_obsclk_info = {
 	.ocsrc_mask = GENMASK(4, 0),
 };
 
-int da850_pll1_init(struct device *dev, void __iomem *base)
+int da850_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
 {
 	struct clk *clk;
 
-	davinci_pll_clk_register(dev, &da850_pll1_info, "oscin", base);
+	davinci_pll_clk_register(dev, &da850_pll1_info, "oscin", base, cfgchip);
 
 	davinci_pll_sysclk_register(dev, &pll1_sysclk1, base);
 
@@ -204,9 +205,9 @@ static const struct davinci_pll_sysclk_info *da850_pll1_sysclk_info[] = {
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
index 93f4a53d6b44..2e3f390df75f 100644
--- a/drivers/clk/davinci/pll-dm355.c
+++ b/drivers/clk/davinci/pll-dm355.c
@@ -27,11 +27,11 @@ SYSCLK(2, pll1_sysclk2, pll1_pllen, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED)
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
@@ -64,9 +64,9 @@ static const struct davinci_pll_clk_info dm355_pll2_info = {
 
 SYSCLK(1, pll2_sysclk1, pll2_pllen, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
 
-int dm355_pll2_init(struct device *dev, void __iomem *base)
+int dm355_pll2_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
 {
-	davinci_pll_clk_register(dev, &dm355_pll2_info, "oscin", base);
+	davinci_pll_clk_register(dev, &dm355_pll2_info, "oscin", base, cfgchip);
 
 	davinci_pll_sysclk_register(dev, &pll2_sysclk1, base);
 
diff --git a/drivers/clk/davinci/pll-dm365.c b/drivers/clk/davinci/pll-dm365.c
index 5f8d9f42d0f3..e0bf37ad78fc 100644
--- a/drivers/clk/davinci/pll-dm365.c
+++ b/drivers/clk/davinci/pll-dm365.c
@@ -56,11 +56,11 @@ static const struct davinci_pll_obsclk_info dm365_pll1_obsclk_info = {
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
@@ -119,11 +119,11 @@ static const struct davinci_pll_obsclk_info dm365_pll2_obsclk_info = {
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
index 69bf785377cf..0d39fb07a510 100644
--- a/drivers/clk/davinci/pll-dm644x.c
+++ b/drivers/clk/davinci/pll-dm644x.c
@@ -27,11 +27,11 @@ SYSCLK(2, pll1_sysclk2, pll1_pllen, 4, SYSCLK_FIXED_DIV);
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
@@ -66,9 +66,9 @@ static const struct davinci_pll_clk_info dm644x_pll2_info = {
 SYSCLK(1, pll2_sysclk1, pll2_pllen, 4, 0);
 SYSCLK(2, pll2_sysclk2, pll2_pllen, 4, 0);
 
-int dm644x_pll2_init(struct device *dev, void __iomem *base)
+int dm644x_pll2_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
 {
-	davinci_pll_clk_register(dev, &dm644x_pll2_info, "oscin", base);
+	davinci_pll_clk_register(dev, &dm644x_pll2_info, "oscin", base, cfgchip);
 
 	davinci_pll_sysclk_register(dev, &pll2_sysclk1, base);
 
diff --git a/drivers/clk/davinci/pll-dm646x.c b/drivers/clk/davinci/pll-dm646x.c
index a61cc3256418..eb96dd72b6b7 100644
--- a/drivers/clk/davinci/pll-dm646x.c
+++ b/drivers/clk/davinci/pll-dm646x.c
@@ -29,11 +29,11 @@ SYSCLK(6, pll1_sysclk6, pll1_pllen, 4, 0);
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
@@ -74,9 +74,9 @@ static const struct davinci_pll_clk_info dm646x_pll2_info = {
 
 SYSCLK(1, pll2_sysclk1, pll2_pllen, 4, 0);
 
-int dm646x_pll2_init(struct device *dev, void __iomem *base)
+int dm646x_pll2_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
 {
-	davinci_pll_clk_register(dev, &dm646x_pll2_info, "oscin", base);
+	davinci_pll_clk_register(dev, &dm646x_pll2_info, "oscin", base, cfgchip);
 
 	davinci_pll_sysclk_register(dev, &pll2_sysclk1, base);
 
diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
index 23a24c944f1d..f362f10d8459 100644
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
+ * @dev: the clock's device node or NULL
  * @name: the clock name
  * @parent_name: the parent clock name
  * @reg: the *DIV register
@@ -241,14 +243,14 @@ static struct clk *davinci_pll_div_register(struct device *dev,
 	struct clk_gate *gate;
 	struct clk_divider *divider;
 
-	gate = devm_kzalloc(dev, sizeof(*gate), GFP_KERNEL);
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
 	if (!gate)
 		return ERR_PTR(-ENOMEM);
 
 	gate->reg = reg;
 	gate->bit_idx = DIV_ENABLE_SHIFT;
 
-	divider = devm_kzalloc(dev, sizeof(*divider), GFP_KERNEL);
+	divider = kzalloc(sizeof(*divider), GFP_KERNEL);
 	if (!divider)
 		return ERR_PTR(-ENOMEM);
 
@@ -321,36 +323,17 @@ static int davinci_pllen_rate_change(struct notifier_block *nb,
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
+ * @dev: The clock's device node or NULL
  * @info: The device-specific clock info
  * @parent_name: The parent clock name
  * @base: The PLL's memory region
+ * @cfgchip: CFGCHIP syscon regmap for info->unlock_reg or NULL
  *
  * This creates a series of clocks that represent the PLL.
  *
@@ -366,9 +349,9 @@ static struct notifier_block davinci_pllen_notifier = {
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
@@ -378,10 +361,6 @@ struct clk *davinci_pll_clk_register(struct device *dev,
 	struct davinci_pllen_clk *pllen;
 	struct clk *pllout_clk, *clk;
 
-	pdata = davinci_pll_get_pdata(dev);
-	if (!pdata)
-		return ERR_PTR(-ENOMEM);
-
 	if (info->flags & PLL_HAS_CLKMODE) {
 		/*
 		 * If a PLL has PLLCTL[CLKMODE], then it is the primary PLL.
@@ -424,15 +403,15 @@ struct clk *davinci_pll_clk_register(struct device *dev,
 
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
+	pllout = kzalloc(sizeof(*pllout), GFP_KERNEL);
 	if (!pllout)
 		return ERR_PTR(-ENOMEM);
 
@@ -456,7 +435,7 @@ struct clk *davinci_pll_clk_register(struct device *dev,
 	pllout->pllm_min = info->pllm_min;
 	pllout->pllm_max = info->pllm_max;
 
-	pllout_clk = devm_clk_register(dev, &pllout->hw);
+	pllout_clk = clk_register(dev, &pllout->hw);
 	if (IS_ERR(pllout_clk))
 		return pllout_clk;
 
@@ -482,7 +461,7 @@ struct clk *davinci_pll_clk_register(struct device *dev,
 		parent_name = postdiv_name;
 	}
 
-	pllen = devm_kzalloc(dev, sizeof(*pllout), GFP_KERNEL);
+	pllen = kzalloc(sizeof(*pllout), GFP_KERNEL);
 	if (!pllen)
 		return ERR_PTR(-ENOMEM);
 
@@ -497,7 +476,7 @@ struct clk *davinci_pll_clk_register(struct device *dev,
 	pllen->hw.init = &init;
 	pllen->base = base;
 
-	clk = devm_clk_register(dev, &pllen->hw);
+	clk = clk_register(dev, &pllen->hw);
 	if (IS_ERR(clk))
 		return clk;
 
@@ -548,7 +527,7 @@ davinci_pll_obsclk_register(struct device *dev,
 	struct clk_divider *divider;
 	u32 oscdiv;
 
-	mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
 	if (!mux)
 		return ERR_PTR(-ENOMEM);
 
@@ -556,14 +535,14 @@ davinci_pll_obsclk_register(struct device *dev,
 	mux->table = info->table;
 	mux->mask = info->ocsrc_mask;
 
-	gate = devm_kzalloc(dev, sizeof(*gate), GFP_KERNEL);
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
 	if (!gate)
 		return ERR_PTR(-ENOMEM);
 
 	gate->reg = base + CKEN;
 	gate->bit_idx = CKEN_OBSCLK_SHIFT;
 
-	divider = devm_kzalloc(dev, sizeof(*divider), GFP_KERNEL);
+	divider = kzalloc(sizeof(*divider), GFP_KERNEL);
 	if (!divider)
 		return ERR_PTR(-ENOMEM);
 
@@ -637,14 +616,14 @@ davinci_pll_sysclk_register(struct device *dev,
 	else
 		reg = PLLDIV4 + 4 * (info->id - 4);
 
-	gate = devm_kzalloc(dev, sizeof(*gate), GFP_KERNEL);
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
 	if (!gate)
 		return ERR_PTR(-ENOMEM);
 
 	gate->reg = base + reg;
 	gate->bit_idx = DIV_ENABLE_SHIFT;
 
-	divider = devm_kzalloc(dev, sizeof(*divider), GFP_KERNEL);
+	divider = kzalloc(sizeof(*divider), GFP_KERNEL);
 	if (!divider)
 		return ERR_PTR(-ENOMEM);
 
@@ -676,14 +655,14 @@ davinci_pll_sysclk_register(struct device *dev,
 	return clk;
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
@@ -693,7 +672,7 @@ int of_davinci_pll_init(struct device *dev,
 	else
 		parent_name = OSCIN_CLK_NAME;
 
-	clk = davinci_pll_clk_register(dev, info, parent_name, base);
+	clk = davinci_pll_clk_register(dev, info, parent_name, base, cfgchip);
 	if (IS_ERR(clk)) {
 		dev_err(dev, "failed to register %s\n", info->name);
 		return PTR_ERR(clk);
@@ -711,11 +690,11 @@ int of_davinci_pll_init(struct device *dev,
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
 
@@ -770,6 +749,27 @@ int of_davinci_pll_init(struct device *dev,
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
@@ -791,11 +791,13 @@ static const struct platform_device_id davinci_pll_id_table[] = {
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
@@ -812,12 +814,18 @@ static int davinci_pll_probe(struct platform_device *pdev)
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
