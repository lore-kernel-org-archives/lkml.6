Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AEE12C5CFF0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50EEC20660
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="l4lWRmjq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SX9oRkLT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50EEC20660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934337AbeFKR1M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:27:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52952 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933362AbeFKR1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:27:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9A41A60850; Mon, 11 Jun 2018 17:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528738025;
        bh=fqyBHTfoO09A8NvGsNwB922soKYOkVIEVrs1ZoZDQi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l4lWRmjqVKK7IXoy65DCho+WCMPaIqeZMlZtiyNSMLQms5RkHfQ13UOeCBSwfipeB
         axX8dHNdwbHctW4Vref0O65T0qbrHpnhUYwbdsezS9jEouko7h9E2UqT9AiUxNbBA8
         OPXsc5LkqpTNRhX5tfVuyeBQpSchXEmyzOxWPwAY=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B13E1602FC;
        Mon, 11 Jun 2018 17:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528738024;
        bh=fqyBHTfoO09A8NvGsNwB922soKYOkVIEVrs1ZoZDQi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SX9oRkLTs+n9uaRYPqxAo+JIPv6ywR2JSS2R39v2LA0o19IyKxBPR1oBqiUxr7c9h
         QZF8ahqIGjG1QYk8bIhCk1YZNIrBdkLG+llsGxHNFBjA6IpUs7d6YfdIJoCp/0bNvz
         kAi3IG/HGC9t+z+wMp6MsAnvJ2FTnaupsqWoj3pY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B13E1602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   Raju P L S S S N <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH v10 09/10] drivers: qcom: rpmh: add support for batch RPMH request
Date:   Mon, 11 Jun 2018 22:55:48 +0530
Message-Id: <1528737949-17495-10-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1528737949-17495-1-git-send-email-rplsssn@codeaurora.org>
References: <1528737949-17495-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
---
Changes in v10:
	- Remove wait_count as suggested by Doug
	- Free memory if cache_batch returns error as suggested by Doug
	- Add batch requests to list and simplify error handling as
	  suggested by Doug
	- Add EXPORT_SYMBOL
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
 drivers/soc/qcom/rpmh.c | 192 +++++++++++++++++++++++++++++++++++++++++++-----
 include/soc/qcom/rpmh.h |   8 ++
 2 files changed, 183 insertions(+), 17 deletions(-)

diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index e380e5a..7c46dae 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -72,18 +72,34 @@ struct rpmh_request {
 };
 
 /**
+ * struct batch_cache_req - An entry in our batch catch
+ *
+ * @list: linked list obj
+ * @count: number of messages
+ * @rpm_msgs: the messages
+ */
+
+struct batch_cache_req {
+	struct list_head list;
+	int count;
+	struct rpmh_request rpm_msgs[];
+};
+
+/**
  * struct rpmh_ctrlr: our representation of the controller
  *
  * @drv: the controller instance
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
+	struct list_head batch_cache;
 };
 
 static struct rpmh_ctrlr rpmh_rsc[RPMH_MAX_CTRLR];
@@ -108,6 +124,7 @@ static struct rpmh_ctrlr *get_rpmh_ctrlr(const struct device *dev)
 			rpmh_rsc[i].drv = drv;
 			spin_lock_init(&rpmh_rsc[i].cache_lock);
 			INIT_LIST_HEAD(&rpmh_rsc[i].cache);
+			INIT_LIST_HEAD(&rpmh_rsc[i].batch_cache);
 			break;
 		}
 	}
@@ -131,10 +148,13 @@ void rpmh_tx_done(const struct tcs_request *msg, int r)
 		dev_err(rpm_msg->dev, "RPMH TX fail in msg addr=%#x, err=%d\n",
 			rpm_msg->msg.cmds[0].addr, r);
 
+	if (!compl)
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
@@ -245,27 +265,19 @@ static int __rpmh_write(const struct device *dev, enum rpmh_state state,
 	return ret;
 }
 
-static struct rpmh_request *__get_rpmh_msg_async(enum rpmh_state state,
-						 const struct tcs_cmd *cmd,
-						 u32 n)
+static int __fill_rpmh_msg(struct rpmh_request *req, enum rpmh_state state,
+			   const struct tcs_cmd *cmd, u32 n)
 {
-	struct rpmh_request *req;
-
 	if (!cmd || !n || n > MAX_RPMH_PAYLOAD)
-		return ERR_PTR(-EINVAL);
-
-	req = kzalloc(sizeof(*req), GFP_ATOMIC);
-	if (!req)
-		return ERR_PTR(-ENOMEM);
+		return -EINVAL;
 
 	memcpy(req->cmd, cmd, n * sizeof(*cmd));
 
 	req->msg.state = state;
 	req->msg.cmds = req->cmd;
 	req->msg.num_cmds = n;
-	req->needs_free = true;
 
-	return req;
+	return 0;
 }
 
 /**
@@ -283,10 +295,18 @@ int rpmh_write_async(const struct device *dev, enum rpmh_state state,
 		     const struct tcs_cmd *cmd, u32 n)
 {
 	struct rpmh_request *rpm_msg;
+	int ret;
+
+	rpm_msg = kzalloc(sizeof(*rpm_msg), GFP_ATOMIC);
+	if (!rpm_msg)
+		return -ENOMEM;
+	rpm_msg->needs_free = true;
 
-	rpm_msg = __get_rpmh_msg_async(state, cmd, n);
-	if (IS_ERR(rpm_msg))
-		return PTR_ERR(rpm_msg);
+	ret = __fill_rpmh_msg(rpm_msg, state, cmd, n);
+	if (ret) {
+		kfree(rpm_msg);
+		return ret;
+	}
 
 	return __rpmh_write(dev, state, rpm_msg);
 }
@@ -325,6 +345,138 @@ int rpmh_write(const struct device *dev, enum rpmh_state state,
 }
 EXPORT_SYMBOL(rpmh_write);
 
+static void cache_batch(struct rpmh_ctrlr *ctrlr, struct batch_cache_req *req)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ctrlr->cache_lock, flags);
+	list_add_tail(&req->list, &ctrlr->batch_cache);
+	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
+}
+
+static int flush_batch(struct rpmh_ctrlr *ctrlr)
+{
+	struct batch_cache_req *req;
+	const struct rpmh_request *rpm_msg;
+	unsigned long flags;
+	int ret = 0;
+	int i;
+
+	/* Send Sleep/Wake requests to the controller, expect no response */
+	spin_lock_irqsave(&ctrlr->cache_lock, flags);
+	list_for_each_entry(req, &ctrlr->batch_cache, list) {
+		for (i = 0; i < req->count; i++) {
+			rpm_msg = req->rpm_msgs + i;
+			ret = rpmh_rsc_write_ctrl_data(ctrlr->drv,
+						       &rpm_msg->msg);
+			if (ret)
+				break;
+		}
+	}
+	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
+
+	return ret;
+}
+
+static void invalidate_batch(struct rpmh_ctrlr *ctrlr)
+{
+	struct batch_cache_req *req, *tmp;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ctrlr->cache_lock, flags);
+	list_for_each_entry_safe(req, tmp, &ctrlr->batch_cache, list)
+		kfree(req);
+	INIT_LIST_HEAD(&ctrlr->batch_cache);
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
+	struct batch_cache_req *req;
+	struct rpmh_request *rpm_msgs;
+	DECLARE_COMPLETION_ONSTACK(compl);
+	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
+	unsigned long time_left;
+	int count = 0;
+	int ret, i, j;
+
+	if (IS_ERR(ctrlr) || !cmd || !n)
+		return -EINVAL;
+
+	while (n[count] > 0)
+		count++;
+	if (!count)
+		return -EINVAL;
+
+	req = kzalloc(sizeof(*req) + count * sizeof(req->rpm_msgs[0]),
+		      GFP_ATOMIC);
+	if (!req)
+		return -ENOMEM;
+	req->count = count;
+	rpm_msgs = req->rpm_msgs;
+
+	for (i = 0; i < count; i++) {
+		__fill_rpmh_msg(rpm_msgs + i, state, cmd, n[i]);
+		cmd += n[i];
+	}
+
+	if (state != RPMH_ACTIVE_ONLY_STATE) {
+		cache_batch(ctrlr, req);
+		return 0;
+	}
+
+	for (i = 0; i < count; i++) {
+		rpm_msgs[i].completion = &compl;
+		ret = rpmh_rsc_send_data(ctrlr->drv, &rpm_msgs[i].msg);
+		if (ret) {
+			pr_err("Error(%d) sending RPMH message addr=%#x\n",
+			       ret, rpm_msgs[i].msg.cmds[0].addr);
+			for (j = i; j < count; j++)
+				rpmh_tx_done(&rpm_msgs[j].msg, ret);
+			break;
+		}
+	}
+
+	time_left = RPMH_TIMEOUT_MS;
+	for (i = 0; i < count; i++) {
+		time_left = wait_for_completion_timeout(&compl, time_left);
+		if (!time_left) {
+			/*
+			 * Better hope they never finish because they'll signal
+			 * the completion on our stack and that's bad once
+			 * we've returned from the function.
+			 */
+			WARN_ON(1);
+			ret = -ETIMEDOUT;
+			goto exit;
+		}
+	}
+
+exit:
+	kfree(req);
+
+	return ret;
+}
+EXPORT_SYMBOL(rpmh_write_batch);
+
 static int is_req_valid(struct cache_req *req)
 {
 	return (req->sleep_val != UINT_MAX &&
@@ -376,6 +528,11 @@ int rpmh_flush(const struct device *dev)
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
@@ -417,6 +574,7 @@ int rpmh_invalidate(const struct device *dev)
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

