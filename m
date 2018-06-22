Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8E6C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05F8241FA
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E05F8241FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752569AbeFVMsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:48:01 -0400
Received: from hermes.aosc.io ([199.195.250.187]:57171 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751198AbeFVMr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:47:59 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 99043630E4;
        Fri, 22 Jun 2018 12:47:47 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v2 3/7] bus: add bus driver for accessing Allwinner A64 DE2
Date:   Fri, 22 Jun 2018 20:45:36 +0800
Message-Id: <20180622124540.56203-2-icenowy@aosc.io>
In-Reply-To: <20180622124540.56203-1-icenowy@aosc.io>
References: <20180622124540.56203-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "Display Engine 2.0" (usually called DE2) on the Allwinner A64 SoC
is different from the ones on other Allwinner SoCs. It requires a SRAM
region to be claimed, otherwise all DE2 subblocks won't be accessible.

Add a bus driver for the Allwinner A64 DE2 part which claims the SRAM
region when probing.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
No changes since v1.

 drivers/bus/Kconfig      | 10 ++++++++
 drivers/bus/Makefile     |  1 +
 drivers/bus/sun50i-de2.c | 49 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)
 create mode 100644 drivers/bus/sun50i-de2.c

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index d1c0b60e9326..1851112ccc29 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -103,6 +103,16 @@ config SIMPLE_PM_BUS
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
index b8f036cca7ff..ca300b1914ce 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_OMAP_INTERCONNECT)	+= omap_l3_smx.o omap_l3_noc.o
 
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
+// SPDX-License-Identifier: GPL-2.0
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
2.17.1

