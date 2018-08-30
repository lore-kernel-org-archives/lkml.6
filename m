Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61138C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C972073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IZP3Snoa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C972073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbeH3Llk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 07:41:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40307 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbeH3Llj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 07:41:39 -0400
Received: by mail-pg1-f193.google.com with SMTP id a13-v6so825675pgt.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 00:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LAJCRIWPbqlZYjoPFpjtZRu7hRC5PNhroFuNnTsWv0E=;
        b=IZP3SnoaPRDS87wHJJc3Vq6lrvJTmu2gcBhqGTyOfWU2oC73yptpqpoH+K81ZKdshy
         ySm7yoKGRwBQ5DUmigy8cCrjjrylhm9Y/h29h+g5kiPTJqrRihs95029XedTyQ0Qd8Ri
         zSo6Kw9MCTS1j+As56q8QxlHFoHBaDSh1nh80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LAJCRIWPbqlZYjoPFpjtZRu7hRC5PNhroFuNnTsWv0E=;
        b=p5QWE5TNc0ozihM4WImGFOgpTDc7mZqboWUB/PgHa7jRjMYB5NetI6qnLrCdsG8Wzv
         7AOrYVG4wQYvh75jO8iYuC4N9gEwe0nS9hH8y0m+rANVKoEAN4w/p+67Fs6YQj4H6HYy
         hEJtVj7/nrFnIbIh7p9HDm/HZmGTs645T95A1EoPWAWj6jf2Sv/qPiVV8U/smtHPp5Z/
         NJOewYZl1+NJdyjVWzig/fdXcaxAHdGM3xUePe8yA4oNqCac94yza2G42e+3ZSX1w1AW
         SrXDQqnmY8kZjVr3RkoM9MfiHMxCY8/GZKptEJ99OGQ/DZzA7yN9dCQhlR5BfrXRVTza
         DMBA==
X-Gm-Message-State: APzg51DTbiVc3vF7N0ZU+ZpPdjt22soufVYwpOj9oC/ev9PaX802FUIq
        3lSzrGKxgt9ZhUel/JnEEkOmXw==
X-Google-Smtp-Source: ANB0VdYG1yhytZFem46Lm4D5B2sk0JWSbTBG16HEHF6U6shWWlTdcilARv/AfC7fCTNKhL0qFwpT7A==
X-Received: by 2002:a62:8208:: with SMTP id w8-v6mr9120733pfd.215.1535614850264;
        Thu, 30 Aug 2018 00:40:50 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id q6-v6sm12096167pgq.19.2018.08.30.00.40.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Aug 2018 00:40:49 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     jacek.anaszewski@gmail.com, pavel@ucw.cz
Cc:     rteysseyre@gmail.com, bjorn.andersson@linaro.org,
        baolin.wang@linaro.org, broonie@kernel.org,
        linus.walleij@linaro.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] leds: core: Introduce LED pattern trigger
Date:   Thu, 30 Aug 2018 15:40:39 +0800
Message-Id: <f8f1439338464103cc9a4b4a93b590a9635c7fcb.1535614434.git.baolin.wang@linaro.org>
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
Changes from v5:
 - Add one 'hw_pattern' file for hardware patterns.

Changes from v4:
 - Change the repeat file to return the originally written number.
 - Improve comments.
 - Fix some build warnings.

Changes from v3:
 - Reset pattern number to 0 if user provides incorrect pattern string.
 - Support one pattern.

Changes from v2:
 - Remove hardware_pattern boolen.
 - Chnage the pattern string format.

Changes from v1:
 - Use ATTRIBUTE_GROUPS() to define attributes.
 - Introduce hardware_pattern flag to determine if software pattern
 or hardware pattern.
 - Re-implement pattern_trig_store_pattern() function.
 - Remove pattern_get() interface.
 - Improve comments.
 - Other small optimization.
