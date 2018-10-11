Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3E6C46464
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 04:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0AED2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 04:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="etigi0u3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0AED2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeJKLdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 07:33:33 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36061 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbeJKLdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 07:33:33 -0400
Received: by mail-pl1-f196.google.com with SMTP id y11-v6so3526680plt.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 21:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WjkIt5wKEa+7uuX4vrO6FVUvC7Tag7SLHHTsvIhIUKE=;
        b=etigi0u36pBRbL2xenfVhVPXpnZv6y+zU3+ATIe1sPLoHdGKA6kkwyMlioCi0XFUC3
         BOLE1inoTYte/aBz1aiKYeznNRZki0K+BasAPfok4D6bt80wcVeIQ1UO0TlFf0SNaiEw
         um4lt4t2tzhgGVmqX+qA8OEiGtdrjIXbK2J9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WjkIt5wKEa+7uuX4vrO6FVUvC7Tag7SLHHTsvIhIUKE=;
        b=UA2TKMCJMqxDfASoxpElTUne+YFuK6qdWZ6FSM/OMcyycTpWRxJu6olcSxPGN4Epxu
         u7dy0N/ZlteGVDIwdMqZDAmP10HO5GXLPlXmDuxG0EXAnsx8n+Bgqg/jnYyzh7fhXntt
         ccWUFhbDYGrWTJrVrTKcuLokaUq26ZpRnap57V80cXwc1lh0myJ2eqkTnKsid8/DgOgs
         KdyuhTiHyRZ7mA/UgK6rErfEVAeWCIN8Vx8Vc4MHCfbFcUj4FjoC9M06mEcCl5j2cZjy
         C6OZqOuhx2BnhkXKGSHIHOe1Zdnr7EC7RiTaJ4ZYken2Jhw7EAp81nP2plbopILYuuoj
         +SJA==
X-Gm-Message-State: ABuFfoh11lcsRiK/xKweO8LxQLTHJGntbXjeyAUWHDe+gdpvgN6rgPYc
        +VKb63ES4jkJNqGIfBFi9mmlqxA5PU+Hkw==
X-Google-Smtp-Source: ACcGV61niboK9w1lvt4CL8sFiCy8BmCssgF0TtBEmM0BUE0btiaxAbdFQx3c7/D27hMTSFtojyx+OA==
X-Received: by 2002:a17:902:8687:: with SMTP id g7-v6mr36557466plo.30.1539230892612;
        Wed, 10 Oct 2018 21:08:12 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id r22-v6sm66056714pfd.174.2018.10.10.21.08.08
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Oct 2018 21:08:11 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     jacek.anaszewski@gmail.com, pavel@ucw.cz
Cc:     rteysseyre@gmail.com, bjorn.andersson@linaro.org,
        baolin.wang@linaro.org, broonie@kernel.org,
        linus.walleij@linaro.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v15 1/2] leds: core: Introduce LED pattern trigger
Date:   Thu, 11 Oct 2018 12:07:14 +0800
Message-Id: <9794969ab8a5a6f62d8ac54cdebcaa3caedfc6d6.1539230481.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new led trigger that LED device can employ
software or hardware pattern engine.

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
Changes from v14:
 - Improve the commit message and ABI documentation.
 - Fix some coding style issues.
 - Do not limit the tuple's duration larger than 50 ms, and treat is
 as a a step change of brightness.

Changes from v13:
 - Add duration validation for gradual dimming.
 - Coding style optimization.

Changes from v12:
 - Add gradual dimming support for software pattern.

Changes from v11:
 - Change -1 means repeat indefinitely.

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
 .../ABI/testing/sysfs-class-led-trigger-pattern    |   82 ++++
 drivers/leds/trigger/Kconfig                       |    7 +
 drivers/leds/trigger/Makefile                      |    1 +
 drivers/leds/trigger/ledtrig-pattern.c             |  411 ++++++++++++++++++++
 include/linux/leds.h                               |   15 +
 5 files changed, 516 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-led-trigger-pattern
 create mode 100644 drivers/leds/trigger/ledtrig-pattern.c

diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
new file mode 100644
index 0000000..fb3d1e0
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
@@ -0,0 +1,82 @@
+What:		/sys/class/leds/<led>/pattern
+Date:		September 2018
+KernelVersion:	4.20
+Description:
+		Specify a software pattern for the LED, that supports altering
+		the brightness for the specified duration with one software
+		timer. It can do gradual dimming and step change of brightness.
+
+		The pattern is given by a series of tuples, of brightness and
+		duration (ms). The LED is expected to traverse the series and
+		each brightness value for the specified duration. Duration of
+		0 means brightness should immediately change to new value, and
+		writing malformed pattern deactivates any active one.
+
+		1. For gradual dimming, the dimming interval now is set as 50
+		milliseconds. So the tuple with duration less than dimming
+		interval (50ms) is treated as a step change of brightness,
+		i.e. the subsequent brightness will be applied without adding
+		intervening dimming intervals.
+
+		The gradual dimming format of the software pattern values should be:
+		"brightness_1 duration_1 brightness_2 duration_2 brightness_3
+		duration_3 ...". For example:
+
+		echo 0 1000 255 2000 > pattern
+
+		It will make the LED go gradually from zero-intensity to max (255)
+		intensity in 1000 milliseconds, then back to zero intensity in 2000
+		milliseconds:
+
+		LED brightness
+		    ^
+		255-|       / \            / \            /
+		    |      /    \         /    \         /
+		    |     /       \      /       \      /
+		    |    /          \   /          \   /
+		  0-|   /             \/             \/
+		    +---0----1----2----3----4----5----6------------> time (s)
+
+		2. To make the LED go instantly from one brigntess value to another,
+		we should use use zero-time lengths (the brightness must be same as
+		the previous tuple's). So the format should be:
+		"brightness_1 duration_1 brightness_1 0 brightness_2 duration_2
+		brightness_2 0 ...". For example:
+
+		echo 0 1000 0 0 255 2000 255 0 > pattern
+
+		It will make the LED stay off for one second, then stay at max brightness
+		for two seconds:
+
+		LED brightness
+		    ^
+		255-|        +---------+    +---------+
+		    |        |         |    |         |
+		    |        |         |    |         |
+		    |        |         |    |         |
+		  0-|   -----+         +----+         +----
+		    +---0----1----2----3----4----5----6------------> time (s)
+
+What:		/sys/class/leds/<led>/hw_pattern
+Date:		September 2018
+KernelVersion:	4.20
+Description:
+		Specify a hardware pattern for the LED, for LED hardware that
+		supports autonomously controlling brightness over time, according
+		to some preprogrammed hardware patterns. It deactivates any active
+		software pattern.
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
+		Specify a pattern repeat number. -1 means repeat indefinitely,
+		other negative numbers and number 0 are invalid.
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
index 0000000..ce7acd1
--- /dev/null
+++ b/drivers/leds/trigger/ledtrig-pattern.c
@@ -0,0 +1,411 @@
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
+/*
+ * When doing gradual dimming, the led brightness will be updated
+ * every 50 milliseconds.
+ */
+#define UPDATE_INTERVAL		50
+
+struct pattern_trig_data {
+	struct led_classdev *led_cdev;
+	struct led_pattern patterns[MAX_PATTERNS];
+	struct led_pattern *curr;
+	struct led_pattern *next;
+	struct mutex lock;
+	u32 npatterns;
+	int repeat;
+	int last_repeat;
+	int delta_t;
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
+
+	data->delta_t = 0;
+}
+
+static int pattern_trig_compute_brightness(struct pattern_trig_data *data)
+{
+	int step_brightness;
+
+	/*
+	 * If current tuple's duration is less than the dimming interval,
+	 * we should treat it as a step change of brightness instead of
+	 * doing gradual dimming.
+	 */
+	if (data->delta_t == 0 || data->curr->delta_t < UPDATE_INTERVAL)
+		return data->curr->brightness;
+
+	step_brightness = abs(data->next->brightness - data->curr->brightness);
+	step_brightness = data->delta_t * step_brightness / data->curr->delta_t;
+
+	if (data->next->brightness > data->curr->brightness)
+		return data->curr->brightness + step_brightness;
+	else
+		return data->curr->brightness - step_brightness;
+}
+
+static void pattern_trig_timer_function(struct timer_list *t)
+{
+	struct pattern_trig_data *data = from_timer(data, t, timer);
+
+	mutex_lock(&data->lock);
+
+	for (;;) {
+		if (!data->is_indefinite && !data->repeat)
+			break;
+
+		if (data->curr->brightness == data->next->brightness) {
+			/* Step change of brightness */
+			led_set_brightness(data->led_cdev,
+					   data->curr->brightness);
+			mod_timer(&data->timer,
+				  jiffies + msecs_to_jiffies(data->curr->delta_t));
+
+			/* Skip the tuple with zero duration */
+			pattern_trig_update_patterns(data);
+			/* Select next tuple */
+			pattern_trig_update_patterns(data);
+		} else {
+			/* Gradual dimming */
+
+			/*
+			 * If the accumulation time is larger than current
+			 * tuple's duration, we should go next one and re-check
+			 * if we repeated done.
+			 */
+			if (data->delta_t > data->curr->delta_t) {
+				pattern_trig_update_patterns(data);
+				continue;
+			}
+
+			led_set_brightness(data->led_cdev,
+					   pattern_trig_compute_brightness(data));
+			mod_timer(&data->timer,
+				  jiffies + msecs_to_jiffies(UPDATE_INTERVAL));
+
+			/* Accumulate the gradual dimming time */
+			data->delta_t += UPDATE_INTERVAL;
+		}
+
+		break;
+	}
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
+	/* At least 2 tuples for software pattern. */
+	if (data->npatterns < 2)
+		return -EINVAL;
+
+	data->delta_t = 0;
+	data->curr = data->patterns;
+	data->next = data->patterns + 1;
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
+	int repeat;
+
+	mutex_lock(&data->lock);
+
+	repeat = data->last_repeat;
+
+	mutex_unlock(&data->lock);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", repeat);
+}
+
+static ssize_t repeat_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+	struct pattern_trig_data *data = led_cdev->trigger_data;
+	int err, res;
+
+	err = kstrtos32(buf, 10, &res);
+	if (err)
+		return err;
+
+	/* Number 0 and negative numbers except -1 are invalid. */
+	if (res < -1 || res == 0)
+		return -EINVAL;
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
+	/* -1 means repeat indefinitely */
+	if (data->repeat == -1)
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
+	if (err)
+		data->npatterns = 0;
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
+	data->last_repeat = -1;
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
index 834683d..7393a31 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -22,6 +22,7 @@
 #include <linux/workqueue.h>
 
 struct device;
+struct led_pattern;
 /*
  * LED Core
  */
@@ -88,6 +89,10 @@ struct led_classdev {
 				     unsigned long *delay_on,
 				     unsigned long *delay_off);
 
+	int (*pattern_set)(struct led_classdev *led_cdev,
+			   struct led_pattern *pattern, u32 len, int repeat);
+	int (*pattern_clear)(struct led_classdev *led_cdev);
+
 	struct device		*dev;
 	const struct attribute_group	**groups;
 
@@ -472,4 +477,14 @@ static inline void led_classdev_notify_brightness_hw_changed(
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

