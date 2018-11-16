Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DE7C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464B320684
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="AIPBDzaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 464B320684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390441AbeKQCy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 21:54:26 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45231 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390128AbeKQCyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 21:54:06 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so8391680pfd.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 08:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ZypFTMH60Fx3jMpMj7QY1/KhMcg5cWSg5+lJDph3Qw=;
        b=AIPBDzaUIW4o0VtziBCjUBIlJsipn+4CV1RH0Shs4NYPCts7Nni2fczQoFFVMlYPHh
         TWuEqihqFZhhVP66tlG1oATRQBn2ccO9Uw/E/lVhMxKg5inJoe3rXpNdgr47Um63taYY
         v5Rc3HEGxVja63j9dgA15/W3Aj0YAvIHhJpkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ZypFTMH60Fx3jMpMj7QY1/KhMcg5cWSg5+lJDph3Qw=;
        b=QqoLwRfRK8Nfg+kQZAuIr2J2ffhp209pBFvJgMrBViNiWxmr0t7hEr89qlOQuQwwIW
         wzBULvRJ9MH4+3/+ufspBEQTMUP9ePAvQvSRCizmWZ9J9qt42axWkodRgQZhGJ+lk3EH
         oD0udh8fwB4xXBhUs2/6kbuC+EukyyMd8ONGBd2BflUT13GdDo8qAx8l+0KMXACjVMQg
         meFwVzK38DaMfBqvs3tzv6OCxn2ix7sOO7C7pL4APpl9cNKrX2e+p73gk8XoAiBKKOG2
         N6JueZIuQ4kWovDqO5EIXF5MeQzabz3PuG+dn0lKve40Z5luzpqQavmsG52aMXz9IBvs
         rUGQ==
X-Gm-Message-State: AGRZ1gJcApD6xybFw4CQU7zZoNfw/ZFK3H1IrjuIIOy3psciN4KnKD8J
        AatRtEI3TgezDnzJt02y5LlGwA==
X-Google-Smtp-Source: AJdET5dNd9dvDkwPcOwoXWhUF2ENOtkksLlbr1lilOZFnDkQ/R/pAa/NPYrSu7wl7w3a02tqoTv+4A==
X-Received: by 2002:a62:2095:: with SMTP id m21-v6mr11833807pfj.32.1542386460349;
        Fri, 16 Nov 2018 08:41:00 -0800 (PST)
Received: from localhost.localdomain ([115.97.190.86])
        by smtp.gmail.com with ESMTPSA id p5-v6sm34622213pfb.109.2018.11.16.08.40.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 08:40:59 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        TL Lim <tllim@pine64.org>, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 11/12] drm/panel: Add Feiyang FY07024DI26A30-D MIPI-DSI LCD panel
Date:   Fri, 16 Nov 2018 22:09:15 +0530
Message-Id: <20181116163916.29621-12-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181116163916.29621-1-jagan@amarulasolutions.com>
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Feiyang FY07024DI26A30-D is 1024x600, 4-lane MIPI-DSI LCD panel.

Add panel driver for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../drm/panel/panel-feiyang-fy07024di26a30d.c | 286 ++++++++++++++++++
 4 files changed, 302 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3dac08d0b3cb..40c8bfc974f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4620,6 +4620,12 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 S:	Maintained
 F:	drivers/gpu/drm/tve200/
 
+DRM DRIVER FOR FEIYANG FY07024DI26A30-D MIPI-DSI LCD PANELS
+M:	Jagan Teki <jagan@amarulasolutions.com>
+S:	Maintained
+F:	drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
+F:	Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
+
 DRM DRIVER FOR ILITEK ILI9225 PANELS
 M:	David Lechner <david@lechnology.com>
 S:	Maintained
diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index d0d4e60f5153..bc70896fe43c 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -47,6 +47,15 @@ config DRM_PANEL_SIMPLE
 	  that it can be automatically turned off when the panel goes into a
 	  low power state.
 
