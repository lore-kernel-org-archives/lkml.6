Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6C2C00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 00:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B582147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 00:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K4lxJbTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B582147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbeJDHPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 03:15:11 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36869 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbeJDHPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 03:15:11 -0400
Received: by mail-pl1-f196.google.com with SMTP id az3-v6so4249070plb.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 17:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QQGIWPBszOqmZhfnLvpO2e6Ux+Iq4m9GqjTHV1pp0Sw=;
        b=K4lxJbTpwoSLtyqrkQg6jctDP6E9oWWrtlGIlBoV76MEOYmZtwz2VWOFjvpp+OQPlV
         cwnAfwXablZDEACoelGcIHtjaPM8J4krsEx/ElS5HOoWTh4BQfR3INZyVwbpHXtOZLmo
         Q0aLfmv+SOEg3M1lkSEVbAgDLrz7Xd3GaJjrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QQGIWPBszOqmZhfnLvpO2e6Ux+Iq4m9GqjTHV1pp0Sw=;
        b=tPJXQUmcb4BAGt7ESUG8cw4f+/Ud1ZL9GHwDRV7a5A+Dj7y9GhxgQCvjvnurdHCD03
         8a11AqQtqlep28SqUdaoc++i2DKlZcbt673WQ4rZd1Sw4Vj2eJMhGkpK9XBZtRkJJmlm
         /o2ZtUHqEXlYD6dRV1nUrocYKjaSkAe2gSulzCTgjoI4AliY+xx0WSvQ+MMltq2jSmBd
         OvTZyZJvPITpz3pJ8Wt3yTAa9+7iPbVRdQv0p+5O/2Nh7sMwgAf62Ypx/6KHXedRS1/d
         +CTGpZLV0LwjhPSP9AoZL/umoXoafNvxuaW4hAGrGGICyzi3mFuORhUsvSMem+YHhY6y
         zcQg==
X-Gm-Message-State: ABuFfojdcmPQFoPFvgg9ttqQw3Aq1SIZDszC3xIN3DgexTynpAn90rTl
        eM+yqG4arde/BjFmbfVZKymJPA==
X-Google-Smtp-Source: ACcGV61BCCH8jINUzEx5gylGYgnNkp8hRgJwhGhowFbzgEjdbKGsoHLhTqIGrmtabRVFTORd1a7TQQ==
X-Received: by 2002:a17:902:4403:: with SMTP id k3-v6mr3965214pld.243.1538612669027;
        Wed, 03 Oct 2018 17:24:29 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id 23-v6sm5675399pfy.156.2018.10.03.17.24.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 17:24:28 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2] arm64: dts: qcom: sdm845: Add UART nodes
Date:   Wed,  3 Oct 2018 17:24:09 -0700
Message-Id: <20181004002409.39350-1-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds nodes for all possible UARTs to sdm845.dtsi. By default
only configure the RX/TX lines with pinctrl. Boards that use UARTs
with flow control can overwrite the configuration in the
<board>.dtsi.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v2:
- use GCC_QUPV3_WRAP1_Sx_CLK for uart8-15, not
  GCC_QUPV3_WRAP0_Sx_CLK
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 270 +++++++++++++++++++++++++++
 1 file changed, 270 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0c9a2aa6a1b5..c4056c2c3cc5 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -286,6 +286,17 @@
 				status = "disabled";
 			};
 
+			uart0: serial@880000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x880000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart0_default>;
+				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
 			i2c1: i2c@884000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0x884000 0x4000>;
@@ -312,6 +323,17 @@
 				status = "disabled";
 			};
 
+			uart1: serial@884000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x884000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart1_default>;
+				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
 			i2c2: i2c@888000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0x888000 0x4000>;
@@ -338,6 +360,17 @@
 				status = "disabled";
 			};
 
+			uart2: serial@888000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x888000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart2_default>;
+				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
 			i2c3: i2c@88c000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0x88c000 0x4000>;
@@ -364,6 +397,17 @@
 				status = "disabled";
 			};
 
+			uart3: serial@88c000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x88c000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart3_default>;
+				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
 			i2c4: i2c@890000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0x890000 0x4000>;
@@ -390,6 +434,17 @@
 				status = "disabled";
 			};
 
+			uart4: serial@890000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x890000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart4_default>;
+				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
 			i2c5: i2c@894000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0x894000 0x4000>;
@@ -416,6 +471,17 @@
 				status = "disabled";
 			};
 
+			uart5: serial@894000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x894000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart5_default>;
+				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
 			i2c6: i2c@898000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0x898000 0x4000>;
@@ -442,6 +508,17 @@
 				status = "disabled";
 			};
 
+			uart6: serial@898000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x898000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart6_default>;
+				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
 			i2c7: i2c@89c000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0x89c000 0x4000>;
@@ -467,6 +544,17 @@
 				#size-cells = <0>;
 				status = "disabled";
 			};
+
+			uart7: serial@89c000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x89c000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart7_default>;
+				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
 		};
 
 		qupv3_id_1: geniqup@ac0000 {
@@ -506,6 +594,17 @@
 				status = "disabled";
 			};
 
