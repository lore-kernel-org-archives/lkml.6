Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C6323C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1C8208B5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EhLcvwF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C1C8208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755113AbeFNKoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:44:04 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45045 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755102AbeFNKoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:44:01 -0400
Received: by mail-lf0-f65.google.com with SMTP id 36-v6so8636940lfr.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 03:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=79IlTt7LMeUKFlfd230WbPE21fWiEzhh7e4WAJs4pwE=;
        b=EhLcvwF51e+ZPnpx00WQ9NvTdBWZRTYsULr16qZp96G278PsdBkIIFjJ88DGcF3cI2
         tyd1kYbuPlOl9flhJmd4/DzZHnMjxTqvuo9gP0QcCdq1PmSfUKM2zB1ay3U5LVAXyiKq
         EmEOO67Ng1Q5/ZfiJG04yf6IhBdvZRC7qepPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=79IlTt7LMeUKFlfd230WbPE21fWiEzhh7e4WAJs4pwE=;
        b=VQnkSYKtTEGtZQDuAEuUcZTxwFacyJkUlh6DJ2DrZPG4smHbmmN57alXTQytyNuclt
         w460N5N1aYx1whAUOo0DXZVrisCIfhEQUv8dV9GgEL5P5Vd9EHah20+E8jbX/wF3jRdT
         0wdBlLBOkylDrarhJHfNhSKorNRs8hjVY37BFYL+DCl2CI/R8Efc3VIviaD1rurRDr5v
         0KKAa/1K215Lpa9ff3yr0mZkf+cmR3X4acqenKINoTkoMaZrif47BrSDFtK7ipDcZy2V
         /E64w1U5R+YXT9Tl9cB0gE9jR12mb4e6GEGRicBdRzq4gLWZ4CEF5ICai3WGIHNvC9c6
         lhDg==
X-Gm-Message-State: APt69E1XWVRyFaclZJrklZIBUds4OYK87zjaFyfGYjbhuO3JeqccoWYr
        /J1aoXBEyRLramBdWhkEFE+9JiAHEhI=
X-Google-Smtp-Source: ADUXVKL5dwaQrnAHtJKhp5+/UVEjgw+kgvX49LbIFWdVAPgWfWG6d321tgaIqbUlAxn5VPexK8rmZA==
X-Received: by 2002:a2e:635b:: with SMTP id x88-v6mr1478142ljb.103.1528973040056;
        Thu, 14 Jun 2018 03:44:00 -0700 (PDT)
Received: from localhost (85-76-96-172-nat.elisa-mobile.fi. [85.76.96.172])
        by smtp.gmail.com with ESMTPSA id d6-v6sm893297ljd.52.2018.06.14.03.43.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 03:43:59 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org (open list:THERMAL)
Subject: [PATCH v3 3/6] thermal: tsens: Rename tsens-8996 to tsens-v2 for reuse
Date:   Thu, 14 Jun 2018 13:43:13 +0300
Message-Id: <44df951a0e13aa0b313e3dbcdf4e0b313c5893e2.1528972165.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1528972165.git.amit.kucheria@linaro.org>
References: <cover.1528972165.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1528972165.git.amit.kucheria@linaro.org>
References: <cover.1528972165.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TSENS block inside the 8996 is internally classified as version 2 of
the IP. Several other SoC families use this block and can share this code.

Also, rename get_temp() to reflect that it can be used across the v2 family.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/Makefile                     |  2 +-
 drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c} | 26 ++++++++---------------
 2 files changed, 10 insertions(+), 18 deletions(-)
 rename drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c} (66%)

diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
index 2cc2193..a821929 100644
--- a/drivers/thermal/qcom/Makefile
+++ b/drivers/thermal/qcom/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
-qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o tsens-8996.o
+qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o tsens-v2.o
diff --git a/drivers/thermal/qcom/tsens-8996.c b/drivers/thermal/qcom/tsens-v2.c
similarity index 66%
rename from drivers/thermal/qcom/tsens-8996.c
rename to drivers/thermal/qcom/tsens-v2.c
index e1f7781..c981a40 100644
--- a/drivers/thermal/qcom/tsens-8996.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -1,27 +1,18 @@
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
 #include <linux/regmap.h>
 #include "tsens.h"
 
-#define STATUS_OFFSET	0x10a0
-#define LAST_TEMP_MASK	0xfff
+#define STATUS_OFFSET		0xa0
+#define LAST_TEMP_MASK		0xfff
 #define STATUS_VALID_BIT	BIT(21)
 #define CODE_SIGN_BIT		BIT(11)
 
-static int get_temp_8996(struct tsens_device *tmdev, int id, int *temp)
+static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
 {
 	struct tsens_sensor *s = &tmdev->sensor[id];
 	u32 code;
@@ -73,12 +64,13 @@ static int get_temp_8996(struct tsens_device *tmdev, int id, int *temp)
 	return 0;
 }
 
-static const struct tsens_ops ops_8996 = {
+static const struct tsens_ops ops_v2 = {
 	.init		= init_common,
-	.get_temp	= get_temp_8996,
+	.get_temp	= get_temp_tsens_v2,
 };
 
 const struct tsens_data data_8996 = {
 	.num_sensors	= 13,
-	.ops		= &ops_8996,
+	.ops		= &ops_v2,
 };
+
-- 
2.7.4

