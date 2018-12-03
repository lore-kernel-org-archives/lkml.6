Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3812C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A94020850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A94020850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbeLCO6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:58:40 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:50916 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbeLCO6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:58:39 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 9FBC95FDD7; Mon,  3 Dec 2018 22:58:27 +0800 (CST)
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
Subject: [PATCH v2 13/14] ARM: dts: sun8i: r40: Add RTC device node
Date:   Mon,  3 Dec 2018 22:58:24 +0800
Message-Id: <20181203145825.20511-14-wens@csie.org>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181203145825.20511-1-wens@csie.org>
References: <20181203145825.20511-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The R40 has an RTC hardware block, which has additional registers
that are not related to RTC or clock functions, and is otherwise
compatible with the H3's RTC.

Add a device node for it, and fix up any references to the LOSC.

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index a8917f8b1c80..89762dbefe42 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -70,7 +70,7 @@
 			compatible = "fixed-clock";
 			clock-frequency = <32768>;
 			clock-accuracy = <20000>;
-			clock-output-names = "osc32k";
+			clock-output-names = "ext-osc32k";
 		};
 	};
 
@@ -315,17 +315,27 @@
 		ccu: clock@1c20000 {
 			compatible = "allwinner,sun8i-r40-ccu";
 			reg = <0x01c20000 0x400>;
-			clocks = <&osc24M>, <&osc32k>;
+			clocks = <&osc24M>, <&rtc 0>;
 			clock-names = "hosc", "losc";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
 
+		rtc: rtc@1c20400 {
+			compatible = "allwinner,sun8i-r40-rtc",
+				     "allwinner,sun8i-h3-rtc";
+			reg = <0x01c20400 0x400>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+			clock-output-names = "osc32k", "osc32k-out";
+			clocks = <&osc32k>;
+			#clock-cells = <1>;
+		};
+
 		pio: pinctrl@1c20800 {
 			compatible = "allwinner,sun8i-r40-pinctrl";
 			reg = <0x01c20800 0x400>;
 			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>, <&osc32k>;
+			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>, <&rtc 0>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
 			interrupt-controller;
-- 
2.20.0.rc1

