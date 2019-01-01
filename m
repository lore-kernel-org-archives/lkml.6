Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B0EC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 14:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7618218CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 14:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546351700;
	bh=oIi/n7UoJcAqwxzT04+fUSFTzj8uh+GS8ACcoeCQkSw=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Axf0qQIDVvlsWLj7demZORrj5cgkF3Cy+zcZ8Nc6J3Nm7LGdTN1VI1I8M8GZu131d
	 46Do3Up2yyRTJZKx2b2dDkbCWR/+t/eZiXn/jwxU+XtbBPhGolluHPk1a/bvSaZRZ3
	 dbiWIeHEuWk6cT6N+LCOq+RGhR/fgYEb0Olm8Tno=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfAAOIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 09:08:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:52810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbfAAOIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 09:08:17 -0500
Received: from localhost.localdomain (unknown [194.230.155.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 183FC218AE;
        Tue,  1 Jan 2019 14:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546351696;
        bh=oIi/n7UoJcAqwxzT04+fUSFTzj8uh+GS8ACcoeCQkSw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dKSPBzyL1SwnpWOeAOfNpeifousQviTMY4OnnPq+Vm+LrgRgZs8FAOYaT/C72Ui0v
         DxEWt2kLx7BC3/eRHaHuW0phoiDWqo+y78ltQwvgL+SGtb5brqrB17JXieVc79eIKG
         Stn5GvuaCr2VvDPWLkY+xG2Qm4IxuomjXDHqeTpM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Raphael Teysseyre <rteysseyre@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 3/5] leds: trigger: pattern: Add pattern initialization from Device Tree
Date:   Tue,  1 Jan 2019 15:07:15 +0100
Message-Id: <20190101140717.13564-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190101140717.13564-1-krzk@kernel.org>
References: <20190101140717.13564-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow initialization of pattern used in pattern trigger from Device Tree
property.

This is especially useful for embedded systems where the pattern trigger
would be used to indicate the process of boot status in a nice,
user-friendly blinking way.  This initialization pattern will be used
till user-space is brought up and sets its own pattern, indicating the
boot status is for example finished.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/leds/trigger/ledtrig-pattern.c | 99 +++++++++++++++++++++-----
 1 file changed, 80 insertions(+), 19 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/ledtrig-pattern.c
index 1870cf87afe1..053e430d9dbb 100644
--- a/drivers/leds/trigger/ledtrig-pattern.c
+++ b/drivers/leds/trigger/ledtrig-pattern.c
@@ -220,22 +220,10 @@ static ssize_t pattern_trig_show_patterns(struct pattern_trig_data *data,
 	return count;
 }
 
-static ssize_t pattern_trig_store_patterns(struct led_classdev *led_cdev,
-					   const char *buf, size_t count,
-					   bool hw_pattern)
+static int pattern_trig_store_patterns_string(struct pattern_trig_data *data,
+					      const char *buf, size_t count)
 {
-	struct pattern_trig_data *data = led_cdev->trigger_data;
-	int ccount, cr, offset = 0, err = 0;
-
-	mutex_lock(&data->lock);
-
-	del_timer_sync(&data->timer);
-
-	if (data->is_hw_pattern)
-		led_cdev->pattern_clear(led_cdev);
-
-	data->is_hw_pattern = hw_pattern;
-	data->npatterns = 0;
+	int ccount, cr, offset = 0;
 
 	while (offset < count - 1 && data->npatterns < MAX_PATTERNS) {
 		cr = 0;
@@ -244,14 +232,54 @@ static ssize_t pattern_trig_store_patterns(struct led_classdev *led_cdev,
 				&data->patterns[data->npatterns].delta_t, &cr);
 		if (ccount != 2) {
 			data->npatterns = 0;
-			err = -EINVAL;
-			goto out;
+			return -EINVAL;
 		}
 
 		offset += cr;
 		data->npatterns++;
 	}
 
+	return 0;
+}
+
+static int pattern_trig_store_patterns_int(struct pattern_trig_data *data,
+					   const u32 *buf, size_t count)
+{
+	unsigned int i;
+
+	for (i = 0; i < count; i += 2) {
+		data->patterns[data->npatterns].brightness = buf[i];
+		data->patterns[data->npatterns].delta_t = buf[i + 1];
+		data->npatterns++;
+	}
+
+	return 0;
+}
+
+static ssize_t pattern_trig_store_patterns(struct led_classdev *led_cdev,
+					   const char *buf, const u32 *buf_int,
+					   size_t count, bool hw_pattern)
+{
+	struct pattern_trig_data *data = led_cdev->trigger_data;
+	int err = 0;
+
+	mutex_lock(&data->lock);
+
+	del_timer_sync(&data->timer);
+
+	if (data->is_hw_pattern)
+		led_cdev->pattern_clear(led_cdev);
+
+	data->is_hw_pattern = hw_pattern;
+	data->npatterns = 0;
+
+	if (buf)
+		err = pattern_trig_store_patterns_string(data, buf, count);
+	else
+		err = pattern_trig_store_patterns_int(data, buf_int, count);
+	if (err)
+		goto out;
+
 	err = pattern_trig_start_pattern(led_cdev);
 	if (err)
 		data->npatterns = 0;
@@ -275,7 +303,7 @@ static ssize_t pattern_store(struct device *dev, struct device_attribute *attr,
 {
 	struct led_classdev *led_cdev = dev_get_drvdata(dev);
 
-	return pattern_trig_store_patterns(led_cdev, buf, count, false);
+	return pattern_trig_store_patterns(led_cdev, buf, NULL, count, false);
 }
 
 static DEVICE_ATTR_RW(pattern);
@@ -295,7 +323,7 @@ static ssize_t hw_pattern_store(struct device *dev,
 {
 	struct led_classdev *led_cdev = dev_get_drvdata(dev);
 
-	return pattern_trig_store_patterns(led_cdev, buf, count, true);
+	return pattern_trig_store_patterns(led_cdev, buf, NULL, count, true);
 }
 
 static DEVICE_ATTR_RW(hw_pattern);
@@ -331,6 +359,30 @@ static const struct attribute_group *pattern_trig_groups[] = {
 	NULL,
 };
 
+static void pattern_init(struct led_classdev *led_cdev)
+{
+	unsigned int size = 0;
+	u32 *pattern;
+	int err;
+
+	pattern = led_classdev_get_default_pattern(led_cdev, &size);
+	if (!pattern)
+		return;
+
+	if (size % 2) {
+		dev_warn(led_cdev->dev, "Expected pattern of tuples\n");
+		goto out;
+	}
+
+	err = pattern_trig_store_patterns(led_cdev, NULL, pattern, size, false);
+	if (err < 0)
+		dev_warn(led_cdev->dev,
+			 "Pattern initialization failed with error %d\n", err);
+
+out:
+	kfree(pattern);
+}
+
 static int pattern_trig_activate(struct led_classdev *led_cdev)
 {
 	struct pattern_trig_data *data;
@@ -354,6 +406,15 @@ static int pattern_trig_activate(struct led_classdev *led_cdev)
 	timer_setup(&data->timer, pattern_trig_timer_function, 0);
 	led_cdev->activated = true;
 
+	if (led_cdev->flags & LED_INIT_DEFAULT_TRIGGER) {
+		pattern_init(led_cdev);
+		/*
+		 * Mark as initialized even on pattern_init() error because
+		 * any consecutive call to it would produce the same error.
+		 */
+		led_cdev->flags &= ~LED_INIT_DEFAULT_TRIGGER;
+	}
+
 	return 0;
 }
 
-- 
2.17.1

