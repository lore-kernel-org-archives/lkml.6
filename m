Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751399AbeFDUaw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 16:30:52 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46424 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751400AbeFDUat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 16:30:49 -0400
X-Google-Smtp-Source: ADUXVKKHqKzp3Ln//ypM1fmk32MLUJLly5pOf7DqxT49F8nH60AQPrgFHyqHs+WaKcIDn3AfTYKYkQ==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 4/4] remoteproc: qcom: q6v5-pil: Use common q6v5 helpers
Date: Mon,  4 Jun 2018 13:30:38 -0700
Message-Id: <20180604203038.14080-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180604203038.14080-1-bjorn.andersson@linaro.org>
References: <20180604203038.14080-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Migrate the MSS remoteproc driver to use the newly extracted helper
functions.

Reviewed-by: Sricharan R <sricharan@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since RFC:
- Remove duplicate Kconfig selects
- Picked up Sricharan's reviewed-by

 drivers/remoteproc/Kconfig         |   1 +
 drivers/remoteproc/qcom_q6v5_pil.c | 157 +++--------------------------
 2 files changed, 16 insertions(+), 142 deletions(-)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index d51d155cf8bd..a6a74bde906a 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -116,6 +116,7 @@ config QCOM_Q6V5_PIL
 	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
 	depends on QCOM_SYSMON || QCOM_SYSMON=n
 	select MFD_SYSCON
+	select QCOM_Q6V5_COMMON
 	select QCOM_RPROC_COMMON
 	select QCOM_SCM
 	help
diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
index 2bf8e7c49f2a..e04319573c91 100644
--- a/drivers/remoteproc/qcom_q6v5_pil.c
+++ b/drivers/remoteproc/qcom_q6v5_pil.c
@@ -30,12 +30,11 @@
 #include <linux/remoteproc.h>
 #include <linux/reset.h>
 #include <linux/soc/qcom/mdt_loader.h>
-#include <linux/soc/qcom/smem.h>
-#include <linux/soc/qcom/smem_state.h>
 #include <linux/iopoll.h>
 
 #include "remoteproc_internal.h"
 #include "qcom_common.h"
+#include "qcom_q6v5.h"
 
 #include <linux/qcom_scm.h>
 
@@ -151,12 +150,7 @@ struct q6v5 {
 
 	struct reset_control *mss_restart;
 
-	struct qcom_smem_state *state;
-	unsigned stop_bit;
-
-	int handover_irq;
-
-	bool proxy_unvoted;
+	struct qcom_q6v5 q6v5;
 
 	struct clk *active_clks[8];
 	struct clk *reset_clks[4];
@@ -170,8 +164,6 @@ struct q6v5 {
 	int active_reg_count;
 	int proxy_reg_count;
 
-	struct completion start_done;
-	struct completion stop_done;
 	bool running;
 
 	phys_addr_t mba_phys;
@@ -798,9 +790,7 @@ static int q6v5_start(struct rproc *rproc)
 	int xfermemop_ret;
 	int ret;
 
-	qproc->proxy_unvoted = false;
-
-	enable_irq(qproc->handover_irq);
+	qcom_q6v5_prepare(&qproc->q6v5);
 
 	ret = q6v5_regulator_enable(qproc, qproc->proxy_regs,
 				    qproc->proxy_reg_count);
@@ -875,11 +865,9 @@ static int q6v5_start(struct rproc *rproc)
 	if (ret)
 		goto reclaim_mpss;
 
-	ret = wait_for_completion_timeout(&qproc->start_done,
-					  msecs_to_jiffies(5000));
-	if (ret == 0) {
+	ret = qcom_q6v5_wait_for_start(&qproc->q6v5, msecs_to_jiffies(5000));
+	if (ret == -ETIMEDOUT) {
 		dev_err(qproc->dev, "start timed out\n");
-		ret = -ETIMEDOUT;
 		goto reclaim_mpss;
 	}
 
@@ -933,7 +921,7 @@ static int q6v5_start(struct rproc *rproc)
 			       qproc->proxy_reg_count);
 
 disable_irqs:
-	disable_irq(qproc->handover_irq);
+	qcom_q6v5_unprepare(&qproc->q6v5);
 
 	return ret;
 }
@@ -946,16 +934,10 @@ static int q6v5_stop(struct rproc *rproc)
 
 	qproc->running = false;
 
-	qcom_smem_state_update_bits(qproc->state,
-				    BIT(qproc->stop_bit), BIT(qproc->stop_bit));
-
-	ret = wait_for_completion_timeout(&qproc->stop_done,
-					  msecs_to_jiffies(5000));
-	if (ret == 0)
+	ret = qcom_q6v5_request_stop(&qproc->q6v5);
+	if (ret == -ETIMEDOUT)
 		dev_err(qproc->dev, "timed out on wait\n");
 
-	qcom_smem_state_update_bits(qproc->state, BIT(qproc->stop_bit), 0);
-
 	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_q6);
 	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_modem);
 	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_nc);
@@ -976,9 +958,8 @@ static int q6v5_stop(struct rproc *rproc)
 
 	q6v5_reset_assert(qproc);
 
