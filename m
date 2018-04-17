Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753826AbeDQN4y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:56:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36034 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753099AbeDQN4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:56:52 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B85F960385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=yossim@codeaurora.org
From: Yossi Mansharoff <yossim@codeaurora.org>
To: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-soc@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)),
        linux-kernel@vger.kernel.org (open list)
Cc: swboyd@chromium.org, Yossi Mansharoff <yossim@codeaurora.org>,
        Stephen Boyd <stephen.boyd@linaro.org>
Subject: [PATCH v2] arm64: dts: qcom: Collapse usb support into one node
Date: Tue, 17 Apr 2018 16:56:30 +0300
Message-Id: <1523973390-2387-1-git-send-email-yossim@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently have three device nodes for the same USB hardware
block, as evident by the reuse of the same reg address multiple
times. Now that the chipidea driver fully supports OTG with the
MSM wrapper we can collapse all these nodes into one USB device
node, reflecting the true nature of the hardware.

Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 9ff8487..1505921 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -18,6 +18,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/sound/apq8016-lpass.h>
+#include <dt-bindings/mux/mux.h>
 
 /*
  * GPIO name legend: proper name = the GPIO line is used as GPIO
@@ -371,18 +372,18 @@
 			adp-disable;
 			hnp-disable;
 			srp-disable;
-			dr_mode = "host";
-			pinctrl-names = "default";
-			pinctrl-0 = <&usb_sw_sel_pm>;
+			mux-controls = <&usb_switch>;
+			mux-control-names = "usb_switch";
+
 			ulpi {
 				phy {
 					v1p8-supply = <&pm8916_l7>;
 					v3p3-supply = <&pm8916_l13>;
-					extcon = <&usb_id>;
 				};
 			};
 		};
 
+
 		lpass@7708000 {
 			status = "okay";
 		};
@@ -512,11 +513,17 @@
 
 	usb_id: usb-id {
 		compatible = "linux,extcon-usb-gpio";
-		vbus-gpio = <&msmgpio 121 GPIO_ACTIVE_HIGH>;
+		id-gpio = <&msmgpio 121 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&usb_id_default>;
 	};
 
+	usb_switch: usb-switch {
+		compatible = "gpio-mux";
+		mux-gpios = <&pm8916_gpios 4 GPIO_ACTIVE_HIGH>;
+		#mux-control-cells = <0>;
+	};
+
 	hdmi-out {
 		compatible = "hdmi-connector";
 		type = "a";
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
