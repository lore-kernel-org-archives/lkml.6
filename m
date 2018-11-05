Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A48C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67ED32084F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jelXfYer"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67ED32084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387591AbeKFGbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:31:23 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39997 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730194AbeKFGbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:31:22 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so2905554pgp.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 13:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=96QNBMGBYUONd7YA4Rof9glJ141QHgV69o0Smunt7gs=;
        b=jelXfYer3sJh278jBs6rL7O85F/RO6ZGvxms4tzTz+AiY+h3J01ACasZQJdLlx079Z
         EXb9/XVLCzwqLhNu3lLe56BFEPRTCmTMcAPtmHrcBuLgoajeGsV3tQO6LDHbdRUnTb3w
         vzj9avL5tQBxvjvY+3u9Bob0aQeBm7IV3XayI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=96QNBMGBYUONd7YA4Rof9glJ141QHgV69o0Smunt7gs=;
        b=kCrBnQQv1o9NLwWg4ssFy1Hbt95mr7pdFtkcXIz2CFavPX4C5C4HmzSnBjBZgFWIhJ
         nds2nvrQuSW1FYZJuRseFMXLc4vnOeBnrUxJFt6BBv/jyr7rWqPFvnaitL6lF9uN/lLB
         TPmp6Z6G+eG7mBh+PJ2+pImHWg0OtgSjvgfkaAqZLqmUssOlOlZIkGrQt/N3lvufW/Ix
         LKgMYhnB1gqwt9PQXFsCHHq+NBe5BimSwWh3X16sc7xTlEvbcpkPBaYNcl3rTnKigsiO
         RU51O4LwQUlQ7UidDn6Kl7RK7BkwKf7As4JmE8cxC397e3ytfWutDCnHeii78RJwVme6
         rg2Q==
X-Gm-Message-State: AGRZ1gIuL0fYsuVdv1S/h35J7n4V91gRbE96+AblTGbNTkBBio6SWS6j
        zEVmELJsIg7DBDhzZcGtlmiikA==
X-Google-Smtp-Source: AJdET5cW19JlrUoLsd3vbq9EsGgmxlKi366eoHtuMrDisOUZ+pffILyV1UVubaOJAOm596PifMfqeQ==
X-Received: by 2002:a62:5982:: with SMTP id k2-v6mr23073870pfj.180.1541452186991;
        Mon, 05 Nov 2018 13:09:46 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id l26-v6sm79437452pfg.161.2018.11.05.13.09.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 13:09:46 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: qcom: Add SoC-specific string for sdhci-msm-v4 nodes
Date:   Mon,  5 Nov 2018 13:09:21 -0800
Message-Id: <20181105210921.253707-2-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181105210921.253707-1-dianders@chromium.org>
References: <20181105210921.253707-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per upstream discussion [1], we should have an SoC-specific
compatible string for Qualcomm's SDHCI nodes.  Let's add it.

[1] https://lkml.kernel.org/r/20181105203657.GA32282@bogus

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/msm8916.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/msm8992.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index d302d8d639a1..0a7335526063 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -587,7 +587,7 @@
                 };
 
 		sdhc_1: sdhci@7824000 {
-			compatible = "qcom,sdhci-msm-v4";
+			compatible = "qcom,msm8916-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0x07824900 0x11c>, <0x07824000 0x800>;
 			reg-names = "hc_mem", "core_mem";
 
@@ -604,7 +604,7 @@
 		};
 
 		sdhc_2: sdhci@7864000 {
-			compatible = "qcom,sdhci-msm-v4";
+			compatible = "qcom,msm8916-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0x07864900 0x11c>, <0x07864000 0x800>;
 			reg-names = "hc_mem", "core_mem";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8992.dtsi b/arch/arm64/boot/dts/qcom/msm8992.dtsi
index cf5cacdd624d..09d0234cfd99 100644
--- a/arch/arm64/boot/dts/qcom/msm8992.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8992.dtsi
@@ -203,7 +203,7 @@
 		};
 
 		sdhci1: mmc@f9824900 {
-			compatible = "qcom,sdhci-msm-v4";
+			compatible = "qcom,msm8992-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf9824900 0x1a0>, <0xf9824000 0x800>;
 			reg-names = "hc_mem", "core_mem";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index b29fe80d7288..5e19f87df020 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -535,7 +535,7 @@
 
 		sdhc2: sdhci@74a4900 {
 			 status = "disabled";
-			 compatible = "qcom,sdhci-msm-v4";
+			 compatible = "qcom,msm8996-sdhci", "qcom,sdhci-msm-v4";
 			 reg = <0x74a4900 0x314>, <0x74a4000 0x800>;
 			 reg-names = "hc_mem", "core_mem";
 
-- 
2.19.1.930.g4563a0d9d0-goog

