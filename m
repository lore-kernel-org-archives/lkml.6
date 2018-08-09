Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FA8C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D72521EC2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D72521EC2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732697AbeHITS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 15:18:28 -0400
Received: from mailoutvs20.siol.net ([185.57.226.211]:43714 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732471AbeHITS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 15:18:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 6AC90523198;
        Thu,  9 Aug 2018 18:52:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ywnG6Z4W4GyI; Thu,  9 Aug 2018 18:52:42 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 0A67C5231B8;
        Thu,  9 Aug 2018 18:52:42 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id A00145231AD;
        Thu,  9 Aug 2018 18:52:39 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        jernej.skrabec@siol.net
Subject: [PATCH 5/5] clk: sunxi-ng: a83t: Add max. rate constraint to video PLLs
Date:   Thu,  9 Aug 2018 18:52:17 +0200
Message-Id: <20180809165217.30680-6-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809165217.30680-1-jernej.skrabec@siol.net>
References: <20180809165217.30680-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It may happen that clock framework finds optimal video PLL rate above
that which is really supported by HW.

User manual doesn't really say what is upper limit for video PLLs on
A83T. Because of that, use the maximum rate defined in BSP clk driver
which is 3 GHz.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
index 7d08015b980d..2d6555d73170 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
@@ -108,6 +108,7 @@ static struct ccu_nkmp pll_video0_clk = {
 	.n		= _SUNXI_CCU_MULT_OFFSET_MIN_MAX(8, 8, 0, 12, 0),
 	.m		= _SUNXI_CCU_DIV(16, 1), /* input divider */
 	.p		= _SUNXI_CCU_DIV(0, 2), /* output divider */
+	.max_rate	= 3000000000UL,
 	.common		= {
 		.reg		= 0x010,
 		.lock_reg	= CCU_SUN8I_A83T_LOCK_REG,
@@ -220,6 +221,7 @@ static struct ccu_nkmp pll_video1_clk = {
 	.n		= _SUNXI_CCU_MULT_OFFSET_MIN_MAX(8, 8, 0, 12, 0),
 	.m		= _SUNXI_CCU_DIV(16, 1), /* input divider */
 	.p		= _SUNXI_CCU_DIV(0, 2), /* external divider p */
+	.max_rate	= 3000000000UL,
 	.common		= {
 		.reg		= 0x04c,
 		.lock_reg	= CCU_SUN8I_A83T_LOCK_REG,
-- 
2.18.0

