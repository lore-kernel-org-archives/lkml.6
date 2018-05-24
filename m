Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032547AbeEXKrl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 06:47:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42134 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032509AbeEXKr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 06:47:29 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 50E7D60392
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From: Raju P L S S S N <rplsssn@codeaurora.org>
To: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, mka@chromium.org, rplsssn@codeaurora.org,
        ilina@codeaurora.org
Subject: [PATCH v9 08/10] drivers: qcom: rpmh: allow requests to be sent asynchronously
Date: Thu, 24 May 2018 16:15:29 +0530
Message-Id: <1527158731-17685-9-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527158731-17685-1-git-send-email-rplsssn@codeaurora.org>
References: <1527158731-17685-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lina Iyer <ilina@codeaurora.org>

Platform drivers that want to send a request but do not want to block
until the RPMH request completes have now a new API -
rpmh_write_async().

The API allocates memory and send the requests and returns the control
back to the platform driver. The tx_done callback from the controller is
handled in the context of the controller's thread and frees the
allocated memory. This API allows RPMH requests from atomic contexts as
well.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v9:
	- Remove EXPORT_SYMBOL
	- check to free dynamically allocated request object
	- free request object after notifying completion
Changes in v6:
	- replace rpmh_client with device *
---
 drivers/soc/qcom/rpmh.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/soc/qcom/rpmh.h |  7 +++++++
 2 files changed, 59 insertions(+)

diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index ed96d25..415ad7d 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -34,6 +34,7 @@
 		.cmd = { { 0 } },			\
 		.completion = q,			\
 		.dev = dev,				\
+		.needs_free = false,				\
 	}
 
 /**
@@ -59,6 +60,7 @@ struct cache_req {
  * @completion: triggered when request is done
  * @dev: the device making the request
  * @err: err return from the controller
+ * @needs_free: check to free dynamically allocated request object
  */
 struct rpmh_request {
 	struct tcs_request msg;
@@ -66,6 +68,7 @@ struct rpmh_request {
 	struct completion *completion;
 	const struct device *dev;
 	int err;
+	bool needs_free;
 };
 
 /**
@@ -141,6 +144,9 @@ void rpmh_tx_done(const struct tcs_request *msg, int r)
 	/* Signal the blocking thread we are done */
 	if (compl)
 		complete(compl);
+
+	if (rpm_msg->needs_free)
+		kfree(rpm_msg);
 }
 
 static struct cache_req *__find_req(struct rpmh_ctrlr *ctrlr, u32 addr)
@@ -248,6 +254,52 @@ static int __rpmh_write(const struct device *dev, enum rpmh_state state,
 	return ret;
 }
 
+static struct rpmh_request *__get_rpmh_msg_async(enum rpmh_state state,
+						 const struct tcs_cmd *cmd,
+						 u32 n)
+{
+	struct rpmh_request *req;
+
+	if (!cmd || !n || n > MAX_RPMH_PAYLOAD)
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
+	req->needs_free = true;
+
+	return req;
+}
+
+/**
+ * rpmh_write_async: Write a set of RPMH commands
+ *
+ * @dev: The device making the request
+ * @state: Active/sleep set
+ * @cmd: The payload data
+ * @n: The number of elements in payload
+ *
+ * Write a set of RPMH commands, the order of commands is maintained
+ * and will be sent as a single shot.
+ */
+int rpmh_write_async(const struct device *dev, enum rpmh_state state,
+		     const struct tcs_cmd *cmd, u32 n)
+{
+	struct rpmh_request *rpm_msg;
+
+	rpm_msg = __get_rpmh_msg_async(state, cmd, n);
+	if (IS_ERR(rpm_msg))
+		return PTR_ERR(rpm_msg);
+
+	return __rpmh_write(dev, state, rpm_msg);
+}
+
 /**
  * rpmh_write: Write a set of RPMH commands and block until response
  *
diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
index 42e62a0..1161a5c 100644
--- a/include/soc/qcom/rpmh.h
+++ b/include/soc/qcom/rpmh.h
@@ -14,6 +14,9 @@
 int rpmh_write(const struct device *dev, enum rpmh_state state,
 	       const struct tcs_cmd *cmd, u32 n);
 
+int rpmh_write_async(const struct device *dev, enum rpmh_state state,
+		     const struct tcs_cmd *cmd, u32 n);
+
 int rpmh_flush(const struct device *dev);
 
 int rpmh_invalidate(const struct device *dev);
@@ -24,6 +27,10 @@ static inline int rpmh_write(const struct device *dev, enum rpmh_state state,
 			     const struct tcs_cmd *cmd, u32 n)
 { return -ENODEV; }
 
+static inline int rpmh_write_async(const struct device *dev,
+				   enum rpmh_state state,
+				   const struct tcs_cmd *cmd, u32 n)
+{ return -ENODEV; }
 
 static inline int rpmh_flush(const struct device *dev)
 { return -ENODEV; }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
