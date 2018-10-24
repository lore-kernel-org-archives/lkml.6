Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E42ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6760820832
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6760820832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeJYDMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 23:12:31 -0400
Received: from anholt.net ([50.246.234.109]:53148 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727449AbeJYDMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 23:12:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 56F7410A12E8;
        Wed, 24 Oct 2018 11:43:20 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id zY0icURY2Rmj; Wed, 24 Oct 2018 11:43:16 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id DBBCE10A122F;
        Wed, 24 Oct 2018 11:43:14 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 7F28B2FE1BF2; Wed, 24 Oct 2018 11:43:13 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 2/3] drm: Add an hx8367d tinydrm driver.
Date:   Wed, 24 Oct 2018 11:43:12 -0700
Message-Id: <20181024184313.2967-3-eric@anholt.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181024184313.2967-1-eric@anholt.net>
References: <20181024184313.2967-1-eric@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I want to sort out support for tinydrm in vc4, so I needed to get a
tinydrm-appropriate panel working and this is what I had on hand.
This is derived from a combination of ili9341.c from tinydrm and
fb_hx8357d.c from staging's fbtft.  The register header is copied
directly from staging's fbtft, on the assumption that we will delete
that copy later.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 MAINTAINERS                       |   7 +
 drivers/gpu/drm/tinydrm/Kconfig   |  11 ++
 drivers/gpu/drm/tinydrm/Makefile  |   1 +
 drivers/gpu/drm/tinydrm/hx8357d.c | 261 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/tinydrm/hx8357d.h |  71 ++++++++
 5 files changed, 351 insertions(+)
 create mode 100644 drivers/gpu/drm/tinydrm/hx8357d.c
 create mode 100644 drivers/gpu/drm/tinydrm/hx8357d.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 39c3f6682ace..e78971e20a11 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4623,6 +4623,13 @@ S:	Maintained
 F:	drivers/gpu/drm/tinydrm/ili9225.c
 F:	Documentation/devicetree/bindings/display/ilitek,ili9225.txt
 
+DRM DRIVER FOR HX8357D PANELS
+M:	Eric Anholt <eric@anholt.net>
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+S:	Maintained
+F:	drivers/gpu/drm/tinydrm/hx8357d.c
+F:	Documentation/devicetree/bindings/display/himax,hx8357d.txt
+
 DRM DRIVER FOR INTEL I810 VIDEO CARDS
 S:	Orphan / Obsolete
 F:	drivers/gpu/drm/i810/
diff --git a/drivers/gpu/drm/tinydrm/Kconfig b/drivers/gpu/drm/tinydrm/Kconfig
index 16f4b5c91f1b..2c408ac1a900 100644
--- a/drivers/gpu/drm/tinydrm/Kconfig
+++ b/drivers/gpu/drm/tinydrm/Kconfig
@@ -10,6 +10,17 @@ menuconfig DRM_TINYDRM
 config TINYDRM_MIPI_DBI
 	tristate
 
+config TINYDRM_HX8357D
+	tristate "DRM support for HX8357D display panels"
+	depends on DRM_TINYDRM && SPI
+	depends on BACKLIGHT_CLASS_DEVICE
+	select TINYDRM_MIPI_DBI
+	help
+	  DRM driver for the following HX8357D panels:
+	  * YX350HV15-T 3.5" 340x350 TFT (Adafruit 3.5")
+
+	  If M is selected the module will be called hx8357d.
+
 config TINYDRM_ILI9225
 	tristate "DRM support for ILI9225 display panels"
 	depends on DRM_TINYDRM && SPI
diff --git a/drivers/gpu/drm/tinydrm/Makefile b/drivers/gpu/drm/tinydrm/Makefile
index 14d99080665a..f823066f7743 100644
--- a/drivers/gpu/drm/tinydrm/Makefile
+++ b/drivers/gpu/drm/tinydrm/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_DRM_TINYDRM)		+= core/
 obj-$(CONFIG_TINYDRM_MIPI_DBI)		+= mipi-dbi.o
 
 # Displays
+obj-$(CONFIG_TINYDRM_HX8357D)		+= hx8357d.o
 obj-$(CONFIG_TINYDRM_ILI9225)		+= ili9225.o
 obj-$(CONFIG_TINYDRM_ILI9341)		+= ili9341.o
 obj-$(CONFIG_TINYDRM_MI0283QT)		+= mi0283qt.o
