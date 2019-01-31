Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9820C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A743620B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8TmN9iZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfAaT1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:27:39 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40482 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728754AbfAaT0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:26:45 -0500
Received: by mail-lj1-f193.google.com with SMTP id n18-v6so3681042lji.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lu1s1qSkbM2h9o3dmEeW/waiiJvpRwtbQrFIWhwDPL8=;
        b=P8TmN9iZyeYJEzQHZ9FySbLLdKCfNGQWXCUuCCrGvgusUoeHUZchWMANhtD8dRJUwo
         ie2pi+L8veEhMrSYTxpHisnbNdDujtVuwjY2PXyS7vHj4j6tQkS+zasyRIsHIilZFw3p
         DkCUcytqgqW+TrYaav+Ra+VLz/gpr0DP4qik6wcehgWXBDXH2DehNbRJYLsU1aSikFZ8
         7NDKrBuLEXAlGPGhDriGO8dHc1OH0HR6bbHKE2yQYUR/bH0iT9Q+lq1k1Gb55Go4aQMw
         58FUdlFMl7tN+E1VJNPPjwyHM8zw+YzrVrCnoITh9jKirvyyhsN8G1at51pfx4TFDaR1
         eXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=lu1s1qSkbM2h9o3dmEeW/waiiJvpRwtbQrFIWhwDPL8=;
        b=S1nGPFoi+laeH9VDRupeRmsKPmjk8oqCVlFjReb36u962ytL6LPkGgvhmzr5KMBQ/e
         jG1WJxj65NYAgLkJzr1hmtFeXolZbL53bxYMViGYU0GtT1K2ufy4ZimDwUq7tbm8Vu2M
         JUa9A6aWV7oZfO1XhoNxfQS7vznX1PjscbLs0VAZpbn8N7LpB1Ky/TgG0qcHvy0v88FF
         YBE2SzUvTowX0rUvpD7VS08Y2NO31WtrMJyxWe6vTaqz8PX8L55iEe/F+vGX3Xd10BC5
         ntDFXtW97bizZEvoeWrXZwL+hACPR2zmHGo+R6MKWSeglDfVhMRMU6uObk8mKs6JE9hj
         AVXg==
X-Gm-Message-State: AJcUukcoOP2aNPlse/yjIg1fKIrelKsQ6ck1sZoXDyvyw/F0jbhXxtIi
        6xGjixe2EeOOQjF/IgCOHzw60ID4
X-Google-Smtp-Source: ALg8bN6Gm+NdZFaP+DTw9dB0KxcbTZ2p0ZUmbwoZaa+9ZTzV/GEq4iYAxMzby7Orv9X3fgPh1tArWQ==
X-Received: by 2002:a2e:5cc8:: with SMTP id q191-v6mr28859283ljb.192.1548962803394;
        Thu, 31 Jan 2019 11:26:43 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id f1sm987363lfm.22.2019.01.31.11.26.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:26:42 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 09/19] drm/panel: jdi: use DRM_DEV*
Date:   Thu, 31 Jan 2019 20:26:09 +0100
Message-Id: <20190131192619.9763-10-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190131192619.9763-1-sam@ravnborg.org>
References: <20190131192619.9763-1-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce use of DRM_DEV* for logging.
This makes logging in the drm subsystem more consistent.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/panel/panel-jdi-lt070me05000.c | 64 ++++++++++++++------------
 1 file changed, 34 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
index fecdda0b99a5..6e172b5d7dff 100644
--- a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
+++ b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
@@ -31,6 +31,7 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_panel.h>
+#include <drm/drm_print.h>
 
 #include <video/mipi_display.h>
 
@@ -77,19 +78,19 @@ static int jdi_panel_init(struct jdi_panel *jdi)
 
 	ret = mipi_dsi_dcs_set_pixel_format(dsi, MIPI_DCS_PIXEL_FMT_24BIT << 4);
 	if (ret < 0) {
-		dev_err(dev, "failed to set pixel format: %d\n", ret);
+		DRM_DEV_ERROR(dev, "failed to set pixel format: %d\n", ret);
 		return ret;
 	}
 
 	ret = mipi_dsi_dcs_set_column_address(dsi, 0, jdi->mode->hdisplay - 1);
 	if (ret < 0) {
-		dev_err(dev, "failed to set column address: %d\n", ret);
+		DRM_DEV_ERROR(dev, "failed to set column address: %d\n", ret);
 		return ret;
 	}
 
 	ret = mipi_dsi_dcs_set_page_address(dsi, 0, jdi->mode->vdisplay - 1);
 	if (ret < 0) {
-		dev_err(dev, "failed to set page address: %d\n", ret);
+		DRM_DEV_ERROR(dev, "failed to set page address: %d\n", ret);
 		return ret;
 	}
 
