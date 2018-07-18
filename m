Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D44ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81EAA2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OwrsM1z7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81EAA2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbeGRIB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:01:56 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54328 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729058AbeGRIBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:01:55 -0400
Received: by mail-wm0-f66.google.com with SMTP id c14-v6so1682773wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 00:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=+EqCCIrnC5FlIeZsiZWAuXMV4exxQ1cT9lKye3jrTmM=;
        b=OwrsM1z7RuprWuvIagsuan+fjMXs3MSwOqcjZ/3aQEIKiMnBY4W66n/7S7gVTmTycs
         s1pI7XIsV2VP2oh2yIs0Q4gAz9rHUE05RfZIXzDC1s5To86NxKMgRI7uFk8oyvDIoldL
         2ZakYAyV/h3/yeFesb2REovox043w+HYWkZvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=+EqCCIrnC5FlIeZsiZWAuXMV4exxQ1cT9lKye3jrTmM=;
        b=QbdmnqerUkcJ73jFWakWUgCFs3rIJpG9ocRBQa1DHhW5I5pKLUdpFE/6RxcQhAeVbr
         glPia8mC6wbP3MehI995U+EEQyeostq86D6Zm48dkyBZB/kWkBF1vuCNDF+E2pgvUFkV
         pkJ5WsCU6AdqN1KyjnZwTlNYT6D48wR9G949NkHQEVECPuxKOVpjuZaNpv5RdKl9jnY8
         LkuQLF7rSE0whr/Kv6Q1gtdf9GyinXtDODWuOg1Gm4OiOXc8kba3Fl5wNJYQCK5tOPyM
         JDYf+jmAJZCjJUGh5CAMp1qb0hin76j34LifTSOzOefYrV1d+tpsyR71j8uCQg1L5xhg
         em7Q==
X-Gm-Message-State: AOUpUlHzTsx+i5F64hVMkXBOUGIthm1ePcFK4Vjw3pfjoHLieoXNlCFd
        4eaI/BIAh8/NOp7fMcPOiGU6i/7ZQYc=
X-Google-Smtp-Source: AAOMgpfQOah5O6CZ9okyhTK/dm/C/3QEeYNJj1PnpnFUt5Odjw88WkjPalfDey09mgqadd9sdmxgIg==
X-Received: by 2002:a1c:10d4:: with SMTP id 203-v6mr768310wmq.158.1531898727100;
        Wed, 18 Jul 2018 00:25:27 -0700 (PDT)
Received: from localhost ([49.248.170.255])
        by smtp.gmail.com with ESMTPSA id w24-v6sm1221022wmc.15.2018.07.18.00.25.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 00:25:26 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH v1 1/3] thermal: tsens: Rename variable
Date:   Wed, 18 Jul 2018 12:55:01 +0530
Message-Id: <45062f2bcfd0f20e604f663e3627dcedf01f0be5.1531898088.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1531898088.git.amit.kucheria@linaro.org>
References: <cover.1531898088.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1531898088.git.amit.kucheria@linaro.org>
References: <cover.1531898088.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're actually reading the temperature from the status register. Fix the
variable name to reflect that.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c |  6 +++---
 drivers/thermal/qcom/tsens-v2.c     | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index c22dc18..25e7f24 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -104,11 +104,11 @@ int get_temp_common(struct tsens_device *tmdev, int id, int *temp)
 {
 	struct tsens_sensor *s = &tmdev->sensor[id];
 	u32 code;
-	unsigned int sensor_addr;
+	unsigned int status_reg;
 	int last_temp = 0, ret;
 
-	sensor_addr = S0_ST_ADDR + s->hw_id * SN_ADDR_OFFSET;
-	ret = regmap_read(tmdev->map, sensor_addr, &code);
+	status_reg = S0_ST_ADDR + s->hw_id * SN_ADDR_OFFSET;
+	ret = regmap_read(tmdev->map, status_reg, &code);
 	if (ret)
 		return ret;
 	last_temp = code & SN_ST_TEMP_MASK;
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index f40150f..908e3dc 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -16,11 +16,11 @@ static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
 {
 	struct tsens_sensor *s = &tmdev->sensor[id];
 	u32 code;
-	unsigned int sensor_addr;
+	unsigned int status_reg;
 	int last_temp = 0, last_temp2 = 0, last_temp3 = 0, ret;
 
-	sensor_addr = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * 4;
-	ret = regmap_read(tmdev->map, sensor_addr, &code);
+	status_reg = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * 4;
+	ret = regmap_read(tmdev->map, status_reg, &code);
 	if (ret)
 		return ret;
 	last_temp = code & LAST_TEMP_MASK;
@@ -28,7 +28,7 @@ static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
 		goto done;
 
 	/* Try a second time */
-	ret = regmap_read(tmdev->map, sensor_addr, &code);
+	ret = regmap_read(tmdev->map, status_reg, &code);
 	if (ret)
 		return ret;
 	if (code & STATUS_VALID_BIT) {
@@ -39,7 +39,7 @@ static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
 	}
 
 	/* Try a third/last time */
-	ret = regmap_read(tmdev->map, sensor_addr, &code);
+	ret = regmap_read(tmdev->map, status_reg, &code);
 	if (ret)
 		return ret;
 	if (code & STATUS_VALID_BIT) {
-- 
2.7.4

