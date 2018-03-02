Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967946AbeCBQqL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:46:11 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40964 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967982AbeCBQnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:43:40 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8ECD96076C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v3 07/10] drivers: qcom: rpmh: cache sleep/wake state requests
Date: Fri,  2 Mar 2018 09:43:14 -0700
Message-Id: <20180302164317.10554-8-ilina@codeaurora.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302164317.10554-1-ilina@codeaurora.org>
References: <20180302164317.10554-1-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Active state requests are sent immediately to the mailbox controller,
while sleep and wake state requests are cached in this driver to avoid
taxing the mailbox controller repeatedly. The cached values will be sent
to the controller when the rpmh_flush() is called.

Generally, flushing is a system PM activity and may be called from the
system PM drivers when the system is entering suspend or deeper sleep
modes during cpuidle.

Also allow invalidating the cached requests, so they may be re-populated
again.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---

Changes in v3:
	- Remove locking for flush function
	- Improve comments
---
 drivers/soc/qcom/rpmh.c | 208 +++++++++++++++++++++++++++++++++++++++++++++++-
 include/soc/qcom/rpmh.h |  10 +++
 2 files changed, 217 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index d95ea3fa8b67..8a04009075b8 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -6,11 +6,13 @@
 #include <linux/atomic.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/wait.h>
 
@@ -35,6 +37,22 @@
 		.rc = rc,				\
 	}
 
+
+/**
+ * cache_req : the request object for caching
+ *
+ * @addr: the address of the resource
+ * @sleep_val: the sleep vote
+ * @wake_val: the wake vote
+ * @list: linked list obj
+ */
+struct cache_req {
+	u32 addr;
+	u32 sleep_val;
+	u32 wake_val;
+	struct list_head list;
+};
+
 /**
  * rpmh_request: the message to be sent to rpmh-rsc
  *
@@ -57,9 +75,15 @@ struct rpmh_request {
  * rpmh_ctrlr: our representation of the controller
  *
  * @drv: the controller instance
+ * @cache: the list of cached requests
+ * @lock: synchronize access to the controller data
+ * @dirty: was the cache updated since flush
  */
 struct rpmh_ctrlr {
 	struct rsc_drv *drv;
+	struct list_head cache;
+	spinlock_t lock;
+	bool dirty;
 };
 
 /**
@@ -123,17 +147,91 @@ static int wait_for_tx_done(struct rpmh_client *rc,
 	return (ret > 0) ? 0 : -ETIMEDOUT;
 }
 
+static struct cache_req *__find_req(struct rpmh_client *rc, u32 addr)
+{
+	struct cache_req *p, *req = NULL;
+
+	list_for_each_entry(p, &rc->ctrlr->cache, list) {
+		if (p->addr == addr) {
+			req = p;
+			break;
+		}
+	}
+
+	return req;
+}
+
+static struct cache_req *cache_rpm_request(struct rpmh_client *rc,
+					  enum rpmh_state state,
+					  struct tcs_cmd *cmd)
+{
+	struct cache_req *req;
+	struct rpmh_ctrlr *rpm = rc->ctrlr;
+	unsigned long flags;
+
+	spin_lock_irqsave(&rpm->lock, flags);
+	req = __find_req(rc, cmd->addr);
+	if (req)
+		goto existing;
+
+	req = kzalloc(sizeof(*req), GFP_ATOMIC);
+	if (!req) {
+		req = ERR_PTR(-ENOMEM);
+		goto unlock;
+	}
+
+	req->addr = cmd->addr;
+	req->sleep_val = req->wake_val = UINT_MAX;
+	INIT_LIST_HEAD(&req->list);
+	list_add_tail(&req->list, &rpm->cache);
+
+existing:
+	switch (state) {
+	case RPMH_ACTIVE_ONLY_STATE:
+		if (req->sleep_val != UINT_MAX)
+			req->wake_val = cmd->data;
+		break;
+	case RPMH_WAKE_ONLY_STATE:
+		req->wake_val = cmd->data;
+		break;
+	case RPMH_SLEEP_STATE:
+		req->sleep_val = cmd->data;
+		break;
+	default:
+		break;
+	};
+
+	rpm->dirty = true;
+unlock:
+	spin_unlock_irqrestore(&rpm->lock, flags);
+
+	return req;
+}
+
 /**
- * __rpmh_write: send the RPMH request
+ * __rpmh_write: Cache and send the RPMH request
  *
  * @rc: The RPMH client
  * @state: Active/Sleep request type
  * @rpm_msg: The data that needs to be sent (payload).
+ *
+ * Cache the RPMH request and send if the state is ACTIVE_ONLY.
+ * SLEEP/WAKE_ONLY requests are not sent to the controller at
+ * this time. Use rpmh_flush() to send them to the controller.
  */
 static int __rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
 		       struct rpmh_request *rpm_msg)
 {
 	int ret = -EFAULT;
+	struct cache_req *req;
+	int i;
+
+	/* Cache the request in our store and link the payload */
+	for (i = 0; i < rpm_msg->msg.num_payload; i++) {
+		req = cache_rpm_request(rc, state, &rpm_msg->msg.payload[i]);
+		if (IS_ERR(req))
+			return PTR_ERR(req);
+	}
 
 	rpm_msg->msg.state = state;
 
@@ -150,6 +248,10 @@ static int __rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
 				"Error in RPMH request addr=0x%x, data=0x%x\n",
 				rpm_msg->msg.payload[0].addr,
 				rpm_msg->msg.payload[0].data);
