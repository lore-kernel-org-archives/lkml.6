Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbeEDOA1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:00:27 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60513 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751572AbeEDOAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 10:00:23 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net, kishon@ti.com, linux@armlinux.org.uk,
        gregory.clement@bootlin.com, andrew@lunn.ch, jason@lakedaemon.net,
        sebastian.hesselbarth@gmail.com
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v2 11/13] arm64: dts: marvell: mcbin: enable the fourth network interface
Date: Fri,  4 May 2018 15:56:41 +0200
Message-Id: <20180504135643.23466-12-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180504135643.23466-1-antoine.tenart@bootlin.com>
References: <20180504135643.23466-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the fourth network interface on the Marvell
Macchiatobin. It is configured in the 2500Base-X PHY mode. The SFP cage
is also described.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 .../boot/dts/marvell/armada-8040-mcbin.dts    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
index eaa67de8c2bb..a66958ff4de6 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
@@ -27,6 +27,7 @@
 		ethernet0 = &cp0_eth0;
 		ethernet1 = &cp1_eth0;
 		ethernet2 = &cp1_eth1;
+		ethernet3 = &cp1_eth2;
 	};
 
 	/* Regulator labels correspond with schematics */
@@ -88,6 +89,18 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&cp1_sfpp1_pins &cp0_sfpp1_pins>;
 	};
+
+	sfp_eth3: sfp-eth3 {
+		/* CON3,4 - CPS lane 5 */
+		compatible = "sff,sfp";
+		i2c-bus = <&sfp_1g_i2c>;
+		los-gpio = <&cp0_gpio2 22 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpio = <&cp0_gpio2 21 GPIO_ACTIVE_LOW>;
+		tx-disable-gpio = <&cp1_gpio1 24 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpio = <&cp0_gpio2 19 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cp0_sfp_1g_pins &cp1_sfp_1g_pins>;
+	};
 };
 
 &uart0 {
@@ -195,6 +208,10 @@
 		marvell,pins = "mpp47";
 		marvell,function = "gpio";
 	};
+	cp0_sfp_1g_pins: sfp-1g-pins {
+		marvell,pins = "mpp51", "mpp53", "mpp54";
+		marvell,function = "gpio";
+	};
 	cp0_pcie_pins: pcie-pins {
 		marvell,pins = "mpp52";
 		marvell,function = "gpio";
@@ -287,6 +304,17 @@
 	phys = <&cp1_comphy0 1>;
 };
 
+&cp1_eth2 {
+	/* CPS Lane 5 */
+	status = "okay";
+	/* Network PHY */
+	phy-mode = "2500base-x";
+	managed = "in-band-status";
+	/* Generic PHY, providing serdes lanes */
+	phys = <&cp1_comphy5 2>;
+	sfp = <&sfp_eth3>;
+};
+
 &cp1_pinctrl {
 	cp1_sfpp1_pins: sfpp1-pins {
 		marvell,pins = "mpp8", "mpp10", "mpp11";
@@ -300,6 +328,10 @@
 		marvell,pins = "mpp6", "mpp7";
 		marvell,function = "uart0";
 	};
+	cp1_sfp_1g_pins: sfp-1g-pins {
+		marvell,pins = "mpp24";
+		marvell,function = "gpio";
+	};
 	cp1_sfpp0_pins: sfpp0-pins {
 		marvell,pins = "mpp26", "mpp27", "mpp28", "mpp29";
 		marvell,function = "gpio";
-- 
2.17.0
