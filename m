Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E1DC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF9D20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544434238;
	bh=s0L2ctp383dyFhHV7ZVo1lYfPGGW+6kPPONxHu26wHs=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wk2H1MApZrJib+6wUjb4JnEvRpGSqj7fByNS4kLZg5ImWWOURZSBeVh+DRYmchK1l
	 wad6FenZIvtxqNFKwNJJTbP7/OJpyG0NVnXPd0NzIjS1NqcJSYfV/1vFLxoCc4uxN8
	 L71SUU3pArsWQgwkMvb5D6DAS5eEWXktm9h/TwLA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF9D20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbeLJJaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 04:30:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:51890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbeLJJaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 04:30:12 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2742720874;
        Mon, 10 Dec 2018 09:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544434211;
        bh=s0L2ctp383dyFhHV7ZVo1lYfPGGW+6kPPONxHu26wHs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=IwYZ/JK3Sy2ktaNRx/FmMqy2hsxS6Kp4oDZd+Q3aFF3ZSyEsCQIWxAt6In+Rmdzjx
         hIzWkrvXWqvTQz1MpR/MXcf8L3YYe9BnDZ5hRJYSF9F1WbnEZsqAxIqSb55lGEpJgO
         rDTCyvq7GshrWpsqX+A5XB0nNX73+An7pEIVogGg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] led: triggers: Add LED_INIT_DEFAULT_TRIGGER flag
Date:   Mon, 10 Dec 2018 10:29:58 +0100
Message-Id: <1544434201-14190-3-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544434201-14190-1-git-send-email-krzk@kernel.org>
References: <1544434201-14190-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacek Anaszewski <jacek.anaszewski@gmail.com>

Add the flag LED_INIT_DEFAULT_TRIGGER for indicating that trigger
being set is a default trigger for the LED class device, and
thus it should be initialized with settings provided in the fwnode.

Set the flag in the led_trigger_set_default(). It is expected to be
cleared in the activate() op of a trigger after trigger fwnode
initialization data is parsed and applied. This should happen only
once after LED class device registration, to allow leaving triggers
in the idle state on re-apply and let the users apply their own
settings without being interfered with the default ones.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/leds/led-triggers.c | 2 ++
 include/linux/leds.h        | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/leds/led-triggers.c b/drivers/leds/led-triggers.c
index 52b12e601ebe..9421222ca7a0 100644
--- a/drivers/leds/led-triggers.c
+++ b/drivers/leds/led-triggers.c
@@ -201,10 +201,12 @@ void led_trigger_set_default(struct led_classdev *led_cdev)
 	down_write(&led_cdev->trigger_lock);
 	list_for_each_entry(trig, &trigger_list, next_trig) {
 		if (!strcmp(led_cdev->default_trigger, trig->name)) {
+			led_cdev->flags |= LED_INIT_DEFAULT_TRIGGER;
 			led_trigger_set(led_cdev, trig);
 			break;
 		}
 	}
+
 	up_write(&led_cdev->trigger_lock);
 	up_read(&triggers_list_lock);
 }
diff --git a/include/linux/leds.h b/include/linux/leds.h
index 580cbaef789a..5263f87e1d2c 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -51,6 +51,7 @@ struct led_classdev {
 #define LED_PANIC_INDICATOR	BIT(20)
 #define LED_BRIGHT_HW_CHANGED	BIT(21)
 #define LED_RETAIN_AT_SHUTDOWN	BIT(22)
+#define LED_INIT_DEFAULT_TRIGGER BIT(23)
 
 	/* set_brightness_work / blink_timer flags, atomic, private. */
 	unsigned long		work_flags;
-- 
2.7.4

