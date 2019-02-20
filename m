Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687F1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309E52147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfBTIu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:50:57 -0500
Received: from inva021.nxp.com ([92.121.34.21]:43686 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbfBTIu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:50:56 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 968C8200309;
        Wed, 20 Feb 2019 09:50:54 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C1299200145;
        Wed, 20 Feb 2019 09:50:51 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 3136B402C9;
        Wed, 20 Feb 2019 16:50:48 +0800 (SGT)
From:   Alison Wang <alison.wang@nxp.com>
To:     shawnguo@kernel.org, leoyang.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     alison.wang@nxp.com
Subject: [PATCH v2] arm64: dts: ls1028a: Add Audio DT nodes
Date:   Wed, 20 Feb 2019 16:44:57 +0800
Message-Id: <20190220084457.31357-1-alison.wang@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds Audio DT nodes for LS1028ARDB and LS1028AQDS boards.

Signed-off-by: Alison Wang <alison.wang@nxp.com>
---
Changes in v2:
 - Modify some nodes' names.
 - Use GIC_SPI and IRQ_TYPE_LEVEL_HIGH.

 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts |   62 ++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts |   63 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi    |   57 +++++++++++++++++++
 3 files changed, 182 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
index 14c79f4..b359068 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
@@ -32,6 +32,49 @@
 		device_type = "memory";
 		reg = <0x0 0x80000000 0x1 0x00000000>;
 	};
+
+	sys_mclk: clock-mclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "1P8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,widgets =
+			"Microphone", "Microphone Jack",
+			"Headphone", "Headphone Jack",
+			"Speaker", "Speaker Ext",
+			"Line", "Line In Jack";
+		simple-audio-card,routing =
+			"MIC_IN", "Microphone Jack",
+			"Microphone Jack", "Mic Bias",
+			"LINE_IN", "Line In Jack",
+			"Headphone Jack", "HP_OUT",
+			"Speaker Ext", "LINE_OUT";
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai1>;
+			frame-master;
+			bitclock-master;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&sgtl5000>;
+			frame-master;
+			bitclock-master;
+			system-clock-frequency = <25000000>;
+		};
+	};
 };
 
 &duart0 {
@@ -89,5 +132,24 @@
 				reg = <0x57>;
 			};
 		};
+
+		i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x5>;
+
+			sgtl5000: audio-codec@a {
+				#sound-dai-cells = <0>;
+				compatible = "fsl,sgtl5000";
+				reg = <0xa>;
+				VDDA-supply = <&reg_1p8v>;
+				VDDIO-supply = <&reg_1p8v>;
+				clocks = <&sys_mclk>;
+			};
+		};
 	};
 };
+
+&sai1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index fdeb417..50ca51a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -28,6 +28,49 @@
 		device_type = "memory";
 		reg = <0x0 0x80000000 0x1 0x0000000>;
 	};
+
+	sys_mclk: clock-mclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "1P8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,widgets =
+			"Microphone", "Microphone Jack",
+			"Headphone", "Headphone Jack",
+			"Speaker", "Speaker Ext",
+			"Line", "Line In Jack";
+		simple-audio-card,routing =
+			"MIC_IN", "Microphone Jack",
+			"Microphone Jack", "Mic Bias",
+			"LINE_IN", "Line In Jack",
+			"Headphone Jack", "HP_OUT",
+			"Speaker Ext", "LINE_OUT";
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai4>;
+			frame-master;
+			bitclock-master;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&sgtl5000>;
+			frame-master;
+			bitclock-master;
+			system-clock-frequency = <25000000>;
+		};
+	};
 };
 
 &i2c0 {
@@ -39,6 +82,22 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x1>;
+
+			sgtl5000: audio-codec@a {
+				#sound-dai-cells = <0>;
+				compatible = "fsl,sgtl5000";
+				reg = <0xa>;
+				VDDA-supply = <&reg_1p8v>;
+				VDDIO-supply = <&reg_1p8v>;
+				clocks = <&sys_mclk>;
+				sclk-strength = <3>;
+			};
+		};
+
 		i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -71,3 +130,7 @@
 &duart1 {
 	status = "okay";
 };
+
+&sai4 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index a8cf92a..de590ec 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -335,5 +335,62 @@
 				     <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		edma0: dma-controller@22c0000 {
+			#dma-cells = <2>;
+			compatible = "fsl,vf610-edma";
+			reg = <0x0 0x22c0000 0x0 0x10000>,
+			      <0x0 0x22d0000 0x0 0x10000>,
+			      <0x0 0x22e0000 0x0 0x10000>;
+			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "edma-tx", "edma-err";
+			dma-channels = <32>;
+			clock-names = "dmamux0", "dmamux1";
+			clocks = <&clockgen 4 1>,
+				 <&clockgen 4 1>;
+		};
+
+		sai1: audio-controller@f100000 {
+			#sound-dai-cells = <0>;
+			compatible = "fsl,vf610-sai";
+			reg = <0x0 0xf100000 0x0 0x10000>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				 <&clockgen 4 1>, <&clockgen 4 1>;
+			clock-names = "bus", "mclk1", "mclk2", "mclk3";
+			dma-names = "tx", "rx";
+			dmas = <&edma0 1 4>,
+			       <&edma0 1 3>;
+			status = "disabled";
+		};
+
+		sai2: audio-controller@f110000 {
+			#sound-dai-cells = <0>;
+			compatible = "fsl,vf610-sai";
+			reg = <0x0 0xf110000 0x0 0x10000>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				 <&clockgen 4 1>, <&clockgen 4 1>;
+			clock-names = "bus", "mclk1", "mclk2", "mclk3";
+			dma-names = "tx", "rx";
+			dmas = <&edma0 1 6>,
+			       <&edma0 1 5>;
+			status = "disabled";
+		};
+
+		sai4: audio-controller@f130000 {
+			#sound-dai-cells = <0>;
+			compatible = "fsl,vf610-sai";
+			reg = <0x0 0xf130000 0x0 0x10000>;
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>,
+				 <&clockgen 4 1>, <&clockgen 4 1>;
+			clock-names = "bus", "mclk1", "mclk2", "mclk3";
+			dma-names = "tx", "rx";
+			dmas = <&edma0 1 10>,
+			       <&edma0 1 9>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.7.1

