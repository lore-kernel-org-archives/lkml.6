Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751345AbeEMLRA (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 07:17:00 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:50785 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbeEMLQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 07:16:58 -0400
X-ME-Helo: ubuntu-CJ.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 13 May 2018 13:16:57 +0200
X-ME-IP: 86.244.116.1
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: mturquette@baylibre.com, sboyd@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] clk: stm32mp1: Fix a memory leak in 'clk_stm32_register_gate_ops()'
Date: Sun, 13 May 2018 13:17:04 +0200
Message-Id: <20180513111704.31842-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We allocate some memory which is neither used, nor referenced by anything.
So axe it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch as not been compile-tested, I don't have the corresponding arch
and have not taken time to cross-compile it.
---
 drivers/clk/clk-stm32mp1.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index edd3cf451401..dfb9cb5bd0c4 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -579,14 +579,9 @@ clk_stm32_register_gate_ops(struct device *dev,
 			    spinlock_t *lock)
 {
 	struct clk_init_data init = { NULL };
-	struct clk_gate *gate;
 	struct clk_hw *hw;
 	int ret;
 
-	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
-	if (!gate)
-		return ERR_PTR(-ENOMEM);
-
 	init.name = name;
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
@@ -604,10 +599,8 @@ clk_stm32_register_gate_ops(struct device *dev,
 	hw->init = &init;
 
 	ret = clk_hw_register(dev, hw);
-	if (ret) {
-		kfree(gate);
+	if (ret)
 		hw = ERR_PTR(ret);
-	}
 
 	return hw;
 }
-- 
2.17.0
