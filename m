Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D120C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E46DC2089B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lTVQPeEY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="naqNGS6i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E46DC2089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389350AbeG0L0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:26:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45446 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730717AbeG0L0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:26:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6E30760B81; Fri, 27 Jul 2018 10:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532685910;
        bh=1GVpPZwuOFhg8HYL/RGEWA5mK4KpgXhYR4iqx29KKfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lTVQPeEYPqre1mwoFP+D29Qra+KY4j4YsLZkZ+9jFXLahymPz0rUl38oEoqtXzzxb
         ok7f4NuazVmqfytUhWAbxp21ccnDfNSLEPyeaoecbaqDPTHO0PvOphQ5J/Cur+b76s
         kEPErp2+6MmiL+d6egYXOuxJZO8epaJWwGT4gUEE=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 356F160B15;
        Fri, 27 Jul 2018 10:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532685909;
        bh=1GVpPZwuOFhg8HYL/RGEWA5mK4KpgXhYR4iqx29KKfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=naqNGS6iZHRZMGS192JimhXdvIZOWphBpdPB5yHmPCRB2vKuEqE/Is5xYqUsfhH3G
         H5JDlR+hRDGdP7BEILe21NNOSyunnTdmoUOSF/yPqMg69foqkLk9PcGxhvRdN73uTp
         0ELg6AsIh7BR7VTDCCtOk+ZBRzarbH4EWcyhmcHw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 356F160B15
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   Raju P L S S S N <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH v2 3/6] drivers: qcom: rpmh: disallow active requests in solver mode
Date:   Fri, 27 Jul 2018 15:34:46 +0530
Message-Id: <1532685889-31345-4-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532685889-31345-1-git-send-email-rplsssn@codeaurora.org>
References: <1532685889-31345-1-git-send-email-rplsssn@codeaurora.org>
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

