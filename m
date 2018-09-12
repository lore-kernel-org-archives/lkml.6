Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046CBC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B333E204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OEbotGsS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B333E204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeILO51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:57:27 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45752 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbeILO51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:57:27 -0400
Received: by mail-ed1-f67.google.com with SMTP id p52-v6so1230816eda.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 02:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=RXDtbhIMyFAbtAg9tx8eCbbtVuDm61EOqgYh33KEgl8=;
        b=OEbotGsSjoxEa2H9/50/GxFSgmVnTAOrcJRYC3xo0w08omETCoeu6rMeaVS14mbkKL
         pXKHYSn2IZReT9u3hUPQ401KMAu+qZDFMUzchNNrOxEnHRXF3VW7hssbdF7k6YhkhcSp
         3TmTi2ykfyR4GwPfx4Ay+skd12teQHBTW+nYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=RXDtbhIMyFAbtAg9tx8eCbbtVuDm61EOqgYh33KEgl8=;
        b=touV1Ry728jiGCv/sz+hbrVOXyTuP2GEZ9Nx5wxpqMkig5Ye8hmVrXqIeF5w7rF4Zy
         rpPJ+qXf+isU3DAu12ZpBJrhl65U57uaxooNoI/Xv6M0qeZ9ripRbntLSDa4x2B39goi
         d9nUarxVcNvScVXrUtXep4a+1oBF7ujT687i0b2u+r79EypVFG8ktbLBzwtUPUQTDF7c
         U46wO1dtW78wuWkm6/W9QSmBGgjlQaAumzfTHfjcsiSMTRjXzqxlM1u99vYDroxws0a5
         RUeWmjD9fDcNjCu1ZHVVxtu9FUct+3zfslIUF7uAucySsIc28OPQ6qYvwXrttuV4PkvC
         Dylw==
X-Gm-Message-State: APzg51CxStoa/Ghdo9a4GRdForCEkHT6jgUCgbRxVhWT7AE2kxFGZEVr
        oSaRRp3LptO6er4RDzA6eEJrZxQRVIw=
X-Google-Smtp-Source: ANB0VdbX+ZJr3SFGG70Zfh2Ct/HD1a7yxuSJ0YJb9YkUrm7kd0tpgl3e/O2DeaCbvd6ILh7Civo3/w==
X-Received: by 2002:a50:d798:: with SMTP id w24-v6mr1883556edi.19.1536746019244;
        Wed, 12 Sep 2018 02:53:39 -0700 (PDT)
Received: from localhost ([49.248.190.214])
        by smtp.gmail.com with ESMTPSA id e30-v6sm390310ede.91.2018.09.12.02.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 02:53:38 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 03/16] thermal: tsens: Get rid of dead code
Date:   Wed, 12 Sep 2018 15:22:48 +0530
Message-Id: <fd30eebdaa1eab19e233664be3f1562e5ae3ba0d.1536744310.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1536744310.git.amit.kucheria@linaro.org>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1536744310.git.amit.kucheria@linaro.org>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hw_id is dynamically allocated but not used anywhere. Get rid of dead
code.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/thermal/qcom/tsens.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 90bb431cf740..9a8e8f7b4ae1 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -80,11 +80,6 @@ static int tsens_register(struct tsens_device *tmdev)
 {
 	int i;
 	struct thermal_zone_device *tzd;
-	u32 *hw_id, n = tmdev->num_sensors;
-
-	hw_id = devm_kcalloc(tmdev->dev, n, sizeof(u32), GFP_KERNEL);
-	if (!hw_id)
-		return -ENOMEM;
 
 	for (i = 0;  i < tmdev->num_sensors; i++) {
 		tmdev->sensor[i].tmdev = tmdev;
-- 
2.17.1

