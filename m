Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682B9C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081BF2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081BF2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeH1MWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:22:09 -0400
Received: from gloria.sntech.de ([185.11.138.130]:59754 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbeH1MWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:22:09 -0400
Received: from wd0180.dip.tu-dresden.de ([141.76.108.180] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fuZPK-0003kU-3Q; Tue, 28 Aug 2018 10:31:26 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Sandy Huang <hjc@rock-chips.com>
Cc:     robh@kernel.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v5 2/2] drm/rockchip: Add support for Rockchip Soc RGB output interface
Date:   Tue, 28 Aug 2018 10:31:25 +0200
Message-ID: <2164089.bDJbLuhFGU@phil>
In-Reply-To: <1535443954-38806-3-git-send-email-hjc@rock-chips.com>
References: <1535443954-38806-1-git-send-email-hjc@rock-chips.com> <1535443954-38806-3-git-send-email-hjc@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart3268395.uggG6mqk6v"
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart3268395.uggG6mqk6v
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Sandy,

Am Dienstag, 28. August 2018, 10:12:34 CEST schrieb Sandy Huang:
> Some Rockchip CRTCs, like rv1108 and px30, can directly output parallel
> and serial RGB data to panel or conversion chip, so we add this driver
> to probe encoder and connector.
> 
> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> Reviewed-by: Sean Paul <seanpaul@chromium.org>
> Reviewed-by: Mark Yao <mark.yao@rock-chips.com>
> Link: https://patchwork.freedesktop.org/patch/msgid/1509522851-128181-1-git-send-email-hjc@rock-chips.com

This does not really address, Rob's concern about not being an actual
hardware block related to the devicetree node you are using.

I see your reply to my mail, but I guess you didn't see the alternative
approach I described a bit below in that mail?

Actual (unfinished) code included below. (2 patches)

Heiko



---- 8< -----
From: Heiko Stuebner <heiko@sntech.de>
Date: Sat, 25 Aug 2018 19:05:21 +0200
Subject: [PATCH 1/2] drm/tockchip: add function to check if endpoint is a
 subdriver

To be able to have both internal subdrivers and external bridge
drivers as output endpoints of vops, add a function to be able
to distinguish these.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 27 +++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |  1 +
 2 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 1d9c4a9201c8..d18f7f85aa23 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -24,6 +24,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/module.h>
 #include <linux/of_graph.h>
+#include <linux/of_platform.h>
 #include <linux/component.h>
 #include <linux/console.h>
 #include <linux/iommu.h>
@@ -267,6 +268,32 @@ static const struct dev_pm_ops rockchip_drm_pm_ops = {
 static struct platform_driver *rockchip_sub_drivers[MAX_ROCKCHIP_SUB_DRIVERS];
 static int num_rockchip_sub_drivers;
 
+/*
+ * check if a vop output-endpoint is a subdriver or bridge.
+ */
+bool rockchip_drm_endpoint_is_subdriver(struct device_node *ep)
+{
+	struct device_node *node = of_graph_get_remote_port_parent(ep);
+	struct platform_device *pdev;
+	int i;
+
+	if (!node)
+		return false;
+
+	pdev = of_find_device_by_node(node);
+	if (!pdev)
+		return false;
+
+	for (i = 0; i < num_rockchip_sub_drivers; i++) {
+		struct device_driver *drv = pdev->dev.driver;
+
+		if (rockchip_sub_drivers[i] == to_platform_driver(drv))
+			return true;
+	}
+
+	return false;
+}
+
 static int compare_dev(struct device *dev, void *data)
 {
 	return dev == (struct device *)data;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index d67ad0a3cf36..305b4858c522 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -64,6 +64,7 @@ void rockchip_drm_dma_detach_device(struct drm_device *drm_dev,
 				    struct device *dev);
 int rockchip_drm_wait_vact_end(struct drm_crtc *crtc, unsigned int mstimeout);
 
+bool rockchip_drm_endpoint_is_subdriver(struct device_node *ep);
 extern struct platform_driver cdn_dp_driver;
 extern struct platform_driver dw_hdmi_rockchip_pltfm_driver;
 extern struct platform_driver dw_mipi_dsi_driver;
-- 
2.17.0
---- 8< -----
From: Sandy Huang <hjc@rock-chips.com>
Date: Tue, 26 Jun 2018 15:15:40 +0800
Subject: [PATCH 2/2] drm/rockchip: Add support for RGB output interface

Some Rockchip CRTCs, like rv1108 and px30, can directly output parallel
and serial RGB data to panel or conversion chip.

So add a feature-bit for vops to mark the ability for these direct outputs
and add an internal encoder in that case, that can attach to bridge chips
or panels.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/rockchip/Kconfig            |  11 +
 drivers/gpu/drm/rockchip/Makefile           |   1 +
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  16 ++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h |   1 +
 drivers/gpu/drm/rockchip/rockchip_rgb.c     | 212 ++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_rgb.h     |  19 ++
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c |   1 +
 7 files changed, 261 insertions(+)
 create mode 100644 drivers/gpu/drm/rockchip/rockchip_rgb.c
 create mode 100644 drivers/gpu/drm/rockchip/rockchip_rgb.h

diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index 0ccc76217ee4..e88eb715ae6b 100644
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
index a314e2109e76..868263ff0302 100644
--- a/drivers/gpu/drm/rockchip/Makefile
+++ b/drivers/gpu/drm/rockchip/Makefile
@@ -14,5 +14,6 @@ rockchipdrm-$(CONFIG_ROCKCHIP_DW_HDMI) += dw_hdmi-rockchip.o
 rockchipdrm-$(CONFIG_ROCKCHIP_DW_MIPI_DSI) += dw-mipi-dsi.o
 rockchipdrm-$(CONFIG_ROCKCHIP_INNO_HDMI) += inno_hdmi.o
 rockchipdrm-$(CONFIG_ROCKCHIP_LVDS) += rockchip_lvds.o
+rockchipdrm-$(CONFIG_ROCKCHIP_RGB) += rockchip_rgb.o
 
 obj-$(CONFIG_DRM_ROCKCHIP) += rockchipdrm.o
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 38f8cae7ef51..867b654fe2a3 100644
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
index fcb91041a666..fd5765dfd637 100644
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
index 000000000000..6180369e591f
--- /dev/null
+++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
@@ -0,0 +1,212 @@
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
+//	struct dev_pin_info *pins;
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
+static void rockchip_rgb_encoder_enable(struct drm_encoder *encoder)
+{
+	struct rockchip_rgb *rgb = encoder_to_rgb(encoder);
+
+//	if (rgb->pins && !IS_ERR(rgb->pins->default_state))
+//		pinctrl_select_state(rgb->pins->p, rgb->pins->default_state);
+}
+
+static void rockchip_rgb_encoder_disable(struct drm_encoder *encoder)
+{
+	struct rockchip_rgb *rgb = encoder_to_rgb(encoder);
+
+//FIXME: pin-voodoo?
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
+/*	rgb->pins = devm_kzalloc(rgb->dev, sizeof(*rgb->pins), GFP_KERNEL);
+	if (!rgb->pins)
+		return -ENOMEM; */
+
+/*	rgb->pins->p = devm_pinctrl_get(rgb->dev);
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
+	} */
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
+	rgb->output_mode = ROCKCHIP_OUT_MODE_P888;
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
+	rockchip_rgb_encoder_disable(&rgb->encoder);
+
+	drm_panel_bridge_remove(rgb->bridge);
+	drm_encoder_cleanup(&rgb->encoder);
+}
+EXPORT_SYMBOL_GPL(rockchip_rgb_fini);
diff --git a/drivers/gpu/drm/rockchip/rockchip_rgb.h b/drivers/gpu/drm/rockchip/rockchip_rgb.h
new file mode 100644
index 000000000000..16f05d50abc3
--- /dev/null
+++ b/drivers/gpu/drm/rockchip/rockchip_rgb.h
@@ -0,0 +1,19 @@
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
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 0c5358350159..f4dd0b143467 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -487,6 +487,7 @@ static const struct vop_data rk3188_vop = {
 	.output = &rk3188_output,
 	.win = rk3188_vop_win_data,
 	.win_size = ARRAY_SIZE(rk3188_vop_win_data),
+	.feature = VOP_FEATURE_INTERNAL_RGB,
 };
 
 static const struct vop_scl_extension rk3288_win_full_scl_ext = {
-- 
2.17.0

--nextPart3268395.uggG6mqk6v
Content-Disposition: attachment; filename="0001-drm-tockchip-add-function-to-check-if-endpoint-is-a-.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-drm-tockchip-add-function-to-check-if-endpoint-is-a-.patch"

From c5a48c772f3564211dcd1ec71004de1d6dbb0307 Mon Sep 17 00:00:00 2001
From: Heiko Stuebner <heiko@sntech.de>
Date: Sat, 25 Aug 2018 19:05:21 +0200
Subject: [PATCH 1/2] drm/tockchip: add function to check if endpoint is a
 subdriver

To be able to have both internal subdrivers and external bridge
drivers as output endpoints of vops, add a function to be able
to distinguish these.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 27 +++++++++++++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |  1 +
 2 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 1d9c4a9201c8..d18f7f85aa23 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -24,6 +24,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/module.h>
 #include <linux/of_graph.h>
+#include <linux/of_platform.h>
 #include <linux/component.h>
 #include <linux/console.h>
 #include <linux/iommu.h>
@@ -267,6 +268,32 @@ static const struct dev_pm_ops rockchip_drm_pm_ops = {
 static struct platform_driver *rockchip_sub_drivers[MAX_ROCKCHIP_SUB_DRIVERS];
 static int num_rockchip_sub_drivers;
 
+/*
+ * check if a vop output-endpoint is a subdriver or bridge.
+ */
+bool rockchip_drm_endpoint_is_subdriver(struct device_node *ep)
+{
+	struct device_node *node = of_graph_get_remote_port_parent(ep);
+	struct platform_device *pdev;
+	int i;
+
+	if (!node)
+		return false;
+
+	pdev = of_find_device_by_node(node);
+	if (!pdev)
+		return false;
+
+	for (i = 0; i < num_rockchip_sub_drivers; i++) {
+		struct device_driver *drv = pdev->dev.driver;
+
+		if (rockchip_sub_drivers[i] == to_platform_driver(drv))
+			return true;
+	}
+
+	return false;
+}
+
 static int compare_dev(struct device *dev, void *data)
 {
 	return dev == (struct device *)data;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index d67ad0a3cf36..305b4858c522 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -64,6 +64,7 @@ void rockchip_drm_dma_detach_device(struct drm_device *drm_dev,
 				    struct device *dev);
 int rockchip_drm_wait_vact_end(struct drm_crtc *crtc, unsigned int mstimeout);
 
+bool rockchip_drm_endpoint_is_subdriver(struct device_node *ep);
 extern struct platform_driver cdn_dp_driver;
 extern struct platform_driver dw_hdmi_rockchip_pltfm_driver;
 extern struct platform_driver dw_mipi_dsi_driver;
-- 
2.17.0


--nextPart3268395.uggG6mqk6v--



