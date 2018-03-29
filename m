Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752446AbeC2TQq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 15:16:46 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42861 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbeC2TPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 15:15:49 -0400
X-Google-Smtp-Source: AIpwx48KRuD1T44tjLO9GaGLFV9lA5rx4fSvFyqnYhM3CNY71kxlfbH714ZjmrfBARPpaH7thBp0bA==
From: Thierry Escande <thierry.escande@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/4] arm64: dts: apq8096-db820c: Enable wlan and bt en pins
Date: Thu, 29 Mar 2018 21:15:21 +0200
Message-Id: <20180329191524.30225-2-thierry.escande@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180329191524.30225-1-thierry.escande@linaro.org>
References: <20180329191524.30225-1-thierry.escande@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
Content-Transfert-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch enables regulators and gpios for the Qualcomm QCA6174 BT/WLAN
combo controller.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
---

v7:
- New patch in this patchset

 .../boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi    | 22 +++++++++++++++
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi       | 31 ++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi
index 59b29ddfb6e9..5d50f45c4df7 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi
@@ -14,6 +14,28 @@
 		};
 	};
 
+	bt_en_gpios: bt_en_gpios {
+		pinconf {
+			pins = "gpio19";
+			function = PMIC_GPIO_FUNC_NORMAL;
+			output-low;
+			power-source = <PM8994_GPIO_S4>; // 1.8V
+			qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
+			bias-pull-down;
+		};
+	};
+
+	wlan_en_gpios: wlan_en_gpios {
+		pinconf {
+			pins = "gpio8";
+			function = PMIC_GPIO_FUNC_NORMAL;
+			output-low;
+			power-source = <PM8994_GPIO_S4>; // 1.8V
+			qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
+			bias-pull-down;
+		};
+	};
+
 	volume_up_gpio: pm8996_gpio2 {
 		pinconf {
 			pins = "gpio2";
diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 1c8f1b86472d..ec5e6eee0a7a 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -139,9 +139,40 @@
 			pinctrl-0 = <&usb2_vbus_det_gpio>;
 		};
 
+		bt_en: bt-en-1-8v {
+			pinctrl-names = "default";
+			pinctrl-0 = <&bt_en_gpios>;
+			compatible = "regulator-fixed";
+			regulator-name = "bt-en-regulator";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+
+			/* WLAN card specific delay */
+			startup-delay-us = <70000>;
+			enable-active-high;
+		};
+
+		wlan_en: wlan-en-1-8v {
+			pinctrl-names = "default";
+			pinctrl-0 = <&wlan_en_gpios>;
+			compatible = "regulator-fixed";
+			regulator-name = "wlan-en-regulator";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+
+			gpio = <&pm8994_gpios 8 0>;
+
+			/* WLAN card specific delay */
+			startup-delay-us = <70000>;
+			enable-active-high;
+		};
+
 		agnoc@0 {
 			qcom,pcie@600000 {
+				status = "okay";
 				perst-gpio = <&msmgpio 35 GPIO_ACTIVE_LOW>;
+				vddpe-supply = <&wlan_en>;
+				vddpe1-supply = <&bt_en>;
 			};
 
 			qcom,pcie@608000 {
-- 
2.14.1
