Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F13C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1231921480
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TX+zyk2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1231921480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbeIYPKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:10:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51434 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbeIYPKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:10:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id y25-v6so5068185wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 02:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OZ13DAcracUk8ECXRhZzoH+2ruBFRvOw19LoCvex9TQ=;
        b=TX+zyk2yMB85ok2KiqzJvZnSaiL9mgIg40Cql/dIOJgkjKtACF146jhkyKkuqVe5MW
         MMk8FW7QNx98TzIo+hNdYV5yDiVV1X0bV5+59jVE2ln28Y1Y74DobGx55stxdKmXOSOI
         lc01di//q6BRsnZchp2qAOhPKhA50VB9ID/pY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OZ13DAcracUk8ECXRhZzoH+2ruBFRvOw19LoCvex9TQ=;
        b=ceeNqghsMr39QRVfJkzqmBLcGTjOJ5EjH44pe4yU/wJ9pEoFNOYyBexPGIKXp+AyB6
         WESha3wTrVZDX5l/2M7l622zCPKoL4GiGltEuBKgllhQ+1n6aaO39s67gKPh+W5AU35b
         CvnAE4PfaflSITrQ5FXX+FXiXuNYne++zZ4b1pn+DrzbBr1zbLvphtJIT91A4wdYTAEi
         QWoHIwB664P/f9+gAnXnsQiDp60Ep6HqcclkyB7Qzxc4efMHkcjEnVRYlrLKjJ5Qba83
         Eid2deRtExwbGYb5syIes+1o4XAyLbS7vAzwVKn2Lzs3OMpODBBN7LuuUrj1PKiuTgVh
         KlUg==
X-Gm-Message-State: ABuFfojOdjxoFNTQ/3+1Y1kCyrWf1d1oxeewvEwv7cVzCkvBpVzqIRgZ
        g3cgm++hVJX+IcpY5LfY9mzLuw==
X-Google-Smtp-Source: ACcGV6095yJNvkrVkcdlv9gJ0yMzrFsOoQymXOwzGfvMKJyALnatN9g6Wt+aswH7g+n6SI9FlOBfRw==
X-Received: by 2002:a1c:f11a:: with SMTP id p26-v6mr68368wmh.92.1537866220410;
        Tue, 25 Sep 2018 02:03:40 -0700 (PDT)
Received: from localhost.localdomain (251.150.136.77.rev.sfr.net. [77.136.150.251])
        by smtp.gmail.com with ESMTPSA id y206-v6sm1523828wmg.14.2018.09.25.02.03.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Sep 2018 02:03:35 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     edubezval@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, leo.yan@linaro.org,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 01/14] thermal/drivers/hisi: Change the platform data pointer to sensor ops
Date:   Tue, 25 Sep 2018 11:02:59 +0200
Message-Id: <1537866192-12320-2-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group the temperature sensor specific ops into a single structure and
assign it to hisi thermal data structure.

Change the platform data pointer to reference the specific sensor ops
instead of the probe functions.

Moving out those allow to split the code to self-encapsulate the
sensor object.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 60 ++++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 761d055..9794cfe 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -64,11 +64,18 @@ struct hisi_thermal_sensor {
 	uint32_t thres_temp;
 };
 
