Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85EAC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F47820836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="juPwDCLq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cg0AIyPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F47820836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937977AbeFSNMO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:12:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33964 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937883AbeFSNMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:12:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 90BBF60AD8; Tue, 19 Jun 2018 13:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529413921;
        bh=/3QSmDFUAbx4XidXBMe6yOcg00sfuVOC6Jbor94dsIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=juPwDCLqsD845Yd3O0Vg5YEhu/XQpVKk8qE0pmcobLn9R71oBzZXe8aiGhzre8okt
         0cYTVkAS4DwoAlW9pnMNy7BPjHABeNt4JGXD4IeNvdZAbc/kTx0PslcBtZ2U8htnLv
         63oZELcks+a1oSazsTHCkPBJO5Xrko488Tdo+Qq0=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 26B57607EB;
        Tue, 19 Jun 2018 13:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529413920;
        bh=/3QSmDFUAbx4XidXBMe6yOcg00sfuVOC6Jbor94dsIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cg0AIyPcr7iXbjZfyrVIOF/gxXSJQGy698JWHJmZ0vlkjbw+3zUJzouS6CKGCtsll
         TVlegZdacEup3wgWnUSEo1pB/kSqnQKXmGHQGI2pQixLq56kkVyhUG6KSm6MhbhUuI
         RB2z3R4D0BNQREsr2yHH+ZHRQlVviR/kQe4DI76g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 26B57607EB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   Raju P L S S S N <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH v12 04/10] drivers: qcom: rpmh: add RPMH helper functions
Date:   Tue, 19 Jun 2018 18:41:27 +0530
Message-Id: <1529413893-5520-5-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529413893-5520-1-git-send-email-rplsssn@codeaurora.org>
References: <1529413893-5520-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lina Iyer <ilina@codeaurora.org>

Sending RPMH requests and waiting for response from the controller
through a callback is common functionality across all platform drivers.
To simplify drivers, add a library functions to create RPMH client and
send resource state requests.

rpmh_write() is a synchronous blocking call that can be used to send
active state requests.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
Changes in v12:
	- Rename ctrlr to client in rsc_drv
	- Fix 'err' may be used uninitialized warning

Changes in v11:
	- move rpmh_request to rpmh-internal.h
	- Associate rpmh_ctrl to rsc_drv
	- Remove EXPORT_SYMBOL for rpmh_tx_done

Changes in v10:
	- Remove rsc_drv_list
	- Add EXPORT_SYMBOL

Changes in v9:
	- Remove EXPORT_SYMBOL
	- add WARN_ON if response fails

Changes in v7:
	- Optimization and locking fixes

Changes in v6:
	- replace rpmh_client with device
	- inline wait_for_tx_done()

Changes in v4:
	- use const struct tcs_cmd in API
	- remove wait count from this patch
	- changed -EFAULT to -EINVAL
---
 drivers/soc/qcom/Makefile        |   4 +-
 drivers/soc/qcom/rpmh-internal.h |  31 ++++++++++-
 drivers/soc/qcom/rpmh-rsc.c      |   6 +-
 drivers/soc/qcom/rpmh.c          | 116 +++++++++++++++++++++++++++++++++++++++
 include/soc/qcom/rpmh.h          |  25 +++++++++
 5 files changed, 179 insertions(+), 3 deletions(-)
 create mode 100644 drivers/soc/qcom/rpmh.c
 create mode 100644 include/soc/qcom/rpmh.h

diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index fa90171..03d4c83 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -9,7 +9,9 @@ obj-$(CONFIG_QCOM_PM)	+=	spm.o
 obj-$(CONFIG_QCOM_QMI_HELPERS)	+= qmi_helpers.o
 qmi_helpers-y	+= qmi_encdec.o qmi_interface.o
 obj-$(CONFIG_QCOM_RMTFS_MEM)	+= rmtfs_mem.o
