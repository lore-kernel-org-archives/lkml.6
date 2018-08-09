Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A6DC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8653E21EB7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8653E21EB7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732677AbeHITSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 15:18:25 -0400
Received: from mailoutvs63.siol.net ([185.57.226.254]:43688 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732471AbeHITSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 15:18:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 0EF025230A7;
        Thu,  9 Aug 2018 18:52:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id yfEYIav2XOIf; Thu,  9 Aug 2018 18:52:39 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 99E6E522FE8;
        Thu,  9 Aug 2018 18:52:39 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 3D4335230A7;
        Thu,  9 Aug 2018 18:52:37 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        jernej.skrabec@siol.net
Subject: [PATCH 4/5] clk: sunxi-ng: nkmp: Add constraint for maximum rate
Date:   Thu,  9 Aug 2018 18:52:16 +0200
Message-Id: <20180809165217.30680-5-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809165217.30680-1-jernej.skrabec@siol.net>
References: <20180809165217.30680-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some, if not most, NKMP PLLs can be set to higher rate that is really
supported by HW.

Implement support for maximum frequency constrain for NKMP PLLs.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu_nkmp.c | 7 +++++++
 drivers/clk/sunxi-ng/ccu_nkmp.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.c b/drivers/clk/sunxi-ng/ccu_nkmp.c
index ebd9436d2c7c..9b49adb20d07 100644
--- a/drivers/clk/sunxi-ng/ccu_nkmp.c
+++ b/drivers/clk/sunxi-ng/ccu_nkmp.c
@@ -137,6 +137,13 @@ static long ccu_nkmp_round_rate(struct clk_hw *hw, unsigned long rate,
 	if (nkmp->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate *= nkmp->fixed_post_div;
 
+	if (nkmp->max_rate && rate > nkmp->max_rate) {
+		rate = nkmp->max_rate;
+		if (nkmp->common.features & CCU_FEATURE_FIXED_POSTDIV)
+			rate /= nkmp->fixed_post_div;
+		return rate;
+	}
+
 	_nkmp.min_n = nkmp->n.min ?: 1;
 	_nkmp.max_n = nkmp->n.max ?: 1 << nkmp->n.width;
 	_nkmp.min_k = nkmp->k.min ?: 1;
diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.h b/drivers/clk/sunxi-ng/ccu_nkmp.h
index 6940503e7fc4..a9f8c116a745 100644
--- a/drivers/clk/sunxi-ng/ccu_nkmp.h
+++ b/drivers/clk/sunxi-ng/ccu_nkmp.h
@@ -35,6 +35,7 @@ struct ccu_nkmp {
 	struct ccu_div_internal		p;
 
 	unsigned int		fixed_post_div;
+	unsigned int		max_rate;
 
 	struct ccu_common	common;
 };
-- 
2.18.0

