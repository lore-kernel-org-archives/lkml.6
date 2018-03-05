Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933960AbeCEJy7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 04:54:59 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48086 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933361AbeCEJyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 04:54:24 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 07BFA6081C
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
Date: Mon,  5 Mar 2018 15:23:32 +0530
Message-Id: <1520243613-30393-6-git-send-email-sibis@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520243613-30393-1-git-send-email-sibis@codeaurora.org>
References: <1520243613-30393-1-git-send-email-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From SDM845, the Q6SS reset sequence on software side has been
simplified with the introduction of boot FSM which assists in
bringing the Q6 out of reset

Add GLINK subdevice to allow definition of GLINK edge as a
child of modem-pil

Signed-off-by: sibis <sibis@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_pil.c | 65 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
index b4e5e72..92bf125 100644
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
@@ -166,6 +175,7 @@ struct q6v5 {
 	void *mpss_region;
 	size_t mpss_size;
 
+	struct qcom_rproc_glink glink_subdev;
 	struct qcom_rproc_subdev smd_subdev;
 	struct qcom_rproc_ssr ssr_subdev;
 	bool need_mem_protection;
@@ -178,6 +188,7 @@ enum {
 	MSS_MSM8916,
 	MSS_MSM8974,
 	MSS_MSM8996,
+	MSS_SDM845,
 };
 
 static int q6v5_regulator_init(struct device *dev, struct reg_info *regs,
@@ -384,8 +395,35 @@ static int q6v5proc_reset(struct q6v5 *qproc)
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
+			return ret;
+		}
+
+		goto pbl_wait;
+
+	} else if (qproc->version == MSS_MSM8996) {
 		/* Override the ACC value if required */
 		writel(QDSP6SS_ACC_OVERRIDE_VAL,
 		       qproc->reg_base + QDSP6SS_STRAP_ACC);
@@ -493,6 +531,7 @@ static int q6v5proc_reset(struct q6v5 *qproc)
 	val &= ~Q6SS_STOP_CORE;
 	writel(val, qproc->reg_base + QDSP6SS_RESET_REG);
 
+pbl_wait:
 	/* Wait for PBL status */
 	ret = q6v5_rmb_pbl_wait(qproc, 1000);
 	if (ret == -ETIMEDOUT) {
@@ -1213,6 +1252,7 @@ static int q6v5_probe(struct platform_device *pdev)
 	}
 	qproc->mpss_perm = BIT(QCOM_SCM_VMID_HLOS);
 	qproc->mba_perm = BIT(QCOM_SCM_VMID_HLOS);
+	qcom_add_glink_subdev(rproc, &qproc->glink_subdev);
 	qcom_add_smd_subdev(rproc, &qproc->smd_subdev);
 	qcom_add_ssr_subdev(rproc, &qproc->ssr_subdev, "mpss");
 
@@ -1234,6 +1274,7 @@ static int q6v5_remove(struct platform_device *pdev)
 
 	rproc_del(qproc->rproc);
 
+	qcom_remove_glink_subdev(qproc->rproc, &qproc->glink_subdev);
 	qcom_remove_smd_subdev(qproc->rproc, &qproc->smd_subdev);
 	qcom_remove_ssr_subdev(qproc->rproc, &qproc->ssr_subdev);
 	rproc_free(qproc->rproc);
@@ -1241,6 +1282,27 @@ static int q6v5_remove(struct platform_device *pdev)
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
@@ -1334,6 +1396,7 @@ static int q6v5_remove(struct platform_device *pdev)
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
