Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539D9ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8779215E5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XS4jskXB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8779215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeI0SIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 14:08:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43701 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbeI0SIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 14:08:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id j26-v6so1726987pfi.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 04:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ye3BHTYw3hsX6SekIxERfAK/2gCXXkytVmCv8lGdJeU=;
        b=XS4jskXBa6ajaQ6Il3cCLChRb7VXVD+mm/EDyGLYuw4MaVHLPdCrz79nLMcneWSHQB
         LTAmX4vTqcMT1pZCiJYiJE2PeMBqYAzIPdnvDuu8b0CluQsqECs+boqTgicqWA7mAu9W
         VN+ftSoRx21asn2ibRUiWo2tRoNyAAmaoegoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ye3BHTYw3hsX6SekIxERfAK/2gCXXkytVmCv8lGdJeU=;
        b=qOdppsK1SjmH+Q2n1QRuDVz0mtl3Udbrkv5YNk2dTc1BaZ1lMkSD725i4hPSb/n7jT
         ARBAlhaNu8WTGxjhAh7QhRiIx3XWCj2tOdMzUuECSN13oATYef2KNjhhoGZmAvUosuY1
         O45gTIAkwOQ2ECGa4/LD1Swn04UQC3PqD8dbOvMmc2uRtly77+ItkDZxXXDJlWYoh6Qz
         c3STNv8PSy4tD4Iy74l0dkRD8JRIve9/lJSCPAFVEugBDZHGMCChBIdzNyYYEuXHrrFd
         Ei/v2EzBtMQy7laXZORM7vrEdG19cMGqwlPyg2zjrPhj+7etHXYbLkpizVCGIWbM7Whq
         ZC1g==
X-Gm-Message-State: ABuFfogsmzq/T6pDqQ4v3l4ZAcyf5o0Cq+iOcZY0f3eD462O8eUoetLN
        aMt1I37yxTIf4n9R6ut6z5FaMg==
X-Google-Smtp-Source: ACcGV61C3MWQhpiVTDjjDZ8O2Uk9bssNx1bPcNKn7qNA6iiwc3rX4chyQUYNmPTm2Uk15BHR5skNBQ==
X-Received: by 2002:a17:902:7001:: with SMTP id y1-v6mr10780813plk.259.1538049026262;
        Thu, 27 Sep 2018 04:50:26 -0700 (PDT)
Received: from localhost.localdomain ([183.82.230.83])
        by smtp.gmail.com with ESMTPSA id v36-v6sm3744872pgn.85.2018.09.27.04.50.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 04:50:25 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@free-electrons.com>,
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
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 10/12] drm/panel: Add Bananapi S070WV20-CT16 MIPI-DSI panel driver
Date:   Thu, 27 Sep 2018 17:18:48 +0530
Message-Id: <20180927114850.24565-11-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20180927114850.24565-1-jagan@amarulasolutions.com>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bananapi S070WV20-CT16 is 800x480, 4-lane MIPI-DSI panel which
can be used to connect via BPI-M64 board, so add a driver for it.

The same panel PCB comes with parallel RBG which is supported via
panel-simple driver with "bananapi,s070wv20-ct16" compatible.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-bananapi-s070wv20.c   | 336 ++++++++++++++++++
 3 files changed, 346 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-bananapi-s070wv20.c

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 6020c30a33b3..d25960a63b10 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -17,6 +17,15 @@ config DRM_PANEL_ARM_VERSATILE
 	  reference designs. The panel is detected using special registers
 	  in the Versatile family syscon registers.
 
+config DRM_PANEL_BANANAPI_S070WV20
+	tristate "Bananapi S070WV20-CT16 MIPI-DSI panel driver"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y if you want to enable support for panels based on the
+	  Bananapi S070WV20-CT16 MIPI-DSI controller.
+
 config DRM_PANEL_LVDS
 	tristate "Generic LVDS panel driver"
 	depends on OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index 5ccaaa9d13af..345b6475d3a4 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_DRM_PANEL_ARM_VERSATILE) += panel-arm-versatile.o
+obj-$(CONFIG_DRM_PANEL_BANANAPI_S070WV20) += panel-bananapi-s070wv20.o
 obj-$(CONFIG_DRM_PANEL_LVDS) += panel-lvds.o
 obj-$(CONFIG_DRM_PANEL_SIMPLE) += panel-simple.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_IL9322) += panel-ilitek-ili9322.o
