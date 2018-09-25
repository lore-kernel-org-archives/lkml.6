Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8D6C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A51520877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KM+fLMLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A51520877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbeIYPKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:10:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35540 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728559AbeIYPKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:10:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id o16so9159085wrx.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 02:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B/n+YtvzBVLiSdVatyBy/SAfk8TXmG/YGKWWQu5FHyA=;
        b=KM+fLMLgAtVQ6xfbHs0UQ7I/JbpTkxZz5SZVWDJdJ+JmlMxOk9U46qFHjE/DWvHi1p
         OokmN5ZIS8bWWyoEPYrmf42HIgs4P8DEqvVivJBZinAowF0rt4V92+qC2ynHUF62dcEb
         OzQoR0KNoHJWvpOCTkwgX8ZvGe6hYsgMDhcVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B/n+YtvzBVLiSdVatyBy/SAfk8TXmG/YGKWWQu5FHyA=;
        b=PxrHwJKmuFiHZIkX1vfs5zqPx0hazGCkHCXM4e30g1gAZqwOA+p3iY35RJSvTZrS4a
         I1iCEzyPdRO9LIhYb1qv37HZ37kyGXNWnrpNAUmkX4jNXVRYC027FQcPpFnT7P2eK5TQ
         eSRxLEyl9cUzQdnXy8vXYO4n5b5qt3EXwKteXpi5ZTzGZjf0Ta4eSfd2ZiDEuq6485uf
         tXtzKWnB1rKCkewPmiIS11+L0lYlgGpl4+Sq6fkfm9Qf3rLrZgfrfsSAt72zHMa1tON9
         Sfx06qO4oJ771vuB//RY2P73d/5XEfp638luMqVGvhJKxJ3Yk87GmOdg60EKE7qEHj+s
         x+KA==
X-Gm-Message-State: ABuFfohmiTsFUU1tFHG6+B+fv+PlzeS6jRMJW6jV3fr4Zi6ae/KDJzkP
        O6oWi1WnCI6QG8+5SxJ8aRKdTQ==
X-Google-Smtp-Source: ACcGV620Nr6oA7oi55omovmBdbQuRa8B16xOGsnxLgBP5k7rPh1/BQboaxY4+4SsCyuY8AY1zFqEhQ==
X-Received: by 2002:a5d:5391:: with SMTP id d17-v6mr11507wrv.191.1537866254938;
        Tue, 25 Sep 2018 02:04:14 -0700 (PDT)
Received: from localhost.localdomain (251.150.136.77.rev.sfr.net. [77.136.150.251])
        by smtp.gmail.com with ESMTPSA id y206-v6sm1523828wmg.14.2018.09.25.02.04.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Sep 2018 02:04:03 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     edubezval@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, leo.yan@linaro.org,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 05/14] thermal/drivers/hisi: Prepare to support multiple sensors
Date:   Tue, 25 Sep 2018 11:03:03 +0200
Message-Id: <1537866192-12320-6-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the 'sensor' field to a pointer and propagate the change in
the file. Havintg a pointer, gives us the opportunity to define
multiple sensors.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 7287818..87b82fb 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -77,10 +77,11 @@ struct hisi_thermal_ops {
 
 struct hisi_thermal_data {
 	const struct hisi_thermal_ops *ops;
-	struct hisi_thermal_sensor sensor;
+	struct hisi_thermal_sensor *sensor;
 	struct platform_device *pdev;
 	struct clk *clk;
 	void __iomem *regs;
+	int nr_sensors;
 	int irq;
 };
 
@@ -401,14 +402,29 @@ static int hi6220_thermal_probe(struct hisi_thermal_data *data)
 		return ret;
 	}
 
