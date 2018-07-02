Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91190C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B5525547
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YNbfDIkv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B5525547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752682AbeGBMqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:46:25 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43067 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752969AbeGBMor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:44:47 -0400
Received: by mail-pg0-f65.google.com with SMTP id v13-v6so1479939pgr.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 05:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=L/L01C6WzvehucLFG86xEOcsywazU6bJIjWYV/jdL9A=;
        b=YNbfDIkv1EjO7xDgiMjB8NC5orZPjuTJyaKKC9/kiGNvlyvJJn6xdotR+1jA7hIFu2
         i3/l0+XNtqdwvlCQqQIVvroor5c5nfJ4p3n1ehKPQ7tkAFKsTSTOcUmXmxUeB84WEYSx
         EV6AxjLwexDrpRnh2NHMhy9lZfOozbjA7gqxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=L/L01C6WzvehucLFG86xEOcsywazU6bJIjWYV/jdL9A=;
        b=iChSzGcRW39MA2AjZryKm/RHL/ua2DzFTr3qyFNfhKUALVP8woyM8JSv9uNkrSITHL
         SHHeqdZFDK+XF+dxUlYqApDZ0HvIUerZtx7CpWRDKCDVWJMV+NEhz1bNb/xtm91RkYUi
         AgO/Q+hbkgQ0hGBGCXgnxfS4nTUTvksg4sqr/NdKohpVkPnSyl8l4oioEXjwxhzejraP
         Pq6uI4RB/NgsQcFCFZbpojhFx7QtyD9Yk0VeOMjvVIeXYs0I2tQCUqPdbkBXCWJZxG2T
         jIKUZ8DSSPjtzulOG9tJhBIOYvBivW/39ztYV8TJQkKvQlGBzHvytfakAr7O7k6iQ7Nl
         Lviw==
X-Gm-Message-State: APt69E3Vt/agNkqkXXnrBvowYvHwCb7KlwKXld3oEUtHChPQ7c7sYze1
        gM96T/BLiUMsSlZcGjGRAl78ilnj4nc=
X-Google-Smtp-Source: AAOMgpdbH1MnaEntUh1mkg0+YjXkDz+czLGFC8Q+DjMhtJSf1iAWbSE09ICilNlmr+XCBWZ1ufT9+w==
X-Received: by 2002:a65:428b:: with SMTP id j11-v6mr13315320pgp.200.1530535486136;
        Mon, 02 Jul 2018 05:44:46 -0700 (PDT)
Received: from localhost ([49.248.63.129])
        by smtp.gmail.com with ESMTPSA id z10-v6sm26418883pgo.58.2018.07.02.05.44.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 05:44:45 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 3/6] thermal: tsens: Rename tsens-8996 to tsens-v2 for reuse
Date:   Mon,  2 Jul 2018 18:14:06 +0530
Message-Id: <7e9beaa3218b1c46ea6a7399c5978c1538fce261.1530533998.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1530533998.git.amit.kucheria@linaro.org>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1530533998.git.amit.kucheria@linaro.org>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TSENS block inside the 8996 is internally classified as version 2 of
the IP. Several other SoC families use this block and can share this code.

We rename get_temp() to reflect that it can be used across the v2 family.

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
index e1f7781..2eca7ff 100644
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
+static const struct tsens_ops ops_generic_v2 = {
 	.init		= init_common,
-	.get_temp	= get_temp_8996,
+	.get_temp	= get_temp_tsens_v2,
 };
 
 const struct tsens_data data_8996 = {
 	.num_sensors	= 13,
-	.ops		= &ops_8996,
+	.ops		= &ops_generic_v2,
 };
+
-- 
2.7.4

