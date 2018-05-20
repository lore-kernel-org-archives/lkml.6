Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752534AbeETQcL (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 12:32:11 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:60704 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751310AbeETQcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 12:32:09 -0400
From: Paul Cercueil <paul@crapouillou.net>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: James Hogan <jhogan@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/6] clk: ingenic: Add support for clocks whose gate bit is inverted
Date: Sun, 20 May 2018 16:31:12 +0000
Message-Id: <20180520163117.14125-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support the clocks which are gated when their gate bit is cleared
instead of set.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/clk/ingenic/cgu.c | 5 +++--
 drivers/clk/ingenic/cgu.h | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
index 56a712c9075f..4b31145eb8aa 100644
--- a/drivers/clk/ingenic/cgu.c
+++ b/drivers/clk/ingenic/cgu.c
@@ -43,7 +43,8 @@ static inline bool
 ingenic_cgu_gate_get(struct ingenic_cgu *cgu,
 		     const struct ingenic_cgu_gate_info *info)
 {
-	return readl(cgu->base + info->reg) & BIT(info->bit);
+	return !!(readl(cgu->base + info->reg) & BIT(info->bit))
+		^ info->clear_to_gate;
 }
 
 /**
@@ -62,7 +63,7 @@ ingenic_cgu_gate_set(struct ingenic_cgu *cgu,
 {
 	u32 clkgr = readl(cgu->base + info->reg);
 
-	if (val)
+	if (val ^ info->clear_to_gate)
 		clkgr |= BIT(info->bit);
 	else
 		clkgr &= ~BIT(info->bit);
diff --git a/drivers/clk/ingenic/cgu.h b/drivers/clk/ingenic/cgu.h
index 9da34910bd80..4d2e3fad0e30 100644
--- a/drivers/clk/ingenic/cgu.h
+++ b/drivers/clk/ingenic/cgu.h
@@ -111,10 +111,12 @@ struct ingenic_cgu_fixdiv_info {
  * struct ingenic_cgu_gate_info - information about a clock gate
  * @reg: offset of the gate control register within the CGU
  * @bit: offset of the bit in the register that controls the gate
+ * @clear_to_gate: if set, the clock is gated when the bit is cleared
  */
 struct ingenic_cgu_gate_info {
 	unsigned reg;
 	u8 bit;
+	bool clear_to_gate;
 };
 
 /**
-- 
2.17.0
