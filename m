Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF3BC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344B821EB7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 344B821EB7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732615AbeHITSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 15:18:18 -0400
Received: from mailoutvs28.siol.net ([185.57.226.219]:43609 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730634AbeHITSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 15:18:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id C760952181D;
        Thu,  9 Aug 2018 18:52:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jm1nDHjC2-tj; Thu,  9 Aug 2018 18:52:32 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 45D34523069;
        Thu,  9 Aug 2018 18:52:32 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id A502652181D;
        Thu,  9 Aug 2018 18:52:28 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        jernej.skrabec@siol.net
Subject: [PATCH 1/5] clk: sunxi-ng: Add maximum rate constraint to NM PLLs
Date:   Thu,  9 Aug 2018 18:52:13 +0200
Message-Id: <20180809165217.30680-2-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809165217.30680-1-jernej.skrabec@siol.net>
References: <20180809165217.30680-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some NM PLLs, frequency can be set above PLL working range.

Add a constraint for maximum supported rate. This way, drivers can
specify which is maximum allowed rate for PLL.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu_nm.c |  7 +++++++
 drivers/clk/sunxi-ng/ccu_nm.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
index 4e2073307f34..6fe3c14f7b2d 100644
--- a/drivers/clk/sunxi-ng/ccu_nm.c
+++ b/drivers/clk/sunxi-ng/ccu_nm.c
@@ -124,6 +124,13 @@ static long ccu_nm_round_rate(struct clk_hw *hw, unsigned long rate,
 		return rate;
 	}
 
+	if (nm->max_rate && rate > nm->max_rate) {
+		rate = nm->max_rate;
+		if (nm->common.features & CCU_FEATURE_FIXED_POSTDIV)
+			rate /= nm->fixed_post_div;
+		return rate;
+	}
+
 	if (ccu_frac_helper_has_rate(&nm->common, &nm->frac, rate)) {
 		if (nm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 			rate /= nm->fixed_post_div;
diff --git a/drivers/clk/sunxi-ng/ccu_nm.h b/drivers/clk/sunxi-ng/ccu_nm.h
index 1d8b459c50b7..de232f2199a6 100644
--- a/drivers/clk/sunxi-ng/ccu_nm.h
+++ b/drivers/clk/sunxi-ng/ccu_nm.h
@@ -38,6 +38,7 @@ struct ccu_nm {
 
 	unsigned int		fixed_post_div;
 	unsigned int		min_rate;
+	unsigned int		max_rate;
 
 	struct ccu_common	common;
 };
@@ -115,6 +116,35 @@ struct ccu_nm {
 		},							\
 	}
 
+#define SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX(_struct, _name,	\
+						 _parent, _reg,		\
+						 _min_rate, _max_rate,	\
+						 _nshift, _nwidth,	\
+						 _mshift, _mwidth,	\
+						 _frac_en, _frac_sel,	\
+						 _frac_rate_0,		\
+						 _frac_rate_1,		\
+						 _gate, _lock, _flags)	\
+	struct ccu_nm _struct = {					\
+		.enable		= _gate,				\
+		.lock		= _lock,				\
+		.n		= _SUNXI_CCU_MULT(_nshift, _nwidth),	\
+		.m		= _SUNXI_CCU_DIV(_mshift, _mwidth),	\
+		.frac		= _SUNXI_CCU_FRAC(_frac_en, _frac_sel,	\
+						  _frac_rate_0,		\
+						  _frac_rate_1),	\
+		.min_rate	= _min_rate,				\
+		.max_rate	= _max_rate,				\
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
2.18.0

