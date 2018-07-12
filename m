Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06A6C476E8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976B120842
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DJ9QPMOy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DJ9QPMOy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 976B120842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732508AbeGLRUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:20:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56592 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbeGLRUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:20:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B7A2360251; Thu, 12 Jul 2018 17:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531415404;
        bh=iovhbuGlCY1tz3IuJVoEBR0Z90erYn2zppG5LomJDgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DJ9QPMOyrqLboDo9gheVSpLQGZZM6NrToEL1CsZAHMVKn1E2FfxlbTi8T/ceVJBSh
         4/jB9UqHjmJ9v+aL0xHPJYaJUpaHBzaoaaIbNK/Lp5E4/x7BR/3+r/DqLuNpa4LLa9
         yUntTx7ZJTE4fIVebQeK10v1RmW3ktoPH6nB2cvA=
Received: from anischal-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: anischal@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 95AED6063F;
        Thu, 12 Jul 2018 17:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531415404;
        bh=iovhbuGlCY1tz3IuJVoEBR0Z90erYn2zppG5LomJDgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DJ9QPMOyrqLboDo9gheVSpLQGZZM6NrToEL1CsZAHMVKn1E2FfxlbTi8T/ceVJBSh
         4/jB9UqHjmJ9v+aL0xHPJYaJUpaHBzaoaaIbNK/Lp5E4/x7BR/3+r/DqLuNpa4LLa9
         yUntTx7ZJTE4fIVebQeK10v1RmW3ktoPH6nB2cvA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 95AED6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=anischal@codeaurora.org
From:   Amit Nischal <anischal@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Nischal <anischal@codeaurora.org>
Subject: [PATCH v2 2/4] clk: qcom: Add clk_rcg2_gfx3d_ops for SDM845
Date:   Thu, 12 Jul 2018 22:39:39 +0530
Message-Id: <1531415381-16885-3-git-send-email-anischal@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531415381-16885-1-git-send-email-anischal@codeaurora.org>
References: <1531415381-16885-1-git-send-email-anischal@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To turn on the gpu_gx_gdsc, there is a hardware requirement to
turn on the root clock (GFX3D RCG) first which would be the turn
on signal for the gdsc along with the SW_COLLAPSE. As per the
current implementation of clk_rcg2_shared_ops, it clears the
root_enable bit in the enable() clock op. But due to the above
said requirement for GFX3D shared RCG, root_enable bit would be
already set by gdsc driver and clk_rcg2_shared_enable()should
not clear the root unless the disable is called.

Add support for the same by reusing the existing clk_rcg2_shared_ops
and deriving "clk_rcg2_gfx3d_ops" clk_ops for GFX3D clock to take
care of the root set/clear requirement.

Signed-off-by: Amit Nischal <anischal@codeaurora.org>
---
 drivers/clk/qcom/clk-rcg.h  |  1 +
 drivers/clk/qcom/clk-rcg2.c | 87 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
index b209a2f..c8c9558 100644
--- a/drivers/clk/qcom/clk-rcg.h
+++ b/drivers/clk/qcom/clk-rcg.h
@@ -160,5 +160,6 @@ struct clk_rcg2 {
 extern const struct clk_ops clk_pixel_ops;
 extern const struct clk_ops clk_gfx3d_ops;
 extern const struct clk_ops clk_rcg2_shared_ops;
+extern const struct clk_ops clk_rcg2_gfx3d_ops;

 #endif
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 52208d4..667edd9 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -866,7 +866,7 @@ static int clk_rcg2_shared_set_rate_and_parent(struct clk_hw *hw,
 	return clk_rcg2_shared_set_rate(hw, rate, parent_rate);
 }

-static int clk_rcg2_shared_enable(struct clk_hw *hw)
+static int __clk_rcg2_shared_enable(struct clk_hw *hw)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	int ret;
@@ -879,7 +879,14 @@ static int clk_rcg2_shared_enable(struct clk_hw *hw)
 	if (ret)
 		return ret;

-	ret = update_config(rcg);
+	return update_config(rcg);
+}
+
+static int clk_rcg2_shared_enable(struct clk_hw *hw)
+{
+	int ret;
+
+	ret = __clk_rcg2_shared_enable(hw);
 	if (ret)
 		return ret;

@@ -929,3 +936,79 @@ static void clk_rcg2_shared_disable(struct clk_hw *hw)
 	.set_rate_and_parent = clk_rcg2_shared_set_rate_and_parent,
 };
 EXPORT_SYMBOL_GPL(clk_rcg2_shared_ops);
+
+static int clk_rcg2_gfx3d_enable(struct clk_hw *hw)
+{
+	return __clk_rcg2_shared_enable(hw);
+}
+
+static int clk_rcg2_gfx3d_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req)
+{
+	struct clk_rate_request parent_req = { };
+	struct clk_hw *p;
+	unsigned long rate = req->rate;
+	int ret;
+
+	if (rate < req->min_rate || rate > req->max_rate)
+		return -EINVAL;
+
+	/* Get fixed parent - GPU_CC_PLL0_OUT_EVEN */
+	p = clk_hw_get_parent_by_index(hw, 1);
+
+	/* Parent should always run at twice of the requested rate */
+	parent_req.rate = 2 * req->rate;
+
+	ret = __clk_determine_rate(req->best_parent_hw, &parent_req);
+	if (ret)
+		return ret;
+
+	req->best_parent_hw = p;
+	req->best_parent_rate = parent_req.rate;
+	req->rate = parent_req.rate / 2;
+
+	return 0;
+}
+
+static int clk_rcg2_gfx3d_set_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long parent_rate)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	int ret;
+	u32 cfg;
+
+	/* Configure fixed SRC and DIV */
+	cfg = rcg->parent_map[1].cfg << CFG_SRC_SEL_SHIFT;
+	cfg |= 0x3 << CFG_SRC_DIV_SHIFT;
+
+	ret = regmap_write(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, cfg);
+	if (ret)
+		return ret;
+
+	/*
+	 * In case clock is disabled, update the SRC and DIV only
+	 * and return without configuration update.
+	 */
+	if (!__clk_is_enabled(hw->clk))
+		return 0;
+
+	return update_config(rcg);
+}
+
+static int clk_rcg2_gfx3d_set_rate_and_parent(struct clk_hw *hw,
+		unsigned long rate, unsigned long parent_rate, u8 index)
+{
+	return clk_rcg2_gfx3d_set_rate(hw, rate, parent_rate);
+}
+
+const struct clk_ops clk_rcg2_gfx3d_ops = {
+	.enable = clk_rcg2_gfx3d_enable,
+	.disable = clk_rcg2_shared_disable,
+	.get_parent = clk_rcg2_get_parent,
+	.set_parent = clk_rcg2_set_parent,
+	.recalc_rate = clk_rcg2_recalc_rate,
+	.determine_rate = clk_rcg2_gfx3d_determine_rate,
+	.set_rate = clk_rcg2_gfx3d_set_rate,
+	.set_rate_and_parent = clk_rcg2_gfx3d_set_rate_and_parent,
+};
+EXPORT_SYMBOL_GPL(clk_rcg2_gfx3d_ops);
--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

