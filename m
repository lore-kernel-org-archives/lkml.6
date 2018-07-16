Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA13ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3ED208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WksxxkjM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3ED208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbeGPLho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 07:37:44 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44333 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbeGPLho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 07:37:44 -0400
Received: by mail-pf0-f196.google.com with SMTP id k21-v6so1218623pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 04:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ICzV9qxVeY7tlybwwnBRqlnZ3pEe8EtG5FKFXsBr8PE=;
        b=WksxxkjMkZyjwH57XRF1sAxkyclS2Ymi0bMsdsM6Rjffu9MZbMbcvJw0HFzW7qysG9
         k1bSR2tJyN9at41TJwkViA6YWSp11oPLXczMtBmlfUMwnlwiinBRZJY3xcjh8rqygGYn
         ySst/ch0wCIb7Nf0rlZ2oehJ5y2Ln+hpVvqKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ICzV9qxVeY7tlybwwnBRqlnZ3pEe8EtG5FKFXsBr8PE=;
        b=X+/EjJsSvMoMUFYtwPFvgoxmriwEak3ItxtHELGZo9g2VwigsDItJs2Y3aZMY/q1GN
         COUj7hNyZwxSb3x2eb/PmQl+vI5ZMXI52MOvFKywQB9Oz+883ibT6b3CC4gH64HtyWxv
         saAP6aRfuvCjF4dA64h+oo8sXu54y41jaPOgbVg/3U0QsGrQ74hdfupVbym5Q6tbEFDn
         ARArPNzXGL5npB6P3qQJdms0I8SSpj55u1zM0Fb5RcAHFZR/saEySFz4xMyamXziPWhe
         qRaYv8pjaVSaC+xPK7WVQgMU9DDRY0Sjw3QmUrmUv5bNGkNgV4KyiXTCig9R3F5gh6tC
         E4sg==
X-Gm-Message-State: AOUpUlFQ0lrMBdxnOtkOVoajjvPGq+BG5J2St5NPKMM82b8By0kwEE/g
        3xRt3pfqKCCx7Lpb6BPhdWAlcQ==
X-Google-Smtp-Source: AAOMgpeeFN+gBlaxHm/C0Bkt4fMMj/z+FWx6sgseV/AgeWeTq3kq+4tbRpIrX9PVTrqKM/rFEyI0uA==
X-Received: by 2002:a63:1b5c:: with SMTP id b28-v6mr15562544pgm.204.1531739448389;
        Mon, 16 Jul 2018 04:10:48 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id w72-v6sm51286894pfa.26.2018.07.16.04.10.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jul 2018 04:10:47 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     jacek.anaszewski@gmail.com, pavel@ucw.cz
Cc:     baolin.wang@linaro.org, bjorn.andersson@linaro.org,
        david@lechnology.com, broonie@kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] leds: core: Introduce generic pattern interface
Date:   Mon, 16 Jul 2018 19:10:14 +0800
Message-Id: <05c235df7bbcc4b898e7b263bf38338d9c822005.1531711385.git.baolin.wang@linaro.org>
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
Changes from v4:
 - Fix some typos.
 - Check if pattern_clear() is initialized.

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
index 5f67f7a..a040fd0 100644
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
+		Writing non-empty string to this file will activate the pattern,
+		and empty string will disable the pattern.
diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index 3c7e348..5c6d2e9 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -74,6 +74,118 @@ static ssize_t max_brightness_show(struct device *dev,
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
@@ -88,11 +200,13 @@ static ssize_t max_brightness_show(struct device *dev,
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
@@ -256,6 +370,10 @@ int of_led_classdev_register(struct device *parent, struct device_node *np,
 	char name[LED_MAX_NAME_SIZE];
 	int ret;
 
+	if (led_cdev->pattern_set &&
+	    (!led_cdev->pattern_get || !led_cdev->pattern_clear))
+		return -EINVAL;
+
 	ret = led_classdev_next_name(led_cdev->name, name, sizeof(name));
 	if (ret < 0)
 		return ret;
diff --git a/include/linux/leds.h b/include/linux/leds.h
index b7e8255..5f1c751 100644
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

