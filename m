Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968021AbeCBQnq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:43:46 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40964 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966619AbeCBQnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:43:37 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 979F8607E5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v3 04/10] drivers: qcom: rpmh: add RPMH helper functions
Date: Fri,  2 Mar 2018 09:43:11 -0700
Message-Id: <20180302164317.10554-5-ilina@codeaurora.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302164317.10554-1-ilina@codeaurora.org>
References: <20180302164317.10554-1-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sending RPMH requests and waiting for response from the controller
through a callback is common functionality across all platform drivers.
To simplify drivers, add a library functions to create RPMH client and
send resource state requests.

rpmh_write() is a synchronous blocking call that can be used to send
active state requests.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/soc/qcom/Makefile        |   4 +-
 drivers/soc/qcom/rpmh-internal.h |   2 +
 drivers/soc/qcom/rpmh-rsc.c      |   7 ++
 drivers/soc/qcom/rpmh.c          | 257 +++++++++++++++++++++++++++++++++++++++
 include/soc/qcom/rpmh.h          |  34 ++++++
 5 files changed, 303 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/qcom/rpmh.c
 create mode 100644 include/soc/qcom/rpmh.h

diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index bb013d56b5a1..5c9c6c442ea9 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -13,4 +13,6 @@ obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
 obj-$(CONFIG_QCOM_SMP2P)	+= smp2p.o
 obj-$(CONFIG_QCOM_SMSM)	+= smsm.o
 obj-$(CONFIG_QCOM_WCNSS_CTRL) += wcnss_ctrl.o
-obj-$(CONFIG_QCOM_RPMH)	+=	rpmh-rsc.o
+obj-$(CONFIG_QCOM_RPMH)	+= qcom_rpmh.o
+qcom_rpmh-y		+= rpmh-rsc.o
+qcom_rpmh-y		+= rpmh.o
diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index 12faec77c4f3..1442a64ac4c5 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -84,4 +84,6 @@ struct rsc_drv {
 
 int rpmh_rsc_send_data(struct rsc_drv *drv, struct tcs_request *msg);
 
+void rpmh_tx_done(struct tcs_request *msg, int r);
+
 #endif /* __RPM_INTERNAL_H__ */
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 4322e23a2ba6..b5b39b86f904 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -263,6 +263,8 @@ static void tcs_notify_tx_done(unsigned long data)
 	struct rsc_drv *drv = (struct rsc_drv *)data;
 	struct tcs_response *resp;
 	unsigned long flags;
+	struct tcs_request *msg;
+	int err;
 
 	for (;;) {
 		spin_lock_irqsave(&drv->drv_lock, flags);
@@ -275,7 +277,10 @@ static void tcs_notify_tx_done(unsigned long data)
 		list_del(&resp->list);
 		spin_unlock_irqrestore(&drv->drv_lock, flags);
 		trace_rpmh_notify_tx_done(drv, resp);
+		msg = resp->msg;
+		err = resp->err;
 		free_response(resp);
+		rpmh_tx_done(msg, err);
 	}
 }
 
@@ -575,6 +580,8 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 	write_tcs_reg(drv, RSC_DRV_IRQ_ENABLE, 0, 0,
 		     drv->tcs[ACTIVE_TCS].tcs_mask);
 
