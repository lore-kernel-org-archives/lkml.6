Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED9AC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 03:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C64F20850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 03:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fP+A7b2C";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Zeq5Wc+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C64F20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbeLDDup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 22:50:45 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35408 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbeLDDuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 22:50:44 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2884660312; Tue,  4 Dec 2018 03:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543895443;
        bh=tagvpmTwwEx+maLqLjA/n6hfBXkdR3dMCKFwz9JGzTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fP+A7b2C6CTs1hGeEPknTq2j/L2AdPlFDPiJYFXmTtbTisYazCePz4jXSm+EPCKKm
         dI4EThLoA12pOvoxVSp8lwdJ9sAW2heIEAU3UZv4zvXpStiDLUi4hPAOVjemV/DKIs
         0gL0Wn4OpIBvsoHJYDaGXyEAXvYZunmzeC3BJtPU=
Received: from davidai-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daidavid1@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A6C3160224;
        Tue,  4 Dec 2018 03:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543895442;
        bh=tagvpmTwwEx+maLqLjA/n6hfBXkdR3dMCKFwz9JGzTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zeq5Wc+SSxgG3xPGnkUvD6OJulXE/NfqsfATreTfMmQ8oQipZltqhlECJt+rVeplj
         BU9rCFjK5DyXcpWjYUXugLOID8ZqLEj6WaPALus5+vh2NY3cXxIJ6Sec5/OjWBSxWO
         ZX3jWywA/EfNoxUCVhdwUYjHD0jyAW2cre3rckg8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A6C3160224
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=daidavid1@codeaurora.org
From:   David Dai <daidavid1@codeaurora.org>
To:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     David Dai <daidavid1@codeaurora.org>, georgi.djakov@linaro.org,
        bjorn.andersson@linaro.org, evgreen@google.com,
        tdas@codeaurora.org, elder@linaro.org
Subject: [RFC PATCH] clk: qcom: clk-rpmh: Add IPA clock support
Date:   Mon,  3 Dec 2018 19:50:13 -0800
Message-Id: <1543895413-1553-2-git-send-email-daidavid1@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1543895413-1553-1-git-send-email-daidavid1@codeaurora.org>
References: <1543895413-1553-1-git-send-email-daidavid1@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IPA clock support by extending the current clk rpmh driver to support
clocks that are managed by a different type of RPMh resource known as
Bus Clock Manager(BCM).

Signed-off-by: David Dai <daidavid1@codeaurora.org>
---
 drivers/clk/qcom/clk-rpmh.c           | 142 ++++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/qcom,rpmh.h |   1 +
 2 files changed, 143 insertions(+)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index 9f4fc77..42e2cd2 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -18,6 +18,32 @@
 #define CLK_RPMH_ARC_EN_OFFSET		0
 #define CLK_RPMH_VRM_EN_OFFSET		4
 
