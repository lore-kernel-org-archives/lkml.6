Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbeESSdn (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 14:33:43 -0400
Received: from mailoutvs2.siol.net ([213.250.19.135]:34856 "EHLO mail.siol.net"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752641AbeESSdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 14:33:03 -0400
From: Jernej Skrabec <jernej.skrabec@siol.net>
To: maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc: mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 14/15] ARM: dts: sun8i: r40: Add HDMI pipeline
Date: Sat, 19 May 2018 20:31:26 +0200
Message-Id: <20180519183127.2718-15-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180519183127.2718-1-jernej.skrabec@siol.net>
References: <20180519183127.2718-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add all entries needed for HDMI to function properly.

Since R40 has highly configurable pipeline, both mixers and both TCON
TVs are added. Board specific DT should then connect them together to
best fit the purpose of the board.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 166 +++++++++++++++++++++++++++++++
 1 file changed, 166 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 173dcc1652d2..6d5407964997 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -42,8 +42,11 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/sun8i-de2.h>
 #include <dt-bindings/clock/sun8i-r40-ccu.h>
+#include <dt-bindings/clock/sun8i-tcon-top.h>
 #include <dt-bindings/reset/sun8i-r40-ccu.h>
+#include <dt-bindings/reset/sun8i-de2.h>
 
 / {
 	#address-cells = <1>;
@@ -99,12 +102,70 @@
 		};
 	};
 
+	de: display-engine {
+		compatible = "allwinner,sun8i-r40-display-engine",
+			     "allwinner,sun8i-h3-display-engine";
+		allwinner,pipelines = <&mixer0>, <&mixer1>;
+		status = "disabled";
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
 
+		display_clocks: clock@1000000 {
+			compatible = "allwinner,sun8i-r40-de2-clk",
+				     "allwinner,sun8i-h3-de2-clk";
+			reg = <0x01000000 0x100000>;
+			clocks = <&ccu CLK_DE>,
+				 <&ccu CLK_BUS_DE>;
+			clock-names = "mod",
+				      "bus";
+			resets = <&ccu RST_BUS_DE>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		mixer0: mixer@1100000 {
+			compatible = "allwinner,sun8i-r40-de2-mixer-0";
+			reg = <0x01100000 0x100000>;
+			clocks = <&display_clocks CLK_BUS_MIXER0>,
+				 <&display_clocks CLK_MIXER0>;
+			clock-names = "bus",
+				      "mod";
+			resets = <&display_clocks RST_MIXER0>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				mixer0_out: port@1 {
+					reg = <1>;
+				};
+			};
+		};
+
+		mixer1: mixer@1200000 {
+			compatible = "allwinner,sun8i-r40-de2-mixer-1";
+			reg = <0x01200000 0x100000>;
+			clocks = <&display_clocks CLK_BUS_MIXER1>,
+				 <&display_clocks CLK_MIXER1>;
+			clock-names = "bus",
+				      "mod";
+			resets = <&display_clocks RST_WB>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				mixer1_out: port@1 {
+					reg = <1>;
+				};
+			};
+		};
+
 		nmi_intc: interrupt-controller@1c00030 {
 			compatible = "allwinner,sun7i-a20-sc-nmi";
 			interrupt-controller;
@@ -451,6 +512,70 @@
 			#size-cells = <0>;
 		};
 
+		tcon_top: tcon-top@1c70000 {
+			compatible = "allwinner,sun8i-r40-tcon-top";
+			reg = <0x01c70000 0x1000>;
+			clocks = <&ccu CLK_BUS_TCON_TOP>;
+			clock-names = "bus";
+			resets = <&ccu RST_BUS_TCON_TOP>;
+			reset-names = "rst";
+			#clock-cells = <1>;
+		};
+
+		tcon_tv0: lcd-controller@1c73000 {
+			compatible = "allwinner,sun8i-r40-tcon-tv-0";
+			reg = <0x01c73000 0x1000>;
+			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_TCON_TV0>, <&ccu CLK_TCON_TV0>,
+				 <&tcon_top 1>;
+			clock-names = "ahb", "tcon-ch1", "tcon-top";
+			resets = <&ccu RST_BUS_TCON_TV0>;
+			reset-names = "lcd";
+			allwinner,tcon-top = <&tcon_top>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				tcon_tv0_in: port@0 {
+					reg = <0>;
+				};
+
+				tcon_tv0_out: port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+			};
+		};
+
+		tcon_tv1: lcd-controller@1c74000 {
+			compatible = "allwinner,sun8i-r40-tcon-tv-1";
+			reg = <0x01c74000 0x1000>;
+			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_TCON_TV1>, <&ccu CLK_TCON_TV1>,
+				 <&tcon_top 2>;
+			clock-names = "ahb", "tcon-ch1", "tcon-top";
+			resets = <&ccu RST_BUS_TCON_TV1>;
+			reset-names = "lcd";
+			allwinner,tcon-top = <&tcon_top>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				tcon_tv1_in: port@0 {
+					reg = <0>;
+				};
+
+				tcon_tv1_out: port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+			};
+		};
+
 		gic: interrupt-controller@1c81000 {
 			compatible = "arm,gic-400";
 			reg = <0x01c81000 0x1000>,
@@ -461,6 +586,47 @@
 			#interrupt-cells = <3>;
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
+
+		hdmi: hdmi@1ee0000 {
+			compatible = "allwinner,sun8i-r40-dw-hdmi",
+				     "allwinner,sun8i-a83t-dw-hdmi";
+			reg = <0x01ee0000 0x10000>;
+			reg-io-width = <1>;
+			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_HDMI0>, <&ccu CLK_HDMI_SLOW>,
+				 <&ccu CLK_HDMI>;
+			clock-names = "iahb", "isfr", "tmds";
+			resets = <&ccu RST_BUS_HDMI1>;
+			reset-names = "ctrl";
+			phys = <&hdmi_phy>;
+			phy-names = "hdmi-phy";
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				hdmi_in: port@0 {
+					reg = <0>;
+				};
+
+				hdmi_out: port@1 {
+					reg = <1>;
+				};
+			};
+		};
+
+		hdmi_phy: hdmi-phy@1ef0000 {
+			compatible = "allwinner,sun8i-r40-hdmi-phy",
+				     "allwinner,sun50i-a64-hdmi-phy";
+			reg = <0x01ef0000 0x10000>;
+			clocks = <&ccu CLK_BUS_HDMI1>, <&ccu CLK_HDMI_SLOW>,
+				 <&ccu 7>, <&ccu 16>;
+			clock-names = "bus", "mod", "pll-0", "pll-1";
+			resets = <&ccu RST_BUS_HDMI0>;
+			reset-names = "phy";
+			#phy-cells = <0>;
+		};
 	};
 
 	timer {
-- 
2.17.0
