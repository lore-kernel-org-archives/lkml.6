Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9E6C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 14:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D67D218AE
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 14:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546351704;
	bh=8sVKsRHlEkRLCPq5SXo0ugho6MWV2udlwhUS1zYdsDI=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OvSt82km/yj5kKPAtRrj89JA3dYxiCTV0CRCfDsZBBKRRou3oMIqHQgaE/pINHh4q
	 D+QteD4O9mWCJhOYxT2oXRXQZxBcnIo88U8h2/Vs31hPHzeDThtaPebk9KflAPVgK6
	 /nXElAa37x1LYwuMqHsf9GCtOw9DNl6i2gOonHnc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbfAAOIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 09:08:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:52942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbfAAOIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 09:08:21 -0500
Received: from localhost.localdomain (unknown [194.230.155.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1CB8218AE;
        Tue,  1 Jan 2019 14:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546351701;
        bh=8sVKsRHlEkRLCPq5SXo0ugho6MWV2udlwhUS1zYdsDI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=g/P3R5E2OQA0nCEPwGqUoA0Q5FkZAQLITIWm8uusiyYIxiOtusQ/QKnrlrNepC03D
         kVOmyDOuxzV2/ecGuR6yVV68ENhO3DeIv1SUM80F2OzVgGXJv3hG6v1IZjHTbtfOV4
         4LLQtncVT/H1DBjhBacCKhxiqelYMn0oe9gcWUZs=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Raphael Teysseyre <rteysseyre@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 5/5] leds: trigger: timer: Add initialization from Device Tree
Date:   Tue,  1 Jan 2019 15:07:17 +0100
Message-Id: <20190101140717.13564-6-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190101140717.13564-1-krzk@kernel.org>
References: <20190101140717.13564-1-krzk@kernel.org>
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
 drivers/leds/trigger/ledtrig-timer.c | 34 ++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/leds/trigger/ledtrig-timer.c b/drivers/leds/trigger/ledtrig-timer.c
index 7c14983781ee..3c253241cfa6 100644
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
+	pattern = led_classdev_get_default_pattern(led_cdev, &size);
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
2.17.1

