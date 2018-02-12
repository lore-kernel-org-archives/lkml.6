Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751487AbeBLPAM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 10:00:12 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54390 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932680AbeBLO7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 09:59:13 -0500
X-Google-Smtp-Source: AH8x227wzzHuK1nIRzEGdFsg8ir1tu9DjRaK0EbG5sD/8O+nRz/TThLlLFrzwRPadhxkbNsvlMIPwQ==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/19] clk: meson: use hhi syscon if available
Date: Mon, 12 Feb 2018 15:58:46 +0100
Message-Id: <20180212145846.19380-20-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180212145846.19380-1-jbrunet@baylibre.com>
References: <20180212145846.19380-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On gxbb and axg, try to get the hhi regmap from the parent DT node, which
should be the HHI system controller once the necessary changes have been
made in amlogic's DTs

Until then, if getting regmap through the system controller fails, the
clock controller will fall back to the old way, requesting memory region
directly and then registering the regmap itself.

This should allow a smooth transition to syscon

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/Kconfig |  2 ++
 drivers/clk/meson/axg.c   | 43 ++++++++++++++++++++++++++++++-------------
 drivers/clk/meson/gxbb.c  | 39 ++++++++++++++++++++++++++++-----------
 3 files changed, 60 insertions(+), 24 deletions(-)

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index 936afddae406..d5cbec522aec 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -22,6 +22,7 @@ config COMMON_CLK_GXBB
 	depends on COMMON_CLK_AMLOGIC
 	select RESET_CONTROLLER
 	select COMMON_CLK_REGMAP_MESON
+	select MFD_SYSCON
 	help
 	  Support for the clock controller on AmLogic S905 devices, aka gxbb.
 	  Say Y if you want peripherals and CPU frequency scaling to work.
@@ -31,6 +32,7 @@ config COMMON_CLK_AXG
 	depends on COMMON_CLK_AMLOGIC
 	select RESET_CONTROLLER
 	select COMMON_CLK_REGMAP_MESON
+	select MFD_SYSCON
 	help
 	  Support for the clock controller on AmLogic A113D devices, aka axg.
 	  Say Y if you want peripherals and CPU frequency scaling to work.
diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 6813b632c1a9..acb63c8e0fd8 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
@@ -850,25 +851,41 @@ static int axg_clkc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct resource *res;
-	void __iomem *clk_base;
+	void __iomem *clk_base = NULL;
 	struct regmap *map;
 	int ret, i;
 
-	/*  Generic clocks and PLLs */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -EINVAL;
+	/* Get the hhi system controller node if available */
+	map = syscon_node_to_regmap(of_get_parent(dev->of_node));
+	if (IS_ERR(map)) {
+		dev_err(dev,
+			"failed to get HHI regmap - Trying obsolete regs\n");
+
+		/*
+		 * FIXME: HHI registers should be accessed through
+		 * the appropriate system controller. This is required because
+		 * there is more than just clocks in this register space
+		 *
+		 * This fallback method is only provided temporarily until
+		 * all the platform DTs are properly using the syscon node
+		 */
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (!res)
+			return -EINVAL;
+
+
+		clk_base = devm_ioremap(dev, res->start, resource_size(res));
+		if (!clk_base) {
+			dev_err(dev, "Unable to map clk base\n");
+			return -ENXIO;
+		}
 
-	clk_base = devm_ioremap(dev, res->start, resource_size(res));
-	if (!clk_base) {
-		dev_err(dev, "Unable to map clk base\n");
-		return -ENXIO;
+		map = devm_regmap_init_mmio(dev, clk_base,
+					    &clkc_regmap_config);
+		if (IS_ERR(map))
+			return PTR_ERR(map);
 	}
 
-	map = devm_regmap_init_mmio(dev, clk_base, &clkc_regmap_config);
-	if (IS_ERR(map))
-		return PTR_ERR(map);
-
 	/* Populate regmap for the regmap backed clocks */
 	for (i = 0; i < ARRAY_SIZE(axg_clk_regmaps); i++)
 		axg_clk_regmaps[i]->map = map;
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 5ab8338eb894..bb0b0529ca81 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
@@ -2045,19 +2046,35 @@ static int gxbb_clkc_probe(struct platform_device *pdev)
 	if (!clkc_data)
 		return -EINVAL;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -EINVAL;
+	/* Get the hhi system controller node if available */
+	map = syscon_node_to_regmap(of_get_parent(dev->of_node));
+	if (IS_ERR(map)) {
+		dev_err(dev,
+			"failed to get HHI regmap - Trying obsolete regs\n");
 
-	clk_base = devm_ioremap(dev, res->start, resource_size(res));
-	if (!clk_base) {
-		pr_err("%s: Unable to map clk base\n", __func__);
-		return -ENXIO;
-	}
+		/*
+		 * FIXME: HHI registers should be accessed through
+		 * the appropriate system controller. This is required because
+		 * there is more than just clocks in this register space
+		 *
+		 * This fallback method is only provided temporarily until
+		 * all the platform DTs are properly using the syscon node
+		 */
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (!res)
+			return -EINVAL;
+
+		clk_base = devm_ioremap(dev, res->start, resource_size(res));
+		if (!clk_base) {
+			dev_err(dev, "Unable to map clk base\n");
+			return -ENXIO;
+		}
 
-	map = devm_regmap_init_mmio(dev, clk_base, &clkc_regmap_config);
-	if (IS_ERR(map))
-		return PTR_ERR(map);
+		map = devm_regmap_init_mmio(dev, clk_base,
+					    &clkc_regmap_config);
+		if (IS_ERR(map))
+			return PTR_ERR(map);
+	}
 
 	/* Populate regmap for the common regmap backed clocks */
 	for (i = 0; i < ARRAY_SIZE(gx_clk_regmaps); i++)
-- 
2.14.3
