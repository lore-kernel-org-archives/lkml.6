Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751909AbeBWKT4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:19:56 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:28937 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751586AbeBWKQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:16:55 -0500
X-UUID: 1311f815ed0741a88a14381b1d276f0f-20180223
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 18/19] arm: dts: mt7623: add MT7623A reference boards
Date: Fri, 23 Feb 2018 18:16:38 +0800
Message-ID: <ddffdff293734954ba368be8a54edd3c84a4f4e6.1519378872.git.sean.wang@mediatek.com>
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

Add mt7623a-rfb.dtsi where most nodes can be inherited from
mt7623n-rfb.dtsi and keep these distinctions from MT7623A boards in
mt7623a-rfb.dtsi for most definition can be reused among MT7623A board
variants.

MT7623A has its specific definition of power domain and thus we need
to change related devices such as audio, ethernet, crypto, high-speed
DMA, NAND, and USB controller to the power domain they specifically
belong to. In addition, MT7530 exists as built-in module inside MT7623A
SoC and I2C2 and UART[0-1] get being removed and UART2 have distinct pin
usage. Those all differences can be totally seen in mt7623a-rfb.dtsi.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm/boot/dts/Makefile             |  2 +
 arch/arm/boot/dts/mt7623a-rfb-emmc.dts | 22 +++++++++
 arch/arm/boot/dts/mt7623a-rfb-nand.dts | 26 +++++++++++
 arch/arm/boot/dts/mt7623a-rfb.dtsi     | 84 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/mt7623n-rfb.dtsi     | 15 ++++++
 5 files changed, 149 insertions(+)
 create mode 100644 arch/arm/boot/dts/mt7623a-rfb-emmc.dts
 create mode 100644 arch/arm/boot/dts/mt7623a-rfb-nand.dts
 create mode 100644 arch/arm/boot/dts/mt7623a-rfb.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 5af6fce..818817c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1122,6 +1122,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt6580-evbp1.dtb \
 	mt6589-aquaris5.dtb \
 	mt6592-evb.dtb \
+	mt7623a-rfb-emmc.dtb \
+	mt7623a-rfb-nand.dtb \
 	mt7623n-rfb-emmc.dtb \
 	mt7623n-rfb-nand.dtb \
 	mt7623n-bananapi-bpi-r2.dtb \
diff --git a/arch/arm/boot/dts/mt7623a-rfb-emmc.dts b/arch/arm/boot/dts/mt7623a-rfb-emmc.dts
new file mode 100644
index 0000000..ef6398e
--- /dev/null
+++ b/arch/arm/boot/dts/mt7623a-rfb-emmc.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2017-2018 MediaTek Inc.
+ * Author: Sean Wang <sean.wang@mediatek.com>
+ *
+ */
+
+/dts-v1/;
+#include "mt7623a-rfb.dtsi"
+
+/ {
+	model = "MediaTek MT7623A with eMMC reference board";
+	compatible = "mediatek,mt7623a-rfb-emmc", "mediatek,mt7623";
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 earlyprintk";
+	};
+};
+
+&mmc0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/mt7623a-rfb-nand.dts b/arch/arm/boot/dts/mt7623a-rfb-nand.dts
new file mode 100644
index 0000000..592d5d7
--- /dev/null
+++ b/arch/arm/boot/dts/mt7623a-rfb-nand.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2017-2018 MediaTek Inc.
+ * Author: Sean Wang <sean.wang@mediatek.com>
+ *
+ */
+
+/dts-v1/;
+#include "mt7623a-rfb.dtsi"
+
+/ {
+	model = "MediaTek MT7623A with NAND reference board";
+	compatible = "mediatek,mt7623a-rfb-nand", "mediatek,mt7623";
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 earlyprintk";
+	};
+};
+
+&bch {
+	status = "okay";
+};
+
+&nandc {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/mt7623a-rfb.dtsi b/arch/arm/boot/dts/mt7623a-rfb.dtsi
new file mode 100644
index 0000000..3a15c46
--- /dev/null
+++ b/arch/arm/boot/dts/mt7623a-rfb.dtsi
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2017-2018 MediaTek Inc.
+ * Author: Sean Wang <sean.wang@mediatek.com>
+ *
+ */
+
+/dts-v1/;
+#include <dt-bindings/power/mt7623a-power.h>
+#include "mt7623n-rfb.dtsi"
+
+/ {
+	memory {
+		device_type = "memory";
+		reg = <0 0x80000000 0 0x20000000>;
+	};
+};
+
+&afe {
+	power-domains = <&scpsys MT7623A_POWER_DOMAIN_IFR_MSC>;
+};
+
+&cir {
+	status = "disabled";
+};
+
+&crypto {
+	power-domains = <&scpsys MT7623A_POWER_DOMAIN_ETH>;
+};
+
+&eth {
+	power-domains = <&scpsys MT7623A_POWER_DOMAIN_ETH>;
+};
+
+&hsdma {
+	power-domains = <&scpsys MT7623A_POWER_DOMAIN_ETH>;
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins_b>;
+};
+
+&mt7530 {
+	mediatek,mcm;
+	resets = <&ethsys MT2701_ETHSYS_MCM_RST>;
+	reset-names = "mcm";
+};
+
+&nandc {
+	power-domains = <&scpsys MT7623A_POWER_DOMAIN_IFR_MSC>;
+};
+
+&pcie {
+	power-domains = <&scpsys MT7623A_POWER_DOMAIN_HIF>;
+};
+
+&scpsys {
+	compatible = "mediatek,mt7623a-scpsys",
+		     "syscon";
+	clocks = <&topckgen CLK_TOP_ETHIF_SEL>;
+	clock-names = "ethif";
+};
+
+&uart0 {
+	status = "disabled";
+};
+
+&uart1 {
+	status = "disabled";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins_b>;
+};
+
+&usb1 {
+	power-domains = <&scpsys MT7623A_POWER_DOMAIN_HIF>;
+};
+
+&usb2 {
+	power-domains = <&scpsys MT7623A_POWER_DOMAIN_HIF>;
+};
diff --git a/arch/arm/boot/dts/mt7623n-rfb.dtsi b/arch/arm/boot/dts/mt7623n-rfb.dtsi
index 0237476..07ed15d 100644
--- a/arch/arm/boot/dts/mt7623n-rfb.dtsi
+++ b/arch/arm/boot/dts/mt7623n-rfb.dtsi
@@ -380,6 +380,14 @@
 		};
 	};
 
+	i2c2_pins_b: i2c2-alt {
+		pin-i2c2 {
+			pinmux = <MT7623_PIN_122_GPIO122_FUNC_SDA2>,
+				 <MT7623_PIN_123_HTPLG_FUNC_SCL2>;
+			bias-disable;
+		};
+	};
+
 	i2s0_pins_a: i2s0-default {
 		pin-i2s0 {
 			pinmux = <MT7623_PIN_49_I2S0_DATA_FUNC_I2S0_DATA>,
@@ -629,6 +637,13 @@
 				 <MT7623_PIN_15_GPIO15_FUNC_UTXD2>;
 		};
 	};
+
+	uart2_pins_b: uart2-alt {
+		pins-dat {
+			pinmux = <MT7623_PIN_200_URXD2_FUNC_URXD2>,
+				 <MT7623_PIN_201_UTXD2_FUNC_UTXD2>;
+		};
+	};
 };
 
 &pwm {
-- 
2.7.4