-	data->sensor.id = HI6220_DEFAULT_SENSOR;
+	data->sensor = devm_kzalloc(dev, sizeof(*data->sensor), GFP_KERNEL);
+	if (!data->sensor)
+		return -ENOMEM;
+
+	data->sensor[0].id = HI6220_DEFAULT_SENSOR;
+	data->sensor[0].data = data;
+	data->nr_sensors = 1;
 
 	return 0;
 }
 
 static int hi3660_thermal_probe(struct hisi_thermal_data *data)
 {
-	data->sensor.id = HI3660_DEFAULT_SENSOR;
+	struct platform_device *pdev = data->pdev;
+	struct device *dev = &pdev->dev;
+
+	data->sensor = devm_kzalloc(dev, sizeof(*data->sensor), GFP_KERNEL);
+	if (!data->sensor)
+		return -ENOMEM;
+
+	data->sensor[0].id = HI3660_DEFAULT_SENSOR;
+	data->sensor[0].data = data;
+	data->nr_sensors = 1;
 
 	return 0;
 }
@@ -433,7 +449,7 @@ static const struct thermal_zone_of_device_ops hisi_of_thermal_ops = {
 static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
 {
 	struct hisi_thermal_data *data = dev;
-	struct hisi_thermal_sensor *sensor = &data->sensor;
+	struct hisi_thermal_sensor *sensor = &data->sensor[0];
 	int temp = 0;
 
 	data->ops->irq_handler(sensor);
@@ -444,7 +460,7 @@ static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
 		dev_crit(&data->pdev->dev, "THERMAL ALARM: %d > %d\n",
 			 temp, sensor->thres_temp);
 
-		thermal_zone_device_update(data->sensor.tzd,
+		thermal_zone_device_update(data->sensor[0].tzd,
 					   THERMAL_EVENT_UNSPECIFIED);
 
 	} else {
@@ -535,7 +551,6 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 
 	data->pdev = pdev;
 	platform_set_drvdata(pdev, data);
-	data->sensor.data = data;
 	data->ops = of_device_get_match_data(dev);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -553,13 +568,13 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = hisi_thermal_register_sensor(pdev, &data->sensor);
+	ret = hisi_thermal_register_sensor(pdev, &data->sensor[0]);
 	if (ret) {
 		dev_err(dev, "failed to register thermal sensor: %d\n", ret);
 		return ret;
 	}
 
-	ret = data->ops->enable_sensor(&data->sensor);
+	ret = data->ops->enable_sensor(&data->sensor[0]);
 	if (ret) {
 		dev_err(dev, "Failed to setup the sensor: %d\n", ret);
 		return ret;
@@ -575,7 +590,7 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 		}
 	}
 
-	hisi_thermal_toggle_sensor(&data->sensor, true);
+	hisi_thermal_toggle_sensor(&data->sensor[0], true);
 
 	return 0;
 }
@@ -583,11 +598,11 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 static int hisi_thermal_remove(struct platform_device *pdev)
 {
 	struct hisi_thermal_data *data = platform_get_drvdata(pdev);
-	struct hisi_thermal_sensor *sensor = &data->sensor;
+	struct hisi_thermal_sensor *sensor = &data->sensor[0];
 
 	hisi_thermal_toggle_sensor(sensor, false);
 
-	data->ops->disable_sensor(&data->sensor);
+	data->ops->disable_sensor(sensor);
 
 	return 0;
 }
@@ -597,7 +612,7 @@ static int hisi_thermal_suspend(struct device *dev)
 {
 	struct hisi_thermal_data *data = dev_get_drvdata(dev);
 
-	data->ops->disable_sensor(&data->sensor);
+	data->ops->disable_sensor(&data->sensor[0]);
 
 	return 0;
 }
@@ -606,7 +621,7 @@ static int hisi_thermal_resume(struct device *dev)
 {
 	struct hisi_thermal_data *data = dev_get_drvdata(dev);
 
-	return data->ops->enable_sensor(&data->sensor);
+	return data->ops->enable_sensor(&data->sensor[0]);
 }
 #endif
 
-- 
2.7.4