diff --git a/drivers/gpu/drm/tinydrm/hx8357d.c b/drivers/gpu/drm/tinydrm/hx8357d.c
new file mode 100644
index 000000000000..51d4da624d57
--- /dev/null
+++ b/drivers/gpu/drm/tinydrm/hx8357d.c
@@ -0,0 +1,261 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * DRM driver for the HX8357D LCD controller
+ *
+ * Copyright 2018 Broadcom
+ * Copyright 2018 David Lechner <david@lechnology.com>
+ * Copyright 2016 Noralf Trønnes
+ * Copyright (C) 2015 Adafruit Industries
+ * Copyright (C) 2013 Christian Vogelgsang
+ */
+
+#include <linux/backlight.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/spi/spi.h>
+
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_modeset_helper.h>
+#include <drm/tinydrm/mipi-dbi.h>
+#include <drm/tinydrm/tinydrm-helpers.h>
+#include <video/mipi_display.h>
+#include "hx8357d.h"
+
+#define HX8357D_MADCTL_MY  0x80
+#define HX8357D_MADCTL_MX  0x40
+#define HX8357D_MADCTL_MV  0x20
+#define HX8357D_MADCTL_ML  0x10
+#define HX8357D_MADCTL_RGB 0x00
+#define HX8357D_MADCTL_BGR 0x08
+#define HX8357D_MADCTL_MH  0x04
+
+static void yx240qv29_enable(struct drm_simple_display_pipe *pipe,
+			     struct drm_crtc_state *crtc_state,
+			     struct drm_plane_state *plane_state)
+{
+	struct tinydrm_device *tdev = pipe_to_tinydrm(pipe);
+	struct mipi_dbi *mipi = mipi_dbi_from_tinydrm(tdev);
+	u8 addr_mode;
+	int ret;
+
+	DRM_DEBUG_KMS("\n");
+
+	ret = mipi_dbi_poweron_conditional_reset(mipi);
+	if (ret < 0)
+		return;
+	if (ret == 1)
+		goto out_enable;
+
+	/* setextc */
+	mipi_dbi_command(mipi, HX8357D_SETC, 0xFF, 0x83, 0x57);
+	msleep(150);
+
+	/* setRGB which also enables SDO */
+	mipi_dbi_command(mipi, HX8357_SETRGB, 0x00, 0x00, 0x06, 0x06);
+
+	/* -1.52V */
+	mipi_dbi_command(mipi, HX8357D_SETCOM, 0x25);
+
+	/* Normal mode 70Hz, Idle mode 55 Hz */
+	mipi_dbi_command(mipi, HX8357_SETOSC, 0x68);
+
+	/* Set Panel - BGR, Gate direction swapped */
+	mipi_dbi_command(mipi, HX8357_SETPANEL, 0x05);
+
+	mipi_dbi_command(mipi, HX8357_SETPWR1,
+			 0x00,  /* Not deep standby */
+			 0x15,  /* BT */
+			 0x1C,  /* VSPR */
+			 0x1C,  /* VSNR */
+			 0x83,  /* AP */
+			 0xAA);  /* FS */
+
+	mipi_dbi_command(mipi, HX8357D_SETSTBA,
+			 0x50,  /* OPON normal */
+			 0x50,  /* OPON idle */
+			 0x01,  /* STBA */
+			 0x3C,  /* STBA */
+			 0x1E,  /* STBA */
+			 0x08);  /* GEN */
+
+	mipi_dbi_command(mipi, HX8357D_SETCYC,
+			 0x02,  /* NW 0x02 */
+			 0x40,  /* RTN */
+			 0x00,  /* DIV */
+			 0x2A,  /* DUM */
+			 0x2A,  /* DUM */
+			 0x0D,  /* GDON */
+			 0x78);  /* GDOFF */
+
+	mipi_dbi_command(mipi, HX8357D_SETGAMMA,
+			 0x02,
+			 0x0A,
+			 0x11,
+			 0x1d,
+			 0x23,
+			 0x35,
+			 0x41,
+			 0x4b,
+			 0x4b,
+			 0x42,
+			 0x3A,
+			 0x27,
+			 0x1B,
+			 0x08,
+			 0x09,
+			 0x03,
+			 0x02,
+			 0x0A,
+			 0x11,
+			 0x1d,
+			 0x23,
+			 0x35,
+			 0x41,
+			 0x4b,
+			 0x4b,
+			 0x42,
+			 0x3A,
+			 0x27,
+			 0x1B,
+			 0x08,
+			 0x09,
+			 0x03,
+			 0x00,
+			 0x01);
+
+	/* 16 bit */
+	mipi_dbi_command(mipi, MIPI_DCS_SET_PIXEL_FORMAT,
+			 MIPI_DCS_PIXEL_FMT_16BIT);
+
+	/* TE off */
+	mipi_dbi_command(mipi, MIPI_DCS_SET_TEAR_ON, 0x00);
+
+	/* tear line */
+	mipi_dbi_command(mipi, MIPI_DCS_SET_TEAR_SCANLINE, 0x00, 0x02);
+
+	/* Exit Sleep */
+	mipi_dbi_command(mipi, MIPI_DCS_EXIT_SLEEP_MODE);
+	msleep(150);
+
+	/* display on */
+	mipi_dbi_command(mipi, MIPI_DCS_SET_DISPLAY_ON);
+	usleep_range(5000, 7000);
+
+out_enable:
+	switch (mipi->rotation) {
+	default:
+		addr_mode = HX8357D_MADCTL_MX | HX8357D_MADCTL_MY;
+		break;
+	case 90:
+		addr_mode = HX8357D_MADCTL_MV | HX8357D_MADCTL_MY;
+		break;
+	case 180:
+		addr_mode = 0;
+		break;
+	case 270:
+		addr_mode = HX8357D_MADCTL_MV | HX8357D_MADCTL_MX;
+		break;
+	}
+	mipi_dbi_command(mipi, MIPI_DCS_SET_ADDRESS_MODE, addr_mode);
+	mipi_dbi_enable_flush(mipi, crtc_state, plane_state);
+}
+
+static const struct drm_simple_display_pipe_funcs hx8357d_pipe_funcs = {
+	.enable = yx240qv29_enable,
+	.disable = mipi_dbi_pipe_disable,
+	.update = tinydrm_display_pipe_update,
+	.prepare_fb = drm_gem_fb_simple_display_pipe_prepare_fb,
+};
+
+static const struct drm_display_mode yx350hv15_mode = {
+	TINYDRM_MODE(320, 480, 60, 75),
+};
+
+DEFINE_DRM_GEM_CMA_FOPS(hx8357d_fops);
+
+static struct drm_driver hx8357d_driver = {
+	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_PRIME | DRIVER_ATOMIC,
+	.fops			= &hx8357d_fops,
+	TINYDRM_GEM_DRIVER_OPS,
+	.debugfs_init		= mipi_dbi_debugfs_init,
+	.name			= "hx8357d",
+	.desc			= "HX8357D",
+	.date			= "20181023",
+	.major			= 1,
+	.minor			= 0,
+};
+
+static const struct of_device_id hx8357d_of_match[] = {
+	{ .compatible = "adafruit,yx350hv15" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, hx8357d_of_match);
+
+static const struct spi_device_id hx8357d_id[] = {
+	{ "hx8357d", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, hx8357d_id);
+
+static int hx8357d_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct mipi_dbi *mipi;
+	struct gpio_desc *dc;
+	u32 rotation = 0;
+	int ret;
+
+	mipi = devm_kzalloc(dev, sizeof(*mipi), GFP_KERNEL);
+	if (!mipi)
+		return -ENOMEM;
+
+	dc = devm_gpiod_get(dev, "dc", GPIOD_OUT_LOW);
+	if (IS_ERR(dc)) {
+		DRM_DEV_ERROR(dev, "Failed to get gpio 'dc'\n");
+		return PTR_ERR(dc);
+	}
+
+	mipi->backlight = devm_of_find_backlight(dev);
+	if (IS_ERR(mipi->backlight))
+		return PTR_ERR(mipi->backlight);
+
+	device_property_read_u32(dev, "rotation", &rotation);
+
+	ret = mipi_dbi_spi_init(spi, mipi, dc);
+	if (ret)
+		return ret;
+
+	ret = mipi_dbi_init(&spi->dev, mipi, &hx8357d_pipe_funcs,
+			    &hx8357d_driver, &yx350hv15_mode, rotation);
+	if (ret)
+		return ret;
+
+	spi_set_drvdata(spi, mipi);
+
+	return devm_tinydrm_register(&mipi->tinydrm);
+}
+
+static void hx8357d_shutdown(struct spi_device *spi)
+{
+	struct mipi_dbi *mipi = spi_get_drvdata(spi);
+
+	tinydrm_shutdown(&mipi->tinydrm);
+}
+
+static struct spi_driver hx8357d_spi_driver = {
+	.driver = {
+		.name = "hx8357d",
+		.of_match_table = hx8357d_of_match,
+	},
+	.id_table = hx8357d_id,
+	.probe = hx8357d_probe,
+	.shutdown = hx8357d_shutdown,
+};
+module_spi_driver(hx8357d_spi_driver);
+
+MODULE_DESCRIPTION("HX8357D DRM driver");
+MODULE_AUTHOR("Eric Anholt <eric@anholt.net>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/tinydrm/hx8357d.h b/drivers/gpu/drm/tinydrm/hx8357d.h
new file mode 100644
index 000000000000..6180b093f94f
--- /dev/null
+++ b/drivers/gpu/drm/tinydrm/hx8357d.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * This is our library for the Adafruit  ILI9341 Breakout and Shield
+ * ----> http://www.adafruit.com/products/1651
+ *
+ * Check out the links above for our tutorials and wiring diagrams
+ * These displays use SPI to communicate, 4 or 5 pins are required to
+ * interface (RST is optional)
+ * Adafruit invests time and resources providing this open source code,
+ * please support Adafruit and open-source hardware by purchasing
+ * products from Adafruit!
+ *
+ * Written by Limor Fried/Ladyada for Adafruit Industries.
+ * MIT license, all text above must be included in any redistribution
+ */
+
+#ifndef __HX8357_H__
+#define __HX8357_H__
+
+#define HX8357D 0xD
+#define HX8357B 0xB
+
+#define HX8357_TFTWIDTH  320
+#define HX8357_TFTHEIGHT 480
+
+#define HX8357_SETOSC 0xB0
+#define HX8357_SETPWR1 0xB1
+#define HX8357B_SETDISPLAY 0xB2
+#define HX8357_SETRGB 0xB3
+#define HX8357D_SETCOM  0xB6
+
+#define HX8357B_SETDISPMODE  0xB4
+#define HX8357D_SETCYC  0xB4
+#define HX8357B_SETOTP 0xB7
+#define HX8357D_SETC 0xB9
+
+#define HX8357B_SET_PANEL_DRIVING 0xC0
+#define HX8357D_SETSTBA 0xC0
+#define HX8357B_SETDGC  0xC1
+#define HX8357B_SETID  0xC3
+#define HX8357B_SETDDB  0xC4
+#define HX8357B_SETDISPLAYFRAME 0xC5
+#define HX8357B_GAMMASET 0xC8
+#define HX8357B_SETCABC  0xC9
+#define HX8357_SETPANEL  0xCC
+
+#define HX8357B_SETPOWER 0xD0
+#define HX8357B_SETVCOM 0xD1
+#define HX8357B_SETPWRNORMAL 0xD2
+
+#define HX8357B_RDID1   0xDA
+#define HX8357B_RDID2   0xDB
+#define HX8357B_RDID3   0xDC
+#define HX8357B_RDID4   0xDD
+
+#define HX8357D_SETGAMMA 0xE0
+
+#define HX8357B_SETGAMMA 0xC8
+#define HX8357B_SETPANELRELATED  0xE9
+
+/* Color definitions */
+#define	HX8357_BLACK   0x0000
+#define	HX8357_BLUE    0x001F
+#define	HX8357_RED     0xF800
+#define	HX8357_GREEN   0x07E0
+#define HX8357_CYAN    0x07FF
+#define HX8357_MAGENTA 0xF81F
+#define HX8357_YELLOW  0xFFE0
+#define HX8357_WHITE   0xFFFF
+
+#endif /* __HX8357_H__ */
-- 
2.19.1

