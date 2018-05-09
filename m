Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965731AbeEIRCQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:02:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56928 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965686AbeEIRCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:02:12 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A667860C67
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, mka@chromium.org, rplsssn@codeaurora.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v8 05/10] drivers: qcom: rpmh-rsc: write sleep/wake requests to TCS
Date: Wed,  9 May 2018 11:01:54 -0600
Message-Id: <20180509170159.29682-6-ilina@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180509170159.29682-1-ilina@codeaurora.org>
References: <20180509170159.29682-1-ilina@codeaurora.org>
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
Reviewed-by: Evan Green <evgreen@chromium.org>

---
Changes in v8:
	- Bounds check in find_match()

Changes in v7:
	- Bug fix in find_match()
---
 drivers/soc/qcom/rpmh-internal.h |   8 ++
 drivers/soc/qcom/rpmh-rsc.c      | 122 +++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index d9a21726e568..6e19fe458c31 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -14,6 +14,7 @@
 #define MAX_CMDS_PER_TCS		16
 #define MAX_TCS_PER_TYPE		3
 #define MAX_TCS_NR			(MAX_TCS_PER_TYPE * TCS_TYPE_NR)
+#define MAX_TCS_SLOTS			(MAX_CMDS_PER_TCS * MAX_TCS_PER_TYPE)
 #define RPMH_MAX_CTRLR			2
 
 struct rsc_drv;
@@ -30,6 +31,8 @@ struct rsc_drv;
  * @ncpt:      number of commands in each TCS
  * @lock:      lock for synchronizing this TCS writes
  * @req:       requests that are sent from the TCS
+ * @cmd_cache: flattened cache of cmds in sleep/wake TCS
+ * @slots:     indicates which of @cmd_addr are occupied
  */
 struct tcs_group {
 	struct rsc_drv *drv;
@@ -40,6 +43,8 @@ struct tcs_group {
 	int ncpt;
 	spinlock_t lock;
 	const struct tcs_request *req[MAX_TCS_PER_TYPE];
+	u32 *cmd_cache;
+	DECLARE_BITMAP(slots, MAX_TCS_SLOTS);
 };
 
 /**
@@ -69,6 +74,9 @@ struct rsc_drv {
 extern struct list_head rsc_drv_list;
 
 int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg);
+int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv,
+			     const struct tcs_request *msg);
+int rpmh_rsc_invalidate(struct rsc_drv *drv);
 
 void rpmh_tx_done(const struct tcs_request *msg, int r);
 
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index c0edf3850147..b5894b001ae1 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -113,6 +113,12 @@ static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
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
@@ -353,6 +359,109 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
 }
 EXPORT_SYMBOL(rpmh_rsc_send_data);
 
+static int find_match(const struct tcs_group *tcs, const struct tcs_cmd *cmd,
+		      int len)
+{
+	int i, j;
+
+	/* Check for already cached commands */
+	for_each_set_bit(i, tcs->slots, MAX_TCS_SLOTS) {
+		if (tcs->cmd_cache[i] != cmd[0].addr)
+			continue;
+		if (i + len >= MAX_TCS_SLOTS)
+			goto seq_err;
+		for (j = 0; j < len; j++) {
+			if (tcs->cmd_cache[i + j] != cmd[j].addr)
+				goto seq_err;
+		}
+		return i;
+	}
+
+	return -ENODATA;
+
+seq_err:
+	WARN(1, "Message does not match previous sequence.\n");
+	return -EINVAL;
+}
+
+static int find_slots(struct tcs_group *tcs, const struct tcs_request *msg,
+		      int *tcs_id, int *cmd_id)
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
+	*tcs_id = offset + tcs->offset;
+	*cmd_id = slot % tcs->ncpt;
+
+	return 0;
+}
+
+static int tcs_ctrl_write(struct rsc_drv *drv, const struct tcs_request *msg)
+{
+	struct tcs_group *tcs;
+	int tcs_id = 0, cmd_id = 0;
+	unsigned long flags;
+	int ret;
+
+	tcs = get_tcs_for_msg(drv, msg);
+	if (IS_ERR(tcs))
+		return PTR_ERR(tcs);
+
+	spin_lock_irqsave(&tcs->lock, flags);
+	/* find the m-th TCS and the n-th position in the TCS to write to */
+	ret = find_slots(tcs, msg, &tcs_id, &cmd_id);
+	if (!ret)
+		__tcs_buffer_write(drv, tcs_id, cmd_id, msg);
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
@@ -428,6 +537,19 @@ static int rpmh_probe_tcs_config(struct platform_device *pdev,
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
