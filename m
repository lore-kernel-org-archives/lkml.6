Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753127AbeDKI6B (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 04:58:01 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:32951 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752140AbeDKIyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 04:54:15 -0400
X-UUID: 821c23e144dc4b558808f36223761c7a-20180411
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 06/12] arm: dts: mt7623: add BTIF, HSDMA and SPI-NOR device nodes
Date: Wed, 11 Apr 2018 16:53:59 +0800
Message-ID: <39294f68b1f9e65341f94a989347da81a26c878d.1523434758.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1523434757.git.sean.wang@mediatek.com>
References: <cover.1523434757.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

add BTIF, HSDMA and SPI-NOR device nodes and enable it on relevant boards

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm/boot/dts/mt7623.dtsi                 | 36 ++++++++++++++++++++++++++-
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts |  6 ++++-
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index b9b5619..8cf3d26 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2017 MediaTek Inc.
+ * Copyright (c) 2017-2018 MediaTek Inc.
  * Author: John Crispin <john@phrozen.org>
  *	   Sean Wang <sean.wang@mediatek.com>
  *
@@ -486,6 +486,18 @@
 		nvmem-cell-names = "calibration-data";
 	};
 
+	btif: serial@1100c000 {
+		compatible = "mediatek,mt7623-btif",
+			     "mediatek,mtk-btif";
+		reg = <0 0x1100c000 0 0x1000>;
+		interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_BTIF>;
+		clock-names = "main";
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+
 	nandc: nfi@1100d000 {
 		compatible = "mediatek,mt7623-nfc",
 			     "mediatek,mt2701-nfc";
@@ -511,6 +523,18 @@
 		status = "disabled";
 	};
 
+	nor_flash: spi@11014000 {
+		compatible = "mediatek,mt7623-nor",
+			     "mediatek,mt8173-nor";
+		reg = <0 0x11014000 0 0x1000>;
+		clocks = <&pericfg CLK_PERI_FLASH>,
+			 <&topckgen CLK_TOP_FLASH_SEL>;
+		clock-names = "spi", "sf";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	spi1: spi@11016000 {
 		compatible = "mediatek,mt7623-spi",
 			     "mediatek,mt2701-spi";
@@ -867,6 +891,16 @@
 		#reset-cells = <1>;
 	};
 
+	hsdma: dma-controller@1b007000 {
+		compatible = "mediatek,mt7623-hsdma";
+		reg = <0 0x1b007000 0 0x1000>;
+		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&ethsys CLK_ETHSYS_HSDMA>;
+		clock-names = "hsdma";
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_ETH>;
+		#dma-cells = <1>;
+	};
+
 	eth: ethernet@1b100000 {
 		compatible = "mediatek,mt7623-eth",
 			     "mediatek,mt2701-eth",
diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
index 71023a6..1fd6f55 100644
--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -1,5 +1,5 @@
 /*
- * Copyright 2017 Sean Wang <sean.wang@mediatek.com>
+ * Copyright 2017-2018 Sean Wang <sean.wang@mediatek.com>
  *
  * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
@@ -114,6 +114,10 @@
 	};
 };
 
+&btif {
+	status = "okay";
+};
+
 &cir {
 	pinctrl-names = "default";
 	pinctrl-0 = <&cir_pins_a>;
-- 
2.7.4
