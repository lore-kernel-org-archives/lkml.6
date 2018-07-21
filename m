Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD7EECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F28820868
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="To1Js7ZG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="To1Js7ZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F28820868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbeGUTJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 15:09:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54622 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbeGUTJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 15:09:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 889BC60588; Sat, 21 Jul 2018 18:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532196932;
        bh=IdAzq7oqBKCmGYo/kHqwKtbSgMs0/oaAUylfd1DPGPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=To1Js7ZGdgpuOQVyaYsD9Ka/dZCXoq1Q0TaEsT6OaBZUYNtLFYvcuAOk63XoTa548
         G6al2rBz9itwRASCxG1zW8qvTdJHIWjV0GrE3v74+Zm7pG5hFmI/o6s8vT8HJ0gasC
         UtSs92BNjJUgJ+pcZhHRpkzfrrOR5mTGL4JI4sww=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BC85B60AD9;
        Sat, 21 Jul 2018 18:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532196932;
        bh=IdAzq7oqBKCmGYo/kHqwKtbSgMs0/oaAUylfd1DPGPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=To1Js7ZGdgpuOQVyaYsD9Ka/dZCXoq1Q0TaEsT6OaBZUYNtLFYvcuAOk63XoTa548
         G6al2rBz9itwRASCxG1zW8qvTdJHIWjV0GrE3v74+Zm7pG5hFmI/o6s8vT8HJ0gasC
         UtSs92BNjJUgJ+pcZhHRpkzfrrOR5mTGL4JI4sww=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BC85B60AD9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        grahamr@qti.qualcomm.com, Taniya Das <tdas@codeaurora.org>
Subject: [RFC PATCH 3/4] clk: qcom: Add prepare/unprepare clock ops for PLL/RCG
Date:   Sat, 21 Jul 2018 23:45:01 +0530
Message-Id: <1532196902-28570-4-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532196902-28570-1-git-send-email-tdas@codeaurora.org>
References: <1532196902-28570-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To put across power domain votes associated with a PLL or RCG, add the
prepare/unprepare clock ops which would map the corresponding performance
state corners for a clock frequency when the clk_prepare/clk_unprepare is
being invoked.
Also update the set_rate clock ops to send across the performance state to
genpd framework when a new frequency is being requested.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/clk-alpha-pll.c | 52 +++++++++++++++++++++++++++-------
 drivers/clk/qcom/clk-rcg2.c      | 61 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 96 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 3c49a60..c03b6e4 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -1,14 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2015, 2018, The Linux Foundation. All rights reserved.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/kernel.h>
@@ -18,6 +10,7 @@
 #include <linux/delay.h>
 
 #include "clk-alpha-pll.h"
+#include "clk-pd.h"
 #include "common.h"
 
 #define PLL_MODE(p)		((p)->offset + 0x0)
@@ -522,7 +515,9 @@ static int __clk_alpha_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
 	const struct pll_vco *vco;
 	u32 l, alpha_width = pll_alpha_width(pll);
+	unsigned long old_rate = clk_hw_get_rate(hw);
 	u64 a;
+	int ret;
 
 	rate = alpha_pll_round_rate(rate, prate, &l, &a, alpha_width);
 	vco = alpha_pll_find_vco(pll, rate);
@@ -531,6 +526,15 @@ static int __clk_alpha_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 		return -EINVAL;
 	}
 
+	if (clk_hw_is_prepared(hw)) {
+		/* Enforce power domain requirement for new frequency */
+		ret = clk_power_domain_vote_rate(&pll->clkr, rate);
+		if (ret) {
+			pr_err("Failed to vote/set new rate %lu\n", rate);
+			return ret;
+		}
+	}
+
 	regmap_write(pll->clkr.regmap, PLL_L_VAL(pll), l);
 
 	if (alpha_width > ALPHA_BITWIDTH)
@@ -550,7 +554,15 @@ static int __clk_alpha_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	regmap_update_bits(pll->clkr.regmap, PLL_USER_CTL(pll),
 			   PLL_ALPHA_EN, PLL_ALPHA_EN);
 
-	return clk_alpha_pll_update_latch(pll, is_enabled);
+	ret = clk_alpha_pll_update_latch(pll, is_enabled);
+	if (ret)
+		old_rate = rate;
+
+	if (clk_hw_is_prepared(hw))
+		/* Release the power domain requirement for old frequency */
+		clk_power_domain_unvote_rate(&pll->clkr, old_rate);
+
+	return ret;
 }
 
 static int clk_alpha_pll_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -1017,7 +1029,25 @@ static int alpha_pll_fabia_set_rate(struct clk_hw *hw, unsigned long rate,
 	return __clk_alpha_pll_update_latch(pll);
 }
 
