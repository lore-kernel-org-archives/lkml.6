Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AAEC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9695A20877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cbdFeuBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9695A20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbeIYPKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:10:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35470 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbeIYPKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:10:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id o16so9157172wrx.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 02:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JKtye1UkuEcXKPFhNVW7GNxXrGnc1c47iAdiNPq2Uxg=;
        b=cbdFeuBrE/DKJJz1QSZJFGPjEAFse41UeHzPKMZERRGt78pGqap+46Di+4OVPQcwzE
         l6jZrWxI0t16pbiLxIBXRHXKQZh+1cJgRSvKvA4223WBrOP7jJw9txR+eBP5fzsDoxC1
         wDgRHAuoHLqv4a0XOIhNGzjKfsHOWV2R9cHJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JKtye1UkuEcXKPFhNVW7GNxXrGnc1c47iAdiNPq2Uxg=;
        b=fce6h2nGMn7fPFswUlS5y35E2XhAMe4EB7UZWvWhOdpKqBQWNZhQ6oEggFzBio5Z8S
         NgyEa2suR8UpF1mWfxMEnjiIQP75nsSJ56S1qRk8Es0jTc4TUO4DdWdPkwalHG7GcIoI
         fyfKpenIvCg1RQ5pvULzFNHqpvmBrvosFgWvnLAQeC7Ch2Chu8Qpa/TCZVpqkm5ThDzm
         5tOsqY4jyCuCD1QrNeVHGr675ORD0s/mhBmWopFfzOVgy0XaNNmQ3oPb4Xesda3DmmoF
         69TZ6Ga5QPaItLYG1Jkwcv7b2AJvJNMBIPYhv3NvhuAgFTQsTr8hBNY+KYMFmAidfSKC
         rOpw==
X-Gm-Message-State: ABuFfojLWZR/VG9YQMoRG7avzmhd1nxivwQEFqF7/lsjyvj02bJnWjJq
        U6l7RFvSRc6XLMRk7W3A0X2K+w==
X-Google-Smtp-Source: ACcGV60hy0uv8FF5bS7cCENqvmk2aNuViXQFWD2ZPkRUG8aCrpwxXVFml2l2Lo4a78zSzRwC00d3Dw==
X-Received: by 2002:adf:80a3:: with SMTP id 32-v6mr1131wrl.231.1537866225446;
        Tue, 25 Sep 2018 02:03:45 -0700 (PDT)
Received: from localhost.localdomain (251.150.136.77.rev.sfr.net. [77.136.150.251])
        by smtp.gmail.com with ESMTPSA id y206-v6sm1523828wmg.14.2018.09.25.02.03.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Sep 2018 02:03:42 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     edubezval@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, leo.yan@linaro.org,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 02/14] thermal/drivers/hisi: Change the driver to be sensor oriented
Date:   Tue, 25 Sep 2018 11:03:00 +0200
Message-Id: <1537866192-12320-3-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support multiple sensors, we have to change the code to
deal with sensors and not the hisi thermal structure.

Add a back pointer to the hisi thermal structure (containerof is not a
good option because later we convert the sensor field to a pointer).

Change the functions parameters to take a sensor instead of this hisi
thermal 'data' structure.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 72 ++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 30 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 9794cfe..1fdda55 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -58,27 +58,28 @@
 #define HI6220_DEFAULT_SENSOR		2
 #define HI3660_DEFAULT_SENSOR		1
 
+struct hisi_thermal_data;
+
 struct hisi_thermal_sensor {
+	struct hisi_thermal_data *data;
 	struct thermal_zone_device *tzd;
 	uint32_t id;
 	uint32_t thres_temp;
 };
 
-struct hisi_thermal_data;
-
 struct hisi_thermal_ops {
-	int (*get_temp)(struct hisi_thermal_data *data);
-	int (*enable_sensor)(struct hisi_thermal_data *data);
-	int (*disable_sensor)(struct hisi_thermal_data *data);
-	int (*irq_handler)(struct hisi_thermal_data *data);
+	int (*get_temp)(struct hisi_thermal_sensor *sensor);
+	int (*enable_sensor)(struct hisi_thermal_sensor *sensor);
+	int (*disable_sensor)(struct hisi_thermal_sensor *sensor);
+	int (*irq_handler)(struct hisi_thermal_sensor *sensor);
 	int (*probe)(struct hisi_thermal_data *data);
 };
 
 struct hisi_thermal_data {
 	const struct hisi_thermal_ops *ops;
+	struct hisi_thermal_sensor sensor;
 	struct platform_device *pdev;
 	struct clk *clk;
-	struct hisi_thermal_sensor sensor;
 	void __iomem *regs;
 	int irq;
 };
@@ -273,30 +274,40 @@ static inline void hi6220_thermal_hdak_set(void __iomem *addr, int value)
 	       (value << 4), addr + HI6220_TEMP0_CFG);
 }
 
-static int hi6220_thermal_irq_handler(struct hisi_thermal_data *data)
+static int hi6220_thermal_irq_handler(struct hisi_thermal_sensor *sensor)
 {
+	struct hisi_thermal_data *data = sensor->data;
+
 	hi6220_thermal_alarm_clear(data->regs, 1);
 	return 0;
 }
 
-static int hi3660_thermal_irq_handler(struct hisi_thermal_data *data)
+static int hi3660_thermal_irq_handler(struct hisi_thermal_sensor *sensor)
 {
-	hi3660_thermal_alarm_clear(data->regs, data->sensor.id, 1);
+	struct hisi_thermal_data *data = sensor->data;
+
+	hi3660_thermal_alarm_clear(data->regs, sensor->id, 1);
 	return 0;
 }
 
