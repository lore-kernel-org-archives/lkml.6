Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751966AbeCNJM1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 05:12:27 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36661 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbeCNJMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 05:12:25 -0400
X-Google-Smtp-Source: AG47ELuS5yJgEsHpvTy0cbMQ+HK6VmVUNo8SORzmTwI/dnPdiSaNBIWUhXWsSycC9jcFqt3m0MpkfQ==
From: Lin Huang <hl@rock-chips.com>
To: thierry.reding@gmail.com
Cc: emil.l.velikov@gmail.com, briannorris@chromium.org, robh+dt@kernel.org,
        seanpaul@chromium.org, airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, huang lin <hl@rock-chips.com>
Subject: [PATCH v4 1/3] drm/panel: refactor INNOLUX P079ZCA panel driver
Date: Wed, 14 Mar 2018 17:12:14 +0800
Message-Id: <1521018736-20980-1-git-send-email-hl@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: huang lin <hl@rock-chips.com>

Refactor Innolux P079ZCA panel driver, let it support
multi panel.

Change-Id: If89be5e56dba8cb498e2d50c1bbeb0e8016123a2
Signed-off-by: Lin Huang <hl@rock-chips.com>
---
Changes in v2:
- Change regulator property name to meet the panel datasheet 
Changes in v3:
- this patch only refactor P079ZCA panel to support multi panel, support P097PFG panel in another patch 
Changes in v4:
- Modify the patch which suggest by Thierry
 
 drivers/gpu/drm/panel/panel-innolux-p079zca.c | 142 ++++++++++++++++++--------
 1 file changed, 101 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-innolux-p079zca.c b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
index 57df39b..2075a9d 100644
--- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
+++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
@@ -20,12 +20,28 @@
 
 #include <video/mipi_display.h>
 
+struct panel_desc {
+	const struct drm_display_mode *modes;
+	unsigned int bpc;
+	struct {
+		unsigned int width;
+		unsigned int height;
+	} size;
+
+	unsigned long flags;
+	enum mipi_dsi_pixel_format format;
+	unsigned int lanes;
+};
+
 struct innolux_panel {
 	struct drm_panel base;
 	struct mipi_dsi_device *link;
+	const struct panel_desc *desc;
 
 	struct backlight_device *backlight;
-	struct regulator *supply;
+	struct regulator *vddi;
+	struct regulator *avdd;
+	struct regulator *avee;
 	struct gpio_desc *enable_gpio;
 
 	bool prepared;
@@ -77,9 +93,9 @@ static int innolux_panel_unprepare(struct drm_panel *panel)
 	/* T8: 80ms - 1000ms */
 	msleep(80);
 
-	err = regulator_disable(innolux->supply);
-	if (err < 0)
-		return err;
+	regulator_disable(innolux->avee);
+	regulator_disable(innolux->avdd);
+	regulator_disable(innolux->vddi);
 
 	innolux->prepared = false;
 
@@ -89,17 +105,25 @@ static int innolux_panel_unprepare(struct drm_panel *panel)
 static int innolux_panel_prepare(struct drm_panel *panel)
 {
 	struct innolux_panel *innolux = to_innolux_panel(panel);
-	int err, regulator_err;
+	int err;
 
 	if (innolux->prepared)
 		return 0;
 
 	gpiod_set_value_cansleep(innolux->enable_gpio, 0);
 
-	err = regulator_enable(innolux->supply);
+	err = regulator_enable(innolux->vddi);
 	if (err < 0)
 		return err;
 
+	err = regulator_enable(innolux->avdd);
+	if (err < 0)
+		goto disable_vddi;
+
+	err = regulator_enable(innolux->avee);
+	if (err < 0)
+		goto disable_avdd;
+
 	/* T2: 15ms - 1000ms */
 	usleep_range(15000, 16000);
 
@@ -133,12 +157,13 @@ static int innolux_panel_prepare(struct drm_panel *panel)
 	return 0;
 
 poweroff:
-	regulator_err = regulator_disable(innolux->supply);
-	if (regulator_err)
-		DRM_DEV_ERROR(panel->dev, "failed to disable regulator: %d\n",
-			      regulator_err);
-
 	gpiod_set_value_cansleep(innolux->enable_gpio, 0);
+	regulator_disable(innolux->avee);
+disable_avdd:
+	regulator_disable(innolux->avdd);
+disable_vddi:
+	regulator_disable(innolux->vddi);
+
 	return err;
 }
 
@@ -162,7 +187,7 @@ static int innolux_panel_enable(struct drm_panel *panel)
 	return 0;
 }
 
