Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B654AC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39FB02133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 20:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39FB02133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbeISCSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 22:18:44 -0400
Received: from shell.v3.sk ([90.176.6.54]:55088 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730296AbeISCSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 22:18:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 8FBF6B947D;
        Tue, 18 Sep 2018 22:44:21 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id bExyOEqFfp0u; Tue, 18 Sep 2018 22:44:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id B49E0B9483;
        Tue, 18 Sep 2018 22:44:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZgHPbqsSXL-e; Tue, 18 Sep 2018 22:44:11 +0200 (CEST)
Received: from odvarok.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id C21D6B9481;
        Tue, 18 Sep 2018 22:44:10 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 2/2] misc: hx8837: add a HiMax HX8837 display controller driver
Date:   Tue, 18 Sep 2018 22:43:59 +0200
Message-Id: <20180918204359.24894-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180918204359.24894-1-lkundrak@v3.sk>
References: <20180918204359.24894-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HiMax HX8837 is a display controller used on OLPC platforms.
It controlls backlight and is able to capture and freeze a frame when
the LCD controller (and the rest of the plaform) is powered off.

This driver is based on the same code as drivers/staging/olpc_dcon.
I modernized it to use managed GPIO, device-tree bindings, sysfs
attribtue groups, essentially fixing the staging driver's TODO.

Why I am not removing the staging driver now is because I've hobbled off
some functionality too (with an intent to bring add it back eventually):

* I've removed parts that talk directly to the OLPC EC to turn off/on
  the power. My platform (OLPC 1.75) doesn't have an EC driver yet
  (in progress!), and perhaps there's a more sensible API that should be
  used (regulator? clock?).

* I couldn't test it with XO 1 and XO 1.5, because I don't have the
  hardware. I think I'll be able to get a XO 1 laptop soonish, which
  will make testing easier.  I guess both platforms are DT-based and
  could use the same bindings.

What is there is the backlight control and the sysfs attributes to
control the freeze/unfreeze..

I've also renamed the driver to use the actual chip name instead of the
original name that I found too generic. This way the staging driver can
be used on XO 1 and XO 1.5, while my XO 1.75 can utilize this one.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/misc/Kconfig  |  16 +
 drivers/misc/Makefile |   1 +
 drivers/misc/hx8837.c | 749 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 766 insertions(+)
 create mode 100644 drivers/misc/hx8837.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 3726eacdf65d..3eb6df0ea0a4 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -513,6 +513,22 @@ config MISC_RTSX
 	tristate
 	default MISC_RTSX_PCI || MISC_RTSX_USB
 
+config HX8837_DCON
+        tristate "HiMax HX8837 Display Controller on OLPC"
+        depends on I2C
+        depends on BACKLIGHT_LCD_SUPPORT
+        select BACKLIGHT_CLASS_DEVICE
+        help
+          In order to support very low power operation, the OLPC XO laptop uses a
+          secondary Display Controller, or DCON.  This secondary controller
+          is present in the video pipeline between the primary display
+          controller (integrate into the processor or chipset) and the LCD
+          panel.  It allows the main processor/display controller to be
+          completely powered off while still retaining an image on the display.
+          This controller is only available on OLPC platforms.
+
+          Unless you have an OLPC XO laptop, you will want to say N.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index af22bbc3d00c..33689ae496b4 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -58,3 +58,4 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
 obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
 obj-$(CONFIG_OCXL)		+= ocxl/
 obj-$(CONFIG_MISC_RTSX)		+= cardreader/
