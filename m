Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116F6C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDF52087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfAHHZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 02:25:33 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:55478 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbfAHHZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 02:25:32 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 7A3DB5FBC8; Tue,  8 Jan 2019 15:25:27 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: sun6i: Add clock-output-names to osc24M clock
Date:   Tue,  8 Jan 2019 15:25:26 +0800
Message-Id: <20190108072526.2621-1-wens@csie.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The osc24M clock does not have a "clock-output-names" property, which
means that the clock name is derived from the node name in Linux. The
node name was changed in commit acfd5bbe2641 ("ARM: dts: sun6i: Change
clock node names to avoid warnings"). This breaks Linux as the sunxi-ng
clock driver implicitly depends on the external clock being named
"osc24M".

Add a "clock-output-names" property to restore the previous behavior.

Fixes: acfd5bbe2641 ("ARM: dts: sun6i: Change clock node names to avoid
		      warnings")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
This is a critical fix for v5.0-rc. Without it the A31 boots up to the
UART failing to get its clock rate, and thus failing to setup a console.

Also the timer-sun5i init code hits a divide by zero exception. I'll
send a separate patch to make this one fail gracefully.
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 353d90f99b40..13304b8c5139 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -216,6 +216,7 @@
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <24000000>;
+			clock-output-names = "osc24M";
 		};
 
 		osc32k: clk-32k {
-- 
2.20.1

