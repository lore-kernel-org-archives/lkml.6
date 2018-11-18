Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755E6C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 20:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3373E2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 20:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oug6tt10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3373E2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeKSGZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 01:25:23 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44878 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbeKSGZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 01:25:22 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so1315714pfh.11
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 12:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R2gtFL+tazC/3nupXc+CmURI4UlAP9IGf+TTkfvt1a4=;
        b=Oug6tt100MQJmQeWFqEts3wIZUX8vdYNDTAs+JhOjMQ3lktJU0A8+1X8H07j9nJxxr
         9V/7g7ToZ7MlEP/E9pxCe/C8WRFET+6BZy5BfviT/1r9vlC/CBkdZxNzPMjohUvaKk2g
         W7DxJIY/LX1UyA1ecPTOssMfjhNyCu+sRFPf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R2gtFL+tazC/3nupXc+CmURI4UlAP9IGf+TTkfvt1a4=;
        b=S5Dosq0iZySWkj4lA94iilxjKySvTUmQPK1HZU1cgVaMgWdqGGrTWrmNx8Uqme6QDr
         5Xxne2Ti4tLQCCEtAD9WY4uydvAXsz3NsTGDD0GBtxBCVJWhumeeeuk5fXcDKW4PCwgf
         A7rzNJgVkK55BcC5HAXHz1xLPDISvHTgRtiVQ+2KLd/X2bTA4ZuEk/pwBXF8fB8omrmx
         TmAs963qXZ1XJDuhdmtUgEEqxRHCxHjakWysD7j1mBFt1F8QR1/+PAuth6SRo5e+0wNB
         O14v5/bWzphsDodKEDMKsJf9TeHsPYrdLeJctkA/Dzf/weGV140LEvT0g1pArGCm/wsG
         3RuQ==
X-Gm-Message-State: AGRZ1gJPcDXxNMTDQZoepLaVpWNKYkJLf0UJaLPfgdDMm+tsfgjnPpfS
        tAZw+AOXh2ekR32XATLqKCiP7g==
X-Google-Smtp-Source: AJdET5d1txVoyRS4oZfO+Yr1M2fukGf45s04xFmUZakHIBARIQHR6TD2ln8oxnhV2Tp3cV2uPGL25g==
X-Received: by 2002:a63:2109:: with SMTP id h9mr17346018pgh.277.1542571448857;
        Sun, 18 Nov 2018 12:04:08 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p15-v6sm64102434pfj.72.2018.11.18.12.04.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 12:04:08 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: qcom: qcs404: Add QUP I2C and SPI nodes
Date:   Sun, 18 Nov 2018 12:01:35 -0800
Message-Id: <20181118200135.25258-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181118200135.25258-1-bjorn.andersson@linaro.org>
References: <20181118200135.25258-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define all six QUP controllers, both as SPI and I2C, allowing boards to
enable these as needed. Associated pinmux states are also defined, to
require only pinconf states to be specified by the boards, as they are
enabled.

Note that SPI has not been tested.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 235 +++++++++++++++++++++++++++
 1 file changed, 235 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index ca00987d6400..9d78183cbdd8 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -273,6 +273,38 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 
+			blsp1_i2c0_default: blsp1-i2c0-default {
+				pins = "gpio32", "gpio33";
+				function = "blsp_i2c0";
+			};
+
+			blsp1_i2c1_default: blsp1-i2c1-default {
+				pins = "gpio24", "gpio25";
+				function = "blsp_i2c1";
+			};
+
+			blsp1_i2c2_default: blsp1-i2c2-default {
+				sda {
+					pins = "gpio19";
+					function = "blsp_i2c_sda_a2";
+				};
+
+				scl {
+					pins = "gpio20";
+					function = "blsp_i2c_scl_a2";
+				};
+			};
+
+			blsp1_i2c3_default: blsp1-i2c3-default {
+				pins = "gpio84", "gpio85";
+				function = "blsp_i2c3";
+			};
+
+			blsp1_i2c4_default: blsp1-i2c4-default {
+				pins = "gpio117", "gpio118";
+				function = "blsp_i2c4";
+			};
+
 			blsp1_uart0_default: blsp1-uart0-default {
 				pins = "gpio30", "gpio31", "gpio32", "gpio33";
 				function = "blsp_uart0";
@@ -300,6 +332,41 @@
 				function = "blsp_uart3";
 			};
 
