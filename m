Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D78C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4AE22086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DILfCc0k";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GTLTdrpq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4AE22086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeJIVPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:15:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42200 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeJIVPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:15:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 186CA60C88; Tue,  9 Oct 2018 13:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539093490;
        bh=QwS1nk7JYNcuKFwGPNj0qqwAGA4SD/NCg0heL3j6coQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DILfCc0kn4UH0JaKJy5WA0HZbmwmuZsm96BnnU3hhsQI6Y5aq69GdPn1WZs4XpjDn
         fsv5I5+Qux7L3evEFHvHW/0iPxOl2vpk8iKHqOkvUikpRwA806MaP8tPAQTVLFRE1f
         YHOmcP3FpsRcdMpHlz8tYGD4hk9dqh5muxvqiTfk=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1D13E60C5F;
        Tue,  9 Oct 2018 13:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539093486;
        bh=QwS1nk7JYNcuKFwGPNj0qqwAGA4SD/NCg0heL3j6coQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GTLTdrpqR93pasnHdiKvHnz60XKuyEpXHxwxPjLYgXdqoh5sgQkqI9Zx9+TsatRg2
         4EeZGbsxzfa1eco4CNZtRYHm8ThoVJ0FmYAy+06KHmpHzBGzbK1PS7UD19NWPzJdL5
         RsrnxsEwOpFgNqjEu0ZjUtwQ6cpwKkRyRI42ZsfY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1D13E60C5F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        chandanu@codeaurora.org, Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v1 1/2] clk: qcom: rcg2: Add support for display port clock ops
Date:   Tue,  9 Oct 2018 19:27:46 +0530
Message-Id: <1539093467-12123-2-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539093467-12123-1-git-send-email-tdas@codeaurora.org>
References: <1539093467-12123-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New display port clock ops supported for display port clocks.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/clk-rcg.h  |  1 +
 drivers/clk/qcom/clk-rcg2.c | 86 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
index e5eca8a..e0db0f7 100644
--- a/drivers/clk/qcom/clk-rcg.h
+++ b/drivers/clk/qcom/clk-rcg.h
@@ -162,6 +162,7 @@ struct clk_rcg2 {
 extern const struct clk_ops clk_pixel_ops;
 extern const struct clk_ops clk_gfx3d_ops;
 extern const struct clk_ops clk_rcg2_shared_ops;
+extern const struct clk_ops clk_dp_ops;

 struct clk_rcg_dfs_data {
 	struct clk_rcg2 *rcg;
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 6e3bd19..ca6142f 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -10,6 +10,7 @@
 #include <linux/export.h>
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
+#include <linux/rational.h>
 #include <linux/regmap.h>
 #include <linux/math64.h>
 #include <linux/slab.h>
@@ -1124,3 +1125,88 @@ int qcom_cc_register_rcg_dfs(struct regmap *regmap,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(qcom_cc_register_rcg_dfs);
+
+static int clk_rcg2_dp_set_rate(struct clk_hw *hw, unsigned long rate,
+			unsigned long parent_rate)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	struct freq_tbl f = { 0 };
+	unsigned long src_rate;
+	unsigned long num, den;
+	u32 mask = BIT(rcg->hid_width) - 1;
+	u32 hid_div, cfg;
+	int i, num_parents = clk_hw_get_num_parents(hw);
+
+	src_rate = clk_hw_get_rate(clk_hw_get_parent(hw));
+	if (src_rate <= 0) {
+		pr_err("Invalid RCG parent rate\n");
+		return -EINVAL;
+	}
+
+	rational_best_approximation(src_rate, rate,
+			(unsigned long)(1 << 16) - 1,
+			(unsigned long)(1 << 16) - 1, &den, &num);
+
+	if (!num || !den) {
+		pr_err("Invalid MN values derived for requested rate %lu\n",
+							rate);
+		return -EINVAL;
+	}
+
+	regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, &cfg);
+	hid_div = cfg;
+	cfg &= CFG_SRC_SEL_MASK;
+	cfg >>= CFG_SRC_SEL_SHIFT;
+
+	for (i = 0; i < num_parents; i++)
+		if (cfg == rcg->parent_map[i].cfg) {
+			f.src = rcg->parent_map[i].src;
+			break;
+	}
+
+	f.pre_div = hid_div;
+	f.pre_div >>= CFG_SRC_DIV_SHIFT;
+	f.pre_div &= mask;
+
+	if (num == den) {
+		f.m = 0;
+		f.n = 0;
+	} else {
+		f.m = num;
+		f.n = den;
+	}
+
+	return clk_rcg2_configure(rcg, &f);
+}
+
+static int clk_rcg2_dp_set_rate_and_parent(struct clk_hw *hw,
+		unsigned long rate, unsigned long parent_rate, u8 index)
+{
+	return clk_rcg2_dp_set_rate(hw, rate, parent_rate);
+}
+
+static int clk_rcg2_dp_determine_rate(struct clk_hw *hw,
+				struct clk_rate_request *req)
+{
+	if (!hw)
+		return -EINVAL;
+
+	if (!clk_hw_get_parent(hw)) {
+		pr_err("Missing the parent for the DP RCG\n");
+		return -EINVAL;
+	}
+
+	req->best_parent_rate = clk_hw_get_rate(clk_hw_get_parent(hw));
+	return 0;
+}
+
+const struct clk_ops clk_dp_ops = {
+	.is_enabled = clk_rcg2_is_enabled,
+	.get_parent = clk_rcg2_get_parent,
+	.set_parent = clk_rcg2_set_parent,
+	.recalc_rate = clk_rcg2_recalc_rate,
+	.set_rate = clk_rcg2_dp_set_rate,
+	.set_rate_and_parent = clk_rcg2_dp_set_rate_and_parent,
+	.determine_rate = clk_rcg2_dp_determine_rate,
+};
+EXPORT_SYMBOL_GPL(clk_dp_ops);
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

