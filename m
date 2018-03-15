Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbeCOLWg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 07:22:36 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:50425 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751488AbeCOLWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 07:22:34 -0400
X-Originating-IP: 2.224.242.101
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        horms@verge.net.au, magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] drm: bridge: Add thc63lvd1024 LVDS decoder driver
Date: Thu, 15 Mar 2018 11:56:30 +0100
Message-Id: <1521111391-3515-3-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521111391-3515-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1521111391-3515-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DRM bridge driver for Thine THC63LVD1024 LVDS to digital parallel
output converter.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 drivers/gpu/drm/bridge/Kconfig        |   6 +
 drivers/gpu/drm/bridge/Makefile       |   1 +
 drivers/gpu/drm/bridge/thc63lvd1024.c | 255 ++++++++++++++++++++++++++++++++++
 3 files changed, 262 insertions(+)
 create mode 100644 drivers/gpu/drm/bridge/thc63lvd1024.c

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 3b99d5a..5815a20 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -92,6 +92,12 @@ config DRM_SII9234
 	  It is an I2C driver, that detects connection of MHL bridge
 	  and starts encapsulation of HDMI signal.
 
+config DRM_THINE_THC63LVD1024
+	tristate "Thine THC63LVD1024 LVDS decoder bridge"
+	depends on OF
+	---help---
+	  Thine THC63LVD1024 LVDS/parallel converter driver.
+
 config DRM_TOSHIBA_TC358767
 	tristate "Toshiba TC358767 eDP bridge"
 	depends on OF
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index 373eb28..fd90b16 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_DRM_PARADE_PS8622) += parade-ps8622.o
 obj-$(CONFIG_DRM_SIL_SII8620) += sil-sii8620.o
 obj-$(CONFIG_DRM_SII902X) += sii902x.o
 obj-$(CONFIG_DRM_SII9234) += sii9234.o
+obj-$(CONFIG_DRM_THINE_THC63LVD1024) += thc63lvd1024.o
 obj-$(CONFIG_DRM_TOSHIBA_TC358767) += tc358767.o
 obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix/
 obj-$(CONFIG_DRM_I2C_ADV7511) += adv7511/
