Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EBAC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D88B20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KjNuWYPO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D88B20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbeLFSpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:45:51 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39102 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbeLFSpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:45:51 -0500
Received: by mail-pl1-f194.google.com with SMTP id 101so569454pld.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 10:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6knYnBqW8xngqr8ly8uxHOiioc+WVx6u/9pPsuJ2b4Y=;
        b=KjNuWYPOVk/iRVnTzF0r4YYvOwzuGKARKKEXssldZ0zSbIp5ptxB0+51RwEvEoxv6A
         sjLrFHL1z6SSJevElEXvp7VWNW1PwIEA1w8pIGpR27n0DEtmrQ2FvkawDWuCnN1oU7GT
         HGluL3LSVS42dc/+AtT0BkC2PqA8posliULc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6knYnBqW8xngqr8ly8uxHOiioc+WVx6u/9pPsuJ2b4Y=;
        b=sIM6Vt50rddyHbWNiNdXlmxenVymimdGLrihhx6/3KANQJeHySaLCXExYrg5ODGa1T
         K1gehbK5482fpvEd08iDoRin5ZB5P6xchg8HdQYQ+W33z/C66ZsgXgicb/wdKPrn1Wup
         LDaJPelU3qv5M7IPzgwIgC09z4CaJQ9paz4sNmIoURvQMKOB0DRCEQd0c8K1UsT1CCmn
         1RUqgK8XVRMk9gXP4MlVJE3EcBwCWqo1ICRIYvmAWJt4yVkY5XhtNKFI/Pv9X5Kuxt3n
         Ale8jfu2pWIdcDFwFfM24G4nO42LAH5CRqJ6BbD5v4FOy4O3VNNkZ0zBTZ/xQYBqiVev
         KLxw==
X-Gm-Message-State: AA+aEWZLlHmhcc2+d4H9RQF3eVRRnwtwSk+Hs54wt754x2ASQ05adHrB
        3Nn/xryRBoQMpk1n2zkdBC2z3g==
X-Google-Smtp-Source: AFSGD/UK1mlle9UaXsWD0aBH8F2Zd/pTMbS5MHNCSKnLm1gQVR/C2FK4mMc3YXeyMFYSxJo8kM8Zdg==
X-Received: by 2002:a17:902:bc43:: with SMTP id t3mr27357101plz.124.1544121950564;
        Thu, 06 Dec 2018 10:45:50 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id v89sm1458476pfk.12.2018.12.06.10.45.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Dec 2018 10:45:49 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 1/3] dt-bindings: mmc: sdhci-msm: Clarify register requirements
Date:   Thu,  6 Dec 2018 10:45:20 -0800
Message-Id: <20181206184522.118062-2-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181206184522.118062-1-evgreen@chromium.org>
References: <20181206184522.118062-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sdhci-msm-v5 and beyond, the MCI registers are removed, so there is only
one register region required.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

Changes in v2: None

 Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
index b72871ac90cb2..da4edb146a983 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
@@ -25,7 +25,7 @@ Required properties:
 
 - reg: Base address and length of the register in the following order:
 	- Host controller register map (required)
-	- SD Core register map (required)
+	- SD Core register map (required for msm-v4 and below)
 - interrupts: Should contain an interrupt-specifiers for the interrupts:
 	- Host controller interrupt (required)
 - pinctrl-names: Should contain only one value - "default".
-- 
2.18.1

