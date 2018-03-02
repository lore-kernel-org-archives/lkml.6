Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968111AbeCBQqI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:46:08 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41030 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967983AbeCBQnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:43:41 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9D1E86053B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v3 08/10] drivers: qcom: rpmh: allow requests to be sent asynchronously
Date: Fri,  2 Mar 2018 09:43:15 -0700
Message-Id: <20180302164317.10554-9-ilina@codeaurora.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302164317.10554-1-ilina@codeaurora.org>
References: <20180302164317.10554-1-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform drivers that want to send a request but do not want to block
until the RPMH request completes have now a new API -
rpmh_write_async().

The API allocates memory and send the requests and returns the control
back to the platform driver. The tx_done callback from the controller is
handled in the context of the controller's thread and frees the
allocated memory. This API allows RPMH requests from atomic contexts as
well.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/soc/qcom/rpmh.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/soc/qcom/rpmh.h |  8 ++++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 8a04009075b8..a02d9f685b2b 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -35,6 +35,7 @@
 		.completion = q,			\
 		.wait_count = c,			\
 		.rc = rc,				\
+		.free = NULL,				\
 	}
 
 
@@ -61,6 +62,7 @@ struct cache_req {
  * @completion: triggered when request is done
  * @wait_count: count of waiters for this completion
  * @err: err return from the controller
+ * @free: the request object to be freed at tx_done
  */
 struct rpmh_request {
 	struct tcs_request msg;
@@ -69,6 +71,7 @@ struct rpmh_request {
 	atomic_t *wait_count;
 	struct rpmh_client *rc;
 	int err;
+	struct rpmh_request *free;
 };
 
 /**
@@ -114,6 +117,8 @@ void rpmh_tx_done(struct tcs_request *msg, int r)
 		       "RPMH TX fail in msg addr 0x%x, err=%d\n",
 		       rpm_msg->msg.payload[0].addr, r);
 
+	kfree(rpm_msg->free);
+
 	/* Signal the blocking thread we are done */
 	if (wc && atomic_dec_and_test(wc) && compl)
 		complete(compl);
@@ -257,6 +262,53 @@ static int __rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
 	return ret;
 }
 
+static struct rpmh_request *__get_rpmh_msg_async(struct rpmh_client *rc,
+						enum rpmh_state state,
+						struct tcs_cmd *cmd, int n)
+{
+	struct rpmh_request *req;
+
+	if (IS_ERR_OR_NULL(rc) || !cmd || n <= 0 || n > MAX_RPMH_PAYLOAD)
+		return ERR_PTR(-EINVAL);
+
+	req = kcalloc(1, sizeof(*req), GFP_ATOMIC);
+	if (!req)
+		return ERR_PTR(-ENOMEM);
+
+	memcpy(req->cmd, cmd, n * sizeof(*cmd));
+
+	req->msg.state = state;
+	req->msg.payload = req->cmd;
+	req->msg.num_payload = n;
+	req->free = req;
+
+	return req;
+}
+
+/**
+ * rpmh_write_async: Write a set of RPMH commands
+ *
+ * @rc: The RPMh handle got from rpmh_get_dev_channel
+ * @state: Active/sleep set
+ * @cmd: The payload data
+ * @n: The number of elements in payload
+ *
+ * Write a set of RPMH commands, the order of commands is maintained
+ * and will be sent as a single shot.
+ */
+int rpmh_write_async(struct rpmh_client *rc, enum rpmh_state state,
+		    struct tcs_cmd *cmd, int n)
+{
+	struct rpmh_request *rpm_msg;
+
+	rpm_msg = __get_rpmh_msg_async(rc, state, cmd, n);
+	if (IS_ERR(rpm_msg))
+		return PTR_ERR(rpm_msg);
+
+	return __rpmh_write(rc, state, rpm_msg);
+}
+EXPORT_SYMBOL(rpmh_write_async);
+
 /**
  * rpmh_write: Write a set of RPMH commands and block until response
  *
diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
index a3f1246ce49a..172a649f1a1c 100644
--- a/include/soc/qcom/rpmh.h
+++ b/include/soc/qcom/rpmh.h
@@ -15,6 +15,9 @@ struct rpmh_client;
 int rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
 	      struct tcs_cmd *cmd, int n);
 
+int rpmh_write_async(struct rpmh_client *rc, enum rpmh_state state,
+		    struct tcs_cmd *cmd, int n);
+
 struct rpmh_client *rpmh_get_client(struct platform_device *pdev);
 
 int rpmh_flush(struct rpmh_client *rc);
@@ -32,6 +35,11 @@ static inline int rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
 static inline struct rpmh_client *rpmh_get_client(struct platform_device *pdev)
 { return ERR_PTR(-ENODEV); }
 
+static inline int rpmh_write_async(struct rpmh_client *rc,
+				  enum rpmh_state state,
+				  struct tcs_cmd *cmd, int n)
+{ return -ENODEV; }
+
 static inline int rpmh_flush(struct rpmh_client *rc)
 { return -ENODEV; }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
