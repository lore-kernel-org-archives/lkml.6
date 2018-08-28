Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1382C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693072084C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jRz3TMe7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693072084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbeH1Rbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:31:33 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43838 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728204AbeH1Rbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:31:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id z27-v6so1390276edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 06:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=KGPNhtmxbZmY2SbJ8bQ/3ZZChD9pwNRV/BvwQjyiwy0=;
        b=jRz3TMe71F2b9UgCkzD8872RQyACr9ec+apqRnpZ79KaxeZs95GJKrl7EJ7TP00HmN
         oBiZ0SKVAN6ysQkAy+RL2UDW4xGMHE6tXVr/nRVaYGwrXKeiZkuR8q3sd9mnYnR+th+G
         fpdheiArd7vZQW4X0JODc4FlL8p+MrCKfCZVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=KGPNhtmxbZmY2SbJ8bQ/3ZZChD9pwNRV/BvwQjyiwy0=;
        b=fYrp6mDYR3ycywpqYU2N1hFOBSj8Mri5NI1m4H5F0khKurg6BUTFr1N+JgL83+lu4k
         fz2FLvxmBJYI3Ms9F5jGOdnxmN44rkylW8Kd1NuzrZ0FMy9AWAdKoavNe7v+EVV6UjrU
         9qcKqPYFddlX09C/6T9iJgwBAzLyGlUvIuDqFlzaebF/PrYyPISfV9Gt8Bnbse6PPlQI
         YROoOtO12x638XMvQEyQmzh6flTeAJ4Jq31CCPUolV4mACkIxajj6+qE2n6oFmIkFSpw
         W2FTX3c5/aRoMWO2itkjGGPqE9Cwf3byeleTq3X4eh5vu0gQoZRkjy7NH4ePHpVP06Ee
         qY7g==
X-Gm-Message-State: APzg51BCza7uBysXOgUceVrX+fxPPrRuCTiSGB4nOPVOUlU4samY9R/Z
        92GR3eeLbyjnHeXrlINFxtOHebQf3HQ=
X-Google-Smtp-Source: ANB0VdZNKw7xwQJRr3KXVdoGG27FVqdKJ9dRAXRYzhb0xiZVY02Bdj5lGHgi8LoHCss7g3OQG0BxeA==
X-Received: by 2002:a50:a9a4:: with SMTP id n33-v6mr2656458edc.208.1535463588592;
        Tue, 28 Aug 2018 06:39:48 -0700 (PDT)
Received: from localhost ([49.248.200.109])
        by smtp.gmail.com with ESMTPSA id r11-v6sm536788edh.32.2018.08.28.06.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 06:39:48 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 08/11] thermal: tsens: Check if the IP is correctly enabled by firmware
Date:   Tue, 28 Aug 2018 19:08:37 +0530
Message-Id: <35c332750fe1eddfa2eb53750b810256310866bd.1535462942.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1535462942.git.amit.kucheria@linaro.org>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1535462942.git.amit.kucheria@linaro.org>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SROT registers are initialised by the secure firmware at boot. We
don't have write access to the registers. Check if the block is enabled
before continuing.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/thermal/qcom/tsens-common.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 0b8a793f15f4..d250b757d1f0 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -12,6 +12,11 @@
 #include <linux/regmap.h>
 #include "tsens.h"
 
+/* SROT */
+#define CTRL_OFFSET		0x4
+#define TSENS_EN		BIT(0)
+
+/* TM */
 #define STATUS_OFFSET		0x30
 #define SN_ADDR_OFFSET		0x4
 #define SN_ST_TEMP_MASK		0x3ff
@@ -119,6 +124,8 @@ int __init init_common(struct tsens_device *tmdev)
 {
 	void __iomem *tm_base, *srot_base;
 	struct resource *res;
+	u32 code;
+	int ret;
 	struct platform_device *op = of_find_device_by_node(tmdev->dev->of_node);
 
 	if (!op)
@@ -151,5 +158,15 @@ int __init init_common(struct tsens_device *tmdev)
 	if (IS_ERR(tmdev->tm_map))
 		return PTR_ERR(tmdev->tm_map);
 
+	if (tmdev->srot_map) {
+		ret = regmap_read(tmdev->srot_map, CTRL_OFFSET, &code);
+		if (ret)
+			return ret;
+		if (!(code & TSENS_EN)) {
+			dev_err(tmdev->dev, "tsens device is not enabled\n");
+			return -ENODEV;
+		}
+	}
+
 	return 0;
 }
-- 
2.17.1

