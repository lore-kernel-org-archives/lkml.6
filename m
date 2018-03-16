Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752981AbeCPOFK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 10:05:10 -0400
Received: from hermes.aosc.io ([199.195.250.187]:44117 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752339AbeCPOFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 10:05:07 -0400
From: Icenowy Zheng <icenowy@aosc.io>
To: Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v4 5/9] clk: sunxi-ng: Support fixed post-dividers on NKMP style clocks
Date: Fri, 16 Mar 2018 22:02:11 +0800
Message-Id: <20180316140215.28663-6-icenowy@aosc.io>
In-Reply-To: <20180316140215.28663-1-icenowy@aosc.io>
References: <20180316140215.28663-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the new Allwinner H6 SoC, multiple PLL's are NMP style clocks
(modelled as NKMP with no K) and have fixed post-dividers.

Add fixed post divider support to the NKMP style clocks.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
No changes in v4.

Changes in v3:
- Rebased on newest linux-next/master.

No changes in v2.

 drivers/clk/sunxi-ng/ccu_nkmp.c | 20 +++++++++++++++++---
 drivers/clk/sunxi-ng/ccu_nkmp.h |  2 ++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.c b/drivers/clk/sunxi-ng/ccu_nkmp.c
index c3f6fe7be565..ebd9436d2c7c 100644
--- a/drivers/clk/sunxi-ng/ccu_nkmp.c
+++ b/drivers/clk/sunxi-ng/ccu_nkmp.c
@@ -95,7 +95,7 @@ static unsigned long ccu_nkmp_recalc_rate(struct clk_hw *hw,
 					unsigned long parent_rate)
 {
 	struct ccu_nkmp *nkmp = hw_to_ccu_nkmp(hw);
-	unsigned long n, m, k, p;
+	unsigned long n, m, k, p, rate;
 	u32 reg;
 
 	reg = readl(nkmp->common.base + nkmp->common.reg);
@@ -121,7 +121,11 @@ static unsigned long ccu_nkmp_recalc_rate(struct clk_hw *hw,
 	p = reg >> nkmp->p.shift;
 	p &= (1 << nkmp->p.width) - 1;
 
-	return ccu_nkmp_calc_rate(parent_rate, n, k, m, 1 << p);
+	rate = ccu_nkmp_calc_rate(parent_rate, n, k, m, 1 << p);
+	if (nkmp->common.features & CCU_FEATURE_FIXED_POSTDIV)
+		rate /= nkmp->fixed_post_div;
+
+	return rate;
 }
 
 static long ccu_nkmp_round_rate(struct clk_hw *hw, unsigned long rate,
@@ -130,6 +134,9 @@ static long ccu_nkmp_round_rate(struct clk_hw *hw, unsigned long rate,
 	struct ccu_nkmp *nkmp = hw_to_ccu_nkmp(hw);
 	struct _ccu_nkmp _nkmp;
 
+	if (nkmp->common.features & CCU_FEATURE_FIXED_POSTDIV)
+		rate *= nkmp->fixed_post_div;
+
 	_nkmp.min_n = nkmp->n.min ?: 1;
 	_nkmp.max_n = nkmp->n.max ?: 1 << nkmp->n.width;
 	_nkmp.min_k = nkmp->k.min ?: 1;
@@ -141,8 +148,12 @@ static long ccu_nkmp_round_rate(struct clk_hw *hw, unsigned long rate,
 
 	ccu_nkmp_find_best(*parent_rate, rate, &_nkmp);
 
-	return ccu_nkmp_calc_rate(*parent_rate, _nkmp.n, _nkmp.k,
+	rate = ccu_nkmp_calc_rate(*parent_rate, _nkmp.n, _nkmp.k,
 				  _nkmp.m, _nkmp.p);
+	if (nkmp->common.features & CCU_FEATURE_FIXED_POSTDIV)
+		rate = rate / nkmp->fixed_post_div;
+
+	return rate;
 }
 
 static int ccu_nkmp_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -154,6 +165,9 @@ static int ccu_nkmp_set_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long flags;
 	u32 reg;
 
+	if (nkmp->common.features & CCU_FEATURE_FIXED_POSTDIV)
+		rate = rate * nkmp->fixed_post_div;
+
 	_nkmp.min_n = nkmp->n.min ?: 1;
 	_nkmp.max_n = nkmp->n.max ?: 1 << nkmp->n.width;
 	_nkmp.min_k = nkmp->k.min ?: 1;
diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.h b/drivers/clk/sunxi-ng/ccu_nkmp.h
index a82facbc6144..6940503e7fc4 100644
--- a/drivers/clk/sunxi-ng/ccu_nkmp.h
+++ b/drivers/clk/sunxi-ng/ccu_nkmp.h
@@ -34,6 +34,8 @@ struct ccu_nkmp {
 	struct ccu_div_internal		m;
 	struct ccu_div_internal		p;
 
+	unsigned int		fixed_post_div;
+
 	struct ccu_common	common;
 };
 
-- 
2.15.1
