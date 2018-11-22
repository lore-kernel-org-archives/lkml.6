Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DA8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C32F20866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aussec.com header.i=@aussec.com header.b="txHVAQjW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C32F20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=aussec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393631AbeKVU1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:27:42 -0500
Received: from csm1.csm-office.com.au ([165.228.118.109]:34228 "EHLO
        sleepy.aussec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731614AbeKVU1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:27:41 -0500
X-Virus-Scanned: amavisd-new at aussec.com
Received: from hpdv6.aussec.com.com (c110-21-61-29.farfl4.nsw.optusnet.com.au [110.21.61.29])
        (authenticated bits=0)
        by sleepy.aussec.com (8.15.2/8.15.2) with ESMTPSA id wAM9mAdk030201
        (version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Thu, 22 Nov 2018 20:48:42 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aussec.com; s=2016;
        t=1542880124; bh=7qs5KvaGekiJ0n7vYiDjHOMRpSpUCBBsiTeV+Ece+Yc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=txHVAQjWV3CbMxoFrn14/dPhJJsOoxlnqE/kdfWG6iJILaYttuqsuCogR0MFjqzH6
         JQAqnUAfinpaxwzv4lqool6HQfjjLqiQeJyk4F55fWOnwKvl38bA8+cWnvrnlI+juM
         KqPwjizdTskie5ZJLCTuxs0lQf01TkY5tQgFevyhajCVU/x8IRIo9to5hA1lx58fwT
         weFB+g7f+yXX+wI1rL+It4AFPsj7ib+cok9kmSAHGnq/dekDIdGiK42B9fQVjTVnr+
         1OGkJUZaBEkACazCe1yy+xjWel9e/LOpxcr1sWWixfWnYI87gLeKXZoBA/TCqBY1+u
         y8lIxCwO56Tjw==
From:   Tom Burkart <tom@aussec.com>
To:     Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc:     Tom Burkart <tom@aussec.com>, Lukas Senger <lukas@fridolin.com>
Subject: [PATCH v9 4/4] pps: pps-gpio pps-echo implementation
Date:   Thu, 22 Nov 2018 20:46:02 +1100
Message-Id: <20181122094602.5156-5-tom@aussec.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20181122094602.5156-4-tom@aussec.com>
References: <20181122094602.5156-1-tom@aussec.com>
 <20181122094602.5156-2-tom@aussec.com>
 <20181122094602.5156-3-tom@aussec.com>
 <20181122094602.5156-4-tom@aussec.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the pps echo functionality for pps-gpio, that
sysfs claims is available already.

Configuration is done via device tree bindings.

This patch was originally written by Lukas Senger as part of a masters
thesis project and modified for inclusion into the linux kernel by Tom
Burkart.

Signed-off-by: Lukas Senger <lukas@fridolin.com>
Signed-off-by: Tom Burkart <tom@aussec.com>
---
 drivers/pps/clients/pps-gpio.c | 101 +++++++++++++++++++++++++++++++++++++++--
 include/linux/pps-gpio.h       |   3 ++
 2 files changed, 101 insertions(+), 3 deletions(-)

diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
index d2fbc91dc8fc..14293eb2ff5a 100644
--- a/drivers/pps/clients/pps-gpio.c
+++ b/drivers/pps/clients/pps-gpio.c
@@ -35,6 +35,8 @@
 #include <linux/list.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
+#include <linux/timer.h>
+#include <linux/jiffies.h>
 
 /* Info for each registered platform device */
 struct pps_gpio_device_data {
@@ -42,8 +44,14 @@ struct pps_gpio_device_data {
 	struct pps_device *pps;		/* PPS source device */
 	struct pps_source_info info;	/* PPS source information */
 	struct gpio_desc *gpio_pin;	/* GPIO port descriptors */
+	struct gpio_desc *echo_pin;
+	struct timer_list echo_timer;	/* timer to reset echo active state */
 	bool assert_falling_edge;
 	bool capture_clear;
+	bool enable_pps_echo;
+	bool invert_pps_echo;
+	unsigned int echo_active_ms;	/* PPS echo active duration */
+	unsigned long echo_timeout;	/* timer timeout value in jiffies */
 };
 
 /*
@@ -64,27 +72,72 @@ static irqreturn_t pps_gpio_irq_handler(int irq, void *data)
 	rising_edge = gpiod_get_value(info->gpio_pin);
 	if ((rising_edge && !info->assert_falling_edge) ||
 			(!rising_edge && info->assert_falling_edge))
-		pps_event(info->pps, &ts, PPS_CAPTUREASSERT, NULL);
+		pps_event(info->pps, &ts, PPS_CAPTUREASSERT, data);
 	else if (info->capture_clear &&
 			((rising_edge && info->assert_falling_edge) ||
 			(!rising_edge && !info->assert_falling_edge)))
-		pps_event(info->pps, &ts, PPS_CAPTURECLEAR, NULL);
+		pps_event(info->pps, &ts, PPS_CAPTURECLEAR, data);
 
 	return IRQ_HANDLED;
 }
 
+static void pps_gpio_echo(struct pps_device *pps, int event, void *data)
+{
+	/* add_timer() needs to write into info->echo_timer */
+	struct pps_gpio_device_data *info;
+
+	info = data;
+
+	switch (event) {
+	case PPS_CAPTUREASSERT:
+		if (pps->params.mode & PPS_ECHOASSERT)
+			gpiod_set_value(info->echo_pin,
+				info->invert_pps_echo ? 0 : 1);
+		break;
+
+	case PPS_CAPTURECLEAR:
+		if (pps->params.mode & PPS_ECHOCLEAR)
+			gpiod_set_value(info->echo_pin,
+				info->invert_pps_echo ? 0 : 1);
+		break;
+	}
+
+	/* fire the timer */
+	if (info->pps->params.mode & (PPS_ECHOASSERT | PPS_ECHOCLEAR)) {
+		info->echo_timer.expires = jiffies + info->echo_timeout;
+		add_timer(&info->echo_timer);
+	}
+}
+
+/* Timer callback to reset the echo pin to the inactive state */
+static void pps_gpio_echo_timer_callback(struct timer_list *t)
+{
+	const struct pps_gpio_device_data *info;
+
+	info = from_timer(info, t, echo_timer);
+
+	gpiod_set_value(info->echo_pin,
+		info->invert_pps_echo ? 1 : 0);
+}
+
 static int pps_gpio_setup(struct platform_device *pdev)
 {
 	struct pps_gpio_device_data *data = platform_get_drvdata(pdev);
 	const struct pps_gpio_platform_data *pdata = pdev->dev.platform_data;
 	struct device_node *np = pdev->dev.of_node;
 	int ret;
+	u32 value;
 
 	if (pdata) {
 		data->gpio_pin = pdata->gpio_pin;
+		data->echo_pin = pdata->echo_pin;
+		if (pdata->echo_pin != NULL)
+			data->enable_pps_echo = true;
 
 		data->assert_falling_edge = pdata->assert_falling_edge;
 		data->capture_clear = pdata->capture_clear;
+		data->invert_pps_echo = pdata->invert_pps_echo;
+		data->echo_active_ms = pdata->echo_active_ms;
 	} else {
 		data->gpio_pin = devm_gpiod_get(&pdev->dev,
 			NULL,	/* request "gpios" */
@@ -95,11 +148,43 @@ static int pps_gpio_setup(struct platform_device *pdev)
 			return PTR_ERR(data->gpio_pin);
 		}
 
+		if (of_get_property(np, "echo-gpios", NULL)) {
+			data->enable_pps_echo = true;
+
+			data->echo_pin = devm_gpiod_get(&pdev->dev,
+				"echo",
+				GPIOD_OUT_LOW);
+			if (IS_ERR(data->echo_pin)) {
+				dev_err(&pdev->dev, "failed to request ECHO GPIO\n");
+				return PTR_ERR(data->echo_pin);
+			}
+
+			ret = of_property_read_u32(np,
+				"echo-active-ms",
+				&value);
+			if (ret) {
+				dev_err(&pdev->dev,
+					"failed to get echo-active-ms from OF\n");
+				return ret;
+			}
+			data->echo_active_ms = value;
+			/* sanity check on echo_active_ms */
+			if (!data->echo_active_ms || data->echo_active_ms > 999) {
+				dev_err(&pdev->dev,
+					"echo-active-ms: %u - bad value from OF\n",
+					data->echo_active_ms);
+				return -EINVAL;
+			}
+		}
+
 		if (of_get_property(np, "assert-falling-edge", NULL))
 			data->assert_falling_edge = true;
 
 		if (of_get_property(np, "capture-clear", NULL))
 			data->capture_clear = true;
+
+		if (of_get_property(np, "invert-pps-echo", NULL))
+			data->invert_pps_echo = true;
 	}
 	return 0;
 }
@@ -153,6 +238,11 @@ static int pps_gpio_probe(struct platform_device *pdev)
 	data->info.owner = THIS_MODULE;
 	snprintf(data->info.name, PPS_MAX_NAME_LEN - 1, "%s.%d",
 		 pdev->name, pdev->id);
+	if (data->enable_pps_echo) {
+		data->info.echo = pps_gpio_echo;
+		data->echo_timeout = msecs_to_jiffies(data->echo_active_ms);
+		timer_setup(&data->echo_timer, pps_gpio_echo_timer_callback, 0);
+	}
 
 	/* register PPS source */
 	pps_default_params = PPS_CAPTUREASSERT | PPS_OFFSETASSERT;
@@ -185,6 +275,11 @@ static int pps_gpio_remove(struct platform_device *pdev)
 	struct pps_gpio_device_data *data = platform_get_drvdata(pdev);
 
 	pps_unregister_source(data->pps);
+	if (data->enable_pps_echo) {
+		del_timer_sync(&data->echo_timer);
+		/* reset echo pin in any case */
+		gpiod_set_value(data->echo_pin, data->invert_pps_echo ? 1 : 0);
+	}
 	dev_info(&pdev->dev, "removed IRQ %d as PPS source\n", data->irq);
 	return 0;
 }
@@ -209,4 +304,4 @@ MODULE_AUTHOR("Ricardo Martins <rasm@fe.up.pt>");
 MODULE_AUTHOR("James Nuss <jamesnuss@nanometrics.ca>");
 MODULE_DESCRIPTION("Use GPIO pin as PPS source");
 MODULE_LICENSE("GPL");
-MODULE_VERSION("1.1.0");
+MODULE_VERSION("1.2.0");
diff --git a/include/linux/pps-gpio.h b/include/linux/pps-gpio.h
index f028d2cda6f5..5390f18c73a5 100644
--- a/include/linux/pps-gpio.h
+++ b/include/linux/pps-gpio.h
@@ -24,8 +24,11 @@
 
 struct pps_gpio_platform_data {
 	struct gpio_desc *gpio_pin;
+	struct gpio_desc *echo_pin;
 	bool assert_falling_edge;
 	bool capture_clear;
+	bool invert_pps_echo;
+	unsigned int echo_active_ms;
 };
 
 #endif /* _PPS_GPIO_H */
-- 
2.12.3

