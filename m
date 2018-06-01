Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751482AbeFAJ3t (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 05:29:49 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:48930 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbeFAJ3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 05:29:07 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Jia-Ju Bai <baijiaju1990@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/4] clk: renesas: cpg-mssr: Stop using printk format %pCr
Date: Fri,  1 Jun 2018 11:28:19 +0200
Message-Id: <1527845302-12159-2-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527845302-12159-1-git-send-email-geert+renesas@glider.be>
References: <1527845302-12159-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Printk format "%pCr" will be removed soon, as clk_get_rate() must not be
called in atomic context.

Replace it by open-coding the operation.  This is safe here, as the code
runs in task context.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/renesas/renesas-cpg-mssr.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 49e510691eeeab07..f4b013e9352d9efc 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -258,8 +258,9 @@ struct clk *cpg_mssr_clk_src_twocell_get(struct of_phandle_args *clkspec,
 		dev_err(dev, "Cannot get %s clock %u: %ld", type, clkidx,
 		       PTR_ERR(clk));
 	else
-		dev_dbg(dev, "clock (%u, %u) is %pC at %pCr Hz\n",
-			clkspec->args[0], clkspec->args[1], clk, clk);
+		dev_dbg(dev, "clock (%u, %u) is %pC at %lu Hz\n",
+			clkspec->args[0], clkspec->args[1], clk,
+			clk_get_rate(clk));
 	return clk;
 }
 
@@ -326,7 +327,7 @@ static void __init cpg_mssr_register_core_clk(const struct cpg_core_clk *core,
 	if (IS_ERR_OR_NULL(clk))
 		goto fail;
 
-	dev_dbg(dev, "Core clock %pC at %pCr Hz\n", clk, clk);
+	dev_dbg(dev, "Core clock %pC at %lu Hz\n", clk, clk_get_rate(clk));
 	priv->clks[id] = clk;
 	return;
 
@@ -392,7 +393,7 @@ static void __init cpg_mssr_register_mod_clk(const struct mssr_mod_clk *mod,
 	if (IS_ERR(clk))
 		goto fail;
 
-	dev_dbg(dev, "Module clock %pC at %pCr Hz\n", clk, clk);
+	dev_dbg(dev, "Module clock %pC at %lu Hz\n", clk, clk_get_rate(clk));
 	priv->clks[id] = clk;
 	priv->smstpcr_saved[clock->index / 32].mask |= BIT(clock->index % 32);
 	return;
-- 
2.7.4
