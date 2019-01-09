Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBC3C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1D5206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547045114;
	bh=+mANgzXSwGUuDuDQNe7HZHHIO0+7PRIXjGGM9jViXvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q4LEBxU2pJD22POoxX1JCztONu/L26AzlU9XU/l7RbcKb4Ele2nn3y8Yw6T2I426n
	 jvqNhXDnXSkXmYurLr0tvpzIMnmM66z3qVNsDTVd2uiFGNgWe8HLLOugWtWwiLLaJH
	 RcSS1U0Xn1q6Pvb+JZZTtLyKpER/JV29alY4fC54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731849AbfAIOpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:45:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:48378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731818AbfAIOpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:45:04 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F25121738;
        Wed,  9 Jan 2019 14:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547045103;
        bh=+mANgzXSwGUuDuDQNe7HZHHIO0+7PRIXjGGM9jViXvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ibiq8MEvmg1lJq8tM+NimdUeNqH2IqlcQYkzwZK15lZLbwtV7+DVEDKy/+QfvZD+n
         HcrzxO3Ypmtu5I2c8NBlCxR5O8MkoMShLtHLqSyJw1F0xljmSPT25k+vYqxGz55cFe
         4tblJnBkWtO6Q5+dYejF2rcCcS7eWYt69iv52A6o=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v7 4/5] leds: trigger: oneshot: Add initialization from Device Tree
Date:   Wed,  9 Jan 2019 15:44:48 +0100
Message-Id: <1547045089-19128-5-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547045089-19128-1-git-send-email-krzk@kernel.org>
References: <1547045089-19128-1-git-send-email-krzk@kernel.org>
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
index 95c9be4b6e7e..8808f0ad7339 100644
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
+	pattern = led_get_default_pattern(led_cdev, &size);
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

