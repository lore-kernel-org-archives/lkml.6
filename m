Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B45EC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 05:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C51D27A60
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 05:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aWDKpYLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C51D27A60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753404AbeF2FEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 01:04:02 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36841 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751740AbeF2FEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 01:04:00 -0400
Received: by mail-pf0-f193.google.com with SMTP id u16-v6so3650935pfh.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 22:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=t74VJqRfQJYguZJiqO/bhZrwB44TL3f1SU93gGHRsZ4=;
        b=aWDKpYLamf57iFwqT6n3y0K/HawUqGtHy2R3hz7cLYmXhaxNCxwghPLY1spnXIQ0Lj
         VBPaYHAJYxyrnE2xlBVlui3c7M5rIyjLuguTOaTJTgVJoLvwOgJC4qWjJB40fw3uYs2E
         lxRE/NAHUxWsqBtQOnYN90rtNMAu39+6e6Tc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=t74VJqRfQJYguZJiqO/bhZrwB44TL3f1SU93gGHRsZ4=;
        b=maJpESaftneTX6Y2F67+4KqrBmODcevvQjpZR2wD0zqshAhArE24ChKWuDbEFrEReR
         FWnr1fGelDwHV9hN5m8KYD86IyaSNF1quv0n9uLs8cdK+IZlSCHWncNz8QLJow24jxJL
         58H94F+YXIKUxGS/n7EtkCI9rZDxBa69M3QOe27uPwvAEbLokVWBaSgTftv1zYGF4D/g
         IPZg/2FA3KptOgl9rFspxCYaEld2gF8GyHUxzZMQJtKd2/1dTPIKa2ZpYm0WU4a/MPyU
         HUjFgPZm1X5pd0fddQYRIn93nx3+OcVKVxSrw2/QO32BI/GEz136niEgQ1uNxW0FeaHg
         FHaA==
X-Gm-Message-State: APt69E2LcY9NtTUMgam8DGyKf9n629SzyetbPBt9oT9NeokVvAnadp4a
        oj7r3bkCznMSIrm9svNGe4hU+g==
X-Google-Smtp-Source: ADUXVKJfzk1sBrqW6YBOE33dH3UrcgtLfsVpSVHZSfaJFApqCfN8mUjg6SVLR3o8UJxFlkuLL9Skng==
X-Received: by 2002:a65:4841:: with SMTP id i1-v6mr11077689pgs.75.1530248639697;
        Thu, 28 Jun 2018 22:03:59 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id z10-v6sm12752359pgo.58.2018.06.28.22.03.57
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Jun 2018 22:03:59 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     jacek.anaszewski@gmail.com, pavel@ucw.cz
Cc:     bjorn.andersson@linaro.org, baolin.wang@linaro.org,
        broonie@kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] leds: core: Introduce generic pattern interface
Date:   Fri, 29 Jun 2018 13:03:00 +0800
Message-Id: <1665b877dc2f886a90a00e3ca3b7425372d99b6e.1530248085.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Some LED controllers have support for autonomously controlling
brightness over time, according to some preprogrammed pattern or
function.

This adds a new optional operator that LED class drivers can implement
if they support such functionality as well as a new device attribute to
configure the pattern for a given LED.

[Baolin Wang did some minor improvements.]

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v2:
 - Change kernel version to 4.19.
 - Force user to return error pointer if failed to issue pattern_get().
 - Use strstrip() to trim trailing newline.
 - Other optimization.

Changes from v1:
 - Add some comments suggested by Pavel.
 - Change 'delta_t' can be 0.

Note: I removed the pattern repeat check and will get the repeat number by adding
one extra file named 'pattern_repeat' according to previous discussion.
---
 Documentation/ABI/testing/sysfs-class-led |   17 +++++
 drivers/leds/led-class.c                  |  119 +++++++++++++++++++++++++++++
 include/linux/leds.h                      |   19 +++++
 3 files changed, 155 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-led b/Documentation/ABI/testing/sysfs-class-led
index 5f67f7a..e01ac55 100644
--- a/Documentation/ABI/testing/sysfs-class-led
+++ b/Documentation/ABI/testing/sysfs-class-led
@@ -61,3 +61,20 @@ Description:
 		gpio and backlight triggers. In case of the backlight trigger,
 		it is useful when driving a LED which is intended to indicate
 		a device in a standby like state.
