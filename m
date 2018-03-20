Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeCTDYL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 23:24:11 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38004 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751676AbeCTDYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 23:24:02 -0400
X-Google-Smtp-Source: AG47ELs9lrFcnCR84oGVKqLQg9gFZy6SCOW69mqgSw63IIDHV2qab23Hv80i8D2c0EFX3YEAuSFVRg==
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
Subject: [PATCH v5 1/3] arm64: dts: apq8096-db820c: enable bluetooth node
Date: Tue, 20 Mar 2018 04:23:29 +0100
Message-Id: <20180320032331.29865-2-thierry.escande@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180320032331.29865-1-thierry.escande@linaro.org>
References: <20180320032331.29865-1-thierry.escande@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
Content-Transfert-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new serial node for the Qualcomm BT controller QCA6174. This
allows automatic probing and hci registration through the serdev
framework instead of relying on the userspace helpers.

Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
---

v5:
- Rename 'bt-disable-n' gpio as 'enable'

v4: no change
v3: no change

v2:
- Fix author email

 arch/arm64/boot/dts/qcom/apq8096-db820c-pins.dtsi  | 14 +++++++++
 .../boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi    | 17 +++++++++++
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi       | 33 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi              | 10 +++++++
 4 files changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c-pins.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c-pins.dtsi
index 24552f19b3fa..172165d84669 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c-pins.dtsi
@@ -36,4 +36,18 @@
 			drive-strength = <2>;	/* 2 MA */
 		};
 	};
+
+	blsp1_uart1_default: blsp1_uart1_default {
+		function = "blsp_uart2";
+		pins = "gpio41", "gpio42", "gpio43", "gpio44";
+		drive-strength = <16>;
+		bias-disable;
+	};
+
+	blsp1_uart1_sleep: blsp1_uart1_sleep {
+		function = "gpio";
+		pins = "gpio41", "gpio42", "gpio43", "gpio44";
+		drive-strength = <2>;
+		bias-disable;
+	};
 };
diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi
index 59b29ddfb6e9..f8d2a3b10b1f 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi
@@ -26,6 +26,23 @@
 		};
 	};
 
+	divclk4_pin_a: divclk4 {
+		pins = "gpio18";
+		function = "func2";
+
+		bias-disable;
+		power-source = <PM8994_GPIO_S4>;
+	};
+
+	bt_en_pin_a: bt-en-active {
+		pins = "gpio19";
+		function = "normal";
+
+		output-low;
+		power-source = <PM8994_GPIO_S4>;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
+	};
+
 	usb3_vbus_det_gpio: pm8996_gpio22 {
 		pinconf {
 			pins = "gpio22";
diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 1c8f1b86472d..8b3bcdf0d718 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -23,6 +23,7 @@
 	aliases {
 		serial0 = &blsp2_uart1;
 		serial1 = &blsp2_uart2;
+		serial2 = &blsp1_uart1;
 		i2c0	= &blsp1_i2c2;
 		i2c1	= &blsp2_i2c1;
 		i2c2	= &blsp2_i2c0;
@@ -34,7 +35,39 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	clocks {
+		divclk4: divclk4 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+			clock-output-names = "divclk4";
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&divclk4_pin_a>;
+		};
+	};
+
 	soc {
+		serial@7570000 {
+			label = "BT-UART";
+			status = "okay";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp1_uart1_default>;
+			pinctrl-1 = <&blsp1_uart1_sleep>;
+
+			bluetooth {
+				compatible = "qcom,qca6174-bt";
+
+				/* bt_disable_n gpio */
+				enable-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
+
+				pinctrl-names = "default";
+				pinctrl-0 = <&bt_en_pin_a>;
+
+				clocks = <&divclk4>;
+			};
+		};
+
 		serial@75b0000 {
 			label = "LS-UART1";
 			status = "okay";
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 0a6f7952bbb1..2d54a86a027f 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -408,6 +408,16 @@
 			#clock-cells = <1>;
 		};
 
+		blsp1_uart1: serial@7570000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x07570000 0x1000>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
+
 		blsp1_spi0: spi@7575000 {
 			compatible = "qcom,spi-qup-v2.2.1";
 			reg = <0x07575000 0x600>;
-- 
2.14.1
