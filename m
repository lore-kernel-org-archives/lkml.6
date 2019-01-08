Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5A7C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237E22173C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Gt4nLMQv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EoiAWJEL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfAHKYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:24:15 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33078 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfAHKYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:24:12 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2AF366086A; Tue,  8 Jan 2019 10:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546943051;
        bh=iMRBhcSUvIG+LC1G58e58xwg0UIz2v/ixffvgqMSN5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gt4nLMQvbg4S5YWFUF4wRG7iuiHqtbQf7RHYg+bA1373wqv/oPPgvPULq5DZqXwMk
         Muo35J0NMitJWBRuf6Q5+nAtxynfawRkg+nfTuiye32II4+jmu886I7XvH+dWKjBMg
         jldP7SCSF2DVEpjTqT95UV0r5yST37wzim0qo85o=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 483D1601D1;
        Tue,  8 Jan 2019 10:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546943050;
        bh=iMRBhcSUvIG+LC1G58e58xwg0UIz2v/ixffvgqMSN5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EoiAWJELggGGwz5jKcODgAHsjrBN5zMmVj2so5vp9jzrx8qRxhy0VxKGtX14cJV1x
         2yZtN3BWDwlSBXK8Ttz9CmGR/goZ4Ao1kRuGjze5Puj4TMLfIKagtgw3Lo65JGQDn1
         jWP8zytWEQDH0gUuQEtLO4jYRZailIMxbLRjgOqg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 483D1601D1
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
Subject: [PATCH v3 2/3] remoteproc: qcom: Add shutdown-ack irq
Date:   Tue,  8 Jan 2019 15:53:43 +0530
Message-Id: <20190108102344.28451-2-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108102344.28451-1-sibis@codeaurora.org>
References: <20190108102344.28451-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add shutdown-ack irq handling required for sysmon shutdown for
Q6V5 MSS on SDM845/MSM8996 and for WCSS Q6V5 on QCS404 SoC.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---

v3:
   * Move shutdown-irq handling back to sysmon and
     modify qcom_add_sysmon_subdev to handle -EPROBE_DEFER
   * Dropped has_shutdown_irq flag

v2:
   * Move shutdown-irq get to Q6V5 from sysmon to handle
     -EPROBE_DEFER cases

 drivers/remoteproc/qcom_common.h    | 16 +++++----
 drivers/remoteproc/qcom_q6v5_adsp.c |  9 +++--
 drivers/remoteproc/qcom_q6v5_mss.c  |  4 ++-
 drivers/remoteproc/qcom_q6v5_pas.c  |  9 +++--
 drivers/remoteproc/qcom_sysmon.c    | 52 +++++++++++++++++++++++++----
 drivers/remoteproc/qcom_wcnss.c     |  5 ++-
 6 files changed, 73 insertions(+), 22 deletions(-)

