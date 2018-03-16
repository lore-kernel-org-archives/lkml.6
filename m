Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753225AbeCPRz4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 13:55:56 -0400
Received: from hermes.aosc.io ([199.195.250.187]:52765 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753121AbeCPRzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 13:55:53 -0400
From: Icenowy Zheng <icenowy@aosc.io>
To: Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 3/7] bus: add bus driver for accessing Allwinner A64 DE2
Date: Sat, 17 Mar 2018 01:53:50 +0800
Message-Id: <20180316175354.21437-4-icenowy@aosc.io>
In-Reply-To: <20180316175354.21437-1-icenowy@aosc.io>
References: <20180316175354.21437-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "Display Engine 2.0" (usually called DE2) on the Allwinner A64 SoC
is different from the ones on other Allwinner SoCs. It requires a SRAM
region to be claimed, otherwise all DE2 subblocks won't be accessible.

Add a bus driver for the Allwinner A64 DE2 part which claims the SRAM
region when probing.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/bus/Kconfig      | 10 ++++++++++
 drivers/bus/Makefile     |  1 +
 drivers/bus/sun50i-de2.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)
 create mode 100644 drivers/bus/sun50i-de2.c

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index ff70850031c5..cc8e4b4b6b59 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -95,6 +95,16 @@ config SIMPLE_PM_BUS
 	  Controller (BSC, sometimes called "LBSC within Bus Bridge", or
 	  "External Bus Interface") as found on several Renesas ARM SoCs.
 
+config SUN50I_DE2_BUS
+	bool "Allwinner A64 DE2 Bus Driver"
+	  default ARM64
+	  depends on ARCH_SUNXI
+	  select SUNXI_SRAM
+	  help
+	  Say y here to enable support for Allwinner A64 DE2 bus driver. It's
+	  mostly transparent, but a SRAM region needs to be claimed in the SRAM
+	  controller to make the all blocks in the DE2 part accessible.
+
 config SUNXI_RSB
 	tristate "Allwinner sunXi Reduced Serial Bus Driver"
 	  default MACH_SUN8I || MACH_SUN9I || ARM64
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index 3d473b8adeac..746ff0cebe10 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_OMAP_INTERCONNECT)	+= omap_l3_smx.o omap_l3_noc.o
 
 obj-$(CONFIG_OMAP_OCP2SCP)	+= omap-ocp2scp.o
 obj-$(CONFIG_QCOM_EBI2)		+= qcom-ebi2.o
+obj-$(CONFIG_SUN50I_DE2_BUS)	+= sun50i-de2.o
 obj-$(CONFIG_SUNXI_RSB)		+= sunxi-rsb.o
 obj-$(CONFIG_SIMPLE_PM_BUS)	+= simple-pm-bus.o
 obj-$(CONFIG_TEGRA_ACONNECT)	+= tegra-aconnect.o
diff --git a/drivers/bus/sun50i-de2.c b/drivers/bus/sun50i-de2.c
new file mode 100644
index 000000000000..836828ef96d5
--- /dev/null
+++ b/drivers/bus/sun50i-de2.c
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Allwinner A64 Display Engine 2.0 Bus Driver
+ *
+ * Copyright (C) 2018 Icenowy Zheng <icenowy@aosc.io>
+ */
+
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/soc/sunxi/sunxi_sram.h>
+
+static int sun50i_de2_bus_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	int ret;
+
+	ret = sunxi_sram_claim(&pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "Error couldn't map SRAM to device\n");
+		return ret;
+	}
+
+	if (np)
+		of_platform_populate(np, NULL, NULL, &pdev->dev);
+
+	return 0;
+}
+
+static int sun50i_de2_bus_remove(struct platform_device *pdev)
+{
+	sunxi_sram_release(&pdev->dev);
+	return 0;
+}
+
+static const struct of_device_id sun50i_de2_bus_of_match[] = {
+	{ .compatible = "allwinner,sun50i-a64-de2", },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver sun50i_de2_bus_driver = {
+	.probe = sun50i_de2_bus_probe,
+	.remove = sun50i_de2_bus_remove,
+	.driver = {
+		.name = "sun50i-de2-bus",
+		.of_match_table = sun50i_de2_bus_of_match,
+	},
+};
+
+builtin_platform_driver(sun50i_de2_bus_driver);
-- 
2.15.1
