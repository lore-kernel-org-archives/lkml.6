Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27665C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBCA021871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546596577;
	bh=TBJlLdZ6Jq+4wBjJR2/CwIUaJizkBzsurbq1I2CVTD0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bDqb2KI6N05iBkoBFyYcHMwpLWO2iwbjuYCvZACvkpD1wlsLqdjeftLcjUy1PrhA8
	 nj9q0B4kOct3fE/TBrD69iJuXNIVIfI93HU31gajj+4yf/3fbJDhgnXyW1QPLjD0ac
	 l3eUhE6Jc2ahfVwrxOD/4MUdsbhGRoh3OkrWa0xk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfADKJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 05:09:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:57286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbfADKJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 05:09:11 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B55B4218CD;
        Fri,  4 Jan 2019 10:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546596551;
        bh=TBJlLdZ6Jq+4wBjJR2/CwIUaJizkBzsurbq1I2CVTD0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=pZiU5RTezJd1GggJljI8thIdvVAFhq/8+euqAdD7N2gh3xRV5djA8a3rsRk2eGT8L
         hP02m8rEApgLNoLuFh8PGnIObyaorBojFJsYhAwhkXiollWxhcSMbi/xGVdXMWS48i
         rhFyNgDhLPWJouM3XgAv6bpDDQOSZrhmvB3Dx484=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v6 2/5] leds: Add helper for getting default pattern from Device Tree
Date:   Fri,  4 Jan 2019 11:08:41 +0100
Message-Id: <1546596524-19863-3-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546596524-19863-1-git-send-email-krzk@kernel.org>
References: <1546596524-19863-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple LED triggers might need to access default pattern so add a
helper for that.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/leds/led-core.c | 32 ++++++++++++++++++++++++++++++++
 include/linux/leds.h    | 13 +++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
index ede4fa0ac2cc..c81d7d27c2af 100644
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
@@ -310,6 +312,36 @@ int led_update_brightness(struct led_classdev *led_cdev)
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
+EXPORT_SYMBOL_GPL(led_get_default_pattern);
+
 /* Caller must ensure led_cdev->led_access held */
 void led_sysfs_disable(struct led_classdev *led_cdev)
 {
diff --git a/include/linux/leds.h b/include/linux/leds.h
index 5263f87e1d2c..ac6d34377e7e 100644
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
+ * Return:    Allocated array of integers with default pattern from DeviceTree
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

