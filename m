Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752924AbeDIN7v (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 09:59:51 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39191 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752498AbeDIN72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 09:59:28 -0400
X-Google-Smtp-Source: AIpwx48sEHwReNOWR5fstPHW6j6IXw3Nvm7fYqIUBCvXDDWzD3bHR2depuHUsvaEQLBNNoaxKJlmZA==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: [PATCH 1/2] clk: honor CLK_MUX_ROUND_CLOSEST in generic clk mux
Date: Mon,  9 Apr 2018 15:59:20 +0200
Message-Id: <20180409135921.5617-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180409135921.5617-1-jbrunet@baylibre.com>
References: <20180409135921.5617-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CLK_MUX_ROUND_CLOSEST is part of the clk_mux documentation but clk_mux
directly calls __clk_mux_determine_rate(), which overrides the flag.
As result, if clk_mux is instantiated with CLK_MUX_ROUND_CLOSEST, the
flag will be ignored and the clock rounded down.

To solve this, this patch expose clk_mux_determine_rate_flags() in the
clk-provider API and uses it in the determine_rate() callback of clk_mux.

Fixes: 15a02c1f6dd7 ("clk: Add __clk_mux_determine_rate_closest")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/clk-mux.c        | 10 +++++++++-
 drivers/clk/clk.c            |  7 ++++---
 include/linux/clk-provider.h |  3 +++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index ac4a042f8658..1628b93655ed 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -112,10 +112,18 @@ static int clk_mux_set_parent(struct clk_hw *hw, u8 index)
 	return 0;
 }
 
+static int clk_mux_determine_rate(struct clk_hw *hw,
+				  struct clk_rate_request *req)
+{
+	struct clk_mux *mux = to_clk_mux(hw);
+
+	return clk_mux_determine_rate_flags(hw, req, mux->flags);
+}
+
 const struct clk_ops clk_mux_ops = {
 	.get_parent = clk_mux_get_parent,
 	.set_parent = clk_mux_set_parent,
-	.determine_rate = __clk_mux_determine_rate,
+	.determine_rate = clk_mux_determine_rate,
 };
 EXPORT_SYMBOL_GPL(clk_mux_ops);
 
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index ea67ac81c6f9..7af555f0e60c 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -426,9 +426,9 @@ static bool mux_is_better_rate(unsigned long rate, unsigned long now,
 	return now <= rate && now > best;
 }
 
-static int
-clk_mux_determine_rate_flags(struct clk_hw *hw, struct clk_rate_request *req,
-			     unsigned long flags)
+int clk_mux_determine_rate_flags(struct clk_hw *hw,
+				 struct clk_rate_request *req,
+				 unsigned long flags)
 {
 	struct clk_core *core = hw->core, *parent, *best_parent = NULL;
 	int i, num_parents, ret;
@@ -488,6 +488,7 @@ clk_mux_determine_rate_flags(struct clk_hw *hw, struct clk_rate_request *req,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(clk_mux_determine_rate_flags);
 
 struct clk *__clk_lookup(const char *name)
 {
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 210a890008f9..1d25e149c1c5 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -765,6 +765,9 @@ int __clk_mux_determine_rate(struct clk_hw *hw,
 int __clk_determine_rate(struct clk_hw *core, struct clk_rate_request *req);
 int __clk_mux_determine_rate_closest(struct clk_hw *hw,
 				     struct clk_rate_request *req);
+int clk_mux_determine_rate_flags(struct clk_hw *hw,
+				 struct clk_rate_request *req,
+				 unsigned long flags);
 void clk_hw_reparent(struct clk_hw *hw, struct clk_hw *new_parent);
 void clk_hw_set_rate_range(struct clk_hw *hw, unsigned long min_rate,
 			   unsigned long max_rate);
-- 
2.14.3
