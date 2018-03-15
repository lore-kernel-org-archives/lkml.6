Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbeCOLmO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 07:42:14 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:59406 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751961AbeCOLlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 07:41:42 -0400
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] ARM: dts: sun9i: Add device nodes for documented display pipelines for A80
Date: Thu, 15 Mar 2018 19:41:34 +0800
Message-Id: <20180315114136.24747-7-wens@csie.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315114136.24747-1-wens@csie.org>
References: <20180315114136.24747-1-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner A80 SoC has 3 display pipelines, of which some parts are
documented:

  - 3x display front ends (FE), documented
  - 2x display enhancement units (DEU), undocumented
  - 3x display back ends (BE), documented
  - 2x dynamic range controller (DRC), undocumented
  - 2x LCDC/TCONs, documented
  - 1x LCDC/TCON, undocumented, and probably not useable
  - 1x HDMI transmitter, undocumented but DesignWare compatible
  - 1x MERGE block, function unknown

This patch adds device nodes for the first 2 documented pipelines:

    FE0 - DEU0 - - BE0 - DRC0 - TCON0
		x
    FE1 - DEU1 - - BE1 - DRC1 - TCON1

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 381 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 381 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index 82a770a5ba46..6fdb4eaa2e04 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -248,6 +248,12 @@
 		};
 	};
 
+	de: display-engine {
+		compatible = "allwinner,sun9i-a80-display-engine";
+		allwinner,pipelines = <&fe0>, <&fe1>;
+		status = "disabled";
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -523,6 +529,381 @@
 			#reset-cells = <1>;
 		};
 
