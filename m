Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754059AbeBBSIj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 13:08:39 -0500
Received: from hermes.aosc.io ([199.195.250.187]:54901 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753939AbeBBSFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 13:05:50 -0500
From: Icenowy Zheng <icenowy@aosc.io>
To: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        "David S . Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 2/3] ARM: sun8i: v3s: add V3s EMAC device tree node
Date: Sat,  3 Feb 2018 02:04:55 +0800
Message-Id: <20180202180456.60378-3-icenowy@aosc.io>
In-Reply-To: <20180202180456.60378-1-icenowy@aosc.io>
References: <20180202180456.60378-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The V3/V3s EMAC is just similar to the one in H3 SoC, but as the package
of V3s is pin-limited, the external MII/MDIO bus is not wired out.

Add V3s EMAC device tree node. As V3s is only capable of using the
internal PHY, it's hardcoded in the V3s DTSI file.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun8i-v3s.dtsi | 55 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index 443b083c6adc..4d49a8b22a1c 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -141,6 +141,12 @@
 			};
 		};
 
+		syscon: syscon@1c00000 {
+			compatible = "allwinner,sun8i-v3-system-controller",
+				"syscon";
+			reg = <0x01c00000 0x1000>;
+		};
+
 		tcon0: lcd-controller@1c0c000 {
 			compatible = "allwinner,sun8i-v3s-tcon";
 			reg = <0x01c0c000 0x1000>;
@@ -402,6 +408,55 @@
 			#size-cells = <0>;
 		};
 
+		emac: ethernet@1c30000 {
+			compatible = "allwinner,sun8i-v3-emac";
+			syscon = <&syscon>;
+			reg = <0x01c30000 0x10000>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			resets = <&ccu RST_BUS_EMAC>;
+			reset-names = "stmmaceth";
+			clocks = <&ccu CLK_BUS_EMAC>;
+			clock-names = "stmmaceth";
+			phy-handle = <&int_mii_phy>;
+			phy-mode = "mii";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			mdio: mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "snps,dwmac-mdio";
+			};
+
+			mdio-mux {
+				compatible = "allwinner,sun8i-v3-mdio-mux",
+					     "allwinner,sun8i-h3-mdio-mux";
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				mdio-parent-bus = <&mdio>;
+
+				internal_mdio: mdio@1 {
+					compatible = "allwinner,sun8i-v3-mdio-internal",
+						     "allwinner,sun8i-h3-mdio-internal";
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					int_mii_phy: ethernet-phy@1 {
+						compatible = "ethernet-phy-ieee802.3-c22";
+						reg = <1>;
+						clocks = <&ccu CLK_BUS_EPHY>;
+						resets = <&ccu RST_BUS_EPHY>;
+					};
+				};
+
+				/* V3s has no external MDIO bus, but V3 has it */
+			};
+		};
+
 		spi0: spi@1c68000 {
 			compatible = "allwinner,sun8i-h3-spi";
 			reg = <0x01c68000 0x1000>;
-- 
2.15.1
