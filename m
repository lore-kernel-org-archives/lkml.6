Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965813AbeEIREB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:04:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56820 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965697AbeEIRCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:02:10 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6FF0D601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, mka@chromium.org, rplsssn@codeaurora.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v8 04/10] drivers: qcom: rpmh: add RPMH helper functions
Date: Wed,  9 May 2018 11:01:53 -0600
Message-Id: <20180509170159.29682-5-ilina@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180509170159.29682-1-ilina@codeaurora.org>
References: <20180509170159.29682-1-ilina@codeaurora.org>
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
 drivers/soc/qcom/rpmh-internal.h |   6 ++
 drivers/soc/qcom/rpmh-rsc.c      |   8 ++
 drivers/soc/qcom/rpmh.c          | 176 +++++++++++++++++++++++++++++++
 include/soc/qcom/rpmh.h          |  25 +++++
 5 files changed, 218 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/qcom/rpmh.c
 create mode 100644 include/soc/qcom/rpmh.h

diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index cb6300f6a8e9..bb395c3202ca 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -7,7 +7,9 @@ obj-$(CONFIG_QCOM_PM)	+=	spm.o
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
index cc29176f1303..d9a21726e568 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -14,6 +14,7 @@
 #define MAX_CMDS_PER_TCS		16
 #define MAX_TCS_PER_TYPE		3
 #define MAX_TCS_NR			(MAX_TCS_PER_TYPE * TCS_TYPE_NR)
+#define RPMH_MAX_CTRLR			2
 
 struct rsc_drv;
 
@@ -52,6 +53,7 @@ struct tcs_group {
  * @tcs:        TCS groups
  * @tcs_in_use: s/w state of the TCS
  * @lock:       synchronize state of the controller
+ * @list:       element in list of drv
  */
 struct rsc_drv {
 	const char *name;
@@ -61,9 +63,13 @@ struct rsc_drv {
 	struct tcs_group tcs[TCS_TYPE_NR];
 	DECLARE_BITMAP(tcs_in_use, MAX_TCS_NR);
 	spinlock_t lock;
+	struct list_head list;
 };
 
+extern struct list_head rsc_drv_list;
 
 int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg);
 
+void rpmh_tx_done(const struct tcs_request *msg, int r);
+
 #endif /* __RPM_INTERNAL_H__ */
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 0a8cec9d1651..c0edf3850147 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -61,6 +61,8 @@
 #define CMD_STATUS_ISSUED		BIT(8)
 #define CMD_STATUS_COMPL		BIT(16)
 
+LIST_HEAD(rsc_drv_list);
+
 static u32 read_tcs_reg(struct rsc_drv *drv, int reg, int tcs_id, int cmd_id)
 {
 	return readl_relaxed(drv->tcs_base + reg + RSC_DRV_TCS_OFFSET * tcs_id +
@@ -176,6 +178,8 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
 		spin_lock(&drv->lock);
 		clear_bit(i, drv->tcs_in_use);
 		spin_unlock(&drv->lock);
+		if (req)
+			rpmh_tx_done(req, err);
 	}
 
 	return IRQ_HANDLED;
@@ -469,6 +473,10 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 	/* Enable the active TCS to send requests immediately */
 	write_tcs_reg(drv, RSC_DRV_IRQ_ENABLE, 0, drv->tcs[ACTIVE_TCS].mask);
 
+	INIT_LIST_HEAD(&drv->list);
+	list_add(&drv->list, &rsc_drv_list);
+	dev_set_drvdata(&pdev->dev, drv);
+
 	return devm_of_platform_populate(&pdev->dev);
 }
 
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
new file mode 100644
index 000000000000..74bb82339b01
--- /dev/null
+++ b/drivers/soc/qcom/rpmh.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/atomic.h>
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
+/**
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
+static struct rpmh_ctrlr rpmh_rsc[RPMH_MAX_CTRLR];
+static DEFINE_SPINLOCK(rpmh_rsc_lock);
+
+static struct rpmh_ctrlr *get_rpmh_ctrlr(const struct device *dev)
+{
+	int i;
+	struct rsc_drv *p, *drv = dev_get_drvdata(dev->parent);
+	struct rpmh_ctrlr *ctrlr = ERR_PTR(-EINVAL);
+	unsigned long flags;
+
+	if (!drv)
+		return ctrlr;
+
+	for (i = 0; i < RPMH_MAX_CTRLR; i++) {
+		if (rpmh_rsc[i].drv == drv) {
+			ctrlr = &rpmh_rsc[i];
+			return ctrlr;
+		}
+	}
+
+	spin_lock_irqsave(&rpmh_rsc_lock, flags);
+	list_for_each_entry(p, &rsc_drv_list, list) {
+		if (drv == p) {
+			for (i = 0; i < RPMH_MAX_CTRLR; i++) {
+				if (!rpmh_rsc[i].drv)
+					break;
+			}
+			if (i == RPMH_MAX_CTRLR) {
+				ctrlr = ERR_PTR(-ENOMEM);
+				break;
+			}
+			rpmh_rsc[i].drv = drv;
+			ctrlr = &rpmh_rsc[i];
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&rpmh_rsc_lock, flags);
+
+	return ctrlr;
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
+EXPORT_SYMBOL(rpmh_tx_done);
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
+	if (IS_ERR(ctrlr))
+		return PTR_ERR(ctrlr);
+
+	rpm_msg->msg.state = state;
+
+	if (state != RPMH_ACTIVE_ONLY_STATE)
+		return -EINVAL;
+
+	WARN_ON(irqs_disabled());
+
+	return rpmh_rsc_send_data(ctrlr->drv, &rpm_msg->msg);
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
+	return (ret > 0) ? 0 : -ETIMEDOUT;
+}
+EXPORT_SYMBOL(rpmh_write);
diff --git a/include/soc/qcom/rpmh.h b/include/soc/qcom/rpmh.h
new file mode 100644
index 000000000000..c1d0f902bd71
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
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