-obj-$(CONFIG_QCOM_RPMH)	+=	rpmh-rsc.o
+obj-$(CONFIG_QCOM_RPMH)		+= qcom_rpmh.o
+qcom_rpmh-y			+= rpmh-rsc.o
+qcom_rpmh-y			+= rpmh.o
 obj-$(CONFIG_QCOM_SMD_RPM)	+= smd-rpm.o
 obj-$(CONFIG_QCOM_SMEM) +=	smem.o
 obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index cc29176..1e687f7 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -42,6 +42,32 @@ struct tcs_group {
 };
 
 /**
+ * struct rpmh_request: the message to be sent to rpmh-rsc
+ *
+ * @msg: the request
+ * @cmd: the payload that will be part of the @msg
+ * @completion: triggered when request is done
+ * @dev: the device making the request
+ * @err: err return from the controller
+ */
+struct rpmh_request {
+	struct tcs_request msg;
+	struct tcs_cmd cmd[MAX_RPMH_PAYLOAD];
+	struct completion *completion;
+	const struct device *dev;
+	int err;
+};
+
+/**
+ * struct rpmh_ctrlr: our representation of the controller
+ *
+ * @drv: the controller instance
+ */
+struct rpmh_ctrlr {
+	struct rsc_drv *drv;
+};
+
+/**
  * struct rsc_drv: the Direct Resource Voter (DRV) of the
  * Resource State Coordinator controller (RSC)
  *
@@ -52,6 +78,7 @@ struct tcs_group {
  * @tcs:        TCS groups
  * @tcs_in_use: s/w state of the TCS
  * @lock:       synchronize state of the controller
+ * @client:     handle to the DRV's client.
  */
 struct rsc_drv {
 	const char *name;
@@ -61,9 +88,11 @@ struct rsc_drv {
 	struct tcs_group tcs[TCS_TYPE_NR];
 	DECLARE_BITMAP(tcs_in_use, MAX_TCS_NR);
 	spinlock_t lock;
+	struct rpmh_ctrlr client;
 };
 
-
 int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg);
 