-static const struct drm_display_mode default_mode = {
+static const struct drm_display_mode innolux_p079zca_mode = {
 	.clock = 56900,
 	.hdisplay = 768,
 	.hsync_start = 768 + 40,
@@ -175,15 +200,29 @@ static const struct drm_display_mode default_mode = {
 	.vrefresh = 60,
 };
 
+static const struct panel_desc innolux_p079zca_panel_desc = {
+	.modes = &innolux_p079zca_mode,
+	.bpc = 8,
+	.size = {
+		.width = 120,
+		.height = 160,
+	},
+	.flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+		 MIPI_DSI_MODE_LPM,
+	.format = MIPI_DSI_FMT_RGB888,
+	.lanes = 4,
+};
+
 static int innolux_panel_get_modes(struct drm_panel *panel)
 {
 	struct drm_display_mode *mode;
+	struct innolux_panel *innolux = to_innolux_panel(panel);
+	const struct drm_display_mode *m = innolux->desc->modes;
 
-	mode = drm_mode_duplicate(panel->drm, &default_mode);
+	mode = drm_mode_duplicate(panel->drm, m);
 	if (!mode) {
 		DRM_DEV_ERROR(panel->drm->dev, "failed to add mode %ux%ux@%u\n",
-			      default_mode.hdisplay, default_mode.vdisplay,
-			      default_mode.vrefresh);
+			      m->hdisplay, m->vdisplay, m->vrefresh);
 		return -ENOMEM;
 	}
 
@@ -191,9 +230,11 @@ static int innolux_panel_get_modes(struct drm_panel *panel)
 
 	drm_mode_probed_add(panel->connector, mode);
 
-	panel->connector->display_info.width_mm = 120;
-	panel->connector->display_info.height_mm = 160;
-	panel->connector->display_info.bpc = 8;
+	panel->connector->display_info.width_mm =
+			innolux->desc->size.width;
+	panel->connector->display_info.height_mm =
+			innolux->desc->size.height;
+	panel->connector->display_info.bpc = innolux->desc->bpc;
 
 	return 1;
 }
@@ -207,19 +248,28 @@ static const struct drm_panel_funcs innolux_panel_funcs = {
 };
 
 static const struct of_device_id innolux_of_match[] = {
-	{ .compatible = "innolux,p079zca", },
+	{ .compatible = "innolux,p079zca",
+	  .data = &innolux_p079zca_panel_desc
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, innolux_of_match);
 
-static int innolux_panel_add(struct innolux_panel *innolux)
+static int innolux_panel_add(struct mipi_dsi_device *dsi,
+			     const struct panel_desc *desc)
 {
-	struct device *dev = &innolux->link->dev;
+	struct innolux_panel *innolux;
+	struct device *dev = &dsi->dev;
 	int err;
 
-	innolux->supply = devm_regulator_get(dev, "power");
-	if (IS_ERR(innolux->supply))
-		return PTR_ERR(innolux->supply);
+	innolux = devm_kzalloc(dev, sizeof(*innolux), GFP_KERNEL);
+	if (!innolux)
+		return -ENOMEM;
+
+	innolux->desc = desc;
+	innolux->vddi = devm_regulator_get(dev, "power");
+	innolux->avdd = devm_regulator_get(dev, "avdd");
+	innolux->avee = devm_regulator_get(dev, "avee");
 
 	innolux->enable_gpio = devm_gpiod_get_optional(dev, "enable",
 						       GPIOD_OUT_HIGH);
@@ -236,9 +286,21 @@ static int innolux_panel_add(struct innolux_panel *innolux)
 
 	drm_panel_init(&innolux->base);
 	innolux->base.funcs = &innolux_panel_funcs;
-	innolux->base.dev = &innolux->link->dev;
+	innolux->base.dev = dev;
+
+	err = drm_panel_add(&innolux->base);
+	if (err < 0)
+		goto put_backlight;
+
+	dev_set_drvdata(dev, innolux);
+	innolux->link = dsi;
+
+	return 0;
+
+put_backlight:
+	put_device(&innolux->backlight->dev);
 
-	return drm_panel_add(&innolux->base);
+	return err;
 }
 
 static void innolux_panel_del(struct innolux_panel *innolux)
@@ -249,28 +311,25 @@ static void innolux_panel_del(struct innolux_panel *innolux)
 
 static int innolux_panel_probe(struct mipi_dsi_device *dsi)
 {
-	struct innolux_panel *innolux;
-	int err;
 
-	dsi->lanes = 4;
-	dsi->format = MIPI_DSI_FMT_RGB888;
-	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
-			  MIPI_DSI_MODE_LPM;
-
-	innolux = devm_kzalloc(&dsi->dev, sizeof(*innolux), GFP_KERNEL);
-	if (!innolux)
-		return -ENOMEM;
+	const struct panel_desc *desc;
+	const struct of_device_id *id;
+	int err;
 
-	mipi_dsi_set_drvdata(dsi, innolux);
+	id = of_match_node(innolux_of_match, dsi->dev.of_node);
+	if (!id)
+		return -ENODEV;
 
-	innolux->link = dsi;
+	desc = id->data;
+	dsi->mode_flags = desc->flags;
+	dsi->format = desc->format;
+	dsi->lanes = desc->lanes;
 
-	err = innolux_panel_add(innolux);
+	err = innolux_panel_add(dsi, desc);
 	if (err < 0)
 		return err;
 
-	err = mipi_dsi_attach(dsi);
-	return err;
+	return mipi_dsi_attach(dsi);
 }
 
 static int innolux_panel_remove(struct mipi_dsi_device *dsi)
@@ -318,5 +377,6 @@ static struct mipi_dsi_driver innolux_panel_driver = {
 module_mipi_dsi_driver(innolux_panel_driver);
 
 MODULE_AUTHOR("Chris Zhong <zyw@rock-chips.com>");
+MODULE_AUTHOR("Lin Huang <hl@rock-chips.com>");
 MODULE_DESCRIPTION("Innolux P079ZCA panel driver");
 MODULE_LICENSE("GPL v2");
-- 
2.7.4
