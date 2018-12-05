Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFC4C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89169206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89169206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbeLEKMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:12:00 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:51450 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728021AbeLEKL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:11:56 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 621865FD54; Wed,  5 Dec 2018 18:11:53 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH 2/3] clk: sunxi-ng: a33: Set CLK_SET_RATE_PARENT for all audio module clocks
Date:   Wed,  5 Dec 2018 18:11:51 +0800
Message-Id: <20181205101152.22983-3-wens@csie.org>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181205101152.22983-1-wens@csie.org>
References: <20181205101152.22983-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the audio interfaces on Allwinner SoCs need to change their module
clocks during operation, to switch between support for 44.1 kHz and 48
kHz family sample rates. The clock rate for the module clocks is
governed by their upstream audio PLL. The module clocks themselves only
have a gate, and sometimes a divider or mux. Thus any rate changes need
to be propagated upstream.

Set the CLK_SET_RATE_PARENT flag for all audio module clocks to achieve
this.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
index f763648a5f20..c7bf814dfd2b 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
@@ -377,10 +377,10 @@ static SUNXI_CCU_MP_WITH_MUX_GATE(spi1_clk, "spi1", mod0_default_parents, 0x0a4,
 static const char * const i2s_parents[] = { "pll-audio-8x", "pll-audio-4x",
 					    "pll-audio-2x", "pll-audio" };
 static SUNXI_CCU_MUX_WITH_GATE(i2s0_clk, "i2s0", i2s_parents,
-			       0x0b0, 16, 2, BIT(31), 0);
+			       0x0b0, 16, 2, BIT(31), CLK_SET_RATE_PARENT);
 
 static SUNXI_CCU_MUX_WITH_GATE(i2s1_clk, "i2s1", i2s_parents,
-			       0x0b4, 16, 2, BIT(31), 0);
+			       0x0b4, 16, 2, BIT(31), CLK_SET_RATE_PARENT);
 
 /* TODO: the parent for most of the USB clocks is not known */
 static SUNXI_CCU_GATE(usb_phy0_clk,	"usb-phy0",	"osc24M",
@@ -457,7 +457,7 @@ static SUNXI_CCU_M_WITH_GATE(ve_clk, "ve", "pll-ve",
 static SUNXI_CCU_GATE(ac_dig_clk,	"ac-dig",	"pll-audio",
 		      0x140, BIT(31), CLK_SET_RATE_PARENT);
 static SUNXI_CCU_GATE(ac_dig_4x_clk,	"ac-dig-4x",	"pll-audio-4x",
-		      0x140, BIT(30), 0);
+		      0x140, BIT(30), CLK_SET_RATE_PARENT);
 static SUNXI_CCU_GATE(avs_clk,		"avs",		"osc24M",
 		      0x144, BIT(31), 0);
 
-- 
2.20.0.rc1

