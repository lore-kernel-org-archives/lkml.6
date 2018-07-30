Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9542DFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B30520881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fcThgy2J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B30520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbeG3OFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:05:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33620 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728798AbeG3OFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:05:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id d4-v6so4245789pfn.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 05:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QhQ9Ayd56PZnAQpsQqZJBNLbgbVKjRGyBc6F+pgDHxM=;
        b=fcThgy2JOgZt0b75mGwMjPLBWvWqwblDLU7spZoH2ZUsWewdDm0mVbH9mhrNQvDWML
         XWpiKZeb8f2N2pv3PXUFEC/RNGUi668pVLegroS8Ij+j0gVvmJHK/sVduqQjUJlb+2UD
         01OyXg2xQQgTut9AWNXwcFw/qA1bh/Cxb2KOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QhQ9Ayd56PZnAQpsQqZJBNLbgbVKjRGyBc6F+pgDHxM=;
        b=hRRerPElr+QTYzUcWwCfO7UtXN4F4cSwekHqMBczrenQufaNNo2oeGnWmbRuSsEp1C
         VtG/uHYim6S6ozZilOW/y3kRvJSjPxVsFmoO9eF0srhoiqdjX8k+RIC3eQ7wQoI1Z6Ka
         grUeKc95Q9psAmLu8o2T1OViAkPYRAGw77qn9wD2IhukPJokRpgnok2OtzY3B5qThAwH
         ib9YLF0QSNoNoy1W3AHvs+oOgUPiUnJc8MIR5x0oNmaF9nqktKN+675vlCvHm0U/f8qz
         VJYoiI4tSZ0EqQs/St2gl5HGZ+fqvcea/MwIrMWrvIbZXoDQ8c62CnGzreRdrBWa4pB7
         G4FA==
X-Gm-Message-State: AOUpUlGCgAjZaK2fn0nAXy2BoK+aJRV5tH4BLvL3pfGYovGOB9J+4T7q
        cmVCsAfMJEmw3l+2XDaC1qCbYw==
X-Google-Smtp-Source: AAOMgpeHGcC25DtmuVNBHXgvjzzfmVywiRvtdUHMm87KUsdT36yFSvnQOEWu2wi4/x6PItv2dEk69Q==
X-Received: by 2002:a63:ba43:: with SMTP id l3-v6mr15700002pgu.295.1532953838020;
        Mon, 30 Jul 2018 05:30:38 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e8-v6sm26640139pgi.24.2018.07.30.05.30.35
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Jul 2018 05:30:37 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     jacek.anaszewski@gmail.com, pavel@ucw.cz
Cc:     bjorn.andersson@linaro.org, david@lechnology.com,
        baolin.wang@linaro.org, broonie@kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] leds: core: Introduce LED pattern trigger
Date:   Mon, 30 Jul 2018 20:29:29 +0800
Message-Id: <e74c21120d89dd645377761e6c9995eab6eb00ca.1532953083.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some LED controllers have support for autonomously controlling
brightness over time, according to some preprogrammed pattern or
function.

This patch adds pattern trigger that LED device can configure the
pattern and trigger it.

Signed-off-by: Raphael Teysseyre <rteysseyre@gmail.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../ABI/testing/sysfs-class-led-trigger-pattern    |   21 ++
 drivers/leds/trigger/Kconfig                       |   10 +
 drivers/leds/trigger/Makefile                      |    1 +
 drivers/leds/trigger/ledtrig-pattern.c             |  349 ++++++++++++++++++++
 include/linux/leds.h                               |   19 ++
 5 files changed, 400 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-led-trigger-pattern
 create mode 100644 drivers/leds/trigger/ledtrig-pattern.c

diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
new file mode 100644
index 0000000..c52da34
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
@@ -0,0 +1,21 @@
+What:		/sys/class/leds/<led>/pattern
+Date:		August 2018
+KernelVersion:	4.19
+Description:
+		Specify a pattern for the LED, for LED hardware that support
+		altering the brightness as a function of time.
+
+		The pattern is given by a series of tuples, of brightness and
+		duration (ms). The LED is expected to traverse the series and
+		each brightness value for the specified duration. Duration of
+		0 means brightness should immediately change to new value.
+
+		The format of the pattern values should be:
+		"brightness_1 duration_1, brightness_2 duration_2, brightness_3
+		duration_3, ...".
+
+What:		/sys/class/leds/<led>/repeat
+Date:		August 2018
+KernelVersion:	4.19
+Description:
+		Specify a pattern repeat number. 0 means repeat indefinitely.
diff --git a/drivers/leds/trigger/Kconfig b/drivers/leds/trigger/Kconfig
index a2559b4..a03afcd 100644
--- a/drivers/leds/trigger/Kconfig
+++ b/drivers/leds/trigger/Kconfig
@@ -125,6 +125,16 @@ config LEDS_TRIGGER_CAMERA
 	  This enables direct flash/torch on/off by the driver, kernel space.
 	  If unsure, say Y.
 
