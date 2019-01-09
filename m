Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297E2C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5EF206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547045111;
	bh=y3Yojy1kQ+otg+Hk+Q1N3iU/XnLq1/q/FnAB0oYxnjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BcJ3i8WCxfwDrMg0sl6bvPX0HIKOPJP24VcG825FH97t2OVk7WiSreX76DaKAhCUr
	 43NmFOBQnnaZE3lGxGzeWF6pyzhmxm5M/qOScN/RU2P1r97R+r1tNOcMYh3F+F3L8J
	 o5dry3YUcwDK4IVVcEh7MnUYl2xqFPvkMzVx37qc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731862AbfAIOpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:45:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:48412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731832AbfAIOpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:45:06 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53A09206BA;
        Wed,  9 Jan 2019 14:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547045105;
        bh=y3Yojy1kQ+otg+Hk+Q1N3iU/XnLq1/q/FnAB0oYxnjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rX4cO0rcQJwXS0dKpGBg2CyCHxX0/yanYRkdYhvJ82N7/QljaEhEHxjRDnkS9tAoP
         db0qYHhM3qPjfrIy1HdTPHFi6IeV0RihRvYTcEkSmf1G9L0rJnPx4dFHwPEjtnqO8U
         nl1qT1ubgPihEf3hARWWasarsfc04ES3n+8AJeeQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v7 5/5] leds: trigger: timer: Add initialization from Device Tree
Date:   Wed,  9 Jan 2019 15:44:49 +0100
Message-Id: <1547045089-19128-6-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547045089-19128-1-git-send-email-krzk@kernel.org>
References: <1547045089-19128-1-git-send-email-krzk@kernel.org>
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