-struct hisi_thermal_data {
+struct hisi_thermal_data;
+
+struct hisi_thermal_ops {
 	int (*get_temp)(struct hisi_thermal_data *data);
 	int (*enable_sensor)(struct hisi_thermal_data *data);
 	int (*disable_sensor)(struct hisi_thermal_data *data);
 	int (*irq_handler)(struct hisi_thermal_data *data);
+	int (*probe)(struct hisi_thermal_data *data);
+};
+
+struct hisi_thermal_data {
+	const struct hisi_thermal_ops *ops;
 	struct platform_device *pdev;
 	struct clk *clk;
 	struct hisi_thermal_sensor sensor;
@@ -374,11 +381,6 @@ static int hi6220_thermal_probe(struct hisi_thermal_data *data)
 	struct resource *res;
 	int ret;
 
-	data->get_temp = hi6220_thermal_get_temp;
-	data->enable_sensor = hi6220_thermal_enable_sensor;
-	data->disable_sensor = hi6220_thermal_disable_sensor;
-	data->irq_handler = hi6220_thermal_irq_handler;
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	data->regs = devm_ioremap_resource(dev, res);
 	if (IS_ERR(data->regs)) {
@@ -409,11 +411,6 @@ static int hi3660_thermal_probe(struct hisi_thermal_data *data)
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 
-	data->get_temp = hi3660_thermal_get_temp;
-	data->enable_sensor = hi3660_thermal_enable_sensor;
-	data->disable_sensor = hi3660_thermal_disable_sensor;
-	data->irq_handler = hi3660_thermal_irq_handler;
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	data->regs = devm_ioremap_resource(dev, res);
 	if (IS_ERR(data->regs)) {
@@ -435,7 +432,7 @@ static int hisi_thermal_get_temp(void *__data, int *temp)
 	struct hisi_thermal_data *data = __data;
 	struct hisi_thermal_sensor *sensor = &data->sensor;
 
-	*temp = data->get_temp(data);
+	*temp = data->ops->get_temp(data);
 
 	dev_dbg(&data->pdev->dev, "id=%d, temp=%d, thres=%d\n",
 		sensor->id, *temp, sensor->thres_temp);
@@ -453,7 +450,7 @@ static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
 	struct hisi_thermal_sensor *sensor = &data->sensor;
 	int temp = 0;
 
-	data->irq_handler(data);
+	data->ops->irq_handler(data);
 
 	hisi_thermal_get_temp(data, &temp);
 
@@ -502,14 +499,30 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
 	return 0;
 }
 
+static const struct hisi_thermal_ops hi6220_ops = {
+	.get_temp	= hi6220_thermal_get_temp,
+	.enable_sensor	= hi6220_thermal_enable_sensor,
+	.disable_sensor	= hi6220_thermal_disable_sensor,
+	.irq_handler	= hi6220_thermal_irq_handler,
+	.probe		= hi6220_thermal_probe,
+};
+
+static const struct hisi_thermal_ops hi3660_ops = {
+	.get_temp	= hi3660_thermal_get_temp,
+	.enable_sensor	= hi3660_thermal_enable_sensor,
+	.disable_sensor	= hi3660_thermal_disable_sensor,
+	.irq_handler	= hi3660_thermal_irq_handler,
+	.probe		= hi3660_thermal_probe,
+};
+
 static const struct of_device_id of_hisi_thermal_match[] = {
 	{
 		.compatible = "hisilicon,tsensor",
-		.data = hi6220_thermal_probe
+		.data = &hi6220_ops,
 	},
 	{
 		.compatible = "hisilicon,hi3660-tsensor",
-		.data = hi3660_thermal_probe
+		.data = &hi3660_ops,
 	},
 	{ /* end */ }
 };
@@ -527,7 +540,6 @@ static void hisi_thermal_toggle_sensor(struct hisi_thermal_sensor *sensor,
 static int hisi_thermal_probe(struct platform_device *pdev)
 {
 	struct hisi_thermal_data *data;
-	int (*platform_probe)(struct hisi_thermal_data *);
 	struct device *dev = &pdev->dev;
 	int ret;
 
@@ -538,13 +550,9 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 	data->pdev = pdev;
 	platform_set_drvdata(pdev, data);
 
-	platform_probe = of_device_get_match_data(dev);
-	if (!platform_probe) {
-		dev_err(dev, "failed to get probe func\n");
-		return -EINVAL;
-	}
+	data->ops = of_device_get_match_data(dev);
 
-	ret = platform_probe(data);
+	ret = data->ops->probe(data);
 	if (ret)
 		return ret;
 
@@ -555,7 +563,7 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = data->enable_sensor(data);
+	ret = data->ops->enable_sensor(data);
 	if (ret) {
 		dev_err(dev, "Failed to setup the sensor: %d\n", ret);
 		return ret;
@@ -583,7 +591,7 @@ static int hisi_thermal_remove(struct platform_device *pdev)
 
 	hisi_thermal_toggle_sensor(sensor, false);
 
-	data->disable_sensor(data);
+	data->ops->disable_sensor(data);
 
 	return 0;
 }
@@ -593,7 +601,7 @@ static int hisi_thermal_suspend(struct device *dev)
 {
 	struct hisi_thermal_data *data = dev_get_drvdata(dev);
 
-	data->disable_sensor(data);
+	data->ops->disable_sensor(data);
 
 	return 0;
 }
@@ -602,7 +610,7 @@ static int hisi_thermal_resume(struct device *dev)
 {
 	struct hisi_thermal_data *data = dev_get_drvdata(dev);
 
-	return data->enable_sensor(data);
+	return data->ops->enable_sensor(data);
 }
 #endif
 
-- 
2.7.4

