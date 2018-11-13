Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E31C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB72223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aussec.com header.i=@aussec.com header.b="f2rOy5W9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFB72223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=aussec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730536AbeKMOBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 09:01:47 -0500
Received: from csm1.csm-office.com.au ([165.228.118.109]:40420 "EHLO
        sleepy.aussec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeKMOBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 09:01:46 -0500
X-Greylist: delayed 1358 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Nov 2018 09:01:44 EST
X-Virus-Scanned: amavisd-new at aussec.com
Received: from localhost.localdomain (dhcp-3-227.csm-office.com.au [172.16.3.227])
        (authenticated bits=0)
        by sleepy.aussec.com (8.15.2/8.15.2) with ESMTPSA id wAD3gTri014074
        (version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Tue, 13 Nov 2018 14:43:12 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aussec.com; s=2016;
        t=1542080592; bh=e1pYg69Zap5CzGcqMYr7fA/gTXpWmqf5KOHnPUpfxys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=f2rOy5W91NrLRDLHgGHgfBjG1hkiCU4hKv/VztL+FDqOiPgsmP50EhJQrnXu4LkNV
         x5orolIIfJUS9mjT+E7EHY0hN0C6u++7cFAoppDl6Oh2oGPwrZQxR8Bh4J2C2VNZZ6
         nbLC9EW4DtxgsHAAlGnNW0B6B+jNN4sPnf4G6fBNZOrBOOwhNI5k5ISe0Ya8Q9wkwm
         zInpHGzEPq6B741PuEVqpwdeggVmT1lDqkjagwpPCu46yhlW/6jofh5q+PiFgZqYd0
         iVGcNAV2g5lmzv1N2Y0SXhQE2vmN2NaYzcZFGRVbqrbktp6ZwjiHd6PULcNjQfB4h+
         CJqGKLz8RgJrQ==
From:   Tom Burkart <tom@aussec.com>
To:     Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc:     Tom Burkart <tom@aussec.com>
Subject: [PATCH v6 2/4] pps: descriptor-based gpio, capture-clear addition
Date:   Tue, 13 Nov 2018 14:40:05 +1100
Message-Id: <20181113034007.3878-3-tom@aussec.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20181113034007.3878-2-tom@aussec.com>
References: <20181113034007.3878-1-tom@aussec.com>
 <20181113034007.3878-2-tom@aussec.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the GPIO access for the pps-gpio driver from the
integer based API to the descriptor based API.  It also adds
documentation for the device tree capture-clear option and
device tree capture-clear extraction.

The change from integer based GPIO API to the descriptor based API
breaks backward compatibility for the devicetree.  This is due to
the descriptor based API appending "-gpio" or "-gpios" (see
Documentation/gpio/base.txt.)

Signed-off-by: Tom Burkart <tom@aussec.com>
---
 drivers/pps/clients/pps-gpio.c | 33 +++++++++++----------------------
 include/linux/pps-gpio.h       |  2 +-
 2 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
index 333ad7d5b45b..d25710883794 100644
--- a/drivers/pps/clients/pps-gpio.c
+++ b/drivers/pps/clients/pps-gpio.c
@@ -31,7 +31,7 @@
 #include <linux/slab.h>
 #include <linux/pps_kernel.h>
 #include <linux/pps-gpio.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/list.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
@@ -41,9 +41,9 @@ struct pps_gpio_device_data {
 	int irq;			/* IRQ used as PPS source */
 	struct pps_device *pps;		/* PPS source device */
 	struct pps_source_info info;	/* PPS source information */
+	struct gpio_desc *gpio_pin;	/* GPIO port descriptors */
 	bool assert_falling_edge;
 	bool capture_clear;
-	unsigned int gpio_pin;
 };
 
 /*
@@ -61,7 +61,7 @@ static irqreturn_t pps_gpio_irq_handler(int irq, void *data)
 
 	info = data;
 
-	rising_edge = gpio_get_value(info->gpio_pin);
+	rising_edge = gpiod_get_value(info->gpio_pin);
 	if ((rising_edge && !info->assert_falling_edge) ||
 			(!rising_edge && info->assert_falling_edge))
 		pps_event(info->pps, &ts, PPS_CAPTUREASSERT, NULL);
@@ -109,34 +109,23 @@ static int pps_gpio_probe(struct platform_device *pdev)
 		data->assert_falling_edge = pdata->assert_falling_edge;
 		data->capture_clear = pdata->capture_clear;
 	} else {
-		ret = of_get_gpio(np, 0);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "failed to get GPIO from device tree\n");
-			return ret;
+		/* GPIO setup */
+		data->gpio_pin = devm_gpiod_get(&pdev->dev, "pps", GPIOD_IN);
+		if (IS_ERR(data->gpio_pin)) {
+			dev_err(&pdev->dev, "failed to request PPS GPIO\n");
+			return PTR_ERR(data->gpio_pin);
 		}
-		data->gpio_pin = ret;
 		gpio_label = PPS_GPIO_NAME;
 
 		if (of_get_property(np, "assert-falling-edge", NULL))
 			data->assert_falling_edge = true;
-	}
-
-	/* GPIO setup */
-	ret = devm_gpio_request(&pdev->dev, data->gpio_pin, gpio_label);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to request GPIO %u\n",
-			data->gpio_pin);
-		return ret;
-	}
 
-	ret = gpio_direction_input(data->gpio_pin);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to set pin direction\n");
-		return -EINVAL;
+		if (of_get_property(np, "capture-clear", NULL))
+			data->capture_clear = true;
 	}
 
 	/* IRQ setup */
-	ret = gpio_to_irq(data->gpio_pin);
+	ret = gpiod_to_irq(data->gpio_pin);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to map GPIO to IRQ: %d\n", ret);
 		return -EINVAL;
diff --git a/include/linux/pps-gpio.h b/include/linux/pps-gpio.h
index 56f35dd3d01d..671a029fc80b 100644
--- a/include/linux/pps-gpio.h
+++ b/include/linux/pps-gpio.h
@@ -23,9 +23,9 @@
 #define _PPS_GPIO_H
 
 struct pps_gpio_platform_data {
+	struct gpio_desc *gpio_pin;
 	bool assert_falling_edge;
 	bool capture_clear;
-	unsigned int gpio_pin;
 	const char *gpio_label;
 };
 
-- 
2.12.3