+	dev_set_drvdata(&pdev->dev, drv);
+
 	return of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
 }
 
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
new file mode 100644
index 000000000000..d95ea3fa8b67
--- /dev/null
+++ b/drivers/soc/qcom/rpmh.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/atomic.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mailbox_client.h>
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
+#define RPMH_MAX_MBOXES			2
+#define RPMH_TIMEOUT			(10 * HZ)
+
+#define DEFINE_RPMH_MSG_ONSTACK(rc, s, q, c, name)	\
+	struct rpmh_request name = {			\
+		.msg = {				\
+			.state = s,			\
+			.payload = name.cmd,		\
+			.num_payload = 0,		\
+			.is_complete = true,		\
+		},					\
+		.cmd = { { 0 } },			\
+		.completion = q,			\
+		.wait_count = c,			\
+		.rc = rc,				\
+	}
+
+/**
+ * rpmh_request: the message to be sent to rpmh-rsc
+ *
+ * @msg: the request
+ * @cmd: the payload that will be part of the @msg
+ * @completion: triggered when request is done
+ * @wait_count: count of waiters for this completion
+ * @err: err return from the controller
+ */
+struct rpmh_request {
+	struct tcs_request msg;
+	struct tcs_cmd cmd[MAX_RPMH_PAYLOAD];
+	struct completion *completion;
+	atomic_t *wait_count;
+	struct rpmh_client *rc;
+	int err;
+};
+
+/**
+ * rpmh_ctrlr: our representation of the controller
+ *
+ * @drv: the controller instance
+ */
+struct rpmh_ctrlr {
+	struct rsc_drv *drv;
+};
+
+/**
+ * rpmh_client: the client object
+ *
+ * @dev: the platform device that is the owner
+ * @ctrlr: the controller associated with this client.
+ */
+struct rpmh_client {
+	struct device *dev;
+	struct rpmh_ctrlr *ctrlr;
+};
+
+static struct rpmh_ctrlr rpmh_rsc[RPMH_MAX_MBOXES];
+static DEFINE_MUTEX(rpmh_ctrlr_mutex);
+
+void rpmh_tx_done(struct tcs_request *msg, int r)
+{
+	struct rpmh_request *rpm_msg = container_of(msg,
+						   struct rpmh_request, msg);
+	atomic_t *wc = rpm_msg->wait_count;
+	struct completion *compl = rpm_msg->completion;
+
+	rpm_msg->err = r;
+
+	if (r)
+		dev_err(rpm_msg->rc->dev,
+		       "RPMH TX fail in msg addr 0x%x, err=%d\n",
+		       rpm_msg->msg.payload[0].addr, r);
+
+	/* Signal the blocking thread we are done */
+	if (wc && atomic_dec_and_test(wc) && compl)
+		complete(compl);
+}
+EXPORT_SYMBOL(rpmh_tx_done);
+
+/**
+ * wait_for_tx_done: Wait until the response is received.
+ *
+ * @rc: The RPMH client
+ * @compl: The completion object
+ * @addr: An addr that we sent in that request
+ * @data: The data for the address in that request
+ *
+ */
+static int wait_for_tx_done(struct rpmh_client *rc,
+			   struct completion *compl, u32 addr, u32 data)
+{
+	int ret;
+
+	ret = wait_for_completion_timeout(compl, RPMH_TIMEOUT);
+	if (ret)
+		dev_dbg(rc->dev,
+		       "RPMH response received addr=0x%x data=0x%x\n",
+		       addr, data);
+	else
+		dev_err(rc->dev,
+			"RPMH response timeout addr=0x%x data=0x%x\n",
+			addr, data);
+
+	return (ret > 0) ? 0 : -ETIMEDOUT;
+}
+
+/**
+ * __rpmh_write: send the RPMH request
+ *
+ * @rc: The RPMH client
+ * @state: Active/Sleep request type
+ * @rpm_msg: The data that needs to be sent (payload).
+ */
+static int __rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
+		       struct rpmh_request *rpm_msg)
+{
+	int ret = -EFAULT;
+
+	rpm_msg->msg.state = state;
+
+	if (state == RPMH_ACTIVE_ONLY_STATE) {
+		WARN_ON(irqs_disabled());
+		ret = rpmh_rsc_send_data(rc->ctrlr->drv, &rpm_msg->msg);
+		if (!ret)
+			dev_dbg(rc->dev,
+			       "RPMH request sent addr=0x%x, data=0x%x\n",
+			       rpm_msg->msg.payload[0].addr,
+			       rpm_msg->msg.payload[0].data);
+		else
+			dev_warn(rc->dev,
+				"Error in RPMH request addr=0x%x, data=0x%x\n",
+				rpm_msg->msg.payload[0].addr,
+				rpm_msg->msg.payload[0].data);
+	}
+
+	return ret;
+}
+
+/**
+ * rpmh_write: Write a set of RPMH commands and block until response
+ *
+ * @rc: The RPMh handle got from rpmh_get_dev_channel
+ * @state: Active/sleep set
+ * @cmd: The payload data
+ * @n: The number of elements in payload
+ *
+ * May sleep. Do not call from atomic contexts.
+ */
+int rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
+	      struct tcs_cmd *cmd, int n)
+{
+	DECLARE_COMPLETION_ONSTACK(compl);
+	atomic_t wait_count = ATOMIC_INIT(1);
+	DEFINE_RPMH_MSG_ONSTACK(rc, state, &compl, &wait_count, rpm_msg);
+	int ret;
+
+	if (IS_ERR_OR_NULL(rc) || !cmd || n <= 0 || n > MAX_RPMH_PAYLOAD)
+		return -EINVAL;
+
+	might_sleep();
+
+	memcpy(rpm_msg.cmd, cmd, n * sizeof(*cmd));
+	rpm_msg.msg.num_payload = n;
+
+	ret = __rpmh_write(rc, state, &rpm_msg);
+	if (ret)
+		return ret;
+
+	return wait_for_tx_done(rc, &compl, cmd[0].addr, cmd[0].data);
+}
+EXPORT_SYMBOL(rpmh_write);
+
+static struct rpmh_ctrlr *get_rpmh_ctrlr(struct platform_device *pdev)
+{
+	int i;
+	struct rsc_drv *drv = dev_get_drvdata(pdev->dev.parent);
+	struct rpmh_ctrlr *ctrlr = ERR_PTR(-EFAULT);
+
+	if (!drv)
+		return ctrlr;
+
+	mutex_lock(&rpmh_ctrlr_mutex);
+	for (i = 0; i < RPMH_MAX_MBOXES; i++) {
+		if (rpmh_rsc[i].drv == drv) {
+			ctrlr = &rpmh_rsc[i];
+			goto unlock;
+		}
+	}
+
+	for (i = 0; i < RPMH_MAX_MBOXES; i++) {
+		if (rpmh_rsc[i].drv == NULL) {
+			ctrlr = &rpmh_rsc[i];
+			ctrlr->drv = drv;
+			break;
+		}
+	}
+	WARN_ON(i == RPMH_MAX_MBOXES);
+unlock:
+	mutex_unlock(&rpmh_ctrlr_mutex);
+	return ctrlr;
+}
+
+/**
+ * rpmh_get_client: Get the RPMh handle
+ *
+ * @pdev: the platform device which needs to communicate with RPM
+ * accelerators
+ * May sleep.
+ */
+struct rpmh_client *rpmh_get_client(struct platform_device *pdev)
+{
+	struct rpmh_client *rc;
+
+	rc = kzalloc(sizeof(*rc), GFP_KERNEL);
+	if (!rc)
+		return ERR_PTR(-ENOMEM);
+
+	rc->dev = &pdev->dev;
+	rc->ctrlr = get_rpmh_ctrlr(pdev);
+	if (IS_ERR(rc->ctrlr)) {
+		kfree(rc);
+		return ERR_PTR(-EFAULT);
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL(rpmh_get_client);
+
+/**
+ * rpmh_release: Release the RPMH client
+ *
+ * @rc: The RPMh handle to be freed.
+ */
+void rpmh_release(struct rpmh_client *rc)
+{
+	kfree(rc);
+}
+EXPORT_SYMBOL(rpmh_release);
diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
new file mode 100644
index 000000000000..53cc145990c2
--- /dev/null
+++ b/include/soc/qcom/rpmh.h
@@ -0,0 +1,34 @@
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
+struct rpmh_client;
+
+#if IS_ENABLED(CONFIG_QCOM_RPMH)
+int rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
+	      struct tcs_cmd *cmd, int n);
+
+struct rpmh_client *rpmh_get_client(struct platform_device *pdev);
+
+void rpmh_release(struct rpmh_client *rc);
+
+#else
+
+static inline int rpmh_write(struct rpmh_client *rc, enum rpmh_state state,
+			    struct tcs_cmd *cmd, int n)
+{ return -ENODEV; }
+
+static inline struct rpmh_client *rpmh_get_client(struct platform_device *pdev)
+{ return ERR_PTR(-ENODEV); }
+
+static inline void rpmh_release(struct rpmh_client *rc) { }
+#endif /* CONFIG_QCOM_RPMH */
+
+#endif /* __SOC_QCOM_RPMH_H__ */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
