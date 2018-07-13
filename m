Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F103ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C222420843
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hMeb/smE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C222420843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbeGMGeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 02:34:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40281 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbeGMGeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 02:34:50 -0400
Received: by mail-pg1-f196.google.com with SMTP id x5-v6so4656888pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 23:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+0G0cm319x/IzAoVqzdxV4FsrRaG8wFCZDpe3isoq5Q=;
        b=hMeb/smEk0Ve8P3T8L7kMW7+JJThv2lBs3WZ0cD7nRdTrLATWTHxk9C8U/fdfJqSlH
         clvPKdJ3iO4IvO67lMtYLdUOPCscFLciwu4Y0Qt74kuW9Fhb9PFZAcuvSYL5gFzYmZol
         wcAUMgRoLSb+Hm9qg3l1PIXxyp6BnXwvJduL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+0G0cm319x/IzAoVqzdxV4FsrRaG8wFCZDpe3isoq5Q=;
        b=oQA7M0IHiu61I6HfMCjsCmyLI8dwv7V7y08sSZ+x0XzHMp2MhuoFyHKUMSXdAAnqgE
         YCXLhitEo7h8uH5SQL2z8B0oMY7ch1MDY7NgoLW5wnhoRwCYqQz1JwN6Wuj34D8mfMBq
         NX0rwif4DIE5qYXGESeiJo0QERLVz3Tk59aY8fJC8+9YKWL5WJ4i1qPoz5PYNbmrhI0O
         hK1lcc0Y6VgEsSOqv9OVXOG6uOpSK6ipTNMeuqnOXHti+ycLpwRhXSetUjOMGWZlH7Vy
         NlpCqyoMltqHzWtjD3xIWAiEZuTOFRoc4BSynHoivmkCQkfNne7O13DerzR+aiz6zdvA
         k0jQ==
X-Gm-Message-State: AOUpUlExrdcL3IOzJrf5x+f2wq6lJe0FgjTEBmJ4GbAmhcwmTohHVeb8
        UZLQEjfv2rmgWJglai+ji4vIjQ==
X-Google-Smtp-Source: AAOMgpcMtyrFJ555Ay+TyIGoejVBTu6roWyQ7YZPe1DUrc+qfXb1zytLx3khGnTcG1/k30x7FglZHg==
X-Received: by 2002:a63:6188:: with SMTP id v130-v6mr4861822pgb.100.1531462902355;
        Thu, 12 Jul 2018 23:21:42 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id r16-v6sm46006878pfe.173.2018.07.12.23.21.40
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jul 2018 23:21:41 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     jacek.anaszewski@gmail.com, pavel@ucw.cz
Cc:     baolin.wang@linaro.org, bjorn.andersson@linaro.org,
        broonie@kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] leds: core: Introduce generic pattern interface
Date:   Fri, 13 Jul 2018 14:21:13 +0800
Message-Id: <a0b874372f9ccd0491b54c79ac63b41812efef56.1531460834.git.baolin.wang@linaro.org>
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

[Baolin Wang did some improvements.]

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v3:
 - Move the check in pattern_show() to of_led_classdev_register().
 - Add more documentation to explain how to set/clear one pattern.

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
 Documentation/ABI/testing/sysfs-class-led |   20 +++++
 drivers/leds/led-class.c                  |  118 +++++++++++++++++++++++++++++
 include/linux/leds.h                      |   19 +++++
 3 files changed, 157 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-led b/Documentation/ABI/testing/sysfs-class-led
index 5f67f7a..f4b73ad 100644
--- a/Documentation/ABI/testing/sysfs-class-led
+++ b/Documentation/ABI/testing/sysfs-class-led
@@ -61,3 +61,23 @@ Description:
 		gpio and backlight triggers. In case of the backlight trigger,
 		it is useful when driving a LED which is intended to indicate
 		a device in a standby like state.
+
+What: /sys/class/leds/<led>/pattern
+Date:		July 2018
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
+		As LED hardware might have different capabilities and precision
+		the requested pattern might be slighly adjusted by the driver
+		and the resulting pattern of such operation should be returned
+		when this file is read.
+
+		Writing non-empty string to this file will active the pattern,
+		and empty string will disable the pattern.
diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index 3c7e348..0992a0e 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -74,6 +74,119 @@ static ssize_t max_brightness_show(struct device *dev,
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
+	char *sbegin, *elem, *s;
+	unsigned long val;
+	int ret = 0, len = 0;
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
+		if (led_cdev->pattern_clear)
+			ret = led_cdev->pattern_clear(led_cdev);
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
@@ -88,11 +201,13 @@ static ssize_t max_brightness_show(struct device *dev,
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
@@ -256,6 +371,9 @@ int of_led_classdev_register(struct device *parent, struct device_node *np,
 	char name[LED_MAX_NAME_SIZE];
 	int ret;
 
+	if (led_cdev->pattern_set && !led_cdev->pattern_get)
+		return -EINVAL;
+
 	ret = led_classdev_next_name(led_cdev->name, name, sizeof(name));
 	if (ret < 0)
 		return ret;
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

