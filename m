Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A91C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 14:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD82218CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 14:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546351709;
	bh=1S44U5hZcDuVg3ULZXHMwE0FkvBYkLASRV7AGMhTldA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2XwvmuSb59j8jjP68t+x7E/DS5P0ZF/fOD6c/G1UpuIWiIcyKBwkNFXhYnVg6Pr/A
	 T0Hhwl3SOvdSlJ7NdASi5EL3LibykA4eom2fqjVJYrq4+7L7lHqT+DOL2oenzpoc7B
	 +dDwm9g/PrsBdZ9uTGwUfr/fOQ7Rgy5DT/DPvJyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfAAOI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 09:08:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:52878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728927AbfAAOIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 09:08:19 -0500
Received: from localhost.localdomain (unknown [194.230.155.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85049218CD;
        Tue,  1 Jan 2019 14:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546351698;
        bh=1S44U5hZcDuVg3ULZXHMwE0FkvBYkLASRV7AGMhTldA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=roJl9ZRtzQHGUCWC55oe0Q+WIoLDc8/bA77nTx35yjE2VIVg+rlHTaGPL8kOCGhr4
         oHFiiro/wn+v5w+v9Z+6LaWko1fEtwY7kUQvv6ipC8EqY6GUc4OHV30VXYU/c1LG8/
         CZndwVx6zmyfpZ6CwGQSyqLoE3B3hbBYylsytCqU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Raphael Teysseyre <rteysseyre@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 4/5] leds: trigger: oneshot: Add initialization from Device Tree
Date:   Tue,  1 Jan 2019 15:07:16 +0100
Message-Id: <20190101140717.13564-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190101140717.13564-1-krzk@kernel.org>
References: <20190101140717.13564-1-krzk@kernel.org>
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
 drivers/leds/trigger/ledtrig-oneshot.c | 38 ++++++++++++++++++++++++--
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
2.17.1

