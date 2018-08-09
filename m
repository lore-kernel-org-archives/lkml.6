Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C56EC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0407521DEC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SngJGovQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0407521DEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbeHIO6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:58:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41995 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732269AbeHIO6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:58:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id y4-v6so2689204pgp.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 05:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Gct4lOuxYFWJ5iMbse3TfLVgnZuyuNabzMoHh2gRRuQ=;
        b=SngJGovQLy8KurtU6+ZIVcvxJ39PFS30jXQoqitXwU65m9c/yrARDeWfwwpnl7Z5HE
         VrcAh/dNNHLxiz2mdxOhTNKnpCLLEcaGcZDeBsF/IgizgMBqqKFf1ncFtwT3Sh1GDZmL
         7knOvcTABQXmO1PSnC7s7LI8MbJWsFwaSG6Ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Gct4lOuxYFWJ5iMbse3TfLVgnZuyuNabzMoHh2gRRuQ=;
        b=R+aZGNglOi2aRTPFSoy1iCJu0/zxinjotxNV+Djzl2QOb5f4NKJpvHDhZh+kWIBaZn
         uQ2YjSVljypP3jaPKcfNWm++2IwNvnEsWfjlC1afpawoysNk9JDtM0r4syZSbXf4HTfB
         QjfGglVfHLm6kCBwxQEE7n4Jy+O9uVwICReO7o8VewEdjGjLBgBdw76Ly7qUPvFgSEIt
         85AqM1ZWkMxMU9I36HO14YzhGjNHIFVCvgQnQZghDnqHLih+aOFiXLSTlxVmni2v9byv
         TNy9GyFq7Vs9V9RT8K6PumC0pDa3PIJ+Qkxcdj3tExzIHb0JHVAfMeo7pDpWENYd7pBU
         Nqyg==
X-Gm-Message-State: AOUpUlEhCZ9Czo+63QQRhRdHOz3+fSYvWPfhyW1MVwivycOM4j5xPG82
        5g/hkIweuOoXNQqpwqBT75IbfGdouEI=
X-Google-Smtp-Source: AA+uWPxl7f9PffgIeKBiuJe7dSIbVHCouAspjmh09C32JFNgZtAKjQiIvRVGHUNqsH7GepOxM5voPA==
X-Received: by 2002:a62:5e45:: with SMTP id s66-v6mr2216120pfb.129.1533818004405;
        Thu, 09 Aug 2018 05:33:24 -0700 (PDT)
Received: from localhost ([45.113.251.134])
        by smtp.gmail.com with ESMTPSA id n9-v6sm12201171pfg.21.2018.08.09.05.33.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 05:33:23 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH v1 08/10] thermal: tsens: Get rid of 'id' field
Date:   Thu,  9 Aug 2018 18:02:40 +0530
Message-Id: <3810cbe6b499d265d7e3fb97c408cb80a12d5850.1533815718.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1533815718.git.amit.kucheria@linaro.org>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1533815718.git.amit.kucheria@linaro.org>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hw_id field in 'struct tsens_sensor' can do the job of tracking
unique ids for each sensor connected to each tsens device instance. It
also allows hw_ids to be overridden (e.g. 8916) in cases where some
sensors in a sequence are disabled on a particular platform.

Use the hw_id field instead of the id field consistently across the
tsens code.

While, we're at it, document the fields of struct tsens_sensor.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens.c |  5 ++---
 drivers/thermal/qcom/tsens.h | 10 +++++++++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 9a8e8f7b4ae1..fb728ec5d77f 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -17,7 +17,7 @@ static int tsens_get_temp(void *data, int *temp)
 	const struct tsens_sensor *s = data;
 	struct tsens_device *tmdev = s->tmdev;
 
-	return tmdev->ops->get_temp(tmdev, s->id, temp);
+	return tmdev->ops->get_temp(tmdev, s->hw_id, temp);
 }
 
 static int tsens_get_trend(void *p, int trip, enum thermal_trend *trend)
@@ -26,7 +26,7 @@ static int tsens_get_trend(void *p, int trip, enum thermal_trend *trend)
 	struct tsens_device *tmdev = s->tmdev;
 
 	if (tmdev->ops->get_trend)
-		return  tmdev->ops->get_trend(tmdev, s->id, trend);
+		return  tmdev->ops->get_trend(tmdev, s->hw_id, trend);
 
 	return -ENOTSUPP;
 }
@@ -83,7 +83,6 @@ static int tsens_register(struct tsens_device *tmdev)
 
 	for (i = 0;  i < tmdev->num_sensors; i++) {
 		tmdev->sensor[i].tmdev = tmdev;
-		tmdev->sensor[i].id = i;
 		tzd = devm_thermal_zone_of_sensor_register(tmdev->dev, i,
 							   &tmdev->sensor[i],
 							   &tsens_of_ops);
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index b9c4bcf255fa..2a3174dfc1a9 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -14,11 +14,19 @@
 
 struct tsens_device;
 
+/**
+ * struct tsens_sensor - sensor-specific data
+ * @tmdev: tsens device instance this sensor is connected to
+ * @tzd: thermal zone corresponding to this sensor
+ * @offset: offset from calibration data to convert ADC data to degrees
+ * @hw_id: unique sensor ID for each sensor connected to tsens device instance
+ * @slope: slope from calibration data to convert ADC data to degrees
+ * @status: 8960-specific status register addresses
+ */
 struct tsens_sensor {
 	struct tsens_device		*tmdev;
 	struct thermal_zone_device	*tzd;
 	int				offset;
-	int				id;
 	int				hw_id;
 	int				slope;
 	u32				status;
-- 
2.17.1

