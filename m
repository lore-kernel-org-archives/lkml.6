Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA3FECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 10:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E551B208DB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 10:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E551B208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbeGOKoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 06:44:01 -0400
Received: from www.osadl.org ([62.245.132.105]:36635 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbeGOKn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 06:43:56 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59] (may be forged))
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w6FAJBaJ004985;
        Sun, 15 Jul 2018 12:19:19 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Michael Turquette <mturquette@baylibre.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Kees Cook <keescook@chromium.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 2/2] drivers: clk: st: address sparse warnings
Date:   Sun, 15 Jul 2018 12:18:24 +0200
Message-Id: <1531649904-6072-2-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1531649904-6072-1-git-send-email-hofrat@osadl.org>
References: <1531649904-6072-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Refactoring of code to make it more readable and at the same time make
sparse happy again.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

sparse complained about:
drivers/clk/st/clkgen-pll.c:225:12: warning: context imbalance in 'clkgen_pll_enable' - different lock contexts for basic block
drivers/clk/st/clkgen-pll.c:267:9: warning: context imbalance in 'clkgen_pll_disable' - different lock contexts for basic block
drivers/clk/st/clkgen-pll.c:413:9: warning: context imbalance in 'set_rate_stm_pll3200c32' - different lock contexts for basic block
drivers/clk/st/clkgen-pll.c:570:9: warning: context imbalance in 'set_rate_stm_pll4600c28' - different lock contexts for basic block

Which are technically false positives as the pll->lock which is being
checked is determined at configuration time, thus the locks are balanced.
Never the less the refactored code seems more readable and was 
commented to make it clear.

Patch was compile tested with: multi_v7_defconfig (implies
CONFIG_ARCH_STI=y)

Patch is against 4.18-rc4 (localversion-next is next-20180713)

 drivers/clk/st/clkgen-pll.c | 51 +++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/clk/st/clkgen-pll.c b/drivers/clk/st/clkgen-pll.c
index 7a7106dc..cbb5184 100644
--- a/drivers/clk/st/clkgen-pll.c
+++ b/drivers/clk/st/clkgen-pll.c
@@ -228,13 +228,13 @@ static int clkgen_pll_enable(struct clk_hw *hw)
 	unsigned long flags = 0;
 	int ret = 0;
 
-	if (pll->lock)
+	if (pll->lock) {
+		/* stih418 and stih407 */
 		spin_lock_irqsave(pll->lock, flags);
-
-	ret = __clkgen_pll_enable(hw);
-
-	if (pll->lock)
+		ret = __clkgen_pll_enable(hw);
 		spin_unlock_irqrestore(pll->lock, flags);
+	} else
+		ret = __clkgen_pll_enable(hw);
 
 	return ret;
 }
@@ -259,13 +259,13 @@ static void clkgen_pll_disable(struct clk_hw *hw)
 	struct clkgen_pll *pll = to_clkgen_pll(hw);
 	unsigned long flags = 0;
 
-	if (pll->lock)
+	if (pll->lock) {
+		/* stih418 and stih407 */
 		spin_lock_irqsave(pll->lock, flags);
-
-	__clkgen_pll_disable(hw);
-
-	if (pll->lock)
+		__clkgen_pll_disable(hw);
 		spin_unlock_irqrestore(pll->lock, flags);
+	} else
+		__clkgen_pll_disable(hw);
 }
 
 static int clk_pll3200c32_get_params(unsigned long input, unsigned long output,
@@ -400,15 +400,18 @@ static int set_rate_stm_pll3200c32(struct clk_hw *hw, unsigned long rate,
 
 	__clkgen_pll_disable(hw);
 
-	if (pll->lock)
+	if (pll->lock) {
+		/* stih407 and stih418 */
 		spin_lock_irqsave(pll->lock, flags);
-
-	CLKGEN_WRITE(pll, ndiv, pll->ndiv);
-	CLKGEN_WRITE(pll, idf, pll->idf);
-	CLKGEN_WRITE(pll, cp, pll->cp);
-
-	if (pll->lock)
+		CLKGEN_WRITE(pll, ndiv, pll->ndiv);
+		CLKGEN_WRITE(pll, idf, pll->idf);
+		CLKGEN_WRITE(pll, cp, pll->cp);
 		spin_unlock_irqrestore(pll->lock, flags);
+	} else {
+		CLKGEN_WRITE(pll, ndiv, pll->ndiv);
+		CLKGEN_WRITE(pll, idf, pll->idf);
+		CLKGEN_WRITE(pll, cp, pll->cp);
+	}
 
 	__clkgen_pll_enable(hw);
 
@@ -558,14 +561,16 @@ static int set_rate_stm_pll4600c28(struct clk_hw *hw, unsigned long rate,
 
 	__clkgen_pll_disable(hw);
 
-	if (pll->lock)
+	if (pll->lock) {
+		/* stih407 and stih418 */
 		spin_lock_irqsave(pll->lock, flags);
-
-	CLKGEN_WRITE(pll, ndiv, pll->ndiv);
-	CLKGEN_WRITE(pll, idf, pll->idf);
-
-	if (pll->lock)
+		CLKGEN_WRITE(pll, ndiv, pll->ndiv);
+		CLKGEN_WRITE(pll, idf, pll->idf);
 		spin_unlock_irqrestore(pll->lock, flags);
+	} else {
+		CLKGEN_WRITE(pll, ndiv, pll->ndiv);
+		CLKGEN_WRITE(pll, idf, pll->idf);
+	}
 
 	__clkgen_pll_enable(hw);
 
-- 
2.1.4

