Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58CFC04ABB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 05:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C47C20869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 05:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zd8nwick"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C47C20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeIGKNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 06:13:40 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38494 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbeIGKNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 06:13:40 -0400
Received: by mail-pl1-f195.google.com with SMTP id u11-v6so6056989plq.5;
        Thu, 06 Sep 2018 22:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OrrybhJIPYjPh16l8ZZ98Z8C2HQKxxZ4xhp8lof9aNs=;
        b=Zd8nwickrN1JZ8yGytlxU1A9uhts+lUbUPCB8pdiDnD9rymfqS4IcvUu55U24Qq1mR
         iFM22skxSp2XPvvFslD+Zh9ZkBUAtLIoobPb5n4pnHCa4Ph1ZLbAJIUQ4lW7yon7h61F
         4ij6yP/GgYAFeVeoSGxwoj3wDDU7M+JifiZgbowyIgVivWtJ94+4t2QyDAIAa2o1TslK
         +SlMrQ81AYJJuI2IvFy8dD48q1oj9X93I7TrZdUwgKkpEe030nIuvp2PycUWNVEvrULh
         TLrcQjo3cUkk3/j9qVjSeL0dJSUzlG6c8x17vXtEmogflryec//AASLFYPG/y2eRRq73
         i5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OrrybhJIPYjPh16l8ZZ98Z8C2HQKxxZ4xhp8lof9aNs=;
        b=nXeFGdhkZdHE2QIGc4XLxB+9JxwvaxzZLto/e9RVW54HwWH21WzHmmJY6GhTMJBVwo
         c/AJ52ntPrjNrs+H/ydes8GAhxqi+2781EvsVaocdJhdmbszK+WdPwLwr7B1ZA2uVdFV
         s5t6iEyyBKw1+ZRWkHdRHEgL03NyiyCWrn0sKpnz5AsqkP6QW8jF1Dqgb8GyRrxi/rQK
         0VE43d3ZlRNa7+Y+mldN+KEPmoqb6S9jgHFOkHJJ9JffCrDIW60+qKctGZM0aNFyqO9d
         C6MUPp+KJYo1WDUOKUNor4Ch0TaZq/CCDiuoZLQUYXjrBAeF3oOWRbEtx0FMxthEcQSw
         5rtg==
X-Gm-Message-State: APzg51CEB9YCHljmiUM0Pg5c7LuYNR/VOZ6Lm5YFNTlbBtEvQDQDLL5j
        CDBaN2nb0P5ENsHegAKrmSA=
X-Google-Smtp-Source: ANB0VdZO7/4aeukT1MFxk9ZL8BBrjaOODv3jZ546gpgICAbJvxRkJzwkvyavHqmPtExFYMjlY7pWxw==
X-Received: by 2002:a17:902:1681:: with SMTP id h1-v6mr6152572plh.226.1536298465554;
        Thu, 06 Sep 2018 22:34:25 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id b203-v6sm9291581pfb.174.2018.09.06.22.34.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Sep 2018 22:34:24 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Arun Kumar Neelakantam <aneela@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/6] ARM: dts: qcom-msm8974: use named constant for interrupt type GIC_SPI
