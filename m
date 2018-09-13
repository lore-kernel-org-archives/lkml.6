Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F761C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC3A204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jybs0AEE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC3A204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbeIMXQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 19:16:54 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41448 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbeIMXQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 19:16:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id h79-v6so3025122pfk.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 11:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UhWsM1uFegA3yqM6IdX1PUXA06hwvmU505oKPVKDDYw=;
        b=Jybs0AEEia4rbecGeVTRjb3+rZjXXZ9udToUg2BmfazsCMZbWAY8uqe/0H20VRQwLf
         hDSVlj8V4Ly3MDH1Wk+zgAsC0rAnJ2yH0TzdXv0UiNE4qWUAQ5YTxiBn3RNDmKPIjsf1
         TltrxCtcxPR7vz6lhG8e8xexa4OFphNJQGj44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UhWsM1uFegA3yqM6IdX1PUXA06hwvmU505oKPVKDDYw=;
        b=MJ9okDV4Z+kmtzo1XHwPSVwdQsWFW8fZv9Uw5V0Sfoq9Cu8d/W66mJ+zzc0jT25mQY
         0FVlIPaZkpNt8OJwEE+WOJsXQrzTQPfUpg/e1VL4Wj0zvH3S3LKdBTSHsuNPUhdXTnGT
         4FoWjAONhN08YerPis4cfjiofiugdA0S2Afh5v7SAqbMpHkhFTBGNH5T24w91aKMnNLG
         uEOyitbf+/dSwZzww6/69Kw4y0cymzxMtAt4eDqpj96eONbNBs3JmMKQkBLsJO/XMUQh
         5woG76oszXQlyji+02U7+cZz+lSxntz/uksLMhi9RpKYozW/F6kCUR+PXrZUyExUs3tV
         rlKw==
X-Gm-Message-State: APzg51DpJ2TA1mru90uMW7jvkLPOZBGe2DGfUvtiOV+wT8ZjhthSld/5
        2IKunUhjMA9O9IPBW9bkucfq
X-Google-Smtp-Source: ANB0VdZ9f5+JMrv2KRhbQlU9mok5unuWnmgbpqBaIuHFbTWuPE9Hn/PYiNyEUJE5I0LyreASa5aQAg==
X-Received: by 2002:a63:906:: with SMTP id 6-v6mr7958352pgj.92.1536861978297;
        Thu, 13 Sep 2018 11:06:18 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6115:a36e:955b:f94d:4607:e9b9])
        by smtp.gmail.com with ESMTPSA id u184-v6sm8856802pgd.46.2018.09.13.11.06.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 11:06:17 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     heiko@sntech.de, robh+dt@kernel.org
Cc:     vicencb@gmail.com, shawn.lin@rock-chips.com,
        ezequiel@collabora.com, enric.balletbo@collabora.com,
        pbrobinson@gmail.com, tom@vamrs.com, dev@vamrs.com,
        stephen@vamrs.com, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 2/4] dt-bindings: arm: rockchip: Add binding for Rock960 board
Date:   Thu, 13 Sep 2018 23:35:43 +0530
Message-Id: <20180913180545.29756-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180913180545.29756-1-manivannan.sadhasivam@linaro.org>
References: <20180913180545.29756-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Rock960 board from Vamrs Limited.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/rockchip.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
index acfd3c773dd0..4b6888a21db2 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.txt
+++ b/Documentation/devicetree/bindings/arm/rockchip.txt
@@ -5,6 +5,10 @@ Rockchip platforms device tree bindings
     Required root node properties:
       - compatible = "vamrs,ficus", "rockchip,rk3399";
 
+- 96boards RK3399 Rock960 (ROCK960 Consumer Edition)
+    Required root node properties:
+      - compatible = "vamrs,rock960", "rockchip,rk3399";
+
 - Amarula Vyasa RK3288 board
     Required root node properties:
       - compatible = "amarula,vyasa-rk3288", "rockchip,rk3288";
-- 
2.17.1

