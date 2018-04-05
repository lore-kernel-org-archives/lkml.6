Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbeDEQTw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 12:19:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41918 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751696AbeDEQSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 12:18:54 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6D3D260F94
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v5 08/10] drivers: qcom: rpmh: allow requests to be sent asynchronously
Date: Thu,  5 Apr 2018 10:18:32 -0600
Message-Id: <20180405161834.3850-9-ilina@codeaurora.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180405161834.3850-1-ilina@codeaurora.org>
References: <20180405161834.3850-1-ilina@codeaurora.org>
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
 drivers/soc/qcom/rpmh.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/soc/qcom/rpmh.h |  8 ++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index b5468ef082c1..3a96e5f58302 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -35,6 +35,7 @@
 		.cmd = { { 0 } },			\
 		.completion = q,			\
 		.rc = rc,				\
+		.free = NULL,				\
 	}
 
 /**
@@ -59,6 +60,7 @@ struct cache_req {
  * @cmd: the payload that will be part of the @msg
  * @completion: triggered when request is done
  * @err: err return from the controller
+ * @free: the request object to be freed at tx_done
  */
 struct rpmh_request {
 	struct tcs_request msg;
@@ -66,6 +68,7 @@ struct rpmh_request {
 	struct completion *completion;
 	struct rpmh_client *rc;
 	int err;
+	struct rpmh_request *free;
 };
 
 /**
@@ -110,6 +113,8 @@ void rpmh_tx_done(const struct tcs_request *msg, int r)
 			"RPMH TX fail in msg addr=%#x, err=%d\n",
 			rpm_msg->msg.cmds[0].addr, r);
 
+	kfree(rpm_msg->free);
+
 	/* Signal the blocking thread we are done */
 	if (compl)
 		complete(compl);
@@ -255,6 +260,54 @@ static int __rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
 	return ret;
 }
 
+static struct rpmh_request *__get_rpmh_msg_async(struct rpmh_client *rc,
+						 enum rpmh_state state,
+						 const struct tcs_cmd *cmd,
+						 u32 n)
+{
+	struct rpmh_request *req;
+
+	if (IS_ERR_OR_NULL(rc) || !cmd || !n || n > MAX_RPMH_PAYLOAD)
+		return ERR_PTR(-EINVAL);
+
+	req = kzalloc(sizeof(*req), GFP_ATOMIC);
+	if (!req)
+		return ERR_PTR(-ENOMEM);
+
+	memcpy(req->cmd, cmd, n * sizeof(*cmd));
+
+	req->msg.state = state;
+	req->msg.cmds = req->cmd;
+	req->msg.num_cmds = n;
+	req->free = req;
+
+	return req;
+}
+
+/**
+ * rpmh_write_async: Write a set of RPMH commands
+ *
+ * @rc: The RPMh handle got from rpmh_get_client
+ * @state: Active/sleep set
+ * @cmd: The payload data
+ * @n: The number of elements in payload
+ *
+ * Write a set of RPMH commands, the order of commands is maintained
+ * and will be sent as a single shot.
+ */
+int rpmh_write_async(struct rpmh_client *rc, enum rpmh_state state,
+		     const struct tcs_cmd *cmd, u32 n)
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
index 41a2518c46a5..9e6de09e43f0 100644
--- a/include/soc/qcom/rpmh.h
+++ b/include/soc/qcom/rpmh.h
@@ -15,6 +15,9 @@ struct rpmh_client;
 int rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
 	       const struct tcs_cmd *cmd, u32 n);
 
+int rpmh_write_async(struct rpmh_client *rc, enum rpmh_state state,
+		     const struct tcs_cmd *cmd, u32 n);
+
 struct rpmh_client *rpmh_get_client(struct platform_device *pdev);
 
 int rpmh_flush(struct rpmh_client *rc);
@@ -32,6 +35,11 @@ static inline int rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
 static inline struct rpmh_client *rpmh_get_client(struct platform_device *pdev)
 { return ERR_PTR(-ENODEV); }
 
+static inline int rpmh_write_async(struct rpmh_client *rc,
+				   enum rpmh_state state,
+				   const struct tcs_cmd *cmd, u32 n)
+{ return -ENODEV; }
+
 static inline int rpmh_flush(struct rpmh_client *rc)
 { return -ENODEV; }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
