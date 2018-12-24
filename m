Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36D1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1EA321773
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oHn9g9oP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EqLOjHEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeLXItP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 03:49:15 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:47006 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbeLXItO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 03:49:14 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0CF1F608D2; Mon, 24 Dec 2018 08:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545641353;
        bh=dqk9ZmeSnTEd7cXIRnrDYU41Pykk/FfpZPX357i4/ys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oHn9g9oPTxQ9ok0SIHJ/x2w8aPWUJa3Eu/bzpkueSwhIODCi7QeH2Qh3yPKXiAzTe
         nRbZr9oMJA8h+la7KI05fQZpTc3qGJbST9levXsjW/n+asT9AvaV+qSF0VNmMGEsGL
         19wZLekFE/MjUPA1whzflcDoNS4dCoDDkPlaKnr8=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0191C6081E;
        Mon, 24 Dec 2018 08:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545641350;
        bh=dqk9ZmeSnTEd7cXIRnrDYU41Pykk/FfpZPX357i4/ys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EqLOjHEvGb/2qTnZcmLtI/ZO7BsJuWkJAkGpbqVkXV4KU//Y3qmXO6T8D7LumAiYQ
         HaFXJJX+V/bkyV9bZl+BlkuOhrqLa+w5ygc3HLu/3gNJhvgBqDguWOzQPda5+Mp1gA
         sqPfzH9iOxBk4OJ/lgOofSxwQFxzEttVCwwgdKFU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0191C6081E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        ohad@wizery.com, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org, dianders@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v2 3/4] remoteproc: qcom: Wait for shutdown-ack/ind on sysmon shutdown
Date:   Mon, 24 Dec 2018 14:18:24 +0530
Message-Id: <20181224084824.25193-3-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181224084824.25193-1-sibis@codeaurora.org>
References: <20181224084824.25193-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After sending a sysmon shutdown request to the SSCTL service on the
subsystem, wait for the service to send shutdown-ack interrupt or
an indication message to signal the completion of graceful shutdown.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/remoteproc/qcom_sysmon.c | 40 +++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_sysmon.c b/drivers/remoteproc/qcom_sysmon.c
index c0d6ee8de995..0da83638ca99 100644
--- a/drivers/remoteproc/qcom_sysmon.c
+++ b/drivers/remoteproc/qcom_sysmon.c
@@ -36,6 +36,7 @@ struct qcom_sysmon {
 
 	struct rpmsg_endpoint *ept;
 	struct completion comp;
+	struct completion ind_comp;
 	struct mutex lock;
 
 	bool ssr_ack;
@@ -139,6 +140,7 @@ static int sysmon_callback(struct rpmsg_device *rpdev, void *data, int count,
 }
 
 #define SSCTL_SHUTDOWN_REQ		0x21
+#define SSCTL_SHUTDOWN_READY_IND	0x21
 #define SSCTL_SUBSYS_EVENT_REQ		0x23
 
 #define SSCTL_MAX_MSG_LEN		7
@@ -254,6 +256,29 @@ static struct qmi_elem_info ssctl_subsys_event_resp_ei[] = {
 	{}
 };
 
+static struct qmi_elem_info ssctl_shutdown_ind_ei[] = {
+	{}
+};
+
+static void sysmon_ind_cb(struct qmi_handle *qmi, struct sockaddr_qrtr *sq,
+			  struct qmi_txn *txn, const void *data)
+{
+	struct qcom_sysmon *sysmon = container_of(qmi, struct qcom_sysmon, qmi);
+
+	complete(&sysmon->ind_comp);
+}
+
+static struct qmi_msg_handler qmi_indication_handler[] = {
+	{
+		.type = QMI_INDICATION,
+		.msg_id = SSCTL_SHUTDOWN_READY_IND,
+		.ei = ssctl_shutdown_ind_ei,
+		.decoded_size = 0,
+		.fn = sysmon_ind_cb
+	},
+	{}
+};
+
 /**
  * ssctl_request_shutdown() - request shutdown via SSCTL QMI service
  * @sysmon:	sysmon context
@@ -264,6 +289,7 @@ static void ssctl_request_shutdown(struct qcom_sysmon *sysmon)
 	struct qmi_txn txn;
 	int ret;
 
+	reinit_completion(&sysmon->ind_comp);
 	ret = qmi_txn_init(&sysmon->qmi, &txn, ssctl_shutdown_resp_ei, &resp);
 	if (ret < 0) {
 		dev_err(sysmon->dev, "failed to allocate QMI txn\n");
@@ -285,6 +311,16 @@ static void ssctl_request_shutdown(struct qcom_sysmon *sysmon)
 		dev_err(sysmon->dev, "shutdown request failed\n");
 	else
 		dev_dbg(sysmon->dev, "shutdown request completed\n");
+
+	if (sysmon->q6v5) {
+		ret = qcom_q6v5_wait_for_shutdown(sysmon->q6v5, 10 * HZ);
+		if (ret) {
+			ret = try_wait_for_completion(&sysmon->ind_comp);
+			if (!ret)
+				dev_err(sysmon->dev,
+					"timeout waiting for shutdown ack\n");
+		}
+	}
 }
 
 /**
@@ -462,9 +498,11 @@ struct qcom_sysmon *qcom_add_sysmon_subdev(struct rproc *rproc,
 	sysmon->q6v5 = q6v5;
 
 	init_completion(&sysmon->comp);
+	init_completion(&sysmon->ind_comp);
 	mutex_init(&sysmon->lock);
 
-	ret = qmi_handle_init(&sysmon->qmi, SSCTL_MAX_MSG_LEN, &ssctl_ops, NULL);
+	ret = qmi_handle_init(&sysmon->qmi, SSCTL_MAX_MSG_LEN, &ssctl_ops,
+			      qmi_indication_handler);
 	if (ret < 0) {
 		dev_err(sysmon->dev, "failed to initialize qmi handle\n");
 		kfree(sysmon);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

