Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4351C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618F720836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mhHYOTM+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Kgypoi5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618F720836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966367AbeFSNMX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:12:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34632 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937989AbeFSNMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:12:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E7A2560714; Tue, 19 Jun 2018 13:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529413939;
        bh=8Jtp6Nep+NrIi4E4WFqUnaUfl5QUaN4i1VrIOFWxPyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mhHYOTM+UA4KnX2RKz6IDYTIdl26LcGNJZsCrXVUe5Ko4K6jWGDEBhQQUSZbsi9BS
         XeNIM0vsEQS4D4eI1R8m6oZk+hTHpvf///AAj4CVmhxnfWB/NIoh2TRFqBbpUBAtrU
         06sGHxwyYLpr/RnAJYuNP+PluqOgqsS44lJAQsvE=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B60FA60B10;
        Tue, 19 Jun 2018 13:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529413938;
        bh=8Jtp6Nep+NrIi4E4WFqUnaUfl5QUaN4i1VrIOFWxPyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kgypoi5+wP7EZPjbpYOO3pFCsUsHOPTwHj6bvrD7Fs9XUaBB5/ijNaAfsDwYq6p8V
         1DrwhjamCeGJ4Ns+8IxXXbn8bL1L+dDNsGVrdY8T2Z9nLWg+y3ssiPj4202eSEE/Bw
         KEhMGbB5Tbg77IpydWnLFB5iwd7gAO0hdkY8M0Q0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B60FA60B10
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   Raju P L S S S N <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH v12 08/10] drivers: qcom: rpmh: allow requests to be sent asynchronously
Date:   Tue, 19 Jun 2018 18:41:31 +0530
Message-Id: <1529413893-5520-9-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529413893-5520-1-git-send-email-rplsssn@codeaurora.org>
References: <1529413893-5520-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
---

Changes in v10:
	- Add EXPORT_SYMBOL
Changes in v9:
	- Remove EXPORT_SYMBOL
	- check to free dynamically allocated request object
	- free request object after notifying completion
Changes in v6:
	- replace rpmh_client with device *
---
 drivers/soc/qcom/rpmh-internal.h |  2 ++
 drivers/soc/qcom/rpmh.c          | 51 ++++++++++++++++++++++++++++++++++++++++
 include/soc/qcom/rpmh.h          |  7 ++++++
 3 files changed, 60 insertions(+)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index 101145c..6a8a4b7 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -54,6 +54,7 @@ struct tcs_group {
  * @completion: triggered when request is done
  * @dev: the device making the request
  * @err: err return from the controller
+ * @needs_free: check to free dynamically allocated request object
  */
 struct rpmh_request {
 	struct tcs_request msg;
@@ -61,6 +62,7 @@ struct rpmh_request {
 	struct completion *completion;
 	const struct device *dev;
 	int err;
+	bool needs_free;
 };
 
 /**
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index c355ba1..1e3d348 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -34,6 +34,7 @@
 		.cmd = { { 0 } },			\
 		.completion = q,			\
 		.dev = dev,				\
+		.needs_free = false,				\
 	}
 
 #define ctrlr_to_drv(ctrlr) container_of(ctrlr, struct rsc_drv, client)
@@ -75,6 +76,9 @@ void rpmh_tx_done(const struct tcs_request *msg, int r)
 	/* Signal the blocking thread we are done */
 	if (compl)
 		complete(compl);
+
+	if (rpm_msg->needs_free)
+		kfree(rpm_msg);
 }
 
 static struct cache_req *__find_req(struct rpmh_ctrlr *ctrlr, u32 addr)
@@ -180,6 +184,53 @@ static int __rpmh_write(const struct device *dev, enum rpmh_state state,
 	return ret;
 }
 
+static int __fill_rpmh_msg(struct rpmh_request *req, enum rpmh_state state,
+		const struct tcs_cmd *cmd, u32 n)
+{
+	if (!cmd || !n || n > MAX_RPMH_PAYLOAD)
+		return -EINVAL;
+
+	memcpy(req->cmd, cmd, n * sizeof(*cmd));
+
+	req->msg.state = state;
+	req->msg.cmds = req->cmd;
+	req->msg.num_cmds = n;
+
+	return 0;
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
+	int ret;
+
+	rpm_msg = kzalloc(sizeof(*rpm_msg), GFP_ATOMIC);
+	if (!rpm_msg)
+		return -ENOMEM;
+	rpm_msg->needs_free = true;
+
+	ret = __fill_rpmh_msg(rpm_msg, state, cmd, n);
+	if (ret) {
+		kfree(rpm_msg);
+		return ret;
+	}
+
+	return __rpmh_write(dev, state, rpm_msg);
+}
+EXPORT_SYMBOL(rpmh_write_async);
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

