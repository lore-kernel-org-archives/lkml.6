Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932116AbeEOQhY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 12:37:24 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36859 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752750AbeEOQhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 12:37:00 -0400
X-Google-Smtp-Source: AB8JxZqplFPL0N9JF8E+5qDpYKgX8criJWrFlFCMLSV6sOnoKY4wtaIusIb60us4jnFv3f6jDD4o8g==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] clk: meson: mpll: add round closest support
Date: Tue, 15 May 2018 18:36:51 +0200
Message-Id: <20180515163652.19980-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180515163652.19980-1-jbrunet@baylibre.com>
References: <20180515163652.19980-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the mpll driver to round the requested rate up if
CLK_MESON_MPLL_ROUND_CLOSEST is set and it provides a rate closer to the
requested rate.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/clk-mpll.c | 24 +++++++++++++++++++-----
 drivers/clk/meson/clkc.h     |  3 +++
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/meson/clk-mpll.c b/drivers/clk/meson/clk-mpll.c
index 0df1227b65b3..d233549de244 100644
--- a/drivers/clk/meson/clk-mpll.c
+++ b/drivers/clk/meson/clk-mpll.c
@@ -89,10 +89,23 @@ static long rate_from_params(unsigned long parent_rate,
 static void params_from_rate(unsigned long requested_rate,
 			     unsigned long parent_rate,
 			     unsigned int *sdm,
-			     unsigned int *n2)
+			     unsigned int *n2,
+			     u8 flags)
 {
 	uint64_t div = parent_rate;
-	unsigned long rem = do_div(div, requested_rate);
+	uint64_t frac = do_div(div, requested_rate);
+
+	frac *= SDM_DEN;
+
+	if (flags & CLK_MESON_MPLL_ROUND_CLOSEST)
+		*sdm = DIV_ROUND_CLOSEST_ULL(frac, requested_rate);
+	else
+		*sdm = DIV_ROUND_UP_ULL(frac, requested_rate);
+
+	if (*sdm == SDM_DEN) {
+		*sdm = 0;
+		div += 1;
+	}
 
 	if (div < N2_MIN) {
 		*n2 = N2_MIN;
@@ -102,7 +115,6 @@ static void params_from_rate(unsigned long requested_rate,
 		*sdm = SDM_DEN - 1;
 	} else {
 		*n2 = div;
-		*sdm = DIV_ROUND_UP_ULL((u64)rem * SDM_DEN, requested_rate);
 	}
 }
 
@@ -125,9 +137,11 @@ static long mpll_round_rate(struct clk_hw *hw,
 			    unsigned long rate,
 			    unsigned long *parent_rate)
 {
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_mpll_data *mpll = meson_clk_mpll_data(clk);
 	unsigned int sdm, n2;
 
-	params_from_rate(rate, *parent_rate, &sdm, &n2);
+	params_from_rate(rate, *parent_rate, &sdm, &n2, mpll->flags);
 	return rate_from_params(*parent_rate, sdm, n2);
 }
 
@@ -140,7 +154,7 @@ static int mpll_set_rate(struct clk_hw *hw,
 	unsigned int sdm, n2;
 	unsigned long flags = 0;
 
-	params_from_rate(rate, parent_rate, &sdm, &n2);
+	params_from_rate(rate, parent_rate, &sdm, &n2, mpll->flags);
 
 	if (mpll->lock)
 		spin_lock_irqsave(mpll->lock, flags);
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index 8fe73c4edca8..8cc265cd3d2b 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -97,8 +97,11 @@ struct meson_clk_mpll_data {
 	struct parm ssen;
 	struct parm misc;
 	spinlock_t *lock;
+	u8 flags;
 };
 
+#define CLK_MESON_MPLL_ROUND_CLOSEST	BIT(0)
+
 struct meson_clk_audio_div_data {
 	struct parm div;
 	u8 flags;
-- 
2.14.3
