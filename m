Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95461C10F0B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 17:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CEF9206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 17:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfBWRjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 12:39:55 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:42370 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbfBWRjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 12:39:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 52C38FB04;
        Sat, 23 Feb 2019 18:39:48 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pZVhXo04HhWx; Sat, 23 Feb 2019 18:39:44 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 2396D41490; Sat, 23 Feb 2019 18:39:44 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 3/3] drm/panel: Add Rocktech jh057n00900 panel driver
Date:   Sat, 23 Feb 2019 18:39:44 +0100
Message-Id: <79858664af8ee2f725e53d902ce46b447ac8fcfc.1550943220.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1550943220.git.agx@sigxcpu.org>
References: <cover.1550943220.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support Rocktech jh057n00900 5.5" 720x1440 TFT LCD panel. It is a MIPI
DSI video mode panel.

The panel seems to use a Sitronix ST7703 look alike (most of the
commands look similar to the ST7703's data sheet but use a different
number of parameters). The initial version of the DSI init sequence
(including sleeps) were provided by the vendor. Sleeps were reduced
considerably though to speed up initialization.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/gpu/drm/panel/Kconfig                 |  12 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../drm/panel/panel-rocktech-jh057n00900.c    | 414 ++++++++++++++++++
 3 files changed, 427 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 3e070153ef21..4647d29afd6c 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -149,6 +149,18 @@ config DRM_PANEL_RAYDIUM_RM68200
 	  Say Y here if you want to enable support for Raydium RM68200
 	  720x1280 DSI video mode panel.
 
+config DRM_PANEL_ROCKTECH_JH057N00900
+	tristate "Rocktech JH057N00900 MIPI touchscreen panel"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	help
+	  Say Y here if you want to enable support for Rocktech JH057N00900
+	  MIPI DSI panel as e.g. used in the Librem 5 devkit. It has a
+	  resolution of 720x1440 pixels, a built in backlight and touch
+	  controller.
+	  Touch input support is provided by the goodix driver and needs to be
+	  selected separately.
+
 config DRM_PANEL_SAMSUNG_S6D16D0
 	tristate "Samsung S6D16D0 DSI video mode panel"
 	depends on OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index e7ab71968bbf..902e871059d0 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_DRM_PANEL_ORISETECH_OTM8009A) += panel-orisetech-otm8009a.o
 obj-$(CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00) += panel-panasonic-vvx10f034n00.o
 obj-$(CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN) += panel-raspberrypi-touchscreen.o
 obj-$(CONFIG_DRM_PANEL_RAYDIUM_RM68200) += panel-raydium-rm68200.o
