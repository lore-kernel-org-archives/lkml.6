Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA852C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921EC21566
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRifXqQC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921EC21566
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731905AbeHBVih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 17:38:37 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34455 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729772AbeHBVig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 17:38:36 -0400
Received: by mail-ed1-f66.google.com with SMTP id h1-v6so1349875eds.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 12:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x+ldX8WC7G5P7vlIlapCAkFKnlhXy03RAaF+I6SAEiE=;
        b=WRifXqQCVhfw88AjsNsC/pThZ9Gz6MM0zYDsqLMMGwCvpghQfw2fZ75lZA5uCpKeGG
         x/NFkmKDei5Tjeb8t/oFFBRziBgVos2bY+0wbr7hVq3LIgQ8/zwhVUcMoPp56HoyBZIu
         mWpdSx7/uwS/pW2+W/3WaMdNAVKSlsXxoCqMETVkx8GsX05cuyA3jBEBJpTTGi4b12eJ
         HEInaiqA/oZoijRwJP/e+0S8wfOUFg5ocz4i8g82mz5/hMwriVjMA4iSKAjxGMbG7s7X
         lfcGk38CN/tEHMV2Il9Hliq2L1+eIn7gfLGCxM+2UT5vugJvfh/AgOHnqXT+gJJgxv/R
         iTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=x+ldX8WC7G5P7vlIlapCAkFKnlhXy03RAaF+I6SAEiE=;
        b=tCRNA5PNL4tg/tlY/Rr+tpc/W3RAm6nDVs3CDr4MhHwFf+A+K66KcAU2k5Po6ej3pg
         Fw+L21KZImfi8h/IPCNEgalZ0fb1XgwdFP+Bd2kTU5Pgx6w5lBw4T4W+NVL/SbhFASqF
         Ig6d24FDNmri4r2XTnMk+QiCv8nn+55cg6yMLJsC8RX80Qv1r91NRF9XvxPpEgbh4naw
         9eRtFdU+wpwcLXUXjjxzvw1zUE9LpcD4YmRws+yrJaXUfHBPp9Zv720ZK1pI0ovZuIl3
         Q5IGyUVXRDChJiJbwgQdZqZ4EsedNwUtpp7NU0fVIHWoLU7jFTtQQLozYyeAF52A/Som
         JY3w==
X-Gm-Message-State: AOUpUlGAuIuFEalUb7Y8shnubsLno+fmBZjQff4w7LVFPar2FAEChWqZ
        tKRemU+HmyFAQRZhALE2omcVBg/D
X-Google-Smtp-Source: AAOMgpdy2VwZISIMzYoUuz41YAoW8rPh6LJfMKif4INQHYjHeqN5bSjrckzD5wJRaY7VwS7UnEVO7w==
X-Received: by 2002:a50:b8c5:: with SMTP id l63-v6mr4620472ede.80.1533239159828;
        Thu, 02 Aug 2018 12:45:59 -0700 (PDT)
Received: from jupiter.lan (126.158-248-196.customer.lyse.net. [158.248.196.126])
        by smtp.gmail.com with ESMTPSA id g6-v6sm1219655edn.28.2018.08.02.12.45.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 12:45:59 -0700 (PDT)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Noralf T <noralf@tronnes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 5/5] tinydrm: add winstar wg160160 driver
Date:   Thu,  2 Aug 2018 21:45:36 +0200
Message-Id: <20180802194536.10820-5-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180802193909.GA11443@ravnborg.org>
References: <20180802193909.GA11443@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for the winstar wg160160 display.
The driver utilises pardata-dbi that
again utilise the pardata subsystem.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 MAINTAINERS                        |   5 +
 drivers/gpu/drm/tinydrm/Kconfig    |  10 ++
 drivers/gpu/drm/tinydrm/Makefile   |   1 +
 drivers/gpu/drm/tinydrm/wg160160.c | 298 +++++++++++++++++++++++++++++++++++++
 4 files changed, 314 insertions(+)
 create mode 100644 drivers/gpu/drm/tinydrm/wg160160.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ba7ff7c3e46..d77e53041395 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15501,6 +15501,11 @@ L:	linux-watchdog@vger.kernel.org
 S:	Maintained
 F:	drivers/watchdog/ebc-c384_wdt.c
 
