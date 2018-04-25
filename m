Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754931AbeDYPJv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 11:09:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40682 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754959AbeDYPJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 11:09:46 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F2B2760AE0
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
Subject: [PATCH v4 5/5] remoteproc: qcom: Always assert and deassert reset signals in SDM845
Date: Wed, 25 Apr 2018 20:38:43 +0530
Message-Id: <20180425150843.26657-6-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425150843.26657-1-sibis@codeaurora.org>
References: <20180425150843.26657-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDM845 brings a new reset signal ALT_RESET which is a part of the MSS
subsystem hence requires some of the active clks to be enabled before
assert/deassert

Reset the modem if the BOOT FSM does timeout

Reset assert/deassert sequence vary across SoCs adding reset, adding
start/stop helper functions to handle SoC specific reset sequences

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_pil.c | 81 ++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
index 4d9504e8bf8e..99ef3f51c528 100644
--- a/drivers/remoteproc/qcom_q6v5_pil.c
+++ b/drivers/remoteproc/qcom_q6v5_pil.c
@@ -130,9 +130,11 @@ struct rproc_hexagon_res {
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
@@ -157,8 +159,10 @@ struct q6v5 {
 	unsigned int fatal_interrupt;
 
 	struct clk *active_clks[8];
+	struct clk *reset_clks[4];
 	struct clk *proxy_clks[4];
 	int active_clk_count;
+	int reset_clk_count;
 	int proxy_clk_count;
 
 	struct reg_info active_regs[1];
@@ -179,6 +183,9 @@ struct q6v5 {
 	void *mpss_region;
 	size_t mpss_size;
 
+	int (*reset_deassert)(struct q6v5 *qproc);
+	int (*reset_assert)(struct q6v5 *qproc);
+
 	struct qcom_rproc_glink glink_subdev;
 	struct qcom_rproc_subdev smd_subdev;
 	struct qcom_rproc_ssr ssr_subdev;
@@ -349,6 +356,32 @@ static int q6v5_load(struct rproc *rproc, const struct firmware *fw)
 	return 0;
 }
 
+static int q6v5_reset_assert(struct q6v5 *qproc)
+{
+	return reset_control_assert(qproc->mss_restart);
+}
+
+static int q6v5_reset_deassert(struct q6v5 *qproc)
+{
+	return reset_control_deassert(qproc->mss_restart);
+}
+
+static int q6v5_alt_reset_assert(struct q6v5 *qproc)
+{
+	return reset_control_reset(qproc->mss_restart);
+}
+
+static int q6v5_alt_reset_deassert(struct q6v5 *qproc)
+{
+	/* Ensure alt reset is written before restart reg */
+	writel(1, qproc->rmb_base + RMB_MBA_ALT_RESET);
+
+	reset_control_reset(qproc->mss_restart);
+
+	writel(0, qproc->rmb_base + RMB_MBA_ALT_RESET);
+	return 0;
+}
+
 static int q6v5_rmb_pbl_wait(struct q6v5 *qproc, int ms)
 {
 	unsigned long timeout;
@@ -424,6 +457,8 @@ static int q6v5proc_reset(struct q6v5 *qproc)
 				val, (val & BIT(0)) != 0, 10, BOOT_FSM_TIMEOUT);
 		if (ret) {
 			dev_err(qproc->dev, "Boot FSM failed to complete.\n");
+			/* Reset the modem so that boot FSM is in reset state */
+			qproc->reset_deassert(qproc);
 			return ret;
 		}
 
@@ -792,12 +827,20 @@ static int q6v5_start(struct rproc *rproc)
 		dev_err(qproc->dev, "failed to enable supplies\n");
 		goto disable_proxy_clk;
 	}
-	ret = reset_control_deassert(qproc->mss_restart);
+
+	ret = q6v5_clk_enable(qproc->dev, qproc->reset_clks,
+			      qproc->reset_clk_count);
 	if (ret) {
-		dev_err(qproc->dev, "failed to deassert mss restart\n");
+		dev_err(qproc->dev, "failed to enable reset clocks\n");
 		goto disable_vdd;
 	}
 
+	ret = qproc->reset_deassert(qproc);
+	if (ret) {
+		dev_err(qproc->dev, "failed to deassert mss restart\n");
+		goto disable_reset_clks;
+	}
+
 	ret = q6v5_clk_enable(qproc->dev, qproc->active_clks,
 			      qproc->active_clk_count);
 	if (ret) {
@@ -888,7 +931,10 @@ static int q6v5_start(struct rproc *rproc)
 			 qproc->active_clk_count);
 
 assert_reset:
-	reset_control_assert(qproc->mss_restart);
+	qproc->reset_assert(qproc);
+disable_reset_clks:
+	q6v5_clk_disable(qproc->dev, qproc->reset_clks,
+			 qproc->reset_clk_count);
 disable_vdd:
 	q6v5_regulator_disable(qproc, qproc->active_regs,
 			       qproc->active_reg_count);
@@ -938,7 +984,7 @@ static int q6v5_stop(struct rproc *rproc)
 				      qproc->mpss_phys, qproc->mpss_size);
 	WARN_ON(ret);
 
