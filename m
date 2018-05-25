Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934466AbeEYMf0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 08:35:26 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:23091 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932994AbeEYMfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 08:35:22 -0400
X-IronPort-AV: E=Sophos;i="5.49,440,1520924400";
   d="scan'208";a="15314123"
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <nicolas.ferre@microchip.com>,
        <boris.brezillon@bootlin.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <broonie@kernel.org>
CC: <Cristian.Birsan@microchip.com>
Subject: [PATCH v4 2/7] clk: at91: add I2S clock mux driver
Date: Fri, 25 May 2018 15:34:23 +0300
Message-ID: <1527251668-31396-3-git-send-email-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527251668-31396-1-git-send-email-codrin.ciubotariu@microchip.com>
References: <1527251668-31396-1-git-send-email-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is a simple muxing driver that controls the
I2S's clock input by using syscon/regmap to change the parrent.
The available inputs can be Peripheral clock and Generated clock.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 arch/arm/mach-at91/Kconfig     |   4 ++
 drivers/clk/at91/Makefile      |   1 +
 drivers/clk/at91/clk-i2s-mux.c | 117 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+)
 create mode 100644 drivers/clk/at91/clk-i2s-mux.c

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 1254bf9..903f23c 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -27,6 +27,7 @@ config SOC_SAMA5D2
 	select HAVE_AT91_H32MX
 	select HAVE_AT91_GENERATED_CLK
 	select HAVE_AT91_AUDIO_PLL
+	select HAVE_AT91_I2S_MUX_CLK
 	select PINCTRL_AT91PIO4
 	help
 	  Select this if ou are using one of Microchip's SAMA5D2 family SoC.
@@ -129,6 +130,9 @@ config HAVE_AT91_GENERATED_CLK
 config HAVE_AT91_AUDIO_PLL
 	bool
 
+config HAVE_AT91_I2S_MUX_CLK
+	bool
+
 config SOC_SAM_V4_V5
 	bool
 
diff --git a/drivers/clk/at91/Makefile b/drivers/clk/at91/Makefile
index 082596f..facc169 100644
--- a/drivers/clk/at91/Makefile
+++ b/drivers/clk/at91/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_HAVE_AT91_USB_CLK)		+= clk-usb.o
 obj-$(CONFIG_HAVE_AT91_SMD)		+= clk-smd.o
 obj-$(CONFIG_HAVE_AT91_H32MX)		+= clk-h32mx.o
 obj-$(CONFIG_HAVE_AT91_GENERATED_CLK)	+= clk-generated.o
+obj-$(CONFIG_HAVE_AT91_I2S_MUX_CLK)	+= clk-i2s-mux.o
diff --git a/drivers/clk/at91/clk-i2s-mux.c b/drivers/clk/at91/clk-i2s-mux.c
new file mode 100644
index 0000000..2d56ded
--- /dev/null
+++ b/drivers/clk/at91/clk-i2s-mux.c
@@ -0,0 +1,117 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Copyright (C) 2018 Microchip Technology Inc,
+ *                     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
+ *
+ *
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#include <soc/at91/atmel-sfr.h>
+
+#define	I2S_BUS_NR	2
+
+struct clk_i2s_mux {
+	struct clk_hw hw;
+	struct regmap *regmap;
+	u32 bus_id;
+};
+
+#define to_clk_i2s_mux(hw) container_of(hw, struct clk_i2s_mux, hw)
+
+static u8 clk_i2s_mux_get_parent(struct clk_hw *hw)
+{
+	struct clk_i2s_mux *mux = to_clk_i2s_mux(hw);
+	u32 val;
+
+	regmap_read(mux->regmap, AT91_SFR_I2SCLKSEL, &val);
+
+	return (val & BIT(mux->bus_id)) >> mux->bus_id;
+}
+
+static int clk_i2s_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_i2s_mux *mux = to_clk_i2s_mux(hw);
+
+	return regmap_update_bits(mux->regmap, AT91_SFR_I2SCLKSEL,
+				  BIT(mux->bus_id), index << mux->bus_id);
+}
+
+const struct clk_ops clk_i2s_mux_ops = {
+	.get_parent = clk_i2s_mux_get_parent,
+	.set_parent = clk_i2s_mux_set_parent,
+	.determine_rate = __clk_mux_determine_rate,
+};
+
+static struct clk_hw * __init
+at91_clk_i2s_mux_register(struct regmap *regmap, const char *name,
+			  const char * const *parent_names,
+			  unsigned int num_parents, u32 bus_id)
+{
+	struct clk_init_data init = {};
+	struct clk_i2s_mux *i2s_ck;
+	int ret;
+
+	i2s_ck = kzalloc(sizeof(*i2s_ck), GFP_KERNEL);
+	if (!i2s_ck)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &clk_i2s_mux_ops;
+	init.parent_names = parent_names;
+	init.num_parents = num_parents;
+	init.flags = CLK_IGNORE_UNUSED;
+
+	i2s_ck->hw.init = &init;
+	i2s_ck->bus_id = bus_id;
+	i2s_ck->regmap = regmap;
+
+	ret = clk_hw_register(NULL, &i2s_ck->hw);
+	if (ret) {
+		kfree(i2s_ck);
+		return ERR_PTR(ret);
+	}
+
+	return &i2s_ck->hw;
+}
+
+static void __init of_sama5d2_clk_i2s_mux_setup(struct device_node *np)
+{
+	struct regmap *regmap_sfr;
+	u32 bus_id;
+	const char *parent_names[2];
+	struct device_node *i2s_mux_np;
+	struct clk_hw *hw;
+	int ret;
+
+	regmap_sfr = syscon_regmap_lookup_by_compatible("atmel,sama5d2-sfr");
+	if (IS_ERR(regmap_sfr))
+		return;
+
+	for_each_child_of_node(np, i2s_mux_np) {
+		if (of_property_read_u32(i2s_mux_np, "reg", &bus_id))
+			continue;
+
+		if (bus_id > I2S_BUS_NR)
+			continue;
+
+		ret = of_clk_parent_fill(i2s_mux_np, parent_names, 2);
+		if (ret != 2)
+			continue;
+
+		hw = at91_clk_i2s_mux_register(regmap_sfr, i2s_mux_np->name,
+					       parent_names, 2, bus_id);
+		if (IS_ERR(hw))
+			continue;
+
+		of_clk_add_hw_provider(i2s_mux_np, of_clk_hw_simple_get, hw);
+	}
+}
+
+CLK_OF_DECLARE(sama5d2_clk_i2s_mux, "atmel,sama5d2-clk-i2s-mux",
+	       of_sama5d2_clk_i2s_mux_setup);
-- 
2.7.4
