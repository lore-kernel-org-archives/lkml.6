Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA86C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C112321EC2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C112321EC2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732642AbeHITSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 15:18:21 -0400
Received: from mailoutvs32.siol.net ([185.57.226.223]:43632 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730634AbeHITSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 15:18:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 435AA523112;
        Thu,  9 Aug 2018 18:52:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Vs6XPbkbzwxi; Thu,  9 Aug 2018 18:52:34 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id C7DA65230F0;
        Thu,  9 Aug 2018 18:52:34 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 4A8E25230A7;
        Thu,  9 Aug 2018 18:52:32 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        jernej.skrabec@siol.net
Subject: [PATCH 2/5] clk: sunxi-ng: h3/h5: Add max. rate constraint to pll-video
Date:   Thu,  9 Aug 2018 18:52:14 +0200
Message-Id: <20180809165217.30680-3-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809165217.30680-1-jernej.skrabec@siol.net>
References: <20180809165217.30680-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it turns out, pll-video can be set to higher rate that it is really
supported by HW.

For example, one monitor requested 185.58 MHz pixel clock. Clock
framework calculated that minimum rate error would be when pll-video
is set to 2040 MHz. This is clearly out of specs.

Both H3 and H5 user manuals specify 600 MHz as maximum supported rate.
However, BSP clock drivers allow up to 912 MHz and 1008 MHz
respectively. Here 912 MHz is chosen because user manuals were already
proven wrong once for lower limits.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
index 77ed0b0ba681..eb5c608428fa 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
@@ -69,18 +69,19 @@ static SUNXI_CCU_NM_WITH_SDM_GATE_LOCK(pll_audio_base_clk, "pll-audio-base",
 				       BIT(28),	/* lock */
 				       CLK_SET_RATE_UNGATE);
 
-static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN(pll_video_clk, "pll-video",
-					    "osc24M", 0x0010,
-					    192000000,	/* Minimum rate */
-					    8, 7,	/* N */
-					    0, 4,	/* M */
-					    BIT(24),	/* frac enable */
-					    BIT(25),	/* frac select */
-					    270000000,	/* frac rate 0 */
-					    297000000,	/* frac rate 1 */
-					    BIT(31),	/* gate */
-					    BIT(28),	/* lock */
-					    CLK_SET_RATE_UNGATE);
+static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX(pll_video_clk, "pll-video",
+						"osc24M", 0x0010,
+						192000000, /* Minimum rate */
+						912000000, /* Maximum rate */
+						8, 7,      /* N */
+						0, 4,	   /* M */
+						BIT(24),   /* frac enable */
+						BIT(25),   /* frac select */
+						270000000, /* frac rate 0 */
+						297000000, /* frac rate 1 */
+						BIT(31),   /* gate */
+						BIT(28),   /* lock */
+						CLK_SET_RATE_UNGATE);
 
 static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_ve_clk, "pll-ve",
 					"osc24M", 0x0018,
-- 
2.18.0