+obj-$(CONFIG_DRM_PANEL_ROCKTECH_JH057N00900) += panel-rocktech-jh057n00900.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_LD9040) += panel-samsung-ld9040.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6D16D0) += panel-samsung-s6d16d0.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2) += panel-samsung-s6e3ha2.o
diff --git a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
new file mode 100644
index 000000000000..9619b5cdb7f6
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
@@ -0,0 +1,414 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Rockteck jh057n00900 5.5" MIPI-DSI panel driver
+ *
+ * Copyright (C) Purism SPC 2019
+ */
+#include <drm/drmP.h>
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_panel.h>
+#include <linux/backlight.h>
+#include <linux/gpio/consumer.h>
+#include <video/mipi_display.h>
+#include <video/display_timing.h>
+#include <linux/debugfs.h>
+
+#define DRV_NAME "jh057n00900"
+
+/* Manufacturer specific Commands send via DSI */
+#define ST7703_CMD_ALL_PIXEL_OFF 0x22
+#define ST7703_CMD_ALL_PIXEL_ON	 0x23
+#define ST7703_CMD_SETDISP	 0xB2
+#define ST7703_CMD_SETRGBIF	 0xB3
+#define ST7703_CMD_SETCYC	 0xB4
+#define ST7703_CMD_SETBGP	 0xB5
+#define ST7703_CMD_SETVCOM	 0xB6
+#define ST7703_CMD_SETOTP	 0xB7
+#define ST7703_CMD_SETPOWER_EXT	 0xB8
+#define ST7703_CMD_SETEXTC	 0xB9
+#define ST7703_CMD_SETMIPI	 0xBA
+#define ST7703_CMD_SETVDC	 0xBC
+#define ST7703_CMD_SETSCR	 0xC0
+#define ST7703_CMD_SETPOWER	 0xC1
+#define ST7703_CMD_SETPANEL	 0xCC
+#define ST7703_CMD_SETGAMMA	 0xE0
+#define ST7703_CMD_SETEQ	 0xE3
+#define ST7703_CMD_SETGIP1	 0xE9
+#define ST7703_CMD_SETGIP2	 0xEA
+
+struct jh057n {
+	struct device *dev;
+	struct drm_panel panel;
+	struct gpio_desc *reset_gpio;
+	struct backlight_device *backlight;
+	bool prepared;
+	bool enabled;
+
+	struct dentry *debugfs;
+};
+
+static inline struct jh057n *panel_to_jh057n(struct drm_panel *panel)
+{
+	return container_of(panel, struct jh057n, panel);
+}
+
+#define dsi_generic_write_seq(dsi, seq...) do {				\
+		static const u8 d[] = { seq };				\
+		int ret;						\
+		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));	\
+		if (ret < 0)						\
+			return ret;					\
+	} while (0)
+
+static int jh057n_init_sequence(struct jh057n *ctx)
+{
+	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
+	struct device *dev = ctx->dev;
+	int ret;
+
+	/*
+	 * Init sequence was supplied by the panel vendor. Most of the commands
+	 * resemble the ST7703 but the number of parameters often don't match
+	 * so it's likely a clone.
+	 */
+	dsi_generic_write_seq(dsi, ST7703_CMD_SETEXTC,
+			      0xF1, 0x12, 0x83);
+	dsi_generic_write_seq(dsi, ST7703_CMD_SETRGBIF,
+			      0x10, 0x10, 0x05, 0x05, 0x03, 0xFF, 0x00, 0x00,
+			      0x00, 0x00);
+	dsi_generic_write_seq(dsi, ST7703_CMD_SETSCR,
+			      0x73, 0x73, 0x50, 0x50, 0x00, 0x00, 0x08, 0x70,
+			      0x00);
+	dsi_generic_write_seq(dsi, ST7703_CMD_SETVDC, 0x4E);
+	dsi_generic_write_seq(dsi, ST7703_CMD_SETPANEL, 0x0B);
+	dsi_generic_write_seq(dsi, ST7703_CMD_SETCYC, 0x80);
+	dsi_generic_write_seq(dsi, ST7703_CMD_SETDISP, 0xF0, 0x12, 0x30);
+	dsi_generic_write_seq(dsi, ST7703_CMD_SETEQ,
+			      0x07, 0x07, 0x0B, 0x0B, 0x03, 0x0B, 0x00, 0x00,
+			      0x00, 0x00, 0xFF, 0x00, 0xC0, 0x10);
+	dsi_generic_write_seq(dsi, ST7703_CMD_SETBGP, 0x08, 0x08);
+	msleep(20);
+
+	dsi_generic_write_seq(dsi, ST7703_CMD_SETVCOM, 0x3F, 0x3F);
+	dsi_generic_write_seq(dsi, 0xBF, 0x02, 0x11, 0x00);
+	dsi_generic_write_seq(dsi, ST7703_CMD_SETGIP1,
+			      0x82, 0x10, 0x06, 0x05, 0x9E, 0x0A, 0xA5, 0x12,
+			      0x31, 0x23, 0x37, 0x83, 0x04, 0xBC, 0x27, 0x38,
+			      0x0C, 0x00, 0x03, 0x00, 0x00, 0x00, 0x0C, 0x00,
+			      0x03, 0x00, 0x00, 0x00, 0x75, 0x75, 0x31, 0x88,
+			      0x88, 0x88, 0x88, 0x88, 0x88, 0x13, 0x88, 0x64,
+			      0x64, 0x20, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88,
+			      0x02, 0x88, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
+	dsi_generic_write_seq(dsi, ST7703_CMD_SETGIP2,
+			      0x02, 0x21, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			      0x00, 0x00, 0x00, 0x00, 0x02, 0x46, 0x02, 0x88,
+			      0x88, 0x88, 0x88, 0x88, 0x88, 0x64, 0x88, 0x13,
+			      0x57, 0x13, 0x88, 0x88, 0x88, 0x88, 0x88, 0x88,
+			      0x75, 0x88, 0x23, 0x14, 0x00, 0x00, 0x02, 0x00,
+			      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x30, 0x0A,
+			      0xA5, 0x00, 0x00, 0x00, 0x00);
+	dsi_generic_write_seq(dsi, ST7703_CMD_SETGAMMA,
+			      0x00, 0x09, 0x0E, 0x29, 0x2D, 0x3C, 0x41, 0x37,
+			      0x07, 0x0B, 0x0D, 0x10, 0x11, 0x0F, 0x10, 0x11,
+			      0x18, 0x00, 0x09, 0x0E, 0x29, 0x2D, 0x3C, 0x41,
+			      0x37, 0x07, 0x0B, 0x0D, 0x10, 0x11, 0x0F, 0x10,
+			      0x11, 0x18);
+	msleep(20);
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
+	if (ret < 0) {
+		DRM_DEV_ERROR(dev, "Failed to exit sleep mode");
+		return ret;
+	}
+	/* Panel is operational 120 msec after reset */
+	msleep(60);
+	ret = mipi_dsi_dcs_set_display_on(dsi);
+	if (ret)
+		return ret;
+
+	DRM_DEV_DEBUG_DRIVER(dev, "Panel init sequence done");
+	return 0;
+}
+
+static int jh057n_disable(struct drm_panel *panel)
+{
+	struct jh057n *ctx = panel_to_jh057n(panel);
+	int ret;
+
+	if (!ctx->enabled)
+		return 0;
+
+	ret = backlight_disable(ctx->backlight);
+	if (ret < 0)
+		return ret;
+
+	ctx->enabled = false;
+
+	return 0;
+}
+
+static int jh057n_unprepare(struct drm_panel *panel)
+{
+	struct jh057n *ctx = panel_to_jh057n(panel);
+	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
+
+	if (!ctx->prepared)
+		return 0;
+
+	mipi_dsi_dcs_set_display_off(dsi);
+	ctx->prepared = false;
+
+	return 0;
+}
+
+static int jh057n_prepare(struct drm_panel *panel)
+{
+	struct jh057n *ctx = panel_to_jh057n(panel);
+	int ret;
+
+	if (ctx->prepared)
+		return 0;
+
+	DRM_DEV_DEBUG_DRIVER(ctx->dev, "Resetting the panel.");
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	usleep_range(20, 40);
+	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+	msleep(20);
+
+	ret = jh057n_init_sequence(ctx);
+	if (ret < 0) {
+		DRM_DEV_ERROR(ctx->dev, "Panel init sequence failed: %d", ret);
+		return ret;
+	}
+
+	ctx->prepared = true;
+
+	return 0;
+}
+
+static int jh057n_enable(struct drm_panel *panel)
+{
+	struct jh057n *ctx = panel_to_jh057n(panel);
+	int ret;
+
+	ret = backlight_enable(ctx->backlight);
+	if (ret < 0)
+		return ret;
+
+	ctx->enabled = true;
+
+	return 0;
+}
+
+static const struct drm_display_mode default_mode = {
+	.hdisplay    = 720,
+	.hsync_start = 720 + 90,
+	.hsync_end   = 720 + 90 + 20,
+	.htotal	     = 720 + 90 + 20 + 20,
+	.vdisplay    = 1440,
+	.vsync_start = 1440 + 20,
+	.vsync_end   = 1440 + 20 + 4,
+	.vtotal	     = 1440 + 20 + 4 + 12,
+	.vrefresh    = 60,
+	.clock	     = 75276,
+	.flags	     = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+	.width_mm    = 65,
+	.height_mm   = 130,
+};
+
+static int jh057n_get_modes(struct drm_panel *panel)
+{
+	struct drm_display_mode *mode;
+	u32 bus_format = MEDIA_BUS_FMT_RGB888_1X24;
+	int ret;
+
+	mode = drm_mode_duplicate(panel->drm, &default_mode);
+	if (!mode) {
+		DRM_ERROR("Failed to add mode %ux%ux@%u",
+			  default_mode.hdisplay, default_mode.vdisplay,
+			  default_mode.vrefresh);
+		return -ENOMEM;
+	}
+
+	drm_mode_set_name(mode);
+
+	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
+	panel->connector->display_info.width_mm = mode->width_mm;
+	panel->connector->display_info.height_mm = mode->height_mm;
+	ret = drm_display_info_set_bus_formats(&panel->connector->display_info,
+					       &bus_format, 1);
+	if (ret)
+		return ret;
+
+	drm_mode_probed_add(panel->connector, mode);
+
+	return 1;
+}
+
+static const struct drm_panel_funcs jh057n_drm_funcs = {
+	.disable   = jh057n_disable,
+	.unprepare = jh057n_unprepare,
+	.prepare   = jh057n_prepare,
+	.enable	   = jh057n_enable,
+	.get_modes = jh057n_get_modes,
+};
+
+static int allpixelson_set(void *data, u64 val)
+{
+	struct jh057n *ctx = data;
+	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
+
+	DRM_DEV_DEBUG_DRIVER(ctx->dev, "Setting all pixels on");
+	dsi_generic_write_seq(dsi, ST7703_CMD_ALL_PIXEL_ON);
+	msleep(val*1000);
+	/* Reset the panel to get video back */
+	drm_panel_disable(&ctx->panel);
+	drm_panel_unprepare(&ctx->panel);
+	drm_panel_prepare(&ctx->panel);
+	drm_panel_enable(&ctx->panel);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(allpixelson_fops, NULL,
+			allpixelson_set, "%llu\n");
+
+static int jh057n_debugfs_init(struct jh057n *ctx)
+{
+	struct dentry *f;
+
+	ctx->debugfs = debugfs_create_dir(DRV_NAME, NULL);
+	if (!ctx->debugfs)
+		return -ENOMEM;
+
+	f = debugfs_create_file("allpixelson", 0600,
+				ctx->debugfs, ctx, &allpixelson_fops);
+	if (!f)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void jh057n_debugfs_remove(struct jh057n *ctx)
+{
+	debugfs_remove_recursive(ctx->debugfs);
+	ctx->debugfs = NULL;
+}
+
+static int jh057n_probe(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	struct jh057n *ctx;
+	int ret;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->reset_gpio)) {
+		DRM_DEV_ERROR(dev, "cannot get reset gpio");
+		return PTR_ERR(ctx->reset_gpio);
+	}
+
+	mipi_dsi_set_drvdata(dsi, ctx);
+
+	ctx->dev = dev;
+
+	dsi->lanes = 4;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO |
+		MIPI_DSI_MODE_VIDEO_BURST | MIPI_DSI_MODE_VIDEO_SYNC_PULSE;
+
+	ctx->backlight = devm_of_find_backlight(dev);
+	if (IS_ERR(ctx->backlight))
+		return PTR_ERR(ctx->backlight);
+
+	drm_panel_init(&ctx->panel);
+	ctx->panel.dev = dev;
+	ctx->panel.funcs = &jh057n_drm_funcs;
+
+	drm_panel_add(&ctx->panel);
+
+	ret = mipi_dsi_attach(dsi);
+	if (ret < 0) {
+		DRM_DEV_ERROR(dev, "mipi_dsi_attach failed. Is host ready?");
+		drm_panel_remove(&ctx->panel);
+		goto err;
+	}
+
+	DRM_INFO(DRV_NAME "_panel %ux%u@%u %ubpp dsi %udl - ready",
+		 default_mode.hdisplay, default_mode.vdisplay,
+		 default_mode.vrefresh,
+		 mipi_dsi_pixel_format_to_bpp(dsi->format), dsi->lanes);
+
+	jh057n_debugfs_init(ctx);
+	return 0;
+
+err:
+	if (ctx->backlight)
+		put_device(&ctx->backlight->dev);
+	return ret;
+
+}
+
+static void jh057n_shutdown(struct mipi_dsi_device *dsi)
+{
+	struct jh057n *ctx = mipi_dsi_get_drvdata(dsi);
+	int ret;
+
+	ret = jh057n_unprepare(&ctx->panel);
+	if (ret < 0)
+		DRM_DEV_ERROR(&dsi->dev, "Failed to unprepare panel: %d\n",
+			      ret);
+
+	ret = jh057n_disable(&ctx->panel);
+	if (ret < 0)
+		DRM_DEV_ERROR(&dsi->dev, "Failed to disable panel: %d\n",
+			      ret);
+}
+
+static int jh057n_remove(struct mipi_dsi_device *dsi)
+{
+	struct jh057n *ctx = mipi_dsi_get_drvdata(dsi);
+	int ret;
+
+	jh057n_shutdown(dsi);
+
+	ret = mipi_dsi_detach(dsi);
+	if (ret < 0)
+		DRM_DEV_ERROR(&dsi->dev, "Failed to detach from DSI host: %d\n",
+			      ret);
+
+	drm_panel_remove(&ctx->panel);
+
+	if (ctx->backlight)
+		put_device(&ctx->backlight->dev);
+
+	jh057n_debugfs_remove(ctx);
+
+	return 0;
+}
+
+static const struct of_device_id jh057n_of_match[] = {
+	{ .compatible = "rocktech,jh057n00900" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, jh057n_of_match);
+
+static struct mipi_dsi_driver jh057n_driver = {
+	.probe	= jh057n_probe,
+	.remove = jh057n_remove,
+	.shutdown = jh057n_shutdown,
+	.driver = {
+		.name = DRV_NAME "_panel",
+		.of_match_table = jh057n_of_match,
+	},
+};
+module_mipi_dsi_driver(jh057n_driver);
+
+MODULE_AUTHOR("Guido Günther <agx@sigxcpu.org>");
+MODULE_DESCRIPTION("DRM driver for Rocktech JH057N00900 MIPI DSI panel");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

