Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_MIXED_ES,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690A8C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 02:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE552086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 02:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Xa6YipLM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oJbDm7wI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE552086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbeLNCfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 21:35:15 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:42148 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbeLNCfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 21:35:14 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F1CF3601E7; Fri, 14 Dec 2018 02:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544754913;
        bh=cPTLGuUz/rlnX/opxzjZU9PlCopro2P+r+cJw+D4btE=;
        h=From:To:Cc:Subject:Date:From;
        b=Xa6YipLMYK3LCTb2UeG5uOt2axihHW/L5MDMYbKQlobowHV+osm7N5NEGLIpimif5
         gm8l1WaSn7LNYHqrdVr3pS/a773tHUMws7cfYFc2fVBAOMiOitOz6M0PolrTXQk8cx
         IIHuZBgdUgC7NVfRyF642E9EVDdRMBZp47wQZFkU=
Received: from davidai-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daidavid1@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 62567600E2;
        Fri, 14 Dec 2018 02:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544754911;
        bh=cPTLGuUz/rlnX/opxzjZU9PlCopro2P+r+cJw+D4btE=;
        h=From:To:Cc:Subject:Date:From;
        b=oJbDm7wI0IG9Q4LzuE+6rzhzf/KrecJb8vRt1n3ZYsnbon1yRIf5vE21y9njobpGq
         z3NbGRRkRto0aR84CkthvneWUTtB24Y1YtnTJ2vx1e7/ZaAiivbCttwwU1LbdTJiEc
         +Y44Kc7qd4rNFe/LXIrfZrat4KPMIVIN4aoguI9g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 62567600E2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=daidavid1@codeaurora.org
From:   David Dai <daidavid1@codeaurora.org>
To:     sboyd@kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     David Dai <daidavid1@codeaurora.org>, georgi.djakov@linaro.org,
        bjorn.andersson@linaro.org, evgreen@google.com,
        tdas@codeaurora.org, elder@linaro.org
Subject: [PATCH v1] clk: qcom: clk-rpmh: Add IPA clock support
Date:   Thu, 13 Dec 2018 18:35:04 -0800
Message-Id: <1544754904-18951-1-git-send-email-daidavid1@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current clk-rpmh driver only supports on and off RPMh clock resources,
let's extend the current driver by add support for clocks that are managed
by a different type of RPMh resource known as Bus Clock Manager(BCM).
The BCM is a configurable shared resource aggregator that scales performance
based on a preset of frequency points. The Qualcomm IP Accelerator (IPA) clock
is an example of a resource that is managed by the BCM and this a requirement
from the IPA driver in order to scale its core clock.

Signed-off-by: David Dai <daidavid1@codeaurora.org>
---
 drivers/clk/qcom/clk-rpmh.c           | 141 ++++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/qcom,rpmh.h |   1 +
 2 files changed, 142 insertions(+)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index 9f4fc77..ee78c4b 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -18,6 +18,31 @@
 #define CLK_RPMH_ARC_EN_OFFSET		0
 #define CLK_RPMH_VRM_EN_OFFSET		4
 
