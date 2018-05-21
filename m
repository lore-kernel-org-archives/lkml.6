Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752923AbeEUMQF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 08:16:05 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38662 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751251AbeEUMJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 08:09:04 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: Yisheng Xie <xieyisheng1@huawei.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH 14/33] clk: use match_string() helper
Date: Mon, 21 May 2018 19:57:51 +0800
Message-ID: <1526903890-35761-15-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the index of an array for a matching string,
which can be used intead of open coded variant.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/clk/clk.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 7af555f..4469eca 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2171,7 +2171,6 @@ void clk_hw_reparent(struct clk_hw *hw, struct clk_hw *new_parent)
 bool clk_has_parent(struct clk *clk, struct clk *parent)
 {
 	struct clk_core *core, *parent_core;
-	unsigned int i;
 
 	/* NULL clocks should be nops, so return success if either is NULL. */
 	if (!clk || !parent)
@@ -2184,11 +2183,8 @@ bool clk_has_parent(struct clk *clk, struct clk *parent)
 	if (core->parent == parent_core)
 		return true;
 
-	for (i = 0; i < core->num_parents; i++)
-		if (strcmp(core->parent_names[i], parent_core->name) == 0)
-			return true;
-
-	return false;
+	return match_string(core->parent_names,
+			    core->num_parents, parent_core->name) >= 0;
 }
 EXPORT_SYMBOL_GPL(clk_has_parent);
 
-- 
1.7.12.4
