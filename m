Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841D7C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A9821758
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A9821758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbeHHTlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:41:44 -0400
Received: from hermes.aosc.io ([199.195.250.187]:53972 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727472AbeHHTln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:41:43 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 56431BDE6A;
        Wed,  8 Aug 2018 17:20:56 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>, stable@vger.kernel.org
Subject: [PATCH] clk: sunxi-ng: fix H6 bus clocks divider position
Date:   Thu,  9 Aug 2018 01:19:52 +0800
Message-Id: <20180808171952.17263-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bus clocks (AHB/APB) on Allwinner H6 have their second divider start
at bit 8, according to the user manual and the BSP code. However,
currently the divider is wrongly set to 16, thus the divider is not
correctly read and the clock frequency is not correctly calculated.

Fix this bit offset on all affected bus clocks in ccu-sun50i-h6.

Cc: stable@vger.kernel.org # v4.17.y
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
index bdbfe78fe133..0f7a0ffd3f70 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -224,7 +224,7 @@ static SUNXI_CCU_MP_WITH_MUX(psi_ahb1_ahb2_clk, "psi-ahb1-ahb2",
 			     psi_ahb1_ahb2_parents,
 			     0x510,
 			     0, 5,	/* M */
-			     16, 2,	/* P */
+			     8, 2,	/* P */
 			     24, 2,	/* mux */
 			     0);
 
@@ -233,19 +233,19 @@ static const char * const ahb3_apb1_apb2_parents[] = { "osc24M", "osc32k",
 						       "pll-periph0" };
 static SUNXI_CCU_MP_WITH_MUX(ahb3_clk, "ahb3", ahb3_apb1_apb2_parents, 0x51c,
 			     0, 5,	/* M */
-			     16, 2,	/* P */
+			     8, 2,	/* P */
 			     24, 2,	/* mux */
 			     0);
 
 static SUNXI_CCU_MP_WITH_MUX(apb1_clk, "apb1", ahb3_apb1_apb2_parents, 0x520,
 			     0, 5,	/* M */
-			     16, 2,	/* P */
+			     8, 2,	/* P */
 			     24, 2,	/* mux */
 			     0);
 
 static SUNXI_CCU_MP_WITH_MUX(apb2_clk, "apb2", ahb3_apb1_apb2_parents, 0x524,
 			     0, 5,	/* M */
-			     16, 2,	/* P */
+			     8, 2,	/* P */
 			     24, 2,	/* mux */
 			     0);
 
-- 
2.18.0

