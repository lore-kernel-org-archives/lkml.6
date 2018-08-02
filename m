Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB06C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963D021566
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5v+cTiA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 963D021566
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731699AbeHBVie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 17:38:34 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39564 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729772AbeHBVid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 17:38:33 -0400
Received: by mail-ed1-f65.google.com with SMTP id h4-v6so1340846edi.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 12:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qlp/yvroyvV5fqwp5a4gJoO/6mmWbq2pzsE8ATWcghc=;
        b=s5v+cTiAEz+AyIrpbmibeXHeX6TlJ/8vECjj+qNpy2KqcBTOIzXFJg8LMEgoY5+gjL
         Vg14WV0JyktNaN72SBT3ajknO7qOegAIaLvv/5WwF/Juu1bwMUskIla75+YneZvIYuFX
         nQuWFREwtUgZaEY7C03m1ptoENjMODLOAZ19mLf8xPmqOcMzUKlITOyT0/XQ/3auaAHW
         TNwJ1p31JFjUZ0K6UM1Ohm0FYT/d72xwrCF6q1w9OmID9J4/SSWEuOvbc4Sc0Ch7bSWU
         awPRjevtucF+Orqc3g63w+KoD7OREXrGW/I3+0hA1Du3i4MM6A363g4crbdv0lJlxfXK
         hung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=qlp/yvroyvV5fqwp5a4gJoO/6mmWbq2pzsE8ATWcghc=;
        b=awfRzyk8ql8Z1/TyXAcLkg/seSus5D2VGmEi7nzGNi/ytC8pfRyDnGsnWJpb6Zu+Tc
         7yntODxI7xL2UYLCkdl8miXSHhn3f/Gjw+N2+V0i++RUhrQY91jb0XZNMJciiqlRFR5C
         9BDvNuv5B/t6nccj6Mnu/U4trIuurFQHljaOtzjSqLS7GlJb+vXA7nzHo8o17itq2du8
         BkjncsCD47sl3U0nR87bssIJrQnUzM2eNbjZXcoIalw0ntMrtfB97k1GwBmXi4S1VrA6
         jf22TQ3r5W6xn1G5xWi0P4lj/lcOtrJ+6T1o3NGFCBGE3sZ0D6B+KbiuhwJU44c5u3h3
         udJQ==
X-Gm-Message-State: AOUpUlGQrPfr2rpcAJcvN81evIYDFxb+kkrd80oc6oMV3ZhSSMfKipnK
        z74Zn7nLNdvn4MSW5iQT/a87TtNk
X-Google-Smtp-Source: AAOMgpf+nitEWDdiNLY0lJJZo4QIdpxsEXrNNBSe+oQPuuRtPNnIha8tiqFsJbtuM051Vk98WP4R9g==
X-Received: by 2002:a50:a804:: with SMTP id j4-v6mr4781364edc.61.1533239154678;
        Thu, 02 Aug 2018 12:45:54 -0700 (PDT)
Received: from jupiter.lan (126.158-248-196.customer.lyse.net. [158.248.196.126])
        by smtp.gmail.com with ESMTPSA id g6-v6sm1219655edn.28.2018.08.02.12.45.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 12:45:54 -0700 (PDT)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Noralf T <noralf@tronnes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 3/5] tinydrm: add support for parallel data displays
Date:   Thu,  2 Aug 2018 21:45:34 +0200
Message-Id: <20180802194536.10820-3-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180802193909.GA11443@ravnborg.org>
References: <20180802193909.GA11443@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Utilising the pardata bus/driver add support for
displays connected to a parallel data bus.
There is no specific protocol implemented,
but the display is tied to the tinydrm pipe.

Only monochrome displays supported using the
XRGB8888 format.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/gpu/drm/tinydrm/Kconfig       |   3 +
 drivers/gpu/drm/tinydrm/Makefile      |   1 +
 drivers/gpu/drm/tinydrm/pardata-dbi.c | 417 ++++++++++++++++++++++++++++++++++
 include/drm/tinydrm/pardata-dbi.h     | 257 +++++++++++++++++++++
 4 files changed, 678 insertions(+)
 create mode 100644 drivers/gpu/drm/tinydrm/pardata-dbi.c
 create mode 100644 include/drm/tinydrm/pardata-dbi.h

