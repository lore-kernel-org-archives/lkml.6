Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753486AbeEUR2X (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 13:28:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57032 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753468AbeEUR2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 13:28:16 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 877C76090E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From: Sibi Sankar <sibis@codeaurora.org>
To: bjorn.andersson@linaro.org, p.zabel@pengutronix.de, robh+dt@kernel.org
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, jassisinghbrar@gmail.com, ohad@wizery.com,
        mark.rutland@arm.com, kyan@codeaurora.org, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org,
        tsoni@codeaurora.org
Subject: [PATCH v5 7/8] remoteproc: qcom: Add support for mss remoteproc on SDM845
Date: Mon, 21 May 2018 22:57:13 +0530
Message-Id: <20180521172714.8551-8-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521172714.8551-1-sibis@codeaurora.org>
References: <20180521172714.8551-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From SDM845, the Q6SS reset sequence on software side has been
simplified with the introduction of boot FSM which assists in
bringing the Q6 out of reset.

SDM845 brings a new reset signal ALT_RESET which is a part of
the MSS subsystem hence requires reset clks to be enabled before
assert/deassert. Use the SoC specific reset helper function to
add support for ALT_RESET in SDM845.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_pil.c | 109 ++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
index 552805bc07c1..5e85ce975ef8 100644
--- a/drivers/remoteproc/qcom_q6v5_pil.c
+++ b/drivers/remoteproc/qcom_q6v5_pil.c
@@ -57,6 +57,8 @@
 #define RMB_PMI_META_DATA_REG		0x10
 #define RMB_PMI_CODE_START_REG		0x14
 #define RMB_PMI_CODE_LENGTH_REG		0x18
+#define RMB_MBA_MSS_STATUS		0x40
+#define RMB_MBA_ALT_RESET		0x44
 
 #define RMB_CMD_META_DATA_READY		0x1
 #define RMB_CMD_LOAD_READY		0x2
@@ -104,6 +106,13 @@
 #define QDSP6SS_XO_CBCR		0x0038
 #define QDSP6SS_ACC_OVERRIDE_VAL		0x20
 
+/* QDSP6v65 parameters */
+#define QDSP6SS_SLEEP                   0x3C
+#define QDSP6SS_BOOT_CORE_START         0x400
+#define QDSP6SS_BOOT_CMD                0x404
+#define SLEEP_CHECK_MAX_LOOPS           200
+#define BOOT_FSM_TIMEOUT                10000
+
 struct reg_info {
 	struct regulator *reg;
 	int uV;
@@ -121,9 +130,11 @@ struct rproc_hexagon_res {
 	struct qcom_mss_reg_res *proxy_supply;
 	struct qcom_mss_reg_res *active_supply;
 	char **proxy_clk_names;
+	char **reset_clk_names;
 	char **active_clk_names;
 	int version;
 	bool need_mem_protection;
+	bool has_alt_reset;
 };
 
 struct q6v5 {
@@ -148,8 +159,10 @@ struct q6v5 {
 	int fatal_irq;
 
 	struct clk *active_clks[8];
+	struct clk *reset_clks[4];
 	struct clk *proxy_clks[4];
 	int active_clk_count;
+	int reset_clk_count;
 	int proxy_clk_count;
 
 	struct reg_info active_regs[1];
@@ -174,6 +187,7 @@ struct q6v5 {
 	struct qcom_rproc_ssr ssr_subdev;
 	struct qcom_sysmon *sysmon;
 	bool need_mem_protection;
+	bool has_alt_reset;
 	bool unvoted_flag;
 	int mpss_perm;
 	int mba_perm;
@@ -184,6 +198,7 @@ enum {
 	MSS_MSM8916,
 	MSS_MSM8974,
 	MSS_MSM8996,
+	MSS_SDM845,
 };
 
 static int q6v5_regulator_init(struct device *dev, struct reg_info *regs,
@@ -354,11 +369,22 @@ static int q6v5_load(struct rproc *rproc, const struct firmware *fw)
 
 static int q6v5_reset_assert(struct q6v5 *qproc)
 {
+	if (qproc->has_alt_reset)
+		return reset_control_reset(qproc->mss_restart);
+
 	return reset_control_assert(qproc->mss_restart);
 }
 
 static int q6v5_reset_deassert(struct q6v5 *qproc)
 {
+	if (qproc->has_alt_reset) {
+		writel(1, qproc->rmb_base + RMB_MBA_ALT_RESET);
+		reset_control_reset(qproc->mss_restart);
+		writel(0, qproc->rmb_base + RMB_MBA_ALT_RESET);
+
+		return 0;
+	}
+
 	return reset_control_deassert(qproc->mss_restart);
 }
 
@@ -414,8 +440,35 @@ static int q6v5proc_reset(struct q6v5 *qproc)
 	int ret;
 	int i;
 
+	if (qproc->version == MSS_SDM845) {
+		val = readl(qproc->reg_base + QDSP6SS_SLEEP);
+		val |= 0x1;
+		writel(val, qproc->reg_base + QDSP6SS_SLEEP);
 
-	if (qproc->version == MSS_MSM8996) {
+		ret = readl_poll_timeout(qproc->reg_base + QDSP6SS_SLEEP,
+					 val, !(val & BIT(31)), 1,
+					 SLEEP_CHECK_MAX_LOOPS);
+		if (ret) {
+			dev_err(qproc->dev, "QDSP6SS Sleep clock timed out\n");
+			return -ETIMEDOUT;
+		}
+
+		/* De-assert QDSP6 stop core */
+		writel(1, qproc->reg_base + QDSP6SS_BOOT_CORE_START);
+		/* Trigger boot FSM */
+		writel(1, qproc->reg_base + QDSP6SS_BOOT_CMD);
+
+		ret = readl_poll_timeout(qproc->rmb_base + RMB_MBA_MSS_STATUS,
+				val, (val & BIT(0)) != 0, 10, BOOT_FSM_TIMEOUT);
+		if (ret) {
+			dev_err(qproc->dev, "Boot FSM failed to complete.\n");
+			/* Reset the modem so that boot FSM is in reset state */
+			q6v5_reset_deassert(qproc);
+			return ret;
+		}
+
+		goto pbl_wait;
+	} else if (qproc->version == MSS_MSM8996) {
 		/* Override the ACC value if required */
 		writel(QDSP6SS_ACC_OVERRIDE_VAL,
 		       qproc->reg_base + QDSP6SS_STRAP_ACC);
@@ -523,6 +576,7 @@ static int q6v5proc_reset(struct q6v5 *qproc)
 	val &= ~Q6SS_STOP_CORE;
 	writel(val, qproc->reg_base + QDSP6SS_RESET_REG);
 
+pbl_wait:
 	/* Wait for PBL status */
 	ret = q6v5_rmb_pbl_wait(qproc, 1000);
 	if (ret == -ETIMEDOUT) {
@@ -777,10 +831,18 @@ static int q6v5_start(struct rproc *rproc)
 		dev_err(qproc->dev, "failed to enable supplies\n");
 		goto disable_proxy_clk;
 	}
+
+	ret = q6v5_clk_enable(qproc->dev, qproc->reset_clks,
+			      qproc->reset_clk_count);
+	if (ret) {
+		dev_err(qproc->dev, "failed to enable reset clocks\n");
+		goto disable_vdd;
+	}
+
 	ret = q6v5_reset_deassert(qproc);
 	if (ret) {
 		dev_err(qproc->dev, "failed to deassert mss restart\n");
-		goto disable_vdd;
+		goto disable_reset_clks;
 	}
 
 	ret = q6v5_clk_enable(qproc->dev, qproc->active_clks,
@@ -870,6 +932,9 @@ static int q6v5_start(struct rproc *rproc)
 
 assert_reset:
 	q6v5_reset_assert(qproc);
+disable_reset_clks:
+	q6v5_clk_disable(qproc->dev, qproc->reset_clks,
+			 qproc->reset_clk_count);
 disable_vdd:
 	q6v5_regulator_disable(qproc, qproc->active_regs,
 			       qproc->active_reg_count);
@@ -929,6 +994,8 @@ static int q6v5_stop(struct rproc *rproc)
 				       qproc->proxy_reg_count);
 	}
 
+	q6v5_clk_disable(qproc->dev, qproc->reset_clks,
+			 qproc->reset_clk_count);
 	q6v5_clk_disable(qproc->dev, qproc->active_clks,
 			 qproc->active_clk_count);
 	q6v5_regulator_disable(qproc, qproc->active_regs,
@@ -1208,6 +1275,14 @@ static int q6v5_probe(struct platform_device *pdev)
 	}
 	qproc->proxy_clk_count = ret;
 
+	ret = q6v5_init_clocks(&pdev->dev, qproc->reset_clks,
+			       desc->reset_clk_names);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to get reset clocks.\n");
+		goto free_rproc;
+	}
+	qproc->reset_clk_count = ret;
+
 	ret = q6v5_init_clocks(&pdev->dev, qproc->active_clks,
 			       desc->active_clk_names);
 	if (ret < 0) {
@@ -1237,6 +1312,7 @@ static int q6v5_probe(struct platform_device *pdev)
 		goto free_rproc;
 
 	qproc->version = desc->version;
+	qproc->has_alt_reset = desc->has_alt_reset;
 	qproc->need_mem_protection = desc->need_mem_protection;
 	ret = q6v5_request_irq(qproc, pdev, "wdog", q6v5_wdog_interrupt,
 			       &qproc->wdog_irq);
@@ -1301,6 +1377,31 @@ static int q6v5_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct rproc_hexagon_res sdm845_mss = {
+	.hexagon_mba_image = "mba.mbn",
+	.proxy_clk_names = (char*[]){
+			"xo",
+			"axis2",
+			"prng",
+			NULL
+	},
+	.reset_clk_names = (char*[]){
+			"iface",
+			"snoc_axi",
+			NULL
+	},
+	.active_clk_names = (char*[]){
+			"bus",
+			"mem",
+			"gpll0_mss",
+			"mnoc_axi",
+			NULL
+	},
+	.need_mem_protection = true,
+	.has_alt_reset = true,
+	.version = MSS_SDM845,
+};
+
 static const struct rproc_hexagon_res msm8996_mss = {
 	.hexagon_mba_image = "mba.mbn",
 	.proxy_clk_names = (char*[]){
@@ -1316,6 +1417,7 @@ static const struct rproc_hexagon_res msm8996_mss = {
 			NULL
 	},
 	.need_mem_protection = true,
+	.has_alt_reset = false,
 	.version = MSS_MSM8996,
 };
 
@@ -1347,6 +1449,7 @@ static const struct rproc_hexagon_res msm8916_mss = {
 		NULL
 	},
 	.need_mem_protection = false,
+	.has_alt_reset = false,
 	.version = MSS_MSM8916,
 };
 
@@ -1386,6 +1489,7 @@ static const struct rproc_hexagon_res msm8974_mss = {
 		NULL
 	},
 	.need_mem_protection = false,
+	.has_alt_reset = false,
 	.version = MSS_MSM8974,
 };
 
@@ -1394,6 +1498,7 @@ static const struct of_device_id q6v5_of_match[] = {
 	{ .compatible = "qcom,msm8916-mss-pil", .data = &msm8916_mss},
 	{ .compatible = "qcom,msm8974-mss-pil", .data = &msm8974_mss},
 	{ .compatible = "qcom,msm8996-mss-pil", .data = &msm8996_mss},
+	{ .compatible = "qcom,sdm845-mss-pil", .data = &sdm845_mss},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, q6v5_of_match);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