+#define BCM_TCS_CMD_COMMIT_MASK		0x40000000
+#define BCM_TCS_CMD_VALID_SHIFT		29
+#define BCM_TCS_CMD_VOTE_MASK		0x3fff
+#define BCM_TCS_CMD_VOTE_SHIFT		0
+
+#define BCM_TCS_CMD(valid, vote) \
+	(BCM_TCS_CMD_COMMIT_MASK |\
+	((valid) << BCM_TCS_CMD_VALID_SHIFT) |\
+	((cpu_to_le32(vote) &\
+	BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_SHIFT))
+
+/**
+ * struct bcm_db - Auxiliary data pertaining to each Bus Clock Manager(BCM)
+ * @unit: divisor used to convert Hz value to an RPMh msg
+ * @width: multiplier used to convert Hz value to an RPMh msg
+ * @vcd: virtual clock domain that this bcm belongs to
+ * @reserved: reserved to pad the struct
+ */
+
+struct bcm_db {
+	u32 unit;
+	u16 width;
+	u8 vcd;
+	u8 reserved;
+};
+
 /**
  * struct clk_rpmh - individual rpmh clock data structure
  * @hw:			handle between common and hardware-specific interfaces
@@ -29,6 +55,7 @@
  * @aggr_state:		rpmh clock aggregated state
  * @last_sent_aggr_state: rpmh clock last aggr state sent to RPMh
  * @valid_state_mask:	mask to determine the state of the rpmh clock
+ * @aux_data:		data specific to the bcm rpmh resource
  * @dev:		device to which it is attached
  * @peer:		pointer to the clock rpmh sibling
  */
@@ -42,6 +69,7 @@ struct clk_rpmh {
 	u32 aggr_state;
 	u32 last_sent_aggr_state;
 	u32 valid_state_mask;
+	struct bcm_db aux_data;
 	struct device *dev;
 	struct clk_rpmh *peer;
 };
@@ -98,6 +126,17 @@ struct clk_rpmh_desc {
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
@@ -210,6 +249,91 @@ static unsigned long clk_rpmh_recalc_rate(struct clk_hw *hw,
 	.recalc_rate	= clk_rpmh_recalc_rate,
 };
 
+static int clk_rpmh_bcm_send_cmd(struct clk_rpmh *c, bool enable)
+{
+	struct tcs_cmd cmd = { 0 };
+	u32 cmd_state;
+	int ret;
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
+	return 0;
+}
+
+static int clk_rpmh_bcm_prepare(struct clk_hw *hw)
+{
+	struct clk_rpmh *c = to_clk_rpmh(hw);
+	int ret = 0;
+
+	mutex_lock(&rpmh_clk_lock);
+	ret = clk_rpmh_bcm_send_cmd(c, true);
+	mutex_unlock(&rpmh_clk_lock);
+
+	return ret;
+};
+
+static void clk_rpmh_bcm_unprepare(struct clk_hw *hw)
+{
+	struct clk_rpmh *c = to_clk_rpmh(hw);
+
+	mutex_lock(&rpmh_clk_lock);
+	clk_rpmh_bcm_send_cmd(c, false);
+	mutex_unlock(&rpmh_clk_lock);
+};
+
+static int clk_rpmh_bcm_set_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long parent_rate)
+{
+	struct clk_rpmh *c = to_clk_rpmh(hw);
+
+	c->aggr_state = rate / (c->aux_data.unit * 1000);
+
+	if (clk_hw_is_prepared(hw)) {
+		mutex_lock(&rpmh_clk_lock);
+		clk_rpmh_bcm_send_cmd(c, true);
+		mutex_unlock(&rpmh_clk_lock);
+	}
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
+	return c->aggr_state * c->aux_data.unit * 1000;
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
@@ -217,6 +341,7 @@ static unsigned long clk_rpmh_recalc_rate(struct clk_hw *hw,
 DEFINE_CLK_RPMH_VRM(sdm845, rf_clk1, rf_clk1_ao, "rfclka1", 1);
 DEFINE_CLK_RPMH_VRM(sdm845, rf_clk2, rf_clk2_ao, "rfclka2", 1);
 DEFINE_CLK_RPMH_VRM(sdm845, rf_clk3, rf_clk3_ao, "rfclka3", 1);
+DEFINE_CLK_RPMH_BCM(sdm845, ipa, "IP0");
 
 static struct clk_hw *sdm845_rpmh_clocks[] = {
 	[RPMH_CXO_CLK]		= &sdm845_bi_tcxo.hw,
@@ -231,6 +356,7 @@ static unsigned long clk_rpmh_recalc_rate(struct clk_hw *hw,
 	[RPMH_RF_CLK2_A]	= &sdm845_rf_clk2_ao.hw,
 	[RPMH_RF_CLK3]		= &sdm845_rf_clk3.hw,
 	[RPMH_RF_CLK3_A]	= &sdm845_rf_clk3_ao.hw,
+	[RPMH_IPA_CLK]		= &sdm845_ipa.hw,
 };
 
 static const struct clk_rpmh_desc clk_rpmh_sdm845 = {
@@ -267,6 +393,7 @@ static int clk_rpmh_probe(struct platform_device *pdev)
 
 	for (i = 0; i < desc->num_clks; i++) {
 		u32 res_addr;
+		u32 aux_data_len;
 
 		rpmh_clk = to_clk_rpmh(hw_clks[i]);
 		res_addr = cmd_db_read_addr(rpmh_clk->res_name);
@@ -275,6 +402,21 @@ static int clk_rpmh_probe(struct platform_device *pdev)
 				rpmh_clk->res_name);
 			return -ENODEV;
 		}
+		aux_data_len = cmd_db_read_aux_data_len(rpmh_clk->res_name);
+		if (aux_data_len == sizeof(struct bcm_db)) {
+			ret = cmd_db_read_aux_data(rpmh_clk->res_name,
+						   (u8 *)&rpmh_clk->aux_data,
+						   sizeof(struct bcm_db));
+			if (ret < 0) {
+				dev_err(&pdev->dev, "aux data read failure for %s (%d)\n",
+				rpmh_clk->res_name, ret);
+				return ret;
+			}
+			rpmh_clk->aux_data.unit =
+					le32_to_cpu(rpmh_clk->aux_data.unit);
+			rpmh_clk->aux_data.width =
+					le16_to_cpu(rpmh_clk->aux_data.width);
+		}
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

