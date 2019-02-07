Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1EFC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742EA2190A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vJKRJiJI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfBGM6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:58:07 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33400 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbfBGM6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:58:06 -0500
Received: by mail-pf1-f196.google.com with SMTP id c123so4747038pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 04:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=GQERaam7BX0uQrRP6UmIWBlFpeXRfuuGSf7vQIQdfq0=;
        b=vJKRJiJIeiRit9jzYbDlSS4ecb//rSX/xIEZ19PqkbIUK6Nkr1r3z2CzV1r9vY5bzm
         oJpWEn39NJwtttdYmAKFoOZCbsEblrTUR1kFVKngcqyHxjnZf/sdqjIA81ZSmbuii79U
         oEvgSgPAlsqKyF8jLLJQr9yuzBx65hczyS+sAjkbR2R08uI9KLLdvHrqNSiHiYFbrNpb
         RHW+IxiprT038cV/t62wPiQsjx4S1Gy3PckhGuTD9X0dM9r+WpD/hQLs7ZwtqweAOBKC
         qO5dawb8IfWr2GpvMIYb6Cc2toQ686TzxOpjpERrTXTjj7pzrcBcqJZP6rCeByELGwEc
         Cwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=GQERaam7BX0uQrRP6UmIWBlFpeXRfuuGSf7vQIQdfq0=;
        b=O6UBj6g0h1voRp/ci3HmzjkBeV0fkUT+yi8ShrbHd6zjwGIhqDj4RIAx9z/xOLYIv8
         Uar3RCVS2CWF/+oUID+paunwKKPVwa8pmHcUBbfRq4KSrP9ZfGJSIjXZUKoF0cf0GYqq
         q93M4yalmpkDHtvGciDwLJCYdpxX5zlX97y2lKw9NICBJL8VNPfahRBBTfkoZeS6QY17
         OwKMRev1vrGmQklKdox+/cGAdsR41Ugx0rDZjDgbK5Kt6B0RKosfTEsbLsCyhtLpg5nB
         e4ZuSYTC+zFgt2doc/zXs7tnCMKAJvOUDhIlPYecVse9e3GVEN+sG4639w9lveUpRGuB
         5WHw==
X-Gm-Message-State: AHQUAuY2AEwKtYuAldEj0v0gB0WGqwgBNDnna+1GGhi6pi/VJND8wkXY
        jehMaQLJf7b9iiFr2XqoXucfmQHa620=
X-Google-Smtp-Source: AHgI3IYuPx/R2+kXNlkNbntzM43cl66SK7SPaisNLw53wYVv1HPTAXDETsWKA3DS53736zb9brHT3Q==
X-Received: by 2002:a63:111c:: with SMTP id g28mr14434796pgl.85.1549544284801;
        Thu, 07 Feb 2019 04:58:04 -0800 (PST)
Received: from localhost ([2402:3a80:c80:4138:75dd:3900:1d90:762f])
        by smtp.gmail.com with ESMTPSA id v70sm12338415pfa.152.2019.02.07.04.58.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 04:58:04 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v1 09/24] drivers: thermal: tsens: Merge tsens-8974 into tsens-v0_1
Date:   Thu,  7 Feb 2019 16:19:27 +0530
Message-Id: <36047c52f0e3e49b797cd4c9a7c064f4b6689b98.1549525708.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

8974 and 8916 have the same version of the TSENS IP. Merge the files to
allow for better code reuse.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/Makefile     |   2 +-
 drivers/thermal/qcom/tsens-8974.c | 236 ------------------------------
 drivers/thermal/qcom/tsens-v0_1.c | 229 +++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.h      |   8 +-
 4 files changed, 236 insertions(+), 239 deletions(-)
 delete mode 100644 drivers/thermal/qcom/tsens-8974.c

diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
index 1f2fafd43dff..7fa3cadce760 100644
--- a/drivers/thermal/qcom/Makefile
+++ b/drivers/thermal/qcom/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
-qcom_tsens-y			+= tsens.o tsens-common.o tsens-v0_1.o tsens-8974.o tsens-8960.o tsens-v2.o
+qcom_tsens-y			+= tsens.o tsens-common.o tsens-v0_1.o tsens-8960.o tsens-v2.o
 obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
