Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbeCTJbK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 05:31:10 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:56132 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbeCTJbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 05:31:06 -0400
X-Google-Smtp-Source: AG47ELv7SlCf2VCiDcGp3XS3QchgrIqU83usuysdsIYbxnAVbGQCC/fuwIbsccUOoYoK0Wvs/a3/sQ==
From: srinivas.kandagatla@linaro.org
To: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org
Cc: david.brown@linaro.org, robh+dt@kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ARM: dts: db600c: add support to pcie refclk
Date: Tue, 20 Mar 2018 09:28:40 +0000
Message-Id: <20180320092840.4600-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to external pcie refclk.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-db600c.dts | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-db600c.dts b/arch/arm/boot/dts/qcom-apq8064-db600c.dts
index 50151ef6e912..7587088c122f 100644
--- a/arch/arm/boot/dts/qcom-apq8064-db600c.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-db600c.dts
@@ -45,6 +45,18 @@
 
 	};
 
+	clocks {
+		compatible = "simple-bus";
+		pcie_refclk: pcie-refclk {
+			pinctrl-0 = <&pcie_pins>;
+			pinctrl-names = "default";
+			compatible = "gpio-gate-clock";
+	                clocks = <&rpmcc 27>;
+			#clock-cells = <0>;
+			enable-gpios = <&pm8921_gpio 22 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
 	hdmi-out {
 		compatible = "hdmi-connector";
 		type = "a";
@@ -140,6 +152,16 @@
 
 		qcom,ssbi@500000 {
 			pmic@0 {
+				gpio@150 {
+					pcie_pins: pcie_pins {
+						pios {
+							pins = "gpio22";
+							function = "normal";
+							power-source = <PM8921_GPIO_VPH>;
+						};
+					};
+				};
+
 				mpps@50 {
 					pcie_perst: pcie-perst {
 						pinconf {
@@ -439,6 +461,11 @@
 			pinctrl-0 = <&pcie_perst>;
 			pinctrl-names = "default";
 			perst-gpio = <&pm8921_mpps 1 GPIO_ACTIVE_LOW>;
+			clocks = <&gcc PCIE_A_CLK>,
+				 <&gcc PCIE_H_CLK>,
+				 <&gcc PCIE_PHY_REF_CLK>,
+				 <&pcie_refclk>;
+			clock-names = "core", "iface", "phy", "ref";
 		};
 
 		/* OTG */
-- 
2.16.2
