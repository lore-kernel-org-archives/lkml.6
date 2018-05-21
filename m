Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751246AbeEUSqQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 14:46:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38780 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbeEUSqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 14:46:11 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 95B0F60314
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From: Sibi Sankar <sibis@codeaurora.org>
To: bjorn.andersson@linaro.org, ohad@wizery.com
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2] remoteproc: Introduce prepare/unprepare ops for rproc coredump
Date: Tue, 22 May 2018 00:15:59 +0530
Message-Id: <20180521184559.20864-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some occasions the remoteproc device might need to
prepare some hardware before the coredump can be performed
and cleanup the state afterwards.

Q6V5 modem requires the mba to be loaded before the
coredump and some cleanup of the resources afterwards.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---

This patch depends on the following patches:
https://patchwork.kernel.org/patch/10416047/
https://patchwork.kernel.org/patch/10416031/

 drivers/remoteproc/qcom_q6v5_pil.c       | 62 ++++++++++++++++++++----
 drivers/remoteproc/remoteproc_core.c     |  5 ++
 drivers/remoteproc/remoteproc_internal.h | 16 ++++++
 include/linux/remoteproc.h               |  4 ++
 4 files changed, 77 insertions(+), 10 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
index 7656731a6c51..4a33e50b6aeb 100644
--- a/drivers/remoteproc/qcom_q6v5_pil.c
+++ b/drivers/remoteproc/qcom_q6v5_pil.c
@@ -173,6 +173,7 @@ struct q6v5 {
 	struct completion start_done;
 	struct completion stop_done;
 	bool running;
+	bool coredump_pending;
 
 	phys_addr_t mba_phys;
 	void *mba_region;
@@ -742,6 +743,7 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 	}
 
 	mpss_reloc = relocate ? min_addr : qproc->mpss_phys;
+	qproc->mpss_reloc = mpss_reloc;
 	/* Load firmware segments */
 	for (i = 0; i < ehdr->e_phnum; i++) {
 		phdr = &phdrs[i];
@@ -816,7 +818,7 @@ static int q6v5_start(struct rproc *rproc)
 				    qproc->proxy_reg_count);
 	if (ret) {
 		dev_err(qproc->dev, "failed to enable proxy supplies\n");
-		return ret;
+		goto clear_coredump_pending;
 	}
 
 	ret = q6v5_clk_enable(qproc->dev, qproc->proxy_clks,
@@ -880,6 +882,19 @@ static int q6v5_start(struct rproc *rproc)
 		goto halt_axi_ports;
 	}
 
+	if (qproc->coredump_pending) {
+		dev_info(qproc->dev, "MBA booted, skipping mpss for coredump\n");
+		qproc->coredump_pending = false;
+		q6v5_enable_irqs(qproc);
+		xfermemop_ret = q6v5_xfer_mem_ownership(qproc,
+							&qproc->mba_perm, false,
+							qproc->mba_phys,
+							qproc->mba_size);
+		if (xfermemop_ret)
+			dev_err(qproc->dev, "Failed to reclaim mba buffer\n");
+		return 0;
+	}
+
 	dev_info(qproc->dev, "MBA booted, loading mpss\n");
 
 	ret = q6v5_mpss_load(qproc);
@@ -945,6 +960,8 @@ static int q6v5_start(struct rproc *rproc)
 disable_proxy_reg:
 	q6v5_regulator_disable(qproc, qproc->proxy_regs,
 			       qproc->proxy_reg_count);
+clear_coredump_pending:
+	qproc->coredump_pending = false;
 
 	return ret;
 }
@@ -955,17 +972,19 @@ static int q6v5_stop(struct rproc *rproc)
 	int ret;
 	u32 val;
 
-	qproc->running = false;
-
-	qcom_smem_state_update_bits(qproc->state,
-				    BIT(qproc->stop_bit), BIT(qproc->stop_bit));
+	if (qproc->running) {
+		qproc->running = false;
+		qcom_smem_state_update_bits(qproc->state,
+				BIT(qproc->stop_bit), BIT(qproc->stop_bit));
 
-	ret = wait_for_completion_timeout(&qproc->stop_done,
-					  msecs_to_jiffies(5000));
-	if (ret == 0)
-		dev_err(qproc->dev, "timed out on wait\n");
+		ret = wait_for_completion_timeout(&qproc->stop_done,
+				msecs_to_jiffies(5000));
+		if (ret == 0)
+			dev_err(qproc->dev, "timed out on wait\n");
 
-	qcom_smem_state_update_bits(qproc->state, BIT(qproc->stop_bit), 0);
+		qcom_smem_state_update_bits(qproc->state,
+				BIT(qproc->stop_bit), 0);
+	}
 
 	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_q6);
 	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_modem);
