Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030416AbeBNNn4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:43:56 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36522 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030372AbeBNNnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:43:50 -0500
X-Google-Smtp-Source: AH8x225RwRQde4dJVF3axO53t6M9DM+tVbll4+V1xh0a99Ss5yPICSeBmZXMfhPhiqt256tQb5V/mg==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
        Shawn Guo <shawnguo@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH v2 4/8] clk: migrate the count of orphaned clocks at init
Date: Wed, 14 Feb 2018 14:43:36 +0100
Message-Id: <20180214134340.17242-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180214134340.17242-1-jbrunet@baylibre.com>
References: <20180214134340.17242-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The orphan clocks reparents should migrate any existing count from the
orphan clock to its new acestor clocks, otherwise we may have
inconsistent counts in the tree and end-up with gated critical clocks

Assuming we have two clocks, A and B.
* Clock A has CLK_IS_CRITICAL flag set.
* Clock B is an ancestor of A which can gate. Clock B gate is left
  enabled by the bootloader.

Step 1: Clock A is registered. Since it is a critical clock, it is
enabled. The clock being still an orphan, no parent are enabled.

Step 2: Clock B is registered and reparented to clock A (potentially
through several other clocks). We are now in situation where the enable
count of clock A is 1 while the enable count of its ancestors is 0, which
is not good.

Step 3: in lateinit, clk_disable_unused() is called, the enable_count of
clock B being 0, clock B is gated and and critical clock A actually gets
disabled.

This situation was found while adding fdiv_clk gates to the meson8b
platform.  These clocks parent clk81 critical clock, which is the mother
of all peripheral clocks in this system. Because of the issue described
here, the system is crashing when clk_disable_unused() is called.

The situation is solved by reverting
commit f8f8f1d04494 ("clk: Don't touch hardware when reparenting during registration").
To avoid breaking again the situation described in this commit
description, enabling critical clock should be done before walking the
orphan list. This way, a parent critical clock may not be accidentally
disabled due to the CLK_OPS_PARENT_ENABLE mechanism.

Fixes: f8f8f1d04494 ("clk: Don't touch hardware when reparenting during registration")
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/clk.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index a4b4e4d6df5e..cca05ea2c058 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2969,23 +2969,38 @@ static int __clk_core_init(struct clk_core *core)
 		rate = 0;
 	core->rate = core->req_rate = rate;
 
+	/*
+	 * Enable CLK_IS_CRITICAL clocks so newly added critical clocks
+	 * don't get accidentally disabled when walking the orphan tree and
+	 * reparenting clocks
+	 */
+	if (core->flags & CLK_IS_CRITICAL) {
+		unsigned long flags;
+
+		clk_core_prepare(core);
+
+		flags = clk_enable_lock();
+		clk_core_enable(core);
+		clk_enable_unlock(flags);
+	}
+
 	/*
 	 * walk the list of orphan clocks and reparent any that newly finds a
 	 * parent.
 	 */
 	hlist_for_each_entry_safe(orphan, tmp2, &clk_orphan_list, child_node) {
 		struct clk_core *parent = __clk_init_parent(orphan);
-		unsigned long flags;
 
 		/*
-		 * we could call __clk_set_parent, but that would result in a
-		 * redundant call to the .set_rate op, if it exists
+		 * We need to use __clk_set_parent_before() and _after() to
+		 * to properly migrate any prepare/enable count of the orphan
+		 * clock. This is important for CLK_IS_CRITICAL clocks, which
+		 * are enabled during init but might not have a parent yet.
 		 */
 		if (parent) {
 			/* update the clk tree topology */
-			flags = clk_enable_lock();
-			clk_reparent(orphan, parent);
-			clk_enable_unlock(flags);
+			__clk_set_parent_before(orphan, parent);
+			__clk_set_parent_after(orphan, parent, NULL);
 			__clk_recalc_accuracies(orphan);
 			__clk_recalc_rates(orphan, 0);
 		}
@@ -3002,16 +3017,6 @@ static int __clk_core_init(struct clk_core *core)
 	if (core->ops->init)
 		core->ops->init(core->hw);
 
-	if (core->flags & CLK_IS_CRITICAL) {
-		unsigned long flags;
-
-		clk_core_prepare(core);
-
-		flags = clk_enable_lock();
-		clk_core_enable(core);
-		clk_enable_unlock(flags);
-	}
-
 	kref_init(&core->ref);
 out:
 	clk_pm_runtime_put(core);
-- 
2.14.3