@@ -102,7 +103,8 @@ static int jdi_panel_init(struct jdi_panel *jdi)
 	ret = mipi_dsi_dcs_write(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY,
 				 (u8[]){ 0x24 }, 1);
 	if (ret < 0) {
-		dev_err(dev, "failed to write control display: %d\n", ret);
+		DRM_DEV_ERROR(dev,
+			      "failed to write control display: %d\n", ret);
 		return ret;
 	}
 
@@ -110,13 +112,13 @@ static int jdi_panel_init(struct jdi_panel *jdi)
 	ret = mipi_dsi_dcs_write(dsi, MIPI_DCS_WRITE_POWER_SAVE,
 				 (u8[]){ 0x00 }, 1);
 	if (ret < 0) {
-		dev_err(dev, "failed to set cabc off: %d\n", ret);
+		DRM_DEV_ERROR(dev, "failed to set cabc off: %d\n", ret);
 		return ret;
 	}
 
 	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
 	if (ret < 0) {
-		dev_err(dev, "failed to set exit sleep mode: %d\n", ret);
+		DRM_DEV_ERROR(dev, "failed to set exit sleep mode: %d\n", ret);
 		return ret;
 	}
 
@@ -124,7 +126,7 @@ static int jdi_panel_init(struct jdi_panel *jdi)
 
 	ret = mipi_dsi_generic_write(dsi, (u8[]){0xB0, 0x00}, 2);
 	if (ret < 0) {
-		dev_err(dev, "failed to set mcap: %d\n", ret);
+		DRM_DEV_ERROR(dev, "failed to set mcap: %d\n", ret);
 		return ret;
 	}
 
@@ -134,8 +136,9 @@ static int jdi_panel_init(struct jdi_panel *jdi)
 	ret = mipi_dsi_generic_write(dsi, (u8[])
 				     {0xB3, 0x26, 0x08, 0x00, 0x20, 0x00}, 6);
 	if (ret < 0) {
-		dev_err(dev, "failed to set display interface setting: %d\n"
-			, ret);
+		DRM_DEV_ERROR(dev,
+			      "failed to set display interface setting: %d\n",
+			      ret);
 		return ret;
 	}
 
@@ -143,8 +146,9 @@ static int jdi_panel_init(struct jdi_panel *jdi)
 
 	ret = mipi_dsi_generic_write(dsi, (u8[]){0xB0, 0x03}, 2);
 	if (ret < 0) {
-		dev_err(dev, "failed to set default values for mcap: %d\n"
-			, ret);
+		DRM_DEV_ERROR(dev,
+			      "failed to set default values for mcap: %d\n",
+			      ret);
 		return ret;
 	}
 
@@ -161,7 +165,7 @@ static int jdi_panel_on(struct jdi_panel *jdi)
 
 	ret = mipi_dsi_dcs_set_display_on(dsi);
 	if (ret < 0)
-		dev_err(dev, "failed to set display on: %d\n", ret);
+		DRM_DEV_ERROR(dev, "failed to set display on: %d\n", ret);
 
 	return ret;
 }
@@ -176,11 +180,11 @@ static void jdi_panel_off(struct jdi_panel *jdi)
 
 	ret = mipi_dsi_dcs_set_display_off(dsi);
 	if (ret < 0)
-		dev_err(dev, "failed to set display off: %d\n", ret);
+		DRM_DEV_ERROR(dev, "failed to set display off: %d\n", ret);
 
 	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
 	if (ret < 0)
-		dev_err(dev, "failed to enter sleep mode: %d\n", ret);
+		DRM_DEV_ERROR(dev, "failed to enter sleep mode: %d\n", ret);
 
 	msleep(100);
 }
@@ -212,7 +216,7 @@ static int jdi_panel_unprepare(struct drm_panel *panel)
 
 	ret = regulator_bulk_disable(ARRAY_SIZE(jdi->supplies), jdi->supplies);
 	if (ret < 0)
-		dev_err(dev, "regulator disable failed, %d\n", ret);
+		DRM_DEV_ERROR(dev, "regulator disable failed, %d\n", ret);
 
 	gpiod_set_value(jdi->enable_gpio, 0);
 
@@ -236,7 +240,7 @@ static int jdi_panel_prepare(struct drm_panel *panel)
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(jdi->supplies), jdi->supplies);
 	if (ret < 0) {
-		dev_err(dev, "regulator enable failed, %d\n", ret);
+		DRM_DEV_ERROR(dev, "regulator enable failed, %d\n", ret);
 		return ret;
 	}
 