---
 .../ABI/testing/sysfs-class-led-trigger-pattern    |   41 +++
 drivers/leds/trigger/Kconfig                       |    7 +
 drivers/leds/trigger/Makefile                      |    1 +
 drivers/leds/trigger/ledtrig-pattern.c             |  344 ++++++++++++++++++++
 include/linux/leds.h                               |   16 +
 5 files changed, 409 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-led-trigger-pattern
 create mode 100644 drivers/leds/trigger/ledtrig-pattern.c

diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
new file mode 100644
index 0000000..dda8bbc
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
@@ -0,0 +1,41 @@
+What:		/sys/class/leds/<led>/pattern
+Date:		September 2018
+KernelVersion:	4.20
+Description:
+		Specify a software pattern for the LED, that supports altering
+		the brightness for the specified duration with one software
+		timer.
+
+		The pattern is given by a series of tuples, of brightness and
+		duration (ms). The LED is expected to traverse the series and
+		each brightness value for the specified duration. Duration of
+		0 means brightness should immediately change to new value.
+
+		The format of the software pattern values should be:
+		"brightness_1 duration_1 brightness_2 duration_2 brightness_3
+		duration_3 ...".
+
+What:		/sys/class/leds/<led>/hw_pattern
+Date:		September 2018
+KernelVersion:	4.20
+Description:
+		Specify a hardware pattern for the LED, for LED hardware that
+		supports altering the brightness as a function of time.
+
+		The pattern is given by a series of tuples, of brightness and
+		duration (ms). The LED is expected to traverse the series and
+		each brightness value for the specified duration. Duration of
+		0 means brightness should immediately change to new value.
+
+		The format of the hardware pattern values should be:
+		"brightness_1 duration_1 brightness_2 duration_2 brightness_3
+		duration_3 ...".
+
+What:		/sys/class/leds/<led>/repeat
+Date:		September 2018
+KernelVersion:	4.20
+Description:
+		Specify a pattern repeat number. 0 means repeat indefinitely.
+
+		This file will always return the originally written repeat
+		number.
diff --git a/drivers/leds/trigger/Kconfig b/drivers/leds/trigger/Kconfig
index 4018af7..b76fc3c 100644
--- a/drivers/leds/trigger/Kconfig
+++ b/drivers/leds/trigger/Kconfig
@@ -129,4 +129,11 @@ config LEDS_TRIGGER_NETDEV
 	  This allows LEDs to be controlled by network device activity.
 	  If unsure, say Y.
 
+config LEDS_TRIGGER_PATTERN
+	tristate "LED Pattern Trigger"
+	help
+	  This allows LEDs to be controlled by a software or hardware pattern
+	  which is a series of tuples, of brightness and duration (ms).
+	  If unsure, say N
+
 endif # LEDS_TRIGGERS
diff --git a/drivers/leds/trigger/Makefile b/drivers/leds/trigger/Makefile
index f3cfe19..9bcb64e 100644
--- a/drivers/leds/trigger/Makefile
+++ b/drivers/leds/trigger/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_LEDS_TRIGGER_TRANSIENT)	+= ledtrig-transient.o
 obj-$(CONFIG_LEDS_TRIGGER_CAMERA)	+= ledtrig-camera.o
 obj-$(CONFIG_LEDS_TRIGGER_PANIC)	+= ledtrig-panic.o
 obj-$(CONFIG_LEDS_TRIGGER_NETDEV)	+= ledtrig-netdev.o
