Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932875AbeCIX0C (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 18:26:02 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53796 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932757AbeCIXZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 18:25:56 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9F12860858
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org
Cc: linux-soc@vger.kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v4 05/10] drivers: qcom: rpmh-rsc: write sleep/wake requests to TCS
Date: Fri,  9 Mar 2018 16:25:38 -0700
Message-Id: <20180309232543.24636-6-ilina@codeaurora.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309232543.24636-1-ilina@codeaurora.org>
References: <20180309232543.24636-1-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sleep and wake requests are sent when the application processor
subsystem of the SoC is entering deep sleep states like in suspend.
These requests help lower the system power requirements when the
resources are not in use.

Sleep and wake requests are written to the TCS slots but are not
triggered at the time of writing. The TCS are triggered by the firmware
after the last of the CPUs has executed its WFI. Since these requests
may come in different batches of requests, it is the job of this
controller driver to find and arrange the requests into the available
TCSes.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/soc/qcom/rpmh-internal.h |   9 ++-
 drivers/soc/qcom/rpmh-rsc.c      | 120 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index 125f9faec536..638662721086 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -14,6 +14,7 @@
 #define MAX_CMDS_PER_TCS		16
 #define MAX_TCS_PER_TYPE		3
 #define MAX_TCS_NR			(MAX_TCS_PER_TYPE * TCS_TYPE_NR)
+#define MAX_TCS_SLOTS			(MAX_CMDS_PER_TCS * MAX_TCS_PER_TYPE)
 
 struct rsc_drv;
 
@@ -45,6 +46,8 @@ struct tcs_response {
  * @ncpt:      number of commands in each TCS
  * @lock:      lock for synchronizing this TCS writes
  * @responses: response objects for requests sent from each TCS
+ * @cmd_cache: flattened cache of cmds in sleep/wake TCS
+ * @slots:     indicates which of @cmd_addr are occupied
  */
 struct tcs_group {
 	struct rsc_drv *drv;
@@ -55,6 +58,8 @@ struct tcs_group {
 	int ncpt;
 	spinlock_t lock;
 	struct tcs_response *responses[MAX_TCS_PER_TYPE];
+	u32 *cmd_cache;
+	DECLARE_BITMAP(slots, MAX_TCS_SLOTS);
 };
 
 /**
@@ -69,7 +74,7 @@ struct tcs_group {
  *              list of responses that needs to be sent to caller
  * @tcs:        TCS groups
  * @tcs_in_use: s/w state of the TCS
- * @drv_lock:  synchronize state of the controller
+ * @drv_lock:   synchronize state of the controller
  */
 struct rsc_drv {
 	const char *name;
@@ -85,6 +90,8 @@ struct rsc_drv {
 
 
 int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg);
+int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv,
+			     const struct tcs_request *msg);
 
 void rpmh_tx_done(const struct tcs_request *msg, int r);
 
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index c5cde917dba6..58fc7254b6f3 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -171,6 +171,12 @@ static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
 	case RPMH_ACTIVE_ONLY_STATE:
 		type = ACTIVE_TCS;
 		break;
+	case RPMH_WAKE_ONLY_STATE:
+		type = WAKE_TCS;
+		break;
+	case RPMH_SLEEP_STATE:
+		type = SLEEP_TCS;
+		break;
 	default:
 		return ERR_PTR(-EINVAL);
 	}
@@ -439,6 +445,107 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
 }
 EXPORT_SYMBOL(rpmh_rsc_send_data);
 
