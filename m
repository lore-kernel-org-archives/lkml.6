Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E90C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 05:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235D125453
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 05:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MPqwIwph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 235D125453
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751448AbeFYFEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 01:04:22 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46293 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751084AbeFYFEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 01:04:20 -0400
Received: by mail-pl0-f67.google.com with SMTP id 30-v6so6224297pld.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 22:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=sAXeFmYUgCL/4pfnvuUEpMiXSjTdNPix56iSIf02CTs=;
        b=MPqwIwph6SrBmdyJq0W19IjeFetRDAY7VkEzVFwvgO/w2FZ7BDMNU1MScVrHrutzdj
         Zb/9hRfGVqjvL9y9Gbek/AKIe8TNmNF0m5I1H7JjfK/7CJ2DXG7sWwQpdR7pcCWMmxWY
         9hYa6gS6em2HfyD3M/cHEN44PdRut+Q+bIU2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sAXeFmYUgCL/4pfnvuUEpMiXSjTdNPix56iSIf02CTs=;
        b=o52NY1eUPDbZScHtFS+WIRZzUJ8U3dkA28OmXN8SzgqVDlILxD95MYVCMIH5UH6swr
         va4Fe0qYN2UBfMUmFe9G6qkFRnljK2I5FdPHrsl7Es0HgC3KJWyjlK7PZQuMJHIvhIOH
         s5Fz4fcxq8VD7banoe4ObUHxIFlqrEqc9EjuBN3FmvYe7Ji5YuLIOGySwRZzJmlbllCK
         G4tEWuMrJd/OT9rh56QrPKETwSFXmGy2YfeikIKM1vBIps1uaG/xY/U02dzRj/zv5acJ
         Y/KkbsdRMsc57wFij//Eun2jt+kIe3Q9YDag5t0+6iDvrUX+D10ZqlGQMFcQvjduvUyg
         pAMA==
X-Gm-Message-State: APt69E3mTarAPVONCzpTVi6WKFIwBaEO07fUg8xKpbjfFs5EpWoddoET
        vcrpVRqouUZwUQIZwUDh+HCc1A==
X-Google-Smtp-Source: ADUXVKLD79ndjQkkro+PLWaliG2solu22y9VNVOXIUBlohdZ82nwsTZ9sFx71/oTlUUzv+lG7AjvOg==
X-Received: by 2002:a17:902:a416:: with SMTP id p22-v6mr10984906plq.228.1529903059788;
        Sun, 24 Jun 2018 22:04:19 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id x5-v6sm19444695pfh.67.2018.06.24.22.04.16
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Jun 2018 22:04:19 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     jacek.anaszewski@gmail.com, pavel@ucw.cz
Cc:     bjorn.andersson@linaro.org, baolin.wang@linaro.org,
        broonie@kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] leds: core: Introduce generic pattern interface
Date:   Mon, 25 Jun 2018 13:03:19 +0800
Message-Id: <046c0cf717cbdfd55dcdc2bb7463642734e2ca4c.1529902636.git.baolin.wang@linaro.org>
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

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Note: I removed the pattern repeat check and will get the repeat number by adding
one extra file named 'pattern_repeat' according to previous discussion.
---
 Documentation/ABI/testing/sysfs-class-led |   16 ++++
 drivers/leds/led-class.c                  |  127 +++++++++++++++++++++++++++++
 include/linux/leds.h                      |   19 +++++
 3 files changed, 162 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-led b/Documentation/ABI/testing/sysfs-class-led
index 5f67f7a..fe90a12 100644
--- a/Documentation/ABI/testing/sysfs-class-led
+++ b/Documentation/ABI/testing/sysfs-class-led
@@ -61,3 +61,19 @@ Description:
 		gpio and backlight triggers. In case of the backlight trigger,
 		it is useful when driving a LED which is intended to indicate
 		a device in a standby like state.
+
+What: /sys/class/leds/<led>/pattern
+Date: June 2018
+KernelVersion: 4.18
+Description:
+	Specify a pattern for the LED, for LED hardware that support
+	altering the brightness as a function of time.
+
+	The pattern is given by a series of tuples, of brightness and
+	duration (ms). The LED is expected to traverse the series and
+	each brightness value for the specified duration.
+
+	As LED hardware might have different capabilities and precision
+	the requested pattern might be slighly adjusted by the driver
+	and the resulting pattern of such operation should be returned
+	when this file is read.
diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index 3c7e348..5ebdd83 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -74,6 +74,131 @@ static ssize_t max_brightness_show(struct device *dev,
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
+	if (IS_ERR_OR_NULL(pattern))
+		return PTR_ERR(pattern);
+
+	for (i = 0; i < count; i++) {
+		n = snprintf(buf + offset, PAGE_SIZE - offset, "%d %d",
+			     pattern[i].brightness, pattern[i].delta_t);
+
+		if (offset + n >= PAGE_SIZE)
+			goto err_nospc;
+
+		offset += n;
+
+		if (i < count - 1)
+			buf[offset++] = ' ';
+	}
+
+	buf[offset++] = '\n';
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
+	s = sbegin = kstrndup(buf, size, GFP_KERNEL);
+	if (!s)
+		return -ENOMEM;
+
+	/* Trim trailing newline */
+	s[strcspn(s, "\n")] = '\0';
+
+	/* If the remaining string is empty, clear the pattern */
+	if (!s[0]) {
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
+	/* Parse out the brightness & delta_t touples and check for repeat */
+	while ((elem = strsep(&s, " ")) != NULL) {
+		ret = kstrtoul(elem, 10, &val);
+		if (ret)
+			goto out;
+
+		if (odd) {
+			pattern[len].brightness = val;
+		} else {
+			/* Ensure we don't have any delta_t == 0 */
+			if (!val) {
+				ret = -EINVAL;
+				goto out;
+			}
+
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
@@ -88,11 +213,13 @@ static ssize_t max_brightness_show(struct device *dev,
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

