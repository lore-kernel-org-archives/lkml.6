Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90091C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0E720684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A0E720684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394264AbeKVVCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:02:40 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:48382 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394236AbeKVVCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:02:39 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 633FC5FD87; Thu, 22 Nov 2018 18:23:46 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v9 6/8] arm64: dts: allwinner: a64: add nodes necessary for analog sound support
Date:   Thu, 22 Nov 2018 18:23:23 +0800
Message-Id: <20181122102325.29495-7-wens@csie.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122102325.29495-1-wens@csie.org>
References: <20181122102325.29495-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Khoruzhick <anarsoul@gmail.com>

Add nodes for i2s, digital and analog parts of audiocodec on A64.

The routing paths listed are entries connecting the digital and analog
side of the audio codec together. Due to how device tree works, these
must be copied over to each board device tree, in addition to any board
level routes.

The oversampling rate is set to 128, so that when playing back 192 kHz
audio samples, the MCLK runs at the same rate as the module clock, at
24.576 MHz.

The user manual suggests using different oversampling rates for different
sample rates, but that's not possible without a platform-specific machine
driver.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
[wens@csie.org: Lowered oversampling rate to 128; expanded commit message]
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 42abfbf56b88..384c417cb7a2 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -155,6 +155,30 @@
 		method = "smc";
 	};
 
+	sound: sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "sun50i-a64-audio";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&cpudai>;
+		simple-audio-card,bitclock-master = <&cpudai>;
+		simple-audio-card,mclk-fs = <128>;
+		simple-audio-card,aux-devs = <&codec_analog>;
+		simple-audio-card,routing =
+				"Left DAC", "AIF1 Slot 0 Left",
+				"Right DAC", "AIF1 Slot 0 Right",
+				"AIF1 Slot 0 Left ADC", "Left ADC",
+				"AIF1 Slot 0 Right ADC", "Right ADC";
+		status = "disabled";
+
+		cpudai: simple-audio-card,cpu {
+			sound-dai = <&dai>;
+		};
+
+		link_codec: simple-audio-card,codec {
+			sound-dai = <&codec>;
+		};
+	};
+
 	sound_spdif {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "On-board SPDIF";
@@ -665,6 +689,30 @@
 			status = "disabled";
 		};
 
+		dai: dai@1c22c00 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun50i-a64-codec-i2s";
+			reg = <0x01c22c00 0x200>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
+			clock-names = "apb", "mod";
+			resets = <&ccu RST_BUS_CODEC>;
+			reset-names = "rst";
+			dmas = <&dma 15>, <&dma 15>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
+
+		codec: codec@1c22e00 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun8i-a33-codec";
+			reg = <0x01c22e00 0x600>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
+			clock-names = "bus", "mod";
+			status = "disabled";
+		};
+
 		uart0: serial@1c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
@@ -924,6 +972,12 @@
 			#reset-cells = <1>;
 		};
 
+		codec_analog: codec-analog@1f015c0 {
+			compatible = "allwinner,sun50i-a64-codec-analog";
+			reg = <0x01f015c0 0x4>;
+			status = "disabled";
+		};
+
 		r_i2c: i2c@1f02400 {
 			compatible = "allwinner,sun50i-a64-i2c",
 				     "allwinner,sun6i-a31-i2c";
-- 
2.19.1

