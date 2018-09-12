Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69019C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC2720882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BnpNtCrc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC2720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeILO5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:57:21 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37527 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbeILO5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:57:20 -0400
Received: by mail-ed1-f67.google.com with SMTP id a20-v6so1265519edd.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 02:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=C01eNk3NwvsIILRxSmGNc2O1AsfcJ/1SiL94aPpnU1o=;
        b=BnpNtCrcNgH4c+El2+edawnt/IUENWb+siPT2y+6maMo5vKcXvDkyX2bLiuKQO/GhT
         J6F0WSeue+xIu+MOHmGhL3KFA7mLSykVs5czobeMSyvTT7m0hY1I3ExIrebHJ/7w8KoW
         5OMwNFJkBCPEps5rPBI5trL7nERNkApfOIYr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=C01eNk3NwvsIILRxSmGNc2O1AsfcJ/1SiL94aPpnU1o=;
        b=n5mwLOQDCTiyZP7GFqnt33/Qyql57JMyjbQKTcbnJwNjxcL5yA5MQQ8rIg0Bib8zs0
         SC/yReY+NZoqOs476Hf7sOSQq5EJBBRuHhzWOdOZ8qfCEn9kVD5HQQOd+oVTEkqdTAXG
         tvymDJGSY3dPb8UH18nsyc+8admZXs+rwyDnpXZyi/vu5Pf+d3JKOOlRbTeG6MZYPCKy
         touwzMcTG/CYH0ZXJZfwLzzt8an18F3GVn224NgbjW7eMIzTbVGtQrx44XjGcLklEXFV
         WncU0dgJZit/FjXijQLHkIiBJxURkSLpKN6rNZa+qdnsUfPE27yOIJQycSDxQMCCNQ7U
         6XAA==
X-Gm-Message-State: APzg51AUi/jnqPqz64xVmo92nDzFXyzoBDPtLRlyB5NgERQgbIkKMCni
        XQkpqaNSRLyQi9IwH7d1pHVd8/Tvluw=
X-Google-Smtp-Source: ANB0VdaCE4LTtrOtpLtWYuDeHE2LKO3u8wLJBjIucnmBwckKdc8GleR9u9ZVl/276yu7WZhmE8SuPw==
X-Received: by 2002:a50:fd84:: with SMTP id o4-v6mr1746928edt.116.1536746012859;
        Wed, 12 Sep 2018 02:53:32 -0700 (PDT)
Received: from localhost ([49.248.190.214])
        by smtp.gmail.com with ESMTPSA id g20-v6sm328160edm.36.2018.09.12.02.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 02:53:32 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 02/16] thermal: tsens: Add SPDX license identifiers
Date:   Wed, 12 Sep 2018 15:22:47 +0530
Message-Id: <ca345962eb15e6d9d78606a26524dfb9ee60c81a.1536744310.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1536744310.git.amit.kucheria@linaro.org>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1536744310.git.amit.kucheria@linaro.org>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TSENS drivers use a GPL-2.0 license. Replace with equivalent SPDX
tags and delete the full license text.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
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

