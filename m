Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA0AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10F320815
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545146872;
	bh=YNIQGTCf5JwjaV6hCGFaDUltB8M0Fa3cx1/p1cq7klA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VVArePMqAXWb8ikoo+MlNrk5OWRjpBUQm+I70S/Ho8s0ZjRvH7seck1QbkjJSi98X
	 P92DgUeRm0sbELedrBdVvlYHUlUVKprs+yKekCsBmN3cBNBBaKvhBbgGzkyFg0tpUF
	 8cb+rEVCG6ttr88EQOGVDlZFa2fXKc4Em/rm0Qu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbeLRP1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:27:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:51182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbeLRP1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:27:44 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F30BF218A1;
        Tue, 18 Dec 2018 15:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545146863;
        bh=YNIQGTCf5JwjaV6hCGFaDUltB8M0Fa3cx1/p1cq7klA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SI9u8PDNiTJ8Hw1pknvyBDYcK1XX0CvZNC/+LkHam12z7BpTg17hyCkS8MDKzHWHV
         cAowpKUm3Jw0j4DcNWX3gP9IYeAhf9mQTqRVXWnh4wi98YVBsub4zBlATO+uNFnq8L
         rD5yS4/SSMLhMBVYBuhpn1lcgM66njuIhpxmWCeE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Raphael Teysseyre <rteysseyre@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 2/5] leds: Add helper for getting default pattern from Device Tree
Date:   Tue, 18 Dec 2018 16:27:29 +0100
Message-Id: <1545146852-32207-3-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545146852-32207-1-git-send-email-krzk@kernel.org>
References: <1545146852-32207-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple LED triggers might need to access default pattern so add a
helper for that.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/leds/led-class.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/leds.h     |  3 +++
 2 files changed, 45 insertions(+)

diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index 3c7e3487b373..49eb64bffd4d 100644
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
@@ -244,6 +245,47 @@ static int led_classdev_next_name(const char *init_name, char *name,
 }
 
 /**
+ * led_classdev_get_default_pattern - return default pattern
+ *
+ * @led_cdev: the led_classdev structure for this device
+ * @size:     pointer for storing the number of elements in returned array,
+ *            modified only if return != NULL
+ *
+ * Return:    Allocated array of integers with default pattern from DeviceTree
+ *            or NULL.  Caller is responsible for kfree().
+ */
+u32 *led_classdev_get_default_pattern(struct led_classdev *led_cdev,
+				      unsigned int *size)
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
+	if (of_property_read_u32_array(np, "led-pattern", pattern, count))
+		goto err;
+
+	*size = count;
+
+	return pattern;
+
+err:
+	kfree(pattern);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(led_classdev_get_default_pattern);
+
+/**
  * of_led_classdev_register - register a new object of led_classdev class.
  *
  * @parent: parent of LED device
diff --git a/include/linux/leds.h b/include/linux/leds.h
index 5263f87e1d2c..70edf574ba81 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -129,6 +129,9 @@ struct led_classdev {
 	struct mutex		led_access;
 };
 
+extern u32 *led_classdev_get_default_pattern(struct led_classdev *led_cdev,
+					     unsigned int *size);
+
 extern int of_led_classdev_register(struct device *parent,
 				    struct device_node *np,
 				    struct led_classdev *led_cdev);
-- 
2.7.4

