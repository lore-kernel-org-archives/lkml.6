Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752775AbeDPCku (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 22:40:50 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35570 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752212AbeDPCks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 22:40:48 -0400
X-Google-Smtp-Source: AIpwx4/a4lZKdLtkchspvgywhpVjClKCBBo8ThZAX9yZO9UF30ZW470lTW5o5hMqr0dL7r1rMdcZ0w==
From: Baolin Wang <baolin.wang@linaro.org>
To: robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, arnd@arndb.de, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
Cc: devicetree@vger.kernel.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH 1/2] arm64: dts: Add GPIO and GPIO keys device nodes
Date: Mon, 16 Apr 2018 10:40:03 +0800
Message-Id: <fcea1874b6e3d0243684c133c7b34f2384341a32.1523846102.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device nodes to enable one GPIO controller located on
digital chip, 2 EIC (external interrupt controller) controllers loacted
on PMIC and digital chip for Spreadtrum SC9860 platform.

Moreover this patch adds 3 GPIO keys relied on EIC controller to support
power key and volume up/down keys.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/sc2731.dtsi |   11 ++++++++
 arch/arm64/boot/dts/sprd/sc9860.dtsi |   30 ++++++++++++++++++++
 arch/arm64/boot/dts/sprd/whale2.dtsi |   50 ++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
index 4331006..98d3b4f 100644
--- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -24,6 +24,17 @@
 			interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		pmic_eic: gpio@300 {
+			compatible = "sprd,sc27xx-eic";
+			reg = <0x300>;
+			interrupt-parent = <&sc2731_pmic>;
+			interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
 		regulators {
 			compatible = "sprd,sc27xx-regulator";
 
diff --git a/arch/arm64/boot/dts/sprd/sc9860.dtsi b/arch/arm64/boot/dts/sprd/sc9860.dtsi
index 5dbfb79..3066a55 100644
--- a/arch/arm64/boot/dts/sprd/sc9860.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9860.dtsi
@@ -7,6 +7,8 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
 #include "whale2.dtsi"
 
 / {
@@ -679,5 +681,33 @@
 				};
 			};
 		};
+
+		gpio-keys {
+			compatible = "gpio-keys";
+
+			key-volumedown {
+				label = "Volume Down Key";
+				linux,code = <KEY_VOLUMEDOWN>;
+				gpios = <&eic_debounce 2 GPIO_ACTIVE_LOW>;
+				debounce-interval = <2>;
+				wakeup-source;
+			};
+
+			key-volumeup {
+				label = "Volume Up Key";
+				linux,code = <KEY_VOLUMEUP>;
+				gpios = <&pmic_eic 10 GPIO_ACTIVE_HIGH>;
+				debounce-interval = <2>;
+				wakeup-source;
+			};
+
+			key-power {
+				label = "Power Key";
+				linux,code = <KEY_POWER>;
+				gpios = <&pmic_eic 1 GPIO_ACTIVE_HIGH>;
+				debounce-interval = <2>;
+				wakeup-source;
+			};
+		};
 	};
 };
diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
index 66a881e..bf7e70c 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -154,6 +154,56 @@
 				clocks = <&aon_gate CLK_SPLK_EB>;
 			};
 
+			eic_debounce: gpio@40210000 {
+				compatible = "sprd,sc9860-eic-debounce";
+				reg = <0 0x40210000 0 0x80>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			eic_latch: gpio@40210080 {
+				compatible = "sprd,sc9860-eic-latch";
+				reg = <0 0x40210080 0 0x20>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			eic_async: gpio@402100a0 {
+				compatible = "sprd,sc9860-eic-async";
+				reg = <0 0x402100a0 0 0x20>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			eic_sync: gpio@402100c0 {
+				compatible = "sprd,sc9860-eic-sync";
+				reg = <0 0x402100c0 0 0x20>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			ap_gpio: gpio@40280000 {
+				compatible = "sprd,sc9860-gpio";
+				reg = <0 0x40280000 0 0x1000>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
 			pin_controller: pinctrl@402a0000 {
 				compatible = "sprd,sc9860-pinctrl";
 				reg = <0 0x402a0000 0 0x10000>;
-- 
1.7.9.5
