Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968097AbeCBQqG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:46:06 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41236 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967985AbeCBQnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:43:42 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CB461607EF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v3 09/10] drivers: qcom: rpmh: add support for batch RPMH request
Date: Fri,  2 Mar 2018 09:43:16 -0700
Message-Id: <20180302164317.10554-10-ilina@codeaurora.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302164317.10554-1-ilina@codeaurora.org>
References: <20180302164317.10554-1-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform drivers need make a lot of resource state requests at the same
time, say, at the start or end of an usecase. It can be quite
inefficient to send each request separately. Instead they can give the
RPMH library a batch of requests to be sent and wait on the whole
transaction to be complete.

rpmh_write_batch() is a blocking call that can be used to send multiple
RPMH command sets. Each RPMH command set is set asynchronously and the
API blocks until all the command sets are complete and receive their
tx_done callbacks.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/soc/qcom/rpmh.c | 150 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/soc/qcom/rpmh.h |   8 +++
 2 files changed, 158 insertions(+)

diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index a02d9f685b2b..19e84b031c0d 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -22,6 +22,7 @@
 
 #define RPMH_MAX_MBOXES			2
 #define RPMH_TIMEOUT			(10 * HZ)
+#define RPMH_MAX_REQ_IN_BATCH		10
 
 #define DEFINE_RPMH_MSG_ONSTACK(rc, s, q, c, name)	\
 	struct rpmh_request name = {			\
@@ -81,12 +82,14 @@ struct rpmh_request {
  * @cache: the list of cached requests
  * @lock: synchronize access to the controller data
  * @dirty: was the cache updated since flush
+ * @batch_cache: Cache sleep and wake requests sent as batch
  */
 struct rpmh_ctrlr {
 	struct rsc_drv *drv;
 	struct list_head cache;
 	spinlock_t lock;
 	bool dirty;
+	struct rpmh_request *batch_cache[2 * RPMH_MAX_REQ_IN_BATCH];
 };
 
 /**
@@ -343,6 +346,146 @@ int rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
 }
 EXPORT_SYMBOL(rpmh_write);
 
+static int cache_batch(struct rpmh_client *rc,
+		      struct rpmh_request **rpm_msg, int count)
+{
+	struct rpmh_ctrlr *rpm = rc->ctrlr;
+	unsigned long flags;
+	int ret = 0;
+	int index = 0;
+	int i;
+
+	spin_lock_irqsave(&rpm->lock, flags);
+	while (rpm->batch_cache[index])
+		index++;
+	if (index + count >=  2 * RPMH_MAX_REQ_IN_BATCH) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	for (i = 0; i < count; i++)
+		rpm->batch_cache[index + i] = rpm_msg[i];
+fail:
+	spin_unlock_irqrestore(&rpm->lock, flags);
+
+	return ret;
+}
+
+static int flush_batch(struct rpmh_client *rc)
+{
+	struct rpmh_ctrlr *rpm = rc->ctrlr;
+	struct rpmh_request *rpm_msg;
+	unsigned long flags;
+	int ret = 0;
+	int i;
+
+	/* Send Sleep/Wake requests to the controller, expect no response */
+	spin_lock_irqsave(&rpm->lock, flags);
+	for (i = 0; rpm->batch_cache[i]; i++) {
+		rpm_msg = rpm->batch_cache[i];
+		ret = rpmh_rsc_write_ctrl_data(rc->ctrlr->drv, &rpm_msg->msg);
+		if (ret)
+			break;
+	}
+	spin_unlock_irqrestore(&rpm->lock, flags);
+
+	return ret;
+}
+
+static void invalidate_batch(struct rpmh_client *rc)
+{
+	struct rpmh_ctrlr *rpm = rc->ctrlr;
+	unsigned long flags;
+	int index = 0;
+	int i;
+
+	spin_lock_irqsave(&rpm->lock, flags);
+	while (rpm->batch_cache[index])
+		index++;
+	for (i = 0; i < index; i++) {
+		kfree(rpm->batch_cache[i]->free);
+		rpm->batch_cache[i] = NULL;
+	}
+	spin_unlock_irqrestore(&rpm->lock, flags);
+}
+
+/**
+ * rpmh_write_batch: Write multiple sets of RPMH commands and wait for the
+ * batch to finish.
+ *
+ * @rc: The RPMh handle got from rpmh_get_dev_channel
+ * @state: Active/sleep set
+ * @cmd: The payload data
+ * @n: The array of count of elements in each batch, 0 terminated.
+ *
+ * Write a request to the mailbox controller without caching. If the request
+ * state is ACTIVE, then the requests are treated as completion request
+ * and sent to the controller immediately. The function waits until all the
+ * commands are complete. If the request was to SLEEP or WAKE_ONLY, then the
+ * request is sent as fire-n-forget and no ack is expected.
+ *
+ * May sleep. Do not call from atomic contexts for ACTIVE_ONLY requests.
+ */
+int rpmh_write_batch(struct rpmh_client *rc, enum rpmh_state state,
+		    struct tcs_cmd *cmd, int *n)
+{
+	struct rpmh_request *rpm_msg[RPMH_MAX_REQ_IN_BATCH] = { NULL };
+	DECLARE_COMPLETION_ONSTACK(compl);
+	atomic_t wait_count = ATOMIC_INIT(0); /* overwritten */
+	int count = 0;
+	int ret, i, j;
+
+	if (IS_ERR_OR_NULL(rc) || !cmd || !n)
+		return -EINVAL;
+
+	while (n[count++] > 0)
+		;
+	count--;
+	if (!count || count > RPMH_MAX_REQ_IN_BATCH)
+		return -EINVAL;
+
+	/* Create async request batches */
+	for (i = 0; i < count; i++) {
+		rpm_msg[i] = __get_rpmh_msg_async(rc, state, cmd, n[i]);
+		if (IS_ERR_OR_NULL(rpm_msg[i])) {
+			for (j = 0 ; j < i; j++)
+				kfree(rpm_msg[j]->free);
+			return PTR_ERR(rpm_msg[i]);
+		}
+		cmd += n[i];
+	}
+
+	/* Send if Active and wait for the whole set to complete */
+	if (state == RPMH_ACTIVE_ONLY_STATE) {
+		might_sleep();
+		atomic_set(&wait_count, count);
+		for (i = 0; i < count; i++) {
+			rpm_msg[i]->completion = &compl;
+			rpm_msg[i]->wait_count = &wait_count;
+			/* Bypass caching and write to mailbox directly */
+			ret = rpmh_rsc_send_data(rc->ctrlr->drv,
+						&rpm_msg[i]->msg);
+			if (ret < 0) {
+				pr_err(
+				"Error(%d) sending RPMH message addr=0x%x\n",
+				ret, rpm_msg[i]->msg.payload[0].addr);
+				break;
+			}
+		}
+		/* For those unsent requests, spoof tx_done */
+		for (j = i; j < count; j++)
+			rpmh_tx_done(&rpm_msg[j]->msg, ret);
+		return wait_for_tx_done(rc, &compl, cmd[0].addr, cmd[0].data);
+	}
+
+	/*
+	 * Cache sleep/wake data in store.
+	 * But flush batch first before flushing all other data.
+	 */
+	return cache_batch(rc, rpm_msg, count);
+}
+EXPORT_SYMBOL(rpmh_write_batch);
+
 static int is_req_valid(struct cache_req *req)
 {
 	return (req->sleep_val != UINT_MAX &&
@@ -391,6 +534,11 @@ int rpmh_flush(struct rpmh_client *rc)
 		return 0;
 	}
 
+	/* First flush the cached batch requests */
+	ret = flush_batch(rc);
+	if (ret)
+		return ret;
+
 	/*
 	 * Nobody else should be calling this function other than system PM,,
 	 * hence we can run without locks.
@@ -433,6 +581,8 @@ int rpmh_invalidate(struct rpmh_client *rc)
 	if (IS_ERR_OR_NULL(rc))
 		return -EINVAL;
 
+	invalidate_batch(rc);
+
 	spin_lock_irqsave(&rpm->lock, flags);
 	rpm->dirty = true;
 	spin_unlock_irqrestore(&rpm->lock, flags);
diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
index 172a649f1a1c..6dc1042534d6 100644
--- a/include/soc/qcom/rpmh.h
+++ b/include/soc/qcom/rpmh.h
@@ -18,6 +18,9 @@ int rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
 int rpmh_write_async(struct rpmh_client *rc, enum rpmh_state state,
 		    struct tcs_cmd *cmd, int n);
 
+int rpmh_write_batch(struct rpmh_client *rc, enum rpmh_state state,
+		    struct tcs_cmd *cmd, int *n);
+
 struct rpmh_client *rpmh_get_client(struct platform_device *pdev);
 
 int rpmh_flush(struct rpmh_client *rc);
@@ -40,6 +43,11 @@ static inline int rpmh_write_async(struct rpmh_client *rc,
 				  struct tcs_cmd *cmd, int n)
 { return -ENODEV; }
 
+static inline int rpmh_write_batch(struct rpmh_client *rc,
+				  enum rpmh_state state,
+				  struct tcs_cmd *cmd, int *n)
+{ return -ENODEV; }
+
 static inline int rpmh_flush(struct rpmh_client *rc)
 { return -ENODEV; }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
