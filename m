Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 34A97C004EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7BEE20869
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="E4fdlYmZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CPsmv95E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7BEE20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934317AbeFKR1D (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:27:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52744 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934241AbeFKR06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:26:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9211A608D2; Mon, 11 Jun 2018 17:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528738017;
        bh=lkGZB3BnFB6IEecI0CY1KjJOh5A41notD6TKGMR8eOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E4fdlYmZONFMk0WxFxk7ogxXzXrMmqiVtx2/YYunRyQme+C0i/0p0GYbKW3Ftz6PQ
         eDUncTDLVoWm14xugGyC8zc/5qExwnJJ6CoswXtZXQX7RZdcp+fConI/+5UXPiB+CM
         xj2QxieWrzezc7+7raWpVAaY48CYuXDmeST4apmg=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DAD54608CE;
        Mon, 11 Jun 2018 17:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528738016;
        bh=lkGZB3BnFB6IEecI0CY1KjJOh5A41notD6TKGMR8eOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CPsmv95EZspXxJT61iFaD5CQYQT7/9sxuG6JDKokhBAxxnMSbRN9UGs5aOZHdBQUt
         KCh3M9PHE50HSYPJ2+tgbyyKND45K+ZL/WnkSLAsrVxgAr3ORNQpW7A2CSJmuS9BMA
         g42dEe4tC3E/CXjedff9+bPePrFT0y+aqhOYgEQk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DAD54608CE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   Raju P L S S S N <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH v10 07/10] drivers: qcom: rpmh: cache sleep/wake state requests
Date:   Mon, 11 Jun 2018 22:55:46 +0530
Message-Id: <1528737949-17495-8-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1528737949-17495-1-git-send-email-rplsssn@codeaurora.org>
References: <1528737949-17495-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lina Iyer <ilina@codeaurora.org>

Active state requests are sent immediately to the RSC controller, while
sleep and wake state requests are cached in this driver to avoid taxing
the RSC controller repeatedly. The cached values will be sent to the
controller when the rpmh_flush() is called.

Generally, flushing is a system PM activity and may be called from the
system PM drivers when the system is entering suspend or deeper sleep
modes during cpuidle.

Also allow invalidating the cached requests, so they may be re-populated
again.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
Reviewed-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v10:
	- Add EXPORT_SYMBOL

Changes in v9:
	- Remove EXPORT_SYMBOL
	- Rename lock to cache_lock
	- Improve comments

Changes in v6:
	- replace rpmh_client with device *

Changes in v4:
	- remove locking for ->dirty in invalidate
	- fix send_single
Changes in v3:
	- Remove locking for flush function
	- Improve comments
---
 drivers/soc/qcom/rpmh.c | 217 ++++++++++++++++++++++++++++++++++++++++++++++--
 include/soc/qcom/rpmh.h |  11 +++
 2 files changed, 223 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index f7bece0..a99194f 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -8,10 +8,12 @@
 #include <linux/interrupt.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/wait.h>
 
@@ -35,6 +37,21 @@
 	}
 
 /**
+ * struct cache_req: the request object for caching
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
+/**
  * struct rpmh_request: the message to be sent to rpmh-rsc
  *
  * @msg: the request
@@ -55,9 +72,15 @@ struct rpmh_request {
  * struct rpmh_ctrlr: our representation of the controller
  *
  * @drv: the controller instance
+ * @cache: the list of cached requests
+ * @cache_lock: synchronize access to the cache data
+ * @dirty: was the cache updated since flush
  */
 struct rpmh_ctrlr {
 	struct rsc_drv *drv;
+	struct list_head cache;
+	spinlock_t cache_lock;
+	bool dirty;
 };
 
 static struct rpmh_ctrlr rpmh_rsc[RPMH_MAX_CTRLR];