diff --git a/drivers/remoteproc/qcom_common.h b/drivers/remoteproc/qcom_common.h
index 58de71e4781c..afea598fdc9d 100644
--- a/drivers/remoteproc/qcom_common.h
+++ b/drivers/remoteproc/qcom_common.h
@@ -43,16 +43,18 @@ void qcom_add_ssr_subdev(struct rproc *rproc, struct qcom_rproc_ssr *ssr,
 void qcom_remove_ssr_subdev(struct rproc *rproc, struct qcom_rproc_ssr *ssr);
 
 #if IS_ENABLED(CONFIG_QCOM_SYSMON)
-struct qcom_sysmon *qcom_add_sysmon_subdev(struct rproc *rproc,
-					   const char *name,
-					   int ssctl_instance);
+int qcom_add_sysmon_subdev(struct rproc *rproc,
+			   struct qcom_sysmon *rproc_sysmon,
+			   const char *name,
+			   int ssctl_instance);
 void qcom_remove_sysmon_subdev(struct qcom_sysmon *sysmon);
 #else
-static inline struct qcom_sysmon *qcom_add_sysmon_subdev(struct rproc *rproc,
-							 const char *name,
-							 int ssctl_instance)
+static inline int qcom_add_sysmon_subdev(struct rproc *rproc,
+					 struct qcom_sysmon *rproc_sysmon,
+					 const char *name,
+					 int ssctl_instance)
 {
-	return NULL;
+	return 0;
 }
 
 static inline void qcom_remove_sysmon_subdev(struct qcom_sysmon *sysmon)
diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index 79374d1de311..e1db2c7a08bd 100644
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@ -436,9 +436,12 @@ static int adsp_probe(struct platform_device *pdev)
 
 	qcom_add_glink_subdev(rproc, &adsp->glink_subdev);
 	qcom_add_ssr_subdev(rproc, &adsp->ssr_subdev, desc->ssr_name);
-	adsp->sysmon = qcom_add_sysmon_subdev(rproc,
-					      desc->sysmon_name,
-					      desc->ssctl_id);
+	ret = qcom_add_sysmon_subdev(rproc,
+				     adsp->sysmon,
+				     desc->sysmon_name,
+				     desc->ssctl_id);
+	if (ret)
+		goto disable_pm;
 
 	ret = rproc_add(rproc);
 	if (ret)
diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index c86dc40cfb8c..7a256fdb2f64 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -1340,7 +1340,9 @@ static int q6v5_probe(struct platform_device *pdev)
 	qcom_add_glink_subdev(rproc, &qproc->glink_subdev);
 	qcom_add_smd_subdev(rproc, &qproc->smd_subdev);
 	qcom_add_ssr_subdev(rproc, &qproc->ssr_subdev, "mpss");
-	qproc->sysmon = qcom_add_sysmon_subdev(rproc, "modem", 0x12);
+	ret = qcom_add_sysmon_subdev(rproc, qproc->sysmon, "modem", 0x12);
+	if (ret)
+		goto free_rproc;
 
 	ret = rproc_add(rproc);
 	if (ret)
diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index b1e63fcd5fdf..942804b5fafa 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -301,9 +301,12 @@ static int adsp_probe(struct platform_device *pdev)
 	qcom_add_glink_subdev(rproc, &adsp->glink_subdev);
 	qcom_add_smd_subdev(rproc, &adsp->smd_subdev);
 	qcom_add_ssr_subdev(rproc, &adsp->ssr_subdev, desc->ssr_name);
-	adsp->sysmon = qcom_add_sysmon_subdev(rproc,
-					      desc->sysmon_name,
-					      desc->ssctl_id);
+	ret = qcom_add_sysmon_subdev(rproc,
+				     adsp->sysmon,
+				     desc->sysmon_name,
+				     desc->ssctl_id);
+	if (ret)
+		goto free_rproc;
 
 	ret = rproc_add(rproc);
 	if (ret)
diff --git a/drivers/remoteproc/qcom_sysmon.c b/drivers/remoteproc/qcom_sysmon.c
index e976a602b015..b17727dfc271 100644
--- a/drivers/remoteproc/qcom_sysmon.c
+++ b/drivers/remoteproc/qcom_sysmon.c
@@ -6,8 +6,10 @@
 #include <linux/module.h>
 #include <linux/notifier.h>
 #include <linux/slab.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/notifier.h>
+#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/remoteproc/qcom_rproc.h>
@@ -25,6 +27,7 @@ struct qcom_sysmon {
 
 	const char *name;
 
+	int shutdown_irq;
 	int ssctl_version;
 	int ssctl_instance;
 
@@ -34,6 +37,7 @@ struct qcom_sysmon {
 
 	struct rpmsg_endpoint *ept;
 	struct completion comp;
+	struct completion shutdown_comp;
 	struct mutex lock;
 
 	bool ssr_ack;
@@ -432,24 +436,35 @@ static int sysmon_notify(struct notifier_block *nb, unsigned long event,
 	return NOTIFY_DONE;
 }
 
+static irqreturn_t sysmon_shutdown_interrupt(int irq, void *data)
+{
+	struct qcom_sysmon *sysmon = data;
+
+	complete(&sysmon->shutdown_comp);
+
+	return IRQ_HANDLED;
+}
+
 /**
  * qcom_add_sysmon_subdev() - create a sysmon subdev for the given remoteproc
  * @rproc:	rproc context to associate the subdev with
+ * @rproc_sysmon: update sysmon context with a new qcom_sysmon object
  * @name:	name of this subdev, to use in SSR
  * @ssctl_instance: instance id of the ssctl QMI service
  *
- * Return: A new qcom_sysmon object, or NULL on failure
+ * Return: 0 on success, negative errno on failure
  */
-struct qcom_sysmon *qcom_add_sysmon_subdev(struct rproc *rproc,
-					   const char *name,
-					   int ssctl_instance)
+int qcom_add_sysmon_subdev(struct rproc *rproc,
+			   struct qcom_sysmon *rproc_sysmon,
+			   const char *name,
+			   int ssctl_instance)
 {
 	struct qcom_sysmon *sysmon;
 	int ret;
 
 	sysmon = kzalloc(sizeof(*sysmon), GFP_KERNEL);
 	if (!sysmon)
-		return NULL;
+		return -ENOMEM;
 
 	sysmon->dev = rproc->dev.parent;
 	sysmon->rproc = rproc;
@@ -458,13 +473,35 @@ struct qcom_sysmon *qcom_add_sysmon_subdev(struct rproc *rproc,
 	sysmon->ssctl_instance = ssctl_instance;
 
 	init_completion(&sysmon->comp);
+	init_completion(&sysmon->shutdown_comp);
 	mutex_init(&sysmon->lock);
 
+	sysmon->shutdown_irq = of_irq_get_byname(sysmon->dev->of_node,
+						 "shutdown-ack");
+	if (sysmon->shutdown_irq < 0) {
+		if (sysmon->shutdown_irq != -ENODATA) {
+			dev_err(sysmon->dev,
+				"failed to retrieve shutdown-ack IRQ\n");
+			return sysmon->shutdown_irq;
+		}
+	} else {
+		ret = devm_request_threaded_irq(sysmon->dev,
+						sysmon->shutdown_irq,
+						NULL, sysmon_shutdown_interrupt,
+						IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+						"q6v5 shutdown-ack", sysmon);
+		if (ret) {
+			dev_err(sysmon->dev,
+				"failed to acquire shutdown-ack IRQ\n");
+			return ret;
+		}
+	}
+
 	ret = qmi_handle_init(&sysmon->qmi, SSCTL_MAX_MSG_LEN, &ssctl_ops, NULL);
 	if (ret < 0) {
 		dev_err(sysmon->dev, "failed to initialize qmi handle\n");
 		kfree(sysmon);
-		return NULL;
+		return ret;
 	}
 
 	qmi_add_lookup(&sysmon->qmi, 43, 0, 0);
@@ -480,8 +517,9 @@ struct qcom_sysmon *qcom_add_sysmon_subdev(struct rproc *rproc,
 	mutex_lock(&sysmon_lock);
 	list_add(&sysmon->node, &sysmon_list);
 	mutex_unlock(&sysmon_lock);
+	rproc_sysmon = sysmon;
 
-	return sysmon;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(qcom_add_sysmon_subdev);
 
diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
index 1152da49a18a..920e85202c5e 100644
--- a/drivers/remoteproc/qcom_wcnss.c
+++ b/drivers/remoteproc/qcom_wcnss.c
@@ -552,7 +552,10 @@ static int wcnss_probe(struct platform_device *pdev)
 	}
 
 	qcom_add_smd_subdev(rproc, &wcnss->smd_subdev);
-	wcnss->sysmon = qcom_add_sysmon_subdev(rproc, "wcnss", WCNSS_SSCTL_ID);
+	ret = qcom_add_sysmon_subdev(rproc, wcnss->sysmon,
+				     "wcnss", WCNSS_SSCTL_ID);
+	if (ret)
+		goto free_rproc;
 
 	ret = rproc_add(rproc);
 	if (ret)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

