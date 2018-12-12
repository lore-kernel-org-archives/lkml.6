Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAC5C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F4B2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544613427;
	bh=1s5Ak26fE9e2ziHIIYK+PV6mDQcaRAYT7Jv/+kqyznA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=arNvNn40Ul9J7gZehAj7LlqU8Q7lixDlnkFv4y6DapAH6M3VxxneIrkA680KGl8AH
	 KYBQwtaCgOp17hG+egIBhYMxOeuHMOxD7CBIjyLc/uRnrI7iWx+on673f10RW/A4cy
	 umMBGeKM7hS7X/BYy/7+33x8f/G/s+DJlj+gufOs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F4B2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbeLLLRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:17:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:44850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbeLLLRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:17:04 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58B7220870;
        Wed, 12 Dec 2018 11:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544613423;
        bh=1s5Ak26fE9e2ziHIIYK+PV6mDQcaRAYT7Jv/+kqyznA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AHVufnK7dVVgUJ3+bF/u2wTC7mLlmFvWeZbjWK7HhxN1wT1OuvFwn1xo5M4fVIOeD
         hfdig+56b1H3CkTq7uGo5v8X/CGEUOGAi8ocx+sOaC3L3h1kDa+bgIcSAJa1j8N0lL
         2h9T/z1NpJkkdCXuo2r2geD576HU59MsMD7qvn88=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] leds: trigger: timer: Add initialization from Device Tree
Date:   Wed, 12 Dec 2018 12:16:46 +0100
Message-Id: <1544613406-27026-6-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544613406-27026-1-git-send-email-krzk@kernel.org>
References: <1544613406-27026-1-git-send-email-krzk@kernel.org>
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

New patch in the series
---
 drivers/leds/trigger/ledtrig-timer.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/leds/trigger/ledtrig-timer.c b/drivers/leds/trigger/ledtrig-timer.c
index 7c14983781ee..85a4b9fc3de0 100644
--- a/drivers/leds/trigger/ledtrig-timer.c
+++ b/drivers/leds/trigger/ledtrig-timer.c
@@ -77,8 +77,36 @@ static struct attribute *timer_trig_attrs[] = {
 };
 ATTRIBUTE_GROUPS(timer_trig);
 
+static void pattern_init(struct led_classdev *led_cdev)
+{
+	const char *pattern;
+	unsigned long delay_on, delay_off;
+
+	pattern = led_classdev_get_default_pattern(led_cdev);
+	if (!pattern)
+		return;
+
+	if (sscanf(pattern, "%lu %lu", &delay_on, &delay_off) == 2) {
+		led_blink_set(led_cdev, &delay_on, &delay_off);
+		led_cdev->blink_delay_on = delay_on;
+		led_cdev->blink_delay_off = delay_off;
+	} else {
+		dev_warn(led_cdev->dev,
+			 "Invalid value for delays pattern\n");
+	}
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