@@ -253,13 +257,13 @@ static int jdi_panel_prepare(struct drm_panel *panel)
 
 	ret = jdi_panel_init(jdi);
 	if (ret < 0) {
-		dev_err(dev, "failed to init panel: %d\n", ret);
+		DRM_DEV_ERROR(dev, "failed to init panel: %d\n", ret);
 		goto poweroff;
 	}
 
 	ret = jdi_panel_on(jdi);
 	if (ret < 0) {
-		dev_err(dev, "failed to set panel on: %d\n", ret);
+		DRM_DEV_ERROR(dev, "failed to set panel on: %d\n", ret);
 		goto poweroff;
 	}
 
@@ -270,7 +274,7 @@ static int jdi_panel_prepare(struct drm_panel *panel)
 poweroff:
 	ret = regulator_bulk_disable(ARRAY_SIZE(jdi->supplies), jdi->supplies);
 	if (ret < 0)
-		dev_err(dev, "regulator disable failed, %d\n", ret);
+		DRM_DEV_ERROR(dev, "regulator disable failed, %d\n", ret);
 
 	gpiod_set_value(jdi->enable_gpio, 0);
 
@@ -317,9 +321,9 @@ static int jdi_panel_get_modes(struct drm_panel *panel)
 
 	mode = drm_mode_duplicate(panel->drm, &default_mode);
 	if (!mode) {
-		dev_err(dev, "failed to add mode %ux%ux@%u\n",
-			default_mode.hdisplay, default_mode.vdisplay,
-			default_mode.vrefresh);
+		DRM_DEV_ERROR(dev, "failed to add mode %ux%ux@%u\n",
+			      default_mode.hdisplay, default_mode.vdisplay,
+			      default_mode.vrefresh);
 		return -ENOMEM;
 	}
 
@@ -414,35 +418,35 @@ static int jdi_panel_add(struct jdi_panel *jdi)
 	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(jdi->supplies),
 				      jdi->supplies);
 	if (ret < 0) {
-		dev_err(dev, "failed to init regulator, ret=%d\n", ret);
+		DRM_DEV_ERROR(dev, "failed to init regulator, ret=%d\n", ret);
 		return ret;
 	}
 
 	jdi->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
 	if (IS_ERR(jdi->enable_gpio)) {
 		ret = PTR_ERR(jdi->enable_gpio);
-		dev_err(dev, "cannot get enable-gpio %d\n", ret);
+		DRM_DEV_ERROR(dev, "cannot get enable-gpio %d\n", ret);
 		return ret;
 	}
 
 	jdi->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(jdi->reset_gpio)) {
 		ret = PTR_ERR(jdi->reset_gpio);
-		dev_err(dev, "cannot get reset-gpios %d\n", ret);
+		DRM_DEV_ERROR(dev, "cannot get reset-gpios %d\n", ret);
 		return ret;
 	}
 
 	jdi->dcdc_en_gpio = devm_gpiod_get(dev, "dcdc-en", GPIOD_OUT_LOW);
 	if (IS_ERR(jdi->dcdc_en_gpio)) {
 		ret = PTR_ERR(jdi->dcdc_en_gpio);
-		dev_err(dev, "cannot get dcdc-en-gpio %d\n", ret);
+		DRM_DEV_ERROR(dev, "cannot get dcdc-en-gpio %d\n", ret);
 		return ret;
 	}
 
 	jdi->backlight = drm_panel_create_dsi_backlight(jdi->dsi);
 	if (IS_ERR(jdi->backlight)) {
 		ret = PTR_ERR(jdi->backlight);
-		dev_err(dev, "failed to register backlight %d\n", ret);
+		DRM_DEV_ERROR(dev, "failed to register backlight %d\n", ret);
 		return ret;
 	}
 
@@ -493,12 +497,12 @@ static int jdi_panel_remove(struct mipi_dsi_device *dsi)
 
 	ret = jdi_panel_disable(&jdi->base);
 	if (ret < 0)
-		dev_err(&dsi->dev, "failed to disable panel: %d\n", ret);
+		DRM_DEV_ERROR(&dsi->dev, "failed to disable panel: %d\n", ret);
 
 	ret = mipi_dsi_detach(dsi);
 	if (ret < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n",
-			ret);
+		DRM_DEV_ERROR(&dsi->dev,
+			      "failed to detach from DSI host: %d\n", ret);
 
 	jdi_panel_del(jdi);
 
-- 
2.12.0

