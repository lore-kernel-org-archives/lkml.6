Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F85C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC1B2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fuO25yrL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC1B2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbeIGIGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 04:06:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45116 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbeIGIGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 04:06:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id j8-v6so5913444pll.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 20:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FtagFuZjurSSKldMvAxg8uj7q3pyslMmBrBHyzCqRoc=;
        b=fuO25yrLeKQa1vW6f7SXWT8NT5aqMWu/Q18WD70WmaG4BtjiSpNyOY+G25AIy42EcK
         lykk6vTQYwiRF7y1RxbjtGABPb9DQHOYo9nqEa7JbrfNfZvMPZSy+43PkSJJ4wHgX7Rc
         Zw7vQq4MGPjJXIKrsvWuo9ZDAvl+rIn1hVjPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FtagFuZjurSSKldMvAxg8uj7q3pyslMmBrBHyzCqRoc=;
        b=QuVrhTLyAYkGeqYhOzNle2CQ9J/toYeNykssH1hSolhhTDw7gwGX7XSDklFZYDT+XF
         D2+Unwt7SRUfhS26J1BRnceHv+r00SiNz/YIOaw2xJVE11et+A+dAY0u7tMv2hl9B2B+
         QxWh/sdvcvVneyBLmiv0RVvo0L2+FwaVyVF5rFk1IVjO/eHAb2cJePe0mjshFD/jQ1EY
         QeNGI8oyAijkG8tdVbcecAPwqa3U9SuthdZDVW/WMWDnLL+tNH2VwfRiWAX1Skw6r3FP
         uVhZU5+cZSwSxHP3CS/DSi02Z51yvDzc3sIm1RxEVl7mlHSdKCEUUU2HG3cGjObwpYq6
         8JJQ==
X-Gm-Message-State: APzg51CHeKdKWsVX9V9k6hazzmmTVpaEv9caxtQutWfZTQfkT8m7PIJi
        UE5OV9QftsBVwzStPi7hN6YdBw==
X-Google-Smtp-Source: ANB0VdZ/r1M6rFwlsbvcJmzCk1hVCKdTW7spsypclTfoxGYzZibzSEDsApefvr4VDS+0lHbK3v+dWg==
X-Received: by 2002:a17:902:9f90:: with SMTP id g16-v6mr5934687plq.34.1536290869497;
        Thu, 06 Sep 2018 20:27:49 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id y124-v6sm9388356pfg.63.2018.09.06.20.27.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Sep 2018 20:27:48 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     jacek.anaszewski@gmail.com, pavel@ucw.cz
Cc:     rteysseyre@gmail.com, bjorn.andersson@linaro.org,
        baolin.wang@linaro.org, broonie@kernel.org,
        linus.walleij@linaro.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 1/2] leds: core: Introduce LED pattern trigger
Date:   Fri,  7 Sep 2018 11:27:23 +0800
Message-Id: <7bad1bc0e3cac157d5f0eb407dae7cb85aaa875f.1536289650.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds one new led trigger that LED device can configure
the software or hardware pattern and trigger it.

Consumers can write 'pattern' file to enable the software pattern
which alters the brightness for the specified duration with one
software timer.

Moreover consumers can write 'hw_pattern' file to enable the hardware
pattern for some LED controllers which can autonomously control
brightness over time, according to some preprogrammed hardware
patterns.

Signed-off-by: Raphael Teysseyre <rteysseyre@gmail.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v10:
 - Change 'int' to 'u32' for delta_t field.

Changes from v9:
 - None.

Changes from v8:
 - None.

Changes from v7:
 - Move the SC27XX hardware patterns description into its own ABI file.

Changes from v6:
 - Improve commit message.
 - Optimize the description of the hw_pattern file.
 - Simplify some logics.

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
 .../ABI/testing/sysfs-class-led-trigger-pattern    |   38 +++
 drivers/leds/trigger/Kconfig                       |    7 +
 drivers/leds/trigger/Makefile                      |    1 +
 drivers/leds/trigger/ledtrig-pattern.c             |  337 ++++++++++++++++++++
 include/linux/leds.h                               |   16 +
 5 files changed, 399 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-led-trigger-pattern
 create mode 100644 drivers/leds/trigger/ledtrig-pattern.c

diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
new file mode 100644
index 0000000..8cc5099
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
@@ -0,0 +1,38 @@
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
+		supports autonomously controlling brightness over time, according
+		to some preprogrammed hardware patterns.
+
+		Since different LED hardware can have different semantics of
+		hardware patterns, each driver is expected to provide its own
+		description for the hardware patterns in their ABI documentation
+		file.
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
index 0000000..e7c9978
--- /dev/null
+++ b/drivers/leds/trigger/ledtrig-pattern.c
@@ -0,0 +1,337 @@
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
+	/* 0 means repeat indefinitely */
+	data->is_indefinite = !data->repeat;
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
+				   "%d %u ",
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
+	data->is_hw_pattern = hw_pattern;
+	data->npatterns = 0;
+
+	while (offset < count - 1 && data->npatterns < MAX_PATTERNS) {
+		cr = 0;
+		ccount = sscanf(buf + offset, "%d %u %n",
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
index 834683d..1bacc62 100644
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
+	u32 delta_t;
+	int brightness;
+};
+
 #endif		/* __LINUX_LEDS_H_INCLUDED */
-- 
1.7.9.5