+obj-$(CONFIG_LEDS_TRIGGER_PATTERN)	+= ledtrig-pattern.o
diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/ledtrig-pattern.c
new file mode 100644
index 0000000..efbd5ef
--- /dev/null
+++ b/drivers/leds/trigger/ledtrig-pattern.c
@@ -0,0 +1,344 @@
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
+#define MAX_PATTERNS		1024
+
+struct pattern_trig_data {
+	struct led_classdev *led_cdev;
+	struct led_pattern patterns[MAX_PATTERNS];
+	struct led_pattern *curr;
+	struct led_pattern *next;
+	struct mutex lock;
+	u32 npatterns;
+	u32 repeat;
+	u32 last_repeat;
+	bool is_indefinite;
+	bool is_hw_pattern;
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
+static int pattern_trig_start_pattern(struct led_classdev *led_cdev)
+{
+	struct pattern_trig_data *data = led_cdev->trigger_data;
+
+	if (!data->npatterns)
+		return 0;
+
+	if (data->is_hw_pattern) {
+		return led_cdev->pattern_set(led_cdev, data->patterns,
+					     data->npatterns, data->repeat);
+	}
+
+	data->curr = data->patterns;
+	data->next = data->npatterns > 1 ? data->patterns + 1 : data->patterns;
+	data->timer.expires = jiffies;
+	add_timer(&data->timer);
+
+	return 0;
+}
+
+static ssize_t repeat_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+	struct pattern_trig_data *data = led_cdev->trigger_data;
+	u32 repeat;
+
+	mutex_lock(&data->lock);
+
+	repeat = data->last_repeat;
+
+	mutex_unlock(&data->lock);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n", repeat);
+}
+
+static ssize_t repeat_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
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
+	/*
+	 * Clear previous patterns' performence firstly, and remove the timer
+	 * without mutex lock to avoid dead lock.
+	 */
+	del_timer_sync(&data->timer);
+
+	mutex_lock(&data->lock);
+
+	if (data->is_hw_pattern)
+		led_cdev->pattern_clear(led_cdev);
+
+	data->last_repeat = data->repeat = res;
+
+	/* 0 means repeat indefinitely */
+	if (!data->repeat)
+		data->is_indefinite = true;
+	else
+		data->is_indefinite = false;
+
+	err = pattern_trig_start_pattern(led_cdev);
+
+	mutex_unlock(&data->lock);
+	return err < 0 ? err : count;
+}
+
+static DEVICE_ATTR_RW(repeat);
+
+static ssize_t pattern_trig_show_patterns(struct pattern_trig_data *data,
+					  char *buf, bool hw_pattern)
+{
+	ssize_t count = 0;
+	int i;
+
+	mutex_lock(&data->lock);
+
+	if (!data->npatterns || (data->is_hw_pattern ^ hw_pattern))
+		goto out;
+
+	for (i = 0; i < data->npatterns; i++) {
+		count += scnprintf(buf + count, PAGE_SIZE - count,
+				   "%d %d ",
+				   data->patterns[i].brightness,
+				   data->patterns[i].delta_t);
+	}
+
+	buf[count - 1] = '\n';
+
+out:
+	mutex_unlock(&data->lock);
+	return count;
+}
+
+static ssize_t pattern_trig_store_patterns(struct led_classdev *led_cdev,
+					   const char *buf, size_t count,
+					   bool hw_pattern)
+{
+	struct pattern_trig_data *data = led_cdev->trigger_data;
+	int ccount, cr, offset = 0, err = 0;
+
+	/*
+	 * Clear previous patterns' performence firstly, and remove the timer
+	 * without mutex lock to avoid dead lock.
+	 */
+	del_timer_sync(&data->timer);
+
+	mutex_lock(&data->lock);
+
+	if (data->is_hw_pattern)
+		led_cdev->pattern_clear(led_cdev);
+
+	if (hw_pattern)
+		data->is_hw_pattern = true;
+	else
+		data->is_hw_pattern = false;
+
+	data->npatterns = 0;
+	while (offset < count - 1 && data->npatterns < MAX_PATTERNS) {
+		cr = 0;
+		ccount = sscanf(buf + offset, "%d %d %n",
+				&data->patterns[data->npatterns].brightness,
+				&data->patterns[data->npatterns].delta_t, &cr);
+		if (ccount != 2) {
+			data->npatterns = 0;
+			err = -EINVAL;
+			goto out;
+		}
+
+		offset += cr;
+		data->npatterns++;
+	}
+
+	err = pattern_trig_start_pattern(led_cdev);
+
+out:
+	mutex_unlock(&data->lock);
+	return err < 0 ? err : count;
+}
+
+static ssize_t pattern_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+	struct pattern_trig_data *data = led_cdev->trigger_data;
+
+	return pattern_trig_show_patterns(data, buf, false);
+}
+
+static ssize_t pattern_store(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+
+	return pattern_trig_store_patterns(led_cdev, buf, count, false);
+}
+
+static DEVICE_ATTR_RW(pattern);
+
+static ssize_t hw_pattern_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+	struct pattern_trig_data *data = led_cdev->trigger_data;
+
+	return pattern_trig_show_patterns(data, buf, true);
+}
+
+static ssize_t hw_pattern_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+
+	return pattern_trig_store_patterns(led_cdev, buf, count, true);
+}
+
+static DEVICE_ATTR_RW(hw_pattern);
+
+static umode_t pattern_trig_attrs_mode(struct kobject *kobj,
+				       struct attribute *attr, int index)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+
+	if (attr == &dev_attr_repeat.attr || attr == &dev_attr_pattern.attr)
+		return attr->mode;
+	else if (attr == &dev_attr_hw_pattern.attr && led_cdev->pattern_set)
+		return attr->mode;
+
+	return 0;
+}
+
+static struct attribute *pattern_trig_attrs[] = {
+	&dev_attr_pattern.attr,
+	&dev_attr_hw_pattern.attr,
+	&dev_attr_repeat.attr,
+	NULL
+};
+
+static const struct attribute_group pattern_trig_group = {
+	.attrs = pattern_trig_attrs,
+	.is_visible = pattern_trig_attrs_mode,
+};
+
+static const struct attribute_group *pattern_trig_groups[] = {
+	&pattern_trig_group,
+	NULL,
+};
+
+static int pattern_trig_activate(struct led_classdev *led_cdev)
+{
+	struct pattern_trig_data *data;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	if (!!led_cdev->pattern_set ^ !!led_cdev->pattern_clear) {
+		dev_warn(led_cdev->dev,
+			 "Hardware pattern ops validation failed\n");
+		led_cdev->pattern_set = NULL;
+		led_cdev->pattern_clear = NULL;
+	}
+
+	data->is_indefinite = true;
+	mutex_init(&data->lock);
+	data->led_cdev = led_cdev;
+	led_set_trigger_data(led_cdev, data);
+	timer_setup(&data->timer, pattern_trig_timer_function, 0);
+	led_cdev->activated = true;
+
+	return 0;
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
+
+	led_set_brightness(led_cdev, LED_OFF);
+	kfree(data);
+	led_cdev->activated = false;
+}
+
+static struct led_trigger pattern_led_trigger = {
+	.name = "pattern",
+	.activate = pattern_trig_activate,
+	.deactivate = pattern_trig_deactivate,
+	.groups = pattern_trig_groups,
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
index 834683d..74fc2c6 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -22,6 +22,7 @@
 #include <linux/workqueue.h>
 
 struct device;
+struct led_pattern;
 /*
  * LED Core
  */
@@ -88,6 +89,11 @@ struct led_classdev {
 				     unsigned long *delay_on,
 				     unsigned long *delay_off);
 
+	int (*pattern_set)(struct led_classdev *led_cdev,
+			   struct led_pattern *pattern, int len,
+			   unsigned int repeat);
+	int (*pattern_clear)(struct led_classdev *led_cdev);
+
 	struct device		*dev;
 	const struct attribute_group	**groups;
 
@@ -472,4 +478,14 @@ static inline void led_classdev_notify_brightness_hw_changed(
 	struct led_classdev *led_cdev, enum led_brightness brightness) { }
 #endif
 
+/**
+ * struct led_pattern - pattern interval settings
+ * @delta_t: pattern interval delay, in milliseconds
+ * @brightness: pattern interval brightness
+ */
+struct led_pattern {
+	int delta_t;
+	int brightness;
+};
+
 #endif		/* __LINUX_LEDS_H_INCLUDED */
-- 
1.7.9.5

