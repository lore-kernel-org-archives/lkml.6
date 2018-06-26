Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8B5C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC806265E8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC806265E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752622AbeFZHWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:22:18 -0400
Received: from regular2.263xmail.com ([211.157.152.3]:32788 "EHLO
        regular2.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbeFZHWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:22:15 -0400
X-Greylist: delayed 317 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Jun 2018 03:22:13 EDT
Received: from regular1.263xmail.com (unknown [192.168.165.114])
        by regular2.263xmail.com (Postfix) with ESMTP id C68741F03B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 15:16:48 +0800 (CST)
Received: from hjc?rock-chips.com (unknown [192.168.167.76])
        by regular1.263xmail.com (Postfix) with ESMTP id B03CB6A;
        Tue, 26 Jun 2018 15:16:28 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 23B62378;
        Tue, 26 Jun 2018 15:16:21 +0800 (CST)
X-RL-SENDER: hjc@rock-chips.com
X-FST-TO: dri-devel@lists.freedesktop.org
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: hjc@rock-chips.com
X-UNIQUE-TAG: <2dd133e7f1b3377955cc431b10f5a5c6>
X-ATTACHMENT-NUM: 0
X-SENDER: hjc@rock-chips.com
X-DNS-TYPE: 0
Received: from unknown (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith SMTP id 2568N5T8SF;
        Tue, 26 Jun 2018 15:16:25 +0800 (CST)
From:   Sandy Huang <hjc@rock-chips.com>
To:     dri-devel@lists.freedesktop.org, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>
Cc:     seanpaul@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v4 2/2] drm/rockchip: Add support for Rockchip Soc RGB output interface
Date:   Tue, 26 Jun 2018 15:15:40 +0800
Message-Id: <1529997340-156879-3-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529997340-156879-1-git-send-email-hjc@rock-chips.com>
References: <1529997340-156879-1-git-send-email-hjc@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Rockchip CRTCs, like rv1108 and px30, can directly output parallel
and serial RGB data to panel or conversion chip, so we add this driver
to probe encoder and connector.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
Reviewed-by: Mark Yao <mark.yao@rock-chips.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1509522851-128181-1-git-send-email-hjc@rock-chips.com
---

Changes in v4:
    1. add support px30;
Changes in v3:
    1. update for rgb-mode move to panel node.
Changes in v2:
    1. add error log when probe failed;
    2. update name_to_output_mode() according to sean's suggest;	
    3. Fix uninitialized use of ret.

 drivers/gpu/drm/rockchip/Kconfig            |  11 +
 drivers/gpu/drm/rockchip/Makefile           |   1 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c |   2 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |   1 +
 drivers/gpu/drm/rockchip/rockchip_rgb.c     | 355 ++++++++++++++++++++++++++++
 5 files changed, 370 insertions(+)
 create mode 100644 drivers/gpu/drm/rockchip/rockchip_rgb.c

diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index 0ccc762..e88eb71 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -8,6 +8,7 @@ config DRM_ROCKCHIP
 	select DRM_ANALOGIX_DP if ROCKCHIP_ANALOGIX_DP
 	select DRM_DW_HDMI if ROCKCHIP_DW_HDMI
 	select DRM_MIPI_DSI if ROCKCHIP_DW_MIPI_DSI
+	select DRM_RGB if ROCKCHIP_RGB
 	select SND_SOC_HDMI_CODEC if ROCKCHIP_CDN_DP && SND_SOC
 	help
 	  Choose this option if you have a Rockchip soc chipset.
@@ -66,4 +67,14 @@ config ROCKCHIP_LVDS
 	  Rockchip rk3288 SoC has LVDS TX Controller can be used, and it
 	  support LVDS, rgb, dual LVDS output mode. say Y to enable its
 	  driver.
+
+config ROCKCHIP_RGB
+	bool "Rockchip RGB support"
+	depends on DRM_ROCKCHIP
+	depends on PINCTRL
+	help
+	  Choose this option to enable support for Rockchip RGB output.
+	  Some Rockchip CRTCs, like rv1108, can directly output parallel
+	  and serial RGB format to panel or connect to a conversion chip.
+	  say Y to enable its driver.
 endif
diff --git a/drivers/gpu/drm/rockchip/Makefile b/drivers/gpu/drm/rockchip/Makefile
index a314e21..868263f 100644
--- a/drivers/gpu/drm/rockchip/Makefile
+++ b/drivers/gpu/drm/rockchip/Makefile
@@ -14,5 +14,6 @@ rockchipdrm-$(CONFIG_ROCKCHIP_DW_HDMI) += dw_hdmi-rockchip.o
 rockchipdrm-$(CONFIG_ROCKCHIP_DW_MIPI_DSI) += dw-mipi-dsi.o
 rockchipdrm-$(CONFIG_ROCKCHIP_INNO_HDMI) += inno_hdmi.o
 rockchipdrm-$(CONFIG_ROCKCHIP_LVDS) += rockchip_lvds.o
+rockchipdrm-$(CONFIG_ROCKCHIP_RGB) += rockchip_rgb.o
 
 obj-$(CONFIG_DRM_ROCKCHIP) += rockchipdrm.o
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index f814d37..7f81afa 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -474,6 +474,8 @@ static int __init rockchip_drm_init(void)
 				CONFIG_ROCKCHIP_LVDS);
 	ADD_ROCKCHIP_SUB_DRIVER(rockchip_dp_driver,
 				CONFIG_ROCKCHIP_ANALOGIX_DP);
