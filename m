Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15DDC46465
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A062086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z0J5bk+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A062086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387792AbeKHDUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:20:37 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43712 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731591AbeKHDUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 22:20:36 -0500
Received: by mail-pl1-f194.google.com with SMTP id g59-v6so8179229plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 09:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZvL9JXPkSCEpU6IxoDs/WZI6AFU5ENywXz2f9GrqSf8=;
        b=Z0J5bk+eoNem0AnNMuMANJe512cbFAU49tWAMroki8xfL7uSXXzcffXoFDzh7kMcgE
         mLlsioDz9P2drBo7TPvY4l6U8x11NoT6CR+Uy1wRDot8pw4yS4glvTqbtbEqNTMMKTA4
         gSAYVS2q9dsA0MW8Fr7b8ST2aJs23i94Exbx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZvL9JXPkSCEpU6IxoDs/WZI6AFU5ENywXz2f9GrqSf8=;
        b=RGUOhYPpX+74EqBBjh+IMroDSZcAXB488thbbggg+jVTDBltaBvVMKCu2PWz7KQHka
         CuMfUgJHQgb5NLm3SpydCOZEtixH0aFq1WeHltqi5v89Qc6EZac4gxxQH0BaXi9pafK8
         vsrKL0OeEWSRZt56BP+hYB4rkRORG0FRqgqDLvpUqx29rlIrURGCDVkjhtd1lc/HEnbG
         bdmrgVR+5okmymFePoJ6FkgRHZIbumpV/AEXY6E84ukHGsK1KxDshSuvnxkyb82dRyfU
         M/f6G6sdaoQQDLLxtAbngBjgeuD/19qdjwiQ8Em+VkhPdqMJ1X9lFWIUjpJNvQw8zaZa
         ga/A==
X-Gm-Message-State: AGRZ1gIoFYH2lAqJXZuIijwZON4Z3oaA7AT8cbzl8yDjhycmgiNcFAoD
        d7heVTH6EoCm6vCQPwM4Fj2N
X-Google-Smtp-Source: AJdET5ePTGKWfoOvu4C1Fs7jjqbYnGGWQHfIzbxUiWhQ644TZ+6TO54YVoeUk5RC8eIoKmqPryN8Jg==
X-Received: by 2002:a17:902:f097:: with SMTP id go23mr1119856plb.328.1541612949727;
        Wed, 07 Nov 2018 09:49:09 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6282:6ca8:a0d9:6a81:97fe:992e])
        by smtp.gmail.com with ESMTPSA id e70-v6sm1232645pfb.113.2018.11.07.09.49.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 09:49:09 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sean.wang@kernel.org, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, amit.kucheria@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 2/4] arm64: dts: mediatek: mt6797: Add pinctrl support
Date:   Wed,  7 Nov 2018 23:18:42 +0530
Message-Id: <20181107174844.5381-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181107174844.5381-1-manivannan.sadhasivam@linaro.org>
References: <20181107174844.5381-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl support for Mediatek MT6797 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/mediatek/mt6797.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6797.dtsi b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
index 4beaa71107d7..231230d32d09 100644
--- a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/clock/mt6797-clk.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/pinctrl/mt6797-pinfunc.h>
 
 / {
 	compatible = "mediatek,mt6797";
@@ -129,6 +130,19 @@
 		#clock-cells = <1>;
 	};
 
+	pio: pinctrl@10005000 {
+		compatible = "mediatek,mt6797-pinctrl";
+		reg = <0 0x10005000 0 0x1000>,
+		      <0 0x10002000 0 0x400>,
+		      <0 0x10002400 0 0x400>,
+		      <0 0x10002800 0 0x400>,
+		      <0 0x10002C00 0 0x400>;
+		reg-names = "gpio", "iocfgl", "iocfgb",
+			    "iocfgr", "iocfgt";
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	scpsys: scpsys@10006000 {
 		compatible = "mediatek,mt6797-scpsys";
 		#power-domain-cells = <1>;
-- 
2.17.1

