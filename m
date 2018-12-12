Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8DEC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF2D2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544613435;
	bh=7X57gYj61mvfiK0CRkwsdHSweASQ/9AsAqrMR/s5XEE=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nmd34MTzGH16ELz4iPNzly8GJxr3LC9Wjwj5dcmN3cYVD7ls1eOtJ2COpO2g9Bwpo
	 3aIPIUlf1Jf4LsNM2zEreYrQYTWhxwabDNBSvqPH6XTFkn4Gu4vxmDLm+gDEMz1NY9
	 jGXJd9u745M17IMfEQDz7CnRB54k2ALQ4WZ6rgyw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF2D2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbeLLLRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:17:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:44836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727319AbeLLLRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:17:02 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62AA720880;
        Wed, 12 Dec 2018 11:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544613422;
        bh=7X57gYj61mvfiK0CRkwsdHSweASQ/9AsAqrMR/s5XEE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lmP2Nf7Y2rexDFlLOuUNI6dLBRB2u4Up/sRSuabYOFnidZTx0Zlhi83Do1GVWKpbA
         VAKnVcLWJCyGhAY7lUaj21X6ur+uQ15qS+Nf2Vf68deNsyHhE8IN7EcW3HfsK7vsZr
         6vG7RSxEfraxExYIjNaAmAQpaSDLWWCJyMPUwrsY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] leds: trigger: oneshot: Add initialization from Device Tree
Date:   Wed, 12 Dec 2018 12:16:45 +0100
Message-Id: <1544613406-27026-5-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544613406-27026-1-git-send-email-krzk@kernel.org>
References: <1544613406-27026-1-git-send-email-krzk@kernel.org>
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

New patch in the series
---
 drivers/leds/trigger/ledtrig-oneshot.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-oneshot.c b/drivers/leds/trigger/ledtrig-oneshot.c
index 95c9be4b6e7e..4e73a1c17a40 100644
--- a/drivers/leds/trigger/ledtrig-oneshot.c
+++ b/drivers/leds/trigger/ledtrig-oneshot.c
@@ -130,6 +130,27 @@ static struct attribute *oneshot_trig_attrs[] = {
 };
 ATTRIBUTE_GROUPS(oneshot_trig);
 
+static void pattern_init(struct led_classdev *led_cdev)
+{
+	const char *pattern;
+	unsigned long delay_on, delay_off;
+
+	pattern = led_classdev_get_default_pattern(led_cdev);
+	if (!pattern) {
+		led_cdev->blink_delay_on = DEFAULT_DELAY;
+		led_cdev->blink_delay_off = DEFAULT_DELAY;
+		return;
+	}
+
+	if (sscanf(pattern, "%lu %lu", &delay_on, &delay_off) == 2) {
+		led_cdev->blink_delay_on = delay_on;
+		led_cdev->blink_delay_off = delay_off;
+	} else {
+		dev_warn(led_cdev->dev,
+			 "Invalid value for delays pattern\n");
+	}
+}
+
 static int oneshot_trig_activate(struct led_classdev *led_cdev)
 {
 	struct oneshot_trig_data *oneshot_data;
@@ -140,8 +161,14 @@ static int oneshot_trig_activate(struct led_classdev *led_cdev)
 
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

