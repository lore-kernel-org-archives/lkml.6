Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F697C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289902085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bydYF52t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 289902085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbeKFGbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:31:21 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44427 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729559AbeKFGbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:31:21 -0500
Received: by mail-pl1-f193.google.com with SMTP id s5-v6so5039624plq.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 13:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZR3dSpwHeHS8JNLbewKBD8mo1RLBu0PiM26k3ABT1to=;
        b=bydYF52tEvWY8DDZ6mhpcKU63fegOm1orauRUs3GhtGTxHQQ7FP9sqhFkOCkWeIX/o
         RpF65818iQkPLSI4y841EgK5YxCulRrihFhgjja1XRg9Qu81jFPYCgbW42mIF09wcfyN
         6bKLPclYQOc9/91aiRoxJQiDEOoA9hcLvYYgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZR3dSpwHeHS8JNLbewKBD8mo1RLBu0PiM26k3ABT1to=;
        b=dhESVRJz7/JXuZm712nifui+0kGyRelCdX7HzKj7v+XHKFwSjs0FO6v68cveYZwHe4
         MOiGtgJ8x4T6AR8nIwyqMweDZ0pT3ZxTBZ03ANSMZcrvTnG3pOFdzqJju79Ygbm4KV0q
         LQO01nNRlhdxviYshX332FdwfILHUeJVsAGmPEFrKJqzwKalLHViwU8azJ+ql/0FX8UQ
         +31lrE1GTW7gTjwGOjHXy67avSq9uX+QTJqPDEVdQGAASsf3d4KCt5TON14wtdCJ/Lki
         stxezmZ/GGegrlD2Mi9N0ZLQ0T40ARERJnpAGnvj5dl7Y4JqJhlt3z4YPFNCRePNRjGK
         e+UA==
X-Gm-Message-State: AGRZ1gK0Bg8NxpYAsvmqEfHFHiHsjyL5ryMSAvf7pNKUFq/975aIMEtz
        a4Ky6UVVkdIC86dqF/Di70KJgQ==
X-Google-Smtp-Source: AJdET5fKQ3HCIi5v6GOsjX4+UDMBFjLz4X+OpLlpId30Lkk2XSVq3vXsosiahzWutfEfWp6PHYQ5qA==
X-Received: by 2002:a17:902:7282:: with SMTP id d2-v6mr22824433pll.272.1541452185891;
        Mon, 05 Nov 2018 13:09:45 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id l26-v6sm79437452pfg.161.2018.11.05.13.09.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 13:09:45 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: qcom: Add SoC-specific string for sdhci-msm-v4 nodes
Date:   Mon,  5 Nov 2018 13:09:20 -0800
Message-Id: <20181105210921.253707-1-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
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

 arch/arm/boot/dts/qcom-apq8084.dtsi | 4 ++--
 arch/arm/boot/dts/qcom-msm8974.dtsi | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index 0e1e98707e3f..899f28533ed7 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -412,7 +412,7 @@
 		};
 
 		sdhci@f9824900 {
-			compatible = "qcom,sdhci-msm-v4";
+			compatible = "qcom,apq8084-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf9824900 0x11c>, <0xf9824000 0x800>;
 			reg-names = "hc_mem", "core_mem";
 			interrupts = <0 123 0>, <0 138 0>;
@@ -425,7 +425,7 @@
 		};
 
 		sdhci@f98a4900 {
-			compatible = "qcom,sdhci-msm-v4";
+			compatible = "qcom,apq8084-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
 			reg-names = "hc_mem", "core_mem";
 			interrupts = <0 125 0>, <0 221 0>;
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index aba159d5a95a..891990c0d0b4 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -602,7 +602,7 @@
 		};
 
 		sdhci@f9824900 {
-			compatible = "qcom,sdhci-msm-v4";
+			compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf9824900 0x11c>, <0xf9824000 0x800>;
 			reg-names = "hc_mem", "core_mem";
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
@@ -616,7 +616,7 @@
 		};
 
 		sdhci@f9864900 {
-			compatible = "qcom,sdhci-msm-v4";
+			compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf9864900 0x11c>, <0xf9864000 0x800>;
 			reg-names = "hc_mem", "core_mem";
 			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
@@ -630,7 +630,7 @@
 		};
 
 		sdhci@f98a4900 {
-			compatible = "qcom,sdhci-msm-v4";
+			compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
 			reg-names = "hc_mem", "core_mem";
 			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.19.1.930.g4563a0d9d0-goog