+		fe0: display-frontend@3100000 {
+			compatible = "allwinner,sun9i-a80-display-frontend";
+			reg = <0x03100000 0x40000>;
+			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&de_clocks CLK_BUS_FE0>, <&de_clocks CLK_FE0>,
+				 <&de_clocks CLK_DRAM_FE0>;
+			clock-names = "ahb", "mod",
+				      "ram";
+			resets = <&de_clocks RST_FE0>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				fe0_out: port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+					fe0_out_deu0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&deu0_in_fe0>;
+					};
+				};
+			};
+		};
+
+		fe1: display-frontend@3140000 {
+			compatible = "allwinner,sun9i-a80-display-frontend";
+			reg = <0x03140000 0x40000>;
+			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&de_clocks CLK_BUS_FE1>, <&de_clocks CLK_FE1>,
+				 <&de_clocks CLK_DRAM_FE1>;
+			clock-names = "ahb", "mod",
+				      "ram";
+			resets = <&de_clocks RST_FE0>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				fe1_out: port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+					fe1_out_deu1: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&deu1_in_fe1>;
+					};
+				};
+			};
+		};
+
+		be0: display-backend@3200000 {
+			compatible = "allwinner,sun9i-a80-display-backend";
+			reg = <0x03200000 0x40000>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&de_clocks CLK_BUS_BE0>, <&de_clocks CLK_BE0>,
+				 <&de_clocks CLK_DRAM_BE0>;
+			clock-names = "ahb", "mod",
+				      "ram";
+			resets = <&de_clocks RST_BE0>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				be0_in: port@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+
+					be0_in_deu0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&deu0_out_be0>;
+					};
+
+					be0_in_deu1: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&deu1_out_be0>;
+					};
+				};
+
+				be0_out: port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+					be0_out_drc0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&drc0_in_be0>;
+					};
+				};
+			};
+		};
+
+		be1: display-backend@3240000 {
+			compatible = "allwinner,sun9i-a80-display-backend";
+			reg = <0x03240000 0x40000>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&de_clocks CLK_BUS_BE1>, <&de_clocks CLK_BE1>,
+				 <&de_clocks CLK_DRAM_BE1>;
+			clock-names = "ahb", "mod",
+				      "ram";
+			resets = <&de_clocks RST_BE1>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				be1_in: port@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+
+					be1_in_deu0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&deu0_out_be1>;
+					};
+
+					be1_in_deu1: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&deu1_out_be1>;
+					};
+				};
+
+				be1_out: port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+					be1_out_drc1: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&drc1_in_be1>;
+					};
+				};
+			};
+		};
+
+		deu0: deu@3300000 {
+			compatible = "allwinner,sun9i-a80-deu";
+			reg = <0x03300000 0x40000>;
+			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&de_clocks CLK_BUS_DEU0>,
+				 <&de_clocks CLK_IEP_DEU0>,
+				 <&de_clocks CLK_DRAM_DEU0>;
+			clock-names = "ahb",
+				      "mod",
+				      "ram";
+			resets = <&de_clocks RST_DEU0>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				deu0_in: port@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+
+					deu0_in_fe0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&fe0_out_deu0>;
+					};
+				};
+
+				deu0_out: port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+					deu0_out_be0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&be0_in_deu0>;
+					};
+
+					deu0_out_be1: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&be1_in_deu0>;
+					};
+				};
+			};
+		};
+
+		deu1: deu@3340000 {
+			compatible = "allwinner,sun9i-a80-deu";
+			reg = <0x03340000 0x40000>;
+			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&de_clocks CLK_BUS_DEU1>,
+				 <&de_clocks CLK_IEP_DEU1>,
+				 <&de_clocks CLK_DRAM_DEU1>;
+			clock-names = "ahb",
+				      "mod",
+				      "ram";
+			resets = <&de_clocks RST_DEU1>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				deu1_in: port@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+
+					deu1_in_fe1: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&fe1_out_deu1>;
+					};
+				};
+
+				deu1_out: port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+					deu1_out_be0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&be0_in_deu1>;
+					};
+
+					deu1_out_be1: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&be1_in_deu1>;
+					};
+				};
+			};
+		};
+
+		drc0: drc@3400000 {
+			compatible = "allwinner,sun9i-a80-drc";
+			reg = <0x03400000 0x40000>;
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&de_clocks CLK_BUS_DRC0>,
+				 <&de_clocks CLK_IEP_DRC0>,
+				 <&de_clocks CLK_DRAM_DRC0>;
+			clock-names = "ahb",
+				      "mod",
+				      "ram";
+			resets = <&de_clocks RST_DRC0>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				drc0_in: port@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+
+					drc0_in_be0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&be0_out_drc0>;
+					};
+				};
+
+				drc0_out: port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+					drc0_out_tcon0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&tcon0_in_drc0>;
+					};
+				};
+			};
+		};
+
+		drc1: drc@3440000 {
+			compatible = "allwinner,sun9i-a80-drc";
+			reg = <0x03440000 0x40000>;
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&de_clocks CLK_BUS_DRC1>,
+				 <&de_clocks CLK_IEP_DRC1>,
+				 <&de_clocks CLK_DRAM_DRC1>;
+			clock-names = "ahb",
+				      "mod",
+				      "ram";
+			resets = <&de_clocks RST_DRC1>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				drc1_in: port@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+
+					drc1_in_be1: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&be1_out_drc1>;
+					};
+				};
+
+				drc1_out: port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+					drc1_out_tcon1: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&tcon1_in_drc1>;
+					};
+				};
+			};
+		};
+
+		tcon0: lcd-controller@3c00000 {
+			compatible = "allwinner,sun9i-a80-tcon-lcd";
+			reg = <0x03c00000 0x10000>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_LCD0>, <&ccu CLK_LCD0>;
+			clock-names = "ahb", "tcon-ch0";
+			resets = <&ccu RST_BUS_LCD0>, <&ccu RST_BUS_EDP>;
+			reset-names = "lcd", "edp";
+			clock-output-names = "tcon0-pixel-clock";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				tcon0_in: port@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+
+					tcon0_in_drc0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&drc0_out_tcon0>;
+					};
+				};
+
+				tcon0_out: port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+			};
+		};
+
+		tcon1: lcd-controller@3c10000 {
+			compatible = "allwinner,sun9i-a80-tcon-tv";
+			reg = <0x03c10000 0x10000>;
+			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_LCD1>, <&ccu CLK_LCD1>;
+			clock-names = "ahb", "tcon-ch1";
+			resets = <&ccu RST_BUS_LCD1>, <&ccu RST_BUS_EDP>;
+			reset-names = "lcd", "edp";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				tcon1_in: port@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+
+					tcon1_in_drc1: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&drc1_out_tcon1>;
+					};
+				};
+
+				tcon1_out: port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+			};
+		};
+
 		ccu: clock@6000000 {
 			compatible = "allwinner,sun9i-a80-ccu";
 			reg = <0x06000000 0x800>;
-- 
2.16.2
