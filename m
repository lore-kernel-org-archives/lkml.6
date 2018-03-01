Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162182AbeCAVk7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:40:59 -0500
Received: from mailoutvs4.siol.net ([213.250.19.137]:33025 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1162062AbeCAVe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:34:57 -0500
From: Jernej Skrabec <jernej.skrabec@siol.net>
To: maxime.ripard@free-electrons.com, wens@csie.org, airlied@linux.ie,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org
Cc: jernej.skrabec@siol.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 01/16] clk: sunxi-ng: Add check for minimal rate to NM PLLs
Date: Thu,  1 Mar 2018 22:34:27 +0100
Message-Id: <20180301213442.16677-2-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180301213442.16677-1-jernej.skrabec@siol.net>
References: <20180301213442.16677-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some NM PLLs doesn't work well when their output clock rate is set below
certain rate.

Add support for that constrain.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu_nm.c |  7 +++++++
 drivers/clk/sunxi-ng/ccu_nm.h | 27 +++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
index a16de092bf94..4e2073307f34 100644
--- a/drivers/clk/sunxi-ng/ccu_nm.c
+++ b/drivers/clk/sunxi-ng/ccu_nm.c
@@ -117,6 +117,13 @@ static long ccu_nm_round_rate(struct clk_hw *hw, unsigned long rate,
 	if (nm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate *= nm->fixed_post_div;
 
+	if (rate < nm->min_rate) {
+		rate = nm->min_rate;
+		if (nm->common.features & CCU_FEATURE_FIXED_POSTDIV)
+			rate /= nm->fixed_post_div;
+		return rate;
+	}
+
 	if (ccu_frac_helper_has_rate(&nm->common, &nm->frac, rate)) {
 		if (nm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 			rate /= nm->fixed_post_div;
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