diff --git a/drivers/gpu/drm/tinydrm/Kconfig b/drivers/gpu/drm/tinydrm/Kconfig
index 4592a5e3f20b..435de2f8d8f5 100644
--- a/drivers/gpu/drm/tinydrm/Kconfig
+++ b/drivers/gpu/drm/tinydrm/Kconfig
@@ -10,6 +10,9 @@ menuconfig DRM_TINYDRM
 config TINYDRM_MIPI_DBI
 	tristate
 
+config TINYDRM_PARDATA_DBI
+	tristate
+
 config TINYDRM_ILI9225
 	tristate "DRM support for ILI9225 display panels"
 	depends on DRM_TINYDRM && SPI
diff --git a/drivers/gpu/drm/tinydrm/Makefile b/drivers/gpu/drm/tinydrm/Makefile
index 49a111929724..0b52df08b0a4 100644
--- a/drivers/gpu/drm/tinydrm/Makefile
+++ b/drivers/gpu/drm/tinydrm/Makefile
@@ -2,6 +2,7 @@ obj-$(CONFIG_DRM_TINYDRM)		+= core/
 
 # Controllers
 obj-$(CONFIG_TINYDRM_MIPI_DBI)		+= mipi-dbi.o
+obj-$(CONFIG_TINYDRM_PARDATA_DBI)	+= pardata-dbi.o
 
 # Displays
 obj-$(CONFIG_TINYDRM_ILI9225)		+= ili9225.o
