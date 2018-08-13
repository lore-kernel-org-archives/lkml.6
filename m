Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE6CC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBF921747
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RRe1pkKm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WysaFIS1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBF921747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbeHMQUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 12:20:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59924 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbeHMQUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 12:20:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C615860D0B; Mon, 13 Aug 2018 13:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534167506;
        bh=ldc0WMWvlds2EQ7RCkF8xSmUH8Hk8lJKEZbeIrOigFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RRe1pkKm4LA8PSLC9g+aXH5LJHkczESq52gqDLyMzRhRlR4AjaP3/daIbqYuMRsXx
         lqZJEEheDwBhszzMTxAHCuNR4eJfmybPvE3lcFIpw6gLsHtMWSXJLeXNKkngn43hw+
         pAqXfORL/SkyeykaOkJP6gMh67LXc4y8ACi3hly8=
Received: from srichara-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 571CE60E42;
        Mon, 13 Aug 2018 13:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534167467;
        bh=ldc0WMWvlds2EQ7RCkF8xSmUH8Hk8lJKEZbeIrOigFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WysaFIS1kCnYQRjrYivubt6Fo7oZHDW7qd+9U+06ksT8zDWeiwWjBz3u9tbjyyxrV
         siUpjPtkQpsOog/EdZdYzoR6Jiwp8YvMa2fTFSj0/MUXGPxGuROnzg7WujYdc9vPhu
         5m2SebUXmwfmk6qdKHYBNQiTBOiWk3TR/8fzWOZo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 571CE60E42
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From:   Sricharan R <sricharan@codeaurora.org>
To:     mark.rutland@arm.com, robh@kernel.org, sudeep.holla@arm.com,
        linux@arm.linux.org.uk, ctatlor97@gmail.com, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, mturquette@baylibre.com,
        linux-pm@vger.kernel.org, sboyd@codeaurora.org,
        linux@armlinux.org.uk, thierry.escande@linaro.org,
        linux-kernel@vger.kernel.org, david.brown@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        andy.gross@linaro.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        niklas.cassel@linaro.org
Cc:     sricharan@codeaurora.org
Subject: [PATCH 12/14] clk: qcom: Add safe switch hook for krait mux clocks
Date:   Mon, 13 Aug 2018 19:06:05 +0530
Message-Id: <1534167367-17545-13-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1534167367-17545-1-git-send-email-sricharan@codeaurora.org>
References: <1534167367-17545-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
index 7ede744..59f1af4 100644
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
index 441ba1e..9120bd2 100644
--- a/drivers/clk/qcom/clk-krait.h
+++ b/drivers/clk/qcom/clk-krait.h
@@ -12,6 +12,9 @@ struct krait_mux_clk {
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

