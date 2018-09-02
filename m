Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9593C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 07:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C66820837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 07:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C66820837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbeIBLmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 07:42:00 -0400
Received: from mailoutvs36.siol.net ([185.57.226.227]:54549 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725905AbeIBLl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 07:41:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 42FBA520B06;
        Sun,  2 Sep 2018 09:27:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id l8Wm0TWpOIBW; Sun,  2 Sep 2018 09:27:08 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id A7AD1520B05;
        Sun,  2 Sep 2018 09:27:08 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 1DB9D520B06;
        Sun,  2 Sep 2018 09:27:06 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     robh+dt@kernel.org, maxime.ripard@bootlin.com, wens@csie.org
Cc:     mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        jernej.skrabec@siol.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 04/27] clk: sunxi-ng: Adjust MP clock parent rate when allowed
Date:   Sun,  2 Sep 2018 09:26:20 +0200
Message-Id: <20180902072643.4917-5-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180902072643.4917-1-jernej.skrabec@siol.net>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently MP clocks don't consider adjusting parent rate even if they
are allowed to do so. Such behaviour considerably lowers amount of
possible rates, which is very inconvenient when such clock is used for
pixel clock, for example.

In order to improve the situation, adjusting parent rate is considered
when allowed.

This code is inspired by clk_divider_bestdiv() function, which does
basically the same thing for different clock type.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu_mp.c | 64 +++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_mp.c b/drivers/clk/sunxi-ng/ccu_mp.c
index 5d0af4051737..0357349eb767 100644
--- a/drivers/clk/sunxi-ng/ccu_mp.c
+++ b/drivers/clk/sunxi-ng/ccu_mp.c
@@ -40,6 +40,61 @@ static void ccu_mp_find_best(unsigned long parent, unsigned long rate,
 	*p = best_p;
 }
 
+static unsigned long ccu_mp_find_best_with_parent_adj(struct clk_hw *hw,
+						      unsigned long *parent,
+						      unsigned long rate,
+						      unsigned int max_m,
+						      unsigned int max_p)
+{
+	unsigned long parent_rate_saved;
+	unsigned long parent_rate, now;
+	unsigned long best_rate = 0;
+	unsigned int _m, _p, div;
+	unsigned long maxdiv;
+
+	parent_rate_saved = *parent;
+
+	/*
+	 * The maximum divider we can use without overflowing
+	 * unsigned long in rate * m * p below
+	 */
+	maxdiv = max_m * max_p;
+	maxdiv = min(ULONG_MAX / rate, maxdiv);
+
+	for (_p = 1; _p <= max_p; _p <<= 1) {
+		for (_m = 1; _m <= max_m; _m++) {
+			div = _m * _p;
+
+			if (div > maxdiv)
+				break;
+
+			if (rate * div == parent_rate_saved) {
+				/*
+				 * It's the most ideal case if the requested
+				 * rate can be divided from parent clock without
+				 * needing to change parent rate, so return the
+				 * divider immediately.
+				 */
+				*parent = parent_rate_saved;
+				return rate;
+			}
+
+			parent_rate = clk_hw_round_rate(hw, rate * div);
+			now = parent_rate / div;
+
+			if (now <= rate && now > best_rate) {
+				best_rate = now;
+				*parent = parent_rate;
+
+				if (now == rate)
+					return rate;
+			}
+		}
+	}
+
+	return best_rate;
+}
+
 static unsigned long ccu_mp_round_rate(struct ccu_mux_internal *mux,
 				       struct clk_hw *hw,
 				       unsigned long *parent_rate,
@@ -56,8 +111,13 @@ static unsigned long ccu_mp_round_rate(struct ccu_mux_internal *mux,
 	max_m = cmp->m.max ?: 1 << cmp->m.width;
 	max_p = cmp->p.max ?: 1 << ((1 << cmp->p.width) - 1);
 
-	ccu_mp_find_best(*parent_rate, rate, max_m, max_p, &m, &p);
-	rate = *parent_rate / p / m;
+	if (!(clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT)) {
+		ccu_mp_find_best(*parent_rate, rate, max_m, max_p, &m, &p);
+		rate = *parent_rate / p / m;
+	} else {
+		rate = ccu_mp_find_best_with_parent_adj(hw, parent_rate, rate,
+							max_m, max_p);
+	}
 
 	if (cmp->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate /= cmp->fixed_post_div;
-- 
2.18.0

