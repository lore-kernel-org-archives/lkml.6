Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77554C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D0B20685
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="fuO6h+ix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D0B20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732935AbeKMVQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:16:42 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35563 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732526AbeKMVQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:16:41 -0500
Received: by mail-pg1-f196.google.com with SMTP id 32-v6so5550114pgu.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 03:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1ffbMwrT3Fv3KeJlLSZWFa/jJG9NP1xOyiBOskUUsgI=;
        b=fuO6h+ixQjrhdbyBkgp6clmVFxWuL0Zv/XlgTVnIofHvMWU0tSIcsfXargH3iUcr/R
         0o8g2TP52ghFOHAK1JNooeU4eAQJaPAfqx867dVheY1sDieW/SWx7nHe/SC/MlAam1Wt
         /caqzX1hRhqgcPz5IBDlLJCRpxvOokMgkuygM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ffbMwrT3Fv3KeJlLSZWFa/jJG9NP1xOyiBOskUUsgI=;
        b=qNlL2ODpt09mtwEx0AflBPugKiPOnewPzPKNcMIwJEfK84f8MP/t+kKgbV9biK+ng2
         eJ0HcVkywZ0bBWtHwfuP6QVOKA+YQQRx4+PC2WF8mAQFyeK363drWfNpiTfe2Bddq6Uk
         ycsb+upyh1maV/EJrr4p5Ks+WhVX1XL8n4yl8uOSzO0zVJrWwAeqKNMre0Tmz5gkWqQt
         E3quptllU1huKqfRK1jJLxhlWGAe41P6ygfr4w05nLsixB3fMznNJzcWHSqJtofOT7xK
         ZL/S4NxRzlfI9n8SD+SgX7vu+fj2beSB8DB/b6f9fqSi0WNv5U8hnNvetRwOsQvWJOL4
         1DpQ==
X-Gm-Message-State: AGRZ1gKytx6/FxNt4+i3zXMTtm1znA/jQwTuJrc5XyQO68S7ApkHYBAp
        /kjidBRJjISvKFuErQHYD7Ussw==
X-Google-Smtp-Source: AJdET5fKeVVA7FH0K3ycrVJkWoc/SudOwAyW0Zs5W0CvJ0YJ0X8l4mkCY/EWUorlk8nTGwlr0NO2rw==
X-Received: by 2002:a62:3101:: with SMTP id x1-v6mr4857394pfx.204.1542107942470;
        Tue, 13 Nov 2018 03:19:02 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:3670:3f11:bc71:2ef7:4a39:e260])
        by smtp.gmail.com with ESMTPSA id 27-v6sm28531377pfm.36.2018.11.13.03.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 03:19:01 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v4 21/26] drm/panel: Add Techstar TS8550B MIPI-DSI LCD panel
Date:   Tue, 13 Nov 2018 16:46:28 +0530
Message-Id: <20181113111633.20189-22-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181113111633.20189-1-jagan@amarulasolutions.com>
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Techstar TS8550B MIPI DSI panel is 480x854, 2-lane MIPI DSI
LCD panel. Add panel driver for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-techstar-ts8550b.c    | 324 ++++++++++++++++++
 4 files changed, 340 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-techstar-ts8550b.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f5bb2ffa1089..3dac08d0b3cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4718,6 +4718,12 @@ S:	Maintained
 F:	drivers/gpu/drm/tinydrm/st7735r.c
 F:	Documentation/devicetree/bindings/display/sitronix,st7735r.txt
 
+DRM DRIVER FOR TECHSTAR TS8550B MIPI-DSI LCD PANELS
+M:	Jagan Teki <jagan@amarulasolutions.com>
+S:	Maintained
+F:	drivers/gpu/drm/panel/panel-techstar-ts8550b.c
+F:	Documentation/devicetree/bindings/display/panel/techstar,ts8550b.txt
+
 DRM DRIVER FOR TDFX VIDEO CARDS
 S:	Orphan / Obsolete
 F:	drivers/gpu/drm/tdfx/
diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 20b88c275421..d0d4e60f5153 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -195,4 +195,13 @@ config DRM_PANEL_SITRONIX_ST7789V
 	  Say Y here if you want to enable support for the Sitronix
 	  ST7789V controller for 240x320 LCD panels
 
+config DRM_PANEL_TECHSTAR_TS8550B
+	tristate "Techstar TS8550B MIPI-DSI panel driver"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y if you want to enable support for panels based on the
+	  Techstar TS8550B MIPI-DSI interface.
+
 endmenu
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index 04696bb85218..88011f06edb8 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_DRM_PANEL_SEIKO_43WVF1G) += panel-seiko-43wvf1g.o
 obj-$(CONFIG_DRM_PANEL_SHARP_LQ101R1SX01) += panel-sharp-lq101r1sx01.o
 obj-$(CONFIG_DRM_PANEL_SHARP_LS043T1LE01) += panel-sharp-ls043t1le01.o
 obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7789V) += panel-sitronix-st7789v.o
