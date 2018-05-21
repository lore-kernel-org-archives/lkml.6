Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753028AbeEUMOx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 08:14:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38706 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752644AbeEUMJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 08:09:05 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: Yisheng Xie <xieyisheng1@huawei.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
Subject: [PATCH 13/33] clk: rockchip: use match_string() helper
Date: Mon, 21 May 2018 19:57:50 +0800
Message-ID: <1526903890-35761-14-git-send-email-xieyisheng1@huawei.com>
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
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-clk@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/clk/rockchip/clk.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index 3cd8ad5..514032d 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -274,18 +274,10 @@ static struct clk *rockchip_clk_register_frac_branch(
 		struct clk_mux *frac_mux = &frac->mux;
 		struct clk_init_data init;
 		struct clk *mux_clk;
-		int i, ret;
-
-		frac->mux_frac_idx = -1;
-		for (i = 0; i < child->num_parents; i++) {
-			if (!strcmp(name, child->parent_names[i])) {
-				pr_debug("%s: found fractional parent in mux at pos %d\n",
-					 __func__, i);
-				frac->mux_frac_idx = i;
-				break;
-			}
-		}
+		int ret;
 
+		frac->mux_frac_idx = match_string(child->parent_names,
+						  child->num_parents, name);
 		frac->mux_ops = &clk_mux_ops;
 		frac->clk_nb.notifier_call = rockchip_clk_frac_notifier_cb;
 
@@ -312,6 +304,8 @@ static struct clk *rockchip_clk_register_frac_branch(
 
 		/* notifier on the fraction divider to catch rate changes */
 		if (frac->mux_frac_idx >= 0) {
+			pr_debug("%s: find fractional parent in mux at pos %d\n",
+				 __func__, frac->mux_frac_idx);
 			ret = clk_notifier_register(clk, &frac->clk_nb);
 			if (ret)
 				pr_err("%s: failed to register clock notifier for %s\n",
-- 
1.7.12.4
