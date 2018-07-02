Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09935C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B873525C87
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:28:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B873525C87
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965616AbeGBK2S (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:28:18 -0400
Received: from gloria.sntech.de ([185.11.138.130]:36166 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965272AbeGBK1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:27:37 -0400
Received: from wd0142.dip.tu-dresden.de ([141.76.108.142] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fZw3P-0004Ek-JU; Mon, 02 Jul 2018 12:27:31 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     thierry.reding@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, seanpaul@chromium.org,
        briannorris@chromium.org, hl@rock-chips.com,
        emil.l.velikov@gmail.com, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v5 1/4] drm/panel: p079zca: refactor panel driver to support multiple panels
Date:   Mon,  2 Jul 2018 12:27:18 +0200
Message-Id: <20180702102721.3546-2-heiko@sntech.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180702102721.3546-1-heiko@sntech.de>
References: <20180702102721.3546-1-heiko@sntech.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: huang lin <hl@rock-chips.com>

Refactor Innolux P079ZCA panel driver, let it support
multi panels from Innolux that share similar power sequences.

Panels may require different power supplies so use regulator bulk
interfaces and define per panel supply-names.

Changes in v2:
- Change regulator property name to meet the panel datasheet
Changes in v3:
- this patch only refactor P079ZCA panel to support multi panel,
  support P097PFG panel in another patch
Changes in v4:
- Modify the patch which suggest by Thierry
Changes in v5:
- use regulator_bulk to handle different supply number

Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/panel/panel-innolux-p079zca.c | 143 ++++++++++++------
 1 file changed, 100 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-innolux-p079zca.c b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
index bb53e0850764..840ad4a6a6a6 100644
--- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
+++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
@@ -20,12 +20,29 @@
 
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
+	const char * const *supply_names;
+	unsigned int num_supplies;
+};
+
 struct innolux_panel {
 	struct drm_panel base;
 	struct mipi_dsi_device *link;
+	const struct panel_desc *desc;
 
 	struct backlight_device *backlight;
-	struct regulator *supply;
+	struct regulator_bulk_data *supplies;
+	unsigned int num_supplies;
 	struct gpio_desc *enable_gpio;
 
 	bool prepared;
@@ -77,9 +94,7 @@ static int innolux_panel_unprepare(struct drm_panel *panel)
 	/* T8: 80ms - 1000ms */
 	msleep(80);
 
-	err = regulator_disable(innolux->supply);
-	if (err < 0)
-		return err;
+	regulator_bulk_disable(innolux->desc->num_supplies, innolux->supplies);
 
 	innolux->prepared = false;
 
@@ -89,14 +104,15 @@ static int innolux_panel_unprepare(struct drm_panel *panel)
 static int innolux_panel_prepare(struct drm_panel *panel)
 {
 	struct innolux_panel *innolux = to_innolux_panel(panel);
-	int err, regulator_err;
+	int err;
 
 	if (innolux->prepared)
 		return 0;
 
 	gpiod_set_value_cansleep(innolux->enable_gpio, 0);
 
-	err = regulator_enable(innolux->supply);
+	err = regulator_bulk_enable(innolux->desc->num_supplies,
+				    innolux->supplies);
 	if (err < 0)
 		return err;
 
@@ -133,12 +149,9 @@ static int innolux_panel_prepare(struct drm_panel *panel)
 	return 0;
 
 poweroff:
-	regulator_err = regulator_disable(innolux->supply);
-	if (regulator_err)
-		DRM_DEV_ERROR(panel->dev, "failed to disable regulator: %d\n",
-			      regulator_err);
-
 	gpiod_set_value_cansleep(innolux->enable_gpio, 0);
+	regulator_bulk_disable(innolux->desc->num_supplies, innolux->supplies);
+
 	return err;
 }
 
@@ -162,7 +175,11 @@ static int innolux_panel_enable(struct drm_panel *panel)
 	return 0;
 }
 
-static const struct drm_display_mode default_mode = {
+static const char * const innolux_p079zca_supply_names[] = {
+	"power",
+};
+
+static const struct drm_display_mode innolux_p079zca_mode = {
 	.clock = 56900,
 	.hdisplay = 768,
 	.hsync_start = 768 + 40,
@@ -175,15 +192,31 @@ static const struct drm_display_mode default_mode = {
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
+	.supply_names = innolux_p079zca_supply_names,
+	.num_supplies = ARRAY_SIZE(innolux_p079zca_supply_names),
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
 
@@ -191,9 +224,11 @@ static int innolux_panel_get_modes(struct drm_panel *panel)
 
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
@@ -207,19 +242,38 @@ static const struct drm_panel_funcs innolux_panel_funcs = {
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
-	int err;
+	struct innolux_panel *innolux;
+	struct device *dev = &dsi->dev;
+	int err, i;
 
-	innolux->supply = devm_regulator_get(dev, "power");
-	if (IS_ERR(innolux->supply))
-		return PTR_ERR(innolux->supply);
+	innolux = devm_kzalloc(dev, sizeof(*innolux), GFP_KERNEL);
+	if (!innolux)
+		return -ENOMEM;
+
+	innolux->desc = desc;
+
+	innolux->supplies = devm_kcalloc(dev, desc->num_supplies,
+				     sizeof(*innolux->supplies), GFP_KERNEL);
+	if (!innolux->supplies)
+		return -ENOMEM;
+
+	for (i = 0; i < desc->num_supplies; i++)
+		innolux->supplies[i].supply = desc->supply_names[i];
+
+	err = devm_regulator_bulk_get(dev, desc->num_supplies,
+					   innolux->supplies);
+	if (err < 0)
+		return err;
 
 	innolux->enable_gpio = devm_gpiod_get_optional(dev, "enable",
 						       GPIOD_OUT_HIGH);
@@ -230,15 +284,21 @@ static int innolux_panel_add(struct innolux_panel *innolux)
 	}
 
 	innolux->backlight = devm_of_find_backlight(dev);
-
 	if (IS_ERR(innolux->backlight))
 		return PTR_ERR(innolux->backlight);
 
 	drm_panel_init(&innolux->base);
 	innolux->base.funcs = &innolux_panel_funcs;
-	innolux->base.dev = &innolux->link->dev;
+	innolux->base.dev = dev;
+
+	err = drm_panel_add(&innolux->base);
+	if (err < 0)
+		return err;
+
+	mipi_dsi_set_drvdata(dsi, innolux);
+	innolux->link = dsi;
 
-	return drm_panel_add(&innolux->base);
+	return 0;
 }
 
 static void innolux_panel_del(struct innolux_panel *innolux)
@@ -249,28 +309,24 @@ static void innolux_panel_del(struct innolux_panel *innolux)
 
 static int innolux_panel_probe(struct mipi_dsi_device *dsi)
 {
-	struct innolux_panel *innolux;
+	const struct panel_desc *desc;
+	const struct of_device_id *id;
 	int err;
 
-	dsi->lanes = 4;
-	dsi->format = MIPI_DSI_FMT_RGB888;
-	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
-			  MIPI_DSI_MODE_LPM;
-
-	innolux = devm_kzalloc(&dsi->dev, sizeof(*innolux), GFP_KERNEL);
-	if (!innolux)
-		return -ENOMEM;
-
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
@@ -317,5 +373,6 @@ static struct mipi_dsi_driver innolux_panel_driver = {
 module_mipi_dsi_driver(innolux_panel_driver);
 
 MODULE_AUTHOR("Chris Zhong <zyw@rock-chips.com>");
+MODULE_AUTHOR("Lin Huang <hl@rock-chips.com>");
 MODULE_DESCRIPTION("Innolux P079ZCA panel driver");
 MODULE_LICENSE("GPL v2");
-- 
2.17.0