@@ -1017,10 +1036,31 @@ static void *q6v5_da_to_va(struct rproc *rproc, u64 da, int len)
 	return qproc->mpss_region + offset;
 }
 
+static int qcom_mpss_register_dump_segments(struct rproc *rproc,
+				const struct firmware *fw_unused)
+{
+	const struct firmware *fw;
+	struct q6v5 *qproc = (struct q6v5 *)rproc->priv;
+	int ret;
+
+	ret = request_firmware(&fw, "modem.mdt", qproc->dev);
+	if (ret < 0) {
+		dev_err(qproc->dev, "unable to load modem.mdt\n");
+		return ret;
+	}
+	ret = qcom_register_dump_segments(rproc, fw);
+
+	release_firmware(fw);
+	return ret;
+}
+
 static const struct rproc_ops q6v5_ops = {
 	.start = q6v5_start,
 	.stop = q6v5_stop,
 	.da_to_va = q6v5_da_to_va,
+	.parse_fw = qcom_mpss_register_dump_segments,
+	.prepare_coredump = q6v5_start,
+	.unprepare_coredump = q6v5_stop,
 	.load = q6v5_load,
 };
 
@@ -1036,6 +1076,7 @@ static irqreturn_t q6v5_wdog_interrupt(int irq, void *dev)
 		return IRQ_HANDLED;
 	}
 
+	qproc->coredump_pending = true;
 	msg = qcom_smem_get(QCOM_SMEM_HOST_ANY, MPSS_CRASH_REASON_SMEM, &len);
 	if (!IS_ERR(msg) && len > 0 && msg[0])
 		dev_err(qproc->dev, "watchdog received: %s\n", msg);
@@ -1053,6 +1094,7 @@ static irqreturn_t q6v5_fatal_interrupt(int irq, void *dev)
 	size_t len;
 	char *msg;
 
+	qproc->coredump_pending = true;
 	msg = qcom_smem_get(QCOM_SMEM_HOST_ANY, MPSS_CRASH_REASON_SMEM, &len);
 	if (!IS_ERR(msg) && len > 0 && msg[0])
 		dev_err(qproc->dev, "fatal error received: %s\n", msg);
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index a9609d971f7f..8c254d9b5c67 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1083,6 +1083,9 @@ static void rproc_coredump(struct rproc *rproc)
 	if (list_empty(&rproc->dump_segments))
 		return;
 
+	if (rproc_prepare_coredump(rproc))
+		return;
+
 	data_size = sizeof(*ehdr);
 	list_for_each_entry(segment, &rproc->dump_segments, node) {
 		data_size += sizeof(*phdr) + segment->size;
@@ -1139,6 +1142,8 @@ static void rproc_coredump(struct rproc *rproc)
 	}
 
 	dev_coredumpv(&rproc->dev, data, data_size, GFP_KERNEL);
+
+	rproc_unprepare_coredump(rproc);
 }
 
 /**
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index 7570beb035b5..22a1b276e110 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -96,6 +96,22 @@ static inline int rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
 	return 0;
 }
 
+static inline int rproc_prepare_coredump(struct rproc *rproc)
+{
+	if (rproc->ops->prepare_coredump)
+		return rproc->ops->prepare_coredump(rproc);
+
+	return 0;
+}
+
+static inline int rproc_unprepare_coredump(struct rproc *rproc)
+{
+	if (rproc->ops->unprepare_coredump)
+		return rproc->ops->unprepare_coredump(rproc);
+
+	return 0;
+}
+
 static inline
 struct resource_table *rproc_find_loaded_rsc_table(struct rproc *rproc,
 						   const struct firmware *fw)
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index dfdaede9139e..010819e01279 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -333,6 +333,8 @@ struct firmware;
  * @kick:	kick a virtqueue (virtqueue id given as a parameter)
  * @da_to_va:	optional platform hook to perform address translations
  * @load_rsc_table:	load resource table from firmware image
+ * @prepare_coredump:	prepare function, called before coredump
+ * @unprepare_coredump:	unprepare function, called post coredump
  * @find_loaded_rsc_table: find the loaded resouce table
  * @load:		load firmeware to memory, where the remote processor
  *			expects to find it
@@ -345,6 +347,8 @@ struct rproc_ops {
 	void (*kick)(struct rproc *rproc, int vqid);
 	void * (*da_to_va)(struct rproc *rproc, u64 da, int len);
 	int (*parse_fw)(struct rproc *rproc, const struct firmware *fw);
+	int (*prepare_coredump)(struct rproc *rproc);
+	int (*unprepare_coredump)(struct rproc *rproc);
 	struct resource_table *(*find_loaded_rsc_table)(
 				struct rproc *rproc, const struct firmware *fw);
 	int (*load)(struct rproc *rproc, const struct firmware *fw);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
