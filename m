Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 70036C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B038208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aoUzxBPz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B038208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933245AbeFLKzo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 06:55:44 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36727 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933135AbeFLKzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 06:55:40 -0400
Received: by mail-lf0-f65.google.com with SMTP id u4-v6so35318279lff.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 03:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=kb84Dckh+p8fYYPXbIUYnlgkmp3CDvlZRfts5T+sPAM=;
        b=aoUzxBPz/KFZAGm6hQNulusSxAuv3gk6DKRSF9BnEIv+kb5oQq1ic19z948O+qZyGF
         TPZbVT3xRvknFc44bniUyl9AYYtGWHnLXF4cMZ+qJsNYpNbmGvFAiTHxAhz58FVrsTGt
         n/CdrnV/tKuDNi1SK5cuHUHsiXGJeYnJOo0Ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=kb84Dckh+p8fYYPXbIUYnlgkmp3CDvlZRfts5T+sPAM=;
        b=LuJFuqfGBnyCFehHi5SD7WGqSsUcT8rUJd65EyFxc8ls14xySMKL0AotvPDA9QubWE
         fLbXdbaFe6PaxUiwV0ZuicjouO0hM8wf8hWSU7C8LcVwVRgP7bs7nIBIL79HUC/1eqTh
         EIKgtWTYGrjAbRhbk0i7sJzc8PYz5ACVRFA6jyU2DVvv+pCkqSe+GVFF7WkQN8HIZQGo
         JLcYX7WKEhQYUsGEvK7axRjtT8LWEY2du1Du07WwtwnUWK/n6Xbs9nj2fAIvkdExCXEV
         xtL/CJnIUQgoRkSmjvkWhQFAo4Z4pEci2GgUfv6QWaWgrpohghidc5XJsd8e2YvDGUiF
         H7oQ==
X-Gm-Message-State: APt69E17zjJr2AQIvHckBglNiKZrgZ01yR/7NPiLVHOTzZSGR4hn6MHf
        e6oH/EAI+Dvs4E84ZkKZiuXL11O7EG4=
X-Google-Smtp-Source: ADUXVKKmQFHCmBaj1oPLNST89H8BFgKaaD3TX6GLmKaqIidJX5dQJlQFmt+s7XJi8gxxZnLmNqXK7g==
X-Received: by 2002:a19:484b:: with SMTP id v72-v6mr1893398lfa.120.1528800938654;
        Tue, 12 Jun 2018 03:55:38 -0700 (PDT)
Received: from localhost (85-76-96-64-nat.elisa-mobile.fi. [85.76.96.64])
        by smtp.gmail.com with ESMTPSA id q84-v6sm156569lja.50.2018.06.12.03.55.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 03:55:38 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org (open list:THERMAL)
Subject: [PATCH v2 3/5] thermal: tsens: Move 8996 get_temp() to common code for reuse
Date:   Tue, 12 Jun 2018 13:54:55 +0300
Message-Id: <ed6b51a1b08e195968f5423a86e40146279a8807.1528799892.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1528799892.git.amit.kucheria@linaro.org>
References: <cover.1528799892.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1528799892.git.amit.kucheria@linaro.org>
References: <cover.1528799892.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TSENS block inside the 8996 is internally classified as version 2.
Several other SoC families use this block and can share this code. Rename
get_temp() to reflect that it can be used across the v2 family.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-8996.c   | 73 ++-----------------------------------
 drivers/thermal/qcom/tsens-common.c | 69 ++++++++++++++++++++++++++++++-----
 drivers/thermal/qcom/tsens.h        |  1 +
 3 files changed, 63 insertions(+), 80 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8996.c b/drivers/thermal/qcom/tsens-8996.c
index 6e59078..a0d9096 100644
--- a/drivers/thermal/qcom/tsens-8996.c
+++ b/drivers/thermal/qcom/tsens-8996.c
@@ -1,81 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2015, The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
+ * Copyright (c) 2018, Linaro Limited
  */
 
-#include <linux/platform_device.h>
-#include <linux/regmap.h>
 #include "tsens.h"
 
