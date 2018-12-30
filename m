Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E764C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 08:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF87A20866
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 08:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aussec.com header.i=@aussec.com header.b="Zg+ckDt8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbeL3IfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 03:35:16 -0500
Received: from csm1.csm-office.com.au ([165.228.118.109]:57170 "EHLO
        sleepy.aussec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbeL3IfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 03:35:15 -0500
X-Virus-Scanned: amavisd-new at aussec.com
Received: from localhost.localdomain ([1.132.227.105])
        (authenticated bits=0)
        by sleepy.aussec.com (8.15.2/8.15.2) with ESMTPSA id wBU8YAfv019893
        (version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Sun, 30 Dec 2018 19:34:46 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aussec.com; s=2016;
        t=1546158887; bh=doXkFEl99gd/yLi9kf+LatS9unPKVE11GzvmirFn9MY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Zg+ckDt8aseskxjgMdSi2yjkQQuaX6shraBRyZYMf4DSdNMXSDJgEcZLqCrwhtJOx
         iIcS0rb5+RQ5qCzEhoM/OEgvHDNUt7UjwUB8OfedrMho78l8M2R8h9otxOMb6jUa3q
         bOQAVCR+v8wZhX3QmufAFs7CzkLBO9aGAleHy+2OZlSP7We8Ad0bZEP59zUqzahnrz
         Z8+dTDXVXbC2xiin6IySoJadknhR4Pb9RaVUA3zmAG2pVMgmE/pVvlOA8Y5si2yluv
         HmJaIj99tvzO0jY5/ETqjpomRRIL5pCcF7AYOPPwnaBzNyAeFzlfCDRoKTqXmnR/vv
         F9ya3LE5sCCUQ==
From:   Tom Burkart <tom@aussec.com>
To:     Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc:     Tom Burkart <tom@aussec.com>,
        Rodolfo Giometti <giometti@enneenne.com>,
        Ricardo Martins <rasm@fe.up.pt>,
        James Nuss <jamesnuss@nanometrics.ca>,
        Lukas Senger <lukas@fridolin.com>
Subject: [PATCH v14 3/3] pps: pps-gpio pps-echo implementation
Date:   Sun, 30 Dec 2018 19:33:33 +1100
Message-Id: <20181230083333.27210-4-tom@aussec.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20181230083333.27210-3-tom@aussec.com>
References: <20181230083333.27210-1-tom@aussec.com>
 <20181230083333.27210-2-tom@aussec.com>
 <20181230083333.27210-3-tom@aussec.com>
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
 drivers/pps/clients/pps-gpio.c | 89 ++++++++++++++++++++++++++++++++++++++++--
 include/linux/pps-gpio.h       |  2 +
 2 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
index 4e5e9229814b..f00f5ca9f9ad 100644
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
@@ -42,8 +44,12 @@ struct pps_gpio_device_data {
 	struct pps_device *pps;		/* PPS source device */
 	struct pps_source_info info;	/* PPS source information */
 	struct gpio_desc *gpio_pin;	/* GPIO port descriptors */
+	struct gpio_desc *echo_pin;
+	struct timer_list echo_timer;	/* timer to reset echo active state */
 	bool assert_falling_edge;
 	bool capture_clear;
+	unsigned int echo_active_ms;	/* PPS echo active duration */
+	unsigned long echo_timeout;	/* timer timeout value in jiffies */
 };
 
 /*
@@ -64,19 +70,57 @@ static irqreturn_t pps_gpio_irq_handler(int irq, void *data)
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
+			gpiod_set_value(info->echo_pin, 1);
+		break;
+
+	case PPS_CAPTURECLEAR:
+		if (pps->params.mode & PPS_ECHOCLEAR)
+			gpiod_set_value(info->echo_pin, 1);
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
+	gpiod_set_value(info->echo_pin, 0);
+}
+
 static int pps_gpio_setup(struct platform_device *pdev)
 {
 	struct pps_gpio_device_data *data = platform_get_drvdata(pdev);
 	struct device_node *np = pdev->dev.of_node;
+	int ret;
+	u32 value;
 
 	data->gpio_pin = devm_gpiod_get(&pdev->dev,
 		NULL,	/* request "gpios" */
@@ -87,6 +131,33 @@ static int pps_gpio_setup(struct platform_device *pdev)
 		return PTR_ERR(data->gpio_pin);
 	}
 
+	data->echo_pin = devm_gpiod_get_optional(&pdev->dev,
+			"echo",
+			GPIOD_OUT_LOW);
+	if (data->echo_pin) {
+		if (IS_ERR(data->echo_pin)) {
+			dev_err(&pdev->dev, "failed to request ECHO GPIO\n");
+			return PTR_ERR(data->echo_pin);
+		}
+
+		ret = of_property_read_u32(np,
+			"echo-active-ms",
+			&value);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"failed to get echo-active-ms from OF\n");
+			return ret;
+		}
+		data->echo_active_ms = value;
+		/* sanity check on echo_active_ms */
+		if (!data->echo_active_ms || data->echo_active_ms > 999) {
+			dev_err(&pdev->dev,
+				"echo-active-ms: %u - bad value from OF\n",
+				data->echo_active_ms);
+			return -EINVAL;
+		}
+	}
+
 	if (of_property_read_bool(np, "assert-falling-edge"))
 		data->assert_falling_edge = true;
 	return 0;
