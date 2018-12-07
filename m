Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F9FC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81935208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544186005;
	bh=s3qW6Iunl+Admk1Gb01ZlcoRcynr78+SXos/+Mwoc2o=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xhBRTr2VPAlkkb1S/l/8G52st9tMiKLJANEt+YHeoG4xWmwr+dgzDwRNWCuk4kMUQ
	 djMYnhd9tR7RA+VIoVEN7IbLmKuG3dsboZYGwP+RbU2Q4Ype+35SxXN949B+G6TFJi
	 lj0nAn8awcvLY2BfUnZlGIOEGkQXFaG2LGcZV81g=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81935208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbeLGMdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:33:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:34270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbeLGMdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 07:33:11 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DB3D208E7;
        Fri,  7 Dec 2018 12:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544185990;
        bh=s3qW6Iunl+Admk1Gb01ZlcoRcynr78+SXos/+Mwoc2o=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UzNa8RjP4KdT8eOgJyXYu4v9hrbuOFH3YpOe6uz79NFmvapdGKicIpQ7PF9Y/5Ldk
         S6vFyTRftzzJ1P5ZRM8GQwVHTCIYlsLAjtCSd00/qq52HG6H4eOLvCVaMbA0AvY9KZ
         fjd4Q06Orm+Gtq4ayOgFE0Le/hgXHdk0dSLX6M8I=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Raphael Teysseyre <rteysseyre@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] leds: trigger: Add pattern initialization from Device Tree
Date:   Fri,  7 Dec 2018 13:32:54 +0100
Message-Id: <1544185974-5932-4-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544185974-5932-1-git-send-email-krzk@kernel.org>
References: <1544185974-5932-1-git-send-email-krzk@kernel.org>
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
 drivers/leds/trigger/ledtrig-pattern.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/ledtrig-pattern.c
index 1870cf87afe1..96309d3bc43c 100644
--- a/drivers/leds/trigger/ledtrig-pattern.c
+++ b/drivers/leds/trigger/ledtrig-pattern.c
@@ -11,6 +11,7 @@
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/timer.h>
 
@@ -331,6 +332,21 @@ static const struct attribute_group *pattern_trig_groups[] = {
 	NULL,
 };
 
+static void pattern_init(struct led_classdev *led_cdev)
+{
+	struct device_node *np = dev_of_node(led_cdev->dev);
+	const char *pattern;
+
+	if (!np)
+		return;
+
+	if (!of_property_read_string(np, "linux,trigger-pattern", &pattern)) {
+		if (strlen(pattern))
+			pattern_trig_store_patterns(led_cdev, pattern,
+						    strlen(pattern), false);
+	}
+}
+
 static int pattern_trig_activate(struct led_classdev *led_cdev)
 {
 	struct pattern_trig_data *data;
@@ -354,6 +370,8 @@ static int pattern_trig_activate(struct led_classdev *led_cdev)
 	timer_setup(&data->timer, pattern_trig_timer_function, 0);
 	led_cdev->activated = true;
 
+	pattern_init(led_cdev);
+
 	return 0;
 }
 
-- 
2.7.4

