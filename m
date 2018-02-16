Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753234AbeBPGGC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 01:06:02 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49790 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753187AbeBPGFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 01:05:43 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7C0C06079C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From: Rajendra Nayak <rnayak@codeaurora.org>
To: andy.gross@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@codeaurora.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        dianders@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v4 4/4] arm64: dts: sdm845: Add serial console support
Date: Fri, 16 Feb 2018 11:35:03 +0530
Message-Id: <20180216060503.22006-5-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180216060503.22006-1-rnayak@codeaurora.org>
References: <20180216060503.22006-1-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the qup uart node and geni se instance needed to
support the serial console on the MTP.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 39 +++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi    | 39 +++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index 979ab49913f1..2a1ed55b703e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -12,4 +12,43 @@
 / {
 	model = "Qualcomm Technologies, Inc. SDM845 MTP";
 	compatible = "qcom,sdm845-mtp";
+
+	aliases {
+		serial0 = &qup_uart2;
+	};
+
+	chosen {
+		stdout-path = "serial0";
+	};
+};
+
+&soc {
+	geni-se@ac0000 {
+		serial@a84000 {
+			status = "okay";
+		};
+	};
+
+	pinctrl@3400000 {
+		qup-uart2-default {
+			pinconf_tx {
+				pins = "gpio4";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			pinconf_rx {
+				pins = "gpio5";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+		};
+
+		qup-uart2-sleep {
+			pinconf {
+				pins = "gpio4", "gpio5";
+				bias-pull-down;
+			};
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index c46e726af621..7b5c16eb63b7 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/qcom,gcc-sdm845.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -195,6 +196,20 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+
+			qup_uart2_default: qup-uart2-default {
+				pinmux {
+					function = "qup9";
+					pins = "gpio4", "gpio5";
+				};
+			};
+
+			qup_uart2_sleep: qup-uart2-sleep {
+				pinmux {
+					function = "gpio";
+					pins = "gpio4", "gpio5";
+				};
+			};
 		};
 
 		timer@17c90000 {
@@ -273,5 +288,29 @@
 			#interrupt-cells = <4>;
 			cell-index = <0>;
 		};
+
+		geni-se@ac0000 {
+			compatible = "qcom,geni-se-qup";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			reg = <0xac0000 0x6000>;
+			clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
+			clock-names = "m-ahb", "s-ahb";
+
+			qup_uart2: serial@a84000 {
+				compatible = "qcom,geni-debug-uart";
+				reg = <0xa84000 0x4000>;
+				reg-names = "se-phys";
+				clock-names = "se-clk";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
+				pinctrl-names = "default", "sleep";
+				pinctrl-0 = <&qup_uart2_default>;
+				pinctrl-1 = <&qup_uart2_sleep>;
+				interrupts = <GIC_SPI 354 IRQ_TYPE_NONE>;
+				status = "disabled";
+			};
+		};
 	};
 };
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
