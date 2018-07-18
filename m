Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28F4ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02172084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e74zkUDu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02172084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbeGRICM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:02:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35126 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729863AbeGRICK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:02:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id a3-v6so3548180wrt.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 00:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=PRLjO4NtEBHF3gs51RwAFkmtv8s6MEbP/FrpA8XBlqY=;
        b=e74zkUDuqT7GYt7618dzrGPvIsDdZdmol4UIQI7axxkYed1TVtfj4ZJwY6PlJ2d29q
         nC2SGzUeH4zTybBtWaZvWBQkGZd7is9HONCvuWKREXkIlr6XAowV3p50GpVKkziAAOga
         GCRSvf6zZ1BMS1olVsjRH4AFVtu3vidCE+o4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=PRLjO4NtEBHF3gs51RwAFkmtv8s6MEbP/FrpA8XBlqY=;
        b=mMegnin51AZuuwlmAlAcF6Y6+1z5kQ5ZsxjWm7xr0AQQUl2w278O5GPSIOBgFlaHT5
         V9klOA72Z69x4PY7Hwmm/z+eAVRpdePCm/0awYubGAxBYHI3LPSqnEse4V69NJMe7/YH
         yMIfbJMFHKTMEcNh0eVPNNe+FtYJfhruF3gQR8xnczxwCeIp5BF9Umtp6Mkexbjk0R6U
         TZ0f1pSPxmm1RDHMWZrgObz/Ig4yUW4x1rQc78UOhxsDwpo+lgk1VVh8TNKVYzeK13A5
         aQxutV7zxQO5FPlJgtYiMJ2oZtTMYJMQ3vJ9V3UJILU6+dkKMjppwBZ8dldqyxM66V/O
         Cy4A==
X-Gm-Message-State: AOUpUlGerhKRNJaq3LBkuNZjbwE4s7IzkEMFgfkX9eJTDGhuP35BOgV2
        KAEZyYpEipUoxNBZISKIIkmZMFCH8SE=
X-Google-Smtp-Source: AAOMgpcyj2U6XN3lDpbl8ptgh4EVKJFiOG/0L4rQ7/M0q5XTB+A4BYdxfQKPRLJK1ya1Hknxgioncg==
X-Received: by 2002:adf:96c3:: with SMTP id u61-v6mr3477566wrb.72.1531898742996;
        Wed, 18 Jul 2018 00:25:42 -0700 (PDT)
Received: from localhost ([49.248.170.255])
        by smtp.gmail.com with ESMTPSA id l127-v6sm5729520wma.41.2018.07.18.00.25.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 00:25:42 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH v1 3/3] thermal: tsens: Fix negative temperature reporting
Date:   Wed, 18 Jul 2018 12:55:03 +0530
Message-Id: <42d6f2a6f9babd6351bd2fcde4000d5ca9c351ce.1531898088.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1531898088.git.amit.kucheria@linaro.org>
References: <cover.1531898088.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1531898088.git.amit.kucheria@linaro.org>
References: <cover.1531898088.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code will always return 0xffffffff in case of negative
temperatures due to a bug in how the binary sign extension is being done.

Use sign_extend32() instead.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-v2.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 908e3dc..46abc21 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -5,19 +5,20 @@
  */
 
 #include <linux/regmap.h>
+#include <linux/bitops.h>
 #include "tsens.h"
 
 #define STATUS_OFFSET		0xa0
 #define LAST_TEMP_MASK		0xfff
 #define STATUS_VALID_BIT	BIT(21)
-#define CODE_SIGN_BIT		BIT(11)
 
 static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
 {
 	struct tsens_sensor *s = &tmdev->sensor[id];
 	u32 code;
 	unsigned int status_reg;
-	int last_temp = 0, last_temp2 = 0, last_temp3 = 0, ret;
+	u32 last_temp = 0, last_temp2 = 0, last_temp3 = 0;
+	int ret;
 
 	status_reg = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * 4;
 	ret = regmap_read(tmdev->map, status_reg, &code);
@@ -54,12 +55,8 @@ static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
 	else if (last_temp2 == last_temp3)
 		last_temp = last_temp3;
 done:
-	/* Code sign bit is the sign extension for a negative value */
-	if (last_temp & CODE_SIGN_BIT)
-		last_temp |= ~CODE_SIGN_BIT;
-
-	/* Temperatures are in deciCelicius */
-	*temp = last_temp * 100;
+	/* Convert temperatures to milliCelicius */
+	*temp = sign_extend32(last_temp, fls(LAST_TEMP_MASK) - 1) * 100;
 
 	return 0;
 }
-- 
2.7.4

