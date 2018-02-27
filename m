Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752204AbeB0Wcp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:32:45 -0500
Received: from mailoutvs4.siol.net ([213.250.19.137]:60337 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751876AbeB0W13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:27:29 -0500
From: Jernej Skrabec <jernej.skrabec@siol.net>
To: maxime.ripard@free-electrons.com, wens@csie.org, airlied@linux.ie,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org
Cc: jernej.skrabec@siol.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v2 01/16] clk: sunxi-ng: Add check for minimal rate to NM PLLs
Date: Tue, 27 Feb 2018 23:26:46 +0100
Message-Id: <20180227222701.9716-2-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180227222701.9716-1-jernej.skrabec@siol.net>
References: <20180227222701.9716-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some NM PLLs doesn't work well when their output clock rate is set below
certain rate.

Add support for that constrain.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu_nm.c | 11 +++++++----
 drivers/clk/sunxi-ng/ccu_nm.h | 27 +++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
index a16de092bf94..7fc743c78c1b 100644
--- a/drivers/clk/sunxi-ng/ccu_nm.c
+++ b/drivers/clk/sunxi-ng/ccu_nm.c
@@ -20,7 +20,7 @@ struct _ccu_nm {
 };
 
 static void ccu_nm_find_best(unsigned long parent, unsigned long rate,
-			     struct _ccu_nm *nm)
+			     unsigned long min_rate, struct _ccu_nm *nm)
 {
 	unsigned long best_rate = 0;
 	unsigned long best_n = 0, best_m = 0;
@@ -30,7 +30,7 @@ static void ccu_nm_find_best(unsigned long parent, unsigned long rate,
 		for (_m = nm->min_m; _m <= nm->max_m; _m++) {
 			unsigned long tmp_rate = parent * _n  / _m;
 
-			if (tmp_rate > rate)
+			if (tmp_rate > rate || tmp_rate < min_rate)
 				continue;
 
 			if ((rate - tmp_rate) < (rate - best_rate)) {
@@ -117,6 +117,9 @@ static long ccu_nm_round_rate(struct clk_hw *hw, unsigned long rate,
 	if (nm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate *= nm->fixed_post_div;
 
+	if (rate < nm->min_rate)
+		rate = nm->min_rate;
+
 	if (ccu_frac_helper_has_rate(&nm->common, &nm->frac, rate)) {
 		if (nm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 			rate /= nm->fixed_post_div;
@@ -134,7 +137,7 @@ static long ccu_nm_round_rate(struct clk_hw *hw, unsigned long rate,
 	_nm.min_m = 1;
 	_nm.max_m = nm->m.max ?: 1 << nm->m.width;
 
-	ccu_nm_find_best(*parent_rate, rate, &_nm);
+	ccu_nm_find_best(*parent_rate, rate, nm->min_rate, &_nm);
 	rate = *parent_rate * _nm.n / _nm.m;
 
 	if (nm->common.features & CCU_FEATURE_FIXED_POSTDIV)
@@ -186,7 +189,7 @@ static int ccu_nm_set_rate(struct clk_hw *hw, unsigned long rate,
 					   &_nm.m, &_nm.n);
 	} else {
 		ccu_sdm_helper_disable(&nm->common, &nm->sdm);
-		ccu_nm_find_best(parent_rate, rate, &_nm);
+		ccu_nm_find_best(parent_rate, rate, nm->min_rate, &_nm);
 	}
 
 	spin_lock_irqsave(nm->common.lock, flags);
diff --git a/drivers/clk/sunxi-ng/ccu_nm.h b/drivers/clk/sunxi-ng/ccu_nm.h
index eba586b4c7d0..1d8b459c50b7 100644
--- a/drivers/clk/sunxi-ng/ccu_nm.h
+++ b/drivers/clk/sunxi-ng/ccu_nm.h
@@ -37,6 +37,7 @@ struct ccu_nm {
 	struct ccu_sdm_internal		sdm;
 
 	unsigned int		fixed_post_div;
+	unsigned int		min_rate;
 
 	struct ccu_common	common;
 };
@@ -88,6 +89,32 @@ struct ccu_nm {
 		},							\
 	}
 
+#define SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN(_struct, _name, _parent,	\
+					     _reg, _min_rate,		\
+					     _nshift, _nwidth,		\
+					     _mshift, _mwidth,		\
+					     _frac_en, _frac_sel,	\
+					     _frac_rate_0, _frac_rate_1,\
+					     _gate, _lock, _flags)	\
+	struct ccu_nm _struct = {					\
+		.enable		= _gate,				\
+		.lock		= _lock,				\
+		.n		= _SUNXI_CCU_MULT(_nshift, _nwidth),	\
+		.m		= _SUNXI_CCU_DIV(_mshift, _mwidth),	\
+		.frac		= _SUNXI_CCU_FRAC(_frac_en, _frac_sel,	\
+						  _frac_rate_0,		\
+						  _frac_rate_1),	\
+		.min_rate	= _min_rate,				\
+		.common		= {					\
+			.reg		= _reg,				\
+			.features	= CCU_FEATURE_FRACTIONAL,	\
+			.hw.init	= CLK_HW_INIT(_name,		\
+						      _parent,		\
+						      &ccu_nm_ops,	\
+						      _flags),		\
+		},							\
+	}
+
 #define SUNXI_CCU_NM_WITH_GATE_LOCK(_struct, _name, _parent, _reg,	\
 				    _nshift, _nwidth,			\
 				    _mshift, _mwidth,			\
-- 
2.16.2
