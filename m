Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968000AbeCBQno (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:43:44 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41030 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967980AbeCBQni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:43:38 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89A036081C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v3 05/10] drivers: qcom: rpmh-rsc: write sleep/wake requests to TCS
Date: Fri,  2 Mar 2018 09:43:12 -0700
Message-Id: <20180302164317.10554-6-ilina@codeaurora.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302164317.10554-1-ilina@codeaurora.org>
References: <20180302164317.10554-1-ilina@codeaurora.org>
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
may come in different batches of requests, it is job of this controller
driver to find arrange the requests into the available TCSes.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/soc/qcom/rpmh-internal.h |   7 +++
 drivers/soc/qcom/rpmh-rsc.c      | 128 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 135 insertions(+)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index 1442a64ac4c5..65dfe1716265 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -13,6 +13,7 @@
 #define MAX_CMDS_PER_TCS		16
 #define MAX_TCS_PER_TYPE		3
 #define MAX_TCS_NR			(MAX_TCS_PER_TYPE * TCS_TYPE_NR)
+#define MAX_TCS_SLOTS			(MAX_CMDS_PER_TCS * MAX_TCS_PER_TYPE)
 
 struct rsc_drv;
 
@@ -44,6 +45,8 @@ struct tcs_response {
  * @ncpt: number of commands in each TCS
  * @tcs_lock: lock for synchronizing this TCS writes
  * @responses: response objects for requests sent from each TCS
+ * @cmd_addr: flattened cache of cmds in sleep/wake TCS
+ * @slots: indicates which of @cmd_addr are occupied
  */
 struct tcs_group {
 	struct rsc_drv *drv;
@@ -54,6 +57,9 @@ struct tcs_group {
 	int ncpt;
 	spinlock_t tcs_lock;
 	struct tcs_response *responses[MAX_TCS_PER_TYPE];
+	u32 *cmd_addr;
+	DECLARE_BITMAP(slots, MAX_TCS_SLOTS);
+
 };
 
 /**
@@ -83,6 +89,7 @@ struct rsc_drv {
 
 
 int rpmh_rsc_send_data(struct rsc_drv *drv, struct tcs_request *msg);
+int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv, struct tcs_request *msg);
 
 void rpmh_tx_done(struct tcs_request *msg, int r);
 
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index b5b39b86f904..34e780d9670f 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -6,6 +6,7 @@
 #define pr_fmt(fmt) "%s " fmt, KBUILD_MODNAME
 
 #include <linux/atomic.h>
+#include <linux/bitmap.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -178,6 +179,12 @@ static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
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
@@ -450,6 +457,114 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, struct tcs_request *msg)
 }
 EXPORT_SYMBOL(rpmh_rsc_send_data);
 
+static int find_match(struct tcs_group *tcs, struct tcs_cmd *cmd, int len)
+{
+	bool found = false;
+	int i = 0, j;
+
+	/* Check for already cached commands */
+	while ((i = find_next_bit(tcs->slots, MAX_TCS_SLOTS, i)) <
+	      MAX_TCS_SLOTS) {
+		if (tcs->cmd_addr[i] != cmd[0].addr) {
+			i++;
+			continue;
+		}
+		/* sanity check to ensure the seq is same */
+		for (j = 1; j < len; j++) {
+			WARN((tcs->cmd_addr[i + j] != cmd[j].addr),
+			    "Message does not match previous sequence.\n");
+			return -EINVAL;
+		}
+		found = true;
+		break;
+	}
+
+	return found ? i : -1;
+}
+
+static int find_slots(struct tcs_group *tcs, struct tcs_request *msg,
+		     int *m, int *n)
+{
+	int slot, offset;
+	int i = 0;
+
+	/* Find if we already have the msg in our TCS */
+	slot = find_match(tcs, msg->payload, msg->num_payload);
+	if (slot >= 0)
+		goto copy_data;
+
+	/* Do over, until we can fit the full payload in a TCS */
+	do {
+		slot = bitmap_find_next_zero_area(tcs->slots, MAX_TCS_SLOTS,
+						 i, msg->num_payload, 0);
+		if (slot == MAX_TCS_SLOTS)
+			break;
+		i += tcs->ncpt;
+	} while (slot + msg->num_payload - 1 >= i);
+
+	if (slot == MAX_TCS_SLOTS)
+		return -ENOMEM;
+
+copy_data:
+	bitmap_set(tcs->slots, slot, msg->num_payload);
+	/* Copy the addresses of the resources over to the slots */
+	if (tcs->cmd_addr) {
+		for (i = 0; i < msg->num_payload; i++)
+			tcs->cmd_addr[slot + i] = msg->payload[i].addr;
+	}
+
+	offset = slot / tcs->ncpt;
+	*m = offset + tcs->tcs_offset;
+	*n = slot % tcs->ncpt;
+
+	return 0;
+}
+
+static int tcs_ctrl_write(struct rsc_drv *drv, struct tcs_request *msg)
+{
+	struct tcs_group *tcs;
+	int m = 0, n = 0;
+	unsigned long flags;
+	int ret = 0;
+
+	tcs = get_tcs_for_msg(drv, msg);
+	if (IS_ERR(tcs))
+		return PTR_ERR(tcs);
+
+	spin_lock_irqsave(&tcs->tcs_lock, flags);
+	/* find the m-th TCS and the n-th position in the TCS to write to */
+	ret = find_slots(tcs, msg, &m, &n);
+	if (!ret)
+		__tcs_buffer_write(drv, m, n, msg);
+	spin_unlock_irqrestore(&tcs->tcs_lock, flags);
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
+int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv, struct tcs_request *msg)
+{
+	if (!msg || !msg->payload || !msg->num_payload ||
+	   msg->num_payload > MAX_RPMH_PAYLOAD) {
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
@@ -530,6 +645,19 @@ static int rpmh_probe_tcs_config(struct platform_device *pdev,
 		tcs->tcs_mask = ((1 << tcs->num_tcs) - 1) << st;
 		tcs->tcs_offset = st;
 		st += tcs->num_tcs;
+
+		/*
+		 * Allocate memory to cache sleep and wake requests to
+		 * avoid reading TCS register memory.
+		 */
+		if (tcs->type == ACTIVE_TCS)
+			continue;
+
+		tcs->cmd_addr = devm_kzalloc(&pdev->dev,
+					    sizeof(u32) * tcs->num_tcs * ncpt,
+					    GFP_KERNEL);
+		if (!tcs->cmd_addr)
+			return -ENOMEM;
 	}
 
 	drv->num_tcs = st;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