+WINSTAR WG160160 DRIVER
+M:	Sam Ravnborg <sam@ravnborg.org>
+S:	Maintained
+F:	drivers/gpu/drm/tinydrm/wg160160.c
+
 WINSYSTEMS WS16C48 GPIO DRIVER
 M:	William Breathitt Gray <vilhelm.gray@gmail.com>
 L:	linux-gpio@vger.kernel.org
diff --git a/drivers/gpu/drm/tinydrm/Kconfig b/drivers/gpu/drm/tinydrm/Kconfig
index 435de2f8d8f5..40315680c0bc 100644
--- a/drivers/gpu/drm/tinydrm/Kconfig
+++ b/drivers/gpu/drm/tinydrm/Kconfig
@@ -65,3 +65,13 @@ config TINYDRM_ST7735R
 	  * JD-T18003-T01 1.8" 128x160 TFT
 
 	  If M is selected the module will be called st7735r.
+
+config TINYDRM_WG160160
+	tristate "DRM support for Winstar WG160160"
+	depends on DRM_TINYDRM && PARDATA
+	select TINYDRM_PARDATA_DBI
+	help
+	  DRM driver for Winstar WG160106.
+	  See https://www.winstar.com.tw/products/graphic-lcd-display-module/lcd-graphics.html
+
+	  If M is selected the module will be named wg160160.
diff --git a/drivers/gpu/drm/tinydrm/Makefile b/drivers/gpu/drm/tinydrm/Makefile
index 0b52df08b0a4..849891fe40cb 100644
--- a/drivers/gpu/drm/tinydrm/Makefile
+++ b/drivers/gpu/drm/tinydrm/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_TINYDRM_MI0283QT)		+= mi0283qt.o
 obj-$(CONFIG_TINYDRM_REPAPER)		+= repaper.o
 obj-$(CONFIG_TINYDRM_ST7586)		+= st7586.o
 obj-$(CONFIG_TINYDRM_ST7735R)		+= st7735r.o
