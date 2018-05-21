Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753507AbeEUR3b (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 13:29:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56598 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753408AbeEUR16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 13:27:58 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E767960A06
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
Subject: [PATCH v5 4/8] remoteproc: Synchronize proxy unvote from multiple contexts
Date: Mon, 21 May 2018 22:57:10 +0530
Message-Id: <20180521172714.8551-5-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521172714.8551-1-sibis@codeaurora.org>
References: <20180521172714.8551-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Synchronize proxy unvote of clks/regs from q6v5_stop and
handover interrupt to prevent multiple proxy unvotes
for a single rproc start.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_pil.c | 73 ++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 19 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
index 6333bdcd9448..a5fa6521bb83 100644
--- a/drivers/remoteproc/qcom_q6v5_pil.c
+++ b/drivers/remoteproc/qcom_q6v5_pil.c
@@ -143,6 +143,10 @@ struct q6v5 {
 	struct qcom_smem_state *state;
 	unsigned stop_bit;
 
+	int handover_irq;
+	int wdog_irq;
+	int fatal_irq;
+
 	struct clk *active_clks[8];
 	struct clk *proxy_clks[4];
 	int active_clk_count;
@@ -170,6 +174,7 @@ struct q6v5 {
 	struct qcom_rproc_ssr ssr_subdev;
 	struct qcom_sysmon *sysmon;
 	bool need_mem_protection;
+	bool unvoted_flag;
 	int mpss_perm;
 	int mba_perm;
 	int version;
@@ -304,6 +309,20 @@ static void q6v5_clk_disable(struct device *dev,
 		clk_disable_unprepare(clks[i]);
 }
 
+static void q6v5_enable_irqs(struct q6v5 *qproc)
+{
+	enable_irq(qproc->wdog_irq);
+	enable_irq(qproc->fatal_irq);
+	enable_irq(qproc->handover_irq);
+}
+
+static void q6v5_disable_irqs(struct q6v5 *qproc)
+{
+	disable_irq(qproc->handover_irq);
+	disable_irq(qproc->fatal_irq);
+	disable_irq(qproc->wdog_irq);
+}
+
 static int q6v5_xfer_mem_ownership(struct q6v5 *qproc, int *current_perm,
 				   bool remote_owner, phys_addr_t addr,
 				   size_t size)
@@ -727,6 +746,7 @@ static int q6v5_start(struct rproc *rproc)
 	int xfermemop_ret;
 	int ret;
 
+	qproc->unvoted_flag = false;
 	ret = q6v5_regulator_enable(qproc, qproc->proxy_regs,
 				    qproc->proxy_reg_count);
 	if (ret) {
@@ -793,9 +813,12 @@ static int q6v5_start(struct rproc *rproc)
 	if (ret)
 		goto reclaim_mpss;
 
+	q6v5_enable_irqs(qproc);
+
 	ret = wait_for_completion_timeout(&qproc->start_done,
 					  msecs_to_jiffies(5000));
 	if (ret == 0) {
+		q6v5_disable_irqs(qproc);
 		dev_err(qproc->dev, "start timed out\n");
 		ret = -ETIMEDOUT;
 		goto reclaim_mpss;
@@ -887,11 +910,14 @@ static int q6v5_stop(struct rproc *rproc)
 	WARN_ON(ret);
 
 	reset_control_assert(qproc->mss_restart);
+	q6v5_disable_irqs(qproc);
 
-	q6v5_clk_disable(qproc->dev, qproc->proxy_clks,
-			 qproc->proxy_clk_count);
-	q6v5_regulator_disable(qproc, qproc->proxy_regs,
-			       qproc->proxy_reg_count);
+	if (!qproc->unvoted_flag) {
+		q6v5_clk_disable(qproc->dev, qproc->proxy_clks,
+				 qproc->proxy_clk_count);
+		q6v5_regulator_disable(qproc, qproc->proxy_regs,
+				       qproc->proxy_reg_count);
+	}
 
 	q6v5_clk_disable(qproc->dev, qproc->active_clks,
 			 qproc->active_clk_count);
@@ -972,10 +998,13 @@ static irqreturn_t q6v5_handover_interrupt(int irq, void *dev)
 {
 	struct q6v5 *qproc = dev;
 
-	q6v5_clk_disable(qproc->dev, qproc->proxy_clks,
-			 qproc->proxy_clk_count);
-	q6v5_regulator_disable(qproc, qproc->proxy_regs,
-			       qproc->proxy_reg_count);
+	if (!qproc->unvoted_flag) {
+		qproc->unvoted_flag = true;
+		q6v5_clk_disable(qproc->dev, qproc->proxy_clks,
+				 qproc->proxy_clk_count);
+		q6v5_regulator_disable(qproc, qproc->proxy_regs,
+				       qproc->proxy_reg_count);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -1058,18 +1087,18 @@ static int q6v5_init_reset(struct q6v5 *qproc)
 	return 0;
 }
 
-static int q6v5_request_irq(struct q6v5 *qproc,
+static inline int q6v5_request_irq(struct q6v5 *qproc,
 			     struct platform_device *pdev,
 			     const char *name,
-			     irq_handler_t thread_fn)
+			     irq_handler_t thread_fn,
+			     unsigned int *irq_num)
 {
 	int ret;
 
 	ret = platform_get_irq_byname(pdev, name);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "no %s IRQ defined\n", name);
-		return ret;
-	}
+
+	if (irq_num)
+		*irq_num = ret;
 
 	ret = devm_request_threaded_irq(&pdev->dev, ret,
 					NULL, thread_fn,
@@ -1199,26 +1228,32 @@ static int q6v5_probe(struct platform_device *pdev)
 
 	qproc->version = desc->version;
 	qproc->need_mem_protection = desc->need_mem_protection;
-	ret = q6v5_request_irq(qproc, pdev, "wdog", q6v5_wdog_interrupt);
+	ret = q6v5_request_irq(qproc, pdev, "wdog", q6v5_wdog_interrupt,
+			       &qproc->wdog_irq);
 	if (ret < 0)
 		goto free_rproc;
 
-	ret = q6v5_request_irq(qproc, pdev, "fatal", q6v5_fatal_interrupt);
+	ret = q6v5_request_irq(qproc, pdev, "fatal", q6v5_fatal_interrupt,
+			       &qproc->fatal_irq);
 	if (ret < 0)
 		goto free_rproc;
 
-	ret = q6v5_request_irq(qproc, pdev, "ready", q6v5_ready_interrupt);
+	ret = q6v5_request_irq(qproc, pdev, "ready", q6v5_ready_interrupt,
+			       NULL);
 	if (ret < 0)
 		goto free_rproc;
 
-	ret = q6v5_request_irq(qproc, pdev, "handover", q6v5_handover_interrupt);
+	ret = q6v5_request_irq(qproc, pdev, "handover", q6v5_handover_interrupt,
+			       &qproc->handover_irq);
 	if (ret < 0)
 		goto free_rproc;
 
-	ret = q6v5_request_irq(qproc, pdev, "stop-ack", q6v5_stop_ack_interrupt);
+	ret = q6v5_request_irq(qproc, pdev, "stop-ack", q6v5_stop_ack_interrupt,
+			       NULL);
 	if (ret < 0)
 		goto free_rproc;
 
+	q6v5_disable_irqs(qproc);
 	qproc->state = qcom_smem_state_get(&pdev->dev, "stop", &qproc->stop_bit);
 	if (IS_ERR(qproc->state)) {
 		ret = PTR_ERR(qproc->state);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