+#define BCM_TCS_CMD_COMMIT_MASK		0x40000000
+#define BCM_TCS_CMD_VALID_SHIFT		29
+#define BCM_TCS_CMD_VOTE_MASK		0x3fff
+#define BCM_TCS_CMD_VOTE_SHIFT		0
+
+#define BCM_TCS_CMD(valid, vote)				\
+	(BCM_TCS_CMD_COMMIT_MASK |				\
+	((valid) << BCM_TCS_CMD_VALID_SHIFT) |			\
+	((cpu_to_le32(vote) &					\
+	BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_SHIFT))
+
+/**
+ * struct bcm_db - Auxiliary data pertaining to each Bus Clock Manager(BCM)
+ * @unit: divisor used to convert Hz value to an RPMh msg
+ * @width: multiplier used to convert Hz value to an RPMh msg
+ * @vcd: virtual clock domain that this bcm belongs to
+ * @reserved: reserved to pad the struct
+ */
+struct bcm_db {
+	__le32 unit;
+	__le16 width;
+	u8 vcd;
+	u8 reserved;
+};
+
 /**
  * struct clk_rpmh - individual rpmh clock data structure
  * @hw:			handle between common and hardware-specific interfaces
@@ -29,6 +54,7 @@
  * @aggr_state:		rpmh clock aggregated state
  * @last_sent_aggr_state: rpmh clock last aggr state sent to RPMh
  * @valid_state_mask:	mask to determine the state of the rpmh clock
+ * @aux_data:		data specific to the bcm rpmh resource
  * @dev:		device to which it is attached
  * @peer:		pointer to the clock rpmh sibling
  */
@@ -42,6 +68,7 @@ struct clk_rpmh {
 	u32 aggr_state;
 	u32 last_sent_aggr_state;
 	u32 valid_state_mask;
+	u32 unit;
 	struct device *dev;
 	struct clk_rpmh *peer;
 };
@@ -98,6 +125,17 @@ struct clk_rpmh_desc {
 	__DEFINE_CLK_RPMH(_platform, _name, _name_active, _res_name,	\
 			  CLK_RPMH_VRM_EN_OFFSET, 1, _div)
 
+#define DEFINE_CLK_RPMH_BCM(_platform, _name, _res_name)		\
+	static struct clk_rpmh _platform##_##_name = {			\
+		.res_name = _res_name,					\
+		.valid_state_mask = BIT(RPMH_ACTIVE_ONLY_STATE),	\
+		.div = 1,						\
+		.hw.init = &(struct clk_init_data){			\
+			.ops = &clk_rpmh_bcm_ops,			\
+			.name = #_name,					\
+		},							\
+	}
+
 static inline struct clk_rpmh *to_clk_rpmh(struct clk_hw *_hw)
 {
 	return container_of(_hw, struct clk_rpmh, hw);
@@ -210,6 +248,91 @@ static unsigned long clk_rpmh_recalc_rate(struct clk_hw *hw,
 	.recalc_rate	= clk_rpmh_recalc_rate,
 };
 
+static int clk_rpmh_bcm_send_cmd(struct clk_rpmh *c, bool enable)
+{
+	struct tcs_cmd cmd = { 0 };
+	u32 cmd_state;
+	int ret;
+
+	mutex_lock(&rpmh_clk_lock);
+
+	cmd_state = enable ? (c->aggr_state ? c->aggr_state : 1) : 0;
+
+	if (c->last_sent_aggr_state == cmd_state)
+		return 0;
+
+	cmd.addr = c->res_addr;
+	cmd.data = BCM_TCS_CMD(enable, cmd_state);
+
+	ret = rpmh_write_async(c->dev, RPMH_ACTIVE_ONLY_STATE, &cmd, 1);
+	if (ret) {
+		dev_err(c->dev, "set active state of %s failed: (%d)\n",
+			c->res_name, ret);
+		return ret;
+	}
+
+	c->last_sent_aggr_state = cmd_state;
+
+	mutex_unlock(&rpmh_clk_lock);
+
+	return 0;
+}
+
+static int clk_rpmh_bcm_prepare(struct clk_hw *hw)
+{
+	struct clk_rpmh *c = to_clk_rpmh(hw);
+	int ret;
+
+	ret = clk_rpmh_bcm_send_cmd(c, true);
+
+	return ret;
+};
+
+static void clk_rpmh_bcm_unprepare(struct clk_hw *hw)
+{
+	struct clk_rpmh *c = to_clk_rpmh(hw);
+
+	clk_rpmh_bcm_send_cmd(c, false);
+};
+
+static int clk_rpmh_bcm_set_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long parent_rate)
+{
+	struct clk_rpmh *c = to_clk_rpmh(hw);
+
+	c->aggr_state = rate / c->unit;
+	/*
+	 * Since any non-zero value sent to hw would result in enabling the
+	 * clock, only send the value if the clock has already been prepared.
+	 */
+	if (clk_hw_is_prepared(hw))
+		clk_rpmh_bcm_send_cmd(c, true);
+
+	return 0;
+};
+
+static long clk_rpmh_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *parent_rate)
+{
+	return rate;
+}
+
+static unsigned long clk_rpmh_bcm_recalc_rate(struct clk_hw *hw,
+					unsigned long prate)
+{
+	struct clk_rpmh *c = to_clk_rpmh(hw);
+
+	return c->aggr_state * c->unit;
+}
+
+static const struct clk_ops clk_rpmh_bcm_ops = {
+	.prepare	= clk_rpmh_bcm_prepare,
+	.unprepare	= clk_rpmh_bcm_unprepare,
+	.set_rate	= clk_rpmh_bcm_set_rate,
+	.round_rate	= clk_rpmh_round_rate,
+	.recalc_rate	= clk_rpmh_bcm_recalc_rate,
+};
+
 /* Resource name must match resource id present in cmd-db. */
 DEFINE_CLK_RPMH_ARC(sdm845, bi_tcxo, bi_tcxo_ao, "xo.lvl", 0x3, 2);
 DEFINE_CLK_RPMH_VRM(sdm845, ln_bb_clk2, ln_bb_clk2_ao, "lnbclka2", 2);
