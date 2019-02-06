Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD54AC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD302184E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbfBFDdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 22:33:11 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:33832 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727963AbfBFDct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 22:32:49 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id C058F5FD53; Wed,  6 Feb 2019 11:32:43 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH 5/9] ARM: dts: sun9i: Add GMAC clock node
Date:   Wed,  6 Feb 2019 11:32:35 +0800
Message-Id: <20190206033239.3619-6-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206033239.3619-1-wens@csie.org>
References: <20190206033239.3619-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A80 has the same DWMAC hardware as on earlier Allwinner SoCs. The
accompanying GMAC clock register has been moved into the "System
Control" area.

Add a clock node for it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index d9532fb1ef65..724ca3b850c8 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -183,6 +183,37 @@
 			clock-output-names = "osc32k";
 		};
 
+		/*
+		 * The following two are dummy clocks, placeholders
+		 * used in the gmac_tx clock. The gmac driver will
+		 * choose one parent depending on the PHY interface
+		 * mode, using clk_set_rate auto-reparenting.
+		 *
+		 * The actual TX clock rate is not controlled by the
+		 * gmac_tx clock.
+		 */
+		mii_phy_tx_clk: mii_phy_tx_clk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <25000000>;
+			clock-output-names = "mii_phy_tx";
+		};
+
+		gmac_int_tx_clk: gmac_int_tx_clk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <125000000>;
+			clock-output-names = "gmac_int_tx";
+		};
+
+		gmac_tx_clk: clk@800030 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun7i-a20-gmac-clk";
+			reg = <0x00800030 0x4>;
+			clocks = <&mii_phy_tx_clk>, <&gmac_int_tx_clk>;
+			clock-output-names = "gmac_tx";
+		};
+
 		cpus_clk: clk@8001410 {
 			compatible = "allwinner,sun9i-a80-cpus-clk";
 			reg = <0x08001410 0x4>;
-- 
2.20.1

