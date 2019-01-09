Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2758C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE8721841
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547045104;
	bh=LEtO+UoHqcmfND7IGEIzZ+sWE34NKxUVs5hJGrLWaGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KlYygX4MRxe5C3TPKl/guyAQ02JZ/Yhy/Wp9ZCqiPE9Xlpr4cG83T1tueo002OOBi
	 TY6TUb5kfRQ6nEfyRRvqkt5WZxThlQZpNdcYEoQg3S1+2Cu+FtR6rpgXR82KHg5u/b
	 2YnIgUUqYMw862A6tYolevkmNuCndjwsX9qAdXyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731808AbfAIOpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:45:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:48294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731772AbfAIOpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:45:00 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0CE820859;
        Wed,  9 Jan 2019 14:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547045100;
        bh=LEtO+UoHqcmfND7IGEIzZ+sWE34NKxUVs5hJGrLWaGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g+6F6/boTBXDWDztV/9RRVBR3X9f3bmcjbvT5yLutKleFcKhpgcZe9PARRwLX1rnR
         oYe+bdc6ewoH10LqJSH5SHEPvkY/o+da/+8IgKQY4rA50mWq4EIwa5AnQjeUlTWFKO
         HBhzIKqCnm5GoUYNH90+mceOMkJJPHncw3rgjsP8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v7 2/5] leds: Add helper for getting default pattern from Device Tree
Date:   Wed,  9 Jan 2019 15:44:46 +0100
Message-Id: <1547045089-19128-3-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547045089-19128-1-git-send-email-krzk@kernel.org>
References: <1547045089-19128-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple LED triggers might need to access default pattern so add a
helper for that.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/leds/led-core.c | 30 ++++++++++++++++++++++++++++++
 include/linux/leds.h    | 13 +++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
index ede4fa0ac2cc..e3da7c03da1b 100644
--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -16,7 +16,9 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/rwsem.h>
+#include <linux/slab.h>
 #include "leds.h"
 
 DECLARE_RWSEM(leds_list_lock);
@@ -310,6 +312,34 @@ int led_update_brightness(struct led_classdev *led_cdev)
 }
 EXPORT_SYMBOL_GPL(led_update_brightness);
 
+u32 *led_get_default_pattern(struct led_classdev *led_cdev, unsigned int *size)
+{
+	struct device_node *np = dev_of_node(led_cdev->dev);
+	u32 *pattern;
+	int count;
+
+	if (!np)
+		return NULL;
+
+	count = of_property_count_u32_elems(np, "led-pattern");
+	if (count < 0)
+		return NULL;
+
+	pattern = kcalloc(count, sizeof(*pattern), GFP_KERNEL);
+	if (!pattern)
+		return NULL;
+
+	if (of_property_read_u32_array(np, "led-pattern", pattern, count)) {
+		kfree(pattern);
+		return NULL;
+	}
+
+	*size = count;
+
+	return pattern;
+}
+EXPORT_SYMBOL_GPL(led_get_default_pattern);
+
 /* Caller must ensure led_cdev->led_access held */
 void led_sysfs_disable(struct led_classdev *led_cdev)
 {
diff --git a/include/linux/leds.h b/include/linux/leds.h
index 5263f87e1d2c..78204650fe2a 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -219,6 +219,19 @@ extern int led_set_brightness_sync(struct led_classdev *led_cdev,
 extern int led_update_brightness(struct led_classdev *led_cdev);
 
 /**
+ * led_get_default_pattern - return default pattern
+ *
+ * @led_cdev: the LED to get default pattern for
+ * @size:     pointer for storing the number of elements in returned array,
+ *            modified only if return != NULL
+ *
+ * Return:    Allocated array of integers with default pattern from device tree
+ *            or NULL.  Caller is responsible for kfree().
+ */
+extern u32 *led_get_default_pattern(struct led_classdev *led_cdev,
+				    unsigned int *size);
+
+/**
  * led_sysfs_disable - disable LED sysfs interface
  * @led_cdev: the LED to set
  *
-- 
2.7.4

