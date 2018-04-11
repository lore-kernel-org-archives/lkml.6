Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753821AbeDKOVq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:21:46 -0400
Received: from hermes.aosc.io ([199.195.250.187]:48433 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752846AbeDKOVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:21:44 -0400
From: Icenowy Zheng <icenowy@aosc.io>
To: Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 5/5] arm64: allwinner: a64: add SRAM controller device tree node
Date: Wed, 11 Apr 2018 22:16:41 +0800
Message-Id: <20180411141641.14675-6-icenowy@aosc.io>
In-Reply-To: <20180411141641.14675-1-icenowy@aosc.io>
References: <20180411141641.14675-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner A64 has a SRAM controller, and in the device tree currently
we have a syscon node to enable EMAC driver to access the EMAC clock
register. As SRAM controller driver can now export regmap for this
register, replace the syscon node to the SRAM controller device node,
and let EMAC driver to acquire its EMAC clock regmap.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 1b2ef28c42bd..1c37659d9d41 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -168,10 +168,25 @@
 		#size-cells = <1>;
 		ranges;
 
-		syscon: syscon@1c00000 {
-			compatible = "allwinner,sun50i-a64-system-controller",
-				"syscon";
+		sram_controller: sram-controller@1c00000 {
+			compatible = "allwinner,sun50i-a64-sram-controller";
 			reg = <0x01c00000 0x1000>;
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
 		};
 
 		dma: dma-controller@1c02000 {
@@ -599,7 +614,7 @@
 
 		emac: ethernet@1c30000 {
 			compatible = "allwinner,sun50i-a64-emac";
-			syscon = <&syscon>;
+			syscon = <&sram_controller>;
 			reg = <0x01c30000 0x10000>;
 			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
-- 
2.15.1
