Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932127AbeCINwO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 08:52:14 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:41826 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbeCINwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 08:52:12 -0500
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] drm: bridge: Add LVDS decoder driver
Date: Fri,  9 Mar 2018 14:51:39 +0100
Message-Id: <1520603500-15218-3-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520603500-15218-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1520603500-15218-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add transparent LVDS decoder driver.

A transparent LVDS decoder is a DRM bridge device that does not require
any configuration and converts LVDS input to digital CMOS/TTL parallel
data output.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 drivers/gpu/drm/bridge/Kconfig        |   8 +++
 drivers/gpu/drm/bridge/Makefile       |   1 +
 drivers/gpu/drm/bridge/lvds-decoder.c | 129 ++++++++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+)
 create mode 100644 drivers/gpu/drm/bridge/lvds-decoder.c

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 3b99d5a..e52a5af 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -32,6 +32,14 @@ config DRM_DUMB_VGA_DAC
 	help
 	  Support for RGB to VGA DAC based bridges

+config DRM_LVDS_DECODER
+	tristate "Transparent LVDS to parallel decoder support"
+	depends on OF
+	select DRM_PANEL_BRIDGE
+	help
+	  Support for transparent LVDS to parallel decoders that don't require
+	  any configuration.
+
 config DRM_LVDS_ENCODER
 	tristate "Transparent parallel to LVDS encoder support"
 	depends on OF
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index 373eb28..edc2332 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_DRM_ANALOGIX_ANX78XX) += analogix-anx78xx.o
 obj-$(CONFIG_DRM_DUMB_VGA_DAC) += dumb-vga-dac.o
+obj-$(CONFIG_DRM_LVDS_DECODER) += lvds-decoder.o
 obj-$(CONFIG_DRM_LVDS_ENCODER) += lvds-encoder.o
 obj-$(CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW) += megachips-stdpxxxx-ge-b850v3-fw.o
 obj-$(CONFIG_DRM_NXP_PTN3460) += nxp-ptn3460.o
diff --git a/drivers/gpu/drm/bridge/lvds-decoder.c b/drivers/gpu/drm/bridge/lvds-decoder.c
new file mode 100644
index 0000000..319f4d5
--- /dev/null
+++ b/drivers/gpu/drm/bridge/lvds-decoder.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * LVDS to parallel data DRM bridge driver.
+ *
+ * Copyright (C) 2018 Jacopo Mondi <jacopo+renesas@jmondi.org>
+ */
+
+#include <drm/drmP.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_panel.h>
+
+#include <linux/of_graph.h>
+
+struct lvds_decoder {
+	struct device *dev;
+
+	struct drm_bridge bridge;
+	struct drm_bridge *next;
+	struct drm_encoder *bridge_encoder;
+};
+
+static inline struct lvds_decoder *to_lvds_decoder(struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct lvds_decoder, bridge);
+}
+
+static int lvds_decoder_attach(struct drm_bridge *bridge)
+{
+	struct lvds_decoder *lvds = to_lvds_decoder(bridge);
+
+	return drm_bridge_attach(bridge->encoder, lvds->next, bridge);
+}
+
+struct drm_bridge_funcs lvds_dec_bridge_func = {
+	.attach	= lvds_decoder_attach,
+};
+
+static int lvds_decoder_parse_dt(struct lvds_decoder *lvds)
+{
+	struct device_node *lvds_output;
+	struct device_node *remote;
+	int ret = 0;
+
+	lvds_output = of_graph_get_endpoint_by_regs(lvds->dev->of_node, 1, -1);
+	if (!lvds_output) {
+		dev_err(lvds->dev, "Missing endpoint in Port@1\n");
+		return -ENODEV;
+	}
+
+	remote = of_graph_get_remote_port_parent(lvds_output);
+	if (!remote) {
+		dev_err(lvds->dev, "Endpoint in Port@1 unconnected\n");
+		ret = -ENODEV;
+		goto error_put_lvds_node;
+	}
+
+	if (!of_device_is_available(remote)) {
+		dev_err(lvds->dev, "Port@1 remote endpoint is disabled\n");
+		ret = -ENODEV;
+		goto error_put_remote_node;
+	}
+
+	lvds->next = of_drm_find_bridge(remote);
+	if (!lvds->next)
+		ret = -EPROBE_DEFER;
+
+error_put_remote_node:
+	of_node_put(remote);
+error_put_lvds_node:
+	of_node_put(lvds_output);
+
+	return ret;
+}
+
+static int lvds_decoder_probe(struct platform_device *pdev)
+{
+	struct lvds_decoder *lvds;
+	int ret;
+
+	lvds = devm_kzalloc(&pdev->dev, sizeof(*lvds), GFP_KERNEL);
+	if (!lvds)
+		return -ENOMEM;
+
+	lvds->dev = &pdev->dev;
+	platform_set_drvdata(pdev, lvds);
+
+	ret = lvds_decoder_parse_dt(lvds);
+	if (ret)
+		return ret;
+
+	lvds->bridge.driver_private = lvds;
+	lvds->bridge.of_node = pdev->dev.of_node;
+	lvds->bridge.funcs = &lvds_dec_bridge_func;
+
+	drm_bridge_add(&lvds->bridge);
+
+	return 0;
+}
+
+static int lvds_decoder_remove(struct platform_device *pdev)
+{
+	struct lvds_decoder *lvds = platform_get_drvdata(pdev);
+
+	drm_bridge_remove(&lvds->bridge);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id lvds_decoder_match[] = {
+	{ .compatible = "lvds-decoder", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, lvds_decoder_match);
+#endif
+
+static struct platform_driver lvds_decoder_driver = {
+	.probe	= lvds_decoder_probe,
+	.remove	= lvds_decoder_remove,
+	.driver	= {
+		.name		= "lvds_decoder",
+		.of_match_table	= lvds_decoder_match,
+	},
+};
+module_platform_driver(lvds_decoder_driver);
+
+MODULE_AUTHOR("Jacopo Mondi <jacopo@jmondi.org>");
+MODULE_DESCRIPTION("Transparent LVDS to parallel data decoder");
+MODULE_LICENSE("GPL v2");
--
2.7.4
