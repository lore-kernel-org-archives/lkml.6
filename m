Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753300AbeCEWEQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:04:16 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46296 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753271AbeCEWDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:03:15 -0500
X-Google-Smtp-Source: AG47ELsu901afmQX+QM4boCoTLakzHrg4vS7SdBn8mD6DV43Ogv/HU4Z2voNMUCEDAwyF0piAuJE0Q==
From: Tim Harvey <tharvey@gateworks.com>
To: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: mfd: Add Gateworks System Controller bindings
Date: Mon,  5 Mar 2018 14:02:38 -0800
Message-Id: <1520287361-12569-2-git-send-email-tharvey@gateworks.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520287361-12569-1-git-send-email-tharvey@gateworks.com>
References: <1520287361-12569-1-git-send-email-tharvey@gateworks.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds documentation of device-tree bindings for the
Gateworks System Controller (GSC).

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 Documentation/devicetree/bindings/mfd/gsc.txt | 159 ++++++++++++++++++++++++++
 1 file changed, 159 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/gsc.txt

diff --git a/Documentation/devicetree/bindings/mfd/gsc.txt b/Documentation/devicetree/bindings/mfd/gsc.txt
new file mode 100644
index 0000000..fe5d114
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/gsc.txt
@@ -0,0 +1,159 @@
+Gateworks System Controller multi-function device
+
+The GSC is a Multifunction I2C slave device with the following submodules:
+- WDT
+- GPIO
+- Pushbutton controller
+- HWMON
+
+Required properties:
+- compatible : Must be "gw,gsc_v1", "gw,gsc_v2", "gw,gsc_v3"
+- reg: I2C address of the device
+- interrupts: interrupt triggered by GSC_IRQ# signal
+- interrupt-parent: Interrupt controller GSC is connected to
+- #interrupt-cells: should be <1>, index of the interrupt within the
+  controller, in accordance with the "one cell" variant of
+  <devicetree/bindings/interrupt-controller/interrupt.txt>
+
+Optional nodes:
+* watchdog:
+The GSC provides a Watchdog monitor which can power cycle the board's
+primary power supply on most board models when tripped.
+
+Required properties:
+- compatible: must be "gw,gsc-watchdog"
+
+* input:
+The GSC provides an input device capable of dispatching Linux Input events
+for user pushbutton events, tamper switch events, etc.
+
+Required properties:
+- compatible: must be "gw,gsc-input"
+
+* hwmon:
+The GSC provides a set of Analog to Digitcal Converter (ADC) pins used for
+temperature and/or voltage monitoring.
+
+Required properties:
+- compatible: must be "gw,gsc-hwmon"
+
+Example:
+
+	gsc: gsc@20 {
+		compatible = "gw,gsc_v2";
+		reg = <0x20>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		gsc_input {
+			compatible = "gw,gsc-input";
+		};
+
+		gsc_watchdog {
+			compatible = "gw,gsc-watchdog";
+		};
+
+		gsc_hwmon {
+			compatible = "gw,gsc-hwmon";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hwmon@0 { /* A0: Board Temperature */
+				type = <0>;
+				reg = <0x00>;
+				label = "temp";
+			};
+
+			hwmon@1 { /* A1: Input Voltage */
+				type = <1>;
+				reg = <0x02>;
+				label = "Vin";
+			};
+
+			hwmon@2 { /* A2: 5P0 */
+				type = <1>;
+				reg = <0x0b>;
+				label = "5P0";
+			};
+
+			hwmon@4 { /* A4: 0-5V input */
+				type = <1>;
+				reg = <0x14>;
+				label = "ANL0";
+			};
+
+			hwmon@5 { /* A5: 2P5 PCIe/GigE */
+				type = <1>;
+				reg = <0x23>;
+				label = "2P5";
+			};
+
+			hwmon@6 { /* A6: 1P8 Aud/Vid */
+				type = <1>;
+				reg = <0x1d>;
+				label = "1P8";
+			};
+
+			hwmon@7 { /* A7: GPS */
+				type = <1>;
+				reg = <0x26>;
+				label = "GPS";
+			};
+
+			hwmon@12 { /* A12: VDD_CORE */
+				type = <1>;
+				reg = <0x3>;
+				label = "VDD_CORE";
+			};
+
+			hwmon@13 { /* A13: VDD_SOC */
+				type = <1>;
+				reg = <0x11>;
+				label = "VDD_SOC";
+			};
+
+			hwmon@14 { /* A14: 1P0 PCIe SW */
+				type = <1>;
+				reg = <0x20>;
+				label = "1P0";
+			};
+
+			hwmon@15 { /* fan0 */
+				type = <2>;
+				reg = <0x2c>;
+				label = "fan_50p";
+			};
+
+			hwmon@16 { /* fan1 */
+				type = <2>;
+				reg = <0x2e>;
+				label = "fan_60p";
+			};
+
+			hwmon@17 { /* fan2 */
+				type = <2>;
+				reg = <0x30>;
+				label = "fan_70p";
+			};
+
+			hwmon@18 { /* fan3 */
+				type = <2>;
+				reg = <0x32>;
+				label = "fan_80p";
+			};
+
+			hwmon@19 { /* fan4 */
+				type = <2>;
+				reg = <0x34>;
+				label = "fan_90p";
+			};
+
+			hwmon@20 { /* fan5 */
+				type = <2>;
+				reg = <0x36>;
+				label = "fan_100p";
+			};
+		};
+	};
-- 
2.7.4
