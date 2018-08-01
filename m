Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE5CC46465
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2680208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lnueAZA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2680208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389558AbeHAPrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:47:05 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:37142 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389532AbeHAPrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:47:04 -0400
Received: by mail-wr1-f44.google.com with SMTP id u12-v6so1913916wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 07:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4c5uxSYxU3Q8UCIWSTlQNK284avOwd3qgO13oKZx4L4=;
        b=lnueAZA89eV+P1vFMPb3PKft3nYNv+OBVWK+LoohuSinbbewO5wJeWWObJNoA21FCm
         Vkp0saFxuGw3slnavP79lz5Gm4TSFdJIpcsoPjmP0hjf4jqzUjmPTEoj5xtPhWK7qter
         RZRF96aQVOlUcjH2YisBqwfZIzoduv3a6oZ7P5t66/pCOrElc12TrMWgtRUsOo4TRO6q
         EyZ5isGXy9XjJM1rHbC2w45/VWqzNdUhm/Pyg+qNB50qr8fAtp3MdRLsT527HrcmLL7j
         34DhNLmpXnCtwtnHVJC8e6AV6cjBh28xOEI/9cPDTDaJaw3rP1psH8x/NGI5JfMxcgS0
         QCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4c5uxSYxU3Q8UCIWSTlQNK284avOwd3qgO13oKZx4L4=;
        b=ZCglhvncwOaGoTvtHW/Nct1zdHwohtWVvy6hHW/tx6GUfAuMQu17A9OVavVvspnxLn
         xcYslNDLPLmICRdA3YuEJGb6CHfWaBsMaUGeJV0/a31h6ZtEx5xyExgOvi42HOOdQMY7
         JUwFYytJn+PUGtFq1kBs0OxvzYdzfsJUcnMKa1N0agXC/XSk4iBTSO9ynLt0tWrSYwY4
         Dqg9hAbjdxRoboRP6jxk8o9pTI9nG1UDdvka+EXhh3YVaPYMphTJHlzVa+vIlMgMe7+1
         RI3YhKKbfRnsv5063t3TWPcRqpa7Z01XBEJ50JxIaVCcL0yAyM6Mueiju80biT0dFf4n
         SxPg==
X-Gm-Message-State: AOUpUlEusa/mmiAh6qkOter4DUVBOQx6BjZdYci6mviQ6mSa1Lh7N0fy
        +WW5owMA0RbcMMMULHxB89VZZA==
X-Google-Smtp-Source: AAOMgpcx10DKdPAugv4VX5Y292OMjljKk14WRVk+fGBYaW8KT8JShtyZ8inoflEL1XGgXk+OD1RlxA==
X-Received: by 2002:a5d:480d:: with SMTP id l13-v6mr25594381wrq.234.1533132067556;
        Wed, 01 Aug 2018 07:01:07 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id d42-v6sm2816309wma.0.2018.08.01.07.01.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 07:01:05 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 4/4] clk: meson: clk-pll: drop hard-coded rates from pll tables
Date:   Wed,  1 Aug 2018 16:00:53 +0200
Message-Id: <20180801140053.25899-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801140053.25899-1-jbrunet@baylibre.com>
References: <20180801140053.25899-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Putting hard-coded rates inside the parameter tables assumes that
the parent is known and will never change. That's a big assumption
we should not make.

We have everything we need to recalculate the output rate using
the parent rate and the rest of the parameters. Let's do so and
drop the rates from the tables.

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg.c     |  73 +++++++++++-----------
 drivers/clk/meson/clk-pll.c |  69 ++++++++++++++-------
 drivers/clk/meson/clkc.h    |   8 +--
 drivers/clk/meson/gxbb.c    | 120 ++++++++++++++++++------------------
 drivers/clk/meson/meson8b.c |  34 +++++-----
 5 files changed, 162 insertions(+), 142 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index a5e4f7b22f39..7511b3e26d40 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -134,36 +134,36 @@ static struct clk_regmap axg_sys_pll = {
 	},
 };
 
