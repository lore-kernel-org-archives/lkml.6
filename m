Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F9DC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A46120877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bwrASE8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A46120877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbeIYPLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:11:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41692 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbeIYPLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:11:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id j15-v6so18382302wrt.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 02:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=twKUT5AkgFgWw/t/b6bDn1W7sM2Rq3ji9heE8FRQKeo=;
        b=bwrASE8SJsryrgfQp4OcrgICX1ooVdFQ8ivP+hUg1MrkP2Piwfyyl56tQV7tpvs4vJ
         J2dxuWJ4Ixf9xZgYy09bXWorJ6l0ku8qJ5Kq7fPRKZN6n9ORds4a0M1+v5yEniW1APBH
         y/DKqJudolhwzSHhpJTNylGgZSsOgYIq3GBuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=twKUT5AkgFgWw/t/b6bDn1W7sM2Rq3ji9heE8FRQKeo=;
        b=KRWc+MzBmJYPN9zqbDgfJ7c4QMPwmHsNJldCf2hUXiu6G3BZj2SZT/l97rbYMmjyuG
         JDifh6DxylgR0X9seh09HJfnuI0ZdXMMpZECwqmnoCUosjQqtCgunUpkCWp3jo3r7I+J
         rbIzM1oWl22nD+DB6vEk4KwVuSRW+9DtUUxqkAE2hCOPkEGQRdy0DJ7dhyeBUclmq5Ox
         kMES8hjd7QLSud67WRsUtcEflHTSOpIOciJBJulem2NOcxxgxuPPrF6RZASa589Pe4b+
         CQ/S3XujsD1UYUSfpbyCHhg1NCpP9l3QZ/DV1EYaZhRGGFpMtGLtC0pBi5cwRR0/WV3l
         hSRw==
X-Gm-Message-State: ABuFfogcrCysQtLeLlW1jMCBt8r35Q6CplENjt6nUJKjhUAYuS021AAf
        imK9MTty9CJR+zKQjDHksvlVVg==
X-Google-Smtp-Source: ACcGV61fzTmdR4BPLrmgBB61wZJaUvDg22lvoj0ZJSjQXUZ5up4w/aemDRqx6zCaR0n2k0YA1gXJUg==
X-Received: by 2002:a5d:4185:: with SMTP id m5-v6mr97633wrp.8.1537866268768;
        Tue, 25 Sep 2018 02:04:28 -0700 (PDT)
Received: from localhost.localdomain (251.150.136.77.rev.sfr.net. [77.136.150.251])
        by smtp.gmail.com with ESMTPSA id y206-v6sm1523828wmg.14.2018.09.25.02.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Sep 2018 02:04:28 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     edubezval@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, leo.yan@linaro.org,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 07/14] thermal/drivers/hisi: Replace macro name with relevant sensor location
Date:   Tue, 25 Sep 2018 11:03:05 +0200
Message-Id: <1537866192-12320-8-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the macro name in order to give a better indication of the
sensor location.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index a5756f6..a542cb3 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -55,8 +55,8 @@
 #define HI3660_TEMP_STEP		(205)
 #define HI3660_TEMP_LAG			(4000)
 
-#define HI6220_DEFAULT_SENSOR		2
-#define HI3660_DEFAULT_SENSOR		1
+#define HI6220_CLUSTER0_SENSOR		2
+#define HI3660_BIG_SENSOR		1
 
 struct hisi_thermal_data;
 
@@ -406,7 +406,7 @@ static int hi6220_thermal_probe(struct hisi_thermal_data *data)
 	if (!data->sensor)
 		return -ENOMEM;
 
-	data->sensor[0].id = HI6220_DEFAULT_SENSOR;
+	data->sensor[0].id = HI6220_CLUSTER0_SENSOR;
 	data->sensor[0].data = data;
 	data->nr_sensors = 1;
 
@@ -422,7 +422,7 @@ static int hi3660_thermal_probe(struct hisi_thermal_data *data)
 	if (!data->sensor)
 		return -ENOMEM;
 
-	data->sensor[0].id = HI3660_DEFAULT_SENSOR;
+	data->sensor[0].id = HI3660_BIG_SENSOR;
 	data->sensor[0].data = data;
 	data->nr_sensors = 1;
 
-- 
2.7.4

