Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031446AbeBNURA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 15:17:00 -0500
Received: from mailoutvs4.siol.net ([213.250.19.137]:36686 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031533AbeBNUJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 15:09:36 -0500
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
Subject: [PATCH v5 01/12] clk: sunxi-ng: Mask nkmp factors when setting register
Date: Wed, 14 Feb 2018 21:08:55 +0100
Message-Id: <20180214200906.31509-2-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180214200906.31509-1-jernej.skrabec@siol.net>
References: <20180214200906.31509-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if one of the factors isn't present, bit 0 gets always set to
1. For example, A83T has NMP PLLs modelled as NKMP PLL without K. Since
K is not specified, it's offset, width and shift is 0. Driver assumes
that lowest value possible is 1, otherwise we would get division by 0.
That situation causes that bit 0 is always set, which may change wanted
clock rate.

Fix that by masking every factor according to it's specified width.
Factors with width set to 0 won't have any influence to final register
value.

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu_nkmp.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.c b/drivers/clk/sunxi-ng/ccu_nkmp.c
index e58c95787f94..a99068a08315 100644
--- a/drivers/clk/sunxi-ng/ccu_nkmp.c
+++ b/drivers/clk/sunxi-ng/ccu_nkmp.c
@@ -134,6 +134,7 @@ static int ccu_nkmp_set_rate(struct clk_hw *hw, unsigned long rate,
 			   unsigned long parent_rate)
 {
 	struct ccu_nkmp *nkmp = hw_to_ccu_nkmp(hw);
+	u32 n_mask, k_mask, m_mask, p_mask;
 	struct _ccu_nkmp _nkmp;
 	unsigned long flags;
 	u32 reg;
@@ -149,18 +150,20 @@ static int ccu_nkmp_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	ccu_nkmp_find_best(parent_rate, rate, &_nkmp);
 
+	n_mask = GENMASK(nkmp->n.width + nkmp->n.shift - 1, nkmp->n.shift);
+	k_mask = GENMASK(nkmp->k.width + nkmp->k.shift - 1, nkmp->k.shift);
+	m_mask = GENMASK(nkmp->m.width + nkmp->m.shift - 1, nkmp->m.shift);
+	p_mask = GENMASK(nkmp->p.width + nkmp->p.shift - 1, nkmp->p.shift);
+
 	spin_lock_irqsave(nkmp->common.lock, flags);
 
 	reg = readl(nkmp->common.base + nkmp->common.reg);
-	reg &= ~GENMASK(nkmp->n.width + nkmp->n.shift - 1, nkmp->n.shift);
-	reg &= ~GENMASK(nkmp->k.width + nkmp->k.shift - 1, nkmp->k.shift);
-	reg &= ~GENMASK(nkmp->m.width + nkmp->m.shift - 1, nkmp->m.shift);
-	reg &= ~GENMASK(nkmp->p.width + nkmp->p.shift - 1, nkmp->p.shift);
-
-	reg |= (_nkmp.n - nkmp->n.offset) << nkmp->n.shift;
-	reg |= (_nkmp.k - nkmp->k.offset) << nkmp->k.shift;
-	reg |= (_nkmp.m - nkmp->m.offset) << nkmp->m.shift;
-	reg |= ilog2(_nkmp.p) << nkmp->p.shift;
+	reg &= ~(n_mask | k_mask | m_mask | p_mask);
+
+	reg |= ((_nkmp.n - nkmp->n.offset) << nkmp->n.shift) & n_mask;
+	reg |= ((_nkmp.k - nkmp->k.offset) << nkmp->k.shift) & k_mask;
+	reg |= ((_nkmp.m - nkmp->m.offset) << nkmp->m.shift) & m_mask;
+	reg |= (ilog2(_nkmp.p) << nkmp->p.shift) & p_mask;
 
 	writel(reg, nkmp->common.base + nkmp->common.reg);
 
-- 
2.16.1
