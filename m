Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbeECSm7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 14:42:59 -0400
Received: from hermes.aosc.io ([199.195.250.187]:36014 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751101AbeECSm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 14:42:57 -0400
From: Icenowy Zheng <icenowy@aosc.io>
To: Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 6/7] arm64: allwinner: h6: add R_I2C controller
Date: Fri,  4 May 2018 02:38:46 +0800
Message-Id: <20180503183847.11046-7-icenowy@aosc.io>
In-Reply-To: <20180503183847.11046-1-icenowy@aosc.io>
References: <20180503183847.11046-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 SoC has a R_I2C controller wired to the PL0/PL1 pins, which
are used in the reference design to connect AXP805 PMIC.

Add support for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index b0b342c8c189..37c2e11fca2e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -5,7 +5,9 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/sun50i-h6-ccu.h>
+#include <dt-bindings/clock/sun50i-h6-r-ccu.h>
 #include <dt-bindings/reset/sun50i-h6-ccu.h>
+#include <dt-bindings/reset/sun50i-h6-r-ccu.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -204,6 +206,24 @@
 			#gpio-cells = <3>;
 			interrupt-controller;
 			#interrupt-cells = <3>;
+
+			r_i2c_pins: r-i2c {
+				pins = "PL0", "PL1";
+				function = "s_i2c";
+			};
+		};
+
+		r_i2c: i2c@7081400 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x07081400 0x400>;
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&r_ccu CLK_R_APB2_I2C>;
+			resets = <&r_ccu RST_R_APB2_I2C>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&r_i2c_pins>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 	};
 };
-- 
2.15.1
