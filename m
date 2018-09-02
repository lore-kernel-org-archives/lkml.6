Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C96C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 07:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E55D2086C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 07:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E55D2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeIBLmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 07:42:02 -0400
Received: from mailoutvs18.siol.net ([185.57.226.209]:54576 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725905AbeIBLmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 07:42:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id C7356520B18;
        Sun,  2 Sep 2018 09:27:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id luqjatt2to1I; Sun,  2 Sep 2018 09:27:11 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 43122520B10;
        Sun,  2 Sep 2018 09:27:11 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id B0299520B18;
        Sun,  2 Sep 2018 09:27:08 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     robh+dt@kernel.org, maxime.ripard@bootlin.com, wens@csie.org
Cc:     mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        jernej.skrabec@siol.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 05/27] clk: sunxi-ng: Use u64 for calculation of NM rate
Date:   Sun,  2 Sep 2018 09:26:21 +0200
Message-Id: <20180902072643.4917-6-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180902072643.4917-1-jernej.skrabec@siol.net>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 SoC has multiplier N range between 1 and 254. Since parent
rate is 24MHz, intermediate result when calculating final rate easily
overflows 32 bit variable.

Because of that, introduce function for calculating clock rate which
uses 64 bit variable for intermediate result.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu_nm.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
index 6fe3c14f7b2d..424d8635b053 100644
--- a/drivers/clk/sunxi-ng/ccu_nm.c
+++ b/drivers/clk/sunxi-ng/ccu_nm.c
@@ -19,6 +19,17 @@ struct _ccu_nm {
 	unsigned long	m, min_m, max_m;
 };
 
+static unsigned long ccu_nm_calc_rate(unsigned long parent,
+				      unsigned long n, unsigned long m)
+{
+	u64 rate = parent;
+
+	rate *= n;
+	do_div(rate, m);
+
+	return rate;
+}
+
 static void ccu_nm_find_best(unsigned long parent, unsigned long rate,
 			     struct _ccu_nm *nm)
 {
@@ -28,7 +39,8 @@ static void ccu_nm_find_best(unsigned long parent, unsigned long rate,
 
 	for (_n = nm->min_n; _n <= nm->max_n; _n++) {
 		for (_m = nm->min_m; _m <= nm->max_m; _m++) {
-			unsigned long tmp_rate = parent * _n  / _m;
+			unsigned long tmp_rate = ccu_nm_calc_rate(parent,
+								  _n, _m);
 
 			if (tmp_rate > rate)
 				continue;
@@ -100,7 +112,7 @@ static unsigned long ccu_nm_recalc_rate(struct clk_hw *hw,
 	if (ccu_sdm_helper_is_enabled(&nm->common, &nm->sdm))
 		rate = ccu_sdm_helper_read_rate(&nm->common, &nm->sdm, m, n);
 	else
-		rate = parent_rate * n / m;
+		rate = ccu_nm_calc_rate(parent_rate, n, m);
 
 	if (nm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate /= nm->fixed_post_div;
@@ -149,7 +161,7 @@ static long ccu_nm_round_rate(struct clk_hw *hw, unsigned long rate,
 	_nm.max_m = nm->m.max ?: 1 << nm->m.width;
 
 	ccu_nm_find_best(*parent_rate, rate, &_nm);
-	rate = *parent_rate * _nm.n / _nm.m;
+	rate = ccu_nm_calc_rate(*parent_rate, _nm.n, _nm.m);
 
 	if (nm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate /= nm->fixed_post_div;
-- 
2.18.0

