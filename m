Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F408C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6180E20869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6180E20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeIDJFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 05:05:03 -0400
Received: from hermes.aosc.io ([199.195.250.187]:44925 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726093AbeIDJFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 05:05:02 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id ECB5A5A0D3;
        Tue,  4 Sep 2018 04:41:38 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v4 02/11] clk: sunxi-ng: a64: Add max. rate constraint to video PLLs
Date:   Tue,  4 Sep 2018 12:40:44 +0800
Message-Id: <20180904044053.15425-3-icenowy@aosc.io>
In-Reply-To: <20180904044053.15425-1-icenowy@aosc.io>
References: <20180904044053.15425-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Video PLLs on A64 can be set to higher rate that it is actually
supported by HW.

Limit maximum rate to 1008 MHz. This is the maximum allowed rate by BSP
clock driver. Interestengly, user manual specifies maximum frequency to
be 600 MHz. Historically, this data was wrong in some user manuals for
other SoCs, so more faith is put in BSP clock driver.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
New patch in v4.

 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 50 ++++++++++++++-------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index d0e30192f0cf..5f80eb018014 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -64,18 +64,19 @@ static SUNXI_CCU_NM_WITH_GATE_LOCK(pll_audio_base_clk, "pll-audio-base",
 				   BIT(28),	/* lock */
 				   CLK_SET_RATE_UNGATE);
 
-static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN(pll_video0_clk, "pll-video0",
-					    "osc24M", 0x010,
-					    192000000,	/* Minimum rate */
-					    8, 7,		/* N */
-					    0, 4,		/* M */
-					    BIT(24),	/* frac enable */
-					    BIT(25),	/* frac select */
-					    270000000,	/* frac rate 0 */
-					    297000000,	/* frac rate 1 */
-					    BIT(31),	/* gate */
-					    BIT(28),	/* lock */
-					    CLK_SET_RATE_UNGATE);
+static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX(pll_video0_clk, "pll-video0",
+						"osc24M", 0x010,
+						192000000,	/* Minimum rate */
+						1008000000,	/* Maximum rate */
+						8, 7,		/* N */
+						0, 4,		/* M */
+						BIT(24),	/* frac enable */
+						BIT(25),	/* frac select */
+						270000000,	/* frac rate 0 */
+						297000000,	/* frac rate 1 */
+						BIT(31),	/* gate */
+						BIT(28),	/* lock */
+						CLK_SET_RATE_UNGATE);
 
 static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_ve_clk, "pll-ve",
 					"osc24M", 0x018,
@@ -126,18 +127,19 @@ static struct ccu_nk pll_periph1_clk = {
 	},
 };
 
-static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN(pll_video1_clk, "pll-video1",
-					    "osc24M", 0x030,
-					    192000000,	/* Minimum rate */
-					    8, 7,		/* N */
-					    0, 4,		/* M */
-					    BIT(24),	/* frac enable */
-					    BIT(25),	/* frac select */
-					    270000000,	/* frac rate 0 */
-					    297000000,	/* frac rate 1 */
-					    BIT(31),	/* gate */
-					    BIT(28),	/* lock */
-					    CLK_SET_RATE_UNGATE);
+static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX(pll_video1_clk, "pll-video1",
+						"osc24M", 0x030,
+						192000000,	/* Minimum rate */
+						1008000000,	/* Maximum rate */
+						8, 7,		/* N */
+						0, 4,		/* M */
+						BIT(24),	/* frac enable */
+						BIT(25),	/* frac select */
+						270000000,	/* frac rate 0 */
+						297000000,	/* frac rate 1 */
+						BIT(31),	/* gate */
+						BIT(28),	/* lock */
+						CLK_SET_RATE_UNGATE);
 
 static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_gpu_clk, "pll-gpu",
 					"osc24M", 0x038,
-- 
2.18.0

