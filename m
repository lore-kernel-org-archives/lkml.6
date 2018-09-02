Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1541C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 07:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D4F2064D
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 07:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D4F2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeIBLmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 07:42:05 -0400
Received: from mailoutvs22.siol.net ([185.57.226.213]:54607 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725905AbeIBLmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 07:42:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 4A63E520B26;
        Sun,  2 Sep 2018 09:27:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jKFuyyPVjnto; Sun,  2 Sep 2018 09:27:13 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id D09FD520B2B;
        Sun,  2 Sep 2018 09:27:13 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 4A920520B26;
        Sun,  2 Sep 2018 09:27:11 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     robh+dt@kernel.org, maxime.ripard@bootlin.com, wens@csie.org
Cc:     mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        jernej.skrabec@siol.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 06/27] clk: sunxi-ng: h6: Set video PLLs limits
Date:   Sun,  2 Sep 2018 09:26:22 +0200
Message-Id: <20180902072643.4917-7-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180902072643.4917-1-jernej.skrabec@siol.net>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Video PLL factors can be set in a way that final PLL rate is outside
stable range. H6 user manual specifically says that N factor should not
be below 12. While it doesn't says anything about maximum stable rate, it
is clear that PLL doesn't work at 6.096 GHz (254 * 24 MHz).

Set minimum allowed PLL video rate to 288 MHz (12 * 24 MHz) and maximum
to 2.4 GHz, which is maximum in BSP driver.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
index 2193e1495086..f44d314b2285 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -120,6 +120,8 @@ static struct ccu_nm pll_video0_clk = {
 	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
 	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
 	.fixed_post_div	= 4,
+	.min_rate	= 288000000,
+	.max_rate	= 2400000000,
 	.common		= {
 		.reg		= 0x040,
 		.features	= CCU_FEATURE_FIXED_POSTDIV,
@@ -136,6 +138,8 @@ static struct ccu_nm pll_video1_clk = {
 	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
 	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
 	.fixed_post_div	= 4,
+	.min_rate	= 288000000,
+	.max_rate	= 2400000000,
 	.common		= {
 		.reg		= 0x048,
 		.features	= CCU_FEATURE_FIXED_POSTDIV,
-- 
2.18.0

