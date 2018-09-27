Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447F8C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C012156B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D5NGjRgK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C012156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbeI0PdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:33:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38862 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbeI0PdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:33:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id r77-v6so1493146pgr.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 02:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=axrz9BaLRBdHfIllkoNDC76+ARIPCmrfuOnxOMTj8gg=;
        b=D5NGjRgKUlOOSFX0MOOHgOZ46FT51aTGck3K+mATbtrlaBmnhCd3ZJtceJObyXEqBx
         V51Io6gzfSfYa872aCY5VwGPBAE3guh5+LtIwt7CHYkUplmwuYXo6Yp14au44qjlmtG7
         OPHnDbWAOoLIoOEbq7ZT7Y+sNiNdLuY5QZoKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=axrz9BaLRBdHfIllkoNDC76+ARIPCmrfuOnxOMTj8gg=;
        b=VyVTq5yPAXoX+PC8erJCOWy8orbagVGn3X5SHA87A5xHHo7ERyxHGJ/fE4PWXkwTeb
         JEXhhQV/ABfJtBkwWyWyMzlaCgLfyDXXb8ynl94YVnms1BAn7VnrrN+Q0HtOHa2muD3u
         nuaKQivJgX2J/w1GTZbbXhLq0873v1R6dU3wuCsRR9Jc29X8b0fABeLuU6OqIcNjWX5i
         DRnH7Nwbus7+fbVMBNPcSqiPtranuqTJ4Xdi/3J2Xu6nYp0iSidCMp5I01ICGM1/U0aC
         NP9epEDUUJZj9LWsgJ/YIJm4QUsChaxaCPSE0Pr+4IVgq2079NhOfpGbtZgGDcuOHjHe
         5VoA==
X-Gm-Message-State: ABuFfohgm0zzewe0zBfLJ9oNBWFTLhPG9CLqj6tMetuVtld73LpRhL4R
        Qg+UXIl6moaX7bQvoVFYu1GVKw==
X-Google-Smtp-Source: ACcGV63gu695K0/1bz4vAJYi3s3OWsdhCxEYIaXiLydPVIubJ8a9P/OVT/Y9qyeOYO7VM9QjPIwdng==
X-Received: by 2002:a17:902:1744:: with SMTP id i62-v6mr9929522pli.315.1538039757763;
        Thu, 27 Sep 2018 02:15:57 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id y1-v6sm2502023pfy.89.2018.09.27.02.15.53
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 02:15:56 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     linus.walleij@linaro.org, orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc:     baolin.wang@linaro.org, broonie@kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: sprd: Move DT parsing before registering pinctrl device
Date:   Thu, 27 Sep 2018 17:15:08 +0800
Message-Id: <07c454a686966823161ebfe1ed7c08f29032fb2c.1538039535.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It will be failed to select default or sleep state for pins hogged
by the pin controller device, since we hadn't parsed pins configuration
in device tree before registering the pin controller device. Thus
we should move the device tree parsing function before registering
the pin controller device.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/pinctrl/sprd/pinctrl-sprd.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/sprd/pinctrl-sprd.c b/drivers/pinctrl/sprd/pinctrl-sprd.c
index 78c2f54..4537b54 100644
--- a/drivers/pinctrl/sprd/pinctrl-sprd.c
+++ b/drivers/pinctrl/sprd/pinctrl-sprd.c
@@ -1059,6 +1059,12 @@ int sprd_pinctrl_core_probe(struct platform_device *pdev,
 		return ret;
 	}
 
+	ret = sprd_pinctrl_parse_dt(sprd_pctl);
+	if (ret) {
+		dev_err(&pdev->dev, "fail to parse dt properties\n");
+		return ret;
+	}
+
 	pin_desc = devm_kcalloc(&pdev->dev,
 				pinctrl_info->npins,
 				sizeof(struct pinctrl_pin_desc),
@@ -1083,13 +1089,6 @@ int sprd_pinctrl_core_probe(struct platform_device *pdev,
 		return PTR_ERR(sprd_pctl->pctl);
 	}
 
-	ret = sprd_pinctrl_parse_dt(sprd_pctl);
-	if (ret) {
-		dev_err(&pdev->dev, "fail to parse dt properties\n");
-		pinctrl_unregister(sprd_pctl->pctl);
-		return ret;
-	}
-
 	return 0;
 }
 
-- 
1.7.9.5