diff --git a/drivers/thermal/qcom/tsens-8974.c b/drivers/thermal/qcom/tsens-8974.c
deleted file mode 100644
index 303157fd00be..000000000000
--- a/drivers/thermal/qcom/tsens-8974.c
+++ /dev/null
@@ -1,236 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2015, The Linux Foundation. All rights reserved.
- */
-
-#include <linux/platform_device.h>
-#include "tsens.h"
-
-/* eeprom layout data for 8974 */
-#define BASE1_MASK		0xff
-#define S0_P1_MASK		0x3f00
-#define S1_P1_MASK		0xfc000
-#define S2_P1_MASK		0x3f00000
-#define S3_P1_MASK		0xfc000000
-#define S4_P1_MASK		0x3f
-#define S5_P1_MASK		0xfc0
-#define S6_P1_MASK		0x3f000
-#define S7_P1_MASK		0xfc0000
-#define S8_P1_MASK		0x3f000000
-#define S8_P1_MASK_BKP		0x3f
-#define S9_P1_MASK		0x3f
-#define S9_P1_MASK_BKP		0xfc0
-#define S10_P1_MASK		0xfc0
-#define S10_P1_MASK_BKP		0x3f000
-#define CAL_SEL_0_1		0xc0000000
-#define CAL_SEL_2		0x40000000
-#define CAL_SEL_SHIFT		30
-#define CAL_SEL_SHIFT_2		28
-
-#define S0_P1_SHIFT		8
-#define S1_P1_SHIFT		14
-#define S2_P1_SHIFT		20
-#define S3_P1_SHIFT		26
-#define S5_P1_SHIFT		6
-#define S6_P1_SHIFT		12
-#define S7_P1_SHIFT		18
-#define S8_P1_SHIFT		24
-#define S9_P1_BKP_SHIFT		6
-#define S10_P1_SHIFT		6
-#define S10_P1_BKP_SHIFT	12
-
-#define BASE2_SHIFT		12
-#define BASE2_BKP_SHIFT		18
-#define S0_P2_SHIFT		20
-#define S0_P2_BKP_SHIFT		26
-#define S1_P2_SHIFT		26
-#define S2_P2_BKP_SHIFT		6
-#define S3_P2_SHIFT		6
-#define S3_P2_BKP_SHIFT		12
-#define S4_P2_SHIFT		12
-#define S4_P2_BKP_SHIFT		18
-#define S5_P2_SHIFT		18
-#define S5_P2_BKP_SHIFT		24
-#define S6_P2_SHIFT		24
-#define S7_P2_BKP_SHIFT		6
-#define S8_P2_SHIFT		6
-#define S8_P2_BKP_SHIFT		12
-#define S9_P2_SHIFT		12
-#define S9_P2_BKP_SHIFT		18
-#define S10_P2_SHIFT		18
-#define S10_P2_BKP_SHIFT	24
-
-#define BASE2_MASK		0xff000
-#define BASE2_BKP_MASK		0xfc0000
-#define S0_P2_MASK		0x3f00000
-#define S0_P2_BKP_MASK		0xfc000000
-#define S1_P2_MASK		0xfc000000
-#define S1_P2_BKP_MASK		0x3f
-#define S2_P2_MASK		0x3f
-#define S2_P2_BKP_MASK		0xfc0
-#define S3_P2_MASK		0xfc0
-#define S3_P2_BKP_MASK		0x3f000
-#define S4_P2_MASK		0x3f000
-#define S4_P2_BKP_MASK		0xfc0000
-#define S5_P2_MASK		0xfc0000
-#define S5_P2_BKP_MASK		0x3f000000
-#define S6_P2_MASK		0x3f000000
-#define S6_P2_BKP_MASK		0x3f
-#define S7_P2_MASK		0x3f
-#define S7_P2_BKP_MASK		0xfc0
-#define S8_P2_MASK		0xfc0
-#define S8_P2_BKP_MASK		0x3f000
-#define S9_P2_MASK		0x3f000
-#define S9_P2_BKP_MASK		0xfc0000
-#define S10_P2_MASK		0xfc0000
-#define S10_P2_BKP_MASK		0x3f000000
-
-#define BKP_SEL			0x3
-#define BKP_REDUN_SEL		0xe0000000
-#define BKP_REDUN_SHIFT		29
-
-#define BIT_APPEND		0x3
-
-static int calibrate_8974(struct tsens_priv *priv)
-{
-	int base1 = 0, base2 = 0, i;
-	u32 p1[11], p2[11];
-	int mode = 0;
-	u32 *calib, *bkp;
-	u32 calib_redun_sel;
-
-	calib = (u32 *)qfprom_read(priv->dev, "calib");
-	if (IS_ERR(calib))
-		return PTR_ERR(calib);
-
-	bkp = (u32 *)qfprom_read(priv->dev, "calib_backup");
-	if (IS_ERR(bkp))
-		return PTR_ERR(bkp);
-
-	calib_redun_sel =  bkp[1] & BKP_REDUN_SEL;
-	calib_redun_sel >>= BKP_REDUN_SHIFT;
-
-	if (calib_redun_sel == BKP_SEL) {
-		mode = (calib[4] & CAL_SEL_0_1) >> CAL_SEL_SHIFT;
-		mode |= (calib[5] & CAL_SEL_2) >> CAL_SEL_SHIFT_2;
-
-		switch (mode) {
-		case TWO_PT_CALIB:
-			base2 = (bkp[2] & BASE2_BKP_MASK) >> BASE2_BKP_SHIFT;
-			p2[0] = (bkp[2] & S0_P2_BKP_MASK) >> S0_P2_BKP_SHIFT;
-			p2[1] = (bkp[3] & S1_P2_BKP_MASK);
-			p2[2] = (bkp[3] & S2_P2_BKP_MASK) >> S2_P2_BKP_SHIFT;
-			p2[3] = (bkp[3] & S3_P2_BKP_MASK) >> S3_P2_BKP_SHIFT;
-			p2[4] = (bkp[3] & S4_P2_BKP_MASK) >> S4_P2_BKP_SHIFT;
-			p2[5] = (calib[4] & S5_P2_BKP_MASK) >> S5_P2_BKP_SHIFT;
-			p2[6] = (calib[5] & S6_P2_BKP_MASK);
-			p2[7] = (calib[5] & S7_P2_BKP_MASK) >> S7_P2_BKP_SHIFT;
-			p2[8] = (calib[5] & S8_P2_BKP_MASK) >> S8_P2_BKP_SHIFT;
-			p2[9] = (calib[5] & S9_P2_BKP_MASK) >> S9_P2_BKP_SHIFT;
-			p2[10] = (calib[5] & S10_P2_BKP_MASK) >> S10_P2_BKP_SHIFT;
-			/* Fall through */
-		case ONE_PT_CALIB:
-		case ONE_PT_CALIB2:
-			base1 = bkp[0] & BASE1_MASK;
-			p1[0] = (bkp[0] & S0_P1_MASK) >> S0_P1_SHIFT;
-			p1[1] = (bkp[0] & S1_P1_MASK) >> S1_P1_SHIFT;
-			p1[2] = (bkp[0] & S2_P1_MASK) >> S2_P1_SHIFT;
-			p1[3] = (bkp[0] & S3_P1_MASK) >> S3_P1_SHIFT;
-			p1[4] = (bkp[1] & S4_P1_MASK);
-			p1[5] = (bkp[1] & S5_P1_MASK) >> S5_P1_SHIFT;
-			p1[6] = (bkp[1] & S6_P1_MASK) >> S6_P1_SHIFT;
-			p1[7] = (bkp[1] & S7_P1_MASK) >> S7_P1_SHIFT;
-			p1[8] = (bkp[2] & S8_P1_MASK_BKP) >> S8_P1_SHIFT;
-			p1[9] = (bkp[2] & S9_P1_MASK_BKP) >> S9_P1_BKP_SHIFT;
-			p1[10] = (bkp[2] & S10_P1_MASK_BKP) >> S10_P1_BKP_SHIFT;
-			break;
-		}
-	} else {
-		mode = (calib[1] & CAL_SEL_0_1) >> CAL_SEL_SHIFT;
-		mode |= (calib[3] & CAL_SEL_2) >> CAL_SEL_SHIFT_2;
-
-		switch (mode) {
-		case TWO_PT_CALIB:
-			base2 = (calib[2] & BASE2_MASK) >> BASE2_SHIFT;
-			p2[0] = (calib[2] & S0_P2_MASK) >> S0_P2_SHIFT;
-			p2[1] = (calib[2] & S1_P2_MASK) >> S1_P2_SHIFT;
-			p2[2] = (calib[3] & S2_P2_MASK);
-			p2[3] = (calib[3] & S3_P2_MASK) >> S3_P2_SHIFT;
-			p2[4] = (calib[3] & S4_P2_MASK) >> S4_P2_SHIFT;
-			p2[5] = (calib[3] & S5_P2_MASK) >> S5_P2_SHIFT;
-			p2[6] = (calib[3] & S6_P2_MASK) >> S6_P2_SHIFT;
-			p2[7] = (calib[4] & S7_P2_MASK);
-			p2[8] = (calib[4] & S8_P2_MASK) >> S8_P2_SHIFT;
-			p2[9] = (calib[4] & S9_P2_MASK) >> S9_P2_SHIFT;
-			p2[10] = (calib[4] & S10_P2_MASK) >> S10_P2_SHIFT;
-			/* Fall through */
-		case ONE_PT_CALIB:
-		case ONE_PT_CALIB2:
-			base1 = calib[0] & BASE1_MASK;
-			p1[0] = (calib[0] & S0_P1_MASK) >> S0_P1_SHIFT;
-			p1[1] = (calib[0] & S1_P1_MASK) >> S1_P1_SHIFT;
-			p1[2] = (calib[0] & S2_P1_MASK) >> S2_P1_SHIFT;
-			p1[3] = (calib[0] & S3_P1_MASK) >> S3_P1_SHIFT;
-			p1[4] = (calib[1] & S4_P1_MASK);
-			p1[5] = (calib[1] & S5_P1_MASK) >> S5_P1_SHIFT;
-			p1[6] = (calib[1] & S6_P1_MASK) >> S6_P1_SHIFT;
-			p1[7] = (calib[1] & S7_P1_MASK) >> S7_P1_SHIFT;
-			p1[8] = (calib[1] & S8_P1_MASK) >> S8_P1_SHIFT;
-			p1[9] = (calib[2] & S9_P1_MASK);
-			p1[10] = (calib[2] & S10_P1_MASK) >> S10_P1_SHIFT;
-			break;
-		}
-	}
-
-	switch (mode) {
-	case ONE_PT_CALIB:
-		for (i = 0; i < priv->num_sensors; i++)
-			p1[i] += (base1 << 2) | BIT_APPEND;
-		break;
-	case TWO_PT_CALIB:
-		for (i = 0; i < priv->num_sensors; i++) {
-			p2[i] += base2;
-			p2[i] <<= 2;
-			p2[i] |= BIT_APPEND;
-		}
-		/* Fall through */
-	case ONE_PT_CALIB2:
-		for (i = 0; i < priv->num_sensors; i++) {
-			p1[i] += base1;
-			p1[i] <<= 2;
-			p1[i] |= BIT_APPEND;
-		}
-		break;
-	default:
-		for (i = 0; i < priv->num_sensors; i++)
-			p2[i] = 780;
-		p1[0] = 502;
-		p1[1] = 509;
-		p1[2] = 503;
-		p1[3] = 509;
-		p1[4] = 505;
-		p1[5] = 509;
-		p1[6] = 507;
-		p1[7] = 510;
-		p1[8] = 508;
-		p1[9] = 509;
-		p1[10] = 508;
-		break;
-	}
-
-	compute_intercept_slope(priv, p1, p2, mode);
-
-	return 0;
-}
-
-static const struct tsens_ops ops_8974 = {
-	.init		= init_common,
-	.calibrate	= calibrate_8974,
-	.get_temp	= get_temp_common,
-};
-
-const struct tsens_plat_data data_8974 = {
-	.num_sensors	= 11,
-	.ops		= &ops_8974,
-	.reg_offsets	= { [SROT_CTRL_OFFSET] = 0x0 },
-};
diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index 30909594b1cf..a6e26be1234f 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -39,6 +39,91 @@
 #define MSM8916_CAL_SEL_MASK	0xe0000000
 #define MSM8916_CAL_SEL_SHIFT	29
 
