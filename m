Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C61C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49762146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107411;
	bh=enkqHnl505A2Wrv1Df9nEW0vCpC36NsjFN0HKGm3Ago=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pyGxss2gvYWbeusXva/dK4tbOeRBiElQHWaRZ/KoM9iWmvKTxcNwtTXnl4VQJzZBx
	 E1Nv9u+c5mOz8/VT3cuw2edvAmxNoxp4CM2+LSsGBStOHDhyZuR9I+iTh1s08vGRzz
	 bgRTgB97Vj4OxOXwsvsVWseL5UNnpb9StrUEPbtA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E49762146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbeLFOna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:43:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:47864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730657AbeLFOn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:43:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96640214E0;
        Thu,  6 Dec 2018 14:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107406;
        bh=enkqHnl505A2Wrv1Df9nEW0vCpC36NsjFN0HKGm3Ago=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QlJZf1DpZEvWyBRAqtnW99AnGOS+1+xVnDgY0wfoTjjq7MXvs7WgSMFcZoFHYn7Gu
         vQZlpuYwaybIKkUZWIiFOC8tvUtY34yEGYQyJuTwUKLTET+Gt7tyTwBUZgYpHjilH7
         1tRmtdzhRm9Ho3UZw/NGSXiV7H8NO2sDzQvVySi4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        "Wangtao (Kevin, Kirin)" <kevin.wangtao@hisilicon.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rafael David Tinoco <rafael.tinoco@linaro.org>
Subject: [PATCH 4.14 48/55] thermal/drivers/hisi: Remove the multiple sensors support
Date:   Thu,  6 Dec 2018 15:39:22 +0100
Message-Id: <20181206143004.335300031@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143001.749982936@linuxfoundation.org>
References: <20181206143001.749982936@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Lezcano <daniel.lezcano@linaro.org>

commit ff4ec2997df8fe7cc40513dbe5f86d9f88fb6be7 upstream.

By essence, the tsensor does not really support multiple sensor at the same
time. It allows to set a sensor and use it to get the temperature, another
sensor could be switched but with a delay of 3-5ms. It is difficult to read
simultaneously several sensors without a big delay.

Today, just one sensor is used, it is not necessary to deal with multiple
sensors in the code. Remove them and if it is needed in the future add them
on top of a code which will be clean up in the meantime.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Wangtao (Kevin, Kirin) <kevin.wangtao@hisilicon.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thermal/hisi_thermal.c |   75 ++++++++++-------------------------------
 1 file changed, 19 insertions(+), 56 deletions(-)

--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -40,6 +40,7 @@
 #define HISI_TEMP_STEP			(784)
 
 #define HISI_MAX_SENSORS		4
