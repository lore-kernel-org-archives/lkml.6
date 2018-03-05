Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933945AbeCEJyi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 04:54:38 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48192 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933903AbeCEJya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 04:54:30 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ACB3D607F5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From: sibis <sibis@codeaurora.org>
To: bjorn.andersson@linaro.org
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, jassisinghbrar@gmail.com,
        p.zabel@pengutronix.de, ohad@wizery.com, mark.rutland@arm.com,
        robh+dt@kernel.org, kyan@codeaurora.org, sricharan@codeaurora.org,
        akdwived@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 6/6] remoteproc: qcom: Always assert and deassert reset signals in SDM845
Date: Mon,  5 Mar 2018 15:23:33 +0530
Message-Id: <1520243613-30393-7-git-send-email-sibis@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520243613-30393-1-git-send-email-sibis@codeaurora.org>
References: <1520243613-30393-1-git-send-email-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDM845 brings a new reset signal ALT_RESET which is a part of the MSS
subsystem hence requires some of the active clks to be enabled before
assert/deassert

Reset the modem if the BOOT FSM does timeout

Reset assert/deassert sequence vary across SoCs adding reset, adding
start/stop helper functions to handle SoC specific reset sequences

Signed-off-by: sibis <sibis@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_pil.c | 100 ++++++++++++++++++++++++++++++++++---
 1 file changed, 94 insertions(+), 6 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
index 92bf125..bd8c397 100644
--- a/drivers/remoteproc/qcom_q6v5_pil.c
+++ b/drivers/remoteproc/qcom_q6v5_pil.c
@@ -130,11 +130,14 @@ struct rproc_hexagon_res {
 	struct qcom_mss_reg_res *proxy_supply;
 	struct qcom_mss_reg_res *active_supply;
 	char **proxy_clk_names;
+	char **reset_clk_names;
 	char **active_clk_names;
 	int version;
 	bool need_mem_protection;
 };
 
