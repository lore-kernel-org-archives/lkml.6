Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB47EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 03:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7814C20850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 03:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7814C20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeH2HHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 03:07:47 -0400
Received: from regular1.263xmail.com ([211.150.99.134]:36986 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbeH2HHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 03:07:46 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.158])
        by regular1.263xmail.com (Postfix) with ESMTP id A664B375;
        Wed, 29 Aug 2018 11:13:02 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id A391D393;
        Wed, 29 Aug 2018 11:13:00 +0800 (CST)
X-RL-SENDER: hjc@rock-chips.com
X-FST-TO: hjc@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: hjc@rock-chips.com
X-UNIQUE-TAG: <e72880a6fcd0ef9bfb5bda6e7addd6be>
X-ATTACHMENT-NUM: 0
X-SENDER: hjc@rock-chips.com
X-DNS-TYPE: 0
Received: from unknown (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith SMTP id 31056FQQ2PI;
        Wed, 29 Aug 2018 11:13:01 +0800 (CST)
From:   Sandy Huang <hjc@rock-chips.com>
To:     hjc@rock-chips.com, heiko@sntech.de, seanpaul@chromium.org,
        David Airlie <airlied@linux.ie>
Cc:     linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 2/3] drm/rockchip: Add support for Rockchip Soc RGB output interface
Date:   Wed, 29 Aug 2018 11:12:43 +0800
Message-Id: <1535512364-80764-3-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535512364-80764-1-git-send-email-hjc@rock-chips.com>
References: <1535512364-80764-1-git-send-email-hjc@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Rockchip CRTCs, like rv1108 and px30, can directly output parallel
and serial RGB data to panel or conversion chip.

So add a feature-bit for vops to mark the ability for these direct
outputs and add an internal encoder in that case, that can attach to
bridge chipsor panels.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
Reviewed-by: Mark Yao <mark.yao@rock-chips.com>
---
 Changes in v7:
    1. forget to delete rockchip_rgb_driver and delete it.
 Changes in v6:
    1. Update according to Heiko Stuebner' implemention, rgb output is
       part of vop's feature, should not register as a independent
       driver.
Changes in v5:
    1. add SPDX-License-Identifier tag
Changes in v4:
    1. add support px30;
Changes in v3:
    1. update for rgb-mode move to panel node.
Changes in v2:
    1. add error log when probe failed;
    2. update name_to_output_mode() according to sean's suggest;	
    3. Fix uninitialized use of ret.
 
 
 drivers/gpu/drm/rockchip/Kconfig            |  11 ++
 drivers/gpu/drm/rockchip/Makefile           |   1 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  16 +++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |   1 +
 drivers/gpu/drm/rockchip/rockchip_rgb.c     | 173 ++++++++++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_rgb.h     |  20 ++++
 6 files changed, 222 insertions(+)
 create mode 100644 drivers/gpu/drm/rockchip/rockchip_rgb.c
 create mode 100644 drivers/gpu/drm/rockchip/rockchip_rgb.h

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
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 38f8cae..867b654 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -41,6 +41,7 @@
 #include "rockchip_drm_fb.h"
 #include "rockchip_drm_psr.h"
 #include "rockchip_drm_vop.h"
