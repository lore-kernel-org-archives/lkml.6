Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E26C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2204521874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546596567;
	bh=y3Yojy1kQ+otg+Hk+Q1N3iU/XnLq1/q/FnAB0oYxnjo=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uTzPPPk9lgOIcWcEVX3Wn/M6rXiH7uc3PP2B6TCZvi9i5b4Oa2S6T4hYsgBZNgqBX
	 UzPdDgny7zWhGbeY9B0/xS3dJYAYwacjYCfqN3lF15L0QwAmcwAwpuJ4XlM9m3PYMq
	 B1o9p6z117WISXPc2apGyMfJl+y2Mcc0k4fFdqqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfADKJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 05:09:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:57438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727993AbfADKJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 05:09:17 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DB49218CD;
        Fri,  4 Jan 2019 10:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546596556;
        bh=y3Yojy1kQ+otg+Hk+Q1N3iU/XnLq1/q/FnAB0oYxnjo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=vPGEyOuULHXm7FLt4TEW1dnhza2ql1/1P9oBksXAKKvResLPmNzM9TMm33/t2jjM7
         BgM94uLNlNXdxG1EmiKKMb2oNg8uFrsU+m0v2oue6ZAVSSpS09Tx+ZRacP9RhuK1GO
         YnXk0dy6pvfaHyNbTZXpaJzHpsvUPbWTtSUfbA7E=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v6 5/5] leds: trigger: timer: Add initialization from Device Tree
Date:   Fri,  4 Jan 2019 11:08:44 +0100
Message-Id: <1546596524-19863-6-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546596524-19863-1-git-send-email-krzk@kernel.org>
References: <1546596524-19863-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow initialization of delays used in timer trigger from Device
Tree property.

This is especially useful for embedded systems where the trigger might
be used early, before bringing up user-space.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/leds/trigger/ledtrig-timer.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/leds/trigger/ledtrig-timer.c b/drivers/leds/trigger/ledtrig-timer.c
index 7c14983781ee..ca898c1383be 100644
--- a/drivers/leds/trigger/ledtrig-timer.c
+++ b/drivers/leds/trigger/ledtrig-timer.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/ctype.h>
+#include <linux/slab.h>
 #include <linux/leds.h>
 
 static ssize_t led_delay_on_show(struct device *dev,
@@ -77,8 +78,41 @@ static struct attribute *timer_trig_attrs[] = {
 };
 ATTRIBUTE_GROUPS(timer_trig);
 
+static void pattern_init(struct led_classdev *led_cdev)
+{
+	u32 *pattern;
+	unsigned int size = 0;
+
+	pattern = led_get_default_pattern(led_cdev, &size);
+	if (!pattern)
+		return;
+
+	if (size != 2) {
+		dev_warn(led_cdev->dev,
+			 "Expected 2 but got %u values for delays pattern\n",
+			 size);
+		goto out;
+	}
+
+	led_cdev->blink_delay_on = pattern[0];
+	led_cdev->blink_delay_off = pattern[1];
+	/* led_blink_set() called by caller */
+
+out:
+	kfree(pattern);
+}
+
 static int timer_trig_activate(struct led_classdev *led_cdev)
 {
+	if (led_cdev->flags & LED_INIT_DEFAULT_TRIGGER) {
+		pattern_init(led_cdev);
+		/*
+		 * Mark as initialized even on pattern_init() error because
+		 * any consecutive call to it would produce the same error.
+		 */
+		led_cdev->flags &= ~LED_INIT_DEFAULT_TRIGGER;
+	}
+
 	led_blink_set(led_cdev, &led_cdev->blink_delay_on,
 		      &led_cdev->blink_delay_off);
 
-- 
2.7.4