-static int hi6220_thermal_get_temp(struct hisi_thermal_data *data)
+static int hi6220_thermal_get_temp(struct hisi_thermal_sensor *sensor)
 {
+	struct hisi_thermal_data *data = sensor->data;
+
 	return hi6220_thermal_get_temperature(data->regs);
 }
 
-static int hi3660_thermal_get_temp(struct hisi_thermal_data *data)
+static int hi3660_thermal_get_temp(struct hisi_thermal_sensor *sensor)
 {
-	return hi3660_thermal_get_temperature(data->regs, data->sensor.id);
+	struct hisi_thermal_data *data = sensor->data;
+
+	return hi3660_thermal_get_temperature(data->regs, sensor->id);
 }
 
-static int hi6220_thermal_disable_sensor(struct hisi_thermal_data *data)
+static int hi6220_thermal_disable_sensor(struct hisi_thermal_sensor *sensor)
 {
+	struct hisi_thermal_data *data = sensor->data;
+
 	/* disable sensor module */
 	hi6220_thermal_enable(data->regs, 0);
 	hi6220_thermal_alarm_enable(data->regs, 0);
@@ -307,16 +318,18 @@ static int hi6220_thermal_disable_sensor(struct hisi_thermal_data *data)
 	return 0;
 }
 
-static int hi3660_thermal_disable_sensor(struct hisi_thermal_data *data)
+static int hi3660_thermal_disable_sensor(struct hisi_thermal_sensor *sensor)
 {
+	struct hisi_thermal_data *data = sensor->data;
+
 	/* disable sensor module */
-	hi3660_thermal_alarm_enable(data->regs, data->sensor.id, 0);
+	hi3660_thermal_alarm_enable(data->regs, sensor->id, 0);
 	return 0;
 }
 
-static int hi6220_thermal_enable_sensor(struct hisi_thermal_data *data)
+static int hi6220_thermal_enable_sensor(struct hisi_thermal_sensor *sensor)
 {
-	struct hisi_thermal_sensor *sensor = &data->sensor;
+	struct hisi_thermal_data *data = sensor->data;
 	int ret;
 
 	/* enable clock for tsensor */
@@ -352,10 +365,10 @@ static int hi6220_thermal_enable_sensor(struct hisi_thermal_data *data)
 	return 0;
 }
 
-static int hi3660_thermal_enable_sensor(struct hisi_thermal_data *data)
+static int hi3660_thermal_enable_sensor(struct hisi_thermal_sensor *sensor)
 {
 	unsigned int value;
-	struct hisi_thermal_sensor *sensor = &data->sensor;
+	struct hisi_thermal_data *data = sensor->data;
 
 	/* disable interrupt */
 	hi3660_thermal_alarm_enable(data->regs, sensor->id, 0);
@@ -432,7 +445,7 @@ static int hisi_thermal_get_temp(void *__data, int *temp)
 	struct hisi_thermal_data *data = __data;
 	struct hisi_thermal_sensor *sensor = &data->sensor;
 
-	*temp = data->ops->get_temp(data);
+	*temp = data->ops->get_temp(sensor);
 
 	dev_dbg(&data->pdev->dev, "id=%d, temp=%d, thres=%d\n",
 		sensor->id, *temp, sensor->thres_temp);
@@ -450,7 +463,7 @@ static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
 	struct hisi_thermal_sensor *sensor = &data->sensor;
 	int temp = 0;
 
-	data->ops->irq_handler(data);
+	data->ops->irq_handler(sensor);
 
 	hisi_thermal_get_temp(data, &temp);
 
@@ -470,10 +483,10 @@ static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
 }
 
 static int hisi_thermal_register_sensor(struct platform_device *pdev,
-					struct hisi_thermal_data *data,
 					struct hisi_thermal_sensor *sensor)
 {
 	int ret, i;
+	struct hisi_thermal_data *data = sensor->data;
 	const struct thermal_trip *trip;
 
 	sensor->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev,
@@ -549,21 +562,20 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 
 	data->pdev = pdev;
 	platform_set_drvdata(pdev, data);
-
+	data->sensor.data = data;
 	data->ops = of_device_get_match_data(dev);
 
 	ret = data->ops->probe(data);
 	if (ret)
 		return ret;
 
-	ret = hisi_thermal_register_sensor(pdev, data,
-					   &data->sensor);
+	ret = hisi_thermal_register_sensor(pdev, &data->sensor);
 	if (ret) {
 		dev_err(dev, "failed to register thermal sensor: %d\n", ret);
 		return ret;
 	}
 
-	ret = data->ops->enable_sensor(data);
+	ret = data->ops->enable_sensor(&data->sensor);
 	if (ret) {
 		dev_err(dev, "Failed to setup the sensor: %d\n", ret);
 		return ret;
@@ -591,7 +603,7 @@ static int hisi_thermal_remove(struct platform_device *pdev)
 
 	hisi_thermal_toggle_sensor(sensor, false);
 
-	data->ops->disable_sensor(data);
+	data->ops->disable_sensor(&data->sensor);
 
 	return 0;
 }
@@ -601,7 +613,7 @@ static int hisi_thermal_suspend(struct device *dev)
 {
 	struct hisi_thermal_data *data = dev_get_drvdata(dev);
 
-	data->ops->disable_sensor(data);
+	data->ops->disable_sensor(&data->sensor);
 
 	return 0;
 }
@@ -610,7 +622,7 @@ static int hisi_thermal_resume(struct device *dev)
 {
 	struct hisi_thermal_data *data = dev_get_drvdata(dev);
 
-	return data->ops->enable_sensor(data);
+	return data->ops->enable_sensor(&data->sensor);
 }
 #endif
 
-- 
2.7.4

