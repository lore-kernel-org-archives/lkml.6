Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2ABAC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590D920877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sb0oe1lb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 590D920877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbeIYPLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:11:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39758 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbeIYPLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:11:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id s14-v6so22455385wrw.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 02:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WEayJ7v/hmTPrXvagArEZzBi0kAZmXnqnjkohn08PO0=;
        b=Sb0oe1lbClXkht5v1ucQ3Geuyw1Ij5+Gor0f/HIPYD6vunyMzaHIsQXNOU94M6JgPR
         /xx/ji5DaC/y69kOUsBpzHZwzBe+f6wfR7nTUaRL1GqcYR/Qszu4BTwADC/H6Sz5Ctp8
         oOPFPbXb2d2JxKGgMgBxIA2m5jg18jipV/6E0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WEayJ7v/hmTPrXvagArEZzBi0kAZmXnqnjkohn08PO0=;
        b=GAXxPmy5ujvUnMt9Tr7ro/Uw+ymPoMNA8f0cggfHpFVhpXuLF0PxoNiInA5BGX7JGH
         p+bIze74W6AgDgW/07bP1hEMKKaFQuZfdIFG5hp/bJZ08tfCcVYCrck5VwJFIVuKGT5b
         uEZRYXKdlJvM2WaaFLMPIVmHxdCWvu6lL2TzzYSWBc6g943HnPk2Fp+lHrXEkjz1RMWJ
         YVyGRwyvcW2VpMke5GddjjxKMA8SrP2ghpOhMkellYiiD4E1vw0TY0aB76XdM47oA0LJ
         yhcWiHhKbSMHjnhIABhDHvskuqNSErJth/JmfegPg8T66sF+zG7bZggy2/HA+Dzo2QAq
         YMAA==
X-Gm-Message-State: ABuFfog3+pn5k5wJkmcg9Fc6Zn2jStI3uprasIZsC2Zh6Iy3nP4Y+cis
        Kz+W43zn09VV1UKxC4u7a0zZCQ==
X-Google-Smtp-Source: ACcGV63CfrfPsly/btiBIuAuGid3UQ/py6M/MKulwWcpEQhMRzT/QS/Wu+nIbTz6WW5Aq7xYVLEd7w==
X-Received: by 2002:a5d:448d:: with SMTP id j13-v6mr40153wrq.236.1537866266930;
        Tue, 25 Sep 2018 02:04:26 -0700 (PDT)
Received: from localhost.localdomain (251.150.136.77.rev.sfr.net. [77.136.150.251])
        by smtp.gmail.com with ESMTPSA id y206-v6sm1523828wmg.14.2018.09.25.02.04.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Sep 2018 02:04:25 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     edubezval@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, leo.yan@linaro.org,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 06/14] thermal/drivers/hisi: Add multiple sensors support
Date:   Tue, 25 Sep 2018 11:03:04 +0200
Message-Id: <1537866192-12320-7-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the code as it is dealing with several sensors.

For git-bisect compatibility (compilation and booting), assume the DT
is not yet changed and we have a single interrupt.

