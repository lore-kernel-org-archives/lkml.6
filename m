Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3ADCAC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8732086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="isZzJiXi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8732086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933277AbeFLK4A (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 06:56:00 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39809 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933394AbeFLKz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 06:55:56 -0400
Received: by mail-lf0-f68.google.com with SMTP id t134-v6so35302927lff.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 03:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=IsTrdZ+kDihtM/XHpghRzKqziLMnz08SUOtIHPMaoHk=;
        b=isZzJiXi+rLTzHRpafJw0fs25sc4Vi13LlgvCI0+WtbmNyJvAigBgGl6PF3870/xAQ
         v9KBEXySnExvg87WZ3yeSuXXUOdktnxloyDc2xuyBIhK9TjzSxxTfyEZ0XfpsRx1+1Je
         6mAY59v72Qq3GYZSwmxh4mS4xcBnJGogj56LE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=IsTrdZ+kDihtM/XHpghRzKqziLMnz08SUOtIHPMaoHk=;
        b=mojhqvk6r4UB/Fp3eJwGOz2YoHUnFUXe9XUhoo816BePE6cviFLv3gcvYWsBHloqnv
         X5GaDYLLZNNnsRBdXPnXGu81HfxFh5eS8a75YMsKNEhHdUMoCU6Yu2FGRy1CYe3BSZGD
         dtSbmFMIuy718OoDREjz8V5Amu51pbWl2RsOA/9hezu9yryBJynMFrRiDizv70v5qB54
         mpWHARNwyH3zEFHhLSqHeKSj+EA57lzTRn0C4iMwKvj+2F7FFrXssSmQ82/S4a/JoI0x
         /IikPn79XKrMktgCf+MmID40rZW5Z1+KM5xPJwLpUIVp0d6MtyFhsa6trThstmTRXQv8
         gGmQ==
X-Gm-Message-State: APt69E2kHI346t1UF5ikKk+JSmn5ZEuoylHQ09lFGgjCYl5+akVB/r2U
        O2fzGkiVa1hh3LkzzAOxSuIxCEQuGTg=
X-Google-Smtp-Source: ADUXVKLxe+VfePNPZrwrUR1gMxhzkMdgPms+Rl61e1lMDm510S6x8W/tCQ9ApEj++aoUIBIyPrnkRA==
X-Received: by 2002:a19:1c5:: with SMTP id 188-v6mr1919305lfb.67.1528800954642;
        Tue, 12 Jun 2018 03:55:54 -0700 (PDT)
Received: from localhost (85-76-96-64-nat.elisa-mobile.fi. [85.76.96.64])
        by smtp.gmail.com with ESMTPSA id r27-v6sm144699lfi.8.2018.06.12.03.55.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 03:55:54 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org (open list:THERMAL)
Subject: [PATCH v2 5/5] thermal: tsens: Check if we have valid data before reading
Date:   Tue, 12 Jun 2018 13:54:57 +0300
Message-Id: <021331bdb04642e9ddf34accda65a93b850c4a23.1528799892.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1528799892.git.amit.kucheria@linaro.org>
References: <cover.1528799892.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1528799892.git.amit.kucheria@linaro.org>
References: <cover.1528799892.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 961ace4..f510e61 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -114,6 +114,9 @@ int get_temp_common(struct tsens_device *tmdev, int id, int *temp)
 #define STATUS_VALID_BIT	BIT(21)
 #define CODE_SIGN_BIT		BIT(11)
 
+#define TRDY_OFFSET     	0xe4
+#define TRDY_READY_BIT  	BIT(0)
+
 int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
 {
 	struct tsens_sensor *s = &tmdev->sensor[id];
@@ -121,6 +124,12 @@ int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
 	unsigned int sensor_addr;
 	int last_temp = 0, last_temp2 = 0, last_temp3 = 0, ret;
 
+	ret = regmap_read(tmdev->map, TRDY_OFFSET, &code);
+	if (ret)
+		return ret;
+	if (code & TRDY_READY_BIT)
+		return -ENODATA;
+
 	sensor_addr = STATUS_OFFSET + s->hw_id * 4;
 	ret = regmap_read(tmdev->map, sensor_addr, &code);
 	if (ret)
-- 
2.7.4