-static const struct pll_rate_table axg_gp0_pll_rate_table[] = {
-	PLL_RATE(960000000, 40, 1),
-	PLL_RATE(984000000, 41, 1),
-	PLL_RATE(1008000000, 42, 1),
-	PLL_RATE(1032000000, 43, 1),
-	PLL_RATE(1056000000, 44, 1),
-	PLL_RATE(1080000000, 45, 1),
-	PLL_RATE(1104000000, 46, 1),
-	PLL_RATE(1128000000, 47, 1),
-	PLL_RATE(1152000000, 48, 1),
-	PLL_RATE(1176000000, 49, 1),
-	PLL_RATE(1200000000, 50, 1),
-	PLL_RATE(1224000000, 51, 1),
-	PLL_RATE(1248000000, 52, 1),
-	PLL_RATE(1272000000, 53, 1),
-	PLL_RATE(1296000000, 54, 1),
-	PLL_RATE(1320000000, 55, 1),
-	PLL_RATE(1344000000, 56, 1),
-	PLL_RATE(1368000000, 57, 1),
-	PLL_RATE(1392000000, 58, 1),
-	PLL_RATE(1416000000, 59, 1),
-	PLL_RATE(1440000000, 60, 1),
-	PLL_RATE(1464000000, 61, 1),
-	PLL_RATE(1488000000, 62, 1),
-	PLL_RATE(1512000000, 63, 1),
-	PLL_RATE(1536000000, 64, 1),
-	PLL_RATE(1560000000, 65, 1),
-	PLL_RATE(1584000000, 66, 1),
-	PLL_RATE(1608000000, 67, 1),
-	PLL_RATE(1632000000, 68, 1),
+static const struct pll_params_table axg_gp0_pll_params_table[] = {
+	PLL_PARAMS(40, 1),
+	PLL_PARAMS(41, 1),
+	PLL_PARAMS(42, 1),
+	PLL_PARAMS(43, 1),
+	PLL_PARAMS(44, 1),
+	PLL_PARAMS(45, 1),
+	PLL_PARAMS(46, 1),
+	PLL_PARAMS(47, 1),
+	PLL_PARAMS(48, 1),
+	PLL_PARAMS(49, 1),
+	PLL_PARAMS(50, 1),
+	PLL_PARAMS(51, 1),
+	PLL_PARAMS(52, 1),
+	PLL_PARAMS(53, 1),
+	PLL_PARAMS(54, 1),
+	PLL_PARAMS(55, 1),
+	PLL_PARAMS(56, 1),
+	PLL_PARAMS(57, 1),
+	PLL_PARAMS(58, 1),
+	PLL_PARAMS(59, 1),
+	PLL_PARAMS(60, 1),
+	PLL_PARAMS(61, 1),
+	PLL_PARAMS(62, 1),
+	PLL_PARAMS(63, 1),
+	PLL_PARAMS(64, 1),
+	PLL_PARAMS(65, 1),
+	PLL_PARAMS(66, 1),
+	PLL_PARAMS(67, 1),
+	PLL_PARAMS(68, 1),
 	{ /* sentinel */ },
 };
 
@@ -207,7 +207,7 @@ static struct clk_regmap axg_gp0_pll_dco = {
 			.shift   = 29,
 			.width   = 1,
 		},
-		.table = axg_gp0_pll_rate_table,
+		.table = axg_gp0_pll_params_table,
 		.init_regs = axg_gp0_init_regs,
 		.init_count = ARRAY_SIZE(axg_gp0_init_regs),
 	},
@@ -275,7 +275,7 @@ static struct clk_regmap axg_hifi_pll_dco = {
 			.shift   = 29,
 			.width   = 1,
 		},
-		.table = axg_gp0_pll_rate_table,
+		.table = axg_gp0_pll_params_table,
 		.init_regs = axg_hifi_init_regs,
 		.init_count = ARRAY_SIZE(axg_hifi_init_regs),
 		.flags = CLK_MESON_PLL_ROUND_CLOSEST,