@@ -80,6 +103,8 @@ static struct rpmh_ctrlr *get_rpmh_ctrlr(const struct device *dev)
 	for (i = 0; i < RPMH_MAX_CTRLR; i++) {
 		if (!rpmh_rsc[i].drv) {
 			rpmh_rsc[i].drv = drv;
+			spin_lock_init(&rpmh_rsc[i].cache_lock);
+			INIT_LIST_HEAD(&rpmh_rsc[i].cache);
 			break;
 		}
 	}
@@ -109,29 +134,109 @@ void rpmh_tx_done(const struct tcs_request *msg, int r)
 }
 EXPORT_SYMBOL(rpmh_tx_done);
 
+static struct cache_req *__find_req(struct rpmh_ctrlr *ctrlr, u32 addr)
+{
+	struct cache_req *p, *req = NULL;
+
+	list_for_each_entry(p, &ctrlr->cache, list) {
+		if (p->addr == addr) {
+			req = p;
+			break;
+		}
+	}
+
+	return req;
+}
+
+static struct cache_req *cache_rpm_request(struct rpmh_ctrlr *ctrlr,
+					   enum rpmh_state state,
+					   struct tcs_cmd *cmd)
+{
+	struct cache_req *req;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ctrlr->cache_lock, flags);
+	req = __find_req(ctrlr, cmd->addr);
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
+	list_add_tail(&req->list, &ctrlr->cache);
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
+	ctrlr->dirty = true;
+unlock:
+	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
+
+	return req;
+}
+
 /**
- * __rpmh_write: send the RPMH request
+ * __rpmh_write: Cache and send the RPMH request
  *
  * @dev: The device making the request
  * @state: Active/Sleep request type
  * @rpm_msg: The data that needs to be sent (cmds).
+ *
+ * Cache the RPMH request and send if the state is ACTIVE_ONLY.
+ * SLEEP/WAKE_ONLY requests are not sent to the controller at
+ * this time. Use rpmh_flush() to send them to the controller.
  */
 static int __rpmh_write(const struct device *dev, enum rpmh_state state,
 			struct rpmh_request *rpm_msg)
 {
 	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
+	int ret = -EINVAL;
+	struct cache_req *req;
+	int i;
 
 	if (IS_ERR(ctrlr))
 		return PTR_ERR(ctrlr);
 
 	rpm_msg->msg.state = state;
 
-	if (state != RPMH_ACTIVE_ONLY_STATE)
-		return -EINVAL;
+	/* Cache the request in our store and link the payload */
+	for (i = 0; i < rpm_msg->msg.num_cmds; i++) {
+		req = cache_rpm_request(ctrlr, state, &rpm_msg->msg.cmds[i]);
+		if (IS_ERR(req))
+			return PTR_ERR(req);
+	}
+
+	rpm_msg->msg.state = state;
 
-	WARN_ON(irqs_disabled());
+	if (state == RPMH_ACTIVE_ONLY_STATE) {
+		WARN_ON(irqs_disabled());
+		ret = rpmh_rsc_send_data(ctrlr->drv, &rpm_msg->msg);
+	} else {
+		ret = rpmh_rsc_write_ctrl_data(ctrlr->drv, &rpm_msg->msg);
+		/* Clean up our call by spoofing tx_done */
+		rpmh_tx_done(&rpm_msg->msg, ret);
+	}
 
-	return rpmh_rsc_send_data(ctrlr->drv, &rpm_msg->msg);
+	return ret;
 }
 
 /**
@@ -166,3 +271,105 @@ int rpmh_write(const struct device *dev, enum rpmh_state state,
 	return (ret > 0) ? 0 : -ETIMEDOUT;
 }
 EXPORT_SYMBOL(rpmh_write);
+
+static int is_req_valid(struct cache_req *req)
+{
+	return (req->sleep_val != UINT_MAX &&
+		req->wake_val != UINT_MAX &&
+		req->sleep_val != req->wake_val);
+}
+
+static int send_single(const struct device *dev, enum rpmh_state state,
+		       u32 addr, u32 data)
+{
+	DEFINE_RPMH_MSG_ONSTACK(dev, state, NULL, rpm_msg);
+	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
+
+	if (IS_ERR(ctrlr))
+		return PTR_ERR(ctrlr);
+
+	/* Wake sets are always complete and sleep sets are not */
+	rpm_msg.msg.wait_for_compl = (state == RPMH_WAKE_ONLY_STATE);
+	rpm_msg.cmd[0].addr = addr;
+	rpm_msg.cmd[0].data = data;
+	rpm_msg.msg.num_cmds = 1;
+
+	return rpmh_rsc_write_ctrl_data(ctrlr->drv, &rpm_msg.msg);
+}
+
+/**
+ * rpmh_flush: Flushes the buffered active and sleep sets to TCS
+ *
+ * @dev: The device making the request
+ *
+ * Return: -EBUSY if the controller is busy, probably waiting on a response
+ * to a RPMH request sent earlier.
+ *
+ * This function is always called from the sleep code from the last CPU
+ * that is powering down the entire system. Since no other RPMH API would be
+ * executing at this time, it is safe to run lockless.
+ */
+int rpmh_flush(const struct device *dev)
+{
+	struct cache_req *p;
+	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
+	int ret;
+
+	if (IS_ERR(ctrlr))
+		return PTR_ERR(ctrlr);
+
+	if (!ctrlr->dirty) {
+		pr_debug("Skipping flush, TCS has latest data.\n");
+		return 0;
+	}
+
+	/*
+	 * Nobody else should be calling this function other than system PM,
+	 * hence we can run without locks.
+	 */
+	list_for_each_entry(p, &ctrlr->cache, list) {
+		if (!is_req_valid(p)) {
+			pr_debug("%s: skipping RPMH req: a:%#x s:%#x w:%#x",
+				 __func__, p->addr, p->sleep_val, p->wake_val);
+			continue;
+		}
+		ret = send_single(dev, RPMH_SLEEP_STATE, p->addr, p->sleep_val);
+		if (ret)
+			return ret;
+		ret = send_single(dev, RPMH_WAKE_ONLY_STATE,
+				  p->addr, p->wake_val);
+		if (ret)
+			return ret;
+	}
+
+	ctrlr->dirty = false;
+
+	return 0;
+}
+EXPORT_SYMBOL(rpmh_flush);
+
+/**
+ * rpmh_invalidate: Invalidate all sleep and active sets
+ * sets.
+ *
+ * @dev: The device making the request
+ *
+ * Invalidate the sleep and active values in the TCS blocks.
+ */
+int rpmh_invalidate(const struct device *dev)
+{
+	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
+	int ret;
+
+	if (IS_ERR(ctrlr))
+		return PTR_ERR(ctrlr);
+
+	ctrlr->dirty = true;
+
+	do {
+		ret = rpmh_rsc_invalidate(ctrlr->drv);
+	} while (ret == -EAGAIN);
+
+	return ret;
+}
+EXPORT_SYMBOL(rpmh_invalidate);
diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
index c1d0f90..42e62a0 100644
--- a/include/soc/qcom/rpmh.h
+++ b/include/soc/qcom/rpmh.h
@@ -14,12 +14,23 @@
 int rpmh_write(const struct device *dev, enum rpmh_state state,
 	       const struct tcs_cmd *cmd, u32 n);
 
+int rpmh_flush(const struct device *dev);
+
+int rpmh_invalidate(const struct device *dev);
+
 #else
 
 static inline int rpmh_write(const struct device *dev, enum rpmh_state state,
 			     const struct tcs_cmd *cmd, u32 n)
 { return -ENODEV; }
 
+
+static inline int rpmh_flush(const struct device *dev)
+{ return -ENODEV; }
+
+static inline int rpmh_invalidate(const struct device *dev)
+{ return -ENODEV; }
+
 #endif /* CONFIG_QCOM_RPMH */
 
 #endif /* __SOC_QCOM_RPMH_H__ */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

