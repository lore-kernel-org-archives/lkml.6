Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753797AbeDKOVe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:21:34 -0400
Received: from hermes.aosc.io ([199.195.250.187]:48417 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753755AbeDKOVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:21:32 -0400
From: Icenowy Zheng <icenowy@aosc.io>
To: Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 4/5] drivers: soc: sunxi: export a regmap for EMAC clock reg on A64
Date: Wed, 11 Apr 2018 22:16:40 +0800
Message-Id: <20180411141641.14675-5-icenowy@aosc.io>
In-Reply-To: <20180411141641.14675-1-icenowy@aosc.io>
References: <20180411141641.14675-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A64 SRAM controller memory zone has a EMAC clock register, which is
needed by the Ethernet MAC driver (dwmac-sun8i).

Export a regmap for this register on A64.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/soc/sunxi/sunxi_sram.c | 48 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index 882be5ed7e84..35ab5f334bb1 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -17,6 +17,7 @@
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 
 #include <linux/soc/sunxi/sunxi_sram.h>
 
@@ -281,13 +282,41 @@ int sunxi_sram_release(struct device *dev)
 }
 EXPORT_SYMBOL(sunxi_sram_release);
 
+struct sunxi_sramc_variant {
+	bool has_emac_clock;
+};
+
+static const struct sunxi_sramc_variant sun4i_a10_sramc_variant = {
+	/* Nothing special */
+};
+
+static const struct sunxi_sramc_variant sun50i_a64_sramc_variant = {
+	.has_emac_clock = true,
+};
+
+static struct regmap_config sunxi_sram_emac_clock_regmap = {
+	.reg_bits       = 32,
+	.val_bits       = 32,
+	.reg_stride     = 4,
+	.max_register   = 0x0,	/* only single register */
+	.name		= "emac-clock",
+};
+
+#define SUNXI_SRAM_EMAC_CLOCK_REG	0x30
+
 static int sunxi_sram_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct dentry *d;
+	struct regmap *emac_clock;
+	const struct sunxi_sramc_variant *variant;
 
 	sram_dev = &pdev->dev;
 
+	variant = of_device_get_match_data(&pdev->dev);
+	if (!variant)
+		return -EINVAL;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(base))
@@ -300,12 +329,27 @@ static int sunxi_sram_probe(struct platform_device *pdev)
 	if (!d)
 		return -ENOMEM;
 
+	if (variant->has_emac_clock) {
+		emac_clock = devm_regmap_init_mmio(&pdev->dev,
+						   base + SUNXI_SRAM_EMAC_CLOCK_REG,
+						   &sunxi_sram_emac_clock_regmap);
+
+		if (IS_ERR(emac_clock))
+			return PTR_ERR(emac_clock);
+	}
+
 	return 0;
 }
 
 static const struct of_device_id sunxi_sram_dt_match[] = {
-	{ .compatible = "allwinner,sun4i-a10-sram-controller" },
-	{ .compatible = "allwinner,sun50i-a64-sram-controller" },
+	{
+		.compatible = "allwinner,sun4i-a10-sram-controller",
+		.data = &sun4i_a10_sramc_variant,
+	},
+	{
+		.compatible = "allwinner,sun50i-a64-sram-controller",
+		.data = &sun50i_a64_sramc_variant,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sunxi_sram_dt_match);
-- 
2.15.1
