Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752753AbeBFJxk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 04:53:40 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:26363 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752532AbeBFJxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 04:53:18 -0500
X-UUID: 29d4de5f1a4a4dfba778bbb393e4c072-20180206
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH v2 02/16] arm64: dts: mt7622: add clock controller device nodes
Date: Tue, 6 Feb 2018 17:52:51 +0800
Message-ID: <1ecd697e189a0a9c202e5792f931e510b35b746b.1517910489.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1517910489.git.sean.wang@mediatek.com>
References: <cover.1517910489.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add clock controller nodes for MT7622 and include header for topckgen,
infracfg, pericfg, apmixedsys, ethsys, sgmiisys, pciesys and ssusbsys
for those devices nodes to be added afterwards.

In addition, provides an oscillator node for the source of PLLs and dummy
clock for PWARP to complement missing support of clock gate for the
wrapper circuit in the driver.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 76 ++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index b111fec..73e5d62 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -8,6 +8,8 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/mt7622-clk.h>
+#include <dt-bindings/reset/mt7622-reset.h>
 
 / {
 	compatible = "mediatek,mt7622";
@@ -48,6 +50,19 @@
 		clock-frequency = <280000000>;
 	};
 
+	pwrap_clk: dummy40m {
+		compatible = "fixed-clock";
+		clock-frequency = <40000000>;
+		#clock-cells = <0>;
+	};
+
+	clk25m: oscillator {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+		clock-output-names = "clkxtal";
+	};
+
 	psci {
 		compatible  = "arm,psci-0.2";
 		method      = "smc";
@@ -78,6 +93,22 @@
 			      IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	infracfg: infracfg@10000000 {
+		compatible = "mediatek,mt7622-infracfg",
+			     "syscon";
+		reg = <0 0x10000000 0 0x1000>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+	};
+
+	pericfg: pericfg@10002000 {
+		compatible = "mediatek,mt7622-pericfg",
+			     "syscon";
+		reg = <0 0x10002000 0 0x1000>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+	};
+
 	sysirq: interrupt-controller@10200620 {
 		compatible = "mediatek,mt7622-sysirq",
 			     "mediatek,mt6577-sysirq";
@@ -87,6 +118,20 @@
 		reg = <0 0x10200620 0 0x20>;
 	};
 
+	apmixedsys: apmixedsys@10209000 {
+		compatible = "mediatek,mt7622-apmixedsys",
+			     "syscon";
+		reg = <0 0x10209000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
+	topckgen: topckgen@10210000 {
+		compatible = "mediatek,mt7622-topckgen",
+			     "syscon";
+		reg = <0 0x10210000 0 0x1000>;
+		#clock-cells = <1>;
+	};
+
 	gic: interrupt-controller@10300000 {
 		compatible = "arm,gic-400";
 		interrupt-controller;
@@ -107,4 +152,35 @@
 		clock-names = "baud", "bus";
 		status = "disabled";
 	};
+
+	ssusbsys: ssusbsys@1a000000 {
+		compatible = "mediatek,mt7622-ssusbsys",
+			     "syscon";
+		reg = <0 0x1a000000 0 0x1000>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+	};
+
+	pciesys: pciesys@1a100800 {
+		compatible = "mediatek,mt7622-pciesys",
+			     "syscon";
+		reg = <0 0x1a100800 0 0x1000>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+	};
+
+	ethsys: syscon@1b000000 {
+		compatible = "mediatek,mt7622-ethsys",
+			     "syscon";
+		reg = <0 0x1b000000 0 0x1000>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+	};
+
+	sgmiisys: sgmiisys@1b128000 {
+		compatible = "mediatek,mt7622-sgmiisys",
+			     "syscon";
+		reg = <0 0x1b128000 0 0x1000>;
+		#clock-cells = <1>;
+	};
 };
-- 
2.7.4
