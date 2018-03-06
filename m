Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933120AbeCFOlJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:41:09 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52318 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932801AbeCFOlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:41:05 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D1A360FF8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From: Sricharan R <sricharan@codeaurora.org>
To: robh@kernel.org, viresh.kumar@linaro.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux@arm.linux.org.uk
Cc: sricharan@codeaurora.org
Subject: [PATCH v9 13/15] clk: qcom: Add safe switch hook for krait mux clocks
Date: Tue,  6 Mar 2018 20:09:06 +0530
Message-Id: <1520347148-27852-14-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520347148-27852-1-git-send-email-sricharan@codeaurora.org>
References: <1520347148-27852-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the Hfplls are reprogrammed during the rate change,
the primary muxes which are sourced from the same hfpll
for higher frequencies, needs to be switched to the 'safe
secondary mux' as the parent for that small window. This
is done by registering a clk notifier for the muxes and
switching to the safe parent in the PRE_RATE_CHANGE notifier
and back to the original parent in the POST_RATE_CHANGE notifier.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/clk/qcom/clk-krait.c |  2 ++
 drivers/clk/qcom/clk-krait.h |  3 +++
 drivers/clk/qcom/krait-cc.c  | 56 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/drivers/clk/qcom/clk-krait.c b/drivers/clk/qcom/clk-krait.c
index 2e41767..ac2e020 100644
--- a/drivers/clk/qcom/clk-krait.c
+++ b/drivers/clk/qcom/clk-krait.c
@@ -50,6 +50,8 @@ static int krait_mux_set_parent(struct clk_hw *hw, u8 index)
 	if (__clk_is_enabled(hw->clk))
 		__krait_mux_set_sel(mux, sel);
 
+	mux->reparent = true;
+
 	return 0;
 }
 
diff --git a/drivers/clk/qcom/clk-krait.h b/drivers/clk/qcom/clk-krait.h
index 71890bc..986f356 100644
--- a/drivers/clk/qcom/clk-krait.h
+++ b/drivers/clk/qcom/clk-krait.h
@@ -13,6 +13,9 @@ struct krait_mux_clk {
 	u32		shift;
 	u32		en_mask;
 	bool		lpl;
+	u8		safe_sel;
+	u8		old_index;
+	bool		reparent;
 
 	struct clk_hw	hw;
 	struct notifier_block   clk_nb;
diff --git a/drivers/clk/qcom/krait-cc.c b/drivers/clk/qcom/krait-cc.c
index 7c9dfb0..4d4b657 100644
--- a/drivers/clk/qcom/krait-cc.c
+++ b/drivers/clk/qcom/krait-cc.c
@@ -26,6 +26,49 @@
 	0,
 };
 
+/*
+ * Notifier function for switching the muxes to safe parent
+ * while the hfpll is getting reprogrammed.
+ */
+static int krait_notifier_cb(struct notifier_block *nb,
+			     unsigned long event,
+			     void *data)
+{
+	int ret = 0;
+	struct krait_mux_clk *mux = container_of(nb, struct krait_mux_clk,
+						 clk_nb);
+	/* Switch to safe parent */
+	if (event == PRE_RATE_CHANGE) {
+		mux->old_index = krait_mux_clk_ops.get_parent(&mux->hw);
+		ret = krait_mux_clk_ops.set_parent(&mux->hw, mux->safe_sel);
+		mux->reparent = false;
+	/*
+	 * By the time POST_RATE_CHANGE notifier is called,
+	 * clk framework itself would have changed the parent for the new rate.
+	 * Only otherwise, put back to the old parent.
+	 */
+	} else if (event == POST_RATE_CHANGE) {
+		if (!mux->reparent)
+			ret = krait_mux_clk_ops.set_parent(&mux->hw,
+							   mux->old_index);
+	}
+
+	return notifier_from_errno(ret);
+}
+
+static int krait_notifier_register(struct device *dev, struct clk *clk,
+				   struct krait_mux_clk *mux)
+{
+	int ret = 0;
+
+	mux->clk_nb.notifier_call = krait_notifier_cb;
+	ret = clk_notifier_register(clk, &mux->clk_nb);
+	if (ret)
+		dev_err(dev, "failed to register clock notifier: %d\n", ret);
+
+	return ret;
+}
+
 static int
 krait_add_div(struct device *dev, int id, const char *s, unsigned int offset)
 {
@@ -70,6 +113,7 @@
 krait_add_sec_mux(struct device *dev, int id, const char *s,
 		  unsigned int offset, bool unique_aux)
 {
+	int ret;
 	struct krait_mux_clk *mux;
 	static const char *sec_mux_list[] = {
 		"acpu_aux",
@@ -93,6 +137,7 @@
 	mux->shift = 2;
 	mux->parent_map = sec_mux_map;
 	mux->hw.init = &init;
+	mux->safe_sel = 0;
 
 	init.name = kasprintf(GFP_KERNEL, "krait%s_sec_mux", s);
 	if (!init.name)
@@ -108,6 +153,11 @@
 
 	clk = devm_clk_register(dev, &mux->hw);
 
+	ret = krait_notifier_register(dev, clk, mux);
+	if (ret)
+		goto unique_aux;
+
+unique_aux:
 	if (unique_aux)
 		kfree(sec_mux_list[0]);
 err_aux:
@@ -119,6 +169,7 @@
 krait_add_pri_mux(struct device *dev, int id, const char *s,
 		  unsigned int offset)
 {
+	int ret;
 	struct krait_mux_clk *mux;
 	const char *p_names[3];
 	struct clk_init_data init = {
@@ -139,6 +190,7 @@
 	mux->lpl = id >= 0;
 	mux->parent_map = pri_mux_map;
 	mux->hw.init = &init;
+	mux->safe_sel = 2;
 
 	init.name = kasprintf(GFP_KERNEL, "krait%s_pri_mux", s);
 	if (!init.name)
@@ -164,6 +216,10 @@
 
 	clk = devm_clk_register(dev, &mux->hw);
 
+	ret = krait_notifier_register(dev, clk, mux);
+	if (ret)
+		goto err_p3;
+err_p3:
 	kfree(p_names[2]);
 err_p2:
 	kfree(p_names[1]);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