+
+What: /sys/class/leds/<led>/pattern
+Date: June 2018
+KernelVersion: 4.19
+Description:
+	Specify a pattern for the LED, for LED hardware that support
+	altering the brightness as a function of time.
+
+	The pattern is given by a series of tuples, of brightness and
+	duration (ms). The LED is expected to traverse the series and
+	each brightness value for the specified duration. Duration of
+	0 means brightness should immediately change to new value.
+
+	As LED hardware might have different capabilities and precision
+	the requested pattern might be slighly adjusted by the driver
+	and the resulting pattern of such operation should be returned
+	when this file is read.
diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index 3c7e348..8a685a2 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -74,6 +74,123 @@ static ssize_t max_brightness_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(max_brightness);
 
+static ssize_t pattern_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+	struct led_pattern *pattern;
+	size_t offset = 0;
+	int count, n, i;
+
+	if (!led_cdev->pattern_get)
+		return -EOPNOTSUPP;
+
+	pattern = led_cdev->pattern_get(led_cdev, &count);
+	if (IS_ERR(pattern))
+		return PTR_ERR(pattern);
+
+	for (i = 0; i < count; i++) {
+		n = snprintf(buf + offset, PAGE_SIZE - offset, "%d %d ",
+			     pattern[i].brightness, pattern[i].delta_t);
+
+		if (offset + n >= PAGE_SIZE)
+			goto err_nospc;
+
+		offset += n;
+	}
+
+	buf[offset - 1] = '\n';
+
+	kfree(pattern);
+	return offset;
+
+err_nospc:
+	kfree(pattern);
+	return -ENOSPC;
+}
+
+static ssize_t pattern_store(struct device *dev,
+			     struct device_attribute *attr,
+			     const char *buf, size_t size)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+	struct led_pattern *pattern = NULL;
+	unsigned long val;
+	char *sbegin;
+	char *elem;
+	char *s;
+	int ret, len = 0;
+	bool odd = true;
+
+	sbegin = kstrndup(buf, size, GFP_KERNEL);
+	if (!sbegin)
+		return -ENOMEM;
+
+	/*
+	 * Trim trailing newline, if the remaining string is empty,
+	 * clear the pattern.
+	 */
+	s = strstrip(sbegin);
+	if (!*s) {
+		ret = led_cdev->pattern_clear(led_cdev);
+		goto out;
+	}
+
+	pattern = kcalloc(size, sizeof(*pattern), GFP_KERNEL);
+	if (!pattern) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* Parse out the brightness & delta_t touples */
+	while ((elem = strsep(&s, " ")) != NULL) {
+		ret = kstrtoul(elem, 10, &val);
+		if (ret)
+			goto out;
+
+		if (odd) {
+			pattern[len].brightness = val;
+		} else {
+			pattern[len].delta_t = val;
+			len++;
+		}
+
+		odd = !odd;
+	}
+
+	/*
+	 * Fail if we didn't find any data points or last data point was partial
+	 */
+	if (!len || !odd) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = led_cdev->pattern_set(led_cdev, pattern, len);
+
+out:
+	kfree(pattern);
+	kfree(sbegin);
+	return ret < 0 ? ret : size;
+}
+static DEVICE_ATTR_RW(pattern);
+
+static umode_t led_class_attrs_mode(struct kobject *kobj,
+				    struct attribute *attr, int index)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+
+	if (attr == &dev_attr_brightness.attr)
+		return attr->mode;
+	if (attr == &dev_attr_max_brightness.attr)
+		return attr->mode;
+	if (attr == &dev_attr_pattern.attr && led_cdev->pattern_set)
+		return attr->mode;
+
+	return 0;
+}
+
 #ifdef CONFIG_LEDS_TRIGGERS
 static DEVICE_ATTR(trigger, 0644, led_trigger_show, led_trigger_store);
 static struct attribute *led_trigger_attrs[] = {
@@ -88,11 +205,13 @@ static ssize_t max_brightness_show(struct device *dev,
 static struct attribute *led_class_attrs[] = {
 	&dev_attr_brightness.attr,
 	&dev_attr_max_brightness.attr,
+	&dev_attr_pattern.attr,
 	NULL,
 };
 
 static const struct attribute_group led_group = {
 	.attrs = led_class_attrs,
+	.is_visible = led_class_attrs_mode,
 };
 
 static const struct attribute_group *led_groups[] = {
diff --git a/include/linux/leds.h b/include/linux/leds.h
index b7e8255..acdbb2f 100644
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
+			   struct led_pattern *pattern, int len);
+
+	int (*pattern_clear)(struct led_classdev *led_cdev);
+
+	struct led_pattern *(*pattern_get)(struct led_classdev *led_cdev,
+					   int *len);
+
 	struct device		*dev;
 	const struct attribute_group	**groups;
 
@@ -446,4 +455,14 @@ static inline void led_classdev_notify_brightness_hw_changed(
 	struct led_classdev *led_cdev, enum led_brightness brightness) { }
 #endif
 
+/**
+ * struct led_pattern - brigheness value in a pattern
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

