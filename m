Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932325AbeAaQWH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 11:22:07 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:34140 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932283AbeAaQVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 11:21:48 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E191B607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From: Rajendra Nayak <rnayak@codeaurora.org>
To: andy.gross@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        sboyd@codeaurora.org, evgreen@chromium.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v2 3/3] arm64: dts: sdm845: Add serial console support
Date: Wed, 31 Jan 2018 21:49:41 +0530
Message-Id: <20180131161941.29865-4-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180131161941.29865-1-rnayak@codeaurora.org>
References: <20180131161941.29865-1-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the qup uart node and geni se instance needed to
support the serial console on the MTP.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 42 +++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi    | 21 +++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index 617c7bb25fb1..42fbf2ab9a2d 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -10,4 +10,46 @@
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
+
+	soc {
+		serial@a84000 {
+			status = "okay";
+		};
+
+		pinctrl@3400000 {
+			qup_uart2_default: qup_uart2_default {
+				pinmux {
+					function = "qup9";
+					pins = "gpio4", "gpio5";
+				};
+
+				pinconf {
+					pins = "gpio4", "gpio5";
+					drive-strength = <2>;
+					bias-disable;
+				};
+			};
+
+			qup_uart2_sleep: qup_uart2_sleep {
+				pinmux {
+					function = "gpio";
+					pins = "gpio4", "gpio5";
+				};
+
+				pinconf {
+					pins = "gpio4", "gpio5";
+					drive-strength = <2>;
+					bias-disable;
+				};
+			};
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 02520f19e4ca..c4ce70840acf 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/qcom,gcc-sdm845.h>
 
 / {
 	model = "Qualcomm Technologies, Inc. SDM845";
@@ -273,5 +274,25 @@
 			cell-index = <0>;
 		};
 
+		qup_1: qcom,geni_se@ac0000 {
+			compatible = "qcom,geni-se-qup";
+			reg = <0xac0000 0x6000>;
+		};
+
+		qup_uart2: serial@a84000 {
+			compatible = "qcom,geni-console", "qcom,geni-uart";
+			reg = <0xa84000 0x4000>;
+			reg-names = "se_phys";
+			clock-names = "se-clk", "m-ahb", "s-ahb";
+			clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&qup_uart2_default>;
+			pinctrl-1 = <&qup_uart2_sleep>;
+			interrupts = <GIC_SPI 354 IRQ_TYPE_NONE>;
+			qcom,wrapper-core = <&qup_1>;
+			status = "disabled";
+		};
 	};
 };
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
