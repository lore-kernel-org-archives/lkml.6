Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752536AbeBSLXr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 06:23:47 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33738 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752606AbeBSLV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 06:21:56 -0500
X-Google-Smtp-Source: AH8x224lLEkOgQ3iJCm/A/csxTn4bas6cUDdDkp+o7oF7VUJNeAyI3bVSJZMEF1pbr9kYMjfljCo/Q==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] clk: meson: improve pll driver results with frac
Date: Mon, 19 Feb 2018 12:21:39 +0100
Message-Id: <20180219112146.21746-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180219112146.21746-1-jbrunet@baylibre.com>
References: <20180219112146.21746-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finding the appropriate settings of meson plls is too tricky to be done
entirely at runtime, using calculation only. Many combination of m, n
and od won't lock which is why we are using a table for this.  However,
for plls having a fractional parameters, it is possible to improve on
the result provided by the table by calculating the frac parameter.

This change adds the calculation of frac when the parameter is available
and the rate provided by the table is not an exact match for the
requested rate.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/clk-pll.c | 137 +++++++++++++++++++++++++++++---------------
 drivers/clk/meson/clkc.h    |  13 +----
 2 files changed, 91 insertions(+), 59 deletions(-)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index 0b9b4422c968..d58961f35b71 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -2,6 +2,9 @@
  * Copyright (c) 2015 Endless Mobile, Inc.
  * Author: Carlo Caione <carlo@endlessm.com>
  *
+ * Copyright (c) 2018 Baylibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
  * version 2, as published by the Free Software Foundation.
@@ -27,7 +30,7 @@
  *                |        |
  *               FREF     VCO
  *
- * out = (in * M / N) >> OD
+ * out = in * (m + frac / frac_max) / (n << sum(ods))
  */
 
 #include <linux/clk-provider.h>
@@ -48,73 +51,110 @@ meson_clk_pll_data(struct clk_regmap *clk)
 	return (struct meson_clk_pll_data *)clk->data;
 }
 
+static unsigned long __pll_params_to_rate(unsigned long parent_rate,
+					  const struct pll_rate_table *pllt,
+					  u16 frac,
+					  struct meson_clk_pll_data *pll)
+{
+	u64 rate = (u64)parent_rate * pllt->m;
+	unsigned int od = pllt->od + pllt->od2 + pllt->od3;
+
+	if (frac && MESON_PARM_APPLICABLE(&pll->frac)) {
+		u64 frac_rate = (u64)parent_rate * frac;
+
+		rate += DIV_ROUND_UP_ULL(frac_rate,
+					 (1 << pll->frac.width));
+	}
+
+	return DIV_ROUND_UP_ULL(rate, pllt->n << od);
+}
+
 static unsigned long meson_clk_pll_recalc_rate(struct clk_hw *hw,
 						unsigned long parent_rate)
 {
 	struct clk_regmap *clk = to_clk_regmap(hw);
 	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
-	u64 rate;
-	u16 n, m, frac = 0, od, od2 = 0, od3 = 0;
-
-	n = meson_parm_read(clk->map, &pll->n);
-	m = meson_parm_read(clk->map, &pll->m);
-	od = meson_parm_read(clk->map, &pll->od);
-
-	if (MESON_PARM_APPLICABLE(&pll->od2))
-		od2 = meson_parm_read(clk->map, &pll->od2);
+	struct pll_rate_table pllt;
+	u16 frac;
 
-	if (MESON_PARM_APPLICABLE(&pll->od3))
-		od3 = meson_parm_read(clk->map, &pll->od3);
+	pllt.n = meson_parm_read(clk->map, &pll->n);
+	pllt.m = meson_parm_read(clk->map, &pll->m);
+	pllt.od = meson_parm_read(clk->map, &pll->od);
 
-	rate = (u64)m * parent_rate;
+	pllt.od2 = MESON_PARM_APPLICABLE(&pll->od2) ?
+		meson_parm_read(clk->map, &pll->od2) :
+		0;
 
-	if (MESON_PARM_APPLICABLE(&pll->frac)) {
-		frac = meson_parm_read(clk->map, &pll->frac);
+	pllt.od3 = MESON_PARM_APPLICABLE(&pll->od3) ?
+		meson_parm_read(clk->map, &pll->od3) :
+		0;
 
-		rate += mul_u64_u32_shr(parent_rate, frac, pll->frac.width);
-	}
+	frac = MESON_PARM_APPLICABLE(&pll->frac) ?
+		meson_parm_read(clk->map, &pll->frac) :
+		0;
 
-	return div_u64(rate, n) >> od >> od2 >> od3;
+	return __pll_params_to_rate(parent_rate, &pllt, frac, pll);
 }
 
