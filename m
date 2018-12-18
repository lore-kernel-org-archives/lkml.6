Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BFAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2580620815
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545146880;
	bh=CZGpSCcG6ZFpobtM9nECS/q+T5L4TgxUTSWPLVKM2/Y=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pQN3tLdrXLEBAq67NlRgvDAB4BSvqrO1G7JBK88QcUMW1BOfhSgobD/iG0hJx8fyD
	 m72ME2ie9DOg8Q8J8Gk+BYa+c0wpmkATqC6b06a70mw5ohqI2yXg7vvx8waUTQiUzn
	 GWTd3+kcC3/ZiguF+G1iaM1Y55/+RWPL+b+oiPiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbeLRP1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:27:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:51210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbeLRP1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:27:47 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19B51218A3;
        Tue, 18 Dec 2018 15:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545146865;
        bh=CZGpSCcG6ZFpobtM9nECS/q+T5L4TgxUTSWPLVKM2/Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=EQYOLlKkJ96Ten3liaZoKKp30h8UWHx5o3qdI6E0uMhl53ACzkltVyzMN9FwmpSUp
         mZNx7GNdfLbKPYoM026crLuJ8aNtlaGYj2xB3DDy+2JjxNq8dzjK3gRjkrapqZs5kL
         0srMrJzg/pS0LXo5cPeHp13Cg0/e06dLyt0wBg58=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Raphael Teysseyre <rteysseyre@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 3/5] leds: trigger: pattern: Add pattern initialization from Device Tree
Date:   Tue, 18 Dec 2018 16:27:30 +0100
Message-Id: <1545146852-32207-4-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545146852-32207-1-git-send-email-krzk@kernel.org>
References: <1545146852-32207-1-git-send-email-krzk@kernel.org>
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
 drivers/leds/trigger/ledtrig-pattern.c | 99 +++++++++++++++++++++++++++-------
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
2.7.4

