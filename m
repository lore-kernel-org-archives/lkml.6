Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8FDC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E791F20846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GR4XghGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E791F20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbeGZLts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:49:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37517 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729277AbeGZLts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:49:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id q10-v6so1195839wrd.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 03:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=LlTjF7iTHMsf57iFeH6E85/+9b8NIV2YUPikYA5LJe8=;
        b=GR4XghGin49xYSALOShEfosJa0gs/9O2sxviVln6NkAacwYKHQ+bk5pAuxLdXxHz4s
         qCaei9mwgM/oAsD8CK23kAy5DvOa26Q9QGSIaTf0EcJMJv+pgc2QbGnCmkWPgDTCu10Q
         09UYU7+Wn5GLF4aokTqvXzaKZIT+iBaGixhYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=LlTjF7iTHMsf57iFeH6E85/+9b8NIV2YUPikYA5LJe8=;
        b=dFZLsNQIXA0Jrfm7lLwdD1YGWEqflyG8oiqKZCFEYrggAAt5z9XZkJJOvL9u+skg+I
         SUkOY+31tqHe+y7dGS6bl/jOm9GVq/tDAwlHo1gtimW8E+v+k4RjGPrSZcCXnzfdziGc
         htIaCEijCBQB/hCwUgVTMSlQiW6KVwnytigeMx5x4zMjaWI2voXkiV/Zfk3YyB0Kb0hT
         c3LO7VTig72VdpKg15lv+ow3qjDr60n+MGuvf2xmULHKTpm9YXHRqIIEasTrZR+Q4wPc
         rRO7QWkKpozm7YArbX2Cx1wqX1ZtncP8eSjhilCylLcmLafFxIXUuoOjUUel9xqNrtXg
         lpOw==
X-Gm-Message-State: AOUpUlHtBSMjdsZ7zkHOjH15VEi9m7aelJqlW0hclEeTyhgKUk1ZWdpu
        hFXkCzo0RcJ8vxqxv0FYNf57w/S0Fyo=
X-Google-Smtp-Source: AAOMgpd28a9hNsoPhDnrIvIv28+mI/kincmZms0Us/D/3iTdR8PzkZxaebj++yDyQN2E3z7KG4rR8A==
X-Received: by 2002:adf:a197:: with SMTP id u23-v6mr1210365wru.50.1532601214477;
        Thu, 26 Jul 2018 03:33:34 -0700 (PDT)
Received: from localhost ([49.248.197.57])
        by smtp.gmail.com with ESMTPSA id x62-v6sm1458087wmg.1.2018.07.26.03.33.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 03:33:33 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH v2 1/3] thermal: tsens: Rename variable
Date:   Thu, 26 Jul 2018 16:03:08 +0530
Message-Id: <5160b58d1d14b87b84ea49adc804afbefb792c34.1532600791.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.GIT
In-Reply-To: <cover.1532600791.git.amit.kucheria@linaro.org>
References: <cover.1532600791.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1532600791.git.amit.kucheria@linaro.org>
References: <cover.1532600791.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're actually reading the temperature from the status register. Fix the
variable name to reflect that.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/thermal/qcom/tsens-common.c |  6 +++---
 drivers/thermal/qcom/tsens-v2.c     | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index c22dc18c7c65..25e7f247b027 100644
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
index f40150fd7eae..908e3dcb2d5c 100644
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
2.17.GIT