+obj-$(CONFIG_HX8837_DCON)	+= hx8837.o
diff --git a/drivers/misc/hx8837.c b/drivers/misc/hx8837.c
new file mode 100644
index 000000000000..3e8924d8c6ec
--- /dev/null
+++ b/drivers/misc/hx8837.c
@@ -0,0 +1,749 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Mainly by David Woodhouse, somewhat modified by Jordan Crouse.
+ * Modernized to use managed GPIO, device-tree, etc. by Lubomir Rintel.
+ *
+ * Copyright (C) 2006-2007  Red Hat, Inc.
+ * Copyright (C) 2006-2007  Advanced Micro Devices, Inc.
+ * Copyright (C) 2009       VIA Technology, Inc.
+ * Copyright (C) 2010-2011  Andres Salomon <dilinger@queued.net>
+ * Copyright (C) 2018       Lubomir Rintel <lkundrak@v3.sk>
+ */
+
+#include <linux/module.h>
+#include <linux/backlight.h>
+#include <linux/console.h>
+#include <linux/ctype.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/fb.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+
+/* DCON registers */
+
+#define DCON_REG_ID		 0
+#define DCON_REG_MODE		 1
+
+#define MODE_PASSTHRU		BIT(0)
+#define MODE_SLEEP		BIT(1)
+#define MODE_SLEEP_AUTO		BIT(2)
+#define MODE_BL_ENABLE		BIT(3)
+#define MODE_BLANK		BIT(4)
+#define MODE_CSWIZZLE		BIT(5)
+#define MODE_COL_AA		BIT(6)
+#define MODE_MONO_LUMA		BIT(7)
+#define MODE_SCAN_INT		BIT(8)
+#define MODE_CLOCKDIV		BIT(9)
+#define MODE_DEBUG		BIT(14)
+#define MODE_SELFTEST		BIT(15)
+
+#define DCON_REG_HRES		0x2
+#define DCON_REG_HTOTAL		0x3
+#define DCON_REG_HSYNC_WIDTH	0x4
+#define DCON_REG_VRES		0x5
+#define DCON_REG_VTOTAL		0x6
+#define DCON_REG_VSYNC_WIDTH	0x7
+#define DCON_REG_TIMEOUT	0x8
+#define DCON_REG_SCAN_INT	0x9
+#define DCON_REG_BRIGHT		0xa
+#define DCON_REG_MEM_OPT_A	0x41
+#define DCON_REG_MEM_OPT_B	0x42
+
+/* Load Delay Locked Loop (DLL) settings for clock delay */
+#define MEM_DLL_CLOCK_DELAY	BIT(0)
+/* Memory controller power down function */
+#define MEM_POWER_DOWN		BIT(8)
+/* Memory controller software reset */
+#define MEM_SOFT_RESET		BIT(0)
+
+/* Status values */
+
+#define DCONSTAT_SCANINT	0
+#define DCONSTAT_SCANINT_DCON	1
+#define DCONSTAT_DISPLAYLOAD	2
+#define DCONSTAT_MISSED		3
+
+/* Source values */
+
+#define DCON_SOURCE_DCON        0
+#define DCON_SOURCE_CPU         1
+
+struct hx8837_priv {
+	struct i2c_client *client;
+	struct fb_info *fbinfo;
+	struct backlight_device *bl_dev;
+
+	wait_queue_head_t waitq;
+	struct work_struct switch_source;
+	struct notifier_block reboot_nb;
+	struct notifier_block panic_nb;
+
+	/* Scanline to interrupt on during resume */
+	ushort resumeline;
+
+	/* Shadow register for the DCON_REG_MODE register */
+	u8 disp_mode;
+
+	/* The current backlight value - this saves us some smbus traffic */
+	u8 bl_val;
+
+	/* Current source, initialized at probe time */
+	int curr_src;
+
+	/* Desired source */
+	int pending_src;
+
+	/* Variables used during switches */
+	bool switched;
+	ktime_t irq_time;
+	ktime_t load_time;
+
+	/* Current output type; true == mono, false == color */
+	bool mono;
+	/* This get set while controlling fb blank state from the driver */
+	bool ignore_fb_events;
+
+	struct gpio_desc *stat0_gpio;
+	struct gpio_desc *stat1_gpio;
+	struct gpio_desc *load_gpio;
+	struct gpio_desc *irq_gpio;
+};
+
+static irqreturn_t hx8837_interrupt(int irq, void *id);
+
+/* I2C structures */
+
+static unsigned short normal_i2c[] = { 0x0d, I2C_CLIENT_END };
+
+static s32 hx8837_write(struct hx8837_priv *priv, u8 reg, u16 val)
+{
+	return i2c_smbus_write_word_data(priv->client, reg, val);
+}
+
+static s32 hx8837_read(struct hx8837_priv *priv, u8 reg)
+{
+	return i2c_smbus_read_word_data(priv->client, reg);
+}
+
+static void hx8837_hw_init(struct hx8837_priv *priv, int is_init)
+{
+	/* SDRAM setup/hold time */
+	hx8837_write(priv, 0x3a, 0xc040);
+	hx8837_write(priv, DCON_REG_MEM_OPT_A, 0x0000);  /* clear option bits */
+	hx8837_write(priv, DCON_REG_MEM_OPT_A,
+		   MEM_DLL_CLOCK_DELAY | MEM_POWER_DOWN);
+	hx8837_write(priv, DCON_REG_MEM_OPT_B, MEM_SOFT_RESET);
+
+	/* Colour swizzle, AA, no passthrough, backlight */
+	if (is_init) {
+		priv->disp_mode = MODE_PASSTHRU | MODE_BL_ENABLE |
+				MODE_CSWIZZLE | MODE_COL_AA;
+	}
+	hx8837_write(priv, DCON_REG_MODE, priv->disp_mode);
+
+	/* Set the scanline to interrupt on during resume */
+	hx8837_write(priv, DCON_REG_SCAN_INT, priv->resumeline);
+}
+
+static void hx8837_set_backlight(struct hx8837_priv *priv, u8 level)
+{
+	hx8837_write(priv, DCON_REG_BRIGHT, level);
+
+	/* Purposely turn off the backlight when we go to level 0 */
+	if (level == 0) {
+		priv->disp_mode &= ~MODE_BL_ENABLE;
+		hx8837_write(priv, DCON_REG_MODE, priv->disp_mode);
+	} else if (!(priv->disp_mode & MODE_BL_ENABLE)) {
+		priv->disp_mode |= MODE_BL_ENABLE;
+		hx8837_write(priv, DCON_REG_MODE, priv->disp_mode);
+	}
+}
+
+/* Set the output type to either color or mono */
+static int hx8837_set_mono_mode(struct hx8837_priv *priv, bool enable_mono)
+{
+	if (priv->mono == enable_mono)
+		return 0;
+
+	priv->mono = enable_mono;
+
+	if (enable_mono) {
+		priv->disp_mode &= ~(MODE_CSWIZZLE | MODE_COL_AA);
+		priv->disp_mode |= MODE_MONO_LUMA;
+	} else {
+		priv->disp_mode &= ~(MODE_MONO_LUMA);
+		priv->disp_mode |= MODE_CSWIZZLE | MODE_COL_AA;
+	}
+
+	hx8837_write(priv, DCON_REG_MODE, priv->disp_mode);
+	return 0;
+}
+
+/* the DCON seems to get confused if we change DCONLOAD too
+ * frequently -- i.e., approximately faster than frame time.
+ * normally we don't change it this fast, so in general we won't
+ * delay here.
+ */
+static void hx8837_load_holdoff(struct hx8837_priv *priv)
+{
+	ktime_t delta_t, now;
+
+	while (1) {
+		now = ktime_get();
+		delta_t = ktime_sub(now, priv->load_time);
+		if (ktime_to_ns(delta_t) > NSEC_PER_MSEC * 20)
+			break;
+		mdelay(4);
+	}
+}
+
+static bool hx8837_blank_fb(struct hx8837_priv *priv, bool blank)
+{
+	int err;
+
+	console_lock();
+	if (!lock_fb_info(priv->fbinfo)) {
+		console_unlock();
+		dev_err(&priv->client->dev, "unable to lock framebuffer\n");
+		return false;
+	}
+
+	priv->ignore_fb_events = true;
+	err = fb_blank(priv->fbinfo,
+		       blank ? FB_BLANK_POWERDOWN : FB_BLANK_UNBLANK);
+	priv->ignore_fb_events = false;
+	unlock_fb_info(priv->fbinfo);
+	console_unlock();
+
+	if (err) {
+		dev_err(&priv->client->dev, "couldn't %sblank framebuffer\n",
+			blank ? "" : "un");
+		return false;
+	}
+	return true;
+}
+
+/* Set the source of the display (CPU or DCON) */
+static void hx8837_source_switch(struct work_struct *work)
+{
+	struct hx8837_priv *priv = container_of(work, struct hx8837_priv,
+							switch_source);
+	struct device *dev = &priv->client->dev;
+	int source = priv->pending_src;
+
+	if (priv->curr_src == source)
+		return;
+
+	hx8837_load_holdoff(priv);
+
+	priv->switched = false;
+
+	switch (source) {
+	case DCON_SOURCE_CPU:
+		dev_info(dev, "%s to CPU\n", __func__);
+		/* Enable the scanline interrupt bit */
+		if (hx8837_write(priv, DCON_REG_MODE,
+			       priv->disp_mode | MODE_SCAN_INT))
+			dev_err(dev, "couldn't enable scanline interrupt!\n");
+		else
+			/* Wait up to one second for the scanline interrupt */
+			wait_event_timeout(priv->waitq, priv->switched, HZ);
+
+		if (!priv->switched)
+			dev_err(dev, "Timeout entering CPU mode; expect a screen glitch.\n");
+
+		/* Turn off the scanline interrupt */
+		if (hx8837_write(priv, DCON_REG_MODE, priv->disp_mode))
+			dev_err(dev, "couldn't disable scanline interrupt!\n");
+
+		/*
+		 * Ideally we'd like to disable interrupts here so that the
+		 * fb unblanking and DCON turn on happen at a known time value;
+		 * however, we can't do that right now with fb_blank
+		 * messing with semaphores.
+		 *
+		 * For now, we just hope..
+		 */
+		if (!hx8837_blank_fb(priv, false)) {
+			dev_err(dev, "Failed to enter CPU mode\n");
+			priv->pending_src = DCON_SOURCE_DCON;
+			return;
+		}
+
+		/* And turn off the DCON */
+		gpiod_set_value(priv->load_gpio, 1);
+		priv->load_time = ktime_get();
+
+		dev_info(dev, "The CPU has control\n");
+		break;
+	case DCON_SOURCE_DCON:
+		dev_info(dev, "%s to DCON\n", __func__);
+
+		/* Clear DCONLOAD - this implies that the DCON is in control */
+		gpiod_set_value(priv->load_gpio, 0);
+		priv->load_time = ktime_get();
+
+		wait_event_timeout(priv->waitq, priv->switched, HZ / 2);
+
+		if (!priv->switched) {
+			dev_err(dev, "Timeout entering DCON mode; expect a screen glitch.\n");
+		} else {
+			ktime_t delta_t;
+
+			/* sometimes the DCON doesn't follow its own rules,
+			 * and doesn't wait for two vsync pulses before
+			 * ack'ing the frame load with an IRQ.  the result
+			 * is that the display shows the *previously*
+			 * loaded frame.  we can detect this by looking at
+			 * the time between asserting DCONLOAD and the IRQ --
+			 * if it's less than 20msec, then the DCON couldn't
+			 * have seen two VSYNC pulses.  in that case we
+			 * deassert and reassert, and hope for the best.
+			 * see http://dev.laptop.org/ticket/9664
+			 */
+			delta_t = ktime_sub(priv->irq_time, priv->load_time);
+			if (priv->switched && ktime_to_ns(delta_t)
+			    < NSEC_PER_MSEC * 20) {
+				dev_err(dev, "missed loading, retrying\n");
+				gpiod_set_value(priv->load_gpio, 1);
+				mdelay(41);
+				gpiod_set_value(priv->load_gpio, 0);
+				priv->load_time = ktime_get();
+				mdelay(41);
+			}
+		}
+
+		hx8837_blank_fb(priv, true);
+		dev_info(dev, "The DCON has control\n");
+		break;
+	default:
+		WARN_ON(1);
+	}
+
+	priv->curr_src = source;
+}
+
+static void hx8837_set_source(struct hx8837_priv *priv, int arg)
+{
+	if (priv->pending_src == arg)
+		return;
+
+	priv->pending_src = arg;
+
+	if (priv->curr_src != arg)
+		schedule_work(&priv->switch_source);
+}
+
+static void hx8837_set_source_sync(struct hx8837_priv *priv, int arg)
+{
+	hx8837_set_source(priv, arg);
+	flush_scheduled_work();
+}
+
+static int hx8837_bl_update(struct backlight_device *dev)
+{
+	struct hx8837_priv *priv = bl_get_data(dev);
+	u8 level = dev->props.brightness & 0x0F;
+
+	priv->bl_val = level;
+
+	if (dev->props.power != FB_BLANK_UNBLANK)
+		level = 0;
+
+	if (dev->props.state & BL_CORE_FBBLANK)
+		level = 0;
+
+	hx8837_set_backlight(priv, level);
+
+	return 0;
+}
+
+static int hx8837_bl_get(struct backlight_device *dev)
+{
+	struct hx8837_priv *priv = bl_get_data(dev);
+
+	return priv->bl_val;
+}
+
+static const struct backlight_ops hx8837_bl_ops = {
+	.update_status = hx8837_bl_update,
+	.get_brightness = hx8837_bl_get,
+};
+
+static struct backlight_properties hx8837_bl_props = {
+	.max_brightness = 15,
+	.type = BACKLIGHT_RAW,
+	.power = FB_BLANK_UNBLANK,
+};
+
+static int hx8837_reboot_notify(struct notifier_block *nb, unsigned long foo,
+								void *bar)
+{
+	struct hx8837_priv *priv = container_of(nb, struct hx8837_priv,
+								reboot_nb);
+
+	/* Turn off the DCON. Entirely. */
+	hx8837_write(priv, DCON_REG_MODE, 0x39);
+	hx8837_write(priv, DCON_REG_MODE, 0x32);
+	return NOTIFY_DONE;
+}
+
+static int hx8837_panic_notify(struct notifier_block *nb, unsigned long e,
+								void *p)
+{
+	struct hx8837_priv *priv = container_of(nb, struct hx8837_priv,
+								panic_nb);
+
+	gpiod_set_value(priv->load_gpio, 1);
+	return NOTIFY_DONE;
+}
+
+static int hx8837_detect(struct i2c_client *client, struct i2c_board_info *info)
+{
+	strlcpy(info->type, "hx8837", I2C_NAME_SIZE);
+
+	return 0;
+}
+
+static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
+								char *buf)
+{
+	struct hx8837_priv *priv = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%4.4X\n", priv->disp_mode);
+}
+
+static ssize_t freeze_show(struct device *dev, struct device_attribute *attr,
+								char *buf)
+{
+	struct hx8837_priv *priv = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", priv->curr_src == DCON_SOURCE_DCON ? 1 : 0);
+}
+
+static ssize_t monochrome_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct hx8837_priv *priv = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", priv->mono);
+}
+
+static ssize_t resumeline_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct hx8837_priv *priv = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", priv->resumeline);
+}
+
+static ssize_t monochrome_store(struct device *dev,
+			struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+	unsigned long enable_mono;
+	int rc;
+
+	rc = kstrtoul(buf, 10, &enable_mono);
+	if (rc)
+		return rc;
+
+	hx8837_set_mono_mode(dev_get_drvdata(dev), enable_mono ? true : false);
+
+	return count;
+}
+
+static ssize_t freeze_store(struct device *dev, struct device_attribute *attr,
+						const char *buf, size_t count)
+{
+	struct hx8837_priv *priv = dev_get_drvdata(dev);
+	unsigned long output;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &output);
+	if (ret)
+		return ret;
+
+	switch (output) {
+	case 0:
+		hx8837_set_source(priv, DCON_SOURCE_CPU);
+		break;
+	case 1:
+		hx8837_set_source_sync(priv, DCON_SOURCE_DCON);
+		break;
+	case 2:  /* normally unused */
+		hx8837_set_source(priv, DCON_SOURCE_DCON);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static ssize_t resumeline_store(struct device *dev,
+			struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+	struct hx8837_priv *priv = dev_get_drvdata(dev);
+	unsigned short rl;
+	int rc;
+
+	rc = kstrtou16(buf, 10, &rl);
+	if (rc)
+		return rc;
+
+	priv->resumeline = rl;
+	hx8837_write(dev_get_drvdata(dev), DCON_REG_SCAN_INT, priv->resumeline);
+
+	return count;
+}
+
+
+static DEVICE_ATTR_RO(mode);
+static DEVICE_ATTR_RW(freeze);
+static DEVICE_ATTR_RW(monochrome);
+static DEVICE_ATTR_RW(resumeline);
+
+static struct attribute *hx8837_attrs[] = {
+	&dev_attr_mode.attr,
+	&dev_attr_freeze.attr,
+	&dev_attr_monochrome.attr,
+	&dev_attr_resumeline.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(hx8837);
+
+static int hx8837_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct hx8837_priv *priv;
+	u16 ver;
+	int rc;
+
+	if (num_registered_fb < 1)
+		return -EPROBE_DEFER;
+
+	priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->client = client;
+	init_waitqueue_head(&priv->waitq);
+	INIT_WORK(&priv->switch_source, hx8837_source_switch);
+	priv->reboot_nb.notifier_call = hx8837_reboot_notify;
+	priv->reboot_nb.priority = -1;
+	priv->panic_nb.notifier_call = hx8837_panic_notify;
+
+	/*
+	 * Perhaps we could add a phandle to the panel to a DT property so that
+	 * we'll be able to guess it from the vertical resolution instead of
+	 * hardwiring it?
+	 */
+	priv->resumeline = 898;
+
+	i2c_set_clientdata(client, priv);
+
+	priv->fbinfo = registered_fb[0];
+
+	priv->stat0_gpio = devm_gpiod_get_index(&client->dev, "stat", 0,
+								GPIOD_IN);
+	if (IS_ERR(priv->stat0_gpio)) {
+		dev_err(&client->dev, "failed to request STAT0 GPIO\n");
+		return PTR_ERR(priv->stat0_gpio);
+	};
+
+	priv->stat1_gpio = devm_gpiod_get_index(&client->dev, "stat", 1,
+								GPIOD_IN);
+	if (IS_ERR(priv->stat1_gpio)) {
+		dev_err(&client->dev, "failed to request STAT1 GPIO\n");
+		return PTR_ERR(priv->stat1_gpio);
+	};
+
+	priv->load_gpio = devm_gpiod_get(&client->dev, "load", GPIOD_IN);
+	if (IS_ERR(priv->load_gpio)) {
+		dev_err(&client->dev, "failed to request LOAD GPIO\n");
+		return PTR_ERR(priv->load_gpio);
+	};
+
+	priv->irq_gpio = devm_gpiod_get(&client->dev, "irq", GPIOD_IN);
+	if (IS_ERR(priv->irq_gpio)) {
+		dev_err(&client->dev, "failed to request IRQ GPIO\n");
+		return PTR_ERR(priv->irq_gpio);
+	};
+
+	ver = hx8837_read(priv, DCON_REG_ID);
+	if ((ver >> 8) != 0xDC) {
+		dev_err(&client->dev, "DCON ID not 0xDCxx: 0x%04x.\n", ver);
+		return -ENXIO;
+	}
+
+	dev_info(&client->dev, "Discovered DCON version %x\n", ver & 0xFF);
+
+	if (ver < 0xdc02) {
+		dev_err(&client->dev, "DCON v1 is unsupported, giving up.\n");
+		return -ENODEV;
+	}
+
+	/*
+	 * Determine the current state by reading the GPIO bit; earlier
+	 * stages of the boot process have established the state.
+	 */
+	priv->curr_src = gpiod_get_value(priv->load_gpio)
+			? DCON_SOURCE_CPU : DCON_SOURCE_DCON;
+	priv->pending_src = priv->curr_src;
+
+	/* Set the directions for the GPIO pins */
+	gpiod_direction_input(priv->stat0_gpio);
+	gpiod_direction_input(priv->stat1_gpio);
+	gpiod_direction_input(priv->irq_gpio);
+	gpiod_direction_output(priv->load_gpio,
+		priv->curr_src == DCON_SOURCE_CPU);
+
+	/* Register the interrupt handler */
+	rc = devm_request_irq(&client->dev, gpiod_to_irq(priv->irq_gpio),
+			&hx8837_interrupt, IRQF_TRIGGER_FALLING, "DCON", priv);
+	if (rc) {
+		dev_err(&client->dev, "failed to request DCON's irq\n");
+		return rc;
+	}
+
+	hx8837_hw_init(priv, 1);
+
+	priv->bl_val = hx8837_read(priv, DCON_REG_BRIGHT) & 0x0F;
+
+	/* Add the backlight device for the DCON */
+	hx8837_bl_props.brightness = priv->bl_val;
+	priv->bl_dev = devm_backlight_device_register(&client->dev, "hx8837-bl",
+			&client->dev, priv, &hx8837_bl_ops, &hx8837_bl_props);
+	if (IS_ERR(priv->bl_dev)) {
+		dev_err(&client->dev, "cannot register backlight dev (%ld)\n",
+			PTR_ERR(priv->bl_dev));
+		priv->bl_dev = NULL;
+	}
+
+	rc = devm_device_add_groups(&client->dev, hx8837_groups);
+	if (rc) {
+		dev_err(&client->dev, "failed to register sysfs groups\n");
+		return rc;
+	}
+
+	devm_register_reboot_notifier(&client->dev, &priv->reboot_nb);
+	atomic_notifier_chain_register(&panic_notifier_list, &priv->panic_nb);
+
+	return 0;
+}
+
+static int hx8837_remove(struct i2c_client *client)
+{
+	struct hx8837_priv *priv = i2c_get_clientdata(client);
+
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+					&priv->panic_nb);
+
+	cancel_work_sync(&priv->switch_source);
+
+	return 0;
+}
+
+static irqreturn_t hx8837_interrupt(int irq, void *id)
+{
+	struct hx8837_priv *priv = id;
+	struct device *dev = &priv->client->dev;
+	u8 status;
+
+	status = gpiod_get_value(priv->stat0_gpio);
+	status |= gpiod_get_value(priv->stat1_gpio) << 1;
+
+
+	switch (status & 3) {
+	case 3:
+		dev_dbg(dev, "DCONLOAD_MISSED interrupt\n");
+		break;
+
+	case 2:	/* switch to DCON mode */
+	case 1: /* switch to CPU mode */
+		priv->switched = true;
+		priv->irq_time = ktime_get();
+		wake_up(&priv->waitq);
+		break;
+
+	case 0:
+		/* workaround resume case:  the DCON (on 1.5) doesn't
+		 * ever assert status 0x01 when switching to CPU mode
+		 * during resume.  this is because DCONLOAD is de-asserted
+		 * _immediately_ upon exiting S3, so the actual release
+		 * of the DCON happened long before this point.
+		 * see http://dev.laptop.org/ticket/9869
+		 */
+		if (priv->curr_src != priv->pending_src && !priv->switched) {
+			priv->switched = true;
+			priv->irq_time = ktime_get();
+			wake_up(&priv->waitq);
+			dev_dbg(dev, "switching w/ status 0/0\n");
+		} else {
+			dev_dbg(dev, "scanline interrupt w/CPU\n");
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+#ifdef CONFIG_PM
+static int hx8837_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct hx8837_priv *priv = i2c_get_clientdata(client);
+
+	hx8837_set_source_sync(priv, DCON_SOURCE_DCON);
+
+	return 0;
+}
+
+static int hx8837_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct hx8837_priv *priv = i2c_get_clientdata(client);
+
+	hx8837_set_source(priv, DCON_SOURCE_CPU);
+
+	return 0;
+}
+#endif /* CONFIG_PM */
+
+static SIMPLE_DEV_PM_OPS(hx8837_pm_ops, hx8837_suspend, hx8837_resume);
+
+static const struct of_device_id hx8837_dt_ids[] = {
+	{ .compatible = "himax,hx8837", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, hx8837_dt_ids);
+
+static const struct i2c_device_id hx8837_i2c_ids[] = {
+	{ .name = "hx8837", },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, hx8837_i2c_ids);
+
+static struct i2c_driver hx8837_driver = {
+	.driver = {
+		.name = "hx8837",
+		.pm = &hx8837_pm_ops,
+		.of_match_table = hx8837_dt_ids,
+	},
+	.class = I2C_CLASS_DDC | I2C_CLASS_HWMON,
+	.id_table = hx8837_i2c_ids,
+	.probe = hx8837_probe,
+	.remove = hx8837_remove,
+	.detect = hx8837_detect,
+	.address_list = normal_i2c,
+};
+
+module_i2c_driver(hx8837_driver);
+
+MODULE_DESCRIPTION("HX8837 Display Controller Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

