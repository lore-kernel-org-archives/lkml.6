Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425607AbeCBJ0M (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 04:26:12 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49608 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425657AbeCBJYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 04:24:38 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E3582607EF
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
Subject: [PATCH 5/6] remoteproc: qcom: Add support for mss remoteproc on SDM845
Date: Fri,  2 Mar 2018 14:53:38 +0530
Message-Id: <1519982619-28336-6-git-send-email-sibis@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519982619-28336-1-git-send-email-sibis@codeaurora.org>
References: <1519982619-28336-1-git-send-email-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From SDM845, the Q6SS reset sequence on software side has been
simplified with the introduction of boot FSM which assists in
bringing the Q6 out of reset

Add GLINK subdevice to allow definition of GLINK edge as a
child of modem-pil

Reset assert/deassert sequence vary across SoCs adding reset
start/stop helper functions to handle SoC specific reset sequences

Signed-off-by: sibis <sibis@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_pil.c | 134 +++++++++++++++++++++++++++++++++++--
 1 file changed, 129 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
index b4e5e72..f4997e0 100644
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
@@ -126,6 +135,8 @@ struct rproc_hexagon_res {
 	bool need_mem_protection;
 };
 
+struct q6v5_reset_ops;
+
 struct q6v5 {
 	struct device *dev;
 	struct rproc *rproc;
@@ -166,6 +177,8 @@ struct q6v5 {
 	void *mpss_region;
 	size_t mpss_size;
 
+	const struct q6v5_reset_ops *ops;
+	struct qcom_rproc_glink glink_subdev;
 	struct qcom_rproc_subdev smd_subdev;
 	struct qcom_rproc_ssr ssr_subdev;
 	bool need_mem_protection;
@@ -174,10 +187,16 @@ struct q6v5 {
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
 	MSS_MSM8996,
+	MSS_SDM845,
 };
 
 static int q6v5_regulator_init(struct device *dev, struct reg_info *regs,
@@ -332,6 +351,52 @@ static int q6v5_load(struct rproc *rproc, const struct firmware *fw)
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
@@ -384,8 +449,37 @@ static int q6v5proc_reset(struct q6v5 *qproc)
 	int ret;
 	int i;
 
+	if (qproc->version == MSS_SDM845) {
 
-	if (qproc->version == MSS_MSM8996) {
+		val = readl(qproc->reg_base + QDSP6SS_SLEEP);
+		val |= 0x1;
+		writel(val, qproc->reg_base + QDSP6SS_SLEEP);
+
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
+			qproc->ops->reset_start(qproc);
+			return ret;
+		}
+
+		goto pbl_wait;
+
+	} else if (qproc->version == MSS_MSM8996) {
 		/* Override the ACC value if required */
 		writel(QDSP6SS_ACC_OVERRIDE_VAL,
 		       qproc->reg_base + QDSP6SS_STRAP_ACC);
@@ -493,6 +587,7 @@ static int q6v5proc_reset(struct q6v5 *qproc)
 	val &= ~Q6SS_STOP_CORE;
 	writel(val, qproc->reg_base + QDSP6SS_RESET_REG);
 
+pbl_wait:
 	/* Wait for PBL status */
 	ret = q6v5_rmb_pbl_wait(qproc, 1000);
 	if (ret == -ETIMEDOUT) {
@@ -746,7 +841,7 @@ static int q6v5_start(struct rproc *rproc)
 		dev_err(qproc->dev, "failed to enable supplies\n");
 		goto disable_proxy_clk;
 	}
-	ret = reset_control_deassert(qproc->mss_restart);
+	ret = qproc->ops->reset_start(qproc);
 	if (ret) {
 		dev_err(qproc->dev, "failed to deassert mss restart\n");
 		goto disable_vdd;
@@ -841,7 +936,7 @@ static int q6v5_start(struct rproc *rproc)
 			 qproc->active_clk_count);
 
 assert_reset:
-	reset_control_assert(qproc->mss_restart);
+	qproc->ops->reset_stop(qproc);
 disable_vdd:
 	q6v5_regulator_disable(qproc, qproc->active_regs,
 			       qproc->active_reg_count);
@@ -891,7 +986,7 @@ static int q6v5_stop(struct rproc *rproc)
 				      qproc->mpss_phys, qproc->mpss_size);
 	WARN_ON(ret);
 
-	reset_control_assert(qproc->mss_restart);
+	qproc->ops->reset_stop(qproc);
 	q6v5_clk_disable(qproc->dev, qproc->active_clks,
 			 qproc->active_clk_count);
 	q6v5_regulator_disable(qproc, qproc->active_regs,
@@ -1140,6 +1235,12 @@ static int q6v5_probe(struct platform_device *pdev)
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
@@ -1188,7 +1289,6 @@ static int q6v5_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_rproc;
 
-	qproc->version = desc->version;
 	qproc->need_mem_protection = desc->need_mem_protection;
 	ret = q6v5_request_irq(qproc, pdev, "wdog", q6v5_wdog_interrupt);
 	if (ret < 0)
@@ -1213,6 +1313,7 @@ static int q6v5_probe(struct platform_device *pdev)
 	}
 	qproc->mpss_perm = BIT(QCOM_SCM_VMID_HLOS);
 	qproc->mba_perm = BIT(QCOM_SCM_VMID_HLOS);
+	qcom_add_glink_subdev(rproc, &qproc->glink_subdev);
 	qcom_add_smd_subdev(rproc, &qproc->smd_subdev);
 	qcom_add_ssr_subdev(rproc, &qproc->ssr_subdev, "mpss");
 
@@ -1234,6 +1335,7 @@ static int q6v5_remove(struct platform_device *pdev)
 
 	rproc_del(qproc->rproc);
 
+	qcom_remove_glink_subdev(qproc->rproc, &qproc->glink_subdev);
 	qcom_remove_smd_subdev(qproc->rproc, &qproc->smd_subdev);
 	qcom_remove_ssr_subdev(qproc->rproc, &qproc->ssr_subdev);
 	rproc_free(qproc->rproc);
@@ -1241,6 +1343,27 @@ static int q6v5_remove(struct platform_device *pdev)
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
+	.active_clk_names = (char*[]){
+			"iface",
+			"bus",
+			"mem",
+			"gpll0_mss",
+			"snoc_axi",
+			"mnoc_axi",
+			NULL
+	},
+	.need_mem_protection = true,
+	.version = MSS_SDM845,
+};
+
 static const struct rproc_hexagon_res msm8996_mss = {
 	.hexagon_mba_image = "mba.mbn",
 	.proxy_clk_names = (char*[]){
@@ -1334,6 +1457,7 @@ static int q6v5_remove(struct platform_device *pdev)
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
