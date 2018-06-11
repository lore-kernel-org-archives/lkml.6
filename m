Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIM_INVALID autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 80FE1C5CFF0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3DC20660
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hiC6S314";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hVAM0Ua4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C3DC20660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934371AbeFKR1n (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:27:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52846 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934294AbeFKR1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:27:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F21F1608CE; Mon, 11 Jun 2018 17:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528738021;
        bh=iA5daY0TMFvQHYdypTv1GDqQpzK+Yid1N49LqMJCqII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hiC6S314zMT1etYo5UiYdfX9vOAs4zxHr99nJHAFk2CscF6TRZp67SlJ1th9sgH8h
         H+TTJm5/4/ODS77x9EKsJnLnV66zU8Atgexj2Gd+K4zcuDp1um21yJBvORcf/uGAef
         F2BQ/4oJ3yBxp8mI78HlNp1MvDph7CidePIh07Dg=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AA494607E4;
        Mon, 11 Jun 2018 17:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528738020;
        bh=iA5daY0TMFvQHYdypTv1GDqQpzK+Yid1N49LqMJCqII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hVAM0Ua42+j+rzZzFmwEoHm7fL0ioz4BySSD7CCXDT6xWNYBVDSEF6wz6uGjNj1RG
         Bf9QakdLuFJrwUD0rwUFYjw7OkjNcpB9eEI9sfUEbsciboCq+IFj3xBiT7FZUTIYzq
         J2MqFG0NAvNaSZnqG+uXv8wTpk4vcuRBhSWys2OU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AA494607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   Raju P L S S S N <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH v10 08/10] drivers: qcom: rpmh: allow requests to be sent asynchronously
Date:   Mon, 11 Jun 2018 22:55:47 +0530
Message-Id: <1528737949-17495-9-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1528737949-17495-1-git-send-email-rplsssn@codeaurora.org>
References: <1528737949-17495-1-git-send-email-rplsssn@codeaurora.org>
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
 drivers/soc/qcom/rpmh.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/soc/qcom/rpmh.h |  7 +++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index a99194f..e380e5a 100644
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
@@ -131,6 +134,9 @@ void rpmh_tx_done(const struct tcs_request *msg, int r)
 	/* Signal the blocking thread we are done */
 	if (compl)
 		complete(compl);
+
+	if (rpm_msg->needs_free)
+		kfree(rpm_msg);
 }
 EXPORT_SYMBOL(rpmh_tx_done);
 
@@ -239,6 +245,53 @@ static int __rpmh_write(const struct device *dev, enum rpmh_state state,
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

