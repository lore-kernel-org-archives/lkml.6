Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752567AbeETQcN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 12:32:13 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:60626 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751681AbeETQcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 12:32:09 -0400
From: Paul Cercueil <paul@crapouillou.net>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: James Hogan <jhogan@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/6] clk: ingenic: Support specifying "wait for clock stable" delay
Date: Sun, 20 May 2018 16:31:13 +0000
Message-Id: <20180520163117.14125-2-paul@crapouillou.net>
In-Reply-To: <20180520163117.14125-1-paul@crapouillou.net>
References: <20180520163117.14125-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some clocks need a small delay after being ungated to run stable, as
using them too soon might result in hardware lockups.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/clk/ingenic/cgu.c | 3 +++
 drivers/clk/ingenic/cgu.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
index 4b31145eb8aa..5ef7d9ba2195 100644
--- a/drivers/clk/ingenic/cgu.c
+++ b/drivers/clk/ingenic/cgu.c
@@ -512,6 +512,9 @@ static int ingenic_clk_enable(struct clk_hw *hw)
 		spin_lock_irqsave(&cgu->lock, flags);
 		ingenic_cgu_gate_set(cgu, &clk_info->gate, false);
 		spin_unlock_irqrestore(&cgu->lock, flags);
+
+		if (clk_info->gate.delay_us)
+			udelay(clk_info->gate.delay_us);
 	}
 
 	return 0;
diff --git a/drivers/clk/ingenic/cgu.h b/drivers/clk/ingenic/cgu.h
index 4d2e3fad0e30..542192376ebf 100644
--- a/drivers/clk/ingenic/cgu.h
+++ b/drivers/clk/ingenic/cgu.h
@@ -112,11 +112,13 @@ struct ingenic_cgu_fixdiv_info {
  * @reg: offset of the gate control register within the CGU
  * @bit: offset of the bit in the register that controls the gate
  * @clear_to_gate: if set, the clock is gated when the bit is cleared
+ * @delay_us: delay in microseconds after which the clock is considered stable
  */
 struct ingenic_cgu_gate_info {
 	unsigned reg;
 	u8 bit;
 	bool clear_to_gate;
+	u16 delay_us;
 };
 
 /**
-- 
2.17.0
