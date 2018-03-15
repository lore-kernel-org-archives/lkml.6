Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752681AbeCOOuu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:50:50 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:50640 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752218AbeCOOus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:50:48 -0400
X-Google-Smtp-Source: AG47ELuxBIOFna9HQbpKPD01+B4GwQl2oD0p2bM3Mf8V9NbYLNrh2xhHXb46OTTkiGu+R29UawOHpQ==
From: srinivas.kandagatla@linaro.org
To: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org
Cc: david.brown@linaro.org, robh+dt@kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ARM: dts: qcom: Add apq8064 Dragon Board 600c support
Date: Thu, 15 Mar 2018 14:48:41 +0000
Message-Id: <20180315144841.16144-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch add support to DB600c board, which is another
96board based on Qualcomm APQ8064 SoC.

Support for USB, HDMI, PCIe, I2C, SPI, eMMC, microSD card, LEDs
device tree nodes is added in this patch.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/Makefile                |   1 +
 arch/arm/boot/dts/qcom-apq8064-db600c.dts | 547 ++++++++++++++++++++++++++++++
 2 files changed, 548 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-apq8064-db600c.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ade7a38543dc..940db57e57b8 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -743,6 +743,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-apq8064-ifc6410.dtb \
 	qcom-apq8064-sony-xperia-yuga.dtb \
 	qcom-apq8064-asus-nexus7-flo.dtb \
+	qcom-apq8064-db600c.dtb \
 	qcom-apq8074-dragonboard.dtb \
 	qcom-apq8084-ifc6540.dtb \
 	qcom-apq8084-mtp.dtb \