diff --git a/drivers/gpu/drm/panel/panel-bananapi-s070wv20.c b/drivers/gpu/drm/panel/panel-bananapi-s070wv20.c
new file mode 100644
index 000000000000..6c9adbec6dd8
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-bananapi-s070wv20.c
@@ -0,0 +1,336 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+/*
+ * Copyright (C) 2018 Amarula Solutions
+ * Author: Jagan Teki <jagan@amarulasolutions.com>
+ */
+
+#include <linux/backlight.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/fb.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
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
+struct s070wv20 {
+	struct drm_panel	panel;
+	struct mipi_dsi_device	*dsi;
+
+	struct backlight_device	*backlight;
+	struct regulator	*dvdd;
+	struct regulator	*avdd;
+	struct gpio_desc	*reset;
+
+	bool			is_enabled;
+	bool			is_prepared;
+};
+
+static inline struct s070wv20 *panel_to_s070wv20(struct drm_panel *panel)
+{
+	return container_of(panel, struct s070wv20, panel);
+}
+
+struct s070wv20_init_cmd {
+	size_t len;
+	const char *data;
+};
+
+#define S070WV20_INIT_CMD(...) { \
+	.len = sizeof((char[]){__VA_ARGS__}), \
+	.data = (char[]){__VA_ARGS__} }
+
+static const struct s070wv20_init_cmd s070wv20_init_cmds[] = {
+	S070WV20_INIT_CMD(0x7A, 0xC1),
+	S070WV20_INIT_CMD(0x20, 0x20),
+	S070WV20_INIT_CMD(0x21, 0xE0),
+	S070WV20_INIT_CMD(0x22, 0x13),
+	S070WV20_INIT_CMD(0x23, 0x28),
+	S070WV20_INIT_CMD(0x24, 0x30),
+	S070WV20_INIT_CMD(0x25, 0x28),
+	S070WV20_INIT_CMD(0x26, 0x00),
+	S070WV20_INIT_CMD(0x27, 0x0D),
+	S070WV20_INIT_CMD(0x28, 0x03),
+	S070WV20_INIT_CMD(0x29, 0x1D),
+	S070WV20_INIT_CMD(0x34, 0x80),
+	S070WV20_INIT_CMD(0x36, 0x28),
+	S070WV20_INIT_CMD(0xB5, 0xA0),
+	S070WV20_INIT_CMD(0x5C, 0xFF),
+	S070WV20_INIT_CMD(0x2A, 0x01),
+	S070WV20_INIT_CMD(0x56, 0x92),
+	S070WV20_INIT_CMD(0x6B, 0x71),
+	S070WV20_INIT_CMD(0x69, 0x2B),
+	S070WV20_INIT_CMD(0x10, 0x40),
+	S070WV20_INIT_CMD(0x11, 0x98),
+	S070WV20_INIT_CMD(0xB6, 0x20),
+	S070WV20_INIT_CMD(0x51, 0x20),
+	S070WV20_INIT_CMD(0x09, 0x10),
+};
+
+static int s070wv20_prepare(struct drm_panel *panel)
+{
+	struct s070wv20 *ctx = panel_to_s070wv20(panel);
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	unsigned int i;
+	int ret;
+
+	if (ctx->is_prepared)
+		return 0;
+
+	msleep(50);
+
+	gpiod_set_value(ctx->reset, 1);
+	msleep(50);
+
+	gpiod_set_value(ctx->reset, 0);
+	msleep(50);
+
+	gpiod_set_value(ctx->reset, 1);
+	msleep(20);
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
+	if (ret < 0) {
+		dev_err(panel->dev, "failed to exit sleep mode: %d\n", ret);
+		return ret;
+	}
+
+	msleep(120);
+
+	for (i = 0; i < ARRAY_SIZE(s070wv20_init_cmds); i++) {
+		const struct s070wv20_init_cmd *cmd = &s070wv20_init_cmds[i];
+
+		ret = mipi_dsi_generic_write(dsi, cmd->data, cmd->len);
+		if (ret < 0)
+			return ret;
+
+		msleep(10);
+	}
+
+	ret = mipi_dsi_dcs_set_display_on(dsi);
+	if (ret < 0) {
+		dev_err(panel->dev, "failed to set display on: %d\n", ret);
+		return ret;
+	}
+
+	ctx->is_prepared = true;
+
+	return 0;
+}
+
+static int s070wv20_enable(struct drm_panel *panel)
+{
+	struct s070wv20 *ctx = panel_to_s070wv20(panel);
+
+	if (ctx->is_enabled)
+		return 0;
+
+	msleep(120);
+
+	backlight_enable(ctx->backlight);
+	ctx->is_enabled = true;
+
+	return 0;
+}
+
+static int s070wv20_disable(struct drm_panel *panel)
+{
+	struct s070wv20 *ctx = panel_to_s070wv20(panel);
+
+	if (!ctx->is_enabled)
+		return 0;
+
+	backlight_disable(ctx->backlight);
+	ctx->is_enabled = false;
+
+	return 0;
+}
+
+static int s070wv20_unprepare(struct drm_panel *panel)
+{
+	struct s070wv20 *ctx = panel_to_s070wv20(panel);
+	int ret;
+
+	if (!ctx->is_prepared)
+		return 0;
+
+	ret = mipi_dsi_dcs_set_display_off(ctx->dsi);
+	if (ret < 0)
+		dev_err(panel->dev, "failed to set display off: %d\n", ret);
+
+	ret = mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
+	if (ret < 0)
+		dev_err(panel->dev, "failed to enter sleep mode: %d\n", ret);
+
+	msleep(100);
+
+	regulator_disable(ctx->avdd);
+
+	regulator_disable(ctx->dvdd);
+
+	gpiod_set_value(ctx->reset, 0);
+
+	gpiod_set_value(ctx->reset, 1);
+
+	gpiod_set_value(ctx->reset, 0);
+
+	ctx->is_prepared = false;
+
+	return 0;
+}
+
+static const struct drm_display_mode s070wv20_default_mode = {
+	.clock = 30000,
+	.vrefresh = 60,
+
+	.hdisplay = 800,
+	.hsync_start = 800 + 40,
+	.hsync_end = 800 + 40 + 48,
+	.htotal = 800 + 40 + 48 + 40,
+
+	.vdisplay = 480,
+	.vsync_start = 480 + 13,
+	.vsync_end = 480 + 13 + 3,
+	.vtotal = 480 + 13 + 3 + 29,
+};
+
+static int s070wv20_get_modes(struct drm_panel *panel)
+{
+	struct drm_connector *connector = panel->connector;
+	struct s070wv20 *ctx = panel_to_s070wv20(panel);
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_duplicate(panel->drm, &s070wv20_default_mode);
+	if (!mode) {
+		dev_err(&ctx->dsi->dev, "failed to add mode %ux%ux@%u\n",
+			s070wv20_default_mode.hdisplay,
+			s070wv20_default_mode.vdisplay,
+			s070wv20_default_mode.vrefresh);
+		return -ENOMEM;
+	}
+
+	drm_mode_set_name(mode);
+
+	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
+	drm_mode_probed_add(connector, mode);
+
+	panel->connector->display_info.width_mm = 86;
+	panel->connector->display_info.height_mm = 154;
+
+	return 1;
+}
+
+static const struct drm_panel_funcs s070wv20_funcs = {
+	.disable = s070wv20_disable,
+	.unprepare = s070wv20_unprepare,
+	.prepare = s070wv20_prepare,
+	.enable = s070wv20_enable,
+	.get_modes = s070wv20_get_modes,
+};
+
+static int s070wv20_dsi_probe(struct mipi_dsi_device *dsi)
+{
+	struct device_node *np;
+	struct s070wv20 *ctx;
+	int ret;
+
+	ctx = devm_kzalloc(&dsi->dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	mipi_dsi_set_drvdata(dsi, ctx);
+	ctx->dsi = dsi;
+
+	drm_panel_init(&ctx->panel);
+	ctx->panel.dev = &dsi->dev;
+	ctx->panel.funcs = &s070wv20_funcs;
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
+	ret = regulator_enable(ctx->dvdd);
+	if (ret)
+		return ret;
+
+	msleep(5);
+
+	ret = regulator_enable(ctx->avdd);
+	if (ret)
+		return ret;
+
+	msleep(5);
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
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO_SYNC_PULSE;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->lanes = 4;
+
+	return mipi_dsi_attach(dsi);
+}
+
+static int s070wv20_dsi_remove(struct mipi_dsi_device *dsi)
+{
+	struct s070wv20 *ctx = mipi_dsi_get_drvdata(dsi);
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
+static const struct of_device_id s070wv20_of_match[] = {
+	{ .compatible = "bananapi,s070wv20-ct16-dsi", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, s070wv20_of_match);
+
+static struct mipi_dsi_driver s070wv20_driver = {
+	.probe = s070wv20_dsi_probe,
+	.remove = s070wv20_dsi_remove,
+	.driver = {
+		.name = "bananapi-s070wv20-ct16-dsi",
+		.of_match_table = s070wv20_of_match,
+	},
+};
+module_mipi_dsi_driver(s070wv20_driver);
+
+MODULE_AUTHOR("Jagan Teki <jagan@amarulasolutions.com>");
+MODULE_DESCRIPTION("Bananapi S070WV20-CT16 MIPI-DSI");
+MODULE_LICENSE("GPL v2");
-- 
2.18.0.321.gffc6fa0e3