+			blsp2_i2c0_default: blsp2-i2c0-default {
+				pins = "gpio28", "gpio29";
+				function = "blsp_i2c5";
+			};
+
+			blsp1_spi0_default: blsp1-spi0-default {
+				pins = "gpio30", "gpio31", "gpio32", "gpio33";
+				function = "blsp_spi0";
+			};
+
+			blsp1_spi1_default: blsp1-spi1-default {
+				pins = "gpio22", "gpio23", "gpio24", "gpio25";
+				function = "blsp_spi1";
+			};
+
+			blsp1_spi2_default: blsp1-spi2-default {
+				pins = "gpio17", "gpio18", "gpio19", "gpio20";
+				function = "blsp_spi2";
+			};
+
+			blsp1_spi3_default: blsp1-spi3-default {
+				pins = "gpio82", "gpio83", "gpio84", "gpio85";
+				function = "blsp_spi3";
+			};
+
+			blsp1_spi4_default: blsp1-spi4-default {
+				pins = "gpio37", "gpio38", "gpio117", "gpio118";
+				function = "blsp_spi4";
+			};
+
+			blsp2_spi0_default: blsp2-spi0-default {
+				pins = "gpio26", "gpio27", "gpio28", "gpio29";
+				function = "blsp_spi5";
+			};
+
 			blsp2_uart0_default: blsp2-uart0-default {
 				pins = "gpio26", "gpio27", "gpio28", "gpio29";
 				function = "blsp_uart5";
@@ -419,6 +486,146 @@
 			status = "disabled";
 		};
 
+		blsp1_i2c0: i2c@78b5000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x078b5000 0x600>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
+				 <&gcc GCC_BLSP1_QUP0_I2C_APPS_CLK>;
+			clock-names = "iface", "core";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_i2c0_default>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp1_spi0: spi@78b5000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x078b5000 0x600>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
+				 <&gcc GCC_BLSP1_QUP0_SPI_APPS_CLK>;
+			clock-names = "iface", "core";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_spi0_default>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp1_i2c1: i2c@78b6000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x078b6000 0x600>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
+				 <&gcc GCC_BLSP1_QUP1_I2C_APPS_CLK>;
+			clock-names = "iface", "core";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_i2c1_default>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp1_spi1: spi@78b6000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x078b6000 0x600>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
+				 <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>;
+			clock-names = "iface", "core";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_spi1_default>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp1_i2c2: i2c@78b7000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x078b7000 0x600>;
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
+				 <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>;
+			clock-names = "iface", "core";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_i2c2_default>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp1_spi2: spi@78b7000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x078b7000 0x600>;
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
+				 <&gcc GCC_BLSP1_QUP2_SPI_APPS_CLK>;
+			clock-names = "iface", "core";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_spi2_default>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp1_i2c3: i2c@78b8000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x078b8000 0x600>;
+			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
+				 <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>;
+			clock-names = "iface", "core";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_i2c3_default>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp1_spi3: spi@78b8000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x078b8000 0x600>;
+			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
+				 <&gcc GCC_BLSP1_QUP3_SPI_APPS_CLK>;
+			clock-names = "iface", "core";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_spi3_default>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp1_i2c4: i2c@78b9000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x078b9000 0x600>;
+			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
+				 <&gcc GCC_BLSP1_QUP4_I2C_APPS_CLK>;
+			clock-names = "iface", "core";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_i2c4_default>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp1_spi4: spi@78b9000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x078b9000 0x600>;
+			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
+				 <&gcc GCC_BLSP1_QUP4_SPI_APPS_CLK>;
+			clock-names = "iface", "core";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_spi4_default>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		blsp2_dma: dma@7ac4000 {
 			compatible = "qcom,bam-v1.7.0";
 			reg = <0x07ac4000 0x17000>;
@@ -444,6 +651,34 @@
 			status = "disabled";
 		};
 
+		blsp2_i2c0: i2c@7af5000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x07af5000 0x600>;
+			interrupts = <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_AHB_CLK>,
+				 <&gcc GCC_BLSP2_QUP0_I2C_APPS_CLK>;
+			clock-names = "iface", "core";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp2_i2c0_default>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp2_spi0: spi@7af5000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x07af5000 0x600>;
+			interrupts = <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_AHB_CLK>,
+				 <&gcc GCC_BLSP2_QUP0_SPI_APPS_CLK>;
+			clock-names = "iface", "core";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp2_spi0_default>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		intc: interrupt-controller@b000000 {
 			compatible = "qcom,msm-qgic2";
 			interrupt-controller;
-- 
2.18.0