+config LEDS_TRIGGER_PATTERN
+       tristate "LED Pattern Trigger"
+       depends on LEDS_TRIGGERS
+       help
+         This allows LEDs blinking with an arbitrary pattern. Can be useful
+         on embedded systems with no screen to give out a status code to
+         a human.
+
+         If unsure, say N
+
 config LEDS_TRIGGER_PANIC
 	bool "LED Panic Trigger"
 	depends on LEDS_TRIGGERS
diff --git a/drivers/leds/trigger/Makefile b/drivers/leds/trigger/Makefile
index f3cfe19..c5d180e 100644
--- a/drivers/leds/trigger/Makefile
+++ b/drivers/leds/trigger/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_LEDS_TRIGGER_TRANSIENT)	+= ledtrig-transient.o
 obj-$(CONFIG_LEDS_TRIGGER_CAMERA)	+= ledtrig-camera.o
 obj-$(CONFIG_LEDS_TRIGGER_PANIC)	+= ledtrig-panic.o
 obj-$(CONFIG_LEDS_TRIGGER_NETDEV)	+= ledtrig-netdev.o
+obj-$(CONFIG_LEDS_TRIGGER_PATTERN)     += ledtrig-pattern.o
diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/ledtrig-pattern.c
new file mode 100644
index 0000000..b709aa1
--- /dev/null
+++ b/drivers/leds/trigger/ledtrig-pattern.c
@@ -0,0 +1,349 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * LED pattern trigger
+ *
+ * Idea discussed with Pavel Machek. Raphael Teysseyre implemented
+ * the first version, Baolin Wang simplified and improved the approach.
+ */
+
+#include <linux/kernel.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/timer.h>
+
+/*
+ * The "pattern" attribute contains at most PAGE_SIZE characters. Each line
+ * in this attribute is at least 4 characters long (a 1-digit number for the
+ * led brighntess, a space, a 1-digit number for the time, a semi-colon).
+ * Therefore, there is at most PAGE_SIZE/4 patterns.
+ */
+#define MAX_PATTERNS		(PAGE_SIZE / 4)
+#define PATTERN_SEPARATOR	","
+
+struct pattern_trig_data {
+	struct led_classdev *led_cdev;
+	struct led_pattern *patterns;
+	struct led_pattern *curr;
+	struct led_pattern *next;
+	struct mutex lock;
+	u32 npatterns;
+	u32 repeat;
+	bool is_indefinite;
+	struct timer_list timer;
+};
+
+static void pattern_trig_update_patterns(struct pattern_trig_data *data)
+{
+	data->curr = data->next;
+	if (!data->is_indefinite && data->curr == data->patterns)
+		data->repeat--;
+
+	if (data->next == data->patterns + data->npatterns - 1)
+		data->next = data->patterns;
+	else
+		data->next++;
+}
+
+static void pattern_trig_timer_function(struct timer_list *t)
+{
+	struct pattern_trig_data *data = from_timer(data, t, timer);
+
+	mutex_lock(&data->lock);
+
+	if (!data->is_indefinite && !data->repeat) {
+		mutex_unlock(&data->lock);
+		return;
+	}
+
+	led_set_brightness(data->led_cdev, data->curr->brightness);
+	mod_timer(&data->timer, jiffies + msecs_to_jiffies(data->curr->delta_t));
+	pattern_trig_update_patterns(data);
+
+	mutex_unlock(&data->lock);
+}
+
+static int pattern_trig_start_pattern(struct pattern_trig_data *data,
+				       struct led_classdev *led_cdev)
+{
+	if (!data->npatterns)
+		return 0;
+
+	if (led_cdev->pattern_clear)
+		led_cdev->pattern_clear(led_cdev);
+
+	if (led_cdev->pattern_set) {
+		return led_cdev->pattern_set(led_cdev, data->patterns,
+					     data->npatterns, data->repeat);
+	}
+
+	data->curr = data->patterns;
+	data->next = data->patterns + 1;
+	data->timer.expires = jiffies;
+	add_timer(&data->timer);
+
+	return 0;
+}
+
+static ssize_t pattern_trig_show_repeat(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+	struct pattern_trig_data *data = led_cdev->trigger_data;
+	int err;
+	u32 repeat;
+
+	mutex_lock(&data->lock);
+
+	if (led_cdev->pattern_get) {
+		err = led_cdev->pattern_get(led_cdev, data->patterns,
+					    &data->npatterns, &data->repeat);
+		if (err) {
+			mutex_unlock(&data->lock);
+			return err;
+		}
+	}
+
+	repeat = data->repeat;
+	mutex_unlock(&data->lock);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n", repeat);
+}
+
+static ssize_t pattern_trig_store_repeat(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+	struct pattern_trig_data *data = led_cdev->trigger_data;
+	unsigned long res;
+	int err;
+
+	err = kstrtoul(buf, 10, &res);
+	if (err)
+		return err;
+
+	del_timer_sync(&data->timer);
+
+	mutex_lock(&data->lock);
+	data->repeat = res;
+
+	/* 0 means repeat indefinitely */
+	if (!data->repeat)
+		data->is_indefinite = true;
+	else
+		data->is_indefinite = false;
+
+	err = pattern_trig_start_pattern(data, led_cdev);
+	if (err) {
+		mutex_unlock(&data->lock);
+		return err;
+	}
+
+	mutex_unlock(&data->lock);
+	return count;
+}
+
+static DEVICE_ATTR(repeat, 0644, pattern_trig_show_repeat,
+		   pattern_trig_store_repeat);
+
+static ssize_t pattern_trig_show_pattern(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+	struct pattern_trig_data *data = led_cdev->trigger_data;
+	ssize_t count = 0;
+	int err, i;
+
+	mutex_lock(&data->lock);
+
+	if (led_cdev->pattern_get) {
+		err = led_cdev->pattern_get(led_cdev, data->patterns,
+					    &data->npatterns, &data->repeat);
+		if (err) {
+			mutex_unlock(&data->lock);
+			return err;
+		}
+	}
+
+	if (!data->npatterns) {
+		mutex_unlock(&data->lock);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < data->npatterns; i++) {
+		count += scnprintf(buf + count, PAGE_SIZE - count,
+				   "%d %d" PATTERN_SEPARATOR,
+				   data->patterns[i].brightness,
+				   data->patterns[i].delta_t);
+	}
+
+	buf[count - 1] = '\n';
+	buf[count] = '\0';
+
+	mutex_unlock(&data->lock);
+	return count + 1;
+}
+
+static ssize_t pattern_trig_store_pattern(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+	struct pattern_trig_data *data = led_cdev->trigger_data;
+	int err, cr, ccount, tcr = 0;
+
+	del_timer_sync(&data->timer);
+
+	mutex_lock(&data->lock);
+
+	for (data->npatterns = 0; data->npatterns < MAX_PATTERNS;
+	     data->npatterns++) {
+		/* Characters read on one conversion */
+		cr = 0;
+		/* Number of successful conversions */
+		ccount = sscanf(buf + tcr, "%d %d " PATTERN_SEPARATOR "%n",
+				&data->patterns[data->npatterns].brightness,
+				&data->patterns[data->npatterns].delta_t, &cr);
+
+		/* Total characters read */
+		tcr += cr;
+		if (cr)
+			continue;
+
+		/* Invalid syntax or end of pattern */
+		if (ccount == 2)
+			data->npatterns++;
+
+		err = pattern_trig_start_pattern(data, led_cdev);
+		if (err) {
+			mutex_unlock(&data->lock);
+			return err;
+		}
+
+		mutex_unlock(&data->lock);
+		return count;
+	}
+
+	/* Shouldn't reach that */
+	WARN(1, "MAX_NSTEP too small. Please report\n");
+	mutex_unlock(&data->lock);
+	return count;
+}
+
+static DEVICE_ATTR(pattern, 0644, pattern_trig_show_pattern,
+		   pattern_trig_store_pattern);
+
+static int pattern_trig_create_sysfs_files(struct device *dev)
+{
+	int err;
+
+	err = device_create_file(dev, &dev_attr_repeat);
+	if (err)
+		return err;
+
+	err = device_create_file(dev, &dev_attr_pattern);
+	if (err)
+		device_remove_file(dev, &dev_attr_repeat);
+
+	return err;
+}
+
+static void pattern_trig_remove_sysfs_files(struct device *dev)
+{
+	device_remove_file(dev, &dev_attr_pattern);
+	device_remove_file(dev, &dev_attr_repeat);
+}
+
+static int pattern_trig_initialize_data(struct pattern_trig_data *data)
+{
+	data->patterns = kcalloc(MAX_PATTERNS, sizeof(struct led_pattern),
+				 GFP_KERNEL);
+	if (!data->patterns)
+		return -ENOMEM;
+
+	data->is_indefinite = true;
+	mutex_init(&data->lock);
+
+	return 0;
+}
+
+static void pattern_trig_clear_data(struct pattern_trig_data *data)
+{
+	kfree(data->patterns);
+}
+
+static void pattern_trig_activate(struct led_classdev *led_cdev)
+{
+	struct pattern_trig_data *data;
+	int err;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return;
+
+	err = pattern_trig_initialize_data(data);
+	if (err) {
+		kfree(data);
+		return;
+	}
+
+	err = pattern_trig_create_sysfs_files(led_cdev->dev);
+	if (err) {
+		pattern_trig_clear_data(data);
+		kfree(data);
+		return;
+	}
+
+	data->led_cdev = led_cdev;
+	led_cdev->trigger_data = data;
+	timer_setup(&data->timer, pattern_trig_timer_function, 0);
+	led_cdev->activated = true;
+}
+
+static void pattern_trig_deactivate(struct led_classdev *led_cdev)
+{
+	struct pattern_trig_data *data = led_cdev->trigger_data;
+
+	if (!led_cdev->activated)
+		return;
+
+	if (led_cdev->pattern_clear)
+		led_cdev->pattern_clear(led_cdev);
+
+	del_timer_sync(&data->timer);
+	pattern_trig_remove_sysfs_files(led_cdev->dev);
+	led_set_brightness(led_cdev, LED_OFF);
+	pattern_trig_clear_data(data);
+	kfree(data);
+	led_cdev->trigger_data = NULL;
+	led_cdev->activated = false;
+}
+
+static struct led_trigger pattern_led_trigger = {
+	.name = "pattern",
+	.activate = pattern_trig_activate,
+	.deactivate = pattern_trig_deactivate,
+};
+
+static int __init pattern_trig_init(void)
+{
+	return led_trigger_register(&pattern_led_trigger);
+}
+
+static void __exit pattern_trig_exit(void)
+{
+	led_trigger_unregister(&pattern_led_trigger);
+}
+
+module_init(pattern_trig_init);
+module_exit(pattern_trig_exit);
+
+MODULE_AUTHOR("Raphael Teysseyre <rteysseyre@gmail.com");
+MODULE_AUTHOR("Baolin Wang <baolin.wang@linaro.org");
+MODULE_DESCRIPTION("LED Pattern trigger");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/leds.h b/include/linux/leds.h
index b7e8255..bea02f0 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -22,6 +22,7 @@
 #include <linux/workqueue.h>
 
 struct device;
+struct led_pattern;
 /*
  * LED Core
  */
@@ -88,6 +89,14 @@ struct led_classdev {
 				     unsigned long *delay_on,
 				     unsigned long *delay_off);
 
+	int (*pattern_set)(struct led_classdev *led_cdev,
+			   struct led_pattern *pattern, int len,
+			   unsigned repeat);
+	int (*pattern_get)(struct led_classdev *led_cdev,
+			   struct led_pattern *pattern, int *len,
+			   unsigned *repeat);
+	int (*pattern_clear)(struct led_classdev *led_cdev);
+
 	struct device		*dev;
 	const struct attribute_group	**groups;
 
@@ -446,4 +455,14 @@ static inline void led_classdev_notify_brightness_hw_changed(
 	struct led_classdev *led_cdev, enum led_brightness brightness) { }
 #endif
 
+/**
+ * struct led_pattern - brightness value in a pattern
+ * @delta_t: delay until next entry, in milliseconds
+ * @brightness: brightness at time = 0
+ */
+struct led_pattern {
+	int delta_t;
+	int brightness;
+};
+
 #endif		/* __LINUX_LEDS_H_INCLUDED */
-- 
1.7.9.5

