Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DB8C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C168A20870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544613442;
	bh=7xHCYizesvYnu/KL2SjvuSvfNjnDIK5ROI9TpnBylj4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TaYOPzwGa+/X5Ijs1pWmNBIqgQPFslKv/N+EBN9rzExD7duCHQaCW2AdGlne4QLXS
	 gZL5PU3E6PtQZjKHdROHxM/OrzfxoTOi/rAJRVZJ1D+Bi0nnj+IAevnCTsAGuPHVmJ
	 r6ED6XXfSQd41h2kGeGpyh8k6FJ7nXosWSUNNrJw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C168A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbeLLLRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:17:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:44764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727276AbeLLLQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:16:58 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74C4620870;
        Wed, 12 Dec 2018 11:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544613418;
        bh=7xHCYizesvYnu/KL2SjvuSvfNjnDIK5ROI9TpnBylj4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZzaxuoQuOgLg82tHGmXVegKS+AIMPDM2LJi6X5sNuc8m/JW/gmAScsJlbroZ2jBdZ
         jAjgIN5HgEIxFQ+uwJvBaYvJBB60Rv7uc0/Ya7sxDVIEvQO4xcZWaXGFmCXrzNUrSg
         WkTwMGe0H6pECYl7Ghigp4uVV6M7GeyKvZj1dRvE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] leds: Add helper for getting default pattern from Device Tree
Date:   Wed, 12 Dec 2018 12:16:43 +0100
Message-Id: <1544613406-27026-3-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544613406-27026-1-git-send-email-krzk@kernel.org>
References: <1544613406-27026-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple LED triggers might need to access default pattern so add a
helper for that.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---

New patch in the series

---
 drivers/leds/led-class.c | 25 +++++++++++++++++++++++++
 include/linux/leds.h     |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index 3c7e3487b373..44b95e6480f6 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -17,6 +17,7 @@
 #include <linux/leds.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/timer.h>
@@ -244,6 +245,30 @@ static int led_classdev_next_name(const char *init_name, char *name,
 }
 
 /**
+ * led_classdev_get_default_pattern - return default pattern
+ *
+ * @led_cdev: the led_classdev structure for this device
+ *
+ * Return: Null terminated string with default pattern from DeviceTree or NULL
+ */
+const char *led_classdev_get_default_pattern(struct led_classdev *led_cdev)
+{
+	struct device_node *np = dev_of_node(led_cdev->dev);
+	const char *pattern;
+
+	if (!np)
+		return NULL;
+
+	if (of_property_read_string(np, "led-pattern", &pattern))
+		return NULL;
+
+	if (!strlen(pattern))
+		return NULL;
+
+	return pattern;
+}
+
+/**
  * of_led_classdev_register - register a new object of led_classdev class.
  *
  * @parent: parent of LED device
diff --git a/include/linux/leds.h b/include/linux/leds.h
index 5263f87e1d2c..9da2bfa183ea 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -129,6 +129,9 @@ struct led_classdev {
 	struct mutex		led_access;
 };
 
+extern const char *
+led_classdev_get_default_pattern(struct led_classdev *led_cdev);
+
 extern int of_led_classdev_register(struct device *parent,
 				    struct device_node *np,
 				    struct led_classdev *led_cdev);
-- 
2.7.4

