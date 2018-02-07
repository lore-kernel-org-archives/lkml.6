Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755182AbeBGVYU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 16:24:20 -0500
Received: from mailoutvs4.siol.net ([213.250.19.137]:45976 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755087AbeBGVX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 16:23:59 -0500
From: Jernej Skrabec <jernej.skrabec@siol.net>
To: maxime.ripard@free-electrons.com, wens@csie.org, airlied@linux.ie,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, narmstrong@baylibre.com,
        Jose.Abreu@synopsys.com
Cc: jernej.skrabec@siol.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v4 02/12] clk: sunxi-ng: Use u64 for calculation of nkmp rate
Date: Wed,  7 Feb 2018 22:17:03 +0100
Message-Id: <20180207211713.3638-3-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180207211713.3638-1-jernej.skrabec@siol.net>
References: <20180207211713.3638-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When parent rate is 24MHz and multiplier N >= 180, intermediate clock
rate doesn't fit in 32 bit variable anymore.

Because of that, introduce function for calculating clock rate which
uses 64 bit variable for intermediate result.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu_nkmp.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.c b/drivers/clk/sunxi-ng/ccu_nkmp.c
index a99068a08315..c3f6fe7be565 100644
--- a/drivers/clk/sunxi-ng/ccu_nkmp.c
+++ b/drivers/clk/sunxi-ng/ccu_nkmp.c
@@ -20,6 +20,18 @@ struct _ccu_nkmp {
 	unsigned long	p, min_p, max_p;
 };
 
+static unsigned long ccu_nkmp_calc_rate(unsigned long parent,
+					unsigned long n, unsigned long k,
+					unsigned long m, unsigned long p)
+{
+	u64 rate = parent;
+
+	rate *= n * k;
+	do_div(rate, m * p);
+
+	return rate;
+}
+
 static void ccu_nkmp_find_best(unsigned long parent, unsigned long rate,
 			       struct _ccu_nkmp *nkmp)
 {
@@ -33,7 +45,9 @@ static void ccu_nkmp_find_best(unsigned long parent, unsigned long rate,
 				for (_p = nkmp->min_p; _p <= nkmp->max_p; _p <<= 1) {
 					unsigned long tmp_rate;
 
-					tmp_rate = parent * _n * _k / (_m * _p);
+					tmp_rate = ccu_nkmp_calc_rate(parent,
+								      _n, _k,
+								      _m, _p);
 
 					if (tmp_rate > rate)
 						continue;
@@ -107,7 +121,7 @@ static unsigned long ccu_nkmp_recalc_rate(struct clk_hw *hw,
 	p = reg >> nkmp->p.shift;
 	p &= (1 << nkmp->p.width) - 1;
 
-	return (parent_rate * n * k >> p) / m;
+	return ccu_nkmp_calc_rate(parent_rate, n, k, m, 1 << p);
 }
 
 static long ccu_nkmp_round_rate(struct clk_hw *hw, unsigned long rate,
@@ -127,7 +141,8 @@ static long ccu_nkmp_round_rate(struct clk_hw *hw, unsigned long rate,
 
 	ccu_nkmp_find_best(*parent_rate, rate, &_nkmp);
 
-	return *parent_rate * _nkmp.n * _nkmp.k / (_nkmp.m * _nkmp.p);
+	return ccu_nkmp_calc_rate(*parent_rate, _nkmp.n, _nkmp.k,
+				  _nkmp.m, _nkmp.p);
 }
 
 static int ccu_nkmp_set_rate(struct clk_hw *hw, unsigned long rate,
-- 
2.16.1