diff --git a/drivers/gpu/drm/tinydrm/pardata-dbi.c b/drivers/gpu/drm/tinydrm/pardata-dbi.c
new file mode 100644
index 000000000000..09bdfdba6291
--- /dev/null
+++ b/drivers/gpu/drm/tinydrm/pardata-dbi.c
@@ -0,0 +1,417 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Parallel Data Display Bus Interface LCD controller support
+ */
+
+#include <linux/regulator/consumer.h>
+#include <linux/gpio/consumer.h>
+#include <linux/dma-buf.h>
+#include <linux/pardata.h>
+#include <linux/module.h>
+
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/tinydrm/tinydrm-helpers.h>
+#include <drm/tinydrm/pardata-dbi.h>
+
+/**
+ * pardata_strobe_8080_write - using the 8080 interface create
+ *			     an enable strobe
+ *
+ * The interface requires that readwrite and chipselect are
+ * setup before the strobe of "e".
+ * There are timings constraints that is handled using udelay().
+ * Drivers can use this for the strobe_write callback.
+ *
+ * @pdd: pardata data
+ */
+void pardata_strobe_8080_write(struct pardata_data *pdd)
+{
+	gpiod_set_value_cansleep(pdd->bus->pin_readwrite, 0);
+
+	if (pdd->pin_cs)
+		gpiod_set_value_cansleep(pdd->pin_cs, 0);
+	/* min 90 nsec from cs/rs/rw to e */
+	udelay(1);
+	gpiod_set_value_cansleep(pdd->bus->pin_enable, 1);
+	/* data setup time 220 ns*/
+	udelay(2);
+	gpiod_set_value_cansleep(pdd->bus->pin_enable, 0);
+	/* data hold time 20 ns */
+	udelay(1);
+	if (pdd->pin_cs)
+		gpiod_set_value_cansleep(pdd->pin_cs, 1);
+}
+EXPORT_SYMBOL_GPL(pardata_strobe_8080_write);
+
+/**
+ * pardata_strobe_6800_write - using the 6800 interface create
+ *			     an enable strobe
+ *
+ * The interface requires that read + write and chipselect are
+ * setup before the strobe of "e".
+ * There are timings constraints that is handled using udelay()
+ * Drivers can use this for the strobe_write callback.
+ *
+ * @pdd: pardata data
+ */
+
+void pardata_strobe_6800_write(struct pardata_data *pdd)
+{
+	gpiod_set_value_cansleep(pdd->bus->pin_read, 0);
+	gpiod_set_value_cansleep(pdd->bus->pin_write, 1);
+
+	if (pdd->pin_cs)
+		gpiod_set_value_cansleep(pdd->pin_cs, 0);
+	/* min 90 nsec from cs/rs/rw to e */
+	udelay(1);
+	gpiod_set_value_cansleep(pdd->bus->pin_enable, 1);
+	/* data setup time 220 ns*/
+	udelay(2);
+	gpiod_set_value_cansleep(pdd->bus->pin_enable, 0);
+	/* data hold time 20 ns */
+	udelay(1);
+	if (pdd->pin_cs)
+		gpiod_set_value_cansleep(pdd->pin_cs, 1);
+}
+EXPORT_SYMBOL_GPL(pardata_strobe_6800_write);
+
+
+static int pardata_write_clip(struct pardata_data *pdd,
+			      struct drm_framebuffer *fb,
+			      u8 *data,
+			      struct drm_clip_rect *clip)
+{
+	bool line_by_line;
+	size_t linelen;
+	size_t len;
+	int x, y;
+	u8 *buf;
+
+	linelen = clip->x2 - clip->x1;
+	len = linelen * (clip->y2 - clip->y1) / 8;
+	buf = kzalloc(len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	/*
+	 * If the clip is the full width then we need only one
+	 * write operation.
+	 */
+	line_by_line = (clip->x2 - clip->x1) != fb->width;
+
+	for (y = clip->y1; y < clip->y2; y++) {
+		for (x = clip->x1; x < clip->x2; x++) {
+			unsigned int index;
+			u8 cc;
+
+			index = x + y * linelen;
+			cc = data[index];
+
+			/* Most significant bit determine bit on/off */
+			if (cc & 0x80)
+				buf[index / 8] |= BIT(index % 8);
+		}
+		if (line_by_line) {
+			int offset;
+
+			offset = y * fb->width + clip->x1;
+			pardata_write_buf(pdd, offset, &buf[offset], linelen);
+		}
+	}
+	if (!line_by_line) {
+		int offset;
+
+		offset = clip->y1 * fb->width;
+		pardata_write_buf(pdd, offset, &buf[offset], len);
+	}
+
+	kfree(buf);
+
+	return 0;
+}
+
+/**
+ * pardata_buf_copy - Copy a framebuffer, transforming it if necessary
+ *
+ * @dst: The destination buffer
+ * @fb: The source framebuffer
+ * @clip: Clipping rectangle of the area to be copied
+ *
+ * Returns:
+ * Zero on success, negative error code on failure.
+ */
+static int pardata_buf_copy(void *dst, struct drm_framebuffer *fb,
+			    struct drm_clip_rect *clip)
+{
+	struct dma_buf_attachment *import_attach;
+	struct drm_gem_cma_object *cma_obj;
+	void *src;
+	int ret;
+
+	cma_obj = drm_fb_cma_get_gem_obj(fb, 0);
+	import_attach = cma_obj->base.import_attach;
+	src = cma_obj->vaddr;
+	ret = 0;
+
+	if (import_attach) {
+		ret = dma_buf_begin_cpu_access(import_attach->dmabuf,
+					       DMA_FROM_DEVICE);
+		if (ret)
+			return ret;
+	}
+
+	tinydrm_xrgb8888_to_gray8(dst, src, fb, clip);
+
+	if (import_attach)
+		ret = dma_buf_end_cpu_access(import_attach->dmabuf,
+					     DMA_FROM_DEVICE);
+	return ret;
+}
+
+static int pardata_fb_dirty(struct drm_framebuffer *fb,
+			    struct drm_file *file_priv,
+			    unsigned int flags,
+			    unsigned int color,
+			    struct drm_clip_rect *clips,
+			    unsigned int num_clips)
+{
+	struct drm_format_name_buf format_name;
+	struct drm_gem_cma_object *cma_obj;
+	struct tinydrm_device *tdev;
+	struct drm_clip_rect clip;
+	struct pardata_data *pdd;
+	bool full;
+	int ret;
+
+	cma_obj = drm_fb_cma_get_gem_obj(fb, 0);
+	tdev = fb->dev->dev_private;
+	pdd = pardata_from_tinydrm(tdev);
+	ret = 0;
+
+	if (!pdd->enabled)
+		return 0;
+
+	if (fb->format->format != DRM_FORMAT_XRGB8888) {
+		dev_err_once(fb->dev->dev, "Format is not supported: %s\n",
+			     drm_get_format_name(fb->format->format,
+						 &format_name));
+		return -EINVAL;
+	}
+
+	full = tinydrm_merge_clips(&clip, clips, num_clips, flags,
+				   fb->width, fb->height);
+
+	DRM_DEV_DEBUG(&pdd->pddev->dev,
+		      "Flushing [FB:%d] x1=%u, x2=%u, y1=%u, y2=%u\n",
+		      fb->base.id, clip.x1, clip.x2, clip.y1, clip.y2);
+
+	if (!full) {
+		ret = pardata_buf_copy(pdd->tx_buf, fb, &clip);
+		if (!ret)
+			ret = pardata_write_clip(pdd, fb, pdd->tx_buf, &clip);
+	} else {
+		size_t len;
+
+		len = fb->width * fb->height;
+		ret = pardata_write_buf(pdd, 0, cma_obj->vaddr, len);
+	}
+
+	return ret;
+}
+
+static const struct drm_framebuffer_funcs mipi_dbi_fb_funcs = {
+	.destroy	= drm_gem_fb_destroy,
+	.create_handle	= drm_gem_fb_create_handle,
+	.dirty		= tinydrm_fb_dirty,
+};
+
+/**
+ * pardata_enable_flush -  enable helper
+ *
+ * @pdd: pardata data
+ * @crtc_state: crtc state
+ * @plane_state: plane state
+ *
+ * This function sets &pdd->enabled, flushes the whole framebuffer and
+ * enables the backlight. Drivers can use this in their
+ * &drm_simple_display_pipe_funcs->enable callback.
+ */
+void pardata_enable_flush(struct pardata_data *pdd,
+			  struct drm_crtc_state *crtc_state,
+			  struct drm_plane_state *plane_state)
+{
+	struct tinydrm_device *tdev;
+	struct drm_framebuffer *fb;
+
+	tdev = &pdd->tinydrm;
+	fb = plane_state->fb;
+	pdd->enabled = true;
+
+	if (fb)
+		tdev->fb_dirty(fb, NULL, 0, 0, NULL, 0);
+
+	backlight_enable(pdd->backlight);
+}
+EXPORT_SYMBOL_GPL(pardata_enable_flush);
+
+static void pardata_blank(struct pardata_data *pdd)
+{
+	struct drm_device *drm;
+	u16 height, width;
+	size_t len;
+
+	drm = pdd->tinydrm.drm;
+	height = drm->mode_config.min_height;
+	width = drm->mode_config.min_width;
+
+	len = width * height;
+
+	memset(pdd->tx_buf, 0, len);
+	pardata_write_buf(pdd, 0, pdd->tx_buf, len);
+}
+
+/**
+ * pardata_pipe_disable - pipe disable helper
+ *
+ * @pipe: Display pipe
+ *
+ * This function disables backlight if present, if not the display memory is
+ * blanked. The regulator is disabled if in use. Drivers can use this as their
+ * &drm_simple_display_pipe_funcs->disable callback.
+ */
+void pardata_pipe_disable(struct drm_simple_display_pipe *pipe)
+{
+	struct tinydrm_device *tdev;
+	struct pardata_data *pdd;
+
+	tdev = pipe_to_tinydrm(pipe);
+	pdd = pardata_from_tinydrm(tdev);
+
+	pdd->enabled = false;
+
+	if (pdd->backlight)
+		backlight_disable(pdd->backlight);
+	else
+		pardata_blank(pdd);
+
+	if (pdd->regulator)
+		regulator_disable(pdd->regulator);
+}
+EXPORT_SYMBOL_GPL(pardata_pipe_disable);
+
+static const uint32_t pardata_formats[] = {
+	DRM_FORMAT_XRGB8888,
+};
+
+/**
+ * pardata_init - initialization
+ * @dev: Parent device
+ * @pdd: pardata data to initialize
+ * @pipe_funcs: Display pipe functions
+ * @driver: DRM driver
+ * @mode: Display mode
+ *
+ * This function initializes a &pardata data structure and it's underlying
+ * @tinydrm_device. It also sets up the display pipeline.
+ *
+ * Supported formats: Emulated XRGB8888.
+ *
+ * Objects created by this function will be automatically freed on driver
+ * detach (devres).
+ *
+ * Returns:
+ * Zero on success, negative error code on failure.
+ */
+int pardata_init(struct device *dev,
+		 struct pardata_data *pdd,
+		 const struct drm_simple_display_pipe_funcs *pipe_funcs,
+		 struct drm_driver *driver,
+		 const struct drm_display_mode *mode)
+{
+	struct tinydrm_device *tdev;
+	size_t bufsize;
+	int ret;
+
+	/* shortcut to pardatabus_data */
+	pdd->bus = dev_get_drvdata(dev->parent);
+
+	tdev = &pdd->tinydrm;
+	bufsize = mode->vdisplay * mode->hdisplay * sizeof(u16);
+
+	pdd->tx_buf = devm_kmalloc(dev, bufsize, GFP_KERNEL);
+	if (!pdd->tx_buf)
+		return -ENOMEM;
+
+	ret = devm_tinydrm_init(dev, tdev, &mipi_dbi_fb_funcs, driver);
+	if (ret)
+		return ret;
+
+	tdev->fb_dirty = pardata_fb_dirty;
+
+	ret = tinydrm_display_pipe_init(tdev, pipe_funcs,
+					DRM_MODE_CONNECTOR_VIRTUAL,
+					pardata_formats,
+					ARRAY_SIZE(pardata_formats),
+					mode,
+					0);
+	if (ret)
+		return ret;
+
+	tdev->drm->mode_config.preferred_depth = 16;
+
+	drm_mode_config_reset(tdev->drm);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pardata_init);
+
+/**
+ * pardata_hw_reset - Hardware reset of controller
+ *
+ * @pdd: pardata data
+ *
+ * Reset controller if the &pardata->pin_reset gpio is set.
+ */
+void pardata_hw_reset(struct pardata_data *pdd)
+{
+	if (!pdd->pin_reset)
+		return;
+
+	gpiod_set_value_cansleep(pdd->pin_reset, 0);
+	usleep_range(20, 1000);
+	gpiod_set_value_cansleep(pdd->pin_reset, 1);
+	msleep(120);
+}
+EXPORT_SYMBOL_GPL(pardata_hw_reset);
+
+/**
+ * pardata_poweron_reset - poweron and reset
+ * @pdd: pardata data
+ *
+ * This function enables the regulator if used and does a hardware reset.
+ *
+ * Returns:
+ * Zero on success, or a negative error code.
+ */
+int pardata_poweron_reset(struct pardata_data *pdd)
+{
+	int ret;
+
+
+	if (pdd->regulator) {
+		ret = regulator_enable(pdd->regulator);
+		if (ret) {
+			DRM_DEV_ERROR(&pdd->pddev->dev,
+				      "Failed to enable regulator (%d)\n",
+				      ret);
+			return ret;
+		}
+	}
+
+	pardata_hw_reset(pdd);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pardata_poweron_reset);
+
+MODULE_LICENSE("GPL v2");
diff --git a/include/drm/tinydrm/pardata-dbi.h b/include/drm/tinydrm/pardata-dbi.h
new file mode 100644
index 000000000000..d72d9a1dff27
--- /dev/null
+++ b/include/drm/tinydrm/pardata-dbi.h
@@ -0,0 +1,257 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Parallel Data Display Bus Interface LCD controller support
+ */
+
+#include <linux/pardata.h>
+
+#include <drm/tinydrm/tinydrm.h>
+
+/**
+ * pardata_pins - the data pins
+ *
+ * The order is important due to use of writing to gpio arrays.
+ * The first four pins (PIN_DB0 to PIN_DB3) are not used for
+ * interfaces using only four data bits.
+ */
+enum pardata_pins {
+	PIN_DB0,
+	PIN_DB1,
+	PIN_DB2,
+	PIN_DB3,
+	PIN_DB4,
+	PIN_DB5,
+	PIN_DB6,
+	PIN_DB7,
+	PIN_NUM,	/* Number of pins */
+};
+
+struct pardata_data {
+	/**
+	 * @tinydrm - tinydrm base
+	 */
+	struct tinydrm_device tinydrm;
+
+	/**
+	 * dev - pardata device
+	 */
+	struct pardata_device *pddev;
+
+	/**
+	 * @busdata - data for the bus
+	 */
+	struct pardatabus_data *bus;
+
+	/**
+	 * @pin_reset: Optional GPIO reset pin
+	 */
+	struct gpio_desc *pin_reset;
+
+	/**
+	 * @pin_cs: Optional chip select pin
+	 */
+	struct gpio_desc *pin_cs;
+
+	/**
+	 * @tx_buf: Poitner to buffer to transer to display RAM
+	 */
+	u8 *tx_buf;
+
+	/**
+	 * @backlight - backlight device (optional)
+	 */
+	struct backlight_device *backlight;
+
+	/**
+	 * @regulator - power regulator (optional)
+	 */
+	struct regulator *regulator;
+
+	/**
+	 * @strobe_write - activate chip select to move data to controller
+	 *
+	 * This callback is used to set read/write and activate
+	 * pin_e and pin_cs - with respect to the timing required by
+	 * the controller.
+	 *
+	 * Use pardata_strobe_8080_write() for 8080 style interface or
+	 * pardata_strobe_6800_write() for 6800 style interface.
+	 * has individual pins for read and write.
+	 *
+	 * Parameters:
+	 *
+	 * pdd: pardata data
+	 */
+	void (*strobe_write)(struct pardata_data *pdd);
+
+	/**
+	 * write_reg - write value to register
+	 *
+	 * This callback is used to write the value to the register.
+	 *
+	 * Parameters:
+	 *
+	 * pdd: pardata data
+	 * reg: The register to write
+	 * value: The value to write to the register
+	 *
+	 * Returns:
+	 * 0 on success, negative value on error
+	 */
+	int (*write_reg)(struct pardata_data *pdd,
+			unsigned int reg, unsigned int value);
+
+	/**
+	 * write_buf - write content of buffer to controller
+	 *
+	 * This callback writes the data to the controller at offset
+	 * and forward. The write operation shall be as efficient as
+	 * possible as this will be called every time the content on
+	 * the display changes
+	 *
+	 * Parameters:
+	 *
+	 * pdd: pardata data
+	 * offset: The offset into the display memory of the controller where
+	 *	 the data shall be written.
+	 * data: Pointer to the data to write to display memory
+	 * len: Number of bytes to write to the display memory
+	 *
+	 * Returns:
+	 * 0 on success, negative value on error
+	 */
+	int (*write_buf)(struct pardata_data *pdd,
+			 u8 offset,
+			 u8 *data,
+			 size_t len);
+
+	/**
+	 * @enabled: Pipeline is enabled (internal)
+	 */
+	bool enabled;
+};
+
+static inline struct pardata_data *
+pardata_from_tinydrm(struct tinydrm_device *tdev)
+{
+	return container_of(tdev, struct pardata_data, tinydrm);
+}
+
+static inline void pardata_strobe_write(struct pardata_data *pdd)
+{
+	if (pdd && pdd->strobe_write)
+		pdd->strobe_write(pdd);
+	else
+		DRM_DEV_ERROR(&pdd->pddev->dev, "No strobe_write callback");
+}
+
+static inline int pardata_write_reg(struct pardata_data *pdd,
+				    unsigned int reg, unsigned int value)
+{
+	if (pdd && pdd->write_reg)
+		pdd->write_reg(pdd, reg, value);
+	else
+		DRM_DEV_ERROR(&pdd->pddev->dev, "No write_reg callback");
+
+	return 0;
+}
+
+static inline int pardata_write_buf(struct pardata_data *pdd,
+				    u8 offset, u8 *data, size_t len)
+{
+	if (pdd && pdd->write_buf)
+		pdd->write_buf(pdd, offset, data, len);
+	else
+		DRM_DEV_ERROR(&pdd->pddev->dev, "No write_buf callback");
+
+	return 0;
+}
+
+/**
+ * pardata_strobe_8080_write - using the 8080 interface create
+ *                             an enable strobe
+ *
+ * The interface requires that readwrite and chipselect are
+ * setup before the strobe of "e".
+ * There are timings constraints that is handled using udelay().
+ * Drivers can use this for the strobe_write callback.
+ *
+ * @pdd: pardata data
+ */
+void pardata_strobe_8080_write(struct pardata_data *pdd);
+
+/**
+ * pardata_strobe_6800_write - using the 6800 interface create
+ *                             an enable strobe
+ *
+ * The interface requires that read + write and chipselect are
+ * setup before the strobe of "e".
+ * There are timings constraints that is handled using udelay()
+ * Drivers can use this for the strobe_write callback.
+ *
+ * @pdd: pardata data
+ */
+void pardata_strobe_6800_write(struct pardata_data *pdd);
+
+/**
+ * pardata_poweron_reset - poweron and reset display
+ *
+ * @pdd: pardata data
+ *
+ * This function enables the regulator if used and does a hardware reset.
+ * Returns:
+ * Zero on success, or a negative error code.
+ */
+int pardata_poweron_reset(struct pardata_data *pdd);
+
+/**
+ * pardata_enable_flush - enable helper
+ *
+ * @pdd: parDATA DATA
+ * @crtc_state: crtc state
+ * @plane_state: plane state
+ *
+ * This function sets &pardata->enabled, flushes the whole framebuffer and
+ * enables the backlight. Drivers can use this in their
+ * &drm_simple_display_pipe_funcs->enable callback.
+ */
+void pardata_enable_flush(struct pardata_data *pdd,
+			  struct drm_crtc_state *crtc_state,
+			  struct drm_plane_state *plane_state);
+
+/**
+ * pardata_pipe_disable - pipe disable helper
+ *
+ * @pipe: Display pipe
+ *
+ * This function disables backlight if present, if not the display memory is
+ * blanked. The regulator is disabled if in use. Drivers can use this as their
+ * &drm_simple_display_pipe_funcs->disable callback.
+ */
+void pardata_pipe_disable(struct drm_simple_display_pipe *pipe);
+
+/**
+ * pardata_init - initialization
+ *
+ * @dev: Parent device
+ * @pdd: pardata data to initialize
+ * @pipe_funcs: Display pipe functions
+ * @driver: DRM driver
+ * @mode: Display mode
+ *
+ * This function initializes a &pardata data structure and it's underlying
+ * @tinydrm_device. It also sets up the display pipeline.
+ *
+ * Supported formats: Emulated XRGB8888.
+ *
+ * Objects created by this function will be automatically freed on driver
+ * detach (devres).
+ *
+ * Returns:
+ * Zero on success, negative error code on failure.
+ */
+int pardata_init(struct device *dev,
+		 struct pardata_data *pdd,
+		 const struct drm_simple_display_pipe_funcs *pipe_funcs,
+		 struct drm_driver *driver,
+		 const struct drm_display_mode *mode);
-- 
2.12.0

