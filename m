Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030426AbeBNNoH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:44:07 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33680 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030406AbeBNNny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:43:54 -0500
X-Google-Smtp-Source: AH8x226a8MunL9SKmigBAvIP/5MWSc3h5UUGXHjVF7zxYAHdwW4c8Px6CSJi/vXJhYDmZF6lqaXyXw==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] clk: qcom: use divider_ro_round_rate helper
Date: Wed, 14 Feb 2018 14:43:40 +0100
Message-Id: <20180214134340.17242-9-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180214134340.17242-1-jbrunet@baylibre.com>
References: <20180214134340.17242-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is now an helper function to round the rate when the
divider is read-only. Let's use it

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/qcom/clk-regmap-divider.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/qcom/clk-regmap-divider.c b/drivers/clk/qcom/clk-regmap-divider.c
index 4e9b8c2c8980..1ee75a5e93f4 100644
--- a/drivers/clk/qcom/clk-regmap-divider.c
+++ b/drivers/clk/qcom/clk-regmap-divider.c
@@ -28,22 +28,14 @@ static long div_round_ro_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct clk_regmap_div *divider = to_clk_regmap_div(hw);
 	struct clk_regmap *clkr = &divider->clkr;
-	u32 div;
-	struct clk_hw *hw_parent = clk_hw_get_parent(hw);
-
-	regmap_read(clkr->regmap, divider->reg, &div);
-	div >>= divider->shift;
-	div &= BIT(divider->width) - 1;
-	div += 1;
-
-	if (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) {
-		if (!hw_parent)
-			return -EINVAL;
+	u32 val;
 
-		*prate = clk_hw_round_rate(hw_parent, rate * div);
-	}
+	regmap_read(clkr->regmap, divider->reg, &val);
+	val >>= divider->shift;
+	val &= BIT(divider->width) - 1;
 
-	return DIV_ROUND_UP_ULL((u64)*prate, div);
+	return divider_ro_round_rate(hw, rate, prate, NULL, divider->width,
+				     CLK_DIVIDER_ROUND_CLOSEST, val);
 }
 
 static long div_round_rate(struct clk_hw *hw, unsigned long rate,
-- 
2.14.3
