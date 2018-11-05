Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEBDECDE43
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE97120825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE97120825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbeKEUKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:10:52 -0500
Received: from hermes.aosc.io ([199.195.250.187]:54642 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbeKEUKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:10:51 -0500
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 0A8D766FDD;
        Mon,  5 Nov 2018 10:51:41 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH] Revert "clk: sunxi-ng: sun50i: h6: Add 2x fixed post-divider to MMC module clocks"
Date:   Mon,  5 Nov 2018 18:51:12 +0800
Message-Id: <20181105105112.5631-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit c2ff8383cc33c2d9c169e4daf1e37a434c3bb420.

This commit seems to lead to eMMC instability on Pine H64 board, both
model A and model B.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 43 +++++++++++++---------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
index 2193e1495086..d425b47cef17 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -408,29 +408,26 @@ static SUNXI_CCU_GATE(bus_nand_clk, "bus-nand", "ahb3", 0x82c, BIT(0), 0);
 
 static const char * const mmc_parents[] = { "osc24M", "pll-periph0-2x",
 					    "pll-periph1-2x" };
-static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc0_clk, "mmc0", mmc_parents, 0x830,
-					  0, 4,		/* M */
-					  8, 2,		/* N */
-					  24, 3,	/* mux */
-					  BIT(31),	/* gate */
-					  2,		/* post-div */
-					  0);
-
-static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc1_clk, "mmc1", mmc_parents, 0x834,
-					  0, 4,		/* M */
-					  8, 2,		/* N */
-					  24, 3,	/* mux */
-					  BIT(31),	/* gate */
-					  2,		/* post-div */
-					  0);
-
-static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc2_clk, "mmc2", mmc_parents, 0x838,
-					  0, 4,		/* M */
-					  8, 2,		/* N */
-					  24, 3,	/* mux */
-					  BIT(31),	/* gate */
-					  2,		/* post-div */
-					  0);
+static SUNXI_CCU_MP_WITH_MUX_GATE(mmc0_clk, "mmc0", mmc_parents, 0x830,
+					0, 4,	/* M */
+					8, 2,	/* N */
+					24, 3,	/* mux */
+					BIT(31),/* gate */
+					0);
+
+static SUNXI_CCU_MP_WITH_MUX_GATE(mmc1_clk, "mmc1", mmc_parents, 0x834,
+					0, 4,	/* M */
+					8, 2,	/* N */
+					24, 3,	/* mux */
+					BIT(31),/* gate */
+					0);
+
+static SUNXI_CCU_MP_WITH_MUX_GATE(mmc2_clk, "mmc2", mmc_parents, 0x838,
+					0, 4,	/* M */
+					8, 2,	/* N */
+					24, 3,	/* mux */
+					BIT(31),/* gate */
+					0);
 
 static SUNXI_CCU_GATE(bus_mmc0_clk, "bus-mmc0", "ahb3", 0x84c, BIT(0), 0);
 static SUNXI_CCU_GATE(bus_mmc1_clk, "bus-mmc1", "ahb3", 0x84c, BIT(1), 0);
-- 
2.18.1