Date:   Thu,  6 Sep 2018 22:33:10 -0700
Message-Id: <1536298394-5548-3-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1536298394-5548-1-git-send-email-frowand.list@gmail.com>
References: <1536298394-5548-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Cosmetic change of integer value "0" in the first field of the
"interrupts" property to the correct named constant.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 56 +++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index f4f5e2df4c03..c09cc1232a6f 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -243,7 +243,7 @@
 	adsp-pil {
 		compatible = "qcom,msm8974-adsp-pil";
 
-		interrupts-extended = <&intc 0 162 IRQ_TYPE_EDGE_RISING>,
+		interrupts-extended = <&intc GIC_SPI 162 IRQ_TYPE_EDGE_RISING>,
 				      <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
 				      <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
 				      <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
@@ -275,7 +275,7 @@
 		qcom,smem = <443>, <429>;
 
 		interrupt-parent = <&intc>;
-		interrupts = <0 158 IRQ_TYPE_EDGE_RISING>;
+		interrupts = <GIC_SPI 158 IRQ_TYPE_EDGE_RISING>;
 
 		qcom,ipc = <&apcs 8 10>;
 
@@ -300,7 +300,7 @@
 		qcom,smem = <435>, <428>;
 
 		interrupt-parent = <&intc>;
-		interrupts = <0 27 IRQ_TYPE_EDGE_RISING>;
+		interrupts = <GIC_SPI 27 IRQ_TYPE_EDGE_RISING>;
 
 		qcom,ipc = <&apcs 8 14>;
 
@@ -325,7 +325,7 @@
 		qcom,smem = <451>, <431>;
 
 		interrupt-parent = <&intc>;
-		interrupts = <0 143 IRQ_TYPE_EDGE_RISING>;
+		interrupts = <GIC_SPI 143 IRQ_TYPE_EDGE_RISING>;
 
 		qcom,ipc = <&apcs 8 18>;
 
@@ -364,7 +364,7 @@
 
 		modem_smsm: modem@1 {
 			reg = <1>;
-			interrupts = <0 26 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
 
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -372,7 +372,7 @@
 
 		adsp_smsm: adsp@2 {
 			reg = <2>;
-			interrupts = <0 157 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <GIC_SPI 157 IRQ_TYPE_EDGE_RISING>;
 
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -380,7 +380,7 @@
 
 		wcnss_smsm: wcnss@7 {
 			reg = <7>;
-			interrupts = <0 144 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <GIC_SPI 144 IRQ_TYPE_EDGE_RISING>;
 
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -445,50 +445,50 @@
 
 			frame@f9021000 {
 				frame-number = <0>;
-				interrupts = <0 8 0x4>,
-					     <0 7 0x4>;
+				interrupts = <GIC_SPI 8 0x4>,
+					     <GIC_SPI 7 0x4>;
 				reg = <0xf9021000 0x1000>,
 				      <0xf9022000 0x1000>;
 			};
 
 			frame@f9023000 {
 				frame-number = <1>;
-				interrupts = <0 9 0x4>;
+				interrupts = <GIC_SPI 9 0x4>;
 				reg = <0xf9023000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@f9024000 {
 				frame-number = <2>;
-				interrupts = <0 10 0x4>;
+				interrupts = <GIC_SPI 10 0x4>;
 				reg = <0xf9024000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@f9025000 {
 				frame-number = <3>;
-				interrupts = <0 11 0x4>;
+				interrupts = <GIC_SPI 11 0x4>;
 				reg = <0xf9025000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@f9026000 {
 				frame-number = <4>;
-				interrupts = <0 12 0x4>;
+				interrupts = <GIC_SPI 12 0x4>;
 				reg = <0xf9026000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@f9027000 {
 				frame-number = <5>;
-				interrupts = <0 13 0x4>;
+				interrupts = <GIC_SPI 13 0x4>;
 				reg = <0xf9027000 0x1000>;
 				status = "disabled";
 			};
 
 			frame@f9028000 {
 				frame-number = <6>;
-				interrupts = <0 14 0x4>;
+				interrupts = <GIC_SPI 14 0x4>;
 				reg = <0xf9028000 0x1000>;
 				status = "disabled";
 			};
@@ -586,7 +586,7 @@
 		blsp1_uart1: serial@f991d000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0xf991d000 0x1000>;
-			interrupts = <0 107 0x0>;
+			interrupts = <GIC_SPI 107 0x0>;
 			clocks = <&gcc GCC_BLSP1_UART1_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
 			status = "disabled";
@@ -595,7 +595,7 @@
 		blsp1_uart2: serial@f991e000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0xf991e000 0x1000>;
-			interrupts = <0 108 0x0>;
+			interrupts = <GIC_SPI 108 0x0>;
 			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
 			status = "disabled";
@@ -605,7 +605,8 @@
 			compatible = "qcom,sdhci-msm-v4";
 			reg = <0xf9824900 0x11c>, <0xf9824000 0x800>;
 			reg-names = "hc_mem", "core_mem";
-			interrupts = <0 123 0>, <0 138 0>;
+			interrupts = <GIC_SPI 123 0>,
+				     <GIC_SPI 138 0>;
 			interrupt-names = "hc_irq", "pwr_irq";
 			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
 				 <&gcc GCC_SDCC1_AHB_CLK>,
@@ -632,7 +633,8 @@
 			compatible = "qcom,sdhci-msm-v4";
 			reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
 			reg-names = "hc_mem", "core_mem";
-			interrupts = <0 125 0>, <0 221 0>;
+			interrupts = <GIC_SPI 125 0>,
+				     <GIC_SPI 221 0>;
 			interrupt-names = "hc_irq", "pwr_irq";
 			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
 				 <&gcc GCC_SDCC2_AHB_CLK>,
@@ -699,14 +701,14 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
-			interrupts = <0 208 0>;
+			interrupts = <GIC_SPI 208 0>;
 		};
 
 		i2c@f9924000 {
 			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
 			reg = <0xf9924000 0x1000>;
-			interrupts = <0 96 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_NONE>;
 			clocks = <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
 			#address-cells = <1>;
@@ -717,7 +719,7 @@
 			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
 			reg = <0xf9964000 0x1000>;
-			interrupts = <0 102 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 102 IRQ_TYPE_NONE>;
 			clocks = <&gcc GCC_BLSP2_QUP2_I2C_APPS_CLK>, <&gcc GCC_BLSP2_AHB_CLK>;
 			clock-names = "core", "iface";
 			#address-cells = <1>;
@@ -728,7 +730,7 @@
 			status = "disabled";
 			compatible = "qcom,i2c-qup-v2.1.1";
 			reg = <0xf9967000 0x1000>;
-			interrupts = <0 105 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 105 IRQ_TYPE_NONE>;
 			clocks = <&gcc GCC_BLSP2_QUP5_I2C_APPS_CLK>, <&gcc GCC_BLSP2_AHB_CLK>;
 			clock-names = "core", "iface";
 			#address-cells = <1>;
@@ -744,7 +746,7 @@
 			      <0xfc4cb000 0x1000>,
 			      <0xfc4ca000 0x1000>;
 			interrupt-names = "periph_irq";
-			interrupts = <0 190 0>;
+			interrupts = <GIC_SPI 190 0>;
 			qcom,ee = <0>;
 			qcom,channel = <0>;
 			#address-cells = <2>;
@@ -1040,21 +1042,21 @@
 		compatible = "qcom,smd";
 
 		adsp {
-			interrupts = <0 156 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
 
 			qcom,ipc = <&apcs 8 8>;
 			qcom,smd-edge = <1>;
 		};
 
 		modem {
-			interrupts = <0 25 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>;
 
 			qcom,ipc = <&apcs 8 12>;
 			qcom,smd-edge = <0>;
 		};
 
 		rpm {
-			interrupts = <0 168 1>;
+			interrupts = <GIC_SPI 168 1>;
 			qcom,ipc = <&apcs 8 0>;
 			qcom,smd-edge = <15>;
 
-- 
Frank Rowand <frank.rowand@sony.com>