-#define STATUS_OFFSET	0x10a0
-#define LAST_TEMP_MASK	0xfff
-#define STATUS_VALID_BIT	BIT(21)
-#define CODE_SIGN_BIT		BIT(11)
-
-static int get_temp_8996(struct tsens_device *tmdev, int id, int *temp)
-{
-	struct tsens_sensor *s = &tmdev->sensor[id];
-	u32 code;
-	unsigned int sensor_addr;
-	int last_temp = 0, last_temp2 = 0, last_temp3 = 0, ret;
-
-	sensor_addr = STATUS_OFFSET + s->hw_id * 4;
-	ret = regmap_read(tmdev->map, sensor_addr, &code);
-	if (ret)
-		return ret;
-	last_temp = code & LAST_TEMP_MASK;
-	if (code & STATUS_VALID_BIT)
-		goto done;
-
-	/* Try a second time */
-	ret = regmap_read(tmdev->map, sensor_addr, &code);
-	if (ret)
-		return ret;
-	if (code & STATUS_VALID_BIT) {
-		last_temp = code & LAST_TEMP_MASK;
-		goto done;
-	} else {
-		last_temp2 = code & LAST_TEMP_MASK;
-	}
-
-	/* Try a third/last time */
-	ret = regmap_read(tmdev->map, sensor_addr, &code);
-	if (ret)
-		return ret;
-	if (code & STATUS_VALID_BIT) {
-		last_temp = code & LAST_TEMP_MASK;
-		goto done;
-	} else {
-		last_temp3 = code & LAST_TEMP_MASK;
-	}
-
-	if (last_temp == last_temp2)
-		last_temp = last_temp2;
-	else if (last_temp2 == last_temp3)
-		last_temp = last_temp3;
-done:
-	/* Code sign bit is the sign extension for a negative value */
-	if (last_temp & CODE_SIGN_BIT)
-		last_temp |= ~CODE_SIGN_BIT;
-
-	/* Temperatures are in deciCelicius */
-	*temp = last_temp * 100;
-
-	return 0;
-}
-
 static const struct tsens_ops ops_8996 = {
 	.init		= init_common,
-	.get_temp	= get_temp_8996,
+	.get_temp	= get_temp_tsens_v2,
 };
 
 const struct tsens_data data_8996 = {
diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index b1449ad..961ace4 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -1,15 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2015, The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
+ * Copyright (c) 2018, Linaro Limited
  */
 
 #include <linux/err.h>
@@ -117,6 +109,63 @@ int get_temp_common(struct tsens_device *tmdev, int id, int *temp)
 	return 0;
 }
 
+#define STATUS_OFFSET		0xa0
+#define LAST_TEMP_MASK		0xfff
+#define STATUS_VALID_BIT	BIT(21)
+#define CODE_SIGN_BIT		BIT(11)
+
+int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
+{
+	struct tsens_sensor *s = &tmdev->sensor[id];
+	u32 code;
+	unsigned int sensor_addr;
+	int last_temp = 0, last_temp2 = 0, last_temp3 = 0, ret;
+
+	sensor_addr = STATUS_OFFSET + s->hw_id * 4;
+	ret = regmap_read(tmdev->map, sensor_addr, &code);
+	if (ret)
+		return ret;
+	last_temp = code & LAST_TEMP_MASK;
+	if (code & STATUS_VALID_BIT)
+		goto done;
+
+	/* Try a second time */
+	ret = regmap_read(tmdev->map, sensor_addr, &code);
+	if (ret)
+		return ret;
+	if (code & STATUS_VALID_BIT) {
+		last_temp = code & LAST_TEMP_MASK;
+		goto done;
+	} else {
+		last_temp2 = code & LAST_TEMP_MASK;
+	}
+
+	/* Try a third/last time */
+	ret = regmap_read(tmdev->map, sensor_addr, &code);
+	if (ret)
+		return ret;
+	if (code & STATUS_VALID_BIT) {
+		last_temp = code & LAST_TEMP_MASK;
+		goto done;
+	} else {
+		last_temp3 = code & LAST_TEMP_MASK;
+	}
+
+	if (last_temp == last_temp2)
+		last_temp = last_temp2;
+	else if (last_temp2 == last_temp3)
+		last_temp = last_temp3;
+done:
+	/* Code sign bit is the sign extension for a negative value */
+	if (last_temp & CODE_SIGN_BIT)
+		last_temp |= ~CODE_SIGN_BIT;
+
+	/* Temperatures are in deciCelicius */
+	*temp = last_temp * 100;
+
+	return 0;
+}
+
 static const struct regmap_config tsens_config = {
 	.reg_bits	= 32,
 	.val_bits	= 32,
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index dc56e1e..80b273d 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -86,6 +86,7 @@ char *qfprom_read(struct device *, const char *);
 void compute_intercept_slope(struct tsens_device *, u32 *, u32 *, u32);
 int init_common(struct tsens_device *);
 int get_temp_common(struct tsens_device *, int, int *);
+int get_temp_tsens_v2(struct tsens_device *, int, int *);
 
 extern const struct tsens_data data_8916, data_8974, data_8960, data_8996;
 
-- 
2.7.4

