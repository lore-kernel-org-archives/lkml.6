Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752097AbeEDOCK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:02:10 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60436 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751917AbeEDOAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 10:00:16 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net, kishon@ti.com, linux@armlinux.org.uk,
        gregory.clement@bootlin.com, andrew@lunn.ch, jason@lakedaemon.net,
        sebastian.hesselbarth@gmail.com
Cc: Russell King <rmk+kernel@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com, linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>
Subject: [PATCH net-next v2 10/13] arm64: dts: marvell: mcbin: add 10G SFP support
Date: Fri,  4 May 2018 15:56:40 +0200
Message-Id: <20180504135643.23466-11-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180504135643.23466-1-antoine.tenart@bootlin.com>
References: <20180504135643.23466-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

This patch adds the SFP cage description in the Marvell Armada 8040
mcbin, for both 10G interfaces.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
[Antoine: small reworks, commit message]
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 .../boot/dts/marvell/armada-8040-mcbin.dts    | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
index 81de03ef860d..eaa67de8c2bb 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
@@ -64,6 +64,30 @@
 		compatible = "usb-nop-xceiv";
 		vcc-supply = <&v_5v0_usb3_hst_vbus>;
 	};
+
+	sfp_eth0: sfp-eth0 {
+		/* CON15,16 - CPM lane 4 */
+		compatible = "sff,sfp";
+		i2c-bus = <&sfpp0_i2c>;
+		los-gpio = <&cp1_gpio1 28 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpio = <&cp1_gpio1 27 GPIO_ACTIVE_LOW>;
+		tx-disable-gpio = <&cp1_gpio1 29 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpio  = <&cp1_gpio1 26 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cp1_sfpp0_pins>;
+	};
+
+	sfp_eth1: sfp-eth1 {
+		/* CON17,18 - CPS lane 4 */
+		compatible = "sff,sfp";
+		i2c-bus = <&sfpp1_i2c>;
+		los-gpio = <&cp1_gpio1 8 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpio = <&cp1_gpio1 11 GPIO_ACTIVE_LOW>;
+		tx-disable-gpio = <&cp1_gpio1 10 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpio = <&cp0_gpio2 30 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cp1_sfpp1_pins &cp0_sfpp1_pins>;
+	};
 };
 
 &uart0 {
@@ -180,6 +204,10 @@
 			       "mpp60", "mpp61";
 		marvell,function = "sdio";
 	};
+	cp0_sfpp1_pins: sfpp1-pins {
+		marvell,pins = "mpp62";
+		marvell,function = "gpio";
+	};
 };
 
 &cp0_xmdio {
@@ -188,11 +216,13 @@
 	phy0: ethernet-phy@0 {
 		compatible = "ethernet-phy-ieee802.3-c45";
 		reg = <0>;
+		sfp = <&sfp_eth0>;
 	};
 
 	phy8: ethernet-phy@8 {
 		compatible = "ethernet-phy-ieee802.3-c45";
 		reg = <8>;
+		sfp = <&sfp_eth1>;
 	};
 };
 
@@ -258,6 +288,10 @@
 };
 
 &cp1_pinctrl {
+	cp1_sfpp1_pins: sfpp1-pins {
+		marvell,pins = "mpp8", "mpp10", "mpp11";
+		marvell,function = "gpio";
+	};
 	cp1_spi1_pins: spi1-pins {
 		marvell,pins = "mpp12", "mpp13", "mpp14", "mpp15", "mpp16";
 		marvell,function = "spi1";
@@ -266,6 +300,10 @@
 		marvell,pins = "mpp6", "mpp7";
 		marvell,function = "uart0";
 	};
+	cp1_sfpp0_pins: sfpp0-pins {
+		marvell,pins = "mpp26", "mpp27", "mpp28", "mpp29";
+		marvell,function = "gpio";
+	};
 };
 
 /* J27 UART header */
-- 
2.17.0
