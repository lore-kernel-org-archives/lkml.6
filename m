Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753426AbeBTRCs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 12:02:48 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:33973 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753197AbeBTRBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 12:01:38 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: arm@kernel.org, Jesper Nilsson <jespern@axis.com>,
        Lars Persson <larper@axis.com>, Niklas Cassel <niklass@axis.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@axis.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] ARM: dts: artpec: migrate ethernet to stmmac binding
Date: Tue, 20 Feb 2018 18:00:45 +0100
Message-Id: <20180220170049.22809-5-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180220170049.22809-1-niklas.cassel@axis.com>
References: <20180220170049.22809-1-niklas.cassel@axis.com>
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The snps,dwc-qos-ethernet binding is still supported as a glue layer
in the stmmac driver.
However, since the snps,dwc-qos-ethernet binding is now deprecated,
migrate to stmmac's native binding.

At the same time, enable features supported by the stmmac driver,
such as PTP, LPI, and an additional tx queue.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 arch/arm/boot/dts/artpec6-devboard.dts |  1 +
 arch/arm/boot/dts/artpec6.dtsi         | 42 ++++++++++++++++++++++++++++------
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/artpec6-devboard.dts b/arch/arm/boot/dts/artpec6-devboard.dts
index 502f3de6dc5b..d20d95359b28 100644
--- a/arch/arm/boot/dts/artpec6-devboard.dts
+++ b/arch/arm/boot/dts/artpec6-devboard.dts
@@ -59,6 +59,7 @@
 	mdio {
 		#address-cells = <0x1>;
 		#size-cells = <0x0>;
+		compatible = "snps,dwmac-mdio";
 		phy1: phy@0 {
 			compatible = "ethernet-phy-ieee802.3-c22";
 			device_type = "ethernet-phy";
diff --git a/arch/arm/boot/dts/artpec6.dtsi b/arch/arm/boot/dts/artpec6.dtsi
index f4b39738f1ac..981aecd27b0b 100644
--- a/arch/arm/boot/dts/artpec6.dtsi
+++ b/arch/arm/boot/dts/artpec6.dtsi
@@ -188,19 +188,47 @@
 		dma-ranges;
 
 		ethernet: ethernet@f8010000 {
-			clock-names = "phy_ref_clk", "apb_pclk";
-			clocks = <&eth_phy_ref_clk>,
-				<&clkctrl ARTPEC6_CLK_ETH_ACLK>;
-			compatible = "snps,dwc-qos-ethernet-4.10";
-			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "stmmaceth", "ptp_ref";
+			clocks = <&clkctrl ARTPEC6_CLK_ETH_ACLK>,
+				<&clkctrl ARTPEC6_CLK_PTP_REF>;
+			compatible = "snps,dwmac-4.10a", "snps,dwmac";
+			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq", "eth_lpi";
 			reg = <0xf8010000 0x4000>;
 
-			snps,write-requests = <2>;
-			snps,read-requests = <16>;
+			snps,axi-config = <&stmmac_axi_setup>;
+			snps,mtl-rx-config = <&mtl_rx_setup>;
+			snps,mtl-tx-config = <&mtl_tx_setup>;
+
 			snps,txpbl = <8>;
 			snps,rxpbl = <2>;
+			snps,aal;
+			snps,tso;
 
 			status = "disabled";
+
+			stmmac_axi_setup: stmmac-axi-config {
+				snps,wr_osr_lmt = <1>;
+				snps,rd_osr_lmt = <15>;
+				/* If FB is disabled, the AXI master chooses
+				 * a burst length of any value less than the
+				 * maximum enabled burst length
+				 * (all lesser burst length enables are redundant).
+				 */
+				snps,blen = <0 0 0 0 16 0 0>;
+			};
+
+			mtl_rx_setup: rx-queues-config {
+				snps,rx-queues-to-use = <1>;
+				queue0 {};
+			};
+
+			mtl_tx_setup: tx-queues-config {
+				snps,tx-queues-to-use = <2>;
+				queue0 {};
+				queue1 {};
+			};
 		};
 
 		uart0: serial@f8036000 {
-- 
2.14.2
