Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965775AbeEIRC6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:02:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57106 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965717AbeEIRCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:02:15 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 592FA601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, mka@chromium.org, rplsssn@codeaurora.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v8 08/10] drivers: qcom: rpmh: allow requests to be sent asynchronously
Date: Wed,  9 May 2018 11:01:57 -0600
Message-Id: <20180509170159.29682-9-ilina@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180509170159.29682-1-ilina@codeaurora.org>
References: <20180509170159.29682-1-ilina@codeaurora.org>
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

Changes in v6:
	- replace rpmh_client with device *
---
 drivers/soc/qcom/rpmh.c | 52 +++++++++++++++++++++++++++++++++++++++++
 include/soc/qcom/rpmh.h |  7 ++++++
 2 files changed, 59 insertions(+)

diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 23fcbd9487cd..1bb62876795c 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -33,6 +33,7 @@
 		.cmd = { { 0 } },			\
 		.completion = q,			\
 		.dev = dev,				\
+		.free = NULL,				\
 	}
 
 /**
@@ -58,6 +59,7 @@ struct cache_req {
  * @completion: triggered when request is done
  * @dev: the device making the request
  * @err: err return from the controller
+ * @free: the request object to be freed at tx_done
  */
 struct rpmh_request {
 	struct tcs_request msg;
@@ -65,6 +67,7 @@ struct rpmh_request {
 	struct completion *completion;
 	const struct device *dev;
 	int err;
+	struct rpmh_request *free;
 };
 
 /**
@@ -137,6 +140,8 @@ void rpmh_tx_done(const struct tcs_request *msg, int r)
 		dev_err(rpm_msg->dev, "RPMH TX fail in msg addr=%#x, err=%d\n",
 			rpm_msg->msg.cmds[0].addr, r);
 
+	kfree(rpm_msg->free);
+
 	/* Signal the blocking thread we are done */
 	if (compl)
 		complete(compl);
@@ -248,6 +253,53 @@ static int __rpmh_write(const struct device *dev, enum rpmh_state state,
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
+	req->free = req;
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
+EXPORT_SYMBOL(rpmh_write_async);
+
 /**
  * rpmh_write: Write a set of RPMH commands and block until response
  *
diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
index 42e62a0d26d8..1161a5c77e75 100644
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
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
