Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A960C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3D4206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="H9NIyuYX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Os9qliq3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbfAHKYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:24:19 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33350 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfAHKYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:24:17 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 687D660397; Tue,  8 Jan 2019 10:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546943056;
        bh=nor+xckfCIYJTKWI40/NhrGwtaEQlNpo9Z9SeVuo8ng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H9NIyuYXmc8xfyFenFBGYv9a5GUHu1Uzy57Y7pjAtIoTFpOMzb74TfTMQzl2wF+Zp
         aVl47tAvXNYUX7GFRUIfHAzEhfdKG8mDq+9LibjOu3tKgQs2aDPHH8gOdhaDNzED+E
         8hWGYYk2lt1C64RALsgYsBWH8m4EgzakNzM598p8=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2734D601EA;
        Tue,  8 Jan 2019 10:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546943055;
        bh=nor+xckfCIYJTKWI40/NhrGwtaEQlNpo9Z9SeVuo8ng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Os9qliq3DpNWDOiXU0p8KLM/Z9u0Fllrqx6dYBkARizNHbvageiwOEhufnVlijlco
         06VrJ7Xa+tJ2YIdBrMhdZugW6q1Fyo5yYYB7gACyqXzniTDUdl8C86XYMdDmX5SZaP
         7PCyMpmZjnHzwMK6QKzhYvSmNK5ScPS2xWVpkVqI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2734D601EA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org
Cc:     robh+dt@kernel.org, andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        ohad@wizery.com, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org, dianders@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v3 3/3] remoteproc: qcom: Wait for shutdown-ack/ind on sysmon shutdown
Date:   Tue,  8 Jan 2019 15:53:44 +0530
Message-Id: <20190108102344.28451-3-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108102344.28451-1-sibis@codeaurora.org>
References: <20190108102344.28451-1-sibis@codeaurora.org>
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

v2:
   * Correct the shutdown-irq wait time to 10 * HZ

 drivers/remoteproc/qcom_sysmon.c | 42 +++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_sysmon.c b/drivers/remoteproc/qcom_sysmon.c
index b17727dfc271..19b732e1427d 100644
--- a/drivers/remoteproc/qcom_sysmon.c
+++ b/drivers/remoteproc/qcom_sysmon.c
@@ -37,6 +37,7 @@ struct qcom_sysmon {
 
 	struct rpmsg_endpoint *ept;
 	struct completion comp;
+	struct completion ind_comp;
 	struct completion shutdown_comp;
 	struct mutex lock;
 
@@ -141,6 +142,7 @@ static int sysmon_callback(struct rpmsg_device *rpdev, void *data, int count,
 }
 
 #define SSCTL_SHUTDOWN_REQ		0x21
+#define SSCTL_SHUTDOWN_READY_IND	0x21
 #define SSCTL_SUBSYS_EVENT_REQ		0x23
 
 #define SSCTL_MAX_MSG_LEN		7
@@ -256,6 +258,29 @@ static struct qmi_elem_info ssctl_subsys_event_resp_ei[] = {
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
@@ -266,6 +291,8 @@ static void ssctl_request_shutdown(struct qcom_sysmon *sysmon)
 	struct qmi_txn txn;
 	int ret;
 
+	reinit_completion(&sysmon->ind_comp);
+	reinit_completion(&sysmon->shutdown_comp);
 	ret = qmi_txn_init(&sysmon->qmi, &txn, ssctl_shutdown_resp_ei, &resp);
 	if (ret < 0) {
 		dev_err(sysmon->dev, "failed to allocate QMI txn\n");
@@ -287,6 +314,17 @@ static void ssctl_request_shutdown(struct qcom_sysmon *sysmon)
 		dev_err(sysmon->dev, "shutdown request failed\n");
 	else
 		dev_dbg(sysmon->dev, "shutdown request completed\n");
+
+	if (sysmon->shutdown_irq > 0) {
+		ret = wait_for_completion_timeout(&sysmon->shutdown_comp,
+						  10 * HZ);
+		if (!ret) {
+			ret = try_wait_for_completion(&sysmon->ind_comp);
+			if (!ret)
+				dev_err(sysmon->dev,
+					"timeout waiting for shutdown ack\n");
+		}
+	}
 }
 
 /**
@@ -473,6 +511,7 @@ int qcom_add_sysmon_subdev(struct rproc *rproc,
 	sysmon->ssctl_instance = ssctl_instance;
 
 	init_completion(&sysmon->comp);
+	init_completion(&sysmon->ind_comp);
 	init_completion(&sysmon->shutdown_comp);
 	mutex_init(&sysmon->lock);
 
@@ -497,7 +536,8 @@ int qcom_add_sysmon_subdev(struct rproc *rproc,
 		}
 	}
 
-	ret = qmi_handle_init(&sysmon->qmi, SSCTL_MAX_MSG_LEN, &ssctl_ops, NULL);
+	ret = qmi_handle_init(&sysmon->qmi, SSCTL_MAX_MSG_LEN, &ssctl_ops,
+			      qmi_indication_handler);
 	if (ret < 0) {
 		dev_err(sysmon->dev, "failed to initialize qmi handle\n");
 		kfree(sysmon);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