Next changes will support multiple interrupt sorted by their name.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 79 +++++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 32 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 87b82fb..a5756f6 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -448,8 +448,8 @@ static const struct thermal_zone_of_device_ops hisi_of_thermal_ops = {
 
 static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
 {
-	struct hisi_thermal_data *data = dev;
-	struct hisi_thermal_sensor *sensor = &data->sensor[0];
+	struct hisi_thermal_sensor *sensor = dev;
+	struct hisi_thermal_data *data = sensor->data;
 	int temp = 0;
 
 	data->ops->irq_handler(sensor);
@@ -457,15 +457,17 @@ static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
 	hisi_thermal_get_temp(sensor, &temp);
 
 	if (temp >= sensor->thres_temp) {
-		dev_crit(&data->pdev->dev, "THERMAL ALARM: %d > %d\n",
-			 temp, sensor->thres_temp);
+		dev_crit(&data->pdev->dev,
+			 "sensor <%d> THERMAL ALARM: %d > %d\n",
+			 sensor->id, temp, sensor->thres_temp);
 
-		thermal_zone_device_update(data->sensor[0].tzd,
+		thermal_zone_device_update(sensor->tzd,
 					   THERMAL_EVENT_UNSPECIFIED);
 
 	} else {
-		dev_crit(&data->pdev->dev, "THERMAL ALARM stopped: %d < %d\n",
-			 temp, sensor->thres_temp);
+		dev_crit(&data->pdev->dev,
+			 "sensor <%d> THERMAL ALARM stopped: %d < %d\n",
+			 sensor->id, temp, sensor->thres_temp);
 	}
 
 	return IRQ_HANDLED;
@@ -543,7 +545,7 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 	struct hisi_thermal_data *data;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
-	int ret;
+	int i, ret;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -560,37 +562,41 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 		return PTR_ERR(data->regs);
 	}
 
-	data->irq = platform_get_irq(pdev, 0);
-	if (data->irq < 0)
-		return data->irq;
-
 	ret = data->ops->probe(data);
 	if (ret)
 		return ret;
 
-	ret = hisi_thermal_register_sensor(pdev, &data->sensor[0]);
-	if (ret) {
-		dev_err(dev, "failed to register thermal sensor: %d\n", ret);
-		return ret;
-	}
+	for (i = 0; i < data->nr_sensors; i++) {
+		struct hisi_thermal_sensor *sensor = &data->sensor[i];
 
-	ret = data->ops->enable_sensor(&data->sensor[0]);
-	if (ret) {
-		dev_err(dev, "Failed to setup the sensor: %d\n", ret);
-		return ret;
-	}
+		ret = hisi_thermal_register_sensor(pdev, sensor);
+		if (ret) {
+			dev_err(dev, "failed to register thermal sensor: %d\n",
+				ret);
+			return ret;
+		}
+
+		data->irq = platform_get_irq(pdev, 0);
+		if (data->irq < 0)
+			return data->irq;
 
-	if (data->irq) {
 		ret = devm_request_threaded_irq(dev, data->irq, NULL,
-				hisi_thermal_alarm_irq_thread,
-				IRQF_ONESHOT, "hisi_thermal", data);
+						hisi_thermal_alarm_irq_thread,
+						IRQF_ONESHOT, "hisi_thermal",
+						sensor);
 		if (ret < 0) {
 			dev_err(dev, "failed to request alarm irq: %d\n", ret);
 			return ret;
 		}
-	}
 
-	hisi_thermal_toggle_sensor(&data->sensor[0], true);
+		ret = data->ops->enable_sensor(sensor);
+		if (ret) {
+			dev_err(dev, "Failed to setup the sensor: %d\n", ret);
+			return ret;
+		}
+
+		hisi_thermal_toggle_sensor(sensor, true);
+	}
 
 	return 0;
 }
@@ -598,11 +604,14 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 static int hisi_thermal_remove(struct platform_device *pdev)
 {
 	struct hisi_thermal_data *data = platform_get_drvdata(pdev);
-	struct hisi_thermal_sensor *sensor = &data->sensor[0];
+	int i;
 
-	hisi_thermal_toggle_sensor(sensor, false);
+	for (i = 0; i < data->nr_sensors; i++) {
+		struct hisi_thermal_sensor *sensor = &data->sensor[i];
 
-	data->ops->disable_sensor(sensor);
+		hisi_thermal_toggle_sensor(sensor, false);
+		data->ops->disable_sensor(sensor);
+	}
 
 	return 0;
 }
@@ -611,8 +620,10 @@ static int hisi_thermal_remove(struct platform_device *pdev)
 static int hisi_thermal_suspend(struct device *dev)
 {
 	struct hisi_thermal_data *data = dev_get_drvdata(dev);
+	int i;
 
-	data->ops->disable_sensor(&data->sensor[0]);
+	for (i = 0; i < data->nr_sensors; i++)
+		data->ops->disable_sensor(&data->sensor[i]);
 
 	return 0;
 }
@@ -620,8 +631,12 @@ static int hisi_thermal_suspend(struct device *dev)
 static int hisi_thermal_resume(struct device *dev)
 {
 	struct hisi_thermal_data *data = dev_get_drvdata(dev);
+	int i, ret = 0;
+
+	for (i = 0; i < data->nr_sensors; i++)
+		ret |= data->ops->enable_sensor(&data->sensor[i]);
 
-	return data->ops->enable_sensor(&data->sensor[0]);
+	return ret;
 }
 #endif
 
-- 
2.7.4

