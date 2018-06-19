Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EB3C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB65F20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iLkIuTj0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UySvlzBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB65F20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966667AbeFSNrE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:47:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43284 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966163AbeFSNqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:46:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C94CE607EB; Tue, 19 Jun 2018 13:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529416010;
        bh=7yI9ryNtjIPjGEcVAHt6mvNlqNPwFW9guSn53oj2F2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iLkIuTj0GoxVKH63XLqRfACr1ZKm/5e//BG70h3cMmtRTYQYqhyNt9ieb5H6uWhE7
         UwPBluvC5NNScEMMD71hxDnwyG2c9NAXL+T9kTHGQX7kbbUL3/LJvDY+AefRZY1L2X
         V7YMUnUq9rfKK4jzYqBgMtIHxedLR0Q20Us63sRg=
Received: from srichara-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5CF1160B13;
        Tue, 19 Jun 2018 13:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529416006;
        bh=7yI9ryNtjIPjGEcVAHt6mvNlqNPwFW9guSn53oj2F2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UySvlzBOcORd79DN8NFHjG8o5tGs0IYRS37iwd+MXFOvImU2aBg0ufGu5nZBTSoKU
         hWF4YbKrme1ku1VTRA/jhuFb6DjC4CxK3apR9hVZ3GxmrMuiVeFCN8pkOGZhRT9HUw
         kPzBA5Cvmkzb2PKDFU3ZjA/rVV/8fs2FoR+87ZIg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5CF1160B13
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From:   Sricharan R <sricharan@codeaurora.org>
To:     robh@kernel.org, viresh.kumar@linaro.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@codeaurora.org,
        linux@armlinux.org.uk, andy.gross@linaro.org,
        david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux@arm.linux.org.uk,
        thierry.escande@linaro.org, ctatlor97@gmail.com
Cc:     sricharan@codeaurora.org
Subject: [PATCH v10 12/14] clk: qcom: Add safe switch hook for krait mux clocks
Date:   Tue, 19 Jun 2018 19:15:23 +0530
Message-Id: <1529415925-28915-13-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529415925-28915-1-git-send-email-sricharan@codeaurora.org>
References: <1529415925-28915-1-git-send-email-sricharan@codeaurora.org>
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
index a651710..ee1076c 100644
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
1.9.1

