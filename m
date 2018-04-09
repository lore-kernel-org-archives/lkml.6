Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752916AbeDIN7d (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 09:59:33 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53410 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752581AbeDIN73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 09:59:29 -0400
X-Google-Smtp-Source: AIpwx48MTo0yDSCrJkQkZNRCxs+4pvPdRGGwk2y09KP/p/ZQHCpKOv/Un9QXGQzEKiwqAbSO3+9hbQ==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: [PATCH 2/2] clk: meson: honor CLK_MUX_ROUND_CLOSEST in clk_regmap
Date: Mon,  9 Apr 2018 15:59:21 +0200
Message-Id: <20180409135921.5617-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180409135921.5617-1-jbrunet@baylibre.com>
References: <20180409135921.5617-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using __clk_mux_determine_rate effectively ignores CLK_MUX_ROUND_CLOSEST
if set the related clk_regmap mux instance.

Use clk_mux_determine_rate_flags() to make sure the flag is honored.

Fixes: ea11dda9e091 ("clk: meson: add regmap clocks")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/clk-regmap.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/clk-regmap.c b/drivers/clk/meson/clk-regmap.c
index 3645fdb62343..ab7a3556f5b2 100644
--- a/drivers/clk/meson/clk-regmap.c
+++ b/drivers/clk/meson/clk-regmap.c
@@ -153,10 +153,19 @@ static int clk_regmap_mux_set_parent(struct clk_hw *hw, u8 index)
 				  val << mux->shift);
 }
 
+static int clk_regmap_mux_determine_rate(struct clk_hw *hw,
+					 struct clk_rate_request *req)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct clk_regmap_mux_data *mux = clk_get_regmap_mux_data(clk);
+
+	return clk_mux_determine_rate_flags(hw, req, mux->flags);
+}
+
 const struct clk_ops clk_regmap_mux_ops = {
 	.get_parent = clk_regmap_mux_get_parent,
 	.set_parent = clk_regmap_mux_set_parent,
-	.determine_rate = __clk_mux_determine_rate,
+	.determine_rate = clk_regmap_mux_determine_rate,
 };
 EXPORT_SYMBOL_GPL(clk_regmap_mux_ops);
 
-- 
2.14.3
