Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752643AbeBSLWC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 06:22:02 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38703 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752592AbeBSLV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 06:21:59 -0500
X-Google-Smtp-Source: AH8x226y4fslCIDi1VnzXqlBQiAOePQg6634aunp9xHl9EmBscsD4oZLQHq5d0lB5gdVMKKIlHIJKQ==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] clk: meson: add ROUND_CLOSEST to the pll driver
Date: Mon, 19 Feb 2018 12:21:41 +0100
Message-Id: <20180219112146.21746-7-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180219112146.21746-1-jbrunet@baylibre.com>
References: <20180219112146.21746-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide an option for the pll driver to round to the rate closest to the
requested rate, instead of systematically rounding down.

This may allow the provided rate to be closer to the requested rate when
rounding up is not an issue

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/clk-pll.c | 17 +++++++++++++----
 drivers/clk/meson/clkc.h    |  2 ++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index d58961f35b71..65a7bd903551 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -105,7 +105,12 @@ static u16 __pll_params_with_frac(unsigned long rate,
 	u64 val = (u64)rate * pllt->n;
 
 	val <<= pllt->od + pllt->od2 + pllt->od3;
-	val = div_u64(val * frac_max, parent_rate);
+
+	if (pll->flags & CLK_MESON_PLL_ROUND_CLOSEST)
+		val = DIV_ROUND_CLOSEST_ULL(val * frac_max, parent_rate);
+	else
+		val = div_u64(val * frac_max, parent_rate);
+
 	val -= pllt->m * frac_max;
 
 	return min((u16)val, (u16)(frac_max - 1));
@@ -125,9 +130,13 @@ meson_clk_get_pll_settings(unsigned long rate,
 	while (table[i].rate && table[i].rate <= rate)
 		i++;
 
-	/* Select the setting of the rounded down rate */
-	if (i != 0)
-		i--;
+	if (i != 0) {
+		if (MESON_PARM_APPLICABLE(&pll->frac) ||
+		    !(pll->flags & CLK_MESON_PLL_ROUND_CLOSEST) ||
+		    (abs(rate - table[i - 1].rate) <
+		     abs(rate - table[i].rate)))
+			i--;
+	}
 
 	return (struct pll_rate_table *)&table[i];
 }
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index 9cdcd9b6c16c..8fe73c4edca8 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -71,6 +71,8 @@ struct pll_rate_table {
 		.od		= (_od),				\
 	}
 
+#define CLK_MESON_PLL_ROUND_CLOSEST	BIT(0)
+
 struct meson_clk_pll_data {
 	struct parm m;
 	struct parm n;
-- 
2.14.3
