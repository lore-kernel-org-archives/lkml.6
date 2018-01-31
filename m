Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754009AbeAaSNv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:13:51 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46624 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753707AbeAaSJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:09:59 -0500
X-Google-Smtp-Source: AH8x224S/rS9enVdhi7cDaJFd83rqkM7wKdfXTKG2rGd+gjw7V7ESq8cQHXwFxOIteW8PaB8NXj32g==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/19] clk: meson: add regmap to the clock controllers
Date: Wed, 31 Jan 2018 19:09:34 +0100
Message-Id: <20180131180945.18025-9-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180131180945.18025-1-jbrunet@baylibre.com>
References: <20180131180945.18025-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change register a regmap in meson8b, gxbb and axg controllers.
The clock are still accessing their registers directly through iomem.
Once all clocks handled by these controllers have been move to regmap,
the regmap register will be removed and replaced with a syscon request.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/Kconfig   |  2 ++
 drivers/clk/meson/axg.c     | 15 ++++++++++++++-
 drivers/clk/meson/gxbb.c    | 33 +++++++++++++++++++++++----------
 drivers/clk/meson/meson8b.c | 14 +++++++++++++-
 4 files changed, 52 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index 33d148e19066..9735335b17a9 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -11,6 +11,7 @@ config COMMON_CLK_MESON8B
 	bool
 	depends on COMMON_CLK_AMLOGIC
 	select RESET_CONTROLLER
+	select REGMAP
 	help
 	  Support for the clock controller on AmLogic S802 (Meson8),
 	  S805 (Meson8b) and S812 (Meson8m2) devices. Say Y if you
@@ -29,6 +30,7 @@ config COMMON_CLK_AXG
 	bool
 	depends on COMMON_CLK_AMLOGIC
 	select RESET_CONTROLLER
+	select REGMAP
 	help
 	  Support for the clock controller on AmLogic A113D devices, aka axg.
 	  Say Y if you want peripherals and CPU frequency scaling to work.
diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index f84927e76f88..669d0ed84ebc 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -11,10 +11,11 @@
 
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/init.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
-#include <linux/init.h>
+#include <linux/regmap.h>
 
 #include "clkc.h"
 #include "axg.h"
@@ -791,12 +792,19 @@ static const struct of_device_id clkc_match_table[] = {
 	{}
 };
 
+static const struct regmap_config clkc_regmap_config = {
+	.reg_bits       = 32,
+	.val_bits       = 32,
+	.reg_stride     = 4,
+};
+
 static int axg_clkc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	const struct clkc_data *clkc_data;
 	struct resource *res;
 	void __iomem *clk_base;
+	struct regmap *map;
 	int ret, i;
 
 	clkc_data = of_device_get_match_data(dev);
@@ -807,12 +815,17 @@ static int axg_clkc_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -EINVAL;
+
 	clk_base = devm_ioremap(dev, res->start, resource_size(res));
 	if (!clk_base) {
 		dev_err(dev, "Unable to map clk base\n");
 		return -ENXIO;
 	}
 
+	map = devm_regmap_init_mmio(dev, clk_base, &clkc_regmap_config);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
 	/* Populate base address for PLLs */
 	for (i = 0; i < clkc_data->clk_plls_count; i++)
 		clkc_data->clk_plls[i]->base = clk_base;
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 6609024eee00..e3faf0a0fdb7 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -19,10 +19,11 @@
 
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/init.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
-#include <linux/init.h>
+#include <linux/regmap.h>
 
 #include "clkc.h"
 #include "gxbb.h"
@@ -1937,10 +1938,18 @@ static const struct of_device_id clkc_match_table[] = {
 	{},
 };
 
+static const struct regmap_config clkc_regmap_config = {
+	.reg_bits       = 32,
+	.val_bits       = 32,
+	.reg_stride     = 4,
+};
+
 static int gxbb_clkc_probe(struct platform_device *pdev)
 {
 	const struct clkc_data *clkc_data;
+	struct resource *res;
 	void __iomem *clk_base;
+	struct regmap *map;
 	int ret, i;
 	struct device *dev = &pdev->dev;
 
@@ -1948,13 +1957,20 @@ static int gxbb_clkc_probe(struct platform_device *pdev)
 	if (!clkc_data)
 		return -EINVAL;
 
-	/*  Generic clocks and PLLs */
-	clk_base = of_iomap(dev->of_node, 0);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+
+	clk_base = devm_ioremap(dev, res->start, resource_size(res));
 	if (!clk_base) {
 		pr_err("%s: Unable to map clk base\n", __func__);
 		return -ENXIO;
 	}
 
+	map = devm_regmap_init_mmio(dev, clk_base, &clkc_regmap_config);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
 	/* Populate base address for PLLs */
 	for (i = 0; i < clkc_data->clk_plls_count; i++)
 		clkc_data->clk_plls[i]->base = clk_base;
@@ -1991,17 +2007,14 @@ static int gxbb_clkc_probe(struct platform_device *pdev)
 
 		ret = devm_clk_hw_register(dev,
 					   clkc_data->hw_onecell_data->hws[i]);
-		if (ret)
-			goto iounmap;
+		if (ret) {
+			dev_err(dev, "Clock registration failed\n");
+			return ret;
+		}
 	}
 
-
 	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
 					   clkc_data->hw_onecell_data);
-
-iounmap:
-	iounmap(clk_base);
-	return ret;
 }
 
 static struct platform_driver gxbb_driver = {
diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index db017c29a84c..0981e970de3d 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -23,11 +23,12 @@
 
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/init.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 #include <linux/slab.h>
-#include <linux/init.h>
+#include <linux/regmap.h>
 
 #include "clkc.h"
 #include "meson8b.h"
@@ -804,16 +805,27 @@ static const struct reset_control_ops meson8b_clk_reset_ops = {
 	.deassert = meson8b_clk_reset_deassert,
 };
 
+static const struct regmap_config clkc_regmap_config = {
+	.reg_bits       = 32,
+	.val_bits       = 32,
+	.reg_stride     = 4,
+};
+
 static int meson8b_clkc_probe(struct platform_device *pdev)
 {
 	int ret, i;
 	struct clk_hw *parent_hw;
 	struct clk *parent_clk;
 	struct device *dev = &pdev->dev;
+	struct regmap *map;
 
 	if (!clk_base)
 		return -ENXIO;
 
+	map = devm_regmap_init_mmio(dev, clk_base, &clkc_regmap_config);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
 	/* Populate base address for PLLs */
 	for (i = 0; i < ARRAY_SIZE(meson8b_clk_plls); i++)
 		meson8b_clk_plls[i]->base = clk_base;
-- 
2.14.3
