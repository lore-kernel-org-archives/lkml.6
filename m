Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753346AbeCPR4U (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 13:56:20 -0400
Received: from hermes.aosc.io ([199.195.250.187]:52813 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751829AbeCPR4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 13:56:18 -0400
From: Icenowy Zheng <icenowy@aosc.io>
To: Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 5/7] arm64: allwinner: a64: add DE2 CCU related device tree nodes
Date: Sat, 17 Mar 2018 01:53:52 +0800
Message-Id: <20180316175354.21437-6-icenowy@aosc.io>
In-Reply-To: <20180316175354.21437-1-icenowy@aosc.io>
References: <20180316175354.21437-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we have all necessary parts to enable the DE2 CCU on the Allwinner
A64 SoC, add the needed device tree nodes, including the SRAM controller
node, SRAM C node, DE2 bus node and DE2 CCU node.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 42 +++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 1b6dc31e7d91..1f92015503ea 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -148,6 +148,48 @@
 		#size-cells = <1>;
 		ranges;
 
+		de2@1000000 {
+			compatible = "allwinner,sun50i-a64-de2";
+			reg = <0x1000000 0x400000>;
+			allwinner,sram = <&de2_sram 1>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x1000000 0x400000>;
+
+			display_clocks: clock@0 {
+				compatible = "allwinner,sun50i-a64-de2-clk";
+				reg = <0x0 0x100000>;
+				clocks = <&ccu CLK_DE>,
+					 <&ccu CLK_BUS_DE>;
+				clock-names = "mod",
+					      "bus";
+				resets = <&ccu RST_BUS_DE>;
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
+		};
+
+		sram-controller@1c00000 {
+			compatible = "allwinner,sun50i-a64-sram-controller";
+			reg = <0x01c00000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			sram_c: sram@18000 {
+				compatible = "mmio-sram";
+				reg = <0x00018000 0x28000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x00018000 0x28000>;
+
+				de2_sram: sram-section@0 {
+					compatible = "allwinner,sun50i-a64-sram-c";
+					reg = <0x0000 0x28000>;
+				};
+			};
+		};
+
 		syscon: syscon@1c00000 {
 			compatible = "allwinner,sun50i-a64-system-controller",
 				"syscon";
-- 
2.15.1
