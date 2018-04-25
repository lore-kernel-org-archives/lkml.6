Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754792AbeDYOuj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 10:50:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42360 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754300AbeDYOuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 10:50:37 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C900C60C64
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From: Sibi Sankar <sibis@codeaurora.org>
To: ohad@wizery.com, bjorn.andersson@linaro.org
Cc: clew@codeaurora.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH] remoteproc: Proxy unvote clk/regs in handover context
Date: Wed, 25 Apr 2018 20:20:25 +0530
Message-Id: <20180425145025.21654-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce interrupt handler for smp2p ready interrupt and
handle start completion. Remove the proxy votes for clocks
and regulators in the handover interrupt context. Disable
wdog and fatal interrupts on remoteproc device stop and
re-enable them on remoteproc device start.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_pil.c | 71 +++++++++++++++++++++++++-----
 1 file changed, 60 insertions(+), 11 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
index 296eb3f8b551..7e2d04d4f2f0 100644
--- a/drivers/remoteproc/qcom_q6v5_pil.c
+++ b/drivers/remoteproc/qcom_q6v5_pil.c
@@ -143,6 +143,10 @@ struct q6v5 {
 	struct qcom_smem_state *state;
 	unsigned stop_bit;
 
+	unsigned int handover_interrupt;
+	unsigned int wdog_interrupt;
+	unsigned int fatal_interrupt;
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
@@ -727,6 +732,7 @@ static int q6v5_start(struct rproc *rproc)
 	int xfermemop_ret;
 	int ret;
 
+	qproc->unvoted_flag = false;
 	ret = q6v5_regulator_enable(qproc, qproc->proxy_regs,
 				    qproc->proxy_reg_count);
 	if (ret) {
@@ -793,9 +799,16 @@ static int q6v5_start(struct rproc *rproc)
 	if (ret)
 		goto reclaim_mpss;
 
+	enable_irq(qproc->handover_interrupt);
+	enable_irq(qproc->wdog_interrupt);
+	enable_irq(qproc->fatal_interrupt);
+
 	ret = wait_for_completion_timeout(&qproc->start_done,
 					  msecs_to_jiffies(5000));
 	if (ret == 0) {
+		disable_irq(qproc->handover_interrupt);
+		disable_irq(qproc->wdog_interrupt);
+		disable_irq(qproc->fatal_interrupt);
 		dev_err(qproc->dev, "start timed out\n");
 		ret = -ETIMEDOUT;
 		goto reclaim_mpss;
@@ -809,11 +822,6 @@ static int q6v5_start(struct rproc *rproc)
 			"Failed to reclaim mba buffer system may become unstable\n");
 	qproc->running = true;
 
-	q6v5_clk_disable(qproc->dev, qproc->proxy_clks,
-			 qproc->proxy_clk_count);
-	q6v5_regulator_disable(qproc, qproc->proxy_regs,
-			       qproc->proxy_reg_count);
-
 	return 0;
 
 reclaim_mpss:
@@ -892,6 +900,16 @@ static int q6v5_stop(struct rproc *rproc)
 	WARN_ON(ret);
 
 	reset_control_assert(qproc->mss_restart);
+	disable_irq(qproc->handover_interrupt);
+	if (!qproc->unvoted_flag) {
+		q6v5_clk_disable(qproc->dev, qproc->proxy_clks,
+				 qproc->proxy_clk_count);
+		q6v5_regulator_disable(qproc, qproc->proxy_regs,
+				       qproc->proxy_reg_count);
+	}
+	disable_irq(qproc->wdog_interrupt);
+	disable_irq(qproc->fatal_interrupt);
+
 	q6v5_clk_disable(qproc->dev, qproc->active_clks,
 			 qproc->active_clk_count);
 	q6v5_regulator_disable(qproc, qproc->active_regs,
@@ -959,7 +977,7 @@ static irqreturn_t q6v5_fatal_interrupt(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t q6v5_handover_interrupt(int irq, void *dev)
+static irqreturn_t q6v5_ready_interrupt(int irq, void *dev)
 {
 	struct q6v5 *qproc = dev;
 
@@ -967,6 +985,21 @@ static irqreturn_t q6v5_handover_interrupt(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t q6v5_handover_interrupt(int irq, void *dev)
+{
+	struct q6v5 *qproc = dev;
+
+	if (!qproc->unvoted_flag) {
+		qproc->unvoted_flag = true;
+		q6v5_clk_disable(qproc->dev, qproc->proxy_clks,
+				 qproc->proxy_clk_count);
+		q6v5_regulator_disable(qproc, qproc->proxy_regs,
+				       qproc->proxy_reg_count);
+	}
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t q6v5_stop_ack_interrupt(int irq, void *dev)
 {
 	struct q6v5 *qproc = dev;
@@ -1048,7 +1081,8 @@ static int q6v5_init_reset(struct q6v5 *qproc)
 static int q6v5_request_irq(struct q6v5 *qproc,
 			     struct platform_device *pdev,
 			     const char *name,
-			     irq_handler_t thread_fn)
+			     irq_handler_t thread_fn,
+			     unsigned int *irq_num)
 {
 	int ret;
 
@@ -1058,6 +1092,9 @@ static int q6v5_request_irq(struct q6v5 *qproc,
 		return ret;
 	}
 
+	if (irq_num)
+		*irq_num = ret;
+
 	ret = devm_request_threaded_irq(&pdev->dev, ret,
 					NULL, thread_fn,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
@@ -1184,19 +1221,31 @@ static int q6v5_probe(struct platform_device *pdev)
 
 	qproc->version = desc->version;
 	qproc->need_mem_protection = desc->need_mem_protection;
-	ret = q6v5_request_irq(qproc, pdev, "wdog", q6v5_wdog_interrupt);
+	ret = q6v5_request_irq(qproc, pdev, "wdog", q6v5_wdog_interrupt,
+			       &qproc->wdog_interrupt);
+	if (ret < 0)
+		goto free_rproc;
+	disable_irq(qproc->wdog_interrupt);
+
+	ret = q6v5_request_irq(qproc, pdev, "fatal", q6v5_fatal_interrupt,
+			       &qproc->fatal_interrupt);
 	if (ret < 0)
 		goto free_rproc;
+	disable_irq(qproc->fatal_interrupt);
 
-	ret = q6v5_request_irq(qproc, pdev, "fatal", q6v5_fatal_interrupt);
+	ret = q6v5_request_irq(qproc, pdev, "ready", q6v5_ready_interrupt,
+			       NULL);
 	if (ret < 0)
 		goto free_rproc;
 
-	ret = q6v5_request_irq(qproc, pdev, "handover", q6v5_handover_interrupt);
+	ret = q6v5_request_irq(qproc, pdev, "handover", q6v5_handover_interrupt,
+			       &qproc->handover_interrupt);
 	if (ret < 0)
 		goto free_rproc;
+	disable_irq(qproc->handover_interrupt);
 
-	ret = q6v5_request_irq(qproc, pdev, "stop-ack", q6v5_stop_ack_interrupt);
+	ret = q6v5_request_irq(qproc, pdev, "stop-ack", q6v5_stop_ack_interrupt,
+			       NULL);
 	if (ret < 0)
 		goto free_rproc;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