diff --git a/drivers/gpu/drm/bridge/thc63lvd1024.c b/drivers/gpu/drm/bridge/thc63lvd1024.c
new file mode 100644
index 0000000..067f231
--- /dev/null
+++ b/drivers/gpu/drm/bridge/thc63lvd1024.c
@@ -0,0 +1,255 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * THC63LVD1024 LVDS to parallel data DRM bridge driver.
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
+enum {
+	THC63_LVDS_IN0,
+	THC63_LVDS_IN1,
+	THC63_DIGITAL_OUT0,
+	THC63_DIGITAL_OUT1,
+};
+
+static const char * const thc63_reg_names[] = {
+	"vcc", "lvcc", "pvcc", "cvcc",
+};
+
+struct thc63_dev {
+	struct device *dev;
+
+	struct regulator *vccs[ARRAY_SIZE(thc63_reg_names)];
+
+	struct gpio_desc *pdwn;
+	struct gpio_desc *oe;
+
+	struct drm_bridge bridge;
+	struct drm_bridge *next;
+};
+
+static inline struct thc63_dev *to_thc63(struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct thc63_dev, bridge);
+}
+
+static int thc63_attach(struct drm_bridge *bridge)
+{
+	struct thc63_dev *thc63 = to_thc63(bridge);
+
+	return drm_bridge_attach(bridge->encoder, thc63->next, bridge);
+}
+
+static void thc63_enable(struct drm_bridge *bridge)
+{
+	struct thc63_dev *thc63 = to_thc63(bridge);
+	struct regulator *vcc;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(thc63->vccs); i++) {
+		vcc = thc63->vccs[i];
+		if (!vcc)
+			continue;
+
+		if (regulator_enable(vcc))
+			goto error_vcc_enable;
+	}
+
+	if (thc63->pdwn)
+		gpiod_set_value(thc63->pdwn, 0);
+
+	if (thc63->oe)
+		gpiod_set_value(thc63->oe, 1);
+
+	return;
+
+error_vcc_enable:
+	dev_err(thc63->dev, "Failed to enable regulator %u\n", i);
+
+	for (i = i - 1; i >= 0; i--) {
+		vcc = thc63->vccs[i];
+		if (!vcc)
+			continue;
+
+		regulator_disable(vcc);
+	}
+}
+
+static void thc63_disable(struct drm_bridge *bridge)
+{
+	struct thc63_dev *thc63 = to_thc63(bridge);
+	struct regulator *vcc;
+	int i;
+
+	if (thc63->oe)
+		gpiod_set_value(thc63->oe, 0);
+
+	if (thc63->pdwn)
+		gpiod_set_value(thc63->pdwn, 1);
+
+	for (i = ARRAY_SIZE(thc63->vccs) - 1; i >= 0; i--) {
+		vcc = thc63->vccs[i];
+		if (!vcc)
+			continue;
+
+		if (regulator_disable(vcc))
+			dev_dbg(thc63->dev,
+				"Failed to disable regulator %u\n", i);
+	}
+}
+
+struct drm_bridge_funcs thc63_bridge_func = {
+	.attach	= thc63_attach,
+	.enable = thc63_enable,
+	.disable = thc63_disable,
+};
+
+static int thc63_parse_dt(struct thc63_dev *thc63)
+{
+	struct device_node *thc63_out;
+	struct device_node *remote;
+	int ret = 0;
+
+	thc63_out = of_graph_get_endpoint_by_regs(thc63->dev->of_node,
+						  THC63_DIGITAL_OUT0, -1);
+	if (!thc63_out) {
+		dev_err(thc63->dev, "Missing endpoint in Port@%u\n",
+			THC63_DIGITAL_OUT0);
+		return -ENODEV;
+	}
+
+	remote = of_graph_get_remote_port_parent(thc63_out);
+	if (!remote) {
+		dev_err(thc63->dev, "Endpoint in Port@%u unconnected\n",
+			THC63_DIGITAL_OUT0);
+		ret = -ENODEV;
+		goto error_put_out_node;
+	}
+
+	if (!of_device_is_available(remote)) {
+		dev_err(thc63->dev, "Port@%u remote endpoint is disabled\n",
+			THC63_DIGITAL_OUT0);
+		ret = -ENODEV;
+		goto error_put_remote_node;
+	}
+
+	thc63->next = of_drm_find_bridge(remote);
+	if (!thc63->next)
+		ret = -EPROBE_DEFER;
+
+error_put_remote_node:
+	of_node_put(remote);
+error_put_out_node:
+	of_node_put(thc63_out);
+
+	return ret;
+}
+
+static int thc63_gpio_init(struct thc63_dev *thc63)
+{
+	thc63->oe = devm_gpiod_get_optional(thc63->dev, "oe", GPIOD_OUT_LOW);
+	if (IS_ERR(thc63->oe)) {
+		dev_err(thc63->dev, "Unable to get \"oe-gpios\"\n");
+		return PTR_ERR(thc63->oe);
+	}
+
+	thc63->pdwn = devm_gpiod_get_optional(thc63->dev, "pdwn",
+					      GPIOD_OUT_HIGH);
+	if (IS_ERR(thc63->pdwn)) {
+		dev_err(thc63->dev, "Unable to get \"pdwn-gpios\"\n");
+		return PTR_ERR(thc63->pdwn);
+	}
+
+	return 0;
+}
+
+static int thc63_regulator_init(struct thc63_dev *thc63)
+{
+	struct regulator **reg;
+	int i;
+
+	reg = &thc63->vccs[0];
+	for (i = 0; i < ARRAY_SIZE(thc63->vccs); i++, reg++) {
+		*reg = devm_regulator_get_optional(thc63->dev,
+						   thc63_reg_names[i]);
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
+static int thc63_probe(struct platform_device *pdev)
+{
+	struct thc63_dev *thc63;
+	int ret;
+
+	thc63 = devm_kzalloc(&pdev->dev, sizeof(*thc63), GFP_KERNEL);
+	if (!thc63)
+		return -ENOMEM;
+
+	thc63->dev = &pdev->dev;
+	platform_set_drvdata(pdev, thc63);
+
+	ret = thc63_regulator_init(thc63);
+	if (ret)
+		return ret;
+
+	ret = thc63_gpio_init(thc63);
+	if (ret)
+		return ret;
+
+	ret = thc63_parse_dt(thc63);
+	if (ret)
+		return ret;
+
+	thc63->bridge.driver_private = thc63;
+	thc63->bridge.of_node = pdev->dev.of_node;
+	thc63->bridge.funcs = &thc63_bridge_func;
+
+	drm_bridge_add(&thc63->bridge);
+
+	return 0;
+}
+
+static int thc63_remove(struct platform_device *pdev)
+{
+	struct thc63_dev *thc63 = platform_get_drvdata(pdev);
+
+	drm_bridge_remove(&thc63->bridge);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id thc63_match[] = {
+	{ .compatible = "thine,thc63lvd1024", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, thc63_match);
+#endif
+
+static struct platform_driver thc63_driver = {
+	.probe	= thc63_probe,
+	.remove	= thc63_remove,
+	.driver	= {
+		.name		= "thc63lvd1024",
+		.of_match_table	= thc63_match,
+	},
+};
+module_platform_driver(thc63_driver);
+
+MODULE_AUTHOR("Jacopo Mondi <jacopo@jmondi.org>");
+MODULE_DESCRIPTION("Thine THC63LVD1024 LVDS decoder DRM bridge driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
