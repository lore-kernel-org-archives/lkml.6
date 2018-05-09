Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965762AbeEIRCY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:02:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57218 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965686AbeEIRCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:02:17 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8EEAB60767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, mka@chromium.org, rplsssn@codeaurora.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v8 09/10] drivers: qcom: rpmh: add support for batch RPMH request
Date: Wed,  9 May 2018 11:01:58 -0600
Message-Id: <20180509170159.29682-10-ilina@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180509170159.29682-1-ilina@codeaurora.org>
References: <20180509170159.29682-1-ilina@codeaurora.org>
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

Changes in v7:
	- Check for loop out of bounds

Changes in v6:
	- replace rpmh_client with device *
Changes in v4:
	- reorganize rpmh_write_batch()
	- introduce wait_count here, instead of patch#4
---
 drivers/soc/qcom/rpmh.c | 154 +++++++++++++++++++++++++++++++++++++++-
 include/soc/qcom/rpmh.h |   8 +++
 2 files changed, 160 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 1bb62876795c..a0e277b4b846 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -21,6 +21,8 @@
 #include "rpmh-internal.h"
 
 #define RPMH_TIMEOUT_MS			msecs_to_jiffies(10000)
+#define RPMH_MAX_REQ_IN_BATCH		10
+#define RPMH_MAX_BATCH_CACHE		(2 * RPMH_MAX_REQ_IN_BATCH)
 
 #define DEFINE_RPMH_MSG_ONSTACK(dev, s, q, name)	\
 	struct rpmh_request name = {			\
@@ -34,6 +36,7 @@
 		.completion = q,			\
 		.dev = dev,				\
 		.free = NULL,				\
+		.wait_count = NULL,			\
 	}
 
 /**
@@ -60,6 +63,7 @@ struct cache_req {
  * @dev: the device making the request
  * @err: err return from the controller
  * @free: the request object to be freed at tx_done
+ * @wait_count: count of waiters for this completion
  */
 struct rpmh_request {
 	struct tcs_request msg;
@@ -68,6 +72,7 @@ struct rpmh_request {
 	const struct device *dev;
 	int err;
 	struct rpmh_request *free;
+	atomic_t *wait_count;
 };
 
 /**
@@ -77,12 +82,14 @@ struct rpmh_request {
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
+	const struct rpmh_request *batch_cache[RPMH_MAX_BATCH_CACHE];
 };
 
 static struct rpmh_ctrlr rpmh_rsc[RPMH_MAX_CTRLR];
@@ -133,6 +140,7 @@ void rpmh_tx_done(const struct tcs_request *msg, int r)
 	struct rpmh_request *rpm_msg = container_of(msg, struct rpmh_request,
 						    msg);
 	struct completion *compl = rpm_msg->completion;
+	atomic_t *wc = rpm_msg->wait_count;
 
 	rpm_msg->err = r;
 
@@ -143,8 +151,13 @@ void rpmh_tx_done(const struct tcs_request *msg, int r)
 	kfree(rpm_msg->free);
 
 	/* Signal the blocking thread we are done */
-	if (compl)
-		complete(compl);
+	if (!compl)
+		return;
+
+	if (wc && !atomic_dec_and_test(wc))
+		return;
+
+	complete(compl);
 }
 EXPORT_SYMBOL(rpmh_tx_done);
 
@@ -332,6 +345,137 @@ int rpmh_write(const struct device *dev, enum rpmh_state state,
 }
 EXPORT_SYMBOL(rpmh_write);
 