+	} else {
+		ret = rpmh_rsc_write_ctrl_data(rc->ctrlr->drv, &rpm_msg->msg);
+		/* Clean up our call by spoofing tx_done */
+		rpmh_tx_done(&rpm_msg->msg, ret);
 	}
 
 	return ret;
@@ -189,6 +291,108 @@ int rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
 }
 EXPORT_SYMBOL(rpmh_write);
 
+static int is_req_valid(struct cache_req *req)
+{
+	return (req->sleep_val != UINT_MAX &&
+	       req->wake_val != UINT_MAX &&
+	       req->sleep_val != req->wake_val);
+}
+
+static int send_single(struct rpmh_client *rc, enum rpmh_state state,
+		      u32 addr, u32 data)
+{
+	DEFINE_RPMH_MSG_ONSTACK(rc, state, NULL, NULL, rpm_msg);
+
+	/* Wake sets are always complete and sleep sets are not */
+	rpm_msg.msg.is_complete = (state == RPMH_WAKE_ONLY_STATE);
+	rpm_msg.cmd[0].addr = addr;
+	rpm_msg.cmd[0].data = data;
+	rpm_msg.msg.num_payload = 1;
+	rpm_msg.msg.is_complete = false;
+
+	return rpmh_rsc_write_ctrl_data(rc->ctrlr->drv, &rpm_msg.msg);
+}
+
+/**
+ * rpmh_flush: Flushes the buffered active and sleep sets to TCS
+ *
+ * @rc: The RPMh handle got from rpmh_get_dev_channel
+ *
+ * Return: -EBUSY if the controller is busy, probably waiting on a response
+ * to a RPMH request sent earlier.
+ *
+ * This function is generally called from the sleep code from the last CPU
+ * that is powering down the entire system. Since no other RPMH API would be
+ * executing at this time, it is safe to run lockless.
+ */
+int rpmh_flush(struct rpmh_client *rc)
+{
+	struct cache_req *p;
+	struct rpmh_ctrlr *rpm = rc->ctrlr;
+	int ret;
+
+	if (IS_ERR_OR_NULL(rc))
+		return -EINVAL;
+
+	if (!rpm->dirty) {
+		pr_debug("Skipping flush, TCS has latest data.\n");
+		return 0;
+	}
+
+	/*
+	 * Nobody else should be calling this function other than system PM,,
+	 * hence we can run without locks.
+	 */
+	list_for_each_entry(p, &rc->ctrlr->cache, list) {
+		if (!is_req_valid(p)) {
+			pr_debug("%s: skipping RPMH req: a:0x%x s:0x%x w:0x%x",
+				__func__, p->addr, p->sleep_val, p->wake_val);
+			continue;
+		}
+		ret = send_single(rc, RPMH_SLEEP_STATE, p->addr, p->sleep_val);
+		if (ret)
+			return ret;
+		ret = send_single(rc, RPMH_WAKE_ONLY_STATE, p->addr,
+						p->wake_val);
+		if (ret)
+			return ret;
+	}
+
+	rpm->dirty = false;
+
+	return 0;
+}
+EXPORT_SYMBOL(rpmh_flush);
+
+/**
+ * rpmh_invalidate: Invalidate all sleep and active sets
+ * sets.
+ *
+ * @rc: The RPMh handle got from rpmh_get_dev_channel
+ *
+ * Invalidate the sleep and active values in the TCS blocks.
+ */
+int rpmh_invalidate(struct rpmh_client *rc)
+{
+	struct rpmh_ctrlr *rpm = rc->ctrlr;
+	int ret;
+	unsigned long flags;
+
+	if (IS_ERR_OR_NULL(rc))
+		return -EINVAL;
+
+	spin_lock_irqsave(&rpm->lock, flags);
+	rpm->dirty = true;
+	spin_unlock_irqrestore(&rpm->lock, flags);
+
+	do {
+		ret = rpmh_rsc_invalidate(rc->ctrlr->drv);
+	} while (ret == -EAGAIN);
+
+	return ret;
+}
+EXPORT_SYMBOL(rpmh_invalidate);
+
 static struct rpmh_ctrlr *get_rpmh_ctrlr(struct platform_device *pdev)
 {
 	int i;
@@ -210,6 +414,8 @@ static struct rpmh_ctrlr *get_rpmh_ctrlr(struct platform_device *pdev)
 		if (rpmh_rsc[i].drv == NULL) {
 			ctrlr = &rpmh_rsc[i];
 			ctrlr->drv = drv;
+			spin_lock_init(&ctrlr->lock);
+			INIT_LIST_HEAD(&ctrlr->cache);
 			break;
 		}
 	}
diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
index 53cc145990c2..a3f1246ce49a 100644
--- a/include/soc/qcom/rpmh.h
+++ b/include/soc/qcom/rpmh.h
@@ -17,6 +17,10 @@ int rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
 
 struct rpmh_client *rpmh_get_client(struct platform_device *pdev);
 
+int rpmh_flush(struct rpmh_client *rc);
+
+int rpmh_invalidate(struct rpmh_client *rc);
+
 void rpmh_release(struct rpmh_client *rc);
 
 #else
@@ -28,6 +32,12 @@ static inline int rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
 static inline struct rpmh_client *rpmh_get_client(struct platform_device *pdev)
 { return ERR_PTR(-ENODEV); }
 
+static inline int rpmh_flush(struct rpmh_client *rc)
+{ return -ENODEV; }
+
+static inline int rpmh_invalidate(struct rpmh_client *rc)
+{ return -ENODEV; }
+
 static inline void rpmh_release(struct rpmh_client *rc) { }
 #endif /* CONFIG_QCOM_RPMH */
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