+#include "rockchip_rgb.h"
 
 #define VOP_WIN_SET(x, win, name, v) \
 		vop_reg_set(vop, &win->phy->name, win->base, ~0, v, #name)
@@ -92,6 +93,7 @@ struct vop_win {
 	struct vop *vop;
 };
 
+struct rockchip_rgb;
 struct vop {
 	struct drm_crtc crtc;
 	struct device *dev;
@@ -135,6 +137,9 @@ struct vop {
 	/* vop dclk reset */
 	struct reset_control *dclk_rst;
 
+	/* optional internal rgb encoder */
+	struct rockchip_rgb *rgb;
+
 	struct vop_win win[];
 };
 
@@ -1638,6 +1643,14 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 	if (ret)
 		goto err_disable_pm_runtime;
 
+	if (vop->data->feature & VOP_FEATURE_INTERNAL_RGB) {
+		vop->rgb = rockchip_rgb_init(dev, &vop->crtc, vop->drm_dev);
+		if (IS_ERR(vop->rgb)) {
+			ret = PTR_ERR(vop->rgb);
+			goto err_disable_pm_runtime;
+		}
+	}
+
 	return 0;
 
 err_disable_pm_runtime:
@@ -1650,6 +1663,9 @@ static void vop_unbind(struct device *dev, struct device *master, void *data)
 {
 	struct vop *vop = dev_get_drvdata(dev);
 
+	if (vop->rgb)
+		rockchip_rgb_fini(vop->rgb);
+
 	pm_runtime_disable(dev);
 	vop_destroy_crtc(vop);
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index fcb9104..fd5765d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -162,6 +162,7 @@ struct vop_data {
 	unsigned int win_size;
 
 #define VOP_FEATURE_OUTPUT_RGB10	BIT(0)
+#define VOP_FEATURE_INTERNAL_RGB	BIT(1)
 	u64 feature;
 };
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_rgb.c b/drivers/gpu/drm/rockchip/rockchip_rgb.c
new file mode 100644
index 0000000..e8d3215
--- /dev/null
+++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
@@ -0,0 +1,173 @@
+//SPDX-License-Identifier: GPL-2.0+
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
+#define encoder_to_rgb(c) container_of(c, struct rockchip_rgb, encoder)
+
+struct rockchip_rgb {
+	struct device *dev;
+	struct drm_device *drm_dev;
+	struct drm_bridge *bridge;
+	struct drm_encoder encoder;
+	int output_mode;
+};
+
+static int
+rockchip_rgb_encoder_atomic_check(struct drm_encoder *encoder,
+				   struct drm_crtc_state *crtc_state,
+				   struct drm_connector_state *conn_state)
+{
+	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc_state);
+	struct drm_connector *connector = conn_state->connector;
+	struct drm_display_info *info = &connector->display_info;
+	u32 bus_format;
+
+	if (info->num_bus_formats)
+		bus_format = info->bus_formats[0];
+	else
+		bus_format = MEDIA_BUS_FMT_RGB888_1X24;
+
+	switch (bus_format) {
+	case MEDIA_BUS_FMT_RGB666_1X18:
+		s->output_mode = ROCKCHIP_OUT_MODE_P666;
+		break;
+	case MEDIA_BUS_FMT_RGB565_1X16:
+		s->output_mode = ROCKCHIP_OUT_MODE_P565;
+		break;
+	case MEDIA_BUS_FMT_RGB888_1X24:
+	case MEDIA_BUS_FMT_RGB666_1X24_CPADHI:
+	default:
+		s->output_mode = ROCKCHIP_OUT_MODE_P888;
+		break;
+	}
+
+	s->output_type = DRM_MODE_CONNECTOR_LVDS;
+
+	return 0;
+}
+
+static const
+struct drm_encoder_helper_funcs rockchip_rgb_encoder_helper_funcs = {
+	.atomic_check = rockchip_rgb_encoder_atomic_check,
+};
+
+static const struct drm_encoder_funcs rockchip_rgb_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
+struct rockchip_rgb *rockchip_rgb_init(struct device *dev,
+				       struct drm_crtc *crtc,
+				       struct drm_device *drm_dev)
+{
+	struct rockchip_rgb *rgb;
+	struct drm_encoder *encoder;
+	struct device_node *port, *endpoint;
+	u32 endpoint_id;
+	int ret = 0, child_count = 0;
+	struct drm_panel *panel;
+	struct drm_bridge *bridge;
+
+	rgb = devm_kzalloc(dev, sizeof(*rgb), GFP_KERNEL);
+	if (!rgb)
+		return ERR_PTR(-ENOMEM);
+
+	rgb->dev = dev;
+	rgb->drm_dev = drm_dev;
+
+	port = of_graph_get_port_by_id(dev->of_node, 0);
+	if (!port)
+		return ERR_PTR(-EINVAL);
+
+	for_each_child_of_node(port, endpoint) {
+		if (of_property_read_u32(endpoint, "reg", &endpoint_id))
+			endpoint_id = 0;
+
+		if (rockchip_drm_endpoint_is_subdriver(endpoint))
+			continue;
+
+		child_count++;
+		ret = drm_of_find_panel_or_bridge(dev->of_node, 0, endpoint_id,
+						  &panel, &bridge);
+		if (!ret)
+			break;
+	}
+
+	of_node_put(port);
+
+	/* if the rgb output is not connected to anything, just return */
+	if (!child_count)
+		return NULL;
+
+	if (ret < 0) {
+		if (ret != -EPROBE_DEFER)
+			DRM_DEV_ERROR(dev, "failed to find panel or bridge %d\n", ret);
+		return ERR_PTR(ret);
+	}
+
+	encoder = &rgb->encoder;
+	encoder->possible_crtcs = drm_crtc_mask(crtc);
+
+	ret = drm_encoder_init(drm_dev, encoder, &rockchip_rgb_encoder_funcs,
+			       DRM_MODE_ENCODER_NONE, NULL);
+	if (ret < 0) {
+		DRM_DEV_ERROR(drm_dev->dev,
+			      "failed to initialize encoder: %d\n", ret);
+		return ERR_PTR(ret);
+	}
+
+	drm_encoder_helper_add(encoder, &rockchip_rgb_encoder_helper_funcs);
+
+	if (panel) {
+		bridge = drm_panel_bridge_add(panel, DRM_MODE_CONNECTOR_LVDS);
+		if (IS_ERR(bridge))
+			return ERR_CAST(bridge);
+	}
+
+	rgb->bridge = bridge;
+
+	ret = drm_bridge_attach(encoder, rgb->bridge, NULL);
+	if (ret) {
+		DRM_DEV_ERROR(drm_dev->dev,
+			      "failed to attach bridge: %d\n", ret);
+		goto err_free_encoder;
+	}
+
+	return rgb;
+
+err_free_encoder:
+	drm_encoder_cleanup(encoder);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(rockchip_rgb_init);
+
+void rockchip_rgb_fini(struct rockchip_rgb *rgb)
+{
+	drm_panel_bridge_remove(rgb->bridge);
+	drm_encoder_cleanup(&rgb->encoder);
+}
+EXPORT_SYMBOL_GPL(rockchip_rgb_fini);
diff --git a/drivers/gpu/drm/rockchip/rockchip_rgb.h b/drivers/gpu/drm/rockchip/rockchip_rgb.h
new file mode 100644
index 0000000..c712a67
--- /dev/null
+++ b/drivers/gpu/drm/rockchip/rockchip_rgb.h
@@ -0,0 +1,20 @@
+//SPDX-License-Identifier: GPL-2.0+
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
+struct rockchip_rgb *rockchip_rgb_init(struct device *dev,
+				       struct drm_crtc *crtc,
+				       struct drm_device *drm_dev);
+void rockchip_rgb_fini(struct rockchip_rgb *rgb);
-- 
2.7.4