+static int cache_batch(struct rpmh_ctrlr *ctrlr,
+		       struct rpmh_request **rpm_msg, int count)
+{
+	unsigned long flags;
+	int ret = 0;
+	int index = 0;
+	int i;
+
+	spin_lock_irqsave(&ctrlr->lock, flags);
+	while (index < RPMH_MAX_BATCH_CACHE && ctrlr->batch_cache[index])
+		index++;
+	if (index + count >= RPMH_MAX_BATCH_CACHE) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	for (i = 0; i < count; i++)
+		ctrlr->batch_cache[index + i] = rpm_msg[i];
+fail:
+	spin_unlock_irqrestore(&ctrlr->lock, flags);
+
+	return ret;
+}
+
+static int flush_batch(struct rpmh_ctrlr *ctrlr)
+{
+	const struct rpmh_request *rpm_msg;
+	unsigned long flags;
+	int ret = 0;
+	int i;
+
+	/* Send Sleep/Wake requests to the controller, expect no response */
+	spin_lock_irqsave(&ctrlr->lock, flags);
+	for (i = 0; ctrlr->batch_cache[i]; i++) {
+		rpm_msg = ctrlr->batch_cache[i];
+		ret = rpmh_rsc_write_ctrl_data(ctrlr->drv, &rpm_msg->msg);
+		if (ret)
+			break;
+	}
+	spin_unlock_irqrestore(&ctrlr->lock, flags);
+
+	return ret;
+}
+
+static void invalidate_batch(struct rpmh_ctrlr *ctrlr)
+{
+	unsigned long flags;
+	int index = 0;
+
+	spin_lock_irqsave(&ctrlr->lock, flags);
+	while (ctrlr->batch_cache[index]) {
+		kfree(ctrlr->batch_cache[index]->free);
+		ctrlr->batch_cache[index] = NULL;
+		index++;
+	}
+	spin_unlock_irqrestore(&ctrlr->lock, flags);
+}
+
+/**
+ * rpmh_write_batch: Write multiple sets of RPMH commands and wait for the
+ * batch to finish.
+ *
+ * @dev: the device making the request
+ * @state: Active/sleep set
+ * @cmd: The payload data
+ * @n: The array of count of elements in each batch, 0 terminated.
+ *
+ * Write a request to the RSC controller without caching. If the request
+ * state is ACTIVE, then the requests are treated as completion request
+ * and sent to the controller immediately. The function waits until all the
+ * commands are complete. If the request was to SLEEP or WAKE_ONLY, then the
+ * request is sent as fire-n-forget and no ack is expected.
+ *
+ * May sleep. Do not call from atomic contexts for ACTIVE_ONLY requests.
+ */
+int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
+		     const struct tcs_cmd *cmd, u32 *n)
+{
+	struct rpmh_request *rpm_msg[RPMH_MAX_REQ_IN_BATCH] = { NULL };
+	DECLARE_COMPLETION_ONSTACK(compl);
+	atomic_t wait_count = ATOMIC_INIT(0);
+	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
+	int count = 0;
+	int ret, i;
+
+	if (IS_ERR(ctrlr) || !cmd || !n)
+		return -EINVAL;
+
+	while (n[count++] > 0)
+		;
+	count--;
+	if (!count || count > RPMH_MAX_REQ_IN_BATCH)
+		return -EINVAL;
+
+	for (i = 0; i < count; i++) {
+		rpm_msg[i] = __get_rpmh_msg_async(state, cmd, n[i]);
+		if (IS_ERR_OR_NULL(rpm_msg[i])) {
+			ret = PTR_ERR(rpm_msg[i]);
+			for (; i >= 0; i--)
+				kfree(rpm_msg[i]->free);
+			return ret;
+		}
+		cmd += n[i];
+	}
+
+	if (state != RPMH_ACTIVE_ONLY_STATE)
+		return cache_batch(ctrlr, rpm_msg, count);
+
+	atomic_set(&wait_count, count);
+
+	for (i = 0; i < count; i++) {
+		rpm_msg[i]->completion = &compl;
+		rpm_msg[i]->wait_count = &wait_count;
+		ret = rpmh_rsc_send_data(ctrlr->drv, &rpm_msg[i]->msg);
+		if (ret) {
+			int j;
+
+			pr_err("Error(%d) sending RPMH message addr=%#x\n",
+			       ret, rpm_msg[i]->msg.cmds[0].addr);
+			for (j = i; j < count; j++)
+				rpmh_tx_done(&rpm_msg[j]->msg, ret);
+			break;
+		}
+	}
+
+	ret = wait_for_completion_timeout(&compl, RPMH_TIMEOUT_MS);
+	return (ret > 0) ? 0 : -ETIMEDOUT;
+
+}
+EXPORT_SYMBOL(rpmh_write_batch);
+
 static int is_req_valid(struct cache_req *req)
 {
 	return (req->sleep_val != UINT_MAX &&
@@ -383,6 +527,11 @@ int rpmh_flush(const struct device *dev)
 		return 0;
 	}
 
+	/* First flush the cached batch requests */
+	ret = flush_batch(ctrlr);
+	if (ret)
+		return ret;
+
 	/*
 	 * Nobody else should be calling this function other than system PM,
 	 * hence we can run without locks.
@@ -424,6 +573,7 @@ int rpmh_invalidate(const struct device *dev)
 	if (IS_ERR(ctrlr))
 		return PTR_ERR(ctrlr);
 
+	invalidate_batch(ctrlr);
 	ctrlr->dirty = true;
 
 	do {
diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
index 1161a5c77e75..619e07c75da9 100644
--- a/include/soc/qcom/rpmh.h
+++ b/include/soc/qcom/rpmh.h
@@ -17,6 +17,9 @@ int rpmh_write(const struct device *dev, enum rpmh_state state,
 int rpmh_write_async(const struct device *dev, enum rpmh_state state,
 		     const struct tcs_cmd *cmd, u32 n);
 
+int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
+		     const struct tcs_cmd *cmd, u32 *n);
+
 int rpmh_flush(const struct device *dev);
 
 int rpmh_invalidate(const struct device *dev);
@@ -32,6 +35,11 @@ static inline int rpmh_write_async(const struct device *dev,
 				   const struct tcs_cmd *cmd, u32 n)
 { return -ENODEV; }
 
+static inline int rpmh_write_batch(const struct device *dev,
+				   enum rpmh_state state,
+				   const struct tcs_cmd *cmd, u32 *n)
+{ return -ENODEV; }
+
 static inline int rpmh_flush(const struct device *dev)
 { return -ENODEV; }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