diff --git a/arch/arm/boot/dts/qcom-apq8064-db600c.dts b/arch/arm/boot/dts/qcom-apq8064-db600c.dts
new file mode 100644
index 000000000000..6a3250151038
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-apq8064-db600c.dts
@@ -0,0 +1,547 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "qcom-apq8064-v2.0.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/pinctrl/qcom,pmic-mpp.h>
+#include <dt-bindings/mfd/qcom-rpm.h>
+
+/ {
+	model = "Qualcomm Technologies, Inc. DB600c";
+	compatible = "arrow,apq8064-db600c", "qcom,apq8064";
+
+	aliases {
+		serial0 = &gsbi7_serial;
+		serial1 = &gsbi1_serial;
+		i2c0 = &gsbi2_i2c;
+		i2c1 = &gsbi3_i2c;
+		i2c2 = &gsbi4_i2c;
+		i2c3 = &gsbi7_i2c;
+		spi0 = &gsbi5_spi;
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		vph: regulator-fixed@1 {
+			compatible = "regulator-fixed";
+			regulator-min-microvolt = <4500000>;
+			regulator-max-microvolt = <4500000>;
+			regulator-name = "VPH";
+			regulator-type = "voltage";
+			regulator-boot-on;
+		};
+
+		/* on board fixed 3.3v supply */
+		vcc3v3: vcc3v3 {
+			compatible = "regulator-fixed";
+			regulator-name = "VCC3V3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+	};
+
+	hdmi-out {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con: endpoint {
+				remote-endpoint = <&hdmi_out>;
+			};
+		};
+	};
+
+	soc {
+		pinctrl@800000 {
+			card_detect: card_detect {
+				mux {
+					pins = "gpio26";
+					function = "gpio";
+					bias-disable;
+				};
+			};
+
+			user_leds: user-leds {
+				mux {
+					pins = "gpio6", "gpio7", "gpio35", "gpio86";
+					function = "gpio";
+				};
+		
+				conf {
+					pins = "gpio6", "gpio7", "gpio35", "gpio86";
+					function = "gpio";
+					output-low;
+				};
+			};
+		
+			i2c1 {
+				pinconf {
+					drive-strength = <8>;
+				};
+			};
+		
+			i2c2 {
+				pinconf {
+					drive-strength = <8>;
+				};
+			};
+		
+			i2c3 {
+				pinconf {
+					drive-strength = <8>;
+				};
+			};
+			
+			i2c4 {
+				pinconf {
+					drive-strength = <8>;
+				};
+			};
+		
+			i2c5 {
+				pinconf {
+					drive-strength = <8>;
+				};
+			};
+		
+			i2c6 {
+				pinconf {
+					drive-strength = <8>;
+				};
+			};
+		
+			i2c7 {
+				pinconf {
+					drive-strength = <8>;
+				};
+			};
+
+			i2c1 {
+				pinconf {
+					drive-strength = <8>;
+				};
+			};
+		
+			spi5_default {
+				pinconf {
+					drive-strength = <8>;
+				};
+		
+				pinconf_cs {
+					drive-strength = <8>;
+				};
+			};
+		};
+
+		qcom,ssbi@500000 {
+			pmic@0 {
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
+				mpps@50 {
+					pcie_perst: pcie-perst {
+						pinconf {
+							pins = "mpp1";
+							function = "digital";
+							power-source = <PM8921_MPP_S4>;
+							output-low;
+						};
+					};
+			
+					mpp_leds: mpp-leds {
+						pinconf {
+							pins = "mpp7", "mpp8", "mpp9", "mpp10",	"mpp11", "mpp12";
+							function = "digital";
+							power-source = <PM8921_MPP_VPH>;
+							drive-strength = <12>;
+							output-high;
+						};
+					};
+				};
+			};
+		};
+
+		rpm@108000 {
+			regulators {
+				vdd_s1-supply = <&vph>;
+				vdd_s2-supply = <&vph>;
+				vdd_s3-supply = <&vph>;
+				vdd_s4-supply = <&vph>;
+				vdd_s5-supply = <&vph>;
+				vdd_s6-supply = <&vph>;
+				vdd_s7-supply = <&vph>;
+
+				vdd_l1_l2_l12_l18-supply = <&pm8921_s4>;
+				vdd_l3_l15_l17-supply = <&vph>;
+				vdd_l4_l14-supply = <&vph>;
+				vdd_l5_l8_l16-supply = <&vph>;
+				vdd_l6_l7-supply = <&vph>;
+				vdd_l9_l11-supply = <&vph>;
+				vdd_l10_l22-supply = <&vph>;
+				vdd_l21_l23_l29-supply = <&vph>;
+
+				vdd_l24-supply = <&pm8921_s1>;
+				vdd_l25-supply = <&pm8921_s1>;
+				vdd_l26-supply = <&pm8921_s7>;
+				vdd_l27-supply = <&pm8921_s7>;
+				vdd_l28-supply = <&pm8921_s7>;
+
+				vin_lvs1_3_6-supply = <&pm8921_s4>;
+				vin_lvs2-supply = <&pm8921_s1>;
+				vin_lvs4_5_7-supply = <&pm8921_s4>;
+
+				s1 {
+					regulator-always-on;
+					regulator-min-microvolt = <1225000>;
+					regulator-max-microvolt = <1225000>;
+					qcom,switch-mode-frequency = <3200000>;
+					bias-pull-down;
+				};
+
+				s2 {
+					regulator-min-microvolt = <1300000>;
+					regulator-max-microvolt = <1300000>;
+					qcom,switch-mode-frequency = <1600000>;
+					bias-pull-down;
+					regulator-always-on;
+				};
+
+				s3 {
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1400000>;
+					qcom,switch-mode-frequency = <4800000>;
+				};
+
+				s4 {
+					regulator-min-microvolt	= <1800000>;
+					regulator-max-microvolt	= <1800000>;
+					qcom,switch-mode-frequency = <1600000>;
+					qcom,force-mode = <QCOM_RPM_FORCE_MODE_AUTO>;
+					bias-pull-down;
+					regulator-always-on;
+				};
+
+				s7 {
+					regulator-min-microvolt = <1300000>;
+					regulator-max-microvolt = <1300000>;
+					qcom,switch-mode-frequency = <3200000>;
+				 };
+
+				l3 {
+					regulator-min-microvolt = <3050000>;
+					regulator-max-microvolt = <3300000>;
+					bias-pull-down;
+				};
+
+				l4 {
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1800000>;
+					bias-pull-down;
+				};
+
+				l5 {
+					regulator-min-microvolt = <2750000>;
+					regulator-max-microvolt = <3000000>;
+					bias-pull-down;
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				l6 {
+					regulator-min-microvolt = <2950000>;
+					regulator-max-microvolt = <2950000>;
+					bias-pull-down;
+				};
+
+				l7 {
+					regulator-min-microvolt = <2950000>;
+					regulator-max-microvolt = <2950000>;
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				/**
+				/**
+				 * 1.8v required on LS expansion
+				 * for mezzanine boards
+				 */
+				l15 {
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+				};
+
+				l23 {
+					regulator-min-microvolt = <1700000>;
+					regulator-max-microvolt = <1900000>;
+					bias-pull-down;
+				};
+
+				l26 {
+					regulator-min-microvolt = < 375000>;
+					regulator-max-microvolt = <1050000>;
+					bias-pull-down;
+				};
+
+				lvs6 {
+					bias-pull-down;
+				};
+
+				lvs7 {
+					bias-pull-down;
+				};
+			};
+		};
+
+		gsbi@12440000 {
+			status = "okay";
+			qcom,mode = <GSBI_PROT_UART_W_FC>;
+			serial@12450000 {
+				label = "LS-UART1";
+				status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <&gsbi1_uart_4pins>;
+			};
+		};
+
+		gsbi@12480000 {
+			status = "okay";
+			qcom,mode = <GSBI_PROT_I2C>;
+			i2c@124a0000 {
+				/* On Low speed expansion and Sensors */
+				label = "LS-I2C0";
+				status = "okay";
+			};
+		};
+
+		gsbi@16200000 {
+			status = "okay";
+			qcom,mode = <GSBI_PROT_I2C>;
+			i2c@16280000 {
+			/* On Low speed expansion */
+				status = "okay";
+				label = "LS-I2C1";
+				clock-frequency = <200000>;
+				eeprom@52 {
+					compatible = "atmel,24c128";
+					reg = <0x52>;
+					pagesize = <64>;
+				};
+			};
+		};
+
+		gsbi@16300000 {
+			status = "okay";
+			qcom,mode = <GSBI_PROT_I2C>;
+			i2c@16380000 {
+				/* On High speed expansion */
+				label = "HS-CAM-I2C3";
+				status = "okay";
+			};
+		};
+
+		gsbi@1a200000 {
+			status = "okay";
+			qcom,mode = <GSBI_PROT_SPI>;
+			spi@1a280000 {
+				/* On Low speed expansion */
+				label = "LS-SPI0";
+				status = "okay";
+				num-cs = <1>;
+				cs-gpios  = <&tlmm_pinmux 53 0>;
+				spi-sram@0 {
+					status = "okay";
+					#address-cells = <1>;
+					#size-cells = <1>;
+					compatible= "microchip,mchp23lcv1024";
+					reg = <0>;
+					spi-max-frequency = <10000000>;
+				};
+			};
+		};
+
+		gsbi@16500000 {
+			status = "okay";
+			qcom,mode = <GSBI_PROT_UART_W_FC>;
+			serial@1654000 {
+				label = "BT-UART";
+				status = "okay";
+				pinctrl-name = "default";
+				pinctrl-0 = <&gsbi6_uart_4pins>;
+			};
+		};
+
+
+		/* DEBUG UART  */
+		gsbi@16600000 {
+			status = "okay";
+			qcom,mode = <GSBI_PROT_I2C_UART>;
+			serial@16640000 {
+				label = "LS-UART0";
+				status = "okay";
+				pinctrl-names = "default";
+				pinctrl-0 = <&gsbi7_uart_2pins>;
+
+			};
+
+			i2c@16680000 {
+				/* On High speed expansion */
+				status = "okay";
+				label = "HS-CAM-I2C2";
+			};
+		};
+
+		leds {
+			pinctrl-names = "default";
+			pinctrl-0 = <&user_leds>, <&mpp_leds>;
+
+			compatible = "gpio-leds";
+
+			user-led0 {
+				label = "user0-led";
+				gpios = <&pm8921_mpps 9 GPIO_ACTIVE_HIGH>;
+				linux,default-trigger = "heartbeat";
+				default-state = "off";
+			};
+
+			user-led1 {
+				label = "user1-led";
+				gpios = <&pm8921_mpps 10 GPIO_ACTIVE_HIGH>;
+				linux,default-trigger = "mmc0";
+				default-state = "off";
+			};
+
+			user-led2 {
+				label = "user2-led";
+				gpios = <&pm8921_mpps 11 GPIO_ACTIVE_HIGH>;
+				linux,default-trigger = "mmc1";
+				default-state = "off";
+			};
+
+			user-led3 {
+				label = "user3-led";
+				gpios = <&pm8921_mpps 12 GPIO_ACTIVE_HIGH>;
+				linux,default-trigger = "none";
+				default-state = "off";
+			};
+
+			wifi-led {
+				label = "WiFi-led";
+				gpios = <&pm8921_mpps 7 GPIO_ACTIVE_HIGH>;
+				default-state = "off";
+				linux,default-trigger = "none";
+			};
+
+			bt-led {
+				label = "BT-led";
+				gpios = <&pm8921_mpps 8 GPIO_ACTIVE_HIGH>;
+				default-state = "off";
+				linux,default-trigger = "none";
+			};
+		};
+
+		pci@1b500000 {
+			status = "okay";
+			vdda-supply = <&pm8921_s3>;
+			vdda_phy-supply = <&pm8921_lvs6>;
+			vdda_refclk-supply = <&vcc3v3>;
+			pinctrl-0 = <&pcie_perst>;
+			pinctrl-names = "default";
+			perst-gpio = <&pm8921_mpps 1 GPIO_ACTIVE_LOW>;
+		};
+
+		/* OTG */
+		usb@12500000 {
+			status = "okay";
+			dr_mode = "otg";
+			ulpi {
+				phy {
+					v3p3-supply = <&pm8921_l3>;
+					v1p8-supply = <&pm8921_l4>;
+				};
+			};
+		};
+
+		usb@12520000 {
+			status = "okay";
+			dr_mode = "host";
+			ulpi {
+				phy {
+					v3p3-supply = <&pm8921_l3>;
+					v1p8-supply = <&pm8921_l23>;
+				};
+			};
+		};
+
+		usb@12530000 {
+			status = "okay";
+			dr_mode = "host";
+			ulpi {
+				phy {
+					v3p3-supply = <&pm8921_l3>;
+					v1p8-supply = <&pm8921_l23>;
+				};
+			};
+		};
+
+		amba {
+			/* eMMC */
+			sdcc1: sdcc@12400000 {
+				status = "okay";
+				vmmc-supply = <&pm8921_l5>;
+				vqmmc-supply = <&pm8921_s4>;
+			};
+
+			/* External micro SD card */
+			sdcc3: sdcc@12180000 {
+				status = "okay";
+				vmmc-supply = <&pm8921_l6>;
+				vqmmc-supply = <&pm8921_l7>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&sdcc3_pins &card_detect>;
+				cd-gpios = <&tlmm_pinmux 26 GPIO_ACTIVE_LOW>;
+			};
+		};
+
+		hdmi-tx@4a00000 {
+			status = "okay";
+			core-vdda-supply = <&pm8921_hdmi_switch>;
+			hdmi-mux-supply = <&vcc3v3>;
+
+			hpd-gpio = <&tlmm_pinmux 72 GPIO_ACTIVE_HIGH>;
+
+			ports {
+				port@1 {
+					endpoint {
+						remote-endpoint = <&hdmi_con>;
+					};
+				};
+			};
+		};
+
+		hdmi-phy@4a00400 {
+			status = "okay";
+			core-vdda-supply = <&pm8921_hdmi_switch>;
+		};
+
+		mdp@5100000 {
+			status = "okay";
+
+			ports {
+				port@3 {
+					endpoint {
+						remote-endpoint = <&hdmi_in>;
+					};
+				};
+			};
+		};
+	};
+};
-- 
2.16.2