+#define HISI_DEFAULT_SENSOR		2
 
 struct hisi_thermal_sensor {
 	struct hisi_thermal_data *thermal;
@@ -54,9 +55,8 @@ struct hisi_thermal_data {
 	struct mutex thermal_lock;    /* protects register data */
 	struct platform_device *pdev;
 	struct clk *clk;
-	struct hisi_thermal_sensor sensors[HISI_MAX_SENSORS];
-
-	int irq, irq_bind_sensor;
+	struct hisi_thermal_sensor sensors;
+	int irq;
 	bool irq_enabled;
 
 	void __iomem *regs;
@@ -133,7 +133,7 @@ static void hisi_thermal_enable_bind_irq
 
 	mutex_lock(&data->thermal_lock);
 
-	sensor = &data->sensors[data->irq_bind_sensor];
+	sensor = &data->sensors;
 
 	/* setting the hdak time */
 	writel(0x0, data->regs + TEMP0_CFG);
@@ -181,31 +181,8 @@ static int hisi_thermal_get_temp(void *_
 	struct hisi_thermal_sensor *sensor = _sensor;
 	struct hisi_thermal_data *data = sensor->thermal;
 
-	int sensor_id = -1, i;
-	long max_temp = 0;
-
 	*temp = hisi_thermal_get_sensor_temp(data, sensor);
 
-	sensor->sensor_temp = *temp;
-
-	for (i = 0; i < HISI_MAX_SENSORS; i++) {
-		if (!data->sensors[i].tzd)
-			continue;
-
-		if (data->sensors[i].sensor_temp >= max_temp) {
-			max_temp = data->sensors[i].sensor_temp;
-			sensor_id = i;
-		}
-	}
-
-	/* If no sensor has been enabled, then skip to enable irq */
-	if (sensor_id == -1)
-		return 0;
-
-	mutex_lock(&data->thermal_lock);
-	data->irq_bind_sensor = sensor_id;
-	mutex_unlock(&data->thermal_lock);
-
 	dev_dbg(&data->pdev->dev, "id=%d, irq=%d, temp=%d, thres=%d\n",
 		sensor->id, data->irq_enabled, *temp, sensor->thres_temp);
 	/*
@@ -218,7 +195,7 @@ static int hisi_thermal_get_temp(void *_
 		return 0;
 	}
 
-	if (max_temp < sensor->thres_temp) {
+	if (*temp < sensor->thres_temp) {
 		data->irq_enabled = true;
 		hisi_thermal_enable_bind_irq_sensor(data);
 		enable_irq(data->irq);
@@ -245,22 +222,16 @@ static irqreturn_t hisi_thermal_alarm_ir
 {
 	struct hisi_thermal_data *data = dev;
 	struct hisi_thermal_sensor *sensor;
-	int i;
 
 	mutex_lock(&data->thermal_lock);
-	sensor = &data->sensors[data->irq_bind_sensor];
+	sensor = &data->sensors;
 
 	dev_crit(&data->pdev->dev, "THERMAL ALARM: T > %d\n",
 		 sensor->thres_temp);
 	mutex_unlock(&data->thermal_lock);
 
-	for (i = 0; i < HISI_MAX_SENSORS; i++) {
-		if (!data->sensors[i].tzd)
-			continue;
-
-		thermal_zone_device_update(data->sensors[i].tzd,
-					   THERMAL_EVENT_UNSPECIFIED);
-	}
+	thermal_zone_device_update(data->sensors.tzd,
+				   THERMAL_EVENT_UNSPECIFIED);
 
 	return IRQ_HANDLED;
 }
@@ -317,7 +288,6 @@ static int hisi_thermal_probe(struct pla
 {
 	struct hisi_thermal_data *data;
 	struct resource *res;
-	int i;
 	int ret;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
@@ -359,14 +329,13 @@ static int hisi_thermal_probe(struct pla
 	hisi_thermal_enable_bind_irq_sensor(data);
 	data->irq_enabled = true;
 
-	for (i = 0; i < HISI_MAX_SENSORS; ++i) {
-		ret = hisi_thermal_register_sensor(pdev, data,
-						   &data->sensors[i], i);
-		if (ret)
-			dev_err(&pdev->dev,
-				"failed to register thermal sensor: %d\n", ret);
-		else
-			hisi_thermal_toggle_sensor(&data->sensors[i], true);
+	ret = hisi_thermal_register_sensor(pdev, data,
+					   &data->sensors,
+					   HISI_DEFAULT_SENSOR);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register thermal sensor: %d\n",
+			ret);
+		return ret;
 	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, data->irq,
@@ -378,6 +347,8 @@ static int hisi_thermal_probe(struct pla
 		return ret;
 	}
 
+	hisi_thermal_toggle_sensor(&data->sensors, true);
+
 	enable_irq(data->irq);
 
 	return 0;
@@ -386,17 +357,9 @@ static int hisi_thermal_probe(struct pla
 static int hisi_thermal_remove(struct platform_device *pdev)
 {
 	struct hisi_thermal_data *data = platform_get_drvdata(pdev);
-	int i;
-
-	for (i = 0; i < HISI_MAX_SENSORS; i++) {
-		struct hisi_thermal_sensor *sensor = &data->sensors[i];
-
-		if (!sensor->tzd)
-			continue;
-
-		hisi_thermal_toggle_sensor(sensor, false);
-	}
+	struct hisi_thermal_sensor *sensor = &data->sensors;
 
+	hisi_thermal_toggle_sensor(sensor, false);
 	hisi_thermal_disable_sensor(data);
 	clk_disable_unprepare(data->clk);
 