+obj-$(CONFIG_TINYDRM_WG160160)		+= wg160160.o
diff --git a/drivers/gpu/drm/tinydrm/wg160160.c b/drivers/gpu/drm/tinydrm/wg160160.c
new file mode 100644
index 000000000000..5477c8ed5599
--- /dev/null
+++ b/drivers/gpu/drm/tinydrm/wg160160.c
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DRM driver for Winstar WG160160 panels
+ *
+ * Copyright 2018 Sam Ravnborg <sam@ravnborg.org>
+ *
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/backlight.h>
+#include <linux/property.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/tinydrm/tinydrm-helpers.h>
+#include <drm/tinydrm/pardata-dbi.h>
+#include <drm/drm_fb_helper.h>
+
+#define WG160160_MODE_REG		0x00
+#define MODE_GRAPHIC_DISP_OFF		0x12
+#define MODE_GRAPHIC_DISP_ON		0x32
+
+#define WG160160_PITCH_REG		0x01
+#define WG160160_WIDTH_REG		0x02
+#define WG160160_DUTY_REG		0x03
+#define WG160160_CURSORPOS_REG		0x04
+#define WG160160_ADDRSL_REG		0x08 /* Start lower address */
+#define WG160160_ADDRSU_REG		0x09 /* Start upper address */
+#define WG160160_WRITE_REG		0x0c /* Write byte, inc cursor */
+#define WG160160_READ_REG		0x0d /* Read byte, inc cursor */
+
+#define WG160160_BUSY_MASK		0x80
+#define BUSY_ACTIVE			1
+#define BUSY_INACTIVE			0
+
+/**
+ * busy_status -read status of busy flag
+ *
+ * @pdd: pardata data
+ *
+ * returns: true if busy, false if not
+ */
+static bool busy_status(struct pardata_data *pdd)
+{
+	int data;
+
+	gpiod_set_value_cansleep(pdd->bus->pin_rs, 1);
+	gpiod_set_value_cansleep(pdd->bus->pin_readwrite, 1);
+	gpiod_set_value_cansleep(pdd->pin_cs, 0);
+	/* min 90 nsec from cs/rs/rw to e */
+	udelay(1);
+	gpiod_set_value_cansleep(pdd->bus->pin_enable, 1);
+	/* data setup time 220 ns*/
+	udelay(2);
+
+	data = gpiod_get_value(pdd->bus->data_pins->desc[PIN_DB7]);
+
+	gpiod_set_value_cansleep(pdd->bus->pin_enable, 0);
+	/* data hold time 20 ns */
+	udelay(1);
+	gpiod_set_value_cansleep(pdd->pin_cs, 1);
+
+	return data == 1;
+}
+
+/**
+ * wait_busy - wait until controller is no longer busy
+ *
+ * Logs an ERROR once if we fail to see a not BUSY condition
+ *
+ * @pdd: pardata_data
+ */
+static void wait_busy(struct pardata_data *pdd)
+{
+	int i;
+
+	i = 0;
+
+	while (busy_status(pdd) && i++ < 10)
+		udelay(1);
+
+	if (i >= 10)
+		DRM_DEV_ERROR_RATELIMITED(&pdd->pddev->dev,
+					  "Timeout waiting for BUSY=0\n");
+}
+
+/**
+ * write_reg - Write instruction on parallel bus to controller
+ *
+ * Check BUSY flag and write instruction
+ *
+ * @pdd: pardata data
+ * @reg: The register to write
+ * @value: The value of the register
+ *
+ * Returns:
+ * Zero on success, negative error code on failure
+ */
+int write_reg(struct pardata_data *pdd, unsigned int reg, unsigned int value)
+{
+	int ins[PIN_NUM];
+	int val[PIN_NUM];
+	int i;
+
+	for (i = 0; i < PIN_NUM; i++)
+		ins[PIN_DB0 + i] = !!BIT(reg);
+
+	for (i = 0; i < PIN_NUM; i++)
+		val[PIN_DB0 + i] = !!(value & BIT(i));
+
+	gpiod_set_value_cansleep(pdd->bus->pin_rs, 1);
+	gpiod_set_array_value_cansleep(PIN_NUM, pdd->bus->data_pins->desc, ins);
+	wait_busy(pdd);
+	pardata_strobe_write(pdd);
+
+	gpiod_set_value_cansleep(pdd->bus->pin_rs, 0);
+	gpiod_set_array_value_cansleep(PIN_NUM, pdd->bus->data_pins->desc, val);
+	wait_busy(pdd);
+	pardata_strobe_write(pdd);
+
+	return 0;
+}
+
+/**
+ * write_buf - write buffer on parallel bus to controller
+ *
+ * @pdd: pardata data
+ * @offset: offset into display RAM
+ * @data: pointer to data to write
+ * @len: number of bytes to write
+ *
+ * Returns:
+ * Zero on success, negative error code on failure
+ */
+int write_buf(struct pardata_data *pdd, u8 offset, u8 *data, size_t len)
+{
+	int ins[PIN_NUM];
+	int val[PIN_NUM];
+	int bit;
+	int i;
+
+	/* Setup address */
+	write_reg(pdd, WG160160_ADDRSL_REG, offset & 0xff);
+	write_reg(pdd, WG160160_ADDRSL_REG, (offset >> 8) & 0xff);
+
+	/* prepare to write data */
+	for (i = 0; i < PIN_NUM; i++)
+		ins[PIN_DB0 + i] = !!(WG160160_WRITE_REG & BIT(i));
+
+	gpiod_set_value_cansleep(pdd->bus->pin_rs, 1);
+	gpiod_set_array_value_cansleep(PIN_NUM, pdd->bus->data_pins->desc, ins);
+	wait_busy(pdd);
+	pardata_strobe_write(pdd);
+
+	/* Write data byte - by byte */
+	gpiod_set_value_cansleep(pdd->bus->pin_rs, 0);
+
+	for (i = offset; i < (offset + len); i++) {
+		for (bit = 0; bit < PIN_NUM; bit++)
+			val[PIN_DB0 + bit] = !!(data[i] & BIT(bit));
+
+		gpiod_set_array_value_cansleep(PIN_NUM,
+					       pdd->bus->data_pins->desc,
+					       val);
+		wait_busy(pdd);
+		pardata_strobe_write(pdd);
+	}
+
+	return 0;
+}
+
+static void wg160160_pipe_enable(struct drm_simple_display_pipe *pipe,
+				 struct drm_crtc_state *crtc_state,
+				 struct drm_plane_state *plane_state)
+{
+	struct tinydrm_device *tdev = pipe_to_tinydrm(pipe);
+	struct pardata_data *pdd = pardata_from_tinydrm(tdev);
+	int ret;
+
+	ret = pardata_poweron_reset(pdd);
+	if (ret)
+		return;
+
+	/* Init quence for WG160160 display */
+
+	/* Graphics mode, Master */
+	pardata_write_reg(pdd, WG160160_MODE_REG, MODE_GRAPHIC_DISP_ON);
+	/* Set PITCH to 8 bits/bytes */
+	pardata_write_reg(pdd, WG160160_PITCH_REG, 0x7);
+	/* Duty cycle is the vertical resolution */
+	pardata_write_reg(pdd, WG160160_DUTY_REG, 160);
+
+	/* Start address in display RAM */
+	pardata_write_reg(pdd, WG160160_ADDRSL_REG, 0x0);
+	pardata_write_reg(pdd, WG160160_ADDRSU_REG, 0x0);
+
+	pardata_enable_flush(pdd, crtc_state, plane_state);
+}
+
+static const struct drm_simple_display_pipe_funcs wg160160_pipe_funcs = {
+	.enable		= wg160160_pipe_enable,
+	.disable	= pardata_pipe_disable,
+	.update		= tinydrm_display_pipe_update,
+	.prepare_fb	= drm_gem_fb_simple_display_pipe_prepare_fb,
+};
+
+static const struct drm_display_mode wg160160_mode = {
+	TINYDRM_MODE(160, 160, 62, 62),
+};
+
+DEFINE_DRM_GEM_CMA_FOPS(wg160160_fops);
+
+static struct drm_driver wg160160_drm_driver = {
+	.driver_features	= DRIVER_GEM |
+				  DRIVER_MODESET |
+				  DRIVER_PRIME |
+				  DRIVER_ATOMIC,
+	.fops			= &wg160160_fops,
+	TINYDRM_GEM_DRIVER_OPS,
+	.lastclose		= drm_fb_helper_lastclose,
+	.name			= "wg160160",
+	.desc			= "Winstar WG160160",
+	.date			= "20180808",
+	.major			= 1,
+	.minor			= 0,
+};
+
+static const struct of_device_id wg160160_of_match[] = {
+	{ .compatible = "winstar,wg160160" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, wg160160_of_match);
+
+static struct pardata_driver wg160160_pardata_driver;
+
+static int wg160160_probe(struct pardata_device *pddev)
+{
+	struct device *dev = &pddev->dev;
+	struct pardata_data *pdd;
+	int ret;
+
+	pdd = devm_kzalloc(dev, sizeof(*pdd), GFP_KERNEL);
+	if (!pdd)
+		return -ENOMEM;
+
+	/* Find all pins */
+	pdd->pin_reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(pdd->pin_reset)) {
+		DRM_DEV_ERROR(dev, "Failed to get gpio 'reset'\n");
+		return PTR_ERR(pdd->pin_reset);
+	}
+
+	pdd->pin_cs = devm_gpiod_get(dev, "cs", GPIOD_OUT_HIGH);
+	if (IS_ERR(pdd->pin_cs)) {
+		DRM_DEV_ERROR(dev, "Failed to get gpio 'rs'\n");
+		return PTR_ERR(pdd->pin_cs);
+	}
+
+	pdd->backlight = devm_of_find_backlight(dev);
+	if (IS_ERR(pdd->backlight))
+		return PTR_ERR(pdd->backlight);
+
+	pdd->strobe_write = pardata_strobe_8080_write;
+	pdd->write_reg = write_reg;
+	pdd->write_buf = write_buf;
+
+	ret = pardata_init(dev, pdd, &wg160160_pipe_funcs,
+			   &wg160160_drm_driver, &wg160160_mode);
+	if (ret)
+		return ret;
+
+	pardata_dev_set_drvdata(pddev, pdd);
+
+	return devm_tinydrm_register(&pdd->tinydrm);
+}
+
+static void wg160160_shutdown(struct pardata_device *pddev)
+{
+	struct pardata_data *dpp = pardata_dev_get_drvdata(pddev);
+
+	tinydrm_shutdown(&dpp->tinydrm);
+}
+
+static struct pardata_driver wg160160_pardata_driver = {
+	.driver = {
+		.name = "wg160160",
+		.owner = THIS_MODULE,
+		.of_match_table = wg160160_of_match,
+	},
+	.probe = wg160160_probe,
+	.shutdown = wg160160_shutdown,
+};
+module_pardata_driver(wg160160_pardata_driver);
+
+MODULE_DESCRIPTION("Winstar WG160160 DRM driver");
+MODULE_AUTHOR("Sam Ravnborg <sam@ravnborg.org>");
+MODULE_LICENSE("GPL v2");
-- 
2.12.0