+struct q6v5_reset_ops;
+
 struct q6v5 {
 	struct device *dev;
 	struct rproc *rproc;
@@ -153,8 +156,10 @@ struct q6v5 {
 	unsigned stop_bit;
 
 	struct clk *active_clks[8];
+	struct clk *reset_clks[4];
 	struct clk *proxy_clks[4];
 	int active_clk_count;
+	int reset_clk_count;
 	int proxy_clk_count;
 
 	struct reg_info active_regs[1];
@@ -175,6 +180,7 @@ struct q6v5 {
 	void *mpss_region;
 	size_t mpss_size;
 
+	const struct q6v5_reset_ops *ops;
 	struct qcom_rproc_glink glink_subdev;
 	struct qcom_rproc_subdev smd_subdev;
 	struct qcom_rproc_ssr ssr_subdev;
@@ -184,6 +190,11 @@ struct q6v5 {
 	int version;
 };
 
+struct q6v5_reset_ops {
+	int (*reset_start)(struct q6v5 *qproc);
+	int (*reset_stop)(struct q6v5 *qproc);
+};
+
 enum {
 	MSS_MSM8916,
 	MSS_MSM8974,
@@ -343,6 +354,52 @@ static int q6v5_load(struct rproc *rproc, const struct firmware *fw)
 	return 0;
 }
 
+static void alt_reset_restart(struct q6v5 *qproc, u32 restart)
+{
+	writel(restart, qproc->rmb_base + RMB_MBA_ALT_RESET);
+}
+
+static int q6v5_msm_reset_stop(struct q6v5 *qproc)
+{
+	return reset_control_assert(qproc->mss_restart);
+}
+
+static int q6v5_msm_reset_start(struct q6v5 *qproc)
+{
+	return reset_control_deassert(qproc->mss_restart);
+}
+
+static int q6v5_sdm_reset_stop(struct q6v5 *qproc)
+{
+	return reset_control_reset(qproc->mss_restart);
+}
+
+static int q6v5_sdm_reset_start(struct q6v5 *qproc)
+{
+	int ret;
+
+	alt_reset_restart(qproc, 1);
+	/* Ensure alt reset is written before restart reg */
+	udelay(100);
+
+	ret = reset_control_reset(qproc->mss_restart);
+
+	udelay(100);
+	alt_reset_restart(qproc, 0);
+
+	return ret;
+}
+
+static const struct q6v5_reset_ops q6v5_msm_ops = {
+	.reset_stop = q6v5_msm_reset_stop,
+	.reset_start = q6v5_msm_reset_start,
+};
+
+static const struct q6v5_reset_ops q6v5_sdm_ops = {
+	.reset_stop = q6v5_sdm_reset_stop,
+	.reset_start = q6v5_sdm_reset_start,
+};
+
 static int q6v5_rmb_pbl_wait(struct q6v5 *qproc, int ms)
 {
 	unsigned long timeout;
@@ -418,6 +475,8 @@ static int q6v5proc_reset(struct q6v5 *qproc)
 				val, (val & BIT(0)) != 0, 10, BOOT_FSM_TIMEOUT);
 		if (ret) {
 			dev_err(qproc->dev, "Boot FSM failed to complete.\n");
+			/* Reset the modem so that boot FSM is in reset state */
+			qproc->ops->reset_start(qproc);
 			return ret;
 		}
 
@@ -785,10 +844,18 @@ static int q6v5_start(struct rproc *rproc)
 		dev_err(qproc->dev, "failed to enable supplies\n");
 		goto disable_proxy_clk;
 	}
-	ret = reset_control_deassert(qproc->mss_restart);
+
+	ret = q6v5_clk_enable(qproc->dev, qproc->reset_clks,
+			      qproc->reset_clk_count);
+	if (ret) {
+		dev_err(qproc->dev, "failed to enable reset clocks\n");
+		goto disable_vdd;
+	}
+
+	ret = qproc->ops->reset_start(qproc);
 	if (ret) {
 		dev_err(qproc->dev, "failed to deassert mss restart\n");
-		goto disable_vdd;
+		goto disable_reset_clks;
 	}
 
 	ret = q6v5_clk_enable(qproc->dev, qproc->active_clks,
@@ -880,7 +947,10 @@ static int q6v5_start(struct rproc *rproc)
 			 qproc->active_clk_count);
 
 assert_reset:
-	reset_control_assert(qproc->mss_restart);
+	qproc->ops->reset_stop(qproc);
+disable_reset_clks:
+	q6v5_clk_disable(qproc->dev, qproc->reset_clks,
+			 qproc->reset_clk_count);
 disable_vdd:
 	q6v5_regulator_disable(qproc, qproc->active_regs,
 			       qproc->active_reg_count);
@@ -930,9 +1000,11 @@ static int q6v5_stop(struct rproc *rproc)
 				      qproc->mpss_phys, qproc->mpss_size);
 	WARN_ON(ret);
 
-	reset_control_assert(qproc->mss_restart);
+	qproc->ops->reset_stop(qproc);
 	q6v5_clk_disable(qproc->dev, qproc->active_clks,
 			 qproc->active_clk_count);
+	q6v5_clk_disable(qproc->dev, qproc->reset_clks,
+			 qproc->reset_clk_count);
 	q6v5_regulator_disable(qproc, qproc->active_regs,
 			       qproc->active_reg_count);
 
@@ -1179,6 +1251,12 @@ static int q6v5_probe(struct platform_device *pdev)
 	qproc->dev = &pdev->dev;
 	qproc->rproc = rproc;
 	platform_set_drvdata(pdev, qproc);
+	qproc->version = desc->version;
+
+	if (qproc->version == MSS_SDM845)
+		qproc->ops = &q6v5_sdm_ops;
+	else
+		qproc->ops = &q6v5_msm_ops;
 
 	init_completion(&qproc->start_done);
 	init_completion(&qproc->stop_done);
@@ -1199,6 +1277,14 @@ static int q6v5_probe(struct platform_device *pdev)
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
@@ -1227,7 +1313,6 @@ static int q6v5_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_rproc;
 
-	qproc->version = desc->version;
 	qproc->need_mem_protection = desc->need_mem_protection;
 	ret = q6v5_request_irq(qproc, pdev, "wdog", q6v5_wdog_interrupt);
 	if (ret < 0)
@@ -1290,8 +1375,11 @@ static int q6v5_remove(struct platform_device *pdev)
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
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