+	ADD_ROCKCHIP_SUB_DRIVER(rockchip_rgb_driver,
+				CONFIG_ROCKCHIP_RGB);
 	ADD_ROCKCHIP_SUB_DRIVER(cdn_dp_driver, CONFIG_ROCKCHIP_CDN_DP);
 	ADD_ROCKCHIP_SUB_DRIVER(dw_hdmi_rockchip_pltfm_driver,
 				CONFIG_ROCKCHIP_DW_HDMI);
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index 3a6ebfc..929b457 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -71,5 +71,6 @@ extern struct platform_driver dw_mipi_dsi_driver;
 extern struct platform_driver inno_hdmi_driver;
 extern struct platform_driver rockchip_dp_driver;
 extern struct platform_driver rockchip_lvds_driver;
+extern struct platform_driver rockchip_rgb_driver;
 extern struct platform_driver vop_platform_driver;
 #endif /* _ROCKCHIP_DRM_DRV_H_ */
diff --git a/drivers/gpu/drm/rockchip/rockchip_rgb.c b/drivers/gpu/drm/rockchip/rockchip_rgb.c
new file mode 100644
index 0000000..a1345ca
--- /dev/null
+++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
@@ -0,0 +1,355 @@
+/*
+ * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
+ * Author:
+ *      Sandy Huang <hjc@rock-chips.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <drm/drmP.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_dp_helper.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_of.h>
+
+#include <linux/component.h>
+#include <linux/of_graph.h>
+
+#include "rockchip_drm_drv.h"
+#include "rockchip_drm_vop.h"
+
+#define connector_to_rgb(c) container_of(c, struct rockchip_rgb, connector)
+#define encoder_to_rgb(c) container_of(c, struct rockchip_rgb, encoder)
+
+struct rockchip_rgb {
+	struct device *dev;
+	struct drm_device *drm_dev;
+	struct drm_panel *panel;
+	struct drm_bridge *bridge;
+	struct drm_connector connector;
+	struct drm_encoder encoder;
+	struct dev_pin_info *pins;
+	int output_mode;
+};
+
+static inline int name_to_output_mode(const char *s)
+{
+	static const struct {
+		const char *name;
+		int format;
+	} formats[] = {
+		{ "p888", ROCKCHIP_OUT_MODE_P888 },
+		{ "p666", ROCKCHIP_OUT_MODE_P666 },
+		{ "p565", ROCKCHIP_OUT_MODE_P565 }
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(formats); i++)
+		if (!strncmp(s, formats[i].name, strlen(formats[i].name)))
+			return formats[i].format;
+
+	return -EINVAL;
+}
+
+static const struct drm_connector_funcs rockchip_rgb_connector_funcs = {
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.destroy = drm_connector_cleanup,
+	.reset = drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+static int rockchip_rgb_connector_get_modes(struct drm_connector *connector)
+{
+	struct rockchip_rgb *rgb = connector_to_rgb(connector);
+	struct drm_panel *panel = rgb->panel;
+
+	return drm_panel_get_modes(panel);
+}
+
+static struct drm_encoder *
+rockchip_rgb_connector_best_encoder(struct drm_connector *connector)
+{
+	struct rockchip_rgb *rgb = connector_to_rgb(connector);
+
+	return &rgb->encoder;
+}
+
+static const
+struct drm_connector_helper_funcs rockchip_rgb_connector_helper_funcs = {
+	.get_modes = rockchip_rgb_connector_get_modes,
+	.best_encoder = rockchip_rgb_connector_best_encoder,
+};
+
+static void rockchip_rgb_encoder_enable(struct drm_encoder *encoder)
+{
+	struct rockchip_rgb *rgb = encoder_to_rgb(encoder);
+
+	drm_panel_prepare(rgb->panel);
+	/* iomux to LCD data/sync mode */
+	if (rgb->pins && !IS_ERR(rgb->pins->default_state))
+		pinctrl_select_state(rgb->pins->p, rgb->pins->default_state);
+
+	drm_panel_enable(rgb->panel);
+}
+
+static void rockchip_rgb_encoder_disable(struct drm_encoder *encoder)
+{
+	struct rockchip_rgb *rgb = encoder_to_rgb(encoder);
+
+	drm_panel_disable(rgb->panel);
+	drm_panel_unprepare(rgb->panel);
+}
+
+static int
+rockchip_rgb_encoder_atomic_check(struct drm_encoder *encoder,
+				   struct drm_crtc_state *crtc_state,
+				   struct drm_connector_state *conn_state)
+{
+	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc_state);
+	struct rockchip_rgb *rgb = encoder_to_rgb(encoder);
+
+	s->output_mode = rgb->output_mode;
+	s->output_type = DRM_MODE_CONNECTOR_LVDS;
+
+	return 0;
+}
+
+static const
+struct drm_encoder_helper_funcs rockchip_rgb_encoder_helper_funcs = {
+	.enable = rockchip_rgb_encoder_enable,
+	.disable = rockchip_rgb_encoder_disable,
+	.atomic_check = rockchip_rgb_encoder_atomic_check,
+};
+
+static const struct drm_encoder_funcs rockchip_rgb_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
+static const struct of_device_id rockchip_rgb_dt_ids[] = {
+	{
+		.compatible = "rockchip,px30-rgb",
+	},
+	{
+		.compatible = "rockchip,rv1108-rgb",
+	},
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, rockchip_rgb_dt_ids);
+
+static int rockchip_rgb_bind(struct device *dev, struct device *master,
+			     void *data)
+{
+	struct rockchip_rgb *rgb = dev_get_drvdata(dev);
+	struct drm_device *drm_dev = data;
+	struct drm_encoder *encoder;
+	struct drm_connector *connector;
+	struct device_node *remote = NULL;
+	struct device_node  *port, *endpoint;
+	u32 endpoint_id;
+	const char *name;
+	int ret = 0, child_count = 0;
+
+	rgb->drm_dev = drm_dev;
+	port = of_graph_get_port_by_id(dev->of_node, 1);
+	if (!port) {
+		DRM_DEV_ERROR(dev,
+			      "can't found port point, please init rgb panel port!\n");
+		return -EINVAL;
+	}
+	for_each_child_of_node(port, endpoint) {
+		child_count++;
+		if (of_property_read_u32(endpoint, "reg", &endpoint_id))
+			endpoint_id = 0;
+		ret = drm_of_find_panel_or_bridge(dev->of_node, 1, endpoint_id,
+						  &rgb->panel, &rgb->bridge);
+		if (!ret)
+			break;
+	}
+	if (!child_count) {
+		DRM_DEV_ERROR(dev, "rgb port does not have any children\n");
+		ret = -EINVAL;
+		goto err_put_port;
+	} else if (ret) {
+		DRM_DEV_ERROR(dev, "failed to find panel and bridge node\n");
+		ret = -EPROBE_DEFER;
+		goto err_put_port;
+	}
+	if (rgb->panel)
+		remote = rgb->panel->dev->of_node;
+	else
+		remote = rgb->bridge->of_node;
+	if (of_property_read_string(remote, "rgb-mode", &name))
+		/* default set it as output mode P888 */
+		rgb->output_mode = ROCKCHIP_OUT_MODE_P888;
+	else
+		rgb->output_mode = name_to_output_mode(name);
+	if (rgb->output_mode < 0) {
+		DRM_DEV_ERROR(dev, "invalid rockchip,rgb-mode [%s]\n", name);
+		ret = rgb->output_mode;
+		goto err_put_remote;
+	}
+
+	encoder = &rgb->encoder;
+	encoder->possible_crtcs = drm_of_find_possible_crtcs(drm_dev,
+							     dev->of_node);
+
+	ret = drm_encoder_init(drm_dev, encoder, &rockchip_rgb_encoder_funcs,
+			       DRM_MODE_ENCODER_NONE, NULL);
+	if (ret < 0) {
+		DRM_DEV_ERROR(drm_dev->dev,
+			      "failed to initialize encoder: %d\n", ret);
+		goto err_put_remote;
+	}
+
+	drm_encoder_helper_add(encoder, &rockchip_rgb_encoder_helper_funcs);
+
+	if (rgb->panel) {
+		connector = &rgb->connector;
+		connector->dpms = DRM_MODE_DPMS_OFF;
+		ret = drm_connector_init(drm_dev, connector,
+					 &rockchip_rgb_connector_funcs,
+					 DRM_MODE_CONNECTOR_Unknown);
+		if (ret < 0) {
+			DRM_DEV_ERROR(drm_dev->dev,
+				      "failed to initialize connector: %d\n",
+				      ret);
+			goto err_free_encoder;
+		}
+
+		drm_connector_helper_add(connector,
+					 &rockchip_rgb_connector_helper_funcs);
+
+		ret = drm_mode_connector_attach_encoder(connector, encoder);
+		if (ret < 0) {
+			DRM_DEV_ERROR(drm_dev->dev,
+				      "failed to attach encoder: %d\n", ret);
+			goto err_free_connector;
+		}
+
+		ret = drm_panel_attach(rgb->panel, connector);
+		if (ret < 0) {
+			DRM_DEV_ERROR(drm_dev->dev,
+				      "failed to attach panel: %d\n", ret);
+			goto err_free_connector;
+		}
+		connector->port = dev->of_node;
+	} else {
+		rgb->bridge->encoder = encoder;
+		ret = drm_bridge_attach(encoder, rgb->bridge, NULL);
+		if (ret) {
+			DRM_DEV_ERROR(drm_dev->dev,
+				      "failed to attach bridge: %d\n", ret);
+			goto err_free_encoder;
+		}
+		encoder->bridge = rgb->bridge;
+	}
+
+	of_node_put(remote);
+	of_node_put(port);
+
+	return 0;
+
+err_free_connector:
+	drm_connector_cleanup(connector);
+err_free_encoder:
+	drm_encoder_cleanup(encoder);
+err_put_remote:
+	of_node_put(remote);
+err_put_port:
+	of_node_put(port);
+
+	return ret;
+}
+
+static void rockchip_rgb_unbind(struct device *dev, struct device *master,
+				void *data)
+{
+	struct rockchip_rgb *rgb = dev_get_drvdata(dev);
+
+	rockchip_rgb_encoder_disable(&rgb->encoder);
+	if (rgb->panel) {
+		drm_panel_detach(rgb->panel);
+		drm_connector_cleanup(&rgb->connector);
+	}
+	drm_encoder_cleanup(&rgb->encoder);
+}
+
+static const struct component_ops rockchip_rgb_component_ops = {
+	.bind = rockchip_rgb_bind,
+	.unbind = rockchip_rgb_unbind,
+};
+
+static int rockchip_rgb_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rockchip_rgb *rgb;
+	const struct of_device_id *match;
+	int ret;
+
+	if (!dev->of_node) {
+		DRM_DEV_ERROR(dev, "dev->of_node is null\n");
+		return -ENODEV;
+	}
+
+	rgb = devm_kzalloc(&pdev->dev, sizeof(*rgb), GFP_KERNEL);
+	if (!rgb)
+		return -ENOMEM;
+
+	rgb->dev = dev;
+	match = of_match_node(rockchip_rgb_dt_ids, dev->of_node);
+	if (!match) {
+		DRM_DEV_ERROR(dev, "match node failed\n");
+		return -ENODEV;
+	}
+
+	rgb->pins = devm_kzalloc(rgb->dev, sizeof(*rgb->pins), GFP_KERNEL);
+	if (!rgb->pins)
+		return -ENOMEM;
+	rgb->pins->p = devm_pinctrl_get(rgb->dev);
+	if (IS_ERR(rgb->pins->p)) {
+		DRM_DEV_ERROR(dev, "no pinctrl handle\n");
+		devm_kfree(rgb->dev, rgb->pins);
+		rgb->pins = NULL;
+	} else {
+		rgb->pins->default_state =
+			pinctrl_lookup_state(rgb->pins->p, "lcdc");
+		if (IS_ERR(rgb->pins->default_state)) {
+			DRM_DEV_ERROR(dev, "no default pinctrl state\n");
+			devm_kfree(rgb->dev, rgb->pins);
+			rgb->pins = NULL;
+		}
+	}
+
+	dev_set_drvdata(dev, rgb);
+	ret = component_add(&pdev->dev, &rockchip_rgb_component_ops);
+	if (ret < 0)
+		DRM_DEV_ERROR(dev, "failed to add component\n");
+
+	return ret;
+}
+
+static int rockchip_rgb_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &rockchip_rgb_component_ops);
+
+	return 0;
+}
+
+struct platform_driver rockchip_rgb_driver = {
+	.probe = rockchip_rgb_probe,
+	.remove = rockchip_rgb_remove,
+	.driver = {
+		   .name = "rockchip-rgb",
+		   .of_match_table = of_match_ptr(rockchip_rgb_dt_ids),
+	},
+};
-- 
2.7.4


