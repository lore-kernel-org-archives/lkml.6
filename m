Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C561EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6597220840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M6MUD1l0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6597220840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388866AbeHAKrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:47:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46156 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388774AbeHAKri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:47:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id p23-v6so10487349pgv.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 02:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZMfHpQt40bPMi4KcEnGNBhwRI8G7VtYqDvJf7z8q7PI=;
        b=M6MUD1l0rwjUaSg0cqGo+pyTjOEEL9P2LNyA3fF6vt1VExEIMHOJbHeJirXaJG8tbV
         /UrSf+0eXsXl+Dw+/JT6151yaHBLV2zPyCcTxafb/4Nki5sngvNkeIr7dTflr8Kg+p/e
         Z0hHFWgQyBd5COIaZBGDZhm6yDMvr+fskZJG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZMfHpQt40bPMi4KcEnGNBhwRI8G7VtYqDvJf7z8q7PI=;
        b=t6umdkQgCIrupsqGWnLrYrXNhVhAJYziQBNNcMqWO9pvRR6n/Hy9QSIcZqQ5sWXU/i
         tuuSOCJQp0+xsLflD8UInoHfbltaIILCt/ky8lqg1PP8q63sgwS0lDfRtBT571nosAbv
         GqXqlGfL+BGk3iVn6ENYhsPYH/yDKH8Jo3feXJUOJg3FBMeMyvd2ydpv13QFMj/ToyKh
         NEOvdrNOviCra3tiUZ2he/G/bCsmK/+OV9vg+Lbqf9pmnnYNDq0H9uAp1ws4V378Yk1F
         8MEMF2Ny25B9QFJyrIx9CznvbIj2t0XWB6OigHqTbc//7lD1kYpEsd/8MIvBKwFvdKwf
         CCOg==
X-Gm-Message-State: AOUpUlHJGYMpIucLYMHUVTlnceIjQkZbf19yhLdaRmq6Aviepivfu5/J
        sHrT4A2PCECOtotSHkwyrcLStg==
X-Google-Smtp-Source: AAOMgpf7aksWxEJTKfBWmUnCN3Tj9MQ9iinwUIoqXAoe2NCwAb2tuXGhzOrwNMx26Q20tH/izMASyg==
X-Received: by 2002:a62:a3d1:: with SMTP id q78-v6mr25669201pfl.5.1533114173632;
        Wed, 01 Aug 2018 02:02:53 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id f90-v6sm7215590pfh.168.2018.08.01.02.02.50
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 02:02:52 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     jacek.anaszewski@gmail.com, pavel@ucw.cz
Cc:     rteysseyre@gmail.com, bjorn.andersson@linaro.org,
        david@lechnology.com, baolin.wang@linaro.org, broonie@kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] leds: core: Introduce LED pattern trigger
Date:   Wed,  1 Aug 2018 17:01:42 +0800
Message-Id: <1bf9aed83d1756dd4f81590297ce7e0b9972bf85.1533112637.git.baolin.wang@linaro.org>
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
Changes from v1:
 - Use ATTRIBUTE_GROUPS() to define attributes.
 - Introduce hardware_pattern flag to determine if software pattern
 or hardware pattern.
 - Re-implement pattern_trig_store_pattern() function.
 - Remove pattern_get() interface.
 - Improve comments.
 - Other small optimization.
---
 .../ABI/testing/sysfs-class-led-trigger-pattern    |   21 ++
 drivers/leds/trigger/Kconfig                       |    7 +
 drivers/leds/trigger/Makefile                      |    1 +
 drivers/leds/trigger/ledtrig-pattern.c             |  273 ++++++++++++++++++++
 include/linux/leds.h                               |   16 ++
 5 files changed, 318 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-led-trigger-pattern
 create mode 100644 drivers/leds/trigger/ledtrig-pattern.c

diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
new file mode 100644
index 0000000..f9a4ac0
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
+		duration_3 ...".
+
+What:		/sys/class/leds/<led>/repeat
+Date:		August 2018
+KernelVersion:	4.19
+Description:
+		Specify a pattern repeat number. 0 means repeat indefinitely.
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
index 0000000..006874b
--- /dev/null
+++ b/drivers/leds/trigger/ledtrig-pattern.c
@@ -0,0 +1,273 @@
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
+#define PATTERN_SEPARATOR	","
+
+struct pattern_trig_data {
+	struct led_classdev *led_cdev;
+	struct led_pattern patterns[MAX_PATTERNS];
+	struct led_pattern *curr;
+	struct led_pattern *next;
+	struct mutex lock;
+	u32 npatterns;
+	u32 repeat;
+	bool is_indefinite;
+	bool hardware_pattern;
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
+				      struct led_classdev *led_cdev)
+{
+	if (!data->npatterns)
+		return 0;
+
+	if (data->hardware_pattern) {
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
+	u32 repeat;
+
+	mutex_lock(&data->lock);
+
+	repeat = data->repeat;
+
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
+	if (!data->hardware_pattern)
+		del_timer_sync(&data->timer);
+
+	mutex_lock(&data->lock);
+
+	data->repeat = res;
+
+	/* 0 means repeat indefinitely */
+	if (!data->repeat)
+		data->is_indefinite = true;
+	else
+		data->is_indefinite = false;
+
+	err = pattern_trig_start_pattern(data, led_cdev);
+
+	mutex_unlock(&data->lock);
+	return err < 0 ? err : count;;
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
+	int i;
+
+	mutex_lock(&data->lock);
+
+	if (!data->npatterns)
+		goto out;
+
+	for (i = 0; i < data->npatterns; i++) {
+		count += scnprintf(buf + count, PAGE_SIZE - count,
+				   "%d %d" PATTERN_SEPARATOR,
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
+static ssize_t pattern_trig_store_pattern(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+	struct pattern_trig_data *data = led_cdev->trigger_data;
+	int cr, ccount, offset = 0, err = 0;
+
+	if (!data->hardware_pattern)
+		del_timer_sync(&data->timer);
+
+	mutex_lock(&data->lock);
+
+	data->npatterns = 0;
+	while (offset < count - 1 && data->npatterns < MAX_PATTERNS) {
+		cr = 0;
+		ccount = sscanf(buf + offset, "%d %d " PATTERN_SEPARATOR "%n",
+				&data->patterns[data->npatterns].brightness,
+				&data->patterns[data->npatterns].delta_t, &cr);
+		if (ccount != 2) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		offset += cr;
+		data->npatterns++;
+		/* end of pattern */
+		if (!cr)
+			break;
+	}
+
+	err = pattern_trig_start_pattern(data, led_cdev);
+
+out:
+	mutex_unlock(&data->lock);
+	return err < 0 ? err : count;
+}
+
+static DEVICE_ATTR(pattern, 0644, pattern_trig_show_pattern,
+		   pattern_trig_store_pattern);
+
+static struct attribute *pattern_trig_attrs[] = {
+	&dev_attr_pattern.attr,
+	&dev_attr_repeat.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(pattern_trig);
+
+static int pattern_trig_activate(struct led_classdev *led_cdev)
+{
+	struct pattern_trig_data *data;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	if (led_cdev->pattern_set && led_cdev->pattern_clear)
+		data->hardware_pattern = true;
+	else
+		data->hardware_pattern = false;
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
+	if (data->hardware_pattern)
+		led_cdev->pattern_clear(led_cdev);
+	else
+		del_timer_sync(&data->timer);
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
index 834683d..c54712c 100644
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
+			   unsigned repeat);
+	int (*pattern_clear)(struct led_classdev *led_cdev);
+
 	struct device		*dev;
 	const struct attribute_group	**groups;
 
@@ -472,4 +478,14 @@ static inline void led_classdev_notify_brightness_hw_changed(
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

