Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B67C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0502146F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="G9NE0Dmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732470AbfAKMrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 07:47:36 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44491 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbfAKMrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 07:47:35 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so6269942pgr.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 04:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TLyO1ePs6zB+Gtekws3iqR5Rlyk1bqW/Mx2DIXlnqnk=;
        b=G9NE0DmgidUAaFTnzQVaXzbeoTWA2VGsNERElGT81u2G/+hwWkVE7uUK30v0XEXqmZ
         PxJosNSxVYrJz1AoCu6BhpQwJXpwNMBtS5+b0iJFBhAsvOrToGy7qfj9cIEBmmoy6LRw
         GmGRAaevgFUrKQDK/NH6ofUbmbZHa6WKniOL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TLyO1ePs6zB+Gtekws3iqR5Rlyk1bqW/Mx2DIXlnqnk=;
        b=JQK/HZmGwVcE8nqYopdUKHkVcRVtQ9tHqZ8SUUAcmkiYmxH/lYhTJhZoI/Hu/9oWun
         zYBN6IFbJCXRQajfhDFNp1RK/6wWTBgvVQT7L6EbAn/DrQS+57woybpOqHQSMnaTQewP
         qYVu5An7DIUYTlNY0kzCqa9c7gw9gUNBjJaCm9rvuzAO5m+Udh6koxg93g1ikCIJA4v/
         Q0Y6BLbv1YihtVjuN/Uj4TazUMiusDS1uNyCMAiWttBDr5wP7zAwU7nsna6p3FBahP1v
         6Xxf+6TjnS4Ey6t0fzjo4GDyGG1am8m0jQ/j9fo6uSoTDWQkeO4YPW8nZTGa8efoa16t
         1+0A==
X-Gm-Message-State: AJcUukc0gC5UVq4lB72OzMuh+IibY4R7O5fx0eTsxzlgJQqMtwOHWT5t
        hZPhGa+9FkoaYCrJPiFkQYRAbg==
X-Google-Smtp-Source: ALg8bN7CICLe1RWJor97kDitNN5VYgK8bzNdBlGcLBIubDfu15TcVwAv3mZ4YgTswBz2GXnF87yuew==
X-Received: by 2002:a62:710a:: with SMTP id m10mr14387160pfc.69.1547210854629;
        Fri, 11 Jan 2019 04:47:34 -0800 (PST)
Received: from localhost.localdomain ([49.206.202.55])
        by smtp.gmail.com with ESMTPSA id m19sm247359326pgn.35.2019.01.11.04.47.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 04:47:34 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH V7 2/2] drm/panel: Add Sitronix ST7701 panel driver
Date:   Fri, 11 Jan 2019 18:17:14 +0530
Message-Id: <20190111124714.19566-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190111124714.19566-1-jagan@amarulasolutions.com>
References: <20190111124714.19566-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ST7701 designed for small and medium sizes of TFT LCD display, is
capable of supporting up to 480RGBX864 in resolution. It provides
several system interfaces like MIPI/RGB/SPI.

Currently added support for Techstar TS8550B which is ST7701 based
480x854, 2-lane MIPI DSI LCD panel.

Driver now registering mipi_dsi device, but indeed it can extendable
for RGB if any requirement trigger in future.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v7:
- rebase on master
Changes for v6:
- use sleep delay value as per datasheet
- add panel_sleep_delay variable for panel specific delay
- use command sequnce display on and off instead panel
  functions
- add proper comments on the delays
- remove delays from command switch
- move mode type on struct display mode
- drop refresh rate value, let drm compute  
Changes for v5:
- found the chip from vendor, so added new panel driver
- here is v4: https://patchwork.kernel.org/patch/10680335/

 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/panel/Kconfig                 |  10 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-sitronix-st7701.c | 427 ++++++++++++++++++
 4 files changed, 444 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-sitronix-st7701.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3f6db876be1f..d2928a4d2847 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4831,6 +4831,12 @@ S:	Orphan / Obsolete
 F:	drivers/gpu/drm/sis/
 F:	include/uapi/drm/sis_drm.h
 
+DRM DRIVER FOR SITRONIX ST7701 PANELS
+M:	Jagan Teki <jagan@amarulasolutions.com>
+S:	Maintained
+F:	drivers/gpu/drm/panel/panel-sitronix-st7701.c
+F:	Documentation/devicetree/bindings/display/panel/sitronix,st7701.txt
+
 DRM DRIVER FOR SITRONIX ST7586 PANELS
 M:	David Lechner <david@lechnology.com>
 S:	Maintained
diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 3f3537719beb..d93b2ba709bc 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -196,6 +196,16 @@ config DRM_PANEL_SHARP_LS043T1LE01
 	  Say Y here if you want to enable support for Sharp LS043T1LE01 qHD
 	  (540x960) DSI panel as found on the Qualcomm APQ8074 Dragonboard
 
+config DRM_PANEL_SITRONIX_ST7701
+	tristate "Sitronix ST7701 panel driver"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y here if you want to enable support for the Sitronix
+	  ST7701 controller for 480X864 LCD panels with MIPI/RGB/SPI
+	  system interfaces.
+
 config DRM_PANEL_SITRONIX_ST7789V
 	tristate "Sitronix ST7789V panel"
 	depends on OF && SPI
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index 4396658a7996..6a9b4cec1891 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -20,5 +20,6 @@ obj-$(CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0) += panel-samsung-s6e8aa0.o
 obj-$(CONFIG_DRM_PANEL_SEIKO_43WVF1G) += panel-seiko-43wvf1g.o
 obj-$(CONFIG_DRM_PANEL_SHARP_LQ101R1SX01) += panel-sharp-lq101r1sx01.o
 obj-$(CONFIG_DRM_PANEL_SHARP_LS043T1LE01) += panel-sharp-ls043t1le01.o
+obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7701) += panel-sitronix-st7701.o
 obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7789V) += panel-sitronix-st7789v.o
 obj-$(CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA) += panel-truly-nt35597.o
diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7701.c b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
new file mode 100644
index 000000000000..8638a5463cb6
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
@@ -0,0 +1,427 @@
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
+/* Command2 BKx selection command */
+#define DSI_CMD2BKX_SEL			0xFF
+
+/* Command2, BK0 commands */
+#define DSI_CMD2_BK0_PVGAMCTRL		0xB0 /* Positive Voltage Gamma Control */
+#define DSI_CMD2_BK0_NVGAMCTRL		0xB1 /* Negative Voltage Gamma Control */
+#define DSI_CMD2_BK0_LNESET		0xC0 /* Display Line setting */
+#define DSI_CMD2_BK0_PORCTRL		0xC1 /* Porch control */
+#define DSI_CMD2_BK0_INVSEL		0xC2 /* Inversion selection, Frame Rate Control */
+
+/* Command2, BK1 commands */
+#define DSI_CMD2_BK1_VRHS		0xB0 /* Vop amplitude setting */
+#define DSI_CMD2_BK1_VCOM		0xB1 /* VCOM amplitude setting */
+#define DSI_CMD2_BK1_VGHSS		0xB2 /* VGH Voltage setting */
+#define DSI_CMD2_BK1_TESTCMD		0xB3 /* TEST Command Setting */
+#define DSI_CMD2_BK1_VGLS		0xB5 /* VGL Voltage setting */
+#define DSI_CMD2_BK1_PWCTLR1		0xB7 /* Power Control 1 */
+#define DSI_CMD2_BK1_PWCTLR2		0xB8 /* Power Control 2 */
+#define DSI_CMD2_BK1_SPD1		0xC1 /* Source pre_drive timing set1 */
+#define DSI_CMD2_BK1_SPD2		0xC2 /* Source EQ2 Setting */
+#define DSI_CMD2_BK1_MIPISET1		0xD0 /* MIPI Setting 1 */
+
+/**
+ * Command2 with BK function selection.
+ *
+ * BIT[4, 0]: [CN2, BKXSEL]
+ * 10 = CMD2BK0, Command2 BK0
+ * 11 = CMD2BK1, Command2 BK1
+ * 00 = Command2 disable
+ */
+#define DSI_CMD2BK1_SEL			0x11
+#define DSI_CMD2BK0_SEL			0x10
+#define DSI_CMD2BKX_SEL_NONE		0x00
+
+/* Command2, BK0 bytes */
+#define DSI_LINESET_LINE		0x69
+#define DSI_LINESET_LDE_EN		BIT(7)
+#define DSI_LINESET_LINEDELTA		GENMASK(1, 0)
+#define DSI_CMD2_BK0_LNESET_B1		DSI_LINESET_LINEDELTA
+#define DSI_CMD2_BK0_LNESET_B0		(DSI_LINESET_LDE_EN | DSI_LINESET_LINE)
+#define DSI_INVSEL_DEFAULT		GENMASK(5, 4)
+#define DSI_INVSEL_NLINV		GENMASK(2, 0)
+#define DSI_INVSEL_RTNI			GENMASK(2, 1)
+#define DSI_CMD2_BK0_INVSEL_B1		DSI_INVSEL_RTNI
+#define DSI_CMD2_BK0_INVSEL_B0		(DSI_INVSEL_DEFAULT | DSI_INVSEL_NLINV)
+#define DSI_CMD2_BK0_PORCTRL_B0(m)	((m)->vtotal - (m)->vsync_end)
+#define DSI_CMD2_BK0_PORCTRL_B1(m)	((m)->vsync_start - (m)->vdisplay)
+
+/* Command2, BK1 bytes */
+#define DSI_CMD2_BK1_VRHA_SET		0x45
+#define DSI_CMD2_BK1_VCOM_SET		0x13
+#define DSI_CMD2_BK1_VGHSS_SET		GENMASK(2, 0)
+#define DSI_CMD2_BK1_TESTCMD_VAL	BIT(7)
+#define DSI_VGLS_DEFAULT		BIT(6)
+#define DSI_VGLS_SEL			GENMASK(2, 0)
+#define DSI_CMD2_BK1_VGLS_SET		(DSI_VGLS_DEFAULT | DSI_VGLS_SEL)
+#define DSI_PWCTLR1_AP			BIT(7) /* Gamma OP bias, max */
+#define DSI_PWCTLR1_APIS		BIT(2) /* Source OP input bias, min */
+#define DSI_PWCTLR1_APOS		BIT(0) /* Source OP output bias, min */
+#define DSI_CMD2_BK1_PWCTLR1_SET	(DSI_PWCTLR1_AP | DSI_PWCTLR1_APIS | \
+					DSI_PWCTLR1_APOS)
+#define DSI_PWCTLR2_AVDD		BIT(5) /* AVDD 6.6v */
+#define DSI_PWCTLR2_AVCL		0x0    /* AVCL -4.4v */
+#define DSI_CMD2_BK1_PWCTLR2_SET	(DSI_PWCTLR2_AVDD | DSI_PWCTLR2_AVCL)
+#define DSI_SPD1_T2D			BIT(3)
+#define DSI_CMD2_BK1_SPD1_SET		(GENMASK(6, 4) | DSI_SPD1_T2D)
+#define DSI_CMD2_BK1_SPD2_SET		DSI_CMD2_BK1_SPD1_SET
+#define DSI_MIPISET1_EOT_EN		BIT(3)
+#define DSI_CMD2_BK1_MIPISET1_SET	(BIT(7) | DSI_MIPISET1_EOT_EN)
+
+struct st7701_panel_desc {
+	const struct drm_display_mode *mode;
+	unsigned int lanes;
+	unsigned long flags;
+	enum mipi_dsi_pixel_format format;
+	const char *const *supply_names;
+	unsigned int num_supplies;
+	unsigned int panel_sleep_delay;
+};
+
+struct st7701 {
+	struct drm_panel panel;
+	struct mipi_dsi_device *dsi;
+	const struct st7701_panel_desc *desc;
+
+	struct backlight_device *backlight;
+	struct regulator_bulk_data *supplies;
+	unsigned int num_supplies;
+	struct gpio_desc *reset;
+	unsigned int sleep_delay;
+};
+
+static inline struct st7701 *panel_to_st7701(struct drm_panel *panel)
+{
+	return container_of(panel, struct st7701, panel);
+}
+
+static inline int st7701_dsi_write(struct st7701 *st7701, const void *seq,
+				   size_t len)
+{
+	return mipi_dsi_dcs_write_buffer(st7701->dsi, seq, len);
+}
+
+#define ST7701_DSI(st7701, seq...)				\
+	{							\
+		const u8 d[] = { seq };				\
+		st7701_dsi_write(st7701, d, ARRAY_SIZE(d));	\
+	}
+
+static void st7701_init_sequence(struct st7701 *st7701)
+{
+	const struct drm_display_mode *mode = st7701->desc->mode;
+
+	ST7701_DSI(st7701, MIPI_DCS_SOFT_RESET, 0x00);
+
+	/* We need to wait 5ms before sending new commands */
+	msleep(5);
+
+	ST7701_DSI(st7701, MIPI_DCS_EXIT_SLEEP_MODE, 0x00);
+
+	msleep(st7701->sleep_delay);
+
+	/* Command2, BK0 */
+	ST7701_DSI(st7701, DSI_CMD2BKX_SEL,
+		   0x77, 0x01, 0x00, 0x00, DSI_CMD2BK0_SEL);
+	ST7701_DSI(st7701, DSI_CMD2_BK0_PVGAMCTRL, 0x00, 0x0E, 0x15, 0x0F,
+		   0x11, 0x08, 0x08, 0x08, 0x08, 0x23, 0x04, 0x13, 0x12,
+		   0x2B, 0x34, 0x1F);
+	ST7701_DSI(st7701, DSI_CMD2_BK0_NVGAMCTRL, 0x00, 0x0E, 0x95, 0x0F,
+		   0x13, 0x07, 0x09, 0x08, 0x08, 0x22, 0x04, 0x10, 0x0E,
+		   0x2C, 0x34, 0x1F);
+	ST7701_DSI(st7701, DSI_CMD2_BK0_LNESET,
+		   DSI_CMD2_BK0_LNESET_B0, DSI_CMD2_BK0_LNESET_B1);
+	ST7701_DSI(st7701, DSI_CMD2_BK0_PORCTRL,
+		   DSI_CMD2_BK0_PORCTRL_B0(mode),
+		   DSI_CMD2_BK0_PORCTRL_B1(mode));
+	ST7701_DSI(st7701, DSI_CMD2_BK0_INVSEL,
+		   DSI_CMD2_BK0_INVSEL_B0, DSI_CMD2_BK0_INVSEL_B1);
+
+	/* Command2, BK1 */
+	ST7701_DSI(st7701, DSI_CMD2BKX_SEL,
+			0x77, 0x01, 0x00, 0x00, DSI_CMD2BK1_SEL);
+	ST7701_DSI(st7701, DSI_CMD2_BK1_VRHS, DSI_CMD2_BK1_VRHA_SET);
+	ST7701_DSI(st7701, DSI_CMD2_BK1_VCOM, DSI_CMD2_BK1_VCOM_SET);
+	ST7701_DSI(st7701, DSI_CMD2_BK1_VGHSS, DSI_CMD2_BK1_VGHSS_SET);
+	ST7701_DSI(st7701, DSI_CMD2_BK1_TESTCMD, DSI_CMD2_BK1_TESTCMD_VAL);
+	ST7701_DSI(st7701, DSI_CMD2_BK1_VGLS, DSI_CMD2_BK1_VGLS_SET);
+	ST7701_DSI(st7701, DSI_CMD2_BK1_PWCTLR1, DSI_CMD2_BK1_PWCTLR1_SET);
+	ST7701_DSI(st7701, DSI_CMD2_BK1_PWCTLR2, DSI_CMD2_BK1_PWCTLR2_SET);
+	ST7701_DSI(st7701, DSI_CMD2_BK1_SPD1, DSI_CMD2_BK1_SPD1_SET);
+	ST7701_DSI(st7701, DSI_CMD2_BK1_SPD2, DSI_CMD2_BK1_SPD2_SET);
+	ST7701_DSI(st7701, DSI_CMD2_BK1_MIPISET1, DSI_CMD2_BK1_MIPISET1_SET);
+
+	/**
+	 * ST7701_SPEC_V1.2 is unable to provide enough information above this
+	 * specific command sequence, so grab the same from vendor BSP driver.
+	 */
+	ST7701_DSI(st7701, 0xE0, 0x00, 0x00, 0x02);
+	ST7701_DSI(st7701, 0xE1, 0x0B, 0x00, 0x0D, 0x00, 0x0C, 0x00, 0x0E,
+		   0x00, 0x00, 0x44, 0x44);
+	ST7701_DSI(st7701, 0xE2, 0x33, 0x33, 0x44, 0x44, 0x64, 0x00, 0x66,
+		   0x00, 0x65, 0x00, 0x67, 0x00, 0x00);
+	ST7701_DSI(st7701, 0xE3, 0x00, 0x00, 0x33, 0x33);
+	ST7701_DSI(st7701, 0xE4, 0x44, 0x44);
+	ST7701_DSI(st7701, 0xE5, 0x0C, 0x78, 0x3C, 0xA0, 0x0E, 0x78, 0x3C,
+		   0xA0, 0x10, 0x78, 0x3C, 0xA0, 0x12, 0x78, 0x3C, 0xA0);
+	ST7701_DSI(st7701, 0xE6, 0x00, 0x00, 0x33, 0x33);
+	ST7701_DSI(st7701, 0xE7, 0x44, 0x44);
+	ST7701_DSI(st7701, 0xE8, 0x0D, 0x78, 0x3C, 0xA0, 0x0F, 0x78, 0x3C,
+		   0xA0, 0x11, 0x78, 0x3C, 0xA0, 0x13, 0x78, 0x3C, 0xA0);
+	ST7701_DSI(st7701, 0xEB, 0x02, 0x02, 0x39, 0x39, 0xEE, 0x44, 0x00);
+	ST7701_DSI(st7701, 0xEC, 0x00, 0x00);
+	ST7701_DSI(st7701, 0xED, 0xFF, 0xF1, 0x04, 0x56, 0x72, 0x3F, 0xFF,
+		   0xFF, 0xFF, 0xFF, 0xF3, 0x27, 0x65, 0x40, 0x1F, 0xFF);
+
+	/* disable Command2 */
+	ST7701_DSI(st7701, DSI_CMD2BKX_SEL,
+		   0x77, 0x01, 0x00, 0x00, DSI_CMD2BKX_SEL_NONE);
+}
+
+static int st7701_prepare(struct drm_panel *panel)
+{
+	struct st7701 *st7701 = panel_to_st7701(panel);
+	int ret;
+
+	gpiod_set_value(st7701->reset, 0);
+	msleep(20);
+
+	ret = regulator_bulk_enable(st7701->desc->num_supplies,
+				    st7701->supplies);
+	if (ret < 0)
+		return ret;
+	msleep(20);
+
+	gpiod_set_value(st7701->reset, 1);
+	msleep(20);
+
+	gpiod_set_value(st7701->reset, 0);
+	msleep(30);
+
+	gpiod_set_value(st7701->reset, 1);
+	msleep(150);
+
+	st7701_init_sequence(st7701);
+
+	return 0;
+}
+
+static int st7701_enable(struct drm_panel *panel)
+{
+	struct st7701 *st7701 = panel_to_st7701(panel);
+
+	ST7701_DSI(st7701, MIPI_DCS_SET_DISPLAY_ON, 0x00);
+	backlight_enable(st7701->backlight);
+
+	return 0;
+}
+
+static int st7701_disable(struct drm_panel *panel)
+{
+	struct st7701 *st7701 = panel_to_st7701(panel);
+
+	backlight_disable(st7701->backlight);
+	ST7701_DSI(st7701, MIPI_DCS_SET_DISPLAY_OFF, 0x00);
+
+	return 0;
+}
+
+static int st7701_unprepare(struct drm_panel *panel)
+{
+	struct st7701 *st7701 = panel_to_st7701(panel);
+
+	ST7701_DSI(st7701, MIPI_DCS_EXIT_SLEEP_MODE, 0x00);
+
+	msleep(st7701->sleep_delay);
+
+	gpiod_set_value(st7701->reset, 0);
+
+	gpiod_set_value(st7701->reset, 1);
+
+	gpiod_set_value(st7701->reset, 0);
+
+	regulator_bulk_disable(st7701->desc->num_supplies, st7701->supplies);
+
+	return 0;
+}
+
+static int st7701_get_modes(struct drm_panel *panel)
+{
+	struct st7701 *st7701 = panel_to_st7701(panel);
+	const struct drm_display_mode *desc_mode = st7701->desc->mode;
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_duplicate(panel->drm, desc_mode);
+	if (!mode) {
+		dev_err(&st7701->dsi->dev, "failed to add mode %ux%ux@%u\n",
+			desc_mode->hdisplay, desc_mode->vdisplay,
+			desc_mode->vrefresh);
+		return -ENOMEM;
+	}
+
+	drm_mode_set_name(mode);
+	drm_mode_probed_add(panel->connector, mode);
+
+	panel->connector->display_info.width_mm = desc_mode->width_mm;
+	panel->connector->display_info.height_mm = desc_mode->height_mm;
+
+	return 1;
+}
+
+static const struct drm_panel_funcs st7701_funcs = {
+	.disable	= st7701_disable,
+	.unprepare	= st7701_unprepare,
+	.prepare	= st7701_prepare,
+	.enable		= st7701_enable,
+	.get_modes	= st7701_get_modes,
+};
+
+static const struct drm_display_mode ts8550b_mode = {
+	.clock		= 27500,
+
+	.hdisplay	= 480,
+	.hsync_start	= 480 + 38,
+	.hsync_end	= 480 + 38 + 12,
+	.htotal		= 480 + 38 + 12 + 12,
+
+	.vdisplay	= 854,
+	.vsync_start	= 854 + 4,
+	.vsync_end	= 854 + 4 + 8,
+	.vtotal		= 854 + 4 + 8 + 18,
+
+	.width_mm	= 69,
+	.height_mm	= 139,
+
+	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
+static const char * const ts8550b_supply_names[] = {
+	"VCC",
+	"IOVCC",
+};
+
+static const struct st7701_panel_desc ts8550b_desc = {
+	.mode = &ts8550b_mode,
+	.lanes = 2,
+	.flags = MIPI_DSI_MODE_VIDEO,
+	.format = MIPI_DSI_FMT_RGB888,
+	.supply_names = ts8550b_supply_names,
+	.num_supplies = ARRAY_SIZE(ts8550b_supply_names),
+	.panel_sleep_delay = 80, /* panel need extra 80ms for sleep out cmd */
+};
+
+static int st7701_dsi_probe(struct mipi_dsi_device *dsi)
+{
+	const struct st7701_panel_desc *desc;
+	struct device_node *np;
+	struct st7701 *st7701;
+	int ret, i;
+
+	st7701 = devm_kzalloc(&dsi->dev, sizeof(*st7701), GFP_KERNEL);
+	if (!st7701)
+		return -ENOMEM;
+
+	desc = of_device_get_match_data(&dsi->dev);
+	dsi->mode_flags = desc->flags;
+	dsi->format = desc->format;
+	dsi->lanes = desc->lanes;
+
+	st7701->supplies = devm_kcalloc(&dsi->dev, desc->num_supplies,
+					sizeof(*st7701->supplies),
+					GFP_KERNEL);
+	if (!st7701->supplies)
+		return -ENOMEM;
+
+	for (i = 0; i < desc->num_supplies; i++)
+		st7701->supplies[i].supply = desc->supply_names[i];
+
+	ret = devm_regulator_bulk_get(&dsi->dev, desc->num_supplies,
+				      st7701->supplies);
+	if (ret < 0)
+		return ret;
+
+	st7701->reset = devm_gpiod_get(&dsi->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(st7701->reset)) {
+		dev_err(&dsi->dev, "Couldn't get our reset GPIO\n");
+		return PTR_ERR(st7701->reset);
+	}
+
+	np = of_parse_phandle(dsi->dev.of_node, "backlight", 0);
+	if (np) {
+		st7701->backlight = of_find_backlight_by_node(np);
+		of_node_put(np);
+
+		if (!st7701->backlight)
+			return -EPROBE_DEFER;
+	}
+
+	drm_panel_init(&st7701->panel);
+
+	/* We need to wait 120ms after a sleep out command */
+	st7701->sleep_delay = 120 + desc->panel_sleep_delay;
+	st7701->panel.funcs = &st7701_funcs;
+	st7701->panel.dev = &dsi->dev;
+
+	ret = drm_panel_add(&st7701->panel);
+	if (ret < 0)
+		return ret;
+
+	mipi_dsi_set_drvdata(dsi, st7701);
+	st7701->dsi = dsi;
+	st7701->desc = desc;
+
+	return mipi_dsi_attach(dsi);
+}
+
+static int st7701_dsi_remove(struct mipi_dsi_device *dsi)
+{
+	struct st7701 *st7701 = mipi_dsi_get_drvdata(dsi);
+
+	mipi_dsi_detach(dsi);
+	drm_panel_remove(&st7701->panel);
+
+	if (st7701->backlight)
+		put_device(&st7701->backlight->dev);
+
+	return 0;
+}
+
+static const struct of_device_id st7701_of_match[] = {
+	{ .compatible = "techstar,ts8550b", .data = &ts8550b_desc },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, st7701_of_match);
+
+static struct mipi_dsi_driver st7701_dsi_driver = {
+	.probe		= st7701_dsi_probe,
+	.remove		= st7701_dsi_remove,
+	.driver = {
+		.name		= "st7701",
+		.of_match_table	= st7701_of_match,
+	},
+};
+module_mipi_dsi_driver(st7701_dsi_driver);
+
+MODULE_AUTHOR("Jagan Teki <jagan@amarulasolutions.com>");
+MODULE_DESCRIPTION("Sitronix ST7701 LCD Panel Driver");
+MODULE_LICENSE("GPL");
-- 
2.18.0.321.gffc6fa0e3