@@ -631,11 +631,10 @@ static struct clk_regmap axg_mpll3 = {
 	},
 };
 
-static const struct pll_rate_table axg_pcie_pll_rate_table[] = {
+static const struct pll_params_table axg_pcie_pll_params_table[] = {
 	{
-		.rate	= 1600000000,
-		.m	= 200,
-		.n	= 3,
+		.m = 200,
+		.n = 3,
 	},
 	{ /* sentinel */ },
 };
@@ -682,7 +681,7 @@ static struct clk_regmap axg_pcie_pll_dco = {
 			.shift   = 29,
 			.width   = 1,
 		},
-		.table = axg_pcie_pll_rate_table,
+		.table = axg_pcie_pll_params_table,
 		.init_regs = axg_pcie_init_regs,
 		.init_count = ARRAY_SIZE(axg_pcie_init_regs),
 	},
diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index 348a866f09eb..f5b5b3fabe3c 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -45,7 +45,7 @@ meson_clk_pll_data(struct clk_regmap *clk)
 }
 
 static unsigned long __pll_params_to_rate(unsigned long parent_rate,
-					  const struct pll_rate_table *pllt,
+					  const struct pll_params_table *pllt,
 					  u16 frac,
 					  struct meson_clk_pll_data *pll)
 {
@@ -66,7 +66,7 @@ static unsigned long meson_clk_pll_recalc_rate(struct clk_hw *hw,
 {
 	struct clk_regmap *clk = to_clk_regmap(hw);
 	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
-	struct pll_rate_table pllt;
+	struct pll_params_table pllt;
 	u16 frac;
 
 	pllt.n = meson_parm_read(clk->map, &pll->n);
@@ -81,7 +81,7 @@ static unsigned long meson_clk_pll_recalc_rate(struct clk_hw *hw,
 
 static u16 __pll_params_with_frac(unsigned long rate,
 				  unsigned long parent_rate,
-				  const struct pll_rate_table *pllt,
+				  const struct pll_params_table *pllt,
 				  struct meson_clk_pll_data *pll)
 {
 	u16 frac_max = (1 << pll->frac.width);
@@ -97,29 +97,50 @@ static u16 __pll_params_with_frac(unsigned long rate,
 	return min((u16)val, (u16)(frac_max - 1));
 }
 
-static const struct pll_rate_table *
+static bool meson_clk_pll_is_better(unsigned long rate,
+				    unsigned long best,
+				    unsigned long now,
+				    struct meson_clk_pll_data *pll)
+{
+	if (!(pll->flags & CLK_MESON_PLL_ROUND_CLOSEST) ||
+	    MESON_PARM_APPLICABLE(&pll->frac)) {
+		/* Round down */
+		if (now < rate && best < now)
+			return true;
+	} else {
+		/* Round Closest */
+		if (abs(now - rate) < abs(best - rate))
+			return true;
+	}
+
+	return false;
+}
+
+static const struct pll_params_table *
 meson_clk_get_pll_settings(unsigned long rate,
+			   unsigned long parent_rate,
 			   struct meson_clk_pll_data *pll)
 {
-	const struct pll_rate_table *table = pll->table;
-	unsigned int i = 0;
+	const struct pll_params_table *table = pll->table;
+	unsigned long best = 0, now = 0;
+	unsigned int i, best_i = 0;
 
 	if (!table)
 		return NULL;
 
-	/* Find the first table element exceeding rate */
-	while (table[i].rate && table[i].rate <= rate)
-		i++;
+	for (i = 0; table[i].n; i++) {
+		now = __pll_params_to_rate(parent_rate, &table[i], 0, pll);
 
-	if (i != 0) {
-		if (MESON_PARM_APPLICABLE(&pll->frac) ||
-		    !(pll->flags & CLK_MESON_PLL_ROUND_CLOSEST) ||
-		    (abs(rate - table[i - 1].rate) <
-		     abs(rate - table[i].rate)))
-			i--;
+		/* If we get an exact match, don't bother any further */
+		if (now == rate) {
+			return &table[i];
+		} else if (meson_clk_pll_is_better(rate, best, now, pll)) {
+			best = now;
+			best_i = i;
+		}
 	}
 
-	return (struct pll_rate_table *)&table[i];
+	return (struct pll_params_table *)&table[best_i];
 }
 
 static long meson_clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
@@ -127,16 +148,18 @@ static long meson_clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct clk_regmap *clk = to_clk_regmap(hw);
 	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
-	const struct pll_rate_table *pllt =
-		meson_clk_get_pll_settings(rate, pll);
+	const struct pll_params_table *pllt =
+		meson_clk_get_pll_settings(rate, *parent_rate, pll);
+	unsigned long round;
 	u16 frac;
 
 	if (!pllt)
 		return meson_clk_pll_recalc_rate(hw, *parent_rate);
 
-	if (!MESON_PARM_APPLICABLE(&pll->frac)
-	    || rate == pllt->rate)
-		return pllt->rate;
+	round = __pll_params_to_rate(*parent_rate, pllt, 0, pll);
+
+	if (!MESON_PARM_APPLICABLE(&pll->frac) || rate == round)
+		return round;
 
 	/*
 	 * The rate provided by the setting is not an exact match, let's
@@ -214,7 +237,7 @@ static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct clk_regmap *clk = to_clk_regmap(hw);
 	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
-	const struct pll_rate_table *pllt;
+	const struct pll_params_table *pllt;
 	unsigned int enabled;
 	unsigned long old_rate;
 	u16 frac = 0;
@@ -224,7 +247,7 @@ static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	old_rate = rate;
 
-	pllt = meson_clk_get_pll_settings(rate, pll);
+	pllt = meson_clk_get_pll_settings(rate, parent_rate, pll);
 	if (!pllt)
 		return -EINVAL;
 
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index a2245e857f70..6b96d55c047d 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -43,15 +43,13 @@ static inline void meson_parm_write(struct regmap *map, struct parm *p,
 }
 
 
-struct pll_rate_table {
-	unsigned long	rate;
+struct pll_params_table {
 	u16		m;
 	u16		n;
 };
 
-#define PLL_RATE(_r, _m, _n)						\
+#define PLL_PARAMS(_m, _n)						\
 	{								\
-		.rate		= (_r),					\
 		.m		= (_m),					\
 		.n		= (_n),					\
 	}
@@ -67,7 +65,7 @@ struct meson_clk_pll_data {
 	struct parm rst;
 	const struct reg_sequence *init_regs;
 	unsigned int init_count;
-	const struct pll_rate_table *table;
+	const struct pll_params_table *table;
 	u8 flags;
 };
 
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index af59f2607dc1..9309cfaaa464 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -18,67 +18,67 @@
 
 static DEFINE_SPINLOCK(meson_clk_lock);
 
-static const struct pll_rate_table gxbb_gp0_pll_rate_table[] = {
-	PLL_RATE(768000000, 32, 1),
-	PLL_RATE(792000000, 33, 1),
-	PLL_RATE(816000000, 34, 1),
-	PLL_RATE(840000000, 35, 1),
-	PLL_RATE(864000000, 36, 1),
-	PLL_RATE(888000000, 37, 1),
-	PLL_RATE(912000000, 38, 1),
-	PLL_RATE(936000000, 39, 1),
-	PLL_RATE(960000000, 40, 1),
-	PLL_RATE(984000000, 41, 1),
-	PLL_RATE(1008000000, 42, 1),
-	PLL_RATE(1032000000, 43, 1),
-	PLL_RATE(1056000000, 44, 1),
-	PLL_RATE(1080000000, 45, 1),
-	PLL_RATE(1104000000, 46, 1),
-	PLL_RATE(1128000000, 47, 1),
-	PLL_RATE(1152000000, 48, 1),
-	PLL_RATE(1176000000, 49, 1),
-	PLL_RATE(1200000000, 50, 1),
-	PLL_RATE(1224000000, 51, 1),
-	PLL_RATE(1248000000, 52, 1),
-	PLL_RATE(1272000000, 53, 1),
-	PLL_RATE(1296000000, 54, 1),
-	PLL_RATE(1320000000, 55, 1),
-	PLL_RATE(1344000000, 56, 1),
-	PLL_RATE(1368000000, 57, 1),
-	PLL_RATE(1392000000, 58, 1),
-	PLL_RATE(1416000000, 59, 1),
-	PLL_RATE(1440000000, 60, 1),
-	PLL_RATE(1464000000, 61, 1),
-	PLL_RATE(1488000000, 62, 1),
+static const struct pll_params_table gxbb_gp0_pll_params_table[] = {
+	PLL_PARAMS(32, 1),
+	PLL_PARAMS(33, 1),
+	PLL_PARAMS(34, 1),
+	PLL_PARAMS(35, 1),
+	PLL_PARAMS(36, 1),
+	PLL_PARAMS(37, 1),
+	PLL_PARAMS(38, 1),
+	PLL_PARAMS(39, 1),
+	PLL_PARAMS(40, 1),
+	PLL_PARAMS(41, 1),
+	PLL_PARAMS(42, 1),
+	PLL_PARAMS(43, 1),
+	PLL_PARAMS(44, 1),
+	PLL_PARAMS(45, 1),
+	PLL_PARAMS(46, 1),
+	PLL_PARAMS(47, 1),
+	PLL_PARAMS(48, 1),
+	PLL_PARAMS(49, 1),
+	PLL_PARAMS(50, 1),
+	PLL_PARAMS(51, 1),
+	PLL_PARAMS(52, 1),
+	PLL_PARAMS(53, 1),
+	PLL_PARAMS(54, 1),
+	PLL_PARAMS(55, 1),
+	PLL_PARAMS(56, 1),
+	PLL_PARAMS(57, 1),
+	PLL_PARAMS(58, 1),
+	PLL_PARAMS(59, 1),
+	PLL_PARAMS(60, 1),
+	PLL_PARAMS(61, 1),
+	PLL_PARAMS(62, 1),
 	{ /* sentinel */ },
 };
 
-static const struct pll_rate_table gxl_gp0_pll_rate_table[] = {
-	PLL_RATE(1008000000, 42, 1),
-	PLL_RATE(1032000000, 43, 1),
-	PLL_RATE(1056000000, 44, 1),
-	PLL_RATE(1080000000, 45, 1),
-	PLL_RATE(1104000000, 46, 1),
-	PLL_RATE(1128000000, 47, 1),
-	PLL_RATE(1152000000, 48, 1),
-	PLL_RATE(1176000000, 49, 1),
-	PLL_RATE(1200000000, 50, 1),
-	PLL_RATE(1224000000, 51, 1),
-	PLL_RATE(1248000000, 52, 1),
-	PLL_RATE(1272000000, 53, 1),
-	PLL_RATE(1296000000, 54, 1),
-	PLL_RATE(1320000000, 55, 1),
-	PLL_RATE(1344000000, 56, 1),
-	PLL_RATE(1368000000, 57, 1),
-	PLL_RATE(1392000000, 58, 1),
-	PLL_RATE(1416000000, 59, 1),
-	PLL_RATE(1440000000, 60, 1),
-	PLL_RATE(1464000000, 61, 1),
-	PLL_RATE(1488000000, 62, 1),
-	PLL_RATE(1512000000, 63, 1),
-	PLL_RATE(1536000000, 64, 1),
-	PLL_RATE(1560000000, 65, 1),
-	PLL_RATE(1584000000, 66, 1),
+static const struct pll_params_table gxl_gp0_pll_params_table[] = {
+	PLL_PARAMS(42, 1),
+	PLL_PARAMS(43, 1),
+	PLL_PARAMS(44, 1),
+	PLL_PARAMS(45, 1),
+	PLL_PARAMS(46, 1),
+	PLL_PARAMS(47, 1),
+	PLL_PARAMS(48, 1),
+	PLL_PARAMS(49, 1),
+	PLL_PARAMS(50, 1),
+	PLL_PARAMS(51, 1),
+	PLL_PARAMS(52, 1),
+	PLL_PARAMS(53, 1),
+	PLL_PARAMS(54, 1),
+	PLL_PARAMS(55, 1),
+	PLL_PARAMS(56, 1),
+	PLL_PARAMS(57, 1),
+	PLL_PARAMS(58, 1),
+	PLL_PARAMS(59, 1),
+	PLL_PARAMS(60, 1),
+	PLL_PARAMS(61, 1),
+	PLL_PARAMS(62, 1),
+	PLL_PARAMS(63, 1),
+	PLL_PARAMS(64, 1),
+	PLL_PARAMS(65, 1),
+	PLL_PARAMS(66, 1),
 	{ /* sentinel */ },
 };
 
@@ -380,7 +380,7 @@ static struct clk_regmap gxbb_gp0_pll_dco = {
 			.shift   = 29,
 			.width   = 1,
 		},
-		.table = gxbb_gp0_pll_rate_table,
+		.table = gxbb_gp0_pll_params_table,
 		.init_regs = gxbb_gp0_init_regs,
 		.init_count = ARRAY_SIZE(gxbb_gp0_init_regs),
 	},
@@ -432,7 +432,7 @@ static struct clk_regmap gxl_gp0_pll_dco = {
 			.shift   = 29,
 			.width   = 1,
 		},
-		.table = gxl_gp0_pll_rate_table,
+		.table = gxl_gp0_pll_params_table,
 		.init_regs = gxl_gp0_init_regs,
 		.init_count = ARRAY_SIZE(gxl_gp0_init_regs),
 	},
diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 4c061c1d3683..978485146ec3 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -29,22 +29,22 @@ struct meson8b_clk_reset {
 	void __iomem *base;
 };
 
-static const struct pll_rate_table sys_pll_rate_table[] = {
-	PLL_RATE(1200000000, 50, 1),
-	PLL_RATE(1224000000, 51, 1),
-	PLL_RATE(1248000000, 52, 1),
-	PLL_RATE(1272000000, 53, 1),
-	PLL_RATE(1296000000, 54, 1),
-	PLL_RATE(1320000000, 55, 1),
-	PLL_RATE(1344000000, 56, 1),
-	PLL_RATE(1368000000, 57, 1),
-	PLL_RATE(1392000000, 58, 1),
-	PLL_RATE(1416000000, 59, 1),
-	PLL_RATE(1440000000, 60, 1),
-	PLL_RATE(1464000000, 61, 1),
-	PLL_RATE(1488000000, 62, 1),
-	PLL_RATE(1512000000, 63, 1),
-	PLL_RATE(1536000000, 64, 1),
+static const struct pll_params_table sys_pll_params_table[] = {
+	PLL_PARAMS(50, 1),
+	PLL_PARAMS(51, 1),
+	PLL_PARAMS(52, 1),
+	PLL_PARAMS(53, 1),
+	PLL_PARAMS(54, 1),
+	PLL_PARAMS(55, 1),
+	PLL_PARAMS(56, 1),
+	PLL_PARAMS(57, 1),
+	PLL_PARAMS(58, 1),
+	PLL_PARAMS(59, 1),
+	PLL_PARAMS(60, 1),
+	PLL_PARAMS(61, 1),
+	PLL_PARAMS(62, 1),
+	PLL_PARAMS(63, 1),
+	PLL_PARAMS(64, 1),
 	{ /* sentinel */ },
 };
 
@@ -196,7 +196,7 @@ static struct clk_regmap meson8b_sys_pll_dco = {
 			.shift   = 29,
 			.width   = 1,
 		},
-		.table = sys_pll_rate_table,
+		.table = sys_pll_params_table,
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "sys_pll_dco",
-- 
2.17.1