+static int clk_alpha_pll_prepare(struct clk_hw *hw)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	unsigned long rate = clk_hw_get_rate(hw);
+
+	return clk_power_domain_vote_rate(&pll->clkr, rate);
+}
+
+static void clk_alpha_pll_unprepare(struct clk_hw *hw)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	unsigned long rate = clk_hw_get_rate(hw);
+
+	clk_power_domain_unvote_rate(&pll->clkr, rate);
+}
+
 const struct clk_ops clk_alpha_pll_fabia_ops = {
+	.prepare = clk_alpha_pll_prepare,
+	.unprepare = clk_alpha_pll_unprepare,
 	.enable = alpha_pll_fabia_enable,
 	.disable = alpha_pll_fabia_disable,
 	.is_enabled = clk_alpha_pll_is_enabled,
@@ -1028,6 +1058,8 @@ static int alpha_pll_fabia_set_rate(struct clk_hw *hw, unsigned long rate,
 EXPORT_SYMBOL_GPL(clk_alpha_pll_fabia_ops);
 
 const struct clk_ops clk_alpha_pll_fixed_fabia_ops = {
+	.prepare = clk_alpha_pll_prepare,
+	.unprepare = clk_alpha_pll_unprepare,
 	.enable = alpha_pll_fabia_enable,
 	.disable = alpha_pll_fabia_disable,
 	.is_enabled = clk_alpha_pll_is_enabled,
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 52208d4..dc17dbf 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -15,6 +15,7 @@
 
 #include <asm/div64.h>
 
+#include "clk-pd.h"
 #include "clk-rcg.h"
 #include "common.h"
 
@@ -247,26 +248,46 @@ static int __clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_tbl *f)
 	u32 cfg, mask;
 	struct clk_hw *hw = &rcg->clkr.hw;
 	int ret, index = qcom_find_src_index(hw, rcg->parent_map, f->src);
+	unsigned long old_rate = clk_hw_get_rate(hw);
 
 	if (index < 0)
 		return index;
 
+	/* Enforce power domain requirement for new frequency */
+	if (clk_hw_is_prepared(hw)) {
+		ret = clk_power_domain_vote_rate(&rcg->clkr, f->freq);
+		if (ret) {
+			pr_err("Failed to vote & set new rate %lu\n", f->freq);
+			return ret;
+		}
+	}
+
 	if (rcg->mnd_width && f->n) {
 		mask = BIT(rcg->mnd_width) - 1;
 		ret = regmap_update_bits(rcg->clkr.regmap,
 				rcg->cmd_rcgr + M_REG, mask, f->m);
-		if (ret)
-			return ret;
+		if (ret) {
+			/*
+			 * Release the power domain requirement for
+			 * new frequency
+			 */
+			old_rate = f->freq;
+			goto out;
+		}
 
 		ret = regmap_update_bits(rcg->clkr.regmap,
 				rcg->cmd_rcgr + N_REG, mask, ~(f->n - f->m));
-		if (ret)
-			return ret;
+		if (ret) {
+			old_rate = f->freq;
+			goto out;
+		}
 
 		ret = regmap_update_bits(rcg->clkr.regmap,
 				rcg->cmd_rcgr + D_REG, mask, ~f->n);
-		if (ret)
-			return ret;
+		if (ret) {
+			old_rate = f->freq;
+			goto out;
+		}
 	}
 
 	mask = BIT(rcg->hid_width) - 1;
@@ -276,8 +297,14 @@ static int __clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_tbl *f)
 	if (rcg->mnd_width && f->n && (f->m != f->n))
 		cfg |= CFG_MODE_DUAL_EDGE;
 
-	return regmap_update_bits(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG,
+	ret = regmap_update_bits(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG,
 					mask, cfg);
+out:
+	if (clk_hw_is_prepared(hw))
+		/* Release the power domain requirement for old/new frequency */
+		clk_power_domain_unvote_rate(&rcg->clkr, old_rate);
+
+	return ret;
 }
 
 static int clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_tbl *f)
@@ -338,7 +365,25 @@ static int clk_rcg2_set_floor_rate_and_parent(struct clk_hw *hw,
 	return __clk_rcg2_set_rate(hw, rate, FLOOR);
 }
 
+static int clk_rcg2_prepare(struct clk_hw *hw)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	unsigned long rate = clk_hw_get_rate(hw);
+
+	return clk_power_domain_vote_rate(&rcg->clkr, rate);
+}
+
+static void clk_rcg2_unprepare(struct clk_hw *hw)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	unsigned long rate = clk_hw_get_rate(hw);
+
+	clk_power_domain_unvote_rate(&rcg->clkr, rate);
+}
+
 const struct clk_ops clk_rcg2_ops = {
+	.prepare = clk_rcg2_prepare,
+	.unprepare = clk_rcg2_unprepare,
 	.is_enabled = clk_rcg2_is_enabled,
 	.get_parent = clk_rcg2_get_parent,
 	.set_parent = clk_rcg2_set_parent,
@@ -919,6 +964,8 @@ static void clk_rcg2_shared_disable(struct clk_hw *hw)
 }
 
 const struct clk_ops clk_rcg2_shared_ops = {
+	.prepare = clk_rcg2_prepare,
+	.unprepare = clk_rcg2_unprepare,
 	.enable = clk_rcg2_shared_enable,
 	.disable = clk_rcg2_shared_disable,
 	.get_parent = clk_rcg2_get_parent,
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