-	disable_irq(qproc->handover_irq);
-
-	if (!qproc->proxy_unvoted) {
+	ret = qcom_q6v5_unprepare(&qproc->q6v5);
+	if (ret) {
 		q6v5_clk_disable(qproc->dev, qproc->proxy_clks,
 				 qproc->proxy_clk_count);
 		q6v5_regulator_disable(qproc, qproc->proxy_regs,
@@ -1014,74 +995,14 @@ static const struct rproc_ops q6v5_ops = {
 	.load = q6v5_load,
 };
 
-static irqreturn_t q6v5_wdog_interrupt(int irq, void *dev)
-{
-	struct q6v5 *qproc = dev;
-	size_t len;
-	char *msg;
-
-	/* Sometimes the stop triggers a watchdog rather than a stop-ack */
-	if (!qproc->running) {
-		complete(&qproc->stop_done);
-		return IRQ_HANDLED;
-	}
-
-	msg = qcom_smem_get(QCOM_SMEM_HOST_ANY, MPSS_CRASH_REASON_SMEM, &len);
-	if (!IS_ERR(msg) && len > 0 && msg[0])
-		dev_err(qproc->dev, "watchdog received: %s\n", msg);
-	else
-		dev_err(qproc->dev, "watchdog without message\n");
-
-	rproc_report_crash(qproc->rproc, RPROC_WATCHDOG);
-
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t q6v5_fatal_interrupt(int irq, void *dev)
-{
-	struct q6v5 *qproc = dev;
-	size_t len;
-	char *msg;
-
-	msg = qcom_smem_get(QCOM_SMEM_HOST_ANY, MPSS_CRASH_REASON_SMEM, &len);
-	if (!IS_ERR(msg) && len > 0 && msg[0])
-		dev_err(qproc->dev, "fatal error received: %s\n", msg);
-	else
-		dev_err(qproc->dev, "fatal error without message\n");
-
-	rproc_report_crash(qproc->rproc, RPROC_FATAL_ERROR);
-
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t q6v5_ready_interrupt(int irq, void *dev)
-{
-	struct q6v5 *qproc = dev;
-
-	complete(&qproc->start_done);
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t q6v5_handover_interrupt(int irq, void *dev)
+static void qcom_msa_handover(struct qcom_q6v5 *q6v5)
 {
-	struct q6v5 *qproc = dev;
+	struct q6v5 *qproc = container_of(q6v5, struct q6v5, q6v5);
 
 	q6v5_clk_disable(qproc->dev, qproc->proxy_clks,
 			 qproc->proxy_clk_count);
 	q6v5_regulator_disable(qproc, qproc->proxy_regs,
 			       qproc->proxy_reg_count);
-
-	qproc->proxy_unvoted = true;
-
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t q6v5_stop_ack_interrupt(int irq, void *dev)
-{
-	struct q6v5 *qproc = dev;
-
-	complete(&qproc->stop_done);
-	return IRQ_HANDLED;
 }
 
 static int q6v5_init_mem(struct q6v5 *qproc, struct platform_device *pdev)
@@ -1154,30 +1075,6 @@ static int q6v5_init_reset(struct q6v5 *qproc)
 	return 0;
 }
 
-static int q6v5_request_irq(struct q6v5 *qproc,
-			     struct platform_device *pdev,
-			     const char *name,
-			     irq_handler_t thread_fn)
-{
-	int irq;
-	int ret;
-
-	irq = platform_get_irq_byname(pdev, name);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no %s IRQ defined\n", name);
-		return irq;
-	}
-
-	ret = devm_request_threaded_irq(&pdev->dev, irq,
-					NULL, thread_fn,
-					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-					"q6v5", qproc);
-	if (ret)
-		dev_err(&pdev->dev, "request %s IRQ failed\n", name);
-
-	return ret ? : irq;
-}
-
 static int q6v5_alloc_memory_region(struct q6v5 *qproc)
 {
 	struct device_node *child;
@@ -1247,9 +1144,6 @@ static int q6v5_probe(struct platform_device *pdev)
 	qproc->rproc = rproc;
 	platform_set_drvdata(pdev, qproc);
 
-	init_completion(&qproc->start_done);
-	init_completion(&qproc->stop_done);
-
 	ret = q6v5_init_mem(qproc, pdev);
 	if (ret)
 		goto free_rproc;
@@ -1305,33 +1199,12 @@ static int q6v5_probe(struct platform_device *pdev)
 	qproc->version = desc->version;
 	qproc->has_alt_reset = desc->has_alt_reset;
 	qproc->need_mem_protection = desc->need_mem_protection;
-	ret = q6v5_request_irq(qproc, pdev, "wdog", q6v5_wdog_interrupt);
-	if (ret < 0)
-		goto free_rproc;
 
-	ret = q6v5_request_irq(qproc, pdev, "fatal", q6v5_fatal_interrupt);
-	if (ret < 0)
-		goto free_rproc;
-
-	ret = q6v5_request_irq(qproc, pdev, "ready", q6v5_ready_interrupt);
-	if (ret < 0)
-		goto free_rproc;
-
-	ret = q6v5_request_irq(qproc, pdev, "handover", q6v5_handover_interrupt);
-	if (ret < 0)
-		goto free_rproc;
-	qproc->handover_irq = ret;
-	disable_irq(qproc->handover_irq);
-
-	ret = q6v5_request_irq(qproc, pdev, "stop-ack", q6v5_stop_ack_interrupt);
-	if (ret < 0)
+	ret = qcom_q6v5_init(&qproc->q6v5, pdev, rproc, MPSS_CRASH_REASON_SMEM,
+			     qcom_msa_handover);
+	if (ret)
 		goto free_rproc;
 
-	qproc->state = qcom_smem_state_get(&pdev->dev, "stop", &qproc->stop_bit);
-	if (IS_ERR(qproc->state)) {
-		ret = PTR_ERR(qproc->state);
-		goto free_rproc;
-	}
 	qproc->mpss_perm = BIT(QCOM_SCM_VMID_HLOS);
 	qproc->mba_perm = BIT(QCOM_SCM_VMID_HLOS);
 	qcom_add_glink_subdev(rproc, &qproc->glink_subdev);
-- 
2.17.0
