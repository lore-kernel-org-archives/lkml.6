Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3558C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF48220821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544434229;
	bh=7yDzIj9V0XUetavI332s7ZdGIvjTxw6XgZQ1NofQ3m4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FFrzv3oel01MXcMu/EVa5g0z+2coDAmbBjiWG4saoPD5OTKJh42j3NxCgCkkiRbBS
	 eNdyHW/505LSANiZLktZKpC3oOa83i4Pq6ou20KLt7xaheaNRstBkuNQtJiITB/n61
	 CA2jYAy0DHeu0YFmgBHQdr4RsSaFd10mmqmp2v/Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF48220821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbeLJJa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 04:30:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:52006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbeLJJaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 04:30:18 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10E9920865;
        Mon, 10 Dec 2018 09:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544434217;
        bh=7yDzIj9V0XUetavI332s7ZdGIvjTxw6XgZQ1NofQ3m4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ANuKBUmIbOS/fo30wnh2TzHcVvuoUI6HAOgtlCNNVXPb7KNqc3aqnn8gZmcZqnWrH
         Tn4TtC5elyPIBEUF1y7SGOAFNUUsKP1+UZJap+Jh/lN6iTwXPiEPyoXIjnLaA48XcY
         GtGs4blk8q59stV6PbTIkT7WQOQd6tWPlRNI1om0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] leds: trigger: Add pattern initialization from Device Tree
Date:   Mon, 10 Dec 2018 10:30:01 +0100
Message-Id: <1544434201-14190-6-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544434201-14190-1-git-send-email-krzk@kernel.org>
References: <1544434201-14190-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow initialization of pattern used in pattern trigger from Device Tree
property.

This is especially useful for embedded systems where the pattern trigger
would be used to indicate the process of boot status in a nice,
user-friendly blinking way.  This initialization pattern will be used
till user-space is brought up and sets its own pattern, indicating the
boot status is for example finished.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/leds/trigger/ledtrig-pattern.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/ledtrig-pattern.c
index 1870cf87afe1..1e7672eba2b8 100644
--- a/drivers/leds/trigger/ledtrig-pattern.c
+++ b/drivers/leds/trigger/ledtrig-pattern.c
@@ -11,6 +11,7 @@
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/timer.h>
 
@@ -331,6 +332,28 @@ static const struct attribute_group *pattern_trig_groups[] = {
 	NULL,
 };
 
+static void pattern_init(struct led_classdev *led_cdev)
+{
+	struct device_node *np = dev_of_node(led_cdev->dev);
+	const char *pattern;
+	int err;
+
+	if (!np)
+		return;
+
+	if (of_property_read_string(np, "linux,trigger-pattern", &pattern))
+		return;
+
+	if (!strlen(pattern))
+		return;
+
+	err = pattern_trig_store_patterns(led_cdev, pattern, strlen(pattern),
+					  false);
+	if (err)
+		dev_warn(led_cdev->dev,
+			 "Pattern initialization failed with error %d\n", err);
+}
+
 static int pattern_trig_activate(struct led_classdev *led_cdev)
 {
 	struct pattern_trig_data *data;
@@ -354,6 +377,15 @@ static int pattern_trig_activate(struct led_classdev *led_cdev)
 	timer_setup(&data->timer, pattern_trig_timer_function, 0);
 	led_cdev->activated = true;
 
+	if (led_cdev->flags & LED_INIT_DEFAULT_TRIGGER) {
+		pattern_init(led_cdev);
+		/*
+		 * Mark as initialized even on pattern_init() error because
+		 * any consecutive call to it would produce the same error.
+		 */
+		led_cdev->flags &= ~LED_INIT_DEFAULT_TRIGGER;
+	}
+
 	return 0;
 }
 
-- 
2.7.4