+/* eeprom layout data for 8974 */
+#define BASE1_MASK		0xff
+#define S0_P1_MASK		0x3f00
+#define S1_P1_MASK		0xfc000
+#define S2_P1_MASK		0x3f00000
+#define S3_P1_MASK		0xfc000000
+#define S4_P1_MASK		0x3f
+#define S5_P1_MASK		0xfc0
+#define S6_P1_MASK		0x3f000
+#define S7_P1_MASK		0xfc0000
+#define S8_P1_MASK		0x3f000000
+#define S8_P1_MASK_BKP		0x3f
+#define S9_P1_MASK		0x3f
+#define S9_P1_MASK_BKP		0xfc0
+#define S10_P1_MASK		0xfc0
+#define S10_P1_MASK_BKP		0x3f000
+#define CAL_SEL_0_1		0xc0000000
+#define CAL_SEL_2		0x40000000
+#define CAL_SEL_SHIFT		30
+#define CAL_SEL_SHIFT_2		28
+
+#define S0_P1_SHIFT		8
+#define S1_P1_SHIFT		14
+#define S2_P1_SHIFT		20
+#define S3_P1_SHIFT		26
+#define S5_P1_SHIFT		6
+#define S6_P1_SHIFT		12
+#define S7_P1_SHIFT		18
+#define S8_P1_SHIFT		24
+#define S9_P1_BKP_SHIFT		6
+#define S10_P1_SHIFT		6
+#define S10_P1_BKP_SHIFT	12
+
+#define BASE2_SHIFT		12
+#define BASE2_BKP_SHIFT		18
+#define S0_P2_SHIFT		20
+#define S0_P2_BKP_SHIFT		26
+#define S1_P2_SHIFT		26
+#define S2_P2_BKP_SHIFT		6
+#define S3_P2_SHIFT		6
+#define S3_P2_BKP_SHIFT		12
+#define S4_P2_SHIFT		12
+#define S4_P2_BKP_SHIFT		18
+#define S5_P2_SHIFT		18
+#define S5_P2_BKP_SHIFT		24
+#define S6_P2_SHIFT		24
+#define S7_P2_BKP_SHIFT		6
+#define S8_P2_SHIFT		6
+#define S8_P2_BKP_SHIFT		12
+#define S9_P2_SHIFT		12
+#define S9_P2_BKP_SHIFT		18
+#define S10_P2_SHIFT		18
+#define S10_P2_BKP_SHIFT	24
+
+#define BASE2_MASK		0xff000
+#define BASE2_BKP_MASK		0xfc0000
+#define S0_P2_MASK		0x3f00000
+#define S0_P2_BKP_MASK		0xfc000000
+#define S1_P2_MASK		0xfc000000
+#define S1_P2_BKP_MASK		0x3f
+#define S2_P2_MASK		0x3f
+#define S2_P2_BKP_MASK		0xfc0
+#define S3_P2_MASK		0xfc0
+#define S3_P2_BKP_MASK		0x3f000
+#define S4_P2_MASK		0x3f000
+#define S4_P2_BKP_MASK		0xfc0000
+#define S5_P2_MASK		0xfc0000
+#define S5_P2_BKP_MASK		0x3f000000
+#define S6_P2_MASK		0x3f000000
+#define S6_P2_BKP_MASK		0x3f
+#define S7_P2_MASK		0x3f
+#define S7_P2_BKP_MASK		0xfc0
+#define S8_P2_MASK		0xfc0
+#define S8_P2_BKP_MASK		0x3f000
+#define S9_P2_MASK		0x3f000
+#define S9_P2_BKP_MASK		0xfc0000
+#define S10_P2_MASK		0xfc0000
+#define S10_P2_BKP_MASK		0x3f000000
+
+#define BKP_SEL			0x3
+#define BKP_REDUN_SEL		0xe0000000
+#define BKP_REDUN_SHIFT		29
+
+#define BIT_APPEND		0x3
+
 static int calibrate_8916(struct tsens_priv *priv)
 {
 	int base0 = 0, base1 = 0, i;
@@ -91,6 +176,138 @@ static int calibrate_8916(struct tsens_priv *priv)
 	return 0;
 }
 
