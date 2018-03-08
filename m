Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756048AbeCHPYl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 10:24:41 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:37496 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756023AbeCHPYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 10:24:38 -0500
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] drm: bridge: Add LVDS decoder driver
Date: Thu,  8 Mar 2018 16:24:02 +0100
Message-Id: <1520522643-11756-3-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520522643-11756-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1520522643-11756-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add transparent LVDS decoder driver.

A transparent LVDS decoder is a DRM bridge device that does not require
any configuration and converts LVDS input to digital CMOS/TTL parallel
data output. The driver is compatible with Thine THC63LVD1024 device
that can control a few power supplies and a few enable GPIOs.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 drivers/gpu/drm/bridge/Kconfig        |   8 ++
 drivers/gpu/drm/bridge/Makefile       |   1 +
 drivers/gpu/drm/bridge/lvds-decoder.c | 239 ++++++++++++++++++++++++++++++++++
 3 files changed, 248 insertions(+)
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
index 0000000..3aada7e
--- /dev/null
+++ b/drivers/gpu/drm/bridge/lvds-decoder.c
@@ -0,0 +1,239 @@
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
+#include <linux/gpio/consumer.h>
+#include <linux/of_graph.h>
+#include <linux/regulator/consumer.h>
+
+struct lvds_decoder {
+	struct device *dev;
+
+	struct regulator *vccs[4];
+
+	struct gpio_desc *pwdn;
+	struct gpio_desc *oe;
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
+static void lvds_decoder_enable(struct drm_bridge *bridge)
+{
+	struct lvds_decoder *lvds = to_lvds_decoder(bridge);
+	struct regulator *vcc;
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < ARRAY_SIZE(lvds->vccs); i++) {
+		vcc = lvds->vccs[i];
+		if (vcc) {
+			ret = regulator_enable(vcc);
+			if (ret)
+				goto error_vcc_enable;
+		}
+	}
+
+	if (lvds->pwdn)
+		gpiod_set_value(lvds->pwdn, 0);
+
+	if (lvds->oe)
+		gpiod_set_value(lvds->oe, 1);
+
+	return;
+
+error_vcc_enable:
+	dev_err(lvds->dev, "Failed to enable regulator %u\n", i);
+}
+
+static void lvds_decoder_disable(struct drm_bridge *bridge)
+{
+	struct lvds_decoder *lvds = to_lvds_decoder(bridge);
+	struct regulator *vcc;
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < ARRAY_SIZE(lvds->vccs); i++) {
+		vcc = lvds->vccs[i];
+		if (vcc) {
+			ret = regulator_disable(vcc);
+			if (ret)
+				goto error_vcc_disable;
+		}
+	}
+
+	if (lvds->pwdn)
+		gpiod_set_value(lvds->pwdn, 1);
+
+	if (lvds->oe)
+		gpiod_set_value(lvds->oe, 0);
+
+	return;
+
+error_vcc_disable:
+	dev_err(lvds->dev, "Failed to enable regulator %u\n", i);
+}
+
+struct drm_bridge_funcs lvds_dec_bridge_func = {
+	.attach	= lvds_decoder_attach,
+	.enable = lvds_decoder_enable,
+	.disable = lvds_decoder_disable,
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
+static int lvds_decoder_gpio_init(struct lvds_decoder *lvds)
+{
+	lvds->pwdn = devm_gpiod_get_optional(lvds->dev, "pwdn", GPIOD_OUT_LOW);
+	if (IS_ERR(lvds->pwdn)) {
+		dev_err(lvds->dev, "Unable to get GPIO \"pwdn\"\n");
+		return PTR_ERR(lvds->pwdn);
+	}
+
+	lvds->oe = devm_gpiod_get_optional(lvds->dev, "oe", GPIOD_OUT_LOW);
+	if (IS_ERR(lvds->oe)) {
+		dev_err(lvds->dev, "Unable to get GPIO \"oe\"\n");
+		return PTR_ERR(lvds->oe);
+	}
+
+	return 0;
+}
+
+static int lvds_decoder_regulator_init(struct lvds_decoder *lvds)
+{
+	const char *reg_names[4] = { "vcc", "lvcc", "pvcc", "cvcc", };
+	struct regulator **reg;
+	int i;
+
+	for (i = 0, reg = &lvds->vccs[0];
+	     i < ARRAY_SIZE(lvds->vccs); i++, reg++) {
+		*reg = devm_regulator_get_optional(lvds->dev, reg_names[i]);
+		if (IS_ERR(*reg)) {
+			if (PTR_ERR(*reg) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+			*reg = NULL;
+		}
+	}
+
+	return 0;
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
+	ret = lvds_decoder_regulator_init(lvds);
+	if (ret)
+		return ret;
+
+	ret = lvds_decoder_gpio_init(lvds);
+	if (ret)
+		return ret;
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
+	{ .compatible = "thine,thc63lvd1024", },
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
