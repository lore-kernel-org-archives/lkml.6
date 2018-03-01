Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162258AbeCAVgm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:36:42 -0500
Received: from mailoutvs4.siol.net ([213.250.19.137]:33437 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1162167AbeCAVfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:35:31 -0500
From: Jernej Skrabec <jernej.skrabec@siol.net>
To: maxime.ripard@free-electrons.com, wens@csie.org, airlied@linux.ie,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org
Cc: jernej.skrabec@siol.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 14/16] ARM: dts: sunxi: h3/h5: Add HDMI pipeline
Date: Thu,  1 Mar 2018 22:34:40 +0100
Message-Id: <20180301213442.16677-15-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180301213442.16677-1-jernej.skrabec@siol.net>
References: <20180301213442.16677-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds all entries needed for HDMI to function properly.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 108 +++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 7741166d34d8..1be1a02d6df2 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -105,6 +105,12 @@
 		};
 	};
 
+	de: display-engine {
+		compatible = "allwinner,sun8i-h3-display-engine";
+		allwinner,pipelines = <&mixer0>;
+		status = "disabled";
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -123,6 +129,29 @@
 			#reset-cells = <1>;
 		};
 
+		mixer0: mixer@1100000 {
+			compatible = "allwinner,sun8i-h3-de2-mixer-0";
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
+
+					mixer0_out_tcon0: endpoint {
+						remote-endpoint = <&tcon0_in_mixer0>;
+					};
+				};
+			};
+		};
+
 		syscon: syscon@1c00000 {
 			compatible = "allwinner,sun8i-h3-system-controller",
 				"syscon";
@@ -138,6 +167,41 @@
 			#dma-cells = <1>;
 		};
 
+		tcon0: lcd-controller@1c0c000 {
+			compatible = "allwinner,sun8i-h3-tcon-tv",
+				     "allwinner,sun8i-a83t-tcon-tv";
+			reg = <0x01c0c000 0x1000>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_TCON0>, <&ccu CLK_TCON0>;
+			clock-names = "ahb", "tcon-ch1";
+			resets = <&ccu RST_BUS_TCON0>;
+			reset-names = "lcd";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				tcon0_in: port@0 {
+					reg = <0>;
+
+					tcon0_in_mixer0: endpoint {
+						remote-endpoint = <&mixer0_out_tcon0>;
+					};
+				};
+
+				tcon0_out: port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+					tcon0_out_hdmi: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&hdmi_in_tcon0>;
+					};
+				};
+			};
+		};
+
 		mmc0: mmc@1c0f000 {
 			/* compatible and clocks are in per SoC .dtsi file */
 			reg = <0x01c0f000 0x1000>;
@@ -682,6 +746,50 @@
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
+		hdmi: hdmi@1ee0000 {
+			compatible = "allwinner,sun8i-h3-dw-hdmi",
+				     "allwinner,sun8i-a83t-dw-hdmi";
+			reg = <0x01ee0000 0x10000>;
+			reg-io-width = <1>;
+			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_DDC>,
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
+
+					hdmi_in_tcon0: endpoint {
+						remote-endpoint = <&tcon0_out_hdmi>;
+					};
+				};
+
+				hdmi_out: port@1 {
+					reg = <1>;
+				};
+			};
+		};
+
+		hdmi_phy: hdmi-phy@1ef0000 {
+			compatible = "allwinner,sun8i-h3-hdmi-phy";
+			reg = <0x01ef0000 0x10000>;
+			clocks = <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_DDC>,
+				 <&ccu 6>;
+			clock-names = "bus", "mod", "pll-0";
+			resets = <&ccu RST_BUS_HDMI0>;
+			reset-names = "phy";
+			#phy-cells = <0>;
+		};
+
 		rtc: rtc@1f00000 {
 			compatible = "allwinner,sun6i-a31-rtc";
 			reg = <0x01f00000 0x54>;
-- 
2.16.2
