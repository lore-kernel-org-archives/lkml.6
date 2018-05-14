Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752446AbeENKrq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 06:47:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50916 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752419AbeENKrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 06:47:41 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4238B60209
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From: Sricharan R <sricharan@codeaurora.org>
To: bjorn.andersson@linaro.org, ohad@wizery.com, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org, david.brown@linaro.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, sibis@codeaurora.org
Cc: sricharan@codeaurora.org
Subject: [PATCH V6 4/5] remoteproc: qcom: Add support for q6v5-wcss pil
Date: Mon, 14 May 2018 16:16:51 +0530
Message-Id: <1526294812-23390-5-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526294812-23390-1-git-send-email-sricharan@codeaurora.org>
References: <1526294812-23390-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ8074 has an integrated Hexagon dsp core q6v5 and a wireless lan
(Lithium) IP. An mdt type single image format is used for the
firmware. So the mdt_load function can be directly used to load
the firmware. Also add the relevant resets required for this core.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 .../devicetree/bindings/remoteproc/qcom,q6v5.txt   |  7 +++-
 drivers/remoteproc/Kconfig                         |  1 +
 drivers/remoteproc/qcom_q6v5_pil.c                 | 37 +++++++++++++++++++++-
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
index d901824..3a4a1a92 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
@@ -12,6 +12,7 @@ on the Qualcomm Hexagon core.
 		    "qcom,msm8974-mss-pil"
 		    "qcom,msm8996-mss-pil"
 		    "qcom,sdm845-mss-pil"
+		    "qcom,ipq8074-wcss-pil"
 
 - reg:
 	Usage: required
@@ -50,11 +51,15 @@ on the Qualcomm Hexagon core.
 	Usage: required
 	Value type: <phandle>
 	Definition: reference to the reset-controller for the modem sub-system
+		    reference to the list of 3 reset-controllers for the
+		    wcss sub-system
 
 - reset-names:
 	Usage: required
 	Value type: <stringlist>
-	Definition: must be "mss_restart"
+	Definition: must be "mss_restart" for the modem sub-system
+	Definition: must be "wcss_aon_reset", "wcss_reset", "wcss_q6_reset"
+		    for the wcss syb-system
 
 - cx-supply:
 - mss-supply:
diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 0272740..4841420 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -113,6 +113,7 @@ config QCOM_Q6V5_PIL
 	select MFD_SYSCON
 	select QCOM_RPROC_COMMON
 	select QCOM_SCM
+	select QCOM_MDT_LOADER
 	help
 	  Say y here to support the Qualcomm Peripherial Image Loader for the
 	  Hexagon V5 based remote processors.
diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
index 2403bb2..fbe179d 100644
--- a/drivers/remoteproc/qcom_q6v5_pil.c
+++ b/drivers/remoteproc/qcom_q6v5_pil.c
@@ -138,6 +138,9 @@ struct q6v5 {
 	u32 halt_nc;
 
 	struct reset_control *mss_restart;
+	struct reset_control *wcss_aon_reset;
+	struct reset_control *wcss_reset;
+	struct reset_control *wcss_q6_reset;
 
 	struct qcom_smem_state *state;
 	unsigned stop_bit;
@@ -204,6 +207,7 @@ enum {
 	MSS_MSM8974,
 	MSS_MSM8996,
 	MSS_SDM845,
+	WCSS_IPQ8074,
 };
 
 static int q6v5_regulator_init(struct device *dev, struct reg_info *regs,
@@ -1173,6 +1177,26 @@ static int q6v5_init_clocks(struct device *dev, struct clk **clks,
 	return i;
 }
 
+static int q6v5_wcss_init_reset(struct q6v5 *qproc)
+{
+	qproc->wcss_aon_reset = devm_reset_control_get(qproc->dev,
+						       "wcss_aon_reset");
+	if (IS_ERR(qproc->wcss_aon_reset))
+		return PTR_ERR(qproc->wcss_aon_reset);
+
+	qproc->wcss_reset = devm_reset_control_get(qproc->dev,
+						   "wcss_reset");
+	if (IS_ERR(qproc->wcss_reset))
+		return PTR_ERR(qproc->wcss_reset);
+
+	qproc->wcss_q6_reset = devm_reset_control_get(qproc->dev,
+						      "wcss_q6_reset");
+	if (IS_ERR(qproc->wcss_q6_reset))
+		return PTR_ERR(qproc->wcss_q6_reset);
+
+	return 0;
+}
+
 static int q6v5_init_reset(struct q6v5 *qproc)
 {
 	qproc->mss_restart = devm_reset_control_get_exclusive(qproc->dev,
@@ -1237,6 +1261,9 @@ static int q6v5_alloc_memory_region(struct q6v5 *qproc)
 		return -EBUSY;
 	}
 
+	if (qproc->version == WCSS_IPQ8074)
+		return 0;
+
 	child = of_get_child_by_name(qproc->dev->of_node, "mpss");
 	node = of_parse_phandle(child, "memory-region", 0);
 	ret = of_address_to_resource(node, 0, &r);
@@ -1279,6 +1306,7 @@ static int q6v5_probe(struct platform_device *pdev)
 	qproc = (struct q6v5 *)rproc->priv;
 	qproc->dev = &pdev->dev;
 	qproc->rproc = rproc;
+	qproc->version = desc->version;
 	platform_set_drvdata(pdev, qproc);
 
 	if (desc->has_alt_reset) {
@@ -1344,7 +1372,6 @@ static int q6v5_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_rproc;
 
-	qproc->version = desc->version;
 	qproc->need_mem_protection = desc->need_mem_protection;
 	ret = q6v5_request_irq(qproc, pdev, "wdog", q6v5_wdog_interrupt,
 			       &qproc->wdog_interrupt);
@@ -1537,12 +1564,20 @@ static int q6v5_remove(struct platform_device *pdev)
 	.ops = &q6v5_ops,
 };
 
+static const struct rproc_hexagon_res ipq8074_wcss = {
+	.hexagon_mba_image = "IPQ8074/q6_fw.mdt",
+	.need_mem_protection = false,
+	.version = WCSS_IPQ8074,
+	.init_reset = q6v5_wcss_init_reset,
+};
+
 static const struct of_device_id q6v5_of_match[] = {
 	{ .compatible = "qcom,q6v5-pil", .data = &msm8916_mss},
 	{ .compatible = "qcom,msm8916-mss-pil", .data = &msm8916_mss},
 	{ .compatible = "qcom,msm8974-mss-pil", .data = &msm8974_mss},
 	{ .compatible = "qcom,msm8996-mss-pil", .data = &msm8996_mss},
 	{ .compatible = "qcom,sdm845-mss-pil", .data = &sdm845_mss},
+	{ .compatible = "qcom,ipq8074-wcss-pil", .data = &ipq8074_wcss},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, q6v5_of_match);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
