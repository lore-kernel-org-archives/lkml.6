Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E87C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE4420877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZC9Ti9Kh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE4420877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbeIYPKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:10:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54174 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbeIYPKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:10:23 -0400
Received: by mail-wm1-f67.google.com with SMTP id b19-v6so12515693wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 02:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HwYZFcnFZ79mwFslZ96x0gM5YC++omWUey3iWIx22vk=;
        b=ZC9Ti9KhOgRCMuao2UPV1SrhW3WxdLEqc3hqIXa9RS5QGznBokFYD8lvQLEELTz0gs
         GjJ3B2Z8QwPivFTCfPGj2YY0Ep1gT1MW+JftbeFy9zVidQbPIvUkKZX0kkJx0n45gTnJ
         4I4UIcTGjhDE8IO12oWJ5XjdJeiTWbGp7TXcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HwYZFcnFZ79mwFslZ96x0gM5YC++omWUey3iWIx22vk=;
        b=j6T4328sG0EM02LKUb1geVlCfuaVugxIFlaBGY7f7bNLgW5u4GaCGrKBBhh53pvuZz
         HabPr2EeVyZy7nEAZQuOFzT9u5r6ZOIop+WvtgIhhNt//X9dqo7+PwkQVrifUUnaJy1E
         fltDLXlEDDI7wmWsTu0dotTaC/ao8kFJ3V5F4LqkE25v/Aa0PHteQxEbuzo7TH9C4Rdf
         nckY5wi7EgEEOQQ8JDQ964FDTVQ5NtGfQAz3WBD1cn0+TBtD5Euud8OB/lZL+ggmHQyX
         T3FsiesEkzHbfUH3KywSwuW9w0XW/UWxK/mAto1tnBCQmZ3HcHnQOEFMkv4zBs/YgXmv
         PXEQ==
X-Gm-Message-State: ABuFfojLLek55CB+eWkhKbflJzp4eHrleAjlg8pC8TIz7WoevZ2Hqfip
        eVvduVwmn1wOCyC19Yf9tqILM+b20+w=
X-Google-Smtp-Source: ACcGV63hg4yas5kJ0bADbIeAlHjupbj8mQHdod1EXaTVPHF6NcV4NRrB+/e4+/aCDSQzNkS6D+S2Iw==
X-Received: by 2002:a1c:9355:: with SMTP id v82-v6mr60555wmd.128.1537866229953;
        Tue, 25 Sep 2018 02:03:49 -0700 (PDT)
Received: from localhost.localdomain (251.150.136.77.rev.sfr.net. [77.136.150.251])
        by smtp.gmail.com with ESMTPSA id y206-v6sm1523828wmg.14.2018.09.25.02.03.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Sep 2018 02:03:47 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     edubezval@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, leo.yan@linaro.org,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 03/14] thermal/drivers/hisi: Set the thermal zone private data to the sensor pointer
Date:   Tue, 25 Sep 2018 11:03:01 +0200
Message-Id: <1537866192-12320-4-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store the sensor pointer in the thermal zone private data and use it
in the callback functions. That allows to continue the conversion to
sensor oriented code where the pointers are the sensors.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 1fdda55..567fde6 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -442,8 +442,8 @@ static int hi3660_thermal_probe(struct hisi_thermal_data *data)
 
 static int hisi_thermal_get_temp(void *__data, int *temp)
 {
-	struct hisi_thermal_data *data = __data;
-	struct hisi_thermal_sensor *sensor = &data->sensor;
+	struct hisi_thermal_sensor *sensor = __data;
+	struct hisi_thermal_data *data = sensor->data;
 
 	*temp = data->ops->get_temp(sensor);
 
@@ -465,7 +465,7 @@ static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
 
 	data->ops->irq_handler(sensor);
 
-	hisi_thermal_get_temp(data, &temp);
+	hisi_thermal_get_temp(sensor, &temp);
 
 	if (temp >= sensor->thres_temp) {
 		dev_crit(&data->pdev->dev, "THERMAL ALARM: %d > %d\n",
@@ -486,11 +486,10 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
 					struct hisi_thermal_sensor *sensor)
 {
 	int ret, i;
-	struct hisi_thermal_data *data = sensor->data;
 	const struct thermal_trip *trip;
 
 	sensor->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev,
-							   sensor->id, data,
+							   sensor->id, sensor,
 							   &hisi_of_thermal_ops);
 	if (IS_ERR(sensor->tzd)) {
 		ret = PTR_ERR(sensor->tzd);
-- 
2.7.4