@@ -122,9 +193,11 @@ static int pps_gpio_probe(struct platform_device *pdev)
 	/* GPIO setup */
 	if (pdata) {
 		data->gpio_pin = pdata->gpio_pin;
+		data->echo_pin = pdata->echo_pin;
 
 		data->assert_falling_edge = pdata->assert_falling_edge;
 		data->capture_clear = pdata->capture_clear;
+		data->echo_active_ms = pdata->echo_active_ms;
 	} else {
 		ret = pps_gpio_setup(pdev);
 		if (ret)
@@ -148,6 +221,11 @@ static int pps_gpio_probe(struct platform_device *pdev)
 	data->info.owner = THIS_MODULE;
 	snprintf(data->info.name, PPS_MAX_NAME_LEN - 1, "%s.%d",
 		 pdev->name, pdev->id);
+	if (data->echo_pin) {
+		data->info.echo = pps_gpio_echo;
+		data->echo_timeout = msecs_to_jiffies(data->echo_active_ms);
+		timer_setup(&data->echo_timer, pps_gpio_echo_timer_callback, 0);
+	}
 
 	/* register PPS source */
 	pps_default_params = PPS_CAPTUREASSERT | PPS_OFFSETASSERT;
@@ -180,6 +258,11 @@ static int pps_gpio_remove(struct platform_device *pdev)
 	struct pps_gpio_device_data *data = platform_get_drvdata(pdev);
 
 	pps_unregister_source(data->pps);
+	if (data->echo_pin) {
+		del_timer_sync(&data->echo_timer);
+		/* reset echo pin in any case */
+		gpiod_set_value(data->echo_pin, 0);
+	}
 	dev_info(&pdev->dev, "removed IRQ %d as PPS source\n", data->irq);
 	return 0;
 }
@@ -204,4 +287,4 @@ MODULE_AUTHOR("Ricardo Martins <rasm@fe.up.pt>");
 MODULE_AUTHOR("James Nuss <jamesnuss@nanometrics.ca>");
 MODULE_DESCRIPTION("Use GPIO pin as PPS source");
 MODULE_LICENSE("GPL");
-MODULE_VERSION("1.1.0");
+MODULE_VERSION("1.2.0");
diff --git a/include/linux/pps-gpio.h b/include/linux/pps-gpio.h
index f028d2cda6f5..44171e6b7197 100644
--- a/include/linux/pps-gpio.h
+++ b/include/linux/pps-gpio.h
@@ -24,8 +24,10 @@
 
 struct pps_gpio_platform_data {
 	struct gpio_desc *gpio_pin;
+	struct gpio_desc *echo_pin;
 	bool assert_falling_edge;
 	bool capture_clear;
+	unsigned int echo_active_ms;
 };
 
 #endif /* _PPS_GPIO_H */
-- 
2.12.3