+static int calibrate_8974(struct tsens_priv *priv)
+{
+	int base1 = 0, base2 = 0, i;
+	u32 p1[11], p2[11];
+	int mode = 0;
+	u32 *calib, *bkp;
+	u32 calib_redun_sel;
+
+	calib = (u32 *)qfprom_read(priv->dev, "calib");
+	if (IS_ERR(calib))
+		return PTR_ERR(calib);
+
+	bkp = (u32 *)qfprom_read(priv->dev, "calib_backup");
+	if (IS_ERR(bkp))
+		return PTR_ERR(bkp);
+
+	calib_redun_sel =  bkp[1] & BKP_REDUN_SEL;
+	calib_redun_sel >>= BKP_REDUN_SHIFT;
+
+	if (calib_redun_sel == BKP_SEL) {
+		mode = (calib[4] & CAL_SEL_0_1) >> CAL_SEL_SHIFT;
+		mode |= (calib[5] & CAL_SEL_2) >> CAL_SEL_SHIFT_2;
+
+		switch (mode) {
+		case TWO_PT_CALIB:
+			base2 = (bkp[2] & BASE2_BKP_MASK) >> BASE2_BKP_SHIFT;
+			p2[0] = (bkp[2] & S0_P2_BKP_MASK) >> S0_P2_BKP_SHIFT;
+			p2[1] = (bkp[3] & S1_P2_BKP_MASK);
+			p2[2] = (bkp[3] & S2_P2_BKP_MASK) >> S2_P2_BKP_SHIFT;
+			p2[3] = (bkp[3] & S3_P2_BKP_MASK) >> S3_P2_BKP_SHIFT;
+			p2[4] = (bkp[3] & S4_P2_BKP_MASK) >> S4_P2_BKP_SHIFT;
+			p2[5] = (calib[4] & S5_P2_BKP_MASK) >> S5_P2_BKP_SHIFT;
+			p2[6] = (calib[5] & S6_P2_BKP_MASK);
+			p2[7] = (calib[5] & S7_P2_BKP_MASK) >> S7_P2_BKP_SHIFT;
+			p2[8] = (calib[5] & S8_P2_BKP_MASK) >> S8_P2_BKP_SHIFT;
+			p2[9] = (calib[5] & S9_P2_BKP_MASK) >> S9_P2_BKP_SHIFT;
+			p2[10] = (calib[5] & S10_P2_BKP_MASK) >> S10_P2_BKP_SHIFT;
+			/* Fall through */
+		case ONE_PT_CALIB:
+		case ONE_PT_CALIB2:
+			base1 = bkp[0] & BASE1_MASK;
+			p1[0] = (bkp[0] & S0_P1_MASK) >> S0_P1_SHIFT;
+			p1[1] = (bkp[0] & S1_P1_MASK) >> S1_P1_SHIFT;
+			p1[2] = (bkp[0] & S2_P1_MASK) >> S2_P1_SHIFT;
+			p1[3] = (bkp[0] & S3_P1_MASK) >> S3_P1_SHIFT;
+			p1[4] = (bkp[1] & S4_P1_MASK);
+			p1[5] = (bkp[1] & S5_P1_MASK) >> S5_P1_SHIFT;
+			p1[6] = (bkp[1] & S6_P1_MASK) >> S6_P1_SHIFT;
+			p1[7] = (bkp[1] & S7_P1_MASK) >> S7_P1_SHIFT;
+			p1[8] = (bkp[2] & S8_P1_MASK_BKP) >> S8_P1_SHIFT;
+			p1[9] = (bkp[2] & S9_P1_MASK_BKP) >> S9_P1_BKP_SHIFT;
+			p1[10] = (bkp[2] & S10_P1_MASK_BKP) >> S10_P1_BKP_SHIFT;
+			break;
+		}
+	} else {
+		mode = (calib[1] & CAL_SEL_0_1) >> CAL_SEL_SHIFT;
+		mode |= (calib[3] & CAL_SEL_2) >> CAL_SEL_SHIFT_2;
+
+		switch (mode) {
+		case TWO_PT_CALIB:
+			base2 = (calib[2] & BASE2_MASK) >> BASE2_SHIFT;
+			p2[0] = (calib[2] & S0_P2_MASK) >> S0_P2_SHIFT;
+			p2[1] = (calib[2] & S1_P2_MASK) >> S1_P2_SHIFT;
+			p2[2] = (calib[3] & S2_P2_MASK);
+			p2[3] = (calib[3] & S3_P2_MASK) >> S3_P2_SHIFT;
+			p2[4] = (calib[3] & S4_P2_MASK) >> S4_P2_SHIFT;
+			p2[5] = (calib[3] & S5_P2_MASK) >> S5_P2_SHIFT;
+			p2[6] = (calib[3] & S6_P2_MASK) >> S6_P2_SHIFT;
+			p2[7] = (calib[4] & S7_P2_MASK);
+			p2[8] = (calib[4] & S8_P2_MASK) >> S8_P2_SHIFT;
+			p2[9] = (calib[4] & S9_P2_MASK) >> S9_P2_SHIFT;
+			p2[10] = (calib[4] & S10_P2_MASK) >> S10_P2_SHIFT;
+			/* Fall through */
+		case ONE_PT_CALIB:
+		case ONE_PT_CALIB2:
+			base1 = calib[0] & BASE1_MASK;
+			p1[0] = (calib[0] & S0_P1_MASK) >> S0_P1_SHIFT;
+			p1[1] = (calib[0] & S1_P1_MASK) >> S1_P1_SHIFT;
+			p1[2] = (calib[0] & S2_P1_MASK) >> S2_P1_SHIFT;
+			p1[3] = (calib[0] & S3_P1_MASK) >> S3_P1_SHIFT;
+			p1[4] = (calib[1] & S4_P1_MASK);
+			p1[5] = (calib[1] & S5_P1_MASK) >> S5_P1_SHIFT;
+			p1[6] = (calib[1] & S6_P1_MASK) >> S6_P1_SHIFT;
+			p1[7] = (calib[1] & S7_P1_MASK) >> S7_P1_SHIFT;
+			p1[8] = (calib[1] & S8_P1_MASK) >> S8_P1_SHIFT;
+			p1[9] = (calib[2] & S9_P1_MASK);
+			p1[10] = (calib[2] & S10_P1_MASK) >> S10_P1_SHIFT;
+			break;
+		}
+	}
+
+	switch (mode) {
+	case ONE_PT_CALIB:
+		for (i = 0; i < priv->num_sensors; i++)
+			p1[i] += (base1 << 2) | BIT_APPEND;
+		break;
+	case TWO_PT_CALIB:
+		for (i = 0; i < priv->num_sensors; i++) {
+			p2[i] += base2;
+			p2[i] <<= 2;
+			p2[i] |= BIT_APPEND;
+		}
+		/* Fall through */
+	case ONE_PT_CALIB2:
+		for (i = 0; i < priv->num_sensors; i++) {
+			p1[i] += base1;
+			p1[i] <<= 2;
+			p1[i] |= BIT_APPEND;
+		}
+		break;
+	default:
+		for (i = 0; i < priv->num_sensors; i++)
+			p2[i] = 780;
+		p1[0] = 502;
+		p1[1] = 509;
+		p1[2] = 503;
+		p1[3] = 509;
+		p1[4] = 505;
+		p1[5] = 509;
+		p1[6] = 507;
+		p1[7] = 510;
+		p1[8] = 508;
+		p1[9] = 509;
+		p1[10] = 508;
+		break;
+	}
+
+	compute_intercept_slope(priv, p1, p2, mode);
+
+	return 0;
+}
+
 static const struct tsens_ops ops_8916 = {
 	.init		= init_common,
 	.calibrate	= calibrate_8916,
@@ -103,3 +320,15 @@ const struct tsens_plat_data data_8916 = {
 	.reg_offsets	= { [SROT_CTRL_OFFSET] = 0x0 },
 	.hw_ids		= (unsigned int []){0, 1, 2, 4, 5 },
 };
+
+static const struct tsens_ops ops_8974 = {
+	.init		= init_common,
+	.calibrate	= calibrate_8974,
+	.get_temp	= get_temp_common,
+};
+
+const struct tsens_plat_data data_8974 = {
+	.num_sensors	= 11,
+	.ops		= &ops_8974,
+	.reg_offsets	= { [SROT_CTRL_OFFSET] = 0x0 },
+};
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 4d6a406f8dca..27b8f74829d9 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -116,8 +116,12 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mo
 int init_common(struct tsens_priv *priv);
 int get_temp_common(struct tsens_priv *priv, int i, int *temp);
 
-/* TSENS v1 targets */
-extern const struct tsens_plat_data data_8916, data_8974, data_8960;
+/* TSENS target */
+extern const struct tsens_plat_data data_8960;
+
+/* TSENS v0.1 targets */
+extern const struct tsens_plat_data data_8916, data_8974;
+
 /* TSENS v2 targets */
 extern const struct tsens_plat_data data_8996, data_tsens_v2;
 
-- 
2.17.1