-static long meson_clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-				     unsigned long *parent_rate)
+static u16 __pll_params_with_frac(unsigned long rate,
+				  unsigned long parent_rate,
+				  const struct pll_rate_table *pllt,
+				  struct meson_clk_pll_data *pll)
 {
-	struct clk_regmap *clk = to_clk_regmap(hw);
-	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
-	const struct pll_rate_table *pllt;
-
-	/*
-	 * if the table is missing, just return the current rate
-	 * since we don't have the other available frequencies
-	 */
-	if (!pll->table)
-		return meson_clk_pll_recalc_rate(hw, *parent_rate);
+	u16 frac_max = (1 << pll->frac.width);
+	u64 val = (u64)rate * pllt->n;
 
-	for (pllt = pll->table; pllt->rate; pllt++) {
-		if (rate <= pllt->rate)
-			return pllt->rate;
-	}
+	val <<= pllt->od + pllt->od2 + pllt->od3;
+	val = div_u64(val * frac_max, parent_rate);
+	val -= pllt->m * frac_max;
 
-	/* else return the smallest value */
-	return pll->table[0].rate;
+	return min((u16)val, (u16)(frac_max - 1));
 }
 
 static const struct pll_rate_table *
-meson_clk_get_pll_settings(const struct pll_rate_table *table,
-			   unsigned long rate)
+meson_clk_get_pll_settings(unsigned long rate,
+			   struct meson_clk_pll_data *pll)
 {
-	const struct pll_rate_table *pllt;
+	const struct pll_rate_table *table = pll->table;
+	unsigned int i = 0;
 
 	if (!table)
 		return NULL;
 
-	for (pllt = table; pllt->rate; pllt++) {
-		if (rate == pllt->rate)
-			return pllt;
-	}
+	/* Find the first table element exceeding rate */
+	while (table[i].rate && table[i].rate <= rate)
+		i++;
+
+	/* Select the setting of the rounded down rate */
+	if (i != 0)
+		i--;
+
+	return (struct pll_rate_table *)&table[i];
+}
+
+static long meson_clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+				     unsigned long *parent_rate)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
+	const struct pll_rate_table *pllt =
+		meson_clk_get_pll_settings(rate, pll);
+	u16 frac;
+
+	if (!pllt)
+		return meson_clk_pll_recalc_rate(hw, *parent_rate);
+
+	if (!MESON_PARM_APPLICABLE(&pll->frac)
+	    || rate == pllt->rate)
+		return pllt->rate;
 
-	return NULL;
+	/*
+	 * The rate provided by the setting is not an exact match, let's
+	 * try to improve the result using the fractional parameter
+	 */
+	frac = __pll_params_with_frac(rate, *parent_rate, pllt, pll);
+
+	return __pll_params_to_rate(*parent_rate, pllt, frac, pll);
 }
 
 static int meson_clk_pll_wait_lock(struct clk_hw *hw)
@@ -154,13 +194,14 @@ static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
 	const struct pll_rate_table *pllt;
 	unsigned long old_rate;
+	u16 frac = 0;
 
 	if (parent_rate == 0 || rate == 0)
 		return -EINVAL;
 
 	old_rate = rate;
 
-	pllt = meson_clk_get_pll_settings(pll->table, rate);
+	pllt = meson_clk_get_pll_settings(rate, pll);
 	if (!pllt)
 		return -EINVAL;
 
@@ -177,8 +218,10 @@ static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (MESON_PARM_APPLICABLE(&pll->od3))
 		meson_parm_write(clk->map, &pll->od3, pllt->od3);
 
-	if (MESON_PARM_APPLICABLE(&pll->frac))
-		meson_parm_write(clk->map, &pll->frac, pllt->frac);
+	if (MESON_PARM_APPLICABLE(&pll->frac)) {
+		frac = __pll_params_with_frac(rate, parent_rate, pllt, pll);
+		meson_parm_write(clk->map, &pll->frac, frac);
+	}
 
 	/* make sure the reset is cleared at this point */
 	meson_parm_write(clk->map, &pll->rst, 0);
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index ebd88afe1eb5..9cdcd9b6c16c 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -61,7 +61,6 @@ struct pll_rate_table {
 	u16		od;
 	u16		od2;
 	u16		od3;
-	u16		frac;
 };
 
 #define PLL_RATE(_r, _m, _n, _od)					\
@@ -70,17 +69,7 @@ struct pll_rate_table {
 		.m		= (_m),					\
 		.n		= (_n),					\
 		.od		= (_od),				\
-	}								\
-
-#define PLL_FRAC_RATE(_r, _m, _n, _od, _od2, _frac)			\
-	{								\
-		.rate		= (_r),					\
-		.m		= (_m),					\
-		.n		= (_n),					\
-		.od		= (_od),				\
-		.od2		= (_od2),				\
-		.frac		= (_frac),				\
-	}								\
+	}
 
 struct meson_clk_pll_data {
 	struct parm m;
-- 
2.14.3