+static int find_match(const struct tcs_group *tcs, const struct tcs_cmd *cmd,
+		      int len)
+{
+	int i, j;
+
+	/* Check for already cached commands */
+	for_each_set_bit(i, tcs->slots, MAX_TCS_SLOTS) {
+		for (j = 0; j < len; j++) {
+			if (tcs->cmd_cache[i] != cmd[0].addr) {
+				if (j == 0)
+					break;
+				WARN(tcs->cmd_cache[i + j] != cmd[j].addr,
+				     "Message does not match previous sequence.\n");
+				return -EINVAL;
+			} else if (j == len - 1) {
+				return i;
+			}
+		}
+	}
+
+	return -ENODATA;
+}
+
+static int find_slots(struct tcs_group *tcs, const struct tcs_request *msg,
+		      int *m, int *n)
+{
+	int slot, offset;
+	int i = 0;
+
+	/* Find if we already have the msg in our TCS */
+	slot = find_match(tcs, msg->cmds, msg->num_cmds);
+	if (slot >= 0)
+		goto copy_data;
+
+	/* Do over, until we can fit the full payload in a TCS */
+	do {
+		slot = bitmap_find_next_zero_area(tcs->slots, MAX_TCS_SLOTS,
+						  i, msg->num_cmds, 0);
+		if (slot == MAX_TCS_SLOTS)
+			return -ENOMEM;
+		i += tcs->ncpt;
+	} while (slot + msg->num_cmds - 1 >= i);
+
+copy_data:
+	bitmap_set(tcs->slots, slot, msg->num_cmds);
+	/* Copy the addresses of the resources over to the slots */
+	for (i = 0; i < msg->num_cmds; i++)
+		tcs->cmd_cache[slot + i] = msg->cmds[i].addr;
+
+	offset = slot / tcs->ncpt;
+	*m = offset + tcs->offset;
+	*n = slot % tcs->ncpt;
+
+	return 0;
+}
+
+static int tcs_ctrl_write(struct rsc_drv *drv, const struct tcs_request *msg)
+{
+	struct tcs_group *tcs;
+	int m = 0, n = 0;
+	unsigned long flags;
+	int ret;
+
+	tcs = get_tcs_for_msg(drv, msg);
+	if (IS_ERR(tcs))
+		return PTR_ERR(tcs);
+
+	spin_lock_irqsave(&tcs->lock, flags);
+	/* find the m-th TCS and the n-th position in the TCS to write to */
+	ret = find_slots(tcs, msg, &m, &n);
+	if (!ret)
+		__tcs_buffer_write(drv, m, n, msg);
+	spin_unlock_irqrestore(&tcs->lock, flags);
+
+	return ret;
+}
+
+/**
+ * rpmh_rsc_write_ctrl_data: Write request to the controller
+ *
+ * @drv: the controller
+ * @msg: the data to be written to the controller
+ *
+ * There is no response returned for writing the request to the controller.
+ */
+int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv, const struct tcs_request *msg)
+{
+	if (!msg || !msg->cmds || !msg->num_cmds ||
+	    msg->num_cmds > MAX_RPMH_PAYLOAD) {
+		pr_err("Payload error\n");
+		return -EINVAL;
+	}
+
+	/* Data sent to this API will not be sent immediately */
+	if (msg->state == RPMH_ACTIVE_ONLY_STATE)
+		return -EINVAL;
+
+	return tcs_ctrl_write(drv, msg);
+}
+EXPORT_SYMBOL(rpmh_rsc_write_ctrl_data);
+
 static int rpmh_probe_tcs_config(struct platform_device *pdev,
 				 struct rsc_drv *drv)
 {
@@ -512,6 +619,19 @@ static int rpmh_probe_tcs_config(struct platform_device *pdev,
 		tcs->mask = ((1 << tcs->num_tcs) - 1) << st;
 		tcs->offset = st;
 		st += tcs->num_tcs;
+
+		/*
+		 * Allocate memory to cache sleep and wake requests to
+		 * avoid reading TCS register memory.
+		 */
+		if (tcs->type == ACTIVE_TCS)
+			continue;
+
+		tcs->cmd_cache = devm_kcalloc(&pdev->dev,
+					      tcs->num_tcs * ncpt, sizeof(u32),
+					      GFP_KERNEL);
+		if (!tcs->cmd_cache)
+			return -ENOMEM;
 	}
 
 	drv->num_tcs = st;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
