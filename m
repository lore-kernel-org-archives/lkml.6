Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F16C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A584821E1D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dfcO0Cnv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A584821E1D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732133AbeHIO5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:57:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32877 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732100AbeHIO5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:57:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id d4-v6so2806578pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 05:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=GqaR+pMjJdkNsSIhnkSoF14V5peIytBf2o52E7KsCnE=;
        b=dfcO0CnvnkBsmBjgMJJUhSkx0NkiSIuooxhRfBJzC709HygUcr00z0coENS9ngv/3q
         6ol8Gts0WWM0Pdfocy5zNf4J27bW4q6VLplzyFL9M9G4Z7XYuGdr3dQ4m4hoR8mv09Ol
         yH7Q64r/Gf7H2a4JbhxsPzdbukzDsqTaDfvBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=GqaR+pMjJdkNsSIhnkSoF14V5peIytBf2o52E7KsCnE=;
        b=LXbGlR8FXkzd0wCtmzALkUiOlaNqem3aFmO7f2Q499RBdFf1SOKyXXw3tAe+mZHuNd
         CroirIADlQUZK44l1F2gjr24haqb0hy0K+GPMnsKqTaXME+Lst+wNZ3IHT0NRjTCDNw+
         aoKjDq5WO8DX4eCKXo8E6c49v3Rux4DSY9E2yK1+ttAzY/jO2hhHQ5avcIy5z8F74+Ng
         gdt8wEP5XbKmhGjiTBQKiRjr8LS5FXAh4rS+oqko9r506z4UAoS/TiKDYdFty/6kwFwV
         u82S+NsStrN/Go91pnKK/AmUl0J3s0YGNxeWe4Kt5S2Q2UnfGDB/Ixl+hhJlCWE2NcUD
         1vGQ==
X-Gm-Message-State: AOUpUlGsph0dhh3zXjPkfpoxm+QW94fC2aH0u9qHknSfH/jvsFp6fCzI
        MUrrtywH7EMbtVp39nh5lHY9Yu8mSYI=
X-Google-Smtp-Source: AA+uWPwyUiKZHviMCbEGS8kEowv05Prr/LSkS2SQmpgGQu+SdrZ93voPcmG2iG3g7cCm6Yraa6tXww==
X-Received: by 2002:a63:81c3:: with SMTP id t186-v6mr2027769pgd.413.1533817986719;
        Thu, 09 Aug 2018 05:33:06 -0700 (PDT)
Received: from localhost ([45.113.251.134])
        by smtp.gmail.com with ESMTPSA id z5-v6sm16478779pfi.4.2018.08.09.05.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 05:33:06 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH v1 03/10] thermal: tsens: Add SPDX license identifiers
Date:   Thu,  9 Aug 2018 18:02:35 +0530
Message-Id: <e9f81dd5358244d44b0d74e3fb11189b514dd976.1533815718.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1533815718.git.amit.kucheria@linaro.org>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1533815718.git.amit.kucheria@linaro.org>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TSENS drivers use a GPL-2.0 license. Replace with equivalent SPDX
tags and delete the full license text.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-8916.c   | 11 +----------
 drivers/thermal/qcom/tsens-8960.c   | 11 +----------
 drivers/thermal/qcom/tsens-8974.c   | 11 +----------
 drivers/thermal/qcom/tsens-common.c | 11 +----------
 drivers/thermal/qcom/tsens.c        | 11 +----------
 drivers/thermal/qcom/tsens.h        | 11 ++---------
 6 files changed, 7 insertions(+), 59 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8916.c b/drivers/thermal/qcom/tsens-8916.c
index fdf561b8b81d..c4955c85e922 100644
--- a/drivers/thermal/qcom/tsens-8916.c
+++ b/drivers/thermal/qcom/tsens-8916.c
@@ -1,15 +1,6 @@
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
  */
 
 #include <linux/platform_device.h>
diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 0451277d3a8f..4af76de7dc2e 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -1,15 +1,6 @@
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
  */
 
 #include <linux/platform_device.h>
diff --git a/drivers/thermal/qcom/tsens-8974.c b/drivers/thermal/qcom/tsens-8974.c
index 9baf77e8cbe3..7e149edbfeb6 100644
--- a/drivers/thermal/qcom/tsens-8974.c
+++ b/drivers/thermal/qcom/tsens-8974.c
@@ -1,15 +1,6 @@
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
  */
 
 #include <linux/platform_device.h>
diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 478739543bbc..303e3fdaca98 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -1,15 +1,6 @@
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
  */
 
 #include <linux/err.h>
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index a2c9bfae3d86..90bb431cf740 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1,15 +1,6 @@
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
  */
 
 #include <linux/err.h>
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 14331eb45a86..8207610f326a 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -1,15 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2015, The Linux Foundation. All rights reserved.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
+
 #ifndef __QCOM_TSENS_H__
 #define __QCOM_TSENS_H__
 
-- 
2.17.1

