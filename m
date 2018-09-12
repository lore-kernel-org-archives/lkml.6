Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5474C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F2FE20882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QxsYTz7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2FE20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbeILO5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:57:14 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40941 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbeILO5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:57:14 -0400
Received: by mail-ed1-f67.google.com with SMTP id j62-v6so1249525edd.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 02:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ZveZRZ6ez2WFXt4vWZSNreLB4c6rXEn4jTnJUKvsQDk=;
        b=QxsYTz7wjLzAywPKeME/lb8Kr8KJSddcqY8CX2VtPjYdD8sXXSX1X4DuI0Rj7+/Ij1
         LeU55vndWr0mBFKqCMwePkISgioxpm3ga2vVaqwJxehCslUgTO/6f3LPJqh8XdtJsG2D
         em7bAXoBOxPifhvgQrTGzKstdmo8MhwIUQlrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ZveZRZ6ez2WFXt4vWZSNreLB4c6rXEn4jTnJUKvsQDk=;
        b=WKqhJXa1PXvSwicpGGzOod2+jms90Fbm0zd8SK1503+B1yS7po9+uERw9cLmCFzrSb
         DF2PFTbMAKJJpopVchDnooDhqonJDc42KA6CDfFy8I/fJkwWupcG1KucTKXFP3pODERX
         CjK9BFaGSgI1qrdMbb65rouGugThW47vvDZSspCVAKdRyAnM9VHcQrZCF/4q/p36jhTn
         +JyydWl1kZhJH6SbaaKHUVE15hYZg025iuOLJXKvjOr3m52RLUpCKDt/APSdu3VuO5Vy
         K0gbpsljUMsv+pQaZIB5ViCGkAKLGvLqYyPYn9H6JkO7nIKWZcvlLc12oZ2IlaXaFoHq
         PcEg==
X-Gm-Message-State: APzg51CEk8lL4HKhb66KOZq+DrpCOOIXMbbDI9N/bppWfZZyEi5QUCYN
        D4oB7vy7aLTH4CPyZ5x2YWGiKR0B7uA=
X-Google-Smtp-Source: ANB0VdbezJYA1okTuxZA969YIcAwld6Dr6dbeD2oN/IUevWxzHdxu8xzerKB+QUIvDhTctj33Irkww==
X-Received: by 2002:a50:f297:: with SMTP id f23-v6mr1870386edm.40.1536746006441;
        Wed, 12 Sep 2018 02:53:26 -0700 (PDT)
Received: from localhost ([49.248.190.214])
        by smtp.gmail.com with ESMTPSA id a33-v6sm433189eda.2.2018.09.12.02.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 02:53:25 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 01/16] thermal: tsens: Prepare 8916 and 8974 tsens to use SROT and TM address space
Date:   Wed, 12 Sep 2018 15:22:46 +0530
Message-Id: <b136431f98d157a1844fe42dd1b35a0a9e0128d3.1536744310.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1536744310.git.amit.kucheria@linaro.org>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1536744310.git.amit.kucheria@linaro.org>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've already converted over the devicetree of platforms using v2
version of the TSENS IP to use two address spaces. Now prepare to
convert over the 8916 and 8974 platforms to use separate SROT and TM
address spaces.

This patch will work with device trees with one or two address spaces
because we set the tm_offset in commit 5b1283984fa3 ("thermal: tsens:
Add support to split up register address space into two").

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/thermal/qcom/tsens-common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 6207d8d92351..478739543bbc 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -21,7 +21,7 @@
 #include <linux/regmap.h>
 #include "tsens.h"
 
-#define S0_ST_ADDR		0x1030
+#define STATUS_OFFSET		0x30
 #define SN_ADDR_OFFSET		0x4
 #define SN_ST_TEMP_MASK		0x3ff
 #define CAL_DEGC_PT1		30
@@ -107,8 +107,9 @@ int get_temp_common(struct tsens_device *tmdev, int id, int *temp)
 	unsigned int status_reg;
 	int last_temp = 0, ret;
 
-	status_reg = S0_ST_ADDR + s->hw_id * SN_ADDR_OFFSET;
+	status_reg = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * SN_ADDR_OFFSET;
 	ret = regmap_read(tmdev->map, status_reg, &code);
+
 	if (ret)
 		return ret;
 	last_temp = code & SN_ST_TEMP_MASK;
-- 
2.17.1

