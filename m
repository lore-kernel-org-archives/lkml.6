Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D51ECDFBD
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 04:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4078A20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 04:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4078A20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbeGSFLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 01:11:08 -0400
Received: from hermes.aosc.io ([199.195.250.187]:40621 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727508AbeGSFLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 01:11:08 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id BCE9F9ED91;
        Thu, 19 Jul 2018 04:29:44 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v2 2/3] arm64: allwinner: h6: add device tree nodes for MMC controllers
Date:   Thu, 19 Jul 2018 12:28:09 +0800
Message-Id: <20180719042810.6546-3-icenowy@aosc.io>
In-Reply-To: <20180719042810.6546-1-icenowy@aosc.io>
References: <20180719042810.6546-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner H6 SoC have 3 MMC controllers.

Add device tree nodes for them.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v2:
- Add A64 compatible fallback.

 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 59 ++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 37c2e11fca2e..cfa5fffcf62b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -126,12 +126,71 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
+			mmc0_pins: mmc0-pins {
+				pins = "PF0", "PF1", "PF2", "PF3",
+				       "PF4", "PF5";
+				function = "mmc0";
+				drive-strength = <30>;
+				bias-pull-up;
+			};
+
+			mmc2_pins: mmc2-pins {
+				pins = "PC1", "PC4", "PC5", "PC6",
+				       "PC7", "PC8", "PC9", "PC10",
+				       "PC11", "PC12", "PC13", "PC14";
+				function = "mmc2";
+				drive-strength = <30>;
+				bias-pull-up;
+			};
+
 			uart0_ph_pins: uart0-ph {
 				pins = "PH0", "PH1";
 				function = "uart0";
 			};
 		};
 
+		mmc0: mmc@4020000 {
+			compatible = "allwinner,sun50i-h6-mmc",
+				     "allwinner,sun50i-a64-mmc";
+			reg = <0x04020000 0x1000>;
+			clocks = <&ccu CLK_BUS_MMC0>, <&ccu CLK_MMC0>;
+			clock-names = "ahb", "mmc";
+			resets = <&ccu RST_BUS_MMC0>;
+			reset-names = "ahb";
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mmc1: mmc@4021000 {
+			compatible = "allwinner,sun50i-h6-mmc",
+				     "allwinner,sun50i-a64-mmc";
+			reg = <0x04021000 0x1000>;
+			clocks = <&ccu CLK_BUS_MMC1>, <&ccu CLK_MMC1>;
+			clock-names = "ahb", "mmc";
+			resets = <&ccu RST_BUS_MMC1>;
+			reset-names = "ahb";
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mmc2: mmc@4022000 {
+			compatible = "allwinner,sun50i-h6-emmc",
+				     "allwinner,sun50i-a64-emmc";
+			reg = <0x04022000 0x1000>;
+			clocks = <&ccu CLK_BUS_MMC2>, <&ccu CLK_MMC2>;
+			clock-names = "ahb", "mmc";
+			resets = <&ccu RST_BUS_MMC2>;
+			reset-names = "ahb";
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		uart0: serial@5000000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x05000000 0x400>;
-- 
2.17.1