@@ -217,6 +340,7 @@ static unsigned long clk_rpmh_recalc_rate(struct clk_hw *hw,
 DEFINE_CLK_RPMH_VRM(sdm845, rf_clk1, rf_clk1_ao, "rfclka1", 1);
 DEFINE_CLK_RPMH_VRM(sdm845, rf_clk2, rf_clk2_ao, "rfclka2", 1);
 DEFINE_CLK_RPMH_VRM(sdm845, rf_clk3, rf_clk3_ao, "rfclka3", 1);
+DEFINE_CLK_RPMH_BCM(sdm845, ipa, "IP0");
 
 static struct clk_hw *sdm845_rpmh_clocks[] = {
 	[RPMH_CXO_CLK]		= &sdm845_bi_tcxo.hw,
@@ -231,6 +355,7 @@ static unsigned long clk_rpmh_recalc_rate(struct clk_hw *hw,
 	[RPMH_RF_CLK2_A]	= &sdm845_rf_clk2_ao.hw,
 	[RPMH_RF_CLK3]		= &sdm845_rf_clk3.hw,
 	[RPMH_RF_CLK3_A]	= &sdm845_rf_clk3_ao.hw,
+	[RPMH_IPA_CLK]		= &sdm845_ipa.hw,
 };
 
 static const struct clk_rpmh_desc clk_rpmh_sdm845 = {
@@ -267,6 +392,8 @@ static int clk_rpmh_probe(struct platform_device *pdev)
 
 	for (i = 0; i < desc->num_clks; i++) {
 		u32 res_addr;
+		size_t aux_data_len;
+		const struct bcm_db *data;
 
 		rpmh_clk = to_clk_rpmh(hw_clks[i]);
 		res_addr = cmd_db_read_addr(rpmh_clk->res_name);
@@ -275,6 +402,20 @@ static int clk_rpmh_probe(struct platform_device *pdev)
 				rpmh_clk->res_name);
 			return -ENODEV;
 		}
+
+		data = cmd_db_read_aux_data(rpmh_clk->res_name, &aux_data_len);
+		if (IS_ERR(data)) {
+			ret = PTR_ERR(data);
+			dev_err(&pdev->dev,
+				"error reading RPMh aux data for %s (%d)\n",
+				rpmh_clk->res_name, ret);
+				return ret;
+		}
+
+		/* Convert unit from Khz to Hz */
+		if (aux_data_len == sizeof(*data))
+			rpmh_clk->unit = le32_to_cpu(data->unit) * 1000ULL;
+
 		rpmh_clk->res_addr += res_addr;
 		rpmh_clk->dev = &pdev->dev;
 
diff --git a/include/dt-bindings/clock/qcom,rpmh.h b/include/dt-bindings/clock/qcom,rpmh.h
index f48fbd6..edcab3f 100644
--- a/include/dt-bindings/clock/qcom,rpmh.h
+++ b/include/dt-bindings/clock/qcom,rpmh.h
@@ -18,5 +18,6 @@
 #define RPMH_RF_CLK2_A				9
 #define RPMH_RF_CLK3				10
 #define RPMH_RF_CLK3_A				11
+#define RPMH_IPA_CLK				12
 
 #endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

