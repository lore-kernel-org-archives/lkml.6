Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934948AbeEINkp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 09:40:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56493 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934630AbeEINko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 09:40:44 -0400
From: Colin King <colin.king@canonical.com>
To: Paul Burton <paul.burton@mips.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-mips@linux-mips.org,
        linux-clk@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: boston: fix memory leak of 'onecell' on error return paths
Date: Wed,  9 May 2018 14:40:31 +0100
Message-Id: <20180509134031.11611-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are several error return paths that don't free up onecell
and hence we have some memory leaks. Add an error exit path that
kfree's onecell to fix the leaks.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/clk/imgtec/clk-boston.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imgtec/clk-boston.c b/drivers/clk/imgtec/clk-boston.c
index 15af423cc0c9..d6bc468ff551 100644
--- a/drivers/clk/imgtec/clk-boston.c
+++ b/drivers/clk/imgtec/clk-boston.c
@@ -73,27 +73,34 @@ static void __init clk_boston_setup(struct device_node *np)
 	hw = clk_hw_register_fixed_rate(NULL, "input", NULL, 0, in_freq);
 	if (IS_ERR(hw)) {
 		pr_err("failed to register input clock: %ld\n", PTR_ERR(hw));
-		return;
+		goto error;
 	}
 	onecell->hws[BOSTON_CLK_INPUT] = hw;
 
 	hw = clk_hw_register_fixed_rate(NULL, "sys", "input", 0, sys_freq);
 	if (IS_ERR(hw)) {
 		pr_err("failed to register sys clock: %ld\n", PTR_ERR(hw));
-		return;
+		goto error;
 	}
 	onecell->hws[BOSTON_CLK_SYS] = hw;
 
 	hw = clk_hw_register_fixed_rate(NULL, "cpu", "input", 0, cpu_freq);
 	if (IS_ERR(hw)) {
 		pr_err("failed to register cpu clock: %ld\n", PTR_ERR(hw));
-		return;
+		goto error;
 	}
 	onecell->hws[BOSTON_CLK_CPU] = hw;
 
 	err = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, onecell);
-	if (err)
+	if (err) {
 		pr_err("failed to add DT provider: %d\n", err);
+		goto error;
+	}
+	return;
+
+error:
+	kfree(onecell);
+	return;
 }
 
 /*
-- 
2.17.0