+config DRM_PANEL_FEIYANG_FY07024DI26A30D
+	tristate "Feiyang FY07024DI26A30-D MIPI-DSI LCD panel"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y if you want to enable support for panels based on the
+	  Feiyang FY07024DI26A30-D MIPI-DSI interface.
+
 config DRM_PANEL_ILITEK_IL9322
 	tristate "Ilitek ILI9322 320x240 QVGA panels"
 	depends on OF && SPI
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index 88011f06edb8..e23c017639c7 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_DRM_PANEL_ARM_VERSATILE) += panel-arm-versatile.o
 obj-$(CONFIG_DRM_PANEL_BANANAPI_S070WV20_ICN6211) += panel-bananapi-s070wv20-icn6211.o
 obj-$(CONFIG_DRM_PANEL_LVDS) += panel-lvds.o
 obj-$(CONFIG_DRM_PANEL_SIMPLE) += panel-simple.o
+obj-$(CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D) += panel-feiyang-fy07024di26a30d.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_IL9322) += panel-ilitek-ili9322.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9881C) += panel-ilitek-ili9881c.o
 obj-$(CONFIG_DRM_PANEL_INNOLUX_P079ZCA) += panel-innolux-p079zca.o
diff --git a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
new file mode 100644
index 000000000000..a4b46bd8fdbe
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
@@ -0,0 +1,286 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018 Amarula Solutions
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
+#include <drm/drmP.h>
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_panel.h>
+
+struct feiyang {
+	struct drm_panel	panel;
+	struct mipi_dsi_device	*dsi;
+
+	struct backlight_device	*backlight;
+	struct regulator	*dvdd;
+	struct regulator	*avdd;
+	struct gpio_desc	*reset;
+};
+
+static inline struct feiyang *panel_to_feiyang(struct drm_panel *panel)
+{
+	return container_of(panel, struct feiyang, panel);
+}
+
+struct feiyang_init_cmd {
+	size_t len;
+	const char *data;
+};
+
+#define FY07024DI26A30D(...) { \
+	.len = sizeof((char[]){__VA_ARGS__}), \
+	.data = (char[]){__VA_ARGS__} }
+
+static const struct feiyang_init_cmd feiyang_init_cmds[] = {
+	FY07024DI26A30D(0x80, 0x58),
+	FY07024DI26A30D(0x81, 0x47),
+	FY07024DI26A30D(0x82, 0xD4),
+	FY07024DI26A30D(0x83, 0x88),
+	FY07024DI26A30D(0x84, 0xA9),
+	FY07024DI26A30D(0x85, 0xC3),
+	FY07024DI26A30D(0x86, 0x82),
+};
+
+static int feiyang_prepare(struct drm_panel *panel)
+{
+	struct feiyang *ctx = panel_to_feiyang(panel);
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	unsigned int i;
+	int ret;
+
+	ret = regulator_enable(ctx->dvdd);
+	if (ret)
+		return ret;
+
+	msleep(100);
+
+	ret = regulator_enable(ctx->avdd);
+	if (ret)
+		return ret;
+
+	msleep(20);
+
+	gpiod_set_value(ctx->reset, 1);
+	msleep(50);
+
+	gpiod_set_value(ctx->reset, 0);
+	msleep(20);
+
+	gpiod_set_value(ctx->reset, 1);
+	msleep(200);
+
+	for (i = 0; i < ARRAY_SIZE(feiyang_init_cmds); i++) {
+		const struct feiyang_init_cmd *cmd =
+						&feiyang_init_cmds[i];
+
+		ret = mipi_dsi_dcs_write_buffer(dsi, cmd->data, cmd->len);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int feiyang_enable(struct drm_panel *panel)
+{
+	struct feiyang *ctx = panel_to_feiyang(panel);
+
+	msleep(120);
+
+	mipi_dsi_dcs_set_display_on(ctx->dsi);
+	backlight_enable(ctx->backlight);
+
+	return 0;
+}
+
+static int feiyang_disable(struct drm_panel *panel)
+{
+	struct feiyang *ctx = panel_to_feiyang(panel);
+
+	backlight_disable(ctx->backlight);
+	return mipi_dsi_dcs_set_display_on(ctx->dsi);
+}
+
+static int feiyang_unprepare(struct drm_panel *panel)
+{
+	struct feiyang *ctx = panel_to_feiyang(panel);
+	int ret;
+
+	ret = mipi_dsi_dcs_set_display_off(ctx->dsi);
+	if (ret < 0)
+		DRM_DEV_ERROR(panel->dev, "failed to set display off: %d\n",
+			      ret);
+
+	ret = mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
+	if (ret < 0)
+		DRM_DEV_ERROR(panel->dev, "failed to enter sleep mode: %d\n",
+			      ret);
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
+	return 0;
+}
+
+static const struct drm_display_mode feiyang_default_mode = {
+	.clock = 55000,
+	.vrefresh = 60,
+
+	.hdisplay = 1024,
+	.hsync_start = 1024 + 396,
+	.hsync_end = 1024 + 396 + 20,
+	.htotal = 1024 + 396 + 20 + 100,
+
+	.vdisplay = 600,
+	.vsync_start = 600 + 12,
+	.vsync_end = 600 + 12 + 2,
+	.vtotal = 600 + 12 + 2 + 21,
+};
+
+static int feiyang_get_modes(struct drm_panel *panel)
+{
+	struct drm_connector *connector = panel->connector;
+	struct feiyang *ctx = panel_to_feiyang(panel);
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_duplicate(panel->drm, &feiyang_default_mode);
+	if (!mode) {
+		DRM_DEV_ERROR(&ctx->dsi->dev, "failed to add mode %ux%ux@%u\n",
+			      feiyang_default_mode.hdisplay,
+			      feiyang_default_mode.vdisplay,
+			      feiyang_default_mode.vrefresh);
+		return -ENOMEM;
+	}
+
+	drm_mode_set_name(mode);
+
+	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
+	drm_mode_probed_add(connector, mode);
+
+	return 1;
+}
+
+static const struct drm_panel_funcs feiyang_funcs = {
+	.disable = feiyang_disable,
+	.unprepare = feiyang_unprepare,
+	.prepare = feiyang_prepare,
+	.enable = feiyang_enable,
+	.get_modes = feiyang_get_modes,
+};
+
+static int feiyang_dsi_probe(struct mipi_dsi_device *dsi)
+{
+	struct device_node *np;
+	struct feiyang *ctx;
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
+	ctx->panel.funcs = &feiyang_funcs;
+
+	ctx->dvdd = devm_regulator_get(&dsi->dev, "dvdd");
+	if (IS_ERR(ctx->dvdd)) {
+		DRM_DEV_ERROR(&dsi->dev, "Couldn't get dvdd regulator\n");
+		return PTR_ERR(ctx->dvdd);
+	}
+
+	ctx->avdd = devm_regulator_get(&dsi->dev, "avdd");
+	if (IS_ERR(ctx->avdd)) {
+		DRM_DEV_ERROR(&dsi->dev, "Couldn't get avdd regulator\n");
+		return PTR_ERR(ctx->avdd);
+	}
+
+	ctx->reset = devm_gpiod_get(&dsi->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->reset)) {
+		DRM_DEV_ERROR(&dsi->dev, "Couldn't get our reset GPIO\n");
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
+		goto put_backlight;
+
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO_BURST;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->lanes = 4;
+
+	ret = mipi_dsi_attach(dsi);
+	if (ret < 0)
+		goto panel_remove;
+
+	return ret;
+
+panel_remove:
+	drm_panel_remove(&ctx->panel);
+put_backlight:
+	if (ctx->backlight)
+		put_device(&ctx->backlight->dev);
+
+	return ret;
+}
+
+static int feiyang_dsi_remove(struct mipi_dsi_device *dsi)
+{
+	struct feiyang *ctx = mipi_dsi_get_drvdata(dsi);
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
+static const struct of_device_id feiyang_of_match[] = {
+	{ .compatible = "feiyang,fy07024di26a30d", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, feiyang_of_match);
+
+static struct mipi_dsi_driver feiyang_driver = {
+	.probe = feiyang_dsi_probe,
+	.remove = feiyang_dsi_remove,
+	.driver = {
+		.name = "feiyang-fy07024di26a30d",
+		.of_match_table = feiyang_of_match,
+	},
+};
+module_mipi_dsi_driver(feiyang_driver);
+
+MODULE_AUTHOR("Jagan Teki <jagan@amarulasolutions.com>");
+MODULE_DESCRIPTION("Feiyang FY07024DI26A30-D MIPI-DSI LCD panel");
+MODULE_LICENSE("GPL");
-- 
2.18.0.321.gffc6fa0e3

