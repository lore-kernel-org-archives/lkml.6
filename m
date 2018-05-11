Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeEKT1E (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 15:27:04 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:48447 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbeEKT07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 15:26:59 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
To: <ssantosh@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [linux-next PATCH 3/4] ARM: dts: keystone-k2g-ice: Enable netcp network driver
Date: Fri, 11 May 2018 15:29:11 -0400
Message-ID: <1526066952-5230-4-git-send-email-m-karicheri2@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526066952-5230-1-git-send-email-m-karicheri2@ti.com>
References: <1526066952-5230-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds dt bindings to enable netcp network driver on K2G
ICE boards. This consists of enabling bindings for NSS qmss, pktdma,
2u ethss, mdio, pinmux and netcp devices as well as DP83867 phy.

EVM hardware spec recommends to add 0.25 nsec delay in the tx direction
and 2.25 nsec delay in the rx direction for internal delay in the clock
path to be on the safer side.

The board straps RX_DV/RX_CTRL pin of on board DP83867 phy in mode 1.
The phy data manual disallows this. Add ti,dp83867-rxctrl-strap-quirk
in the phy node to allow software to enable the workaround suggested for
this incorrect strap setting. This ensures proper operation of this PHY.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 arch/arm/boot/dts/keystone-k2g-ice.dts | 59 ++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g-ice.dts b/arch/arm/boot/dts/keystone-k2g-ice.dts
index d820ed2..2a2d38c 100644
--- a/arch/arm/boot/dts/keystone-k2g-ice.dts
+++ b/arch/arm/boot/dts/keystone-k2g-ice.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include "keystone-k2g.dtsi"
+#include <dt-bindings/net/ti-dp83867.h>
 
 / {
 	compatible = "ti,k2g-ice", "ti,k2g", "ti,keystone";
@@ -281,6 +282,30 @@
 			K2G_CORE_IOPAD(0x11bc) (BUFFER_CLASS_B | PIN_PULLUP | MUX_MODE3)	/* spi2_scsn1.gpio0_102 */
 		>;
 	};
+
+	emac_pins: pinmux_emac_pins {
+		pinctrl-single,pins = <
+			K2G_CORE_IOPAD(0x113C) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_RXD1.RGMII_RXD1 */
+			K2G_CORE_IOPAD(0x1138) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_RXD2.RGMII_RXD2 */
+			K2G_CORE_IOPAD(0x1134) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_RXD3.RGMII_RXD3 */
+			K2G_CORE_IOPAD(0x1140) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_RXD0.RGMII_RXD0 */
+			K2G_CORE_IOPAD(0x1178) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_TXD0.RGMII_TXD0 */
+			K2G_CORE_IOPAD(0x1174) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_TXD1.RGMII_TXD1 */
+			K2G_CORE_IOPAD(0x1170) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_TXD2.RGMII_TXD2 */
+			K2G_CORE_IOPAD(0x116C) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_TXD3.RGMII_TXD3 */
+			K2G_CORE_IOPAD(0x1154) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_TXCLK.RGMII_TXC */
+			K2G_CORE_IOPAD(0x117C) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_TXEN.RGMII_TXCTL */
+			K2G_CORE_IOPAD(0x1120) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_RXCLK.RGMII_RXC */
+			K2G_CORE_IOPAD(0x1144) (BUFFER_CLASS_D | PULL_DISABLE | MUX_MODE1)	/* MII_RXDV.RGMII_RXCTL */
+		>;
+	};
+
+	mdio_pins: pinmux_mdio_pins {
+		pinctrl-single,pins = <
+			K2G_CORE_IOPAD(0x118C) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0)	/* MDIO_CLK.MDIO_CLK */
+			K2G_CORE_IOPAD(0x1188) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0)	/* MDIO_DATA.MDIO_DATA */
+		>;
+	};
 };
 
 &uart0 {
@@ -386,3 +411,37 @@
 		vcc-supply = <&vdd_3v3>;
 	};
 };
+
+&qmss {
+	status = "okay";
+};
+
+&knav_dmas {
+	status = "okay";
+};
+
+&netcp {
+	pinctrl-names = "default";
+	pinctrl-0 = <&emac_pins>;
+	status = "okay";
+};
+
+&mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mdio_pins>;
+	status = "okay";
+	ethphy0: ethernet-phy@0 {
+		reg = <0>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
+		ti,tx-internal-delay = <DP83867_RGMIIDCTL_250_PS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_8_B_NIB>;
+		ti,min-output-impedance;
+		ti,dp83867-rxctrl-strap-quirk;
+	};
+};
+
+&gbe0 {
+	phy-handle = <&ethphy0>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+};
-- 
1.9.1