+obj-$(CONFIG_DRM_PANEL_TECHSTAR_TS8550B) += panel-techstar-ts8550b.o
diff --git a/drivers/gpu/drm/panel/panel-techstar-ts8550b.c b/drivers/gpu/drm/panel/panel-techstar-ts8550b.c
new file mode 100644
index 000000000000..70a5f8ec6908
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-techstar-ts8550b.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2019, Amarula Solutions.
+ * Author: Jagan Teki <jagan@amarulasolutions.com>
+ */
+
+#include <linux/backlight.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+
+#include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
+
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+
+#include <video/mipi_display.h>
+
+struct techstar {
+	struct drm_panel	panel;
+	struct mipi_dsi_device	*dsi;
+
+	struct backlight_device *backlight;
+	struct regulator	*dvdd;
+	struct regulator	*avdd;
+	struct gpio_desc	*reset;
+};
+
+static inline struct techstar *panel_to_techstar(struct drm_panel *panel)
+{
+	return container_of(panel, struct techstar, panel);
+}
+
+static inline int techstar_dcs_write_seq(struct techstar *ctx, const void *seq,
+					size_t len)
+{
+	return mipi_dsi_dcs_write_buffer(ctx->dsi, seq, len);
+};
+
+#define techstar_dcs_write_seq_static(ctx, seq...)		\
+	({							\
+		static const u8 d[] = { seq };			\
+		techstar_dcs_write_seq(ctx, d, ARRAY_SIZE(d));	\
+	})
+
+static void techstar_init_sequence(struct techstar *ctx)
+{
+	techstar_dcs_write_seq_static(ctx, MIPI_DCS_SOFT_RESET, 0x00);
+	msleep(200);
+	techstar_dcs_write_seq_static(ctx, 0xFF, 0x77, 0x01, 0x00, 0x00, 0x11);
+	techstar_dcs_write_seq_static(ctx, 0xD1, 0x11);
+	techstar_dcs_write_seq_static(ctx, MIPI_DCS_EXIT_SLEEP_MODE, 0x00);
+	msleep(200);
+	techstar_dcs_write_seq_static(ctx, 0xFF, 0x77, 0x01, 0x00, 0x00, 0x10);
+	techstar_dcs_write_seq_static(ctx, 0xC0, 0xE9, 0x03);
+	techstar_dcs_write_seq_static(ctx, 0xC1, 0x12, 0x02);
+	techstar_dcs_write_seq_static(ctx, 0xC2, 0x07, 0x06);
+	techstar_dcs_write_seq_static(ctx, 0xB0, 0x00, 0x0E, 0x15, 0x0F, 0x11,
+				     0x08, 0x08, 0x08, 0x08, 0x23, 0x04, 0x13,
+				     0x12, 0x2B, 0x34, 0x1F);
+	techstar_dcs_write_seq_static(ctx, 0xB1, 0x00, 0x0E, 0x95, 0x0F, 0x13,
+				     0x07, 0x09, 0x08, 0x08, 0x22, 0x04, 0x10,
+				     0x0E, 0x2C, 0x34, 0x1F);
+	techstar_dcs_write_seq_static(ctx, 0xFF, 0x77, 0x01, 0x00, 0x00, 0x11);
+	techstar_dcs_write_seq_static(ctx, 0xB0, 0x45);
+	techstar_dcs_write_seq_static(ctx, 0xB1, 0x13);
+	techstar_dcs_write_seq_static(ctx, 0xB2, 0x07);
+	techstar_dcs_write_seq_static(ctx, 0xB3, 0x80);
+	techstar_dcs_write_seq_static(ctx, 0xB5, 0x47);
+	techstar_dcs_write_seq_static(ctx, 0xB7, 0x85);
+	techstar_dcs_write_seq_static(ctx, 0xB8, 0x20);
+	techstar_dcs_write_seq_static(ctx, 0xB9, 0x11);
+	techstar_dcs_write_seq_static(ctx, 0xC1, 0x78);
+	techstar_dcs_write_seq_static(ctx, 0xC2, 0x78);
+	techstar_dcs_write_seq_static(ctx, 0xD0, 0x88);
+	msleep(100);
+	techstar_dcs_write_seq_static(ctx, 0xE0, 0x00, 0x00, 0x02);
+	techstar_dcs_write_seq_static(ctx, 0xE1, 0x0B, 0x00, 0x0D, 0x00, 0x0C,
+				     0x00, 0x0E, 0x00, 0x00, 0x44, 0x44);
+	techstar_dcs_write_seq_static(ctx, 0xE2, 0x33, 0x33, 0x44, 0x44, 0x64,
+				     0x00, 0x66, 0x00, 0x65, 0x00, 0x67, 0x00,
+				     0x00);
+	techstar_dcs_write_seq_static(ctx, 0xE3, 0x00, 0x00, 0x33, 0x33);
+	techstar_dcs_write_seq_static(ctx, 0xE4, 0x44, 0x44);
+	techstar_dcs_write_seq_static(ctx, 0xE5, 0x0C, 0x78, 0x3C, 0xA0, 0x0E,
+				     0x78, 0x3C, 0xA0, 0x10, 0x78, 0x3C, 0xA0,
+				     0x12, 0x78, 0x3C, 0xA0);
+	techstar_dcs_write_seq_static(ctx, 0xE6, 0x00, 0x00, 0x33, 0x33);
+	techstar_dcs_write_seq_static(ctx, 0xE7, 0x44, 0x44);
+	techstar_dcs_write_seq_static(ctx, 0xE8, 0x0D, 0x78, 0x3C, 0xA0, 0x0F,
+				     0x78, 0x3C, 0xA0, 0x11, 0x78, 0x3C, 0xA0,
+				     0x13, 0x78, 0x3C, 0xA0);
+	techstar_dcs_write_seq_static(ctx, 0xEB, 0x02, 0x02, 0x39, 0x39, 0xEE,
+				     0x44, 0x00);
+	techstar_dcs_write_seq_static(ctx, 0xEC, 0x00, 0x00);
+	techstar_dcs_write_seq_static(ctx, 0xED, 0xFF, 0xF1, 0x04, 0x56, 0x72,
+				     0x3F, 0xFF, 0xFF, 0xFF, 0xFF, 0xF3, 0x27,
+				     0x65, 0x40, 0x1F, 0xFF);
+	techstar_dcs_write_seq_static(ctx, 0xFF, 0x77, 0x01, 0x00, 0x00, 0x00);
+	msleep(10);
+	techstar_dcs_write_seq_static(ctx, MIPI_DCS_SET_DISPLAY_ON, 0x00);
+	msleep(200);
+}
+
+static int techstar_prepare(struct drm_panel *panel)
+{
+	struct techstar *ctx = panel_to_techstar(panel);
+	int ret;
+
+	gpiod_set_value(ctx->reset, 0);
+	msleep(20);
+
+	ret = regulator_enable(ctx->dvdd);
+	if (ret)
+		return ret;
+	msleep(20);
+
+	ret = regulator_enable(ctx->avdd);
+	if (ret)
+		return ret;
+	msleep(20);
+
+	gpiod_set_value(ctx->reset, 1);
+	msleep(20);
+
+	gpiod_set_value(ctx->reset, 0);
+	msleep(30);
+
+	gpiod_set_value(ctx->reset, 1);
+	msleep(150);
+
+	techstar_init_sequence(ctx);
+
+	return 0;
+}
+
+static int techstar_enable(struct drm_panel *panel)
+{
+	struct techstar *ctx = panel_to_techstar(panel);
+
+	msleep(120);
+
+	mipi_dsi_dcs_set_display_on(ctx->dsi);
+	backlight_enable(ctx->backlight);
+
+	return 0;
+}
+
+static int techstar_disable(struct drm_panel *panel)
+{
+	struct techstar *ctx = panel_to_techstar(panel);
+
+	backlight_disable(ctx->backlight);
+	return mipi_dsi_dcs_set_display_on(ctx->dsi);
+}
+
+static int techstar_unprepare(struct drm_panel *panel)
+{
+	struct techstar *ctx = panel_to_techstar(panel);
+	int ret;
+
+	ret = mipi_dsi_dcs_set_display_off(ctx->dsi);
+	if (ret < 0)
+		dev_err(panel->dev, "failed to set display off: %d\n", ret);
+
+	ret = mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
+	if (ret < 0)
+		dev_err(panel->dev, "failed to enter sleep mode: %d\n", ret);
+
+	msleep(120);
+
+	regulator_disable(ctx->dvdd);
+
+	regulator_disable(ctx->avdd);
+
+	gpiod_set_value(ctx->reset, 0);
+
+	gpiod_set_value(ctx->reset, 1);
+
+	gpiod_set_value(ctx->reset, 0);
+
+	return 0;
+}
+
+static const struct drm_display_mode default_mode = {
+	.clock		= 27500,
+	.vrefresh	= 60,
+
+	.hdisplay	= 480,
+	.hsync_start	= 480 + 38,
+	.hsync_end	= 480 + 38 + 12,
+	.htotal		= 480 + 38 + 12 + 12,
+
+	.vdisplay	= 854,
+	.vsync_start	= 854 + 18,
+	.vsync_end	= 854 + 18 + 8,
+	.vtotal		= 854 + 18 + 8 + 4,
+
+	.width_mm	= 69,
+	.height_mm	= 139,
+};
+
+static int techstar_get_modes(struct drm_panel *panel)
+{
+	struct drm_connector *connector = panel->connector;
+	struct techstar *ctx = panel_to_techstar(panel);
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_duplicate(panel->drm, &default_mode);
+	if (!mode) {
+		dev_err(&ctx->dsi->dev, "failed to add mode %ux%ux@%u\n",
+			default_mode.hdisplay, default_mode.vdisplay,
+			default_mode.vrefresh);
+		return -ENOMEM;
+	}
+
+	drm_mode_set_name(mode);
+
+	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
+	drm_mode_probed_add(connector, mode);
+
+	panel->connector->display_info.width_mm = mode->width_mm;
+	panel->connector->display_info.height_mm = mode->height_mm;
+
+	return 1;
+}
+
+static const struct drm_panel_funcs techstar_funcs = {
+	.disable	= techstar_disable,
+	.unprepare	= techstar_unprepare,
+	.prepare	= techstar_prepare,
+	.enable		= techstar_enable,
+	.get_modes	= techstar_get_modes,
+};
+
+static int techstar_dsi_probe(struct mipi_dsi_device *dsi)
+{
+	struct device_node *np;
+	struct techstar *ctx;
+	int ret;
+
+	ctx = devm_kzalloc(&dsi->dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	mipi_dsi_set_drvdata(dsi, ctx);
+	ctx->dsi = dsi;
+
+	drm_panel_init(&ctx->panel);
+	ctx->panel.dev = &dsi->dev;
+	ctx->panel.funcs = &techstar_funcs;
+
+	ctx->dvdd = devm_regulator_get(&dsi->dev, "dvdd");
+	if (IS_ERR(ctx->dvdd)) {
+		dev_err(&dsi->dev, "Couldn't get dvdd regulator\n");
+		return PTR_ERR(ctx->dvdd);
+	}
+
+	ctx->avdd = devm_regulator_get(&dsi->dev, "avdd");
+	if (IS_ERR(ctx->avdd)) {
+		dev_err(&dsi->dev, "Couldn't get avdd regulator\n");
+		return PTR_ERR(ctx->avdd);
+	}
+
+	ctx->reset = devm_gpiod_get(&dsi->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->reset)) {
+		dev_err(&dsi->dev, "Couldn't get our reset GPIO\n");
+		return PTR_ERR(ctx->reset);
+	}
+
+	np = of_parse_phandle(dsi->dev.of_node, "backlight", 0);
+	if (np) {
+		ctx->backlight = of_find_backlight_by_node(np);
+		of_node_put(np);
+
+		if (!ctx->backlight)
+			return -EPROBE_DEFER;
+	}
+
+	ret = drm_panel_add(&ctx->panel);
+	if (ret < 0)
+		return ret;
+
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->lanes = 2;
+
+	return mipi_dsi_attach(dsi);
+}
+
+static int techstar_dsi_remove(struct mipi_dsi_device *dsi)
+{
+	struct techstar *ctx = mipi_dsi_get_drvdata(dsi);
+
+	mipi_dsi_detach(dsi);
+	drm_panel_remove(&ctx->panel);
+
+	if (ctx->backlight)
+		put_device(&ctx->backlight->dev);
+
+	return 0;
+}
+
+static const struct of_device_id techstar_of_match[] = {
+	{ .compatible = "techstar,ts8550b" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, techstar_of_match);
+
+static struct mipi_dsi_driver techstar_dsi_driver = {
+	.probe		= techstar_dsi_probe,
+	.remove		= techstar_dsi_remove,
+	.driver = {
+		.name		= "techstar-ts8550b",
+		.of_match_table	= techstar_of_match,
+	},
+};
+module_mipi_dsi_driver(techstar_dsi_driver);
+
+MODULE_AUTHOR("Jagan Teki <jagan@amarulasolutions.com>");
+MODULE_DESCRIPTION("Techstar TS8550B MIPI-DSI LCD Panel Driver");
+MODULE_LICENSE("GPL");
-- 
2.18.0.321.gffc6fa0e3

