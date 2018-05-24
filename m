Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032564AbeEXKsL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 06:48:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42234 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030544AbeEXKrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 06:47:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A663D60C54
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From: Raju P L S S S N <rplsssn@codeaurora.org>
To: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, mka@chromium.org, rplsssn@codeaurora.org,
        ilina@codeaurora.org
Subject: [PATCH v9 09/10] drivers: qcom: rpmh: add support for batch RPMH request
Date: Thu, 24 May 2018 16:15:30 +0530
Message-Id: <1527158731-17685-10-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527158731-17685-1-git-send-email-rplsssn@codeaurora.org>
References: <1527158731-17685-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lina Iyer <ilina@codeaurora.org>

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
Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v9:
	- Fix Check for loop out of bounds
	- Remove EXPORT_SYMBOL
	- Fix comments
	- Change IS_ERR_OR_NULL to IS_ERR for rpm_msg pointer
	- Fix freeing rpm_msg ERR_PTR
Changes in v7:
	- Check for loop out of bounds

Changes in v6:
	- replace rpmh_client with device *
Changes in v4:
	- reorganize rpmh_write_batch()
	- introduce wait_count here, instead of patch#4
---
 drivers/soc/qcom/rpmh.c | 157 +++++++++++++++++++++++++++++++++++++++++++++++-
 include/soc/qcom/rpmh.h |   8 +++
 2 files changed, 163 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 415ad7d..95a0761 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -22,6 +22,8 @@
 #include "rpmh-internal.h"
 
 #define RPMH_TIMEOUT_MS			msecs_to_jiffies(10000)
+#define RPMH_MAX_REQ_IN_BATCH		10
+#define RPMH_MAX_BATCH_CACHE		(2 * RPMH_MAX_REQ_IN_BATCH)
 
 #define DEFINE_RPMH_MSG_ONSTACK(dev, s, q, name)	\
 	struct rpmh_request name = {			\
@@ -35,6 +37,7 @@
 		.completion = q,			\
 		.dev = dev,				\
 		.needs_free = false,				\
+		.wait_count = NULL,			\
 	}
 
 /**
@@ -61,6 +64,7 @@ struct cache_req {
  * @dev: the device making the request
  * @err: err return from the controller
  * @needs_free: check to free dynamically allocated request object
+ * @wait_count: count of waiters for this completion
  */
 struct rpmh_request {
 	struct tcs_request msg;
@@ -69,6 +73,7 @@ struct rpmh_request {
 	const struct device *dev;
 	int err;
 	bool needs_free;
+	atomic_t *wait_count;
 };
 
 /**
@@ -78,12 +83,14 @@ struct rpmh_request {
  * @cache: the list of cached requests
  * @cache_lock: synchronize access to the cache data
  * @dirty: was the cache updated since flush
+ * @batch_cache: Cache sleep and wake requests sent as batch
  */
 struct rpmh_ctrlr {
 	struct rsc_drv *drv;
 	struct list_head cache;
 	spinlock_t cache_lock;
 	bool dirty;
+	const struct rpmh_request *batch_cache[RPMH_MAX_BATCH_CACHE];
 };
 
 static struct rpmh_ctrlr rpmh_rsc[RPMH_MAX_CTRLR];
@@ -134,6 +141,7 @@ void rpmh_tx_done(const struct tcs_request *msg, int r)
 	struct rpmh_request *rpm_msg = container_of(msg, struct rpmh_request,
 						    msg);
 	struct completion *compl = rpm_msg->completion;
+	atomic_t *wc = rpm_msg->wait_count;
 
 	rpm_msg->err = r;
 
@@ -141,10 +149,16 @@ void rpmh_tx_done(const struct tcs_request *msg, int r)
 		dev_err(rpm_msg->dev, "RPMH TX fail in msg addr=%#x, err=%d\n",
 			rpm_msg->msg.cmds[0].addr, r);
 
+	if (!compl)
+		goto exit;
+
+	if (wc && !atomic_dec_and_test(wc))
+		goto exit;
+
 	/* Signal the blocking thread we are done */
-	if (compl)
-		complete(compl);
+	complete(compl);
 
+exit:
 	if (rpm_msg->needs_free)
 		kfree(rpm_msg);
 }
@@ -332,6 +346,139 @@ int rpmh_write(const struct device *dev, enum rpmh_state state,
 	return (ret > 0) ? 0 : -ETIMEDOUT;
 }
 
+static int cache_batch(struct rpmh_ctrlr *ctrlr,
+		       struct rpmh_request **rpm_msg, int count)
+{
+	unsigned long flags;
+	int ret = 0;
+	int index = 0;
+	int i;
+
+	spin_lock_irqsave(&ctrlr->cache_lock, flags);
+	while (index < RPMH_MAX_BATCH_CACHE && ctrlr->batch_cache[index])
+		index++;
+	if (index + count >= RPMH_MAX_BATCH_CACHE) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	for (i = 0; i < count; i++)
+		ctrlr->batch_cache[index + i] = rpm_msg[i];
+exit:
+	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
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
+	spin_lock_irqsave(&ctrlr->cache_lock, flags);
+	for (i = 0; i < RPMH_MAX_BATCH_CACHE && ctrlr->batch_cache[i]; i++) {
+		rpm_msg = ctrlr->batch_cache[i];
+		ret = rpmh_rsc_write_ctrl_data(ctrlr->drv, &rpm_msg->msg);
+		if (ret)
+			break;
+	}
+	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
+
+	return ret;
+}
+
+static void invalidate_batch(struct rpmh_ctrlr *ctrlr)
+{
+	unsigned long flags;
+	int index = 0;
+
+	spin_lock_irqsave(&ctrlr->cache_lock, flags);
+	while (index < RPMH_MAX_BATCH_CACHE && ctrlr->batch_cache[index]) {
+		if (ctrlr->batch_cache[index]->needs_free)
+			kfree(ctrlr->batch_cache[index]);
+		ctrlr->batch_cache[index] = NULL;
+		index++;
+	}
+	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
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
+	int ret, i, j;
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
+		if (IS_ERR(rpm_msg[i])) {
+			ret = PTR_ERR(rpm_msg[i]);
+			for (j = i-1; j >= 0; j--) {
+				if (rpm_msg[j]->needs_free)
+					kfree(rpm_msg[j]);
+			}
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
+
 static int is_req_valid(struct cache_req *req)
 {
 	return (req->sleep_val != UINT_MAX &&
@@ -383,6 +530,11 @@ int rpmh_flush(const struct device *dev)
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
@@ -423,6 +575,7 @@ int rpmh_invalidate(const struct device *dev)
 	if (IS_ERR(ctrlr))
 		return PTR_ERR(ctrlr);
 
+	invalidate_batch(ctrlr);
 	ctrlr->dirty = true;
 
 	do {
diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
index 1161a5c..619e07c 100644
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
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