+void rpmh_tx_done(const struct tcs_request *msg, int r);
+
 #endif /* __RPM_INTERNAL_H__ */
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 89d41cd..91f8d60 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -138,7 +138,7 @@ static const struct tcs_request *get_req_from_tcs(struct rsc_drv *drv,
 static irqreturn_t tcs_tx_done(int irq, void *p)
 {
 	struct rsc_drv *drv = p;
-	int i, j, err;
+	int i, j, err = 0;
 	unsigned long irq_status;
 	const struct tcs_request *req;
 	struct tcs_cmd *cmd;
@@ -175,6 +175,8 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
 		spin_lock(&drv->lock);
 		clear_bit(i, drv->tcs_in_use);
 		spin_unlock(&drv->lock);
+		if (req)
+			rpmh_tx_done(req, err);
 	}
 
 	return IRQ_HANDLED;
@@ -467,6 +469,8 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 	/* Enable the active TCS to send requests immediately */
 	write_tcs_reg(drv, RSC_DRV_IRQ_ENABLE, 0, drv->tcs[ACTIVE_TCS].mask);
 
+	dev_set_drvdata(&pdev->dev, drv);
+
 	return devm_of_platform_populate(&pdev->dev);
 }
 
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
new file mode 100644
index 0000000..5e022cb
--- /dev/null
+++ b/drivers/soc/qcom/rpmh.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/atomic.h>
+#include <linux/bug.h>
+#include <linux/interrupt.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+
+#include <soc/qcom/rpmh.h>
+
+#include "rpmh-internal.h"
+
+#define RPMH_TIMEOUT_MS			msecs_to_jiffies(10000)
+
+#define DEFINE_RPMH_MSG_ONSTACK(dev, s, q, name)	\
+	struct rpmh_request name = {			\
+		.msg = {				\
+			.state = s,			\
+			.cmds = name.cmd,		\
+			.num_cmds = 0,			\
+			.wait_for_compl = true,		\
+		},					\
+		.cmd = { { 0 } },			\
+		.completion = q,			\
+		.dev = dev,				\
+	}
+
+#define ctrlr_to_drv(ctrlr) container_of(ctrlr, struct rsc_drv, client)
+
+static struct rpmh_ctrlr *get_rpmh_ctrlr(const struct device *dev)
+{
+	struct rsc_drv *drv = dev_get_drvdata(dev->parent);
+
+	return &drv->client;
+}
+
+void rpmh_tx_done(const struct tcs_request *msg, int r)
+{
+	struct rpmh_request *rpm_msg = container_of(msg, struct rpmh_request,
+						    msg);
+	struct completion *compl = rpm_msg->completion;
+
+	rpm_msg->err = r;
+
+	if (r)
+		dev_err(rpm_msg->dev, "RPMH TX fail in msg addr=%#x, err=%d\n",
+			rpm_msg->msg.cmds[0].addr, r);
+
+	/* Signal the blocking thread we are done */
+	if (compl)
+		complete(compl);
+}
+
+/**
+ * __rpmh_write: send the RPMH request
+ *
+ * @dev: The device making the request
+ * @state: Active/Sleep request type
+ * @rpm_msg: The data that needs to be sent (cmds).
+ */
+static int __rpmh_write(const struct device *dev, enum rpmh_state state,
+			struct rpmh_request *rpm_msg)
+{
+	struct rpmh_ctrlr *ctrlr = get_rpmh_ctrlr(dev);
+
+	rpm_msg->msg.state = state;
+
+	if (state != RPMH_ACTIVE_ONLY_STATE)
+		return -EINVAL;
+
+	WARN_ON(irqs_disabled());
+
+	return rpmh_rsc_send_data(ctrlr_to_drv(ctrlr), &rpm_msg->msg);
+}
+
+/**
+ * rpmh_write: Write a set of RPMH commands and block until response
+ *
+ * @rc: The RPMH handle got from rpmh_get_client
+ * @state: Active/sleep set
+ * @cmd: The payload data
+ * @n: The number of elements in @cmd
+ *
+ * May sleep. Do not call from atomic contexts.
+ */
+int rpmh_write(const struct device *dev, enum rpmh_state state,
+	       const struct tcs_cmd *cmd, u32 n)
+{
+	DECLARE_COMPLETION_ONSTACK(compl);
+	DEFINE_RPMH_MSG_ONSTACK(dev, state, &compl, rpm_msg);
+	int ret;
+
+	if (!cmd || !n || n > MAX_RPMH_PAYLOAD)
+		return -EINVAL;
+
+	memcpy(rpm_msg.cmd, cmd, n * sizeof(*cmd));
+	rpm_msg.msg.num_cmds = n;
+
+	ret = __rpmh_write(dev, state, &rpm_msg);
+	if (ret)
+		return ret;
+
+	ret = wait_for_completion_timeout(&compl, RPMH_TIMEOUT_MS);
+	WARN_ON(!ret);
+	return (ret > 0) ? 0 : -ETIMEDOUT;
+}
+EXPORT_SYMBOL(rpmh_write);
diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
new file mode 100644
index 0000000..c1d0f90
--- /dev/null
+++ b/include/soc/qcom/rpmh.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __SOC_QCOM_RPMH_H__
+#define __SOC_QCOM_RPMH_H__
+
+#include <soc/qcom/tcs.h>
+#include <linux/platform_device.h>
+
+
+#if IS_ENABLED(CONFIG_QCOM_RPMH)
+int rpmh_write(const struct device *dev, enum rpmh_state state,
+	       const struct tcs_cmd *cmd, u32 n);
+
+#else
+
+static inline int rpmh_write(const struct device *dev, enum rpmh_state state,
+			     const struct tcs_cmd *cmd, u32 n)
+{ return -ENODEV; }
+
+#endif /* CONFIG_QCOM_RPMH */
+
+#endif /* __SOC_QCOM_RPMH_H__ */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

