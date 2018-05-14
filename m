Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752379AbeENKra (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 06:47:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50706 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752336AbeENKr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 06:47:27 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 23FCC60790
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From: Sricharan R <sricharan@codeaurora.org>
To: bjorn.andersson@linaro.org, ohad@wizery.com, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org, david.brown@linaro.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, sibis@codeaurora.org
Cc: sricharan@codeaurora.org
Subject: [PATCH V6 2/5] remoteproc: qcom: Push reset ops, rproc ops in to of_match data
Date: Mon, 14 May 2018 16:16:49 +0530
Message-Id: <1526294812-23390-3-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526294812-23390-1-git-send-email-sricharan@codeaurora.org>
References: <1526294812-23390-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of directly assigning reset and rproc ops, put them
in to of_match data and get from that. Currently same ops
are used for all compatibles, but that will change when we add
q6v5-wcss support.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_pil.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
index a3d65a7..cc26cab 100644
--- a/drivers/remoteproc/qcom_q6v5_pil.c
+++ b/drivers/remoteproc/qcom_q6v5_pil.c
@@ -125,18 +125,6 @@ struct qcom_mss_reg_res {
 	int uA;
 };
 
-struct rproc_hexagon_res {
-	const char *hexagon_mba_image;
-	struct qcom_mss_reg_res *proxy_supply;
-	struct qcom_mss_reg_res *active_supply;
-	char **proxy_clk_names;
-	char **reset_clk_names;
-	char **active_clk_names;
-	int version;
-	bool need_mem_protection;
-	bool has_alt_reset;
-};
-
 struct q6v5 {
 	struct device *dev;
 	struct rproc *rproc;
@@ -197,6 +185,20 @@ struct q6v5 {
 	int version;
 };
 
+struct rproc_hexagon_res {
+	const char *hexagon_mba_image;
+	struct qcom_mss_reg_res *proxy_supply;
+	struct qcom_mss_reg_res *active_supply;
+	char **proxy_clk_names;
+	char **reset_clk_names;
+	char **active_clk_names;
+	int version;
+	bool need_mem_protection;
+	bool has_alt_reset;
+	int (*init_reset)(struct q6v5 *qproc);
+	const struct rproc_ops *ops;
+};
+
 enum {
 	MSS_MSM8916,
 	MSS_MSM8974,
@@ -1250,7 +1252,7 @@ static int q6v5_probe(struct platform_device *pdev)
 	if (!desc)
 		return -EINVAL;
 
-	rproc = rproc_alloc(&pdev->dev, pdev->name, &q6v5_ops,
+	rproc = rproc_alloc(&pdev->dev, pdev->name, desc->ops,
 			    desc->hexagon_mba_image, sizeof(*qproc));
 	if (!rproc) {
 		dev_err(&pdev->dev, "failed to allocate rproc\n");
@@ -1321,7 +1323,7 @@ static int q6v5_probe(struct platform_device *pdev)
 	}
 	qproc->active_reg_count = ret;
 
-	ret = q6v5_init_reset(qproc);
+	ret = desc->init_reset(qproc);
 	if (ret)
 		goto free_rproc;
 
@@ -1417,6 +1419,8 @@ static int q6v5_remove(struct platform_device *pdev)
 	.need_mem_protection = true,
 	.has_alt_reset = true,
 	.version = MSS_SDM845,
+	.init_reset = q6v5_init_reset,
+	.ops = &q6v5_ops,
 };
 
 static const struct rproc_hexagon_res msm8996_mss = {
@@ -1436,6 +1440,8 @@ static int q6v5_remove(struct platform_device *pdev)
 	.need_mem_protection = true,
 	.has_alt_reset = false,
 	.version = MSS_MSM8996,
+	.init_reset = q6v5_init_reset,
+	.ops = &q6v5_ops,
 };
 
 static const struct rproc_hexagon_res msm8916_mss = {
@@ -1468,6 +1474,8 @@ static int q6v5_remove(struct platform_device *pdev)
 	.need_mem_protection = false,
 	.has_alt_reset = false,
 	.version = MSS_MSM8916,
+	.init_reset = q6v5_init_reset,
+	.ops = &q6v5_ops,
 };
 
 static const struct rproc_hexagon_res msm8974_mss = {
@@ -1508,6 +1516,8 @@ static int q6v5_remove(struct platform_device *pdev)
 	.need_mem_protection = false,
 	.has_alt_reset = false,
 	.version = MSS_MSM8974,
+	.init_reset = q6v5_init_reset,
+	.ops = &q6v5_ops,
 };
 
 static const struct of_device_id q6v5_of_match[] = {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
