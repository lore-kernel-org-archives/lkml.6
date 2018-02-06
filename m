Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752589AbeBFP70 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 10:59:26 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:55508 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752222AbeBFP7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 10:59:21 -0500
From: Lukas Senger <lukas@fridolin.com>
To: giometti@enneenne.com
Cc: linux-kernel@vger.kernel.org, Lukas Senger <lukas@fridolin.com>
Subject: [PATCH] pps-gpio: implement echo pulses
Date: Tue,  6 Feb 2018 16:58:56 +0100
Message-Id: <20180206155856.14562-1-lukas@fridolin.com>
X-Mailer: git-send-email 2.16.1
X-Provags-ID: V03:K0:GSUO27Ublka2lsrhW9GQUb2XOFUg1ogSIQ5mtTDWyh3ycGdCfib
 Zx6H/FiWGABRS1yHQW1zNN3DYoVGXvvK0qh/iiFI459bNs5vkaJlLeqNJ/XByDHScxQGQLc
 dZc6ahjUUCGIcDcmlw7vztgBrmITYT339mHkyAdNgj13BF4hTJyS+ihLbAJdjwVMOLmsqt0
 yL818/Hag3DGKMr7edb5A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RuSXAGvCHvo=:nauSzygZ5F/xewJdE9rqIL
 OFKcN+6Iebb9q5SwKXyplxDJV7B0Zy73oD/ZnJIDLGrLqDNEqUlNxxEuso6KRmiISNn6/SdeI
 HbY0jLKRR2JN+YmKW5jVi24pCY6Nj/OaaRgMvcrTlswpwxcnVyH3IQZuU9fKQ/bkCho4R9xY/
 IImYIVJUfxSCwzx25MzFLlZgN0Sv3J7h1rsZhf32IKEpywSNwpuxDYQzWAFcHCxCEYcK+iK8S
 edo7GHucgwcPtAviSux72w/Cx13kAiwyFi72hXzRiA5y2A3fttpcGOZq4/jhf0WVzqWgGJm1C
 4xlwsF/1Wdng6v98bncuwjDnDHNcnCJrPc8fYy+sNwsjmU01ixAKemBQ8i2tP5YqMB9sdT64j
 Ee6d3QXJQV/qjBArvxPqJoAMYSOlpYb2x1L7xG6jTU+EEE/V+q1y6BTPTfEqfm42ZEGv2POwj
 HGTBiMWJK6iCKHEnGyUo/ZUR0OIsin8H2aiB0G1Oyn39nluWVPq8NyUyaRYpmWMM3ojr88tFI
 XVEjnEtzdoBcKi4WQVeq8p/R10h5W9GYLBXrmWHin1NfiRJz+VI7V26H/73z/WqMTPaa53uvy
 hFnJ4G/2uE+bSt42/FwHg52p5uYFcAB9JbhWqmw42OXh/hteBeTqkXOKzfuTZCaKuoduPVvZn
 oScTM7FJ9XypDP8NDf27OKqhADzi7vw8W60w75HcQU3MQZOJuKk5GO6UXPuAjjBcF6d3dGPrw
 j8Bvrf3i7j7+F3Yu1R9bT56uxAlHwkfVJW4Dag==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pps-gpio reports as having echo capability via sysfs, which is not
actually the case. This patch implements it.

The output pin is hardcoded as 17. This should probably be configurable
via the dtoverlay in the same way as the input pin.
---
 drivers/pps/clients/pps-gpio.c | 55 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 5 deletions(-)

diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
index 333ad7d5..dd7624f1 100644
--- a/drivers/pps/clients/pps-gpio.c
+++ b/drivers/pps/clients/pps-gpio.c
@@ -35,6 +35,12 @@
 #include <linux/list.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
+#include <linux/delay.h>
+
+/* TODO: this should work like gpio_pin below but I don't know how to work with
+ * devicetree overlays.
+ */
+#define PPS_GPIO_ECHO_PIN 17
 
 /* Info for each registered platform device */
 struct pps_gpio_device_data {
@@ -63,16 +69,41 @@ static irqreturn_t pps_gpio_irq_handler(int irq, void *data)
 
 	rising_edge = gpio_get_value(info->gpio_pin);
 	if ((rising_edge && !info->assert_falling_edge) ||
-			(!rising_edge && info->assert_falling_edge))
+			(!rising_edge && info->assert_falling_edge)) {
+		if (info->pps->params.mode & PPS_ECHOASSERT) {
+			gpio_set_value(PPS_GPIO_ECHO_PIN, 1);
+		}
 		pps_event(info->pps, &ts, PPS_CAPTUREASSERT, NULL);
-	else if (info->capture_clear &&
+	} else if (info->capture_clear &&
 			((rising_edge && info->assert_falling_edge) ||
-			 (!rising_edge && !info->assert_falling_edge)))
+			 (!rising_edge && !info->assert_falling_edge))) {
+		if (info->pps->params.mode & PPS_ECHOCLEAR) {
+			gpio_set_value(PPS_GPIO_ECHO_PIN, 1);
+		}
 		pps_event(info->pps, &ts, PPS_CAPTURECLEAR, NULL);
+	}
 
+	if (info->pps->params.mode & (PPS_ECHOASSERT | PPS_ECHOCLEAR))
+		return IRQ_WAKE_THREAD;
 	return IRQ_HANDLED;
 }
 
+/* If we sent an echo pulse, we set the output pin back to low. This results in
+ * an echo pulse of roughly 100ms length.
+ */
+static irqreturn_t pps_gpio_irq_threaded(int irq, void *data)
+{
+	const struct pps_gpio_device_data *info;
+
+	info = data;
+
+	msleep(100);
+	gpio_set_value(PPS_GPIO_ECHO_PIN, 0);
+
+	return IRQ_HANDLED;
+}
+
+
 static unsigned long
 get_irqf_trigger_flags(const struct pps_gpio_device_data *data)
 {
@@ -131,7 +162,20 @@ static int pps_gpio_probe(struct platform_device *pdev)
 
 	ret = gpio_direction_input(data->gpio_pin);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to set pin direction\n");
+		dev_err(&pdev->dev, "failed to set pin as input\n");
+		return -EINVAL;
+	}
+
+	ret = devm_gpio_request(&pdev->dev, PPS_GPIO_ECHO_PIN, gpio_label);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to request GPIO %u\n",
+			PPS_GPIO_ECHO_PIN);
+		return ret;
+	}
+
+	ret = gpio_direction_output(PPS_GPIO_ECHO_PIN, 0);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to set pin as output\n");
 		return -EINVAL;
 	}
 
@@ -165,7 +209,8 @@ static int pps_gpio_probe(struct platform_device *pdev)
 	}
 
 	/* register IRQ interrupt handler */
-	ret = devm_request_irq(&pdev->dev, data->irq, pps_gpio_irq_handler,
+	ret = devm_request_threaded_irq(&pdev->dev, data->irq,
+			pps_gpio_irq_handler, pps_gpio_irq_threaded,
 			get_irqf_trigger_flags(data), data->info.name, data);
 	if (ret) {
 		pps_unregister_source(data->pps);
-- 
2.16.1
