Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5802CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1624A20821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KSSY5qjB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ba4KirKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1624A20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbeJaToG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:44:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41476 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbeJaToF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:44:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 70BE560767; Wed, 31 Oct 2018 10:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540982790;
        bh=n7Llx1zi8E9y/9e20tlBulty7KXqgzlZgHwyCqC19as=;
        h=From:To:Cc:Subject:Date:From;
        b=KSSY5qjBv8RFwa5UjMC64+SwVwWtO3k3IZRl7jtPtFiAHkebq+NTH6SzBtL2ae0iD
         1lK1FWo5YU6ky5HP1xhgHoEu4bXYykS+IFqQrrsVLC0ulo+yo4vR//VWXv1EUbiCks
         ydeZkfOL7jSdUk91ztNT6RBxsACl5T2T0J9UgBlE=
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6FAD4601D4;
        Wed, 31 Oct 2018 10:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540982789;
        bh=n7Llx1zi8E9y/9e20tlBulty7KXqgzlZgHwyCqC19as=;
        h=From:To:Cc:Subject:Date:From;
        b=ba4KirKFbaOkh2ogcOxkXiBFURQZqTrUN7WepnuBa20pTixVRJFruEsKJfELe7BMb
         b20490TjEm/ZcjDss5PUB3KmtMayerZH+iUgTUSS7+gPNRTi0oQOAHGBNnWGPEybHR
         WxWSMCr0PCGu33x5Lp4M2E1JDDER5He0lDBHVCGs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6FAD4601D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, briannorris@chromium.org,
        mark.rutland@arm.com, andy.gross@linaro.org
Cc:     akdwived@codeaurora.org, clew@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [RFC PATCH v3] remoteproc: qcom: q6v5-mss: Sync MSS with RMTFS QMI service
Date:   Wed, 31 Oct 2018 16:16:14 +0530
Message-Id: <20181031104614.10412-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce RMTFS qmi lookup client to synchronize bring up/down modem
with the REMOTE FS QMI service.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
The currently implemented workaround in the Linaro QCOMLT releases is to
blacklist the qcom_q6v5_pil kernel module and load this explicitly after rmtfs
has been started.

With this patch the modem module can be loaded automatically by the
platform_bus and will only be booted as the rmtfs becomes available. Performing
actions such as upgrading (and restarting) the rmtfs service will cause the
modem to automatically restart and hence continue to function after the
upgrade.

v3:
  Move rmtfs lookup client to the q6v5_mss driver
  [Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>]
  [Suggested-by: Brian Norris <briannorris@chromium.org>]
  Add deny_sysfs_ops flag to prevent updation of state/firmware
  [Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>]

v2:
  Remove rproc_boot/shutdown from rmtfs_mem open/release and add
  qmi lookup for Remote file system service to address Brian's
  race concerns.

Depends on: https://patchwork.kernel.org/patch/10601325/

 drivers/remoteproc/Kconfig         |  1 +
 drivers/remoteproc/qcom_q6v5_mss.c | 41 ++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 8894935583e2..5919098697ec 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -100,6 +100,7 @@ config QCOM_Q6V5_MSS
 	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
 	depends on QCOM_SYSMON || QCOM_SYSMON=n
 	select MFD_SYSCON
+	select QCOM_QMI_HELPERS
 	select QCOM_Q6V5_COMMON
 	select QCOM_RPROC_COMMON
 	select QCOM_SCM
diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index da4e496816aa..436a7fec84e9 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -30,6 +30,7 @@
 #include <linux/remoteproc.h>
 #include <linux/reset.h>
 #include <linux/soc/qcom/mdt_loader.h>
+#include <linux/soc/qcom/qmi.h>
 #include <linux/iopoll.h>
 
 #include "remoteproc_internal.h"
@@ -39,6 +40,7 @@
 #include <linux/qcom_scm.h>
 
 #define MPSS_CRASH_REASON_SMEM		421
+#define REMOTEFS_QMI_SVC_ID		0xE
 
 /* RMB Status Register Values */
 #define RMB_PBL_SUCCESS			0x1
@@ -180,6 +182,7 @@ struct q6v5 {
 	void *mpss_region;
 	size_t mpss_size;
 
+	struct qmi_handle lookup_client;
 	struct qcom_rproc_glink glink_subdev;
 	struct qcom_rproc_subdev smd_subdev;
 	struct qcom_rproc_ssr ssr_subdev;
@@ -991,6 +994,25 @@ static void qcom_q6v5_dump_segment(struct rproc *rproc,
 	}
 }
 
+static int rmtfs_new_server(struct qmi_handle *qmi, struct qmi_service *serv)
+{
+	struct q6v5 *qproc = container_of(qmi, struct q6v5, lookup_client);
+
+	return rproc_boot(qproc->rproc);
+};
+
+static void rmtfs_del_server(struct qmi_handle *qmi, struct qmi_service *serv)
+{
+	struct q6v5 *qproc = container_of(qmi, struct q6v5, lookup_client);
+
+	rproc_shutdown(qproc->rproc);
+};
+
+static struct qmi_ops lookup_ops = {
+	.new_server = rmtfs_new_server,
+	.del_server = rmtfs_del_server,
+};
+
 static int q6v5_start(struct rproc *rproc)
 {
 	struct q6v5 *qproc = (struct q6v5 *)rproc->priv;
@@ -1269,6 +1291,9 @@ static int q6v5_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	rproc->auto_boot = false;
+	rproc->deny_sysfs_ops = true;
+
 	qproc = (struct q6v5 *)rproc->priv;
 	qproc->dev = &pdev->dev;
 	qproc->rproc = rproc;
@@ -1346,8 +1371,23 @@ static int q6v5_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_rproc;
 
+	/* The modem polls for REMOTE FS QMI service for a fixed period, post
+	 * which it issues a fatal error. The RMTFS lookup client handles this
+	 * dependency by ensuring that the modem is brought up/down in sync with
+	 * the REMOTE FS QMI SERVICE.
+	 */
+	ret = qmi_handle_init(&qproc->lookup_client, 0, &lookup_ops, NULL);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to initialize qmi handle.\n");
+		goto delete_rproc;
+	}
+
+	qmi_add_lookup(&qproc->lookup_client, REMOTEFS_QMI_SVC_ID, 0, 0);
+
 	return 0;
 
+delete_rproc:
+	rproc_del(rproc);
 free_rproc:
 	rproc_free(rproc);
 
@@ -1358,6 +1398,7 @@ static int q6v5_remove(struct platform_device *pdev)
 {
 	struct q6v5 *qproc = platform_get_drvdata(pdev);
 
+	qmi_handle_release(&qproc->lookup_client);
 	rproc_del(qproc->rproc);
 
 	qcom_remove_sysmon_subdev(qproc->sysmon);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

