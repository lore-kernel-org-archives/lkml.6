Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA2DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F542184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbeLSLUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 06:20:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:34908 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726652AbeLSLUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 06:20:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BC424B0A5;
        Wed, 19 Dec 2018 11:20:43 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     afaerber@suse.de, agraf@suse.de,
        linux-rpi-kernel@lists.infradead.org, stefan.wahren@i2se.com,
        eric@anholt.net, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/panel: rpi-touchscreen: Add backlight support
Date:   Wed, 19 Dec 2018 12:20:32 +0100
Message-Id: <20181219112033.31064-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch exposes backlight control into userspace by creating a
backlight device instead of directly accessing the PWM registers.

The backlight driver can't go on a separate file as it shares the I2C
bus & address with the panel.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
v1 -> v2:
  - Add Kconfig dependency with BACKLIGHT_CLASS_DEVICE

 drivers/gpu/drm/panel/Kconfig                 |  1 +
 .../drm/panel/panel-raspberrypi-touchscreen.c | 33 +++++++++++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 6020c30a33b3..1ce35483f342 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -112,6 +112,7 @@ config DRM_PANEL_PANASONIC_VVX10F034N00
 config DRM_PANEL_RASPBERRYPI_TOUCHSCREEN
 	tristate "Raspberry Pi 7-inch touchscreen panel"
 	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
 	help
 	  Say Y here if you want to enable support for the Raspberry
 	  Pi 7" Touchscreen.  To compile this driver as a module,
diff --git a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
index 2c9c9722734f..838b5c8767bc 100644
--- a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
+++ b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
@@ -52,6 +52,7 @@
 #include <linux/of_device.h>
 #include <linux/of_graph.h>
 #include <linux/pm.h>
+#include <linux/backlight.h>
 
 #include <drm/drm_panel.h>
 #include <drm/drmP.h>
@@ -196,6 +197,7 @@ struct rpi_touchscreen {
 	struct drm_panel base;
 	struct mipi_dsi_device *dsi;
 	struct i2c_client *i2c;
+	struct backlight_device *backlight;
 };
 
 static const struct drm_display_mode rpi_touchscreen_modes[] = {
@@ -256,7 +258,8 @@ static int rpi_touchscreen_disable(struct drm_panel *panel)
 {
 	struct rpi_touchscreen *ts = panel_to_ts(panel);
 
-	rpi_touchscreen_i2c_write(ts, REG_PWM, 0);
+	ts->backlight->props.brightness = 0;
+	backlight_update_status(ts->backlight);
 
 	rpi_touchscreen_i2c_write(ts, REG_POWERON, 0);
 	udelay(1);
@@ -300,7 +303,8 @@ static int rpi_touchscreen_enable(struct drm_panel *panel)
 	msleep(100);
 
 	/* Turn on the backlight. */
-	rpi_touchscreen_i2c_write(ts, REG_PWM, 255);
+	ts->backlight->props.brightness = 255;
+	backlight_update_status(ts->backlight);
 
 	/* Default to the same orientation as the closed source
 	 * firmware used for the panel.  Runtime rotation
@@ -358,12 +362,26 @@ static const struct drm_panel_funcs rpi_touchscreen_funcs = {
 	.get_modes = rpi_touchscreen_get_modes,
 };
 
+static int raspberrypi_bl_update_status(struct backlight_device *bl)
+{
+	struct rpi_touchscreen *ts = bl_get_data(bl);
+
+	rpi_touchscreen_i2c_write(ts, REG_PWM, bl->props.brightness);
+
+	return 0;
+}
+
+static const struct backlight_ops raspberrypi_bl_ops = {
+	.update_status = raspberrypi_bl_update_status,
+};
+
 static int rpi_touchscreen_probe(struct i2c_client *i2c,
 				 const struct i2c_device_id *id)
 {
 	struct device *dev = &i2c->dev;
 	struct rpi_touchscreen *ts;
 	struct device_node *endpoint, *dsi_host_node;
+	struct backlight_properties props;
 	struct mipi_dsi_host *host;
 	int ret, ver;
 	struct mipi_dsi_device_info info = {
@@ -398,6 +416,17 @@ static int rpi_touchscreen_probe(struct i2c_client *i2c,
 	/* Turn off at boot, so we can cleanly sequence powering on. */
 	rpi_touchscreen_i2c_write(ts, REG_POWERON, 0);
 
+	memset(&props, 0, sizeof(props));
+	props.type = BACKLIGHT_RAW;
+	props.max_brightness = 255;
+	ts->backlight = devm_backlight_device_register(dev, dev_name(dev), dev,
+						       ts, &raspberrypi_bl_ops,
+						       &props);
+	if (IS_ERR(ts->backlight)) {
+		dev_err(dev, "Failed to create backlight device\n");
+		return PTR_ERR(ts->backlight);
+	}
+
 	/* Look up the DSI host.  It needs to probe before we do. */
 	endpoint = of_graph_get_next_endpoint(dev->of_node, NULL);
 	dsi_host_node = of_graph_get_remote_port_parent(endpoint);
-- 
2.19.2

