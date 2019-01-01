Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D4FC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 14:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3144C218D0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 14:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546351697;
	bh=cPK2BPrwgoSFBPk0BAPtJYBfuEDNRsoMDibTSMTXBZ8=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EynB/74WL3ieMQg4+j/FID6iiHb807qyud8dIQTupSD9uuvXPb0/TobzABbh/dV+L
	 00jjKE+MrDG4jeK7pvCW/Y8U3Lxcv4duQcFMfTda1w3DDt9jovj7iel7FZBNJeFbj6
	 nKV9cUt5dn6XwWtEOLDBu17dUZ5bHSEiDxscKhSE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbfAAOIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 09:08:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:52736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbfAAOIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 09:08:14 -0500
Received: from localhost.localdomain (unknown [194.230.155.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CC51218D0;
        Tue,  1 Jan 2019 14:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546351693;
        bh=cPK2BPrwgoSFBPk0BAPtJYBfuEDNRsoMDibTSMTXBZ8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tt4iCC0civyROqNtc61TPx07ipsBMWCvJay0Dhny2n8q30709bsW5U1lOV4Qljdiy
         OoIa6Mr5E0R0dv1lb3beKPhVFHsm35sWnHv4c6tcJFyp8r9A7UP7OtgbV8Cs7t6Bs8
         SC7NzHxiGfty9z4ZG9qHIXqda4jlZbIthHWiZMec=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Raphael Teysseyre <rteysseyre@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 2/5] leds: Add helper for getting default pattern from Device Tree
Date:   Tue,  1 Jan 2019 15:07:14 +0100
Message-Id: <20190101140717.13564-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190101140717.13564-1-krzk@kernel.org>
References: <20190101140717.13564-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple LED triggers might need to access default pattern so add a
helper for that.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/leds/led-core.c | 43 +++++++++++++++++++++++++++++++++++++++++
 include/linux/leds.h    |  3 +++
 2 files changed, 46 insertions(+)

diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
index ede4fa0ac2cc..e4b6da73bc12 100644
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
@@ -310,6 +312,47 @@ int led_update_brightness(struct led_classdev *led_cdev)
 }
 EXPORT_SYMBOL_GPL(led_update_brightness);
 
+/**
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
 /* Caller must ensure led_cdev->led_access held */
 void led_sysfs_disable(struct led_classdev *led_cdev)
 {
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
2.17.1

