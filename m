Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CE4C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1152D20851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aWUYb0pD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1152D20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbeLCNcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:32:19 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34034 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeLCNcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 08:32:18 -0500
Received: by mail-qk1-f195.google.com with SMTP id a132so7291923qkg.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 05:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A2F6pDiQKGzz6oIk7/k7tBCF05mIb2PLp1W0NJSuOD0=;
        b=aWUYb0pDM8TN4MJwh7SGnXQrA9R28l+VNusyVE0faDzsIjokebAFFXlB+A6JYoAPQX
         GNR8Aubkj1A+4eZlJSCzOzerIKM+me0o4mIgC6+9IArY0Al5DWKgV5o/xsb7iHFWq9SE
         28L08ILYAX57Tai848BId15KyUJwvywCrylRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A2F6pDiQKGzz6oIk7/k7tBCF05mIb2PLp1W0NJSuOD0=;
        b=XgTcrUCpszeIST1Pys6EUHTAXRwD9chNz/9UQjOcnHZYl3ali2AjL1BrFu2rdZMo6A
         jOtdf+ygyyRYEVb8JIQgMBl9D28ULkcdFhLkH1LTOF9snVRYwbrMw0D5VRaCFi770ygz
         vzL+D8aOh9u1pAD8L4zmm7UHO7ImTD/i0w3O+k21cV0ol8fa9Su3P+edtlCpQO5eAG5f
         aCnZDdtEhsoVww0KQAtEe8LuNyfo0Ru0xywBbh64+nyLAjUmIlWQehhFiiLX/Uoh3ejd
         8TZ1Z3IbXz7DarihMuN0AZUTv+JIM8F8iqzqJq3grzmfupYP4nWp0EUy8rad6fg0DCWV
         62Aw==
X-Gm-Message-State: AA+aEWawODG+iT11aoSi3pjnDUV5F+/mWhai3jcJr5ikbUVC2L5S73A4
        StjZqLkFo1feXjo+2A8lbNEJCg==
X-Google-Smtp-Source: AFSGD/XVXXxOvn0+5bBxEaWlrqCsRfrV1RZNtAcmj0px8oUuhk1L60WpfpvHAQ/3oyJ/Mck7kP+LoA==
X-Received: by 2002:a37:59c4:: with SMTP id n187mr15318058qkb.156.1543843875747;
        Mon, 03 Dec 2018 05:31:15 -0800 (PST)
Received: from workstation.celeiro.br ([138.204.25.29])
        by smtp.gmail.com with ESMTPSA id r56sm8619112qtj.30.2018.12.03.05.31.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 05:31:15 -0800 (PST)
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
To:     sashal@kernel.org
Cc:     rafael.tinoco@linaro.org, gregkh@linuxfoundation.org,
        rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 1/5] thermal/drivers/hisi: Remove the multiple sensors support
Date:   Mon,  3 Dec 2018 11:31:03 -0200
Message-Id: <20181203133107.4002-2-rafael.tinoco@linaro.org>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181203133107.4002-1-rafael.tinoco@linaro.org>
References: <20181203133107.4002-1-rafael.tinoco@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Lezcano <daniel.lezcano@linaro.org>

commit ff4ec2997df8fe7cc40513dbe5f86d9f88fb6be7 upstream.

By essence, the tsensor does not really support multiple sensor at the same
time. It allows to set a sensor and use it to get the temperature, another
sensor could be switched but with a delay of 3-5ms. It is difficult to read
simultaneously several sensors without a big delay.

Today, just one sensor is used, it is not necessary to deal with multiple
sensors in the code. Remove them and if it is needed in the future add them
on top of a code which will be clean up in the meantime.

Link: https://bugs.linaro.org/show_bug.cgi?id=4053 (PATCH 1/5)
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Wangtao (Kevin, Kirin) <kevin.wangtao@hisilicon.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
(cherry picked from commit ff4ec2997df8fe7cc40513dbe5f86d9f88fb6be7)
Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 75 +++++++++-------------------------
 1 file changed, 19 insertions(+), 56 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 6d8906d65476..aecbfe9fc8f2 100644
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
@@ -133,7 +133,7 @@ static void hisi_thermal_enable_bind_irq_sensor
 
 	mutex_lock(&data->thermal_lock);
 
-	sensor = &data->sensors[data->irq_bind_sensor];
+	sensor = &data->sensors;
 
 	/* setting the hdak time */
 	writel(0x0, data->regs + TEMP0_CFG);
@@ -181,31 +181,8 @@ static int hisi_thermal_get_temp(void *_sensor, int *temp)
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
@@ -218,7 +195,7 @@ static int hisi_thermal_get_temp(void *_sensor, int *temp)
 		return 0;
 	}
 
-	if (max_temp < sensor->thres_temp) {
+	if (*temp < sensor->thres_temp) {
 		data->irq_enabled = true;
 		hisi_thermal_enable_bind_irq_sensor(data);
 		enable_irq(data->irq);
@@ -245,22 +222,16 @@ static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
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
@@ -317,7 +288,6 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 {
 	struct hisi_thermal_data *data;
 	struct resource *res;
-	int i;
 	int ret;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
@@ -359,14 +329,13 @@ static int hisi_thermal_probe(struct platform_device *pdev)
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
@@ -378,6 +347,8 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	hisi_thermal_toggle_sensor(&data->sensors, true);
+
 	enable_irq(data->irq);
 
 	return 0;
@@ -386,17 +357,9 @@ static int hisi_thermal_probe(struct platform_device *pdev)
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
 
-- 
2.20.0.rc1

