Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2AAC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D78121721
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="i6U4rhHp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="a4j6+WVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbeLXIsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 03:48:51 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46474 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbeLXIst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 03:48:49 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EED45608CC; Mon, 24 Dec 2018 08:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545641327;
        bh=0/pnXypPkAs/a8QKnBM+TOYo61LMcKhE8z48is6hAqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i6U4rhHpLTDxNPG7ddRErj2pwYmSeMXJIIVsAtf/j88XI7ocpeMSvnN2qP44hdzwI
         f65kUWOD/Ml1pUjnEgUamITde6tPdlsbKhIWL2bWtTLwC6A6KQifH88Bp/GFeDTWjl
         dDHdVjeNHRjOoC3MH1ASLZp627HHkYQc+6aVMNz8=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 05492608CC;
        Mon, 24 Dec 2018 08:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545641326;
        bh=0/pnXypPkAs/a8QKnBM+TOYo61LMcKhE8z48is6hAqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a4j6+WVk7T/ONpueQm5tT71UpixgrLj18ntsWKkAZ98qVpPyzD375eYrR5R7SHThD
         LeNcRtqf8q+VhXz2eWO9XKXbTL19ZGKRzH7ahqBZOSAu8Nz2LnaATxQ1Eg9Kbirdfo
         bK2adwu/KhFUDYYWVHDanmdPlpdDxliISP7kIvZY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 05492608CC
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
Subject: [PATCH v2 2/4] remoteproc: qcom: q6v5: Add shutdown-ack irq
Date:   Mon, 24 Dec 2018 14:18:22 +0530
Message-Id: <20181224084824.25193-2-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181224084824.25193-1-sibis@codeaurora.org>
References: <20181224084824.25193-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add shutdown-ack irq handling for Q6V5. This patch includes enabling
shutdown-ack irq on those Q6V5 instances with "has_shutdown_irq"
flag set and exposing Q6V5 state information to the sysmon instance
which is required to ascertain graceful shutdown completion.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---

 v2:
   Move shutdown-irq get to Q6V5 from sysmon to handle
   -EPROBE_DEFER cases
   Correct the shutdown-irq wait time to 10 * HZ

 drivers/remoteproc/qcom_common.h    |  7 ++--
 drivers/remoteproc/qcom_q6v5.c      | 53 +++++++++++++++++++++++++++++
 drivers/remoteproc/qcom_q6v5.h      |  5 +++
 drivers/remoteproc/qcom_q6v5_adsp.c |  3 +-
 drivers/remoteproc/qcom_q6v5_mss.c  |  3 +-
 drivers/remoteproc/qcom_q6v5_pas.c  |  3 +-
 drivers/remoteproc/qcom_sysmon.c    |  6 +++-
 drivers/remoteproc/qcom_wcnss.c     |  3 +-
 8 files changed, 76 insertions(+), 7 deletions(-)

diff --git a/drivers/remoteproc/qcom_common.h b/drivers/remoteproc/qcom_common.h
index 58de71e4781c..d938b09ad02c 100644
--- a/drivers/remoteproc/qcom_common.h
+++ b/drivers/remoteproc/qcom_common.h
@@ -7,6 +7,7 @@
 #include <linux/soc/qcom/qmi.h>
 
 struct qcom_sysmon;
+struct qcom_q6v5;
 
 struct qcom_rproc_glink {
 	struct rproc_subdev subdev;
@@ -45,12 +46,14 @@ void qcom_remove_ssr_subdev(struct rproc *rproc, struct qcom_rproc_ssr *ssr);
 #if IS_ENABLED(CONFIG_QCOM_SYSMON)
 struct qcom_sysmon *qcom_add_sysmon_subdev(struct rproc *rproc,
 					   const char *name,
-					   int ssctl_instance);
+					   int ssctl_instance,
+					   struct qcom_q6v5 *q6v5);
 void qcom_remove_sysmon_subdev(struct qcom_sysmon *sysmon);
 #else
 static inline struct qcom_sysmon *qcom_add_sysmon_subdev(struct rproc *rproc,
 							 const char *name,
-							 int ssctl_instance)
+							 int ssctl_instance,
+							 struct qcom_q6v5 *q6v5)
 {
 	return NULL;
 }
diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
index 0d33e3079f0d..a4c2ecae6a0f 100644
--- a/drivers/remoteproc/qcom_q6v5.c
+++ b/drivers/remoteproc/qcom_q6v5.c
@@ -25,6 +25,7 @@ int qcom_q6v5_prepare(struct qcom_q6v5 *q6v5)
 {
 	reinit_completion(&q6v5->start_done);
 	reinit_completion(&q6v5->stop_done);
+	reinit_completion(&q6v5->shutdown_done);
 
 	q6v5->running = true;
 	q6v5->handover_issued = false;
@@ -141,6 +142,35 @@ static irqreturn_t q6v5_stop_interrupt(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t q6v5_shutdown_interrupt(int irq, void *data)
+{
+	struct qcom_q6v5 *q6v5 = data;
+
+	complete(&q6v5->shutdown_done);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * qcom_q6v5_wait_for_shutdown() - wait for remote processor shutdown signal
+ * @q6v5:	reference to qcom_q6v5 context
+ * @timeout:	timeout to wait for the event, in jiffies
+ *
+ * Return: 0 on success, -ETIMEDOUT on timeout
+ */
+int qcom_q6v5_wait_for_shutdown(struct qcom_q6v5 *q6v5, int timeout)
+{
+	int ret;
+
+	if (!q6v5->has_shutdown_irq)
+		return 0;
+
+	ret = wait_for_completion_timeout(&q6v5->shutdown_done, timeout);
+
+	return !ret ? -ETIMEDOUT : 0;
+}
+EXPORT_SYMBOL_GPL(qcom_q6v5_wait_for_shutdown);
+
 /**
  * qcom_q6v5_request_stop() - request the remote processor to stop
  * @q6v5:	reference to qcom_q6v5 context
@@ -185,6 +215,7 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 
 	init_completion(&q6v5->start_done);
 	init_completion(&q6v5->stop_done);
+	init_completion(&q6v5->shutdown_done);
 
 	q6v5->wdog_irq = platform_get_irq_byname(pdev, "wdog");
 	if (q6v5->wdog_irq < 0) {
@@ -277,6 +308,28 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 		return ret;
 	}
 
+	if (q6v5->has_shutdown_irq) {
+		q6v5->shutdown_irq = platform_get_irq_byname(pdev,
+							     "shutdown-ack");
+		if (q6v5->shutdown_irq < 0) {
+			if (q6v5->shutdown_irq != -EPROBE_DEFER)
+				dev_err(&pdev->dev,
+					"failed to get shutdown-ack IRQ: %d\n",
+					q6v5->shutdown_irq);
+			return q6v5->shutdown_irq;
+		}
+
+		ret = devm_request_threaded_irq(&pdev->dev, q6v5->shutdown_irq,
+						NULL, q6v5_shutdown_interrupt,
+						IRQF_TRIGGER_RISING |
+						IRQF_ONESHOT,
+						"q6v5 shutdown", q6v5);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to acquire shutdown IRQ\n");
+			return ret;
+		}
+	}
+
 	q6v5->state = qcom_smem_state_get(&pdev->dev, "stop", &q6v5->stop_bit);
 	if (IS_ERR(q6v5->state)) {
 		dev_err(&pdev->dev, "failed to acquire stop state\n");
diff --git a/drivers/remoteproc/qcom_q6v5.h b/drivers/remoteproc/qcom_q6v5.h
index 7ac92c1e0f49..5cbaf2564c3a 100644
--- a/drivers/remoteproc/qcom_q6v5.h
+++ b/drivers/remoteproc/qcom_q6v5.h
@@ -21,11 +21,15 @@ struct qcom_q6v5 {
 	int ready_irq;
 	int handover_irq;
 	int stop_irq;
+	int shutdown_irq;
+
+	u8 has_shutdown_irq;
 
 	bool handover_issued;
 
 	struct completion start_done;
 	struct completion stop_done;
+	struct completion shutdown_done;
 
 	int crash_reason;
 
@@ -42,5 +46,6 @@ int qcom_q6v5_prepare(struct qcom_q6v5 *q6v5);
 int qcom_q6v5_unprepare(struct qcom_q6v5 *q6v5);
 int qcom_q6v5_request_stop(struct qcom_q6v5 *q6v5);
 int qcom_q6v5_wait_for_start(struct qcom_q6v5 *q6v5, int timeout);
+int qcom_q6v5_wait_for_shutdown(struct qcom_q6v5 *q6v5, int timeout);
 
 #endif
diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index 79374d1de311..5fc42d38a1cd 100644
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@ -438,7 +438,8 @@ static int adsp_probe(struct platform_device *pdev)
 	qcom_add_ssr_subdev(rproc, &adsp->ssr_subdev, desc->ssr_name);
 	adsp->sysmon = qcom_add_sysmon_subdev(rproc,
 					      desc->sysmon_name,
-					      desc->ssctl_id);
+					      desc->ssctl_id,
+					      &adsp->q6v5);
 
 	ret = rproc_add(rproc);
 	if (ret)
diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 01be7314e176..3bc2dec85928 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -1340,7 +1340,8 @@ static int q6v5_probe(struct platform_device *pdev)
 	qcom_add_glink_subdev(rproc, &qproc->glink_subdev);
 	qcom_add_smd_subdev(rproc, &qproc->smd_subdev);
 	qcom_add_ssr_subdev(rproc, &qproc->ssr_subdev, "mpss");
-	qproc->sysmon = qcom_add_sysmon_subdev(rproc, "modem", 0x12);
+	qproc->sysmon = qcom_add_sysmon_subdev(rproc, "modem", 0x12,
+					       &qproc->q6v5);
 
 	ret = rproc_add(rproc);
 	if (ret)
diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index b1e63fcd5fdf..920a39ea6609 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -303,7 +303,8 @@ static int adsp_probe(struct platform_device *pdev)
 	qcom_add_ssr_subdev(rproc, &adsp->ssr_subdev, desc->ssr_name);
 	adsp->sysmon = qcom_add_sysmon_subdev(rproc,
 					      desc->sysmon_name,
-					      desc->ssctl_id);
+					      desc->ssctl_id,
+					      &adsp->q6v5);
 
 	ret = rproc_add(rproc);
 	if (ret)
diff --git a/drivers/remoteproc/qcom_sysmon.c b/drivers/remoteproc/qcom_sysmon.c
index e976a602b015..c0d6ee8de995 100644
--- a/drivers/remoteproc/qcom_sysmon.c
+++ b/drivers/remoteproc/qcom_sysmon.c
@@ -14,12 +14,14 @@
 #include <linux/rpmsg.h>
 
 #include "qcom_common.h"
+#include "qcom_q6v5.h"
 
 static BLOCKING_NOTIFIER_HEAD(sysmon_notifiers);
 
 struct qcom_sysmon {
 	struct rproc_subdev subdev;
 	struct rproc *rproc;
+	struct qcom_q6v5 *q6v5;
 
 	struct list_head node;
 
@@ -442,7 +444,8 @@ static int sysmon_notify(struct notifier_block *nb, unsigned long event,
  */
 struct qcom_sysmon *qcom_add_sysmon_subdev(struct rproc *rproc,
 					   const char *name,
-					   int ssctl_instance)
+					   int ssctl_instance,
+					   struct qcom_q6v5 *q6v5)
 {
 	struct qcom_sysmon *sysmon;
 	int ret;
@@ -456,6 +459,7 @@ struct qcom_sysmon *qcom_add_sysmon_subdev(struct rproc *rproc,
 
 	sysmon->name = name;
 	sysmon->ssctl_instance = ssctl_instance;
+	sysmon->q6v5 = q6v5;
 
 	init_completion(&sysmon->comp);
 	mutex_init(&sysmon->lock);
diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
index b0e07e9f42d5..af13cade35da 100644
--- a/drivers/remoteproc/qcom_wcnss.c
+++ b/drivers/remoteproc/qcom_wcnss.c
@@ -552,7 +552,8 @@ static int wcnss_probe(struct platform_device *pdev)
 	}
 
 	qcom_add_smd_subdev(rproc, &wcnss->smd_subdev);
-	wcnss->sysmon = qcom_add_sysmon_subdev(rproc, "wcnss", WCNSS_SSCTL_ID);
+	wcnss->sysmon = qcom_add_sysmon_subdev(rproc, "wcnss", WCNSS_SSCTL_ID,
+					       NULL);
 
 	ret = rproc_add(rproc);
 	if (ret)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

