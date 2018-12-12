Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A243CC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689ED208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544613420;
	bh=n0NjEr5wJkGnkMNVdIVIZRq92qjqd9CfF2+fzhCuWQs=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y+hpLDgaAoAfoO7xeONcO5ZwZkxWfuj75GRqsVAM6O1GrHOf/wjHfCl0KNdhpb9Yc
	 KnWEg/HYNcpBL+IOE+tXHazzBb/RJilBkkE13FNpGGoPzVqNWcKcxFpGHoxW1Y2vGk
	 nGOQqO+o7P/T/IdSdXhg/ZUsbiJQtV/gSZvy8+dQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 689ED208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbeLLLQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:16:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:44708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbeLLLQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:16:57 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E7652087F;
        Wed, 12 Dec 2018 11:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544613416;
        bh=n0NjEr5wJkGnkMNVdIVIZRq92qjqd9CfF2+fzhCuWQs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SnRf8Ej6KC6cTciqMWHNvUOb22bCwrO6GBUkIelAd9d6QYgHN28TBGlJNI+Cb2bwE
         PLNZDzEa6XSxchat7N6L7o4SVrHM4fNRwVUzmh69HaorlLS7WuExklfukI3VDQHxQF
         ix1ptySdAkSPyf0vofBeTu9i4T39Rp4OzLVd6qNw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] dt-bindings: leds: Add pattern initialization from Device Tree
Date:   Wed, 12 Dec 2018 12:16:42 +0100
Message-Id: <1544613406-27026-2-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544613406-27026-1-git-send-email-krzk@kernel.org>
References: <1544613406-27026-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document new linux,trigger-pattern property for initialization of LED
pattern trigger.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/leds/common.txt | 36 +++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
index aa1399814a2a..3daccd4ea8a3 100644
--- a/Documentation/devicetree/bindings/leds/common.txt
+++ b/Documentation/devicetree/bindings/leds/common.txt
@@ -37,6 +37,42 @@ Optional properties for child nodes:
      "ide-disk" - LED indicates IDE disk activity (deprecated),
                   in new implementations use "disk-activity"
      "timer" - LED flashes at a fixed, configurable rate
+     "pattern" - LED alters the brightness for the specified duration with one
+                 software timer (requires "led-pattern" property)
+
+- led-pattern : String with default pattern for certain triggers. Each trigger
+                may parse this string differently:
+                - one-shot : two numbers specifying delay on and delay off,
+                - timer : two numbers specifying delay on and delay off,
+                - pattern : The pattern is given by a series of tuples, of
+                  brightness and duration (ms).  The LED is expected to traverse
+                  the series and each brightness value for the specified
+                  duration.  Duration of 0 means brightness should immediately
+                  change to new value.
+
+                  1. For gradual dimming, the dimming interval now is set as 50
+                  milliseconds. So the tuple with duration less than dimming
+                  interval (50ms) is treated as a step change of brightness,
+                  i.e. the subsequent brightness will be applied without adding
+                  intervening dimming intervals.
+
+                  The gradual dimming format of the software pattern values should be:
+                  "brightness_1 duration_1 brightness_2 duration_2 brightness_3
+                  duration_3 ...".
+                  For example "0 1000 255 2000" will make the LED go gradually
+                  from zero-intensity to max (255) intensity in 1000
+                  milliseconds, then back to zero intensity in 2000
+                  milliseconds.
+
+                  2. To make the LED go instantly from one brightness value to
+                  another, pattern should use zero-time lengths (the brightness
+                  must be same as the previous tuple's). So the format should be:
+                  "brightness_1 duration_1 brightness_1 0 brightness_2
+                  duration_2 brightness_2 0 ...".
+                  For example "0 1000 0 0 255 2000 255 0" will make the LED
+                  stay off for one second, then stay at max brightness for two
+                  seconds.
+
 
 - led-max-microamp : Maximum LED supply current in microamperes. This property
                      can be made mandatory for the board configurations
-- 
2.7.4