+			uart8: serial@a80000 {
+				compatible = "qcom,geni-uart";
+				reg = <0xa80000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart8_default>;
+				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
 			i2c9: i2c@a84000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0xa84000 0x4000>;
@@ -569,6 +668,17 @@
 				status = "disabled";
 			};
 
+			uart10: serial@a88000 {
+				compatible = "qcom,geni-uart";
+				reg = <0xa88000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart10_default>;
+				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
 			i2c11: i2c@a8c000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0xa8c000 0x4000>;
@@ -595,6 +705,17 @@
 				status = "disabled";
 			};
 
+			uart11: serial@a8c000 {
+				compatible = "qcom,geni-uart";
+				reg = <0xa8c000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart11_default>;
+				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
 			i2c12: i2c@a90000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0xa90000 0x4000>;
@@ -621,6 +742,17 @@
 				status = "disabled";
 			};
 
+			uart12: serial@a90000 {
+				compatible = "qcom,geni-uart";
+				reg = <0xa90000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart12_default>;
+				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
 			i2c13: i2c@a94000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0xa94000 0x4000>;
@@ -647,6 +779,17 @@
 				status = "disabled";
 			};
 
+			uart13: serial@a94000 {
+				compatible = "qcom,geni-uart";
+				reg = <0xa94000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart13_default>;
+				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
 			i2c14: i2c@a98000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0xa98000 0x4000>;
@@ -673,6 +816,17 @@
 				status = "disabled";
 			};
 
+			uart14: serial@a98000 {
+				compatible = "qcom,geni-uart";
+				reg = <0xa98000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S6_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart14_default>;
+				interrupts = <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
 			i2c15: i2c@a9c000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0xa9c000 0x4000>;
@@ -698,6 +852,17 @@
 				#size-cells = <0>;
 				status = "disabled";
 			};
+
+			uart15: serial@a9c000 {
+				compatible = "qcom,geni-uart";
+				reg = <0xa9c000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S7_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart15_default>;
+				interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
 		};
 
 		tcsr_mutex_regs: syscon@1f40000 {
@@ -954,12 +1119,117 @@
 				};
 			};
 
+			qup_uart0_default: qup-uart0-default {
+				pinmux {
+					pins = "gpio2", "gpio3";
+					function = "qup0";
+				};
+			};
+
+			qup_uart1_default: qup-uart1-default {
+				pinmux {
+					pins = "gpio19", "gpio20";
+					function = "qup1";
+				};
+			};
+
+			qup_uart2_default: qup-uart2-default {
+				pinmux {
+					pins = "gpio29", "gpio30";
+					function = "qup2";
+				};
+			};
+
+			qup_uart3_default: qup-uart3-default {
+				pinmux {
+					pins = "gpio43", "gpio44";
+					function = "qup3";
+				};
+			};
+
+			qup_uart4_default: qup-uart4-default {
+				pinmux {
+					pins = "gpio91", "gpio92";
+					function = "qup4";
+				};
+			};
+
+			qup_uart5_default: qup-uart5-default {
+				pinmux {
+					pins = "gpio87", "gpio88";
+					function = "qup5";
+				};
+			};
+
+			qup_uart6_default: qup-uart6-default {
+				pinmux {
+					pins = "gpio47", "gpio48";
+					function = "qup6";
+				};
+			};
+
+			qup_uart7_default: qup-uart7-default {
+				pinmux {
+					pins = "gpio95", "gpio96";
+					function = "qup7";
+				};
+			};
+
+			qup_uart8_default: qup-uart8-default {
+				pinmux {
+					pins = "gpio67", "gpio68";
+					function = "qup8";
+				};
+			};
+
 			qup_uart9_default: qup-uart9-default {
 				pinmux {
 					pins = "gpio4", "gpio5";
 					function = "qup9";
 				};
 			};
+
+			qup_uart10_default: qup-uart10-default {
+				pinmux {
+					pins = "gpio53", "gpio54";
+					function = "qup10";
+				};
+			};
+
+			qup_uart11_default: qup-uart11-default {
+				pinmux {
+					pins = "gpio33", "gpio34";
+					function = "qup11";
+				};
+			};
+
+			qup_uart12_default: qup-uart12-default {
+				pinmux {
+					pins = "gpio51", "gpio52";
+					function = "qup12";
+				};
+			};
+
+			qup_uart13_default: qup-uart13-default {
+				pinmux {
+					pins = "gpio107", "gpio108";
+					function = "qup13";
+				};
+			};
+
+			qup_uart14_default: qup-uart14-default {
+				pinmux {
+					pins = "gpio31", "gpio32";
+					function = "qup14";
+				};
+			};
+
+			qup_uart15_default: qup-uart15-default {
+				pinmux {
+					pins = "gpio83", "gpio84";
+					function = "qup15";
+				};
+			};
 		};
 
 		tsens0: thermal-sensor@c263000 {
-- 
2.19.0.605.g01d371f741-goog

