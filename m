Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751EFC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5CE2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5CE2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbeLCO6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:58:51 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:50908 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeLCO6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:58:39 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 9491F5FDD0; Mon,  3 Dec 2018 22:58:27 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH v2 11/14] ARM: dts: sunxi: h3/h5: Fix up RTC device node and clock references
Date:   Mon,  3 Dec 2018 22:58:22 +0800
Message-Id: <20181203145825.20511-12-wens@csie.org>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181203145825.20511-1-wens@csie.org>
References: <20181203145825.20511-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC module on the H3 was claimed to be the same as on the A31, when
in fact it is not. The A31 does not have an RTC external clock output,
and its internal RC oscillator's average clock rate is not in the same
range. The H5's RTC has some extra crypto-related registers compared to
the H3. Their exact functions are not clear. Also the RTC-VIO regulator
has different settings.

This patch fixes the compatible string and clock properties to conform
to the updated bindings. The device node for the internal oscillator is
removed, as it is internalized into the RTC device. Clock references to
the IOSC and LOSC are also fixed.

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-h3.dtsi              |  4 +++
 arch/arm/boot/dts/sunxi-h3-h5.dtsi           | 26 ++++++++------------
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi |  4 +++
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index c2da3a3d373a..743c1dbaf147 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -241,3 +241,7 @@
 &pio {
 	compatible = "allwinner,sun8i-h3-pinctrl";
 };
+
+&rtc {
+	compatible = "allwinner,sun8i-h3-rtc";
+};
diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index bce3bf1d6ae5..3cc4366c07fd 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -95,15 +95,7 @@
 			compatible = "fixed-clock";
 			clock-frequency = <32768>;
 			clock-accuracy = <50000>;
-			clock-output-names = "osc32k";
-		};
-
-		iosc: internal-osc-clk {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <16000000>;
-			clock-accuracy = <300000000>;
-			clock-output-names = "iosc";
+			clock-output-names = "ext_osc32k";
 		};
 	};
 
@@ -377,7 +369,7 @@
 		ccu: clock@1c20000 {
 			/* compatible is in per SoC .dtsi file */
 			reg = <0x01c20000 0x400>;
-			clocks = <&osc24M>, <&osc32k>;
+			clocks = <&osc24M>, <&rtc 0>;
 			clock-names = "hosc", "losc";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -388,7 +380,7 @@
 			reg = <0x01c20800 0x400>;
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>, <&osc32k>;
+			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>, <&rtc 0>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
 			#gpio-cells = <3>;
@@ -813,17 +805,19 @@
 		};
 
 		rtc: rtc@1f00000 {
-			compatible = "allwinner,sun6i-a31-rtc";
-			reg = <0x01f00000 0x54>;
+			/* compatible is in per SoC .dtsi file */
+			reg = <0x01f00000 0x400>;
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+			clock-output-names = "osc32k", "osc32k-out", "iosc";
+			clocks = <&osc32k>;
+			#clock-cells = <1>;
 		};
 
 		r_ccu: clock@1f01400 {
 			compatible = "allwinner,sun8i-h3-r-ccu";
 			reg = <0x01f01400 0x100>;
-			clocks = <&osc24M>, <&osc32k>, <&iosc>,
-				 <&ccu 9>;
+			clocks = <&osc24M>, <&rtc 0>, <&rtc 2>, <&ccu 9>;
 			clock-names = "hosc", "losc", "iosc", "pll-periph";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -861,7 +855,7 @@
 			compatible = "allwinner,sun8i-h3-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&r_ccu CLK_APB0_PIO>, <&osc24M>, <&osc32k>;
+			clocks = <&r_ccu CLK_APB0_PIO>, <&osc24M>, <&rtc 0>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
 			#gpio-cells = <3>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
index b41dc1aab67d..fe731b35f761 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
@@ -172,3 +172,7 @@
 		     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 	compatible = "allwinner,sun50i-h5-pinctrl";
 };
+
+&rtc {
+	compatible = "allwinner,sun50i-h5-rtc";
+};
-- 
2.20.0.rc1

