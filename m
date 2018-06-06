Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eUIXmjhY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jSAen/Li"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BF697607E5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbeFFLm1 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 07:42:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43288 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752224AbeFFLmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 07:42:23 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1648B60767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=anischal@codeaurora.org
From: Amit Nischal <anischal@codeaurora.org>
To: Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Nischal <anischal@codeaurora.org>
Subject: [PATCH 2/4] clk: qcom: Add clk_rcg2_gfx3d_ops for SDM845
Date: Wed,  6 Jun 2018 17:11:46 +0530
Message-Id: <1528285308-25477-3-git-send-email-anischal@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1528285308-25477-1-git-send-email-anischal@codeaurora.org>
References: <1528285308-25477-1-git-send-email-anischal@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To turn on the gpu_gx_gdsc, there is a hardware requirement to
turn on the root clock (GFX3D RCG) first which would be the turn
on signal for the gdsc along with the SW_COLLAPSE. As per the
current implementation of clk_rcg2_shared_ops, it clears the
root_enable bit in the enable() and set_rate() clock ops. But due
to the above said requirement for GFX3D shared RCG, root_enable bit
would be already set by gdsc driver and rcg2_shared_ops should not clear
the root unless the disable is called.

Add support for the same by reusing the existing clk_rcg2_shared_ops
and deriving "clk_rcg2_gfx3d_ops" clk_ops for GFX3D clock to
take care of the root set/clear requirement.

Signed-off-by: Amit Nischal <anischal@codeaurora.org>
---
 drivers/clk/qcom/clk-rcg.h  |  1 +
 drivers/clk/qcom/clk-rcg2.c | 78 +++++++++++++++++++++++++++++++++------------
 2 files changed, 58 insertions(+), 21 deletions(-)

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
index 52208d4..491e710 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -823,28 +823,12 @@ static int clk_rcg2_clear_force_enable(struct clk_hw *hw)
 					CMD_ROOT_EN, 0);
 }

-static int
-clk_rcg2_shared_force_enable_clear(struct clk_hw *hw, const struct freq_tbl *f)
-{
-	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
-	int ret;
-
-	ret = clk_rcg2_set_force_enable(hw);
-	if (ret)
-		return ret;
-
-	ret = clk_rcg2_configure(rcg, f);
-	if (ret)
-		return ret;
-
-	return clk_rcg2_clear_force_enable(hw);
-}
-
-static int clk_rcg2_shared_set_rate(struct clk_hw *hw, unsigned long rate,
+static int __clk_rcg2_shared_set_rate(struct clk_hw *hw, unsigned long rate,
 				    unsigned long parent_rate)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	const struct freq_tbl *f;
+	int ret;

 	f = qcom_find_freq(rcg->freq_tbl, rate);
 	if (!f)
@@ -857,7 +841,23 @@ static int clk_rcg2_shared_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (!__clk_is_enabled(hw->clk))
 		return __clk_rcg2_configure(rcg, f);

-	return clk_rcg2_shared_force_enable_clear(hw, f);
+	ret = clk_rcg2_set_force_enable(hw);
+	if (ret)
+		return ret;
+
+	return clk_rcg2_configure(rcg, f);
+}
+
+static int clk_rcg2_shared_set_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long parent_rate)
+{
+	int ret;
+
+	ret = __clk_rcg2_shared_set_rate(hw, rate, parent_rate);
+	if (ret)
+		return ret;
+
+	return clk_rcg2_clear_force_enable(hw);
 }

 static int clk_rcg2_shared_set_rate_and_parent(struct clk_hw *hw,
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

@@ -929,3 +936,32 @@ static void clk_rcg2_shared_disable(struct clk_hw *hw)
 	.set_rate_and_parent = clk_rcg2_shared_set_rate_and_parent,
 };
 EXPORT_SYMBOL_GPL(clk_rcg2_shared_ops);
+
+static int clk_rcg2_gfx3d_enable(struct clk_hw *hw)
+{
+	return __clk_rcg2_shared_enable(hw);
+}
+
+static int clk_rcg2_gfx3d_set_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long parent_rate)
+{
+	return __clk_rcg2_shared_set_rate(hw, rate, parent_rate);
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
+	.determine_rate = clk_rcg2_determine_rate,
+	.set_rate = clk_rcg2_gfx3d_set_rate,
+	.set_rate_and_parent = clk_rcg2_gfx3d_set_rate_and_parent,
+};
+EXPORT_SYMBOL_GPL(clk_rcg2_gfx3d_ops);
--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