-	reset_control_assert(qproc->mss_restart);
+	qproc->reset_assert(qproc);
 	disable_irq(qproc->handover_interrupt);
 	if (!qproc->unvoted_flag) {
 		q6v5_clk_disable(qproc->dev, qproc->proxy_clks,
@@ -949,6 +995,8 @@ static int q6v5_stop(struct rproc *rproc)
 	disable_irq(qproc->wdog_interrupt);
 	disable_irq(qproc->fatal_interrupt);
 
+	q6v5_clk_disable(qproc->dev, qproc->reset_clks,
+			 qproc->reset_clk_count);
 	q6v5_clk_disable(qproc->dev, qproc->active_clks,
 			 qproc->active_clk_count);
 	q6v5_regulator_disable(qproc, qproc->active_regs,
@@ -1211,6 +1259,14 @@ static int q6v5_probe(struct platform_device *pdev)
 	qproc->rproc = rproc;
 	platform_set_drvdata(pdev, qproc);
 
+	if (desc->has_alt_reset) {
+		qproc->reset_deassert = q6v5_alt_reset_deassert;
+		qproc->reset_assert = q6v5_alt_reset_assert;
+	} else {
+		qproc->reset_deassert = q6v5_reset_deassert;
+		qproc->reset_assert = q6v5_reset_assert;
+	}
+
 	init_completion(&qproc->start_done);
 	init_completion(&qproc->stop_done);
 
@@ -1230,6 +1286,14 @@ static int q6v5_probe(struct platform_device *pdev)
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
@@ -1335,8 +1399,11 @@ static const struct rproc_hexagon_res sdm845_mss = {
 			"prng",
 			NULL
 	},
-	.active_clk_names = (char*[]){
+	.reset_clk_names = (char*[]){
 			"iface",
+			NULL
+	},
+	.active_clk_names = (char*[]){
 			"bus",
 			"mem",
 			"gpll0_mss",
@@ -1345,6 +1412,7 @@ static const struct rproc_hexagon_res sdm845_mss = {
 			NULL
 	},
 	.need_mem_protection = true,
+	.has_alt_reset = true,
 	.version = MSS_SDM845,
 };
 
@@ -1363,6 +1431,7 @@ static const struct rproc_hexagon_res msm8996_mss = {
 			NULL
 	},
 	.need_mem_protection = true,
+	.has_alt_reset = false,
 	.version = MSS_MSM8996,
 };
 
@@ -1394,6 +1463,7 @@ static const struct rproc_hexagon_res msm8916_mss = {
 		NULL
 	},
 	.need_mem_protection = false,
+	.has_alt_reset = false,
 	.version = MSS_MSM8916,
 };
 
@@ -1433,6 +1503,7 @@ static const struct rproc_hexagon_res msm8974_mss = {
 		NULL
 	},
 	.need_mem_protection = false,
+	.has_alt_reset = false,
 	.version = MSS_MSM8974,
 };
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
