Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3634C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A283420671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="L7ADtE5T";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="L7ADtE5T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A283420671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbeGSKCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 06:02:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40260 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727449AbeGSKCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 06:02:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CF855607C6; Thu, 19 Jul 2018 09:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531991998;
        bh=1GVpPZwuOFhg8HYL/RGEWA5mK4KpgXhYR4iqx29KKfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L7ADtE5TEghMl3m1XN0joOy7QetD13YROgVzaN94x/bhqplNgWLFPCuYEgA/vyEXY
         6NoEVI+/brNgxxTiyYTzCktdamSOm99IbF7oUvHDzk7NZ8EZGnagbz51U4BnTJR3Sn
         2GuoyBoH2Oo/SuM++TDDON4oXKanXyOjsSLPCfiY=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B5BCE60B7E;
        Thu, 19 Jul 2018 09:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531991998;
        bh=1GVpPZwuOFhg8HYL/RGEWA5mK4KpgXhYR4iqx29KKfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L7ADtE5TEghMl3m1XN0joOy7QetD13YROgVzaN94x/bhqplNgWLFPCuYEgA/vyEXY
         6NoEVI+/brNgxxTiyYTzCktdamSOm99IbF7oUvHDzk7NZ8EZGnagbz51U4BnTJR3Sn
         2GuoyBoH2Oo/SuM++TDDON4oXKanXyOjsSLPCfiY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B5BCE60B7E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   Raju P L S S S N <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH 3/6] drivers: qcom: rpmh: disallow active requests in solver mode
Date:   Thu, 19 Jul 2018 14:49:32 +0530
Message-Id: <1531991975-23665-4-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1531991975-23665-1-git-send-email-rplsssn@codeaurora.org>
References: <1531991975-23665-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lina Iyer <ilina@codeaurora.org>

Controllers may be in 'solver' state, where they could be in autonomous
mode executing low power modes for their hardware and as such are not
available for sending active votes. Device driver may notify RPMH API
that the controller is in solver mode and when in such mode, disallow
requests from platform drivers for state change using the RSC.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 drivers/soc/qcom/rpmh-internal.h |  2 ++
 drivers/soc/qcom/rpmh.c          | 59 ++++++++++++++++++++++++++++++++++++++++
 include/soc/qcom/rpmh.h          |  5 ++++
 3 files changed, 66 insertions(+)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index 4ff43bf..6cd2f78 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -72,12 +72,14 @@ struct rpmh_request {
  * @cache_lock: synchronize access to the cache data
  * @dirty: was the cache updated since flush
  * @batch_cache: Cache sleep and wake requests sent as batch
+ * @in_solver_mode: Controller is busy in solver mode
  */
 struct rpmh_ctrlr {
 	struct list_head cache;
 	spinlock_t cache_lock;
 	bool dirty;
 	struct list_head batch_cache;
+	bool in_solver_mode;
 };
 
 /**
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 2382276..0d276fd 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -5,6 +5,7 @@
 
 #include <linux/atomic.h>
 #include <linux/bug.h>
+#include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
@@ -75,6 +76,50 @@ static struct rpmh_ctrlr *get_rpmh_ctrlr(const struct device *dev)
 	return &drv->client;
 }
 
+static int check_ctrlr_state(struct rpmh_ctrlr *ctrlr, enum rpmh_state state)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	/* Do not allow setting active votes when in solver mode */
+	spin_lock_irqsave(&ctrlr->cache_lock, flags);
+	if (ctrlr->in_solver_mode && state == RPMH_ACTIVE_ONLY_STATE)
+		ret = -EBUSY;
+	spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
+
+	return ret;
+}
+
+/**
+ * rpmh_mode_solver_set: Indicate that the RSC controller hardware has
+ * been configured to be in solver mode
+ *
+ * @dev: the device making the request
+ * @enable: Boolean value indicating if the controller is in solver mode.
+ *
+ * When solver mode is enabled, passthru API will not be able to send wake
+ * votes, just awake and active votes.
+ */
+int rpmh_mode_solver_set(const struct device *dev, bool enable)
+{
+	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
+	unsigned long flags;
+
+	for (;;) {
+		spin_lock_irqsave(&ctrlr->cache_lock, flags);
+		if (rpmh_rsc_ctrlr_is_idle(ctrlr_to_drv(ctrlr))) {
+			ctrlr->in_solver_mode = enable;
+			spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
+			break;
+		}
+		spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
+		udelay(10);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(rpmh_mode_solver_set);
+
 void rpmh_tx_done(const struct tcs_request *msg, int r)
 {
 	struct rpmh_request *rpm_msg = container_of(msg, struct rpmh_request,
@@ -231,8 +276,13 @@ int rpmh_write_async(const struct device *dev, enum rpmh_state state,
 		     const struct tcs_cmd *cmd, u32 n)
 {
 	struct rpmh_request *rpm_msg;
+	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
 	int ret;
 
+	ret = check_ctrlr_state(ctrlr, state);
+	if (ret)
+		return ret;
+
 	rpm_msg = kzalloc(sizeof(*rpm_msg), GFP_ATOMIC);
 	if (!rpm_msg)
 		return -ENOMEM;
@@ -263,11 +313,16 @@ int rpmh_write(const struct device *dev, enum rpmh_state state,
 {
 	DECLARE_COMPLETION_ONSTACK(compl);
 	DEFINE_RPMH_MSG_ONSTACK(dev, state, &compl, rpm_msg);
+	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
 	int ret;
 
 	if (!cmd || !n || n > MAX_RPMH_PAYLOAD)
 		return -EINVAL;
 
+	ret = check_ctrlr_state(ctrlr, state);
+	if (ret)
+		return ret;
+
 	memcpy(rpm_msg.cmd, cmd, n * sizeof(*cmd));
 	rpm_msg.msg.num_cmds = n;
 
@@ -357,6 +412,10 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
 	if (!cmd || !n)
 		return -EINVAL;
 
+	ret = check_ctrlr_state(ctrlr, state);
+	if (ret)
+		return ret;
+
 	while (n[count] > 0)
 		count++;
 	if (!count)
diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
index d445322..018788d 100644
--- a/include/soc/qcom/rpmh.h
+++ b/include/soc/qcom/rpmh.h
@@ -26,6 +26,8 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
 
 int rpmh_ctrlr_idle(const struct device *dev);
 
+int rpmh_mode_solver_set(const struct device *dev, bool enable);
+
 #else
 
 static inline int rpmh_write(const struct device *dev, enum rpmh_state state,
@@ -51,6 +53,9 @@ static inline int rpmh_invalidate(const struct device *dev)
 static inline int rpmh_ctrlr_idle(const struct device *dev)
 { return -ENODEV; }
 
+static inline int rpmh_mode_solver_set(const struct device *dev, bool enable)
+{ return -ENODEV; }
+
 #endif /* CONFIG_QCOM_RPMH */
 
 #endif /* __SOC_QCOM_RPMH_H__ */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

