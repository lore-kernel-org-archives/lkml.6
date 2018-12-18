Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A827CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7603A20815
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545146886;
	bh=z50sZyfl069LVptCYJ+yyHl9ILPpIlVtgKuZtx7M4Mg=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Svy2h7AM/5t91j9VGurPw4DJq/03Upiodu0qj1LXvuuCVarBUU9trLVAh5LT5SQUJ
	 WVKbozVrl6aoSWam0ci2T9AInPe82iuMWNFC1mCMj6NrZlk6FezAYvbnCTQJowfSNc
	 Hf/F7Tl/jz+dPXG4mcUL4QO65lyT6gDrnUgAYg3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbeLRP2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:28:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:51268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbeLRP1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:27:48 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35C5520815;
        Tue, 18 Dec 2018 15:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545146867;
        bh=z50sZyfl069LVptCYJ+yyHl9ILPpIlVtgKuZtx7M4Mg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=s7n/+5QxiVmeg1Q4gHMQhoKhWfGdnzhe/UzeW8rb5IVvrVOyQ0t19nWgRpoS8A3v7
         1ntkhSiLpg72y2Uq8SruRfpVDBEAeQjth1UPOzHiWD87sMw80CTatxcQDmU+AXLvJ+
         CnPbpQjW1Tu+L7rGBeOrNlclKEIQchr4AGPqTEwM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Raphael Teysseyre <rteysseyre@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 4/5] leds: trigger: oneshot: Add initialization from Device Tree
Date:   Tue, 18 Dec 2018 16:27:31 +0100
Message-Id: <1545146852-32207-5-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545146852-32207-1-git-send-email-krzk@kernel.org>
References: <1545146852-32207-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow initialization of delays used in oneshot trigger from Device
Tree property.

This is especially useful for embedded systems where the trigger might
be used early, before bringing up user-space.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/leds/trigger/ledtrig-oneshot.c | 38 ++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-oneshot.c b/drivers/leds/trigger/ledtrig-oneshot.c
index 95c9be4b6e7e..71baccc00f06 100644
--- a/drivers/leds/trigger/ledtrig-oneshot.c
+++ b/drivers/leds/trigger/ledtrig-oneshot.c
@@ -130,6 +130,34 @@ static struct attribute *oneshot_trig_attrs[] = {
 };
 ATTRIBUTE_GROUPS(oneshot_trig);
 
+static void pattern_init(struct led_classdev *led_cdev)
+{
+	u32 *pattern;
+	unsigned int size = 0;
+
+	pattern = led_classdev_get_default_pattern(led_cdev, &size);
+	if (!pattern)
+		goto out_default;
+
+	if (size != 2) {
+		dev_warn(led_cdev->dev,
+			 "Expected 2 but got %u values for delays pattern\n",
+			 size);
+		goto out_default;
+	}
+
+	led_cdev->blink_delay_on = pattern[0];
+	led_cdev->blink_delay_off = pattern[1];
+	kfree(pattern);
+
+	return;
+
+out_default:
+	kfree(pattern);
+	led_cdev->blink_delay_on = DEFAULT_DELAY;
+	led_cdev->blink_delay_off = DEFAULT_DELAY;
+}
+
 static int oneshot_trig_activate(struct led_classdev *led_cdev)
 {
 	struct oneshot_trig_data *oneshot_data;
@@ -140,8 +168,14 @@ static int oneshot_trig_activate(struct led_classdev *led_cdev)
 
 	led_set_trigger_data(led_cdev, oneshot_data);
 
-	led_cdev->blink_delay_on = DEFAULT_DELAY;
-	led_cdev->blink_delay_off = DEFAULT_DELAY;
+	if (led_cdev->flags & LED_INIT_DEFAULT_TRIGGER) {
+		pattern_init(led_cdev);
+		/*
+		 * Mark as initialized even on pattern_init() error because
+		 * any consecutive call to it would produce the same error.
+		 */
+		led_cdev->flags &= ~LED_INIT_DEFAULT_TRIGGER;
+	}
 
 	return 0;
 }
-- 
2.7.4

