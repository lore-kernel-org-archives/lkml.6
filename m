Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12068C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 20:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA36D2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 20:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ivI2DIgF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA36D2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeKSGZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 01:25:22 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44877 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbeKSGZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 01:25:21 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so1315702pfh.11
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 12:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hdFjveG7Hbif97xCDVfIVa5NxJUPIWCTnkSToZ6FZ8c=;
        b=ivI2DIgFMyNyKpW7lPPsw7vVfS4NVtmjj99amQ6ukh9mI2guCJ9LaMON/76JbIeMdG
         lYT6YSKb6a9vtkZdiVmLJB1Qij7UqhdwbfjEPUtmXEOh8hDSe8VJDBLbdoSLUKwzaBKD
         lwwGX44Pxbz+3QrcIc20Yy7QeqVFi0XtLbvII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hdFjveG7Hbif97xCDVfIVa5NxJUPIWCTnkSToZ6FZ8c=;
        b=LjjCevLOrrGPqyI3JJxP27MhhRe4mW6dmsJNo/XAbRR1Z2+P4rxCPTjzv4V1v4oOTJ
         plckqOtKRHtjZff920AJGh1Ohz0iOJ0bM1wdIrRfL0fSx++2Cbq4RnylloUG3+SACtGi
         qzWcE6GsdB+al1h6FCEYARTEDWj11C4qOirt2vLEyn9AQBHuVT8YrPyX1NStKGJknuF2
         De/WBdQoSIwaVtFvhsAUEA6yLJCMYSf8XXVBp5Kva4NkabQ7a7jLxnXK9TM/9TcwahAE
         1FL6xkLRaE3wdzpHISCgwifJqF9ZxJB1G2cKTA03YL13CpzkoQ6W6/a7EPRx985auzv+
         4IBA==
X-Gm-Message-State: AGRZ1gIRPLQ5B/D8bvmxmj28a8VtGaNXachDoecEELJfpniIONXHKt8N
        ulacCbEPybDx7rZ0RYCWc8TvGw==
X-Google-Smtp-Source: AJdET5ekRSztE8vk6dqfFzfWA8kZZB8jPvu+4FHb83PQldQQ7dvvQn/2wB5QfnwwuuFw0uKEFqU03Q==
X-Received: by 2002:a65:57cb:: with SMTP id q11mr17604579pgr.60.1542571447544;
        Sun, 18 Nov 2018 12:04:07 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p15-v6sm64102434pfj.72.2018.11.18.12.04.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 12:04:06 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: qcom: qcs404: Define remaining UARTs
Date:   Sun, 18 Nov 2018 12:01:34 -0800
Message-Id: <20181118200135.25258-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181118200135.25258-1-bjorn.andersson@linaro.org>
References: <20181118200135.25258-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the BLSP2 BAM and add the remaining four UARTs found on the QCS404
platform.

Note that these has not been tested.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 84 ++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 9ec5c85fcb81..ca00987d6400 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -273,6 +273,16 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 
+			blsp1_uart0_default: blsp1-uart0-default {
+				pins = "gpio30", "gpio31", "gpio32", "gpio33";
+				function = "blsp_uart0";
+			};
+
+			blsp1_uart1_default: blsp1-uart1-default {
+				pins = "gpio22", "gpio23";
+				function = "blsp_uart1";
+			};
+
 			blsp1_uart2_default: blsp1-uart2-default {
 				rx {
 					pins = "gpio18";
@@ -284,6 +294,16 @@
 					function = "blsp_uart_tx_a2";
 				};
 			};
+
+			blsp1_uart3_default: blsp1-uart3-default {
+				pins = "gpio82", "gpio83", "gpio84", "gpio85";
+				function = "blsp_uart3";
+			};
+
+			blsp2_uart0_default: blsp2-uart0-default {
+				pins = "gpio26", "gpio27", "gpio28", "gpio29";
+				function = "blsp_uart5";
+			};
 		};
 
 		gcc: clock-controller@1800000 {
@@ -347,6 +367,32 @@
 			status = "okay";
 		};
 
+		blsp1_uart0: serial@78af000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x078af000 0x200>;
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART0_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp1_dma 1>, <&blsp1_dma 0>;
+			dma-names = "rx", "tx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_uart0_default>;
+			status = "disabled";
+		};
+
+		blsp1_uart1: serial@78b0000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x078b0000 0x200>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART1_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp1_dma 3>, <&blsp1_dma 2>;
+			dma-names = "rx", "tx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_uart1_default>;
+			status = "disabled";
+		};
+
 		blsp1_uart2: serial@78b1000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0x078b1000 0x200>;
@@ -360,6 +406,44 @@
 			status = "okay";
 		};
 
+		blsp1_uart3: serial@78b2000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x078b2000 0x200>;
+			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART3_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp1_dma 7>, <&blsp1_dma 6>;
+			dma-names = "rx", "tx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_uart3_default>;
+			status = "disabled";
+		};
+
+		blsp2_dma: dma@7ac4000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0x07ac4000 0x17000>;
+			interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,controlled-remotely = <1>;
+			qcom,ee = <0>;
+			status = "disabled";
+		};
+
+		blsp2_uart0: serial@7aef000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x07aef000 0x200>;
+			interrupts = <GIC_SPI 297 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_UART0_APPS_CLK>, <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp2_dma 1>, <&blsp2_dma 0>;
+			dma-names = "rx", "tx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp2_uart0_default>;
+			status = "disabled";
+		};
+
 		intc: interrupt-controller@b000000 {
 			compatible = "qcom,msm-qgic2";
 			interrupt-controller;
-- 
2.18.0

