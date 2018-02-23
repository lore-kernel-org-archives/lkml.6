Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751891AbeBWKTi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:19:38 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:10528 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751591AbeBWKQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:16:56 -0500
X-UUID: c1ecbed8b3ec497f88d423022569279e-20180223
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 15/19] arm: dts: mt7623: add SPI[1,2], I2C2 and sound related nodes to reference board
Date: Fri, 23 Feb 2018 18:16:35 +0800
Message-ID: <44a792abe2a6fddc21a01e18a90fa21e194c9f87.1519378872.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1519378871.git.sean.wang@mediatek.com>
References: <cover.1519378871.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

There are SPI[1,2] and I2C2 and sound device with WM8960 codec which
MT7623 reference board is equipped with.

However, some of those devices cannot be found on bananapi-r2, they should
be disabled properly for that.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 16 ++++++++
 arch/arm/boot/dts/mt7623n-rfb.dtsi            | 58 +++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
index 373a0dd..140ff78 100644
--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -40,6 +40,10 @@
 	};
 };
 
+&afe {
+	status = "disabled";
+};
+
 &i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c1_pins_a>;
@@ -79,6 +83,14 @@
 	};
 };
 
+&sound {
+	status = "disabled";
+};
+
+&spi1 {
+	status = "disabled";
+};
+
 &usb2 {
 	status = "okay";
 };
@@ -86,3 +98,7 @@
 &u3phy2 {
 	status = "okay";
 };
+
+&wm8960 {
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/mt7623n-rfb.dtsi b/arch/arm/boot/dts/mt7623n-rfb.dtsi
index b9e3b3d..0237476 100644
--- a/arch/arm/boot/dts/mt7623n-rfb.dtsi
+++ b/arch/arm/boot/dts/mt7623n-rfb.dtsi
@@ -96,6 +96,23 @@
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	sound:sound {
+		compatible = "mediatek,mt2701-wm8960-machine";
+		mediatek,platform = <&afe>;
+		audio-routing =
+			"Headphone", "HP_L",
+			"Headphone", "HP_R",
+			"LINPUT1", "AMIC",
+			"RINPUT1", "AMIC";
+		mediatek,audio-codec = <&wm8960>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2s0_pins_a>;
+	};
+};
+
+&afe {
+	status = "okay";
 };
 
 &bch {
@@ -199,6 +216,17 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c1_pins_b>;
 	status = "okay";
+
+	wm8960: wm8960@1a {
+		compatible = "wlf,wm8960";
+		reg = <0x1a>;
+	};
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins_a>;
+	status = "okay";
 };
 
 &mmc0 {
@@ -563,6 +591,24 @@
 		};
 	};
 
+	spi1_pins_a: spi1-default {
+		pins-spi {
+			pinmux = <MT7623_PIN_7_SPI1_CSN_FUNC_SPI1_CS>,
+				<MT7623_PIN_199_SPI1_CK_FUNC_SPI1_CK>,
+				<MT7623_PIN_8_SPI1_MI_FUNC_SPI1_MI>,
+				<MT7623_PIN_9_SPI1_MO_FUNC_SPI1_MO>;
+		};
+	};
+
+	spi2_pins_a: spi2-default {
+		pins-spi {
+			pinmux = <MT7623_PIN_101_SPI2_CSN_FUNC_SPI2_CS>,
+				<MT7623_PIN_104_SPI2_CK_FUNC_SPI2_CK>,
+				<MT7623_PIN_102_SPI2_MI_FUNC_SPI2_MI>,
+				<MT7623_PIN_103_SPI2_MO_FUNC_SPI2_MO>;
+		};
+	};
+
 	uart0_pins_a: uart0-default {
 		pins-dat {
 			pinmux = <MT7623_PIN_79_URXD0_FUNC_URXD0>,
@@ -597,6 +643,18 @@
 	status = "okay";
 };
 
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi1_pins_a>;
+	status = "okay";
+};
+
+&spi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi2_pins_a>;
+	status = "disabled";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.7.4
