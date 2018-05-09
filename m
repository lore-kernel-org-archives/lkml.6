Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965838AbeEIREv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:04:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56616 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965677AbeEIRCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:02:07 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6ADF160591
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, mka@chromium.org, rplsssn@codeaurora.org,
        Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v8 01/10] drivers: qcom: rpmh-rsc: add RPMH controller for QCOM SoCs
Date: Wed,  9 May 2018 11:01:50 -0600
Message-Id: <20180509170159.29682-2-ilina@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180509170159.29682-1-ilina@codeaurora.org>
References: <20180509170159.29682-1-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add controller driver for QCOM SoCs that have hardware based shared
resource management. The hardware IP known as RSC (Resource State
Coordinator) houses multiple Direct Resource Voter (DRV) for different
execution levels. A DRV is a unique voter on the state of a shared
resource. A Trigger Control Set (TCS) is a bunch of slots that can house
multiple resource state requests, that when triggered will issue those
requests through an internal bus to the Resource Power Manager Hardened
(RPMH) blocks. These hardware blocks are capable of adjusting clocks,
voltages, etc. The resource state request from a DRV are aggregated
along with state requests from other processors in the SoC and the
aggregate value is applied on the resource.

Some important aspects of the RPMH communication -
- Requests are <addr, value> with some header information
- Multiple requests (upto 16) may be sent through a TCS, at a time
- Requests in a TCS are sent in sequence
- Requests may be fire-n-forget or completion (response expected)
- Multiple TCS from the same DRV may be triggered simultaneously
- Cannot send a request if another request for the same addr is in
  progress from the same DRV
- When all the requests from a TCS are complete, an IRQ is raised
- The IRQ handler needs to clear the TCS before it is available for
  reuse
- TCS configuration is specific to a DRV
- Platform drivers may use DRV from different RSCs to make requests

Resource state requests made when CPUs are active are called 'active'
state requests. Requests made when all the CPUs are powered down (idle
state) are called 'sleep' state requests. They are matched by a
corresponding 'wake' state requests which puts the resources back in to
previously requested active state before resuming any CPU. TCSes are
dedicated for each type of requests. Active mode TCSes (AMC) are used to
send requests immediately to the resource, while control TCS are used to
provide specific information to the controller. Sleep and Wake TCS send
sleep and wake requests, after and before the system halt respectively.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---

Changes in v8:
	- introduce interrupt description in DT for all DRvs

Changes in v7:
	- rename 'm' and 'n' variable names

Changes in v6:
	- Remove tasklet and response object
	- introduce rpm_write_tcs_cmd() function
	- rename tcs_irq_handler()
	- avoid bool in structures. Fix tcs.h.
Changes in v4:
	- lots of variable name changes as suggested by Stephen B
	- use of const for data pointers
	- fix comments and other code syntax
	- use of bitmap for tcs_in_use instead of atomic
---
 drivers/soc/qcom/Kconfig                |  10 +
 drivers/soc/qcom/Makefile               |   1 +
 drivers/soc/qcom/rpmh-internal.h        |  69 ++++
 drivers/soc/qcom/rpmh-rsc.c             | 483 ++++++++++++++++++++++++
 include/dt-bindings/soc/qcom,rpmh-rsc.h |  14 +
 include/soc/qcom/tcs.h                  |  56 +++
 6 files changed, 633 insertions(+)
 create mode 100644 drivers/soc/qcom/rpmh-internal.h
 create mode 100644 drivers/soc/qcom/rpmh-rsc.c
 create mode 100644 include/dt-bindings/soc/qcom,rpmh-rsc.h
 create mode 100644 include/soc/qcom/tcs.h

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 5c4535b545cc..1887e1b1f43b 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -56,6 +56,16 @@ config QCOM_RMTFS_MEM
 
 	  Say y here if you intend to boot the modem remoteproc.
 
+config QCOM_RPMH
+	bool "Qualcomm RPM-Hardened (RPMH) Communication"
+	depends on ARCH_QCOM && ARM64 && OF || COMPILE_TEST
+	help
+	  Support for communication with the hardened-RPM blocks in
+	  Qualcomm Technologies Inc (QTI) SoCs. RPMH communication uses an
+	  internal bus to transmit state requests for shared resources. A set
+	  of hardware components aggregate requests for these resources and
+	  help apply the aggregated state on the resource.
+
 config QCOM_SMEM
 	tristate "Qualcomm Shared Memory Manager (SMEM)"
 	depends on ARCH_QCOM
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index dcebf2814e6d..39d3a059ee50 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_QCOM_PM)	+=	spm.o
 obj-$(CONFIG_QCOM_QMI_HELPERS)	+= qmi_helpers.o
 qmi_helpers-y	+= qmi_encdec.o qmi_interface.o
 obj-$(CONFIG_QCOM_RMTFS_MEM)	+= rmtfs_mem.o
+obj-$(CONFIG_QCOM_RPMH)	+=	rpmh-rsc.o
 obj-$(CONFIG_QCOM_SMD_RPM)	+= smd-rpm.o
 obj-$(CONFIG_QCOM_SMEM) +=	smem.o
 obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
new file mode 100644
index 000000000000..cc29176f1303
--- /dev/null
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ */
+
+
+#ifndef __RPM_INTERNAL_H__
+#define __RPM_INTERNAL_H__
+
+#include <linux/bitmap.h>
+#include <soc/qcom/tcs.h>
+
+#define TCS_TYPE_NR			4
+#define MAX_CMDS_PER_TCS		16
+#define MAX_TCS_PER_TYPE		3
+#define MAX_TCS_NR			(MAX_TCS_PER_TYPE * TCS_TYPE_NR)
+
+struct rsc_drv;
+
+/**
+ * struct tcs_group: group of Trigger Command Sets (TCS) to send state requests
+ * to the controller
+ *
+ * @drv:       the controller
+ * @type:      type of the TCS in this group - active, sleep, wake
+ * @mask:      mask of the TCSes relative to all the TCSes in the RSC
+ * @offset:    start of the TCS group relative to the TCSes in the RSC
+ * @num_tcs:   number of TCSes in this type
+ * @ncpt:      number of commands in each TCS
+ * @lock:      lock for synchronizing this TCS writes
+ * @req:       requests that are sent from the TCS
+ */
+struct tcs_group {
+	struct rsc_drv *drv;
+	int type;
+	u32 mask;
+	u32 offset;
+	int num_tcs;
+	int ncpt;
+	spinlock_t lock;
+	const struct tcs_request *req[MAX_TCS_PER_TYPE];
+};
+
+/**
+ * struct rsc_drv: the Direct Resource Voter (DRV) of the
+ * Resource State Coordinator controller (RSC)
+ *
+ * @name:       controller identifier
+ * @tcs_base:   start address of the TCS registers in this controller
+ * @id:         instance id in the controller (Direct Resource Voter)
+ * @num_tcs:    number of TCSes in this DRV
+ * @tcs:        TCS groups
+ * @tcs_in_use: s/w state of the TCS
+ * @lock:       synchronize state of the controller
+ */
+struct rsc_drv {
+	const char *name;
+	void __iomem *tcs_base;
+	int id;
+	int num_tcs;
+	struct tcs_group tcs[TCS_TYPE_NR];
+	DECLARE_BITMAP(tcs_in_use, MAX_TCS_NR);
+	spinlock_t lock;
+};
+
+
+int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg);
+
+#endif /* __RPM_INTERNAL_H__ */
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
new file mode 100644
index 000000000000..4eeccf75cc15
--- /dev/null
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -0,0 +1,483 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ */
+
+#define pr_fmt(fmt) "%s " fmt, KBUILD_MODNAME
+
+#include <linux/atomic.h>
+#include <linux/delay.h>
+#include <linux/export.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include <soc/qcom/tcs.h>
+#include <dt-bindings/soc/qcom,rpmh-rsc.h>
+
+#include "rpmh-internal.h"
+
+#define RSC_DRV_TCS_OFFSET		672
+#define RSC_DRV_CMD_OFFSET		20
+
+/* DRV Configuration Information Register */
+#define DRV_PRNT_CHLD_CONFIG		0x0C
+#define DRV_NUM_TCS_MASK		0x3F
+#define DRV_NUM_TCS_SHIFT		6
+#define DRV_NCPT_MASK			0x1F
+#define DRV_NCPT_SHIFT			27
+
+/* Register offsets */
+#define RSC_DRV_IRQ_ENABLE		0x00
+#define RSC_DRV_IRQ_STATUS		0x04
+#define RSC_DRV_IRQ_CLEAR		0x08
+#define RSC_DRV_CMD_WAIT_FOR_CMPL	0x10
+#define RSC_DRV_CONTROL			0x14
+#define RSC_DRV_STATUS			0x18
+#define RSC_DRV_CMD_ENABLE		0x1C
+#define RSC_DRV_CMD_MSGID		0x30
+#define RSC_DRV_CMD_ADDR		0x34
+#define RSC_DRV_CMD_DATA		0x38
+#define RSC_DRV_CMD_STATUS		0x3C
+#define RSC_DRV_CMD_RESP_DATA		0x40
+
+#define TCS_AMC_MODE_ENABLE		BIT(16)
+#define TCS_AMC_MODE_TRIGGER		BIT(24)
+
+/* TCS CMD register bit mask */
+#define CMD_MSGID_LEN			8
+#define CMD_MSGID_RESP_REQ		BIT(8)
+#define CMD_MSGID_WRITE			BIT(16)
+#define CMD_STATUS_ISSUED		BIT(8)
+#define CMD_STATUS_COMPL		BIT(16)
+
+static u32 read_tcs_reg(struct rsc_drv *drv, int reg, int tcs_id, int cmd_id)
+{
+	return readl_relaxed(drv->tcs_base + reg + RSC_DRV_TCS_OFFSET * tcs_id +
+			     RSC_DRV_CMD_OFFSET * cmd_id);
+}
+
+static void write_tcs_cmd(struct rsc_drv *drv, int reg, int tcs_id, int cmd_id,
+			  u32 data)
+{
+	writel_relaxed(data, drv->tcs_base + reg + RSC_DRV_TCS_OFFSET * tcs_id +
+		       RSC_DRV_CMD_OFFSET * cmd_id);
+}
+
+static void write_tcs_reg(struct rsc_drv *drv, int reg, int tcs_id, u32 data)
+{
+	writel_relaxed(data, drv->tcs_base + reg + RSC_DRV_TCS_OFFSET * tcs_id);
+}
+
+static void write_tcs_reg_sync(struct rsc_drv *drv, int reg, int tcs_id,
+			       u32 data)
+{
+	writel(data, drv->tcs_base + reg + RSC_DRV_TCS_OFFSET * tcs_id);
+	for (;;) {
+		if (data == readl(drv->tcs_base + reg +
+				  RSC_DRV_TCS_OFFSET * tcs_id))
+			break;
+		udelay(1);
+	}
+}
+
+static bool tcs_is_free(struct rsc_drv *drv, int tcs_id)
+{
+	return !test_bit(tcs_id, drv->tcs_in_use) &&
+	       read_tcs_reg(drv, RSC_DRV_STATUS, tcs_id, 0);
+}
+
+static struct tcs_group *get_tcs_of_type(struct rsc_drv *drv, int type)
+{
+	return &drv->tcs[type];
+}
+
+static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
+					 const struct tcs_request *msg)
+{
+	int type;
+
+	switch (msg->state) {
+	case RPMH_ACTIVE_ONLY_STATE:
+		type = ACTIVE_TCS;
+		break;
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+
+	return get_tcs_of_type(drv, type);
+}
+
+static const struct tcs_request *get_req_from_tcs(struct rsc_drv *drv,
+						  int tcs_id)
+{
+	struct tcs_group *tcs;
+	int i;
+
+	for (i = 0; i < drv->num_tcs; i++) {
+		tcs = &drv->tcs[i];
+		if (tcs->mask & BIT(tcs_id))
+			return tcs->req[tcs_id - tcs->offset];
+	}
+
+	return NULL;
+}
+
+/**
+ * tcs_tx_done: TX Done interrupt handler
+ */
+static irqreturn_t tcs_tx_done(int irq, void *p)
+{
+	struct rsc_drv *drv = p;
+	int i, j;
+	unsigned long irq_status;
+	const struct tcs_request *req;
+	struct tcs_cmd *cmd;
+
+	irq_status = read_tcs_reg(drv, RSC_DRV_IRQ_STATUS, 0, 0);
+
+	for_each_set_bit(i, &irq_status, BITS_PER_LONG) {
+		req = get_req_from_tcs(drv, i);
+		if (!req) {
+			WARN_ON(1);
+			goto skip;
+		}
+
+		for (j = 0; j < req->num_cmds; j++) {
+			u32 sts;
+
+			cmd = &req->cmds[j];
+			sts = read_tcs_reg(drv, RSC_DRV_CMD_STATUS, i, j);
+			if (!(sts & CMD_STATUS_ISSUED) ||
+			   ((req->wait_for_compl || cmd->wait) &&
+			   !(sts & CMD_STATUS_COMPL))) {
+				pr_err("Incomplete request: %s: addr=%#x data=%#x",
+				       drv->name, cmd->addr, cmd->data);
+			}
+		}
+skip:
+		/* Reclaim the TCS */
+		write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, i, 0);
+		write_tcs_reg(drv, RSC_DRV_IRQ_CLEAR, 0, BIT(i));
+		spin_lock(&drv->lock);
+		clear_bit(i, drv->tcs_in_use);
+		spin_unlock(&drv->lock);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
+			       const struct tcs_request *msg)
+{
+	u32 msgid, cmd_msgid;
+	u32 cmd_enable = 0;
+	u32 cmd_complete;
+	struct tcs_cmd *cmd;
+	int i, j;
+
+	cmd_msgid = CMD_MSGID_LEN;
+	cmd_msgid |= msg->wait_for_compl ? CMD_MSGID_RESP_REQ : 0;
+	cmd_msgid |= CMD_MSGID_WRITE;
+
+	cmd_complete = read_tcs_reg(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, tcs_id, 0);
+
+	for (i = 0, j = cmd_id; i < msg->num_cmds; i++, j++) {
+		cmd = &msg->cmds[i];
+		cmd_enable |= BIT(j);
+		cmd_complete |= cmd->wait << j;
+		msgid = cmd_msgid;
+		msgid |= cmd->wait ? CMD_MSGID_RESP_REQ : 0;
+		write_tcs_cmd(drv, RSC_DRV_CMD_MSGID, tcs_id, j, msgid);
+		write_tcs_cmd(drv, RSC_DRV_CMD_ADDR, tcs_id, j, cmd->addr);
+		write_tcs_cmd(drv, RSC_DRV_CMD_DATA, tcs_id, j, cmd->data);
+	}
+
+	write_tcs_reg(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, tcs_id, cmd_complete);
+	cmd_enable |= read_tcs_reg(drv, RSC_DRV_CMD_ENABLE, tcs_id, 0);
+	write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, tcs_id, cmd_enable);
+}
+
+static void __tcs_trigger(struct rsc_drv *drv, int tcs_id)
+{
+	u32 enable;
+
+	/*
+	 * HW req: Clear the DRV_CONTROL and enable TCS again
+	 * While clearing ensure that the AMC mode trigger is cleared
+	 * and then the mode enable is cleared.
+	 */
+	enable = read_tcs_reg(drv, RSC_DRV_CONTROL, tcs_id, 0);
+	enable &= ~TCS_AMC_MODE_TRIGGER;
+	write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
+	enable &= ~TCS_AMC_MODE_ENABLE;
+	write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
+
+	/* Enable the AMC mode on the TCS and then trigger the TCS */
+	enable = TCS_AMC_MODE_ENABLE;
+	write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
+	enable |= TCS_AMC_MODE_TRIGGER;
+	write_tcs_reg_sync(drv, RSC_DRV_CONTROL, tcs_id, enable);
+}
+
+static int check_for_req_inflight(struct rsc_drv *drv, struct tcs_group *tcs,
+				  const struct tcs_request *msg)
+{
+	unsigned long curr_enabled;
+	u32 addr;
+	int i, j, k;
+	int tcs_id = tcs->offset;
+
+	for (i = 0; i < tcs->num_tcs; i++, tcs_id++) {
+		if (tcs_is_free(drv, tcs_id))
+			continue;
+
+		curr_enabled = read_tcs_reg(drv, RSC_DRV_CMD_ENABLE, tcs_id, 0);
+
+		for_each_set_bit(j, &curr_enabled, MAX_CMDS_PER_TCS) {
+			addr = read_tcs_reg(drv, RSC_DRV_CMD_ADDR, tcs_id, j);
+			for (k = 0; k < msg->num_cmds; k++) {
+				if (addr == msg->cmds[k].addr)
+					return -EBUSY;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int find_free_tcs(struct tcs_group *tcs)
+{
+	int i;
+
+	for (i = 0; i < tcs->num_tcs; i++) {
+		if (tcs_is_free(tcs->drv, tcs->offset + i))
+			return tcs->offset + i;
+	}
+
+	return -EBUSY;
+}
+
+static int tcs_write(struct rsc_drv *drv, const struct tcs_request *msg)
+{
+	struct tcs_group *tcs;
+	int tcs_id;
+	unsigned long flags;
+	int ret;
+
+	tcs = get_tcs_for_msg(drv, msg);
+	if (IS_ERR(tcs))
+		return PTR_ERR(tcs);
+
+	spin_lock_irqsave(&tcs->lock, flags);
+	spin_lock(&drv->lock);
+	/*
+	 * The h/w does not like if we send a request to the same address,
+	 * when one is already in-flight or being processed.
+	 */
+	ret = check_for_req_inflight(drv, tcs, msg);
+	if (ret) {
+		spin_unlock(&drv->lock);
+		goto done_write;
+	}
+
+	tcs_id = find_free_tcs(tcs);
+	if (tcs_id < 0) {
+		ret = tcs_id;
+		spin_unlock(&drv->lock);
+		goto done_write;
+	}
+
+	tcs->req[tcs_id - tcs->offset] = msg;
+	set_bit(tcs_id, drv->tcs_in_use);
+	spin_unlock(&drv->lock);
+
+	__tcs_buffer_write(drv, tcs_id, 0, msg);
+	__tcs_trigger(drv, tcs_id);
+
+done_write:
+	spin_unlock_irqrestore(&tcs->lock, flags);
+	return ret;
+}
+
+/**
+ * rpmh_rsc_send_data: Validate the incoming message and write to the
+ * appropriate TCS block.
+ *
+ * @drv: the controller
+ * @msg: the data to be sent
+ *
+ * Return: 0 on success, -EINVAL on error.
+ * Note: This call blocks until a valid data is written to the TCS.
+ */
+int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
+{
+	int ret;
+
+	if (!msg || !msg->cmds || !msg->num_cmds ||
+	    msg->num_cmds > MAX_RPMH_PAYLOAD) {
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	do {
+		ret = tcs_write(drv, msg);
+		if (ret == -EBUSY) {
+			pr_info_ratelimited("TCS Busy, retrying RPMH message send: addr=%#x\n",
+					    msg->cmds[0].addr);
+			udelay(10);
+		}
+	} while (ret == -EBUSY);
+
+	return ret;
+}
+EXPORT_SYMBOL(rpmh_rsc_send_data);
+
+static int rpmh_probe_tcs_config(struct platform_device *pdev,
+				 struct rsc_drv *drv)
+{
+	struct tcs_type_config {
+		u32 type;
+		u32 n;
+	} tcs_cfg[TCS_TYPE_NR] = { { 0 } };
+	struct device_node *dn = pdev->dev.of_node;
+	u32 config, max_tcs, ncpt, offset;
+	int i, ret, n, st = 0;
+	struct tcs_group *tcs;
+	struct resource *res;
+	void __iomem *base;
+	char drv_id[10] = {0};
+
+	snprintf(drv_id, ARRAY_SIZE(drv_id), "drv-%d", drv->id);
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, drv_id);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	ret = of_property_read_u32(dn, "qcom,tcs-offset", &offset);
+	if (ret)
+		return ret;
+	drv->tcs_base = base + offset;
+
+	config = readl_relaxed(base + DRV_PRNT_CHLD_CONFIG);
+
+	max_tcs = config;
+	max_tcs &= DRV_NUM_TCS_MASK << (DRV_NUM_TCS_SHIFT * drv->id);
+	max_tcs = max_tcs >> (DRV_NUM_TCS_SHIFT * drv->id);
+
+	ncpt = config & (DRV_NCPT_MASK << DRV_NCPT_SHIFT);
+	ncpt = ncpt >> DRV_NCPT_SHIFT;
+
+	n = of_property_count_u32_elems(dn, "qcom,tcs-config");
+	if (n != 2 * TCS_TYPE_NR)
+		return -EINVAL;
+
+	for (i = 0; i < TCS_TYPE_NR; i++) {
+		ret = of_property_read_u32_index(dn, "qcom,tcs-config",
+						 i * 2, &tcs_cfg[i].type);
+		if (ret)
+			return ret;
+		if (tcs_cfg[i].type >= TCS_TYPE_NR)
+			return -EINVAL;
+
+		ret = of_property_read_u32_index(dn, "qcom,tcs-config",
+						 i * 2 + 1, &tcs_cfg[i].n);
+		if (ret)
+			return ret;
+		if (tcs_cfg[i].n > MAX_TCS_PER_TYPE)
+			return -EINVAL;
+	}
+
+	for (i = 0; i < TCS_TYPE_NR; i++) {
+		tcs = &drv->tcs[tcs_cfg[i].type];
+		if (tcs->drv)
+			return -EINVAL;
+		tcs->drv = drv;
+		tcs->type = tcs_cfg[i].type;
+		tcs->num_tcs = tcs_cfg[i].n;
+		tcs->ncpt = ncpt;
+		spin_lock_init(&tcs->lock);
+
+		if (!tcs->num_tcs || tcs->type == CONTROL_TCS)
+			continue;
+
+		if (st + tcs->num_tcs > max_tcs ||
+		    st + tcs->num_tcs >= BITS_PER_BYTE * sizeof(tcs->mask))
+			return -EINVAL;
+
+		tcs->mask = ((1 << tcs->num_tcs) - 1) << st;
+		tcs->offset = st;
+		st += tcs->num_tcs;
+	}
+
+	drv->num_tcs = st;
+
+	return 0;
+}
+
+static int rpmh_rsc_probe(struct platform_device *pdev)
+{
+	struct device_node *dn = pdev->dev.of_node;
+	struct rsc_drv *drv;
+	int ret, irq;
+
+	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
+	if (!drv)
+		return -ENOMEM;
+
+	ret = of_property_read_u32(dn, "qcom,drv-id", &drv->id);
+	if (ret)
+		return ret;
+
+	drv->name = of_get_property(dn, "label", NULL);
+	if (!drv->name)
+		drv->name = dev_name(&pdev->dev);
+
+	ret = rpmh_probe_tcs_config(pdev, drv);
+	if (ret)
+		return ret;
+
+	spin_lock_init(&drv->lock);
+	bitmap_zero(drv->tcs_in_use, MAX_TCS_NR);
+
+	irq = platform_get_irq(pdev, drv->id);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_irq(&pdev->dev, irq, tcs_tx_done,
+			       IRQF_TRIGGER_HIGH | IRQF_NO_SUSPEND,
+			       drv->name, drv);
+	if (ret)
+		return ret;
+
+	/* Enable the active TCS to send requests immediately */
+	write_tcs_reg(drv, RSC_DRV_IRQ_ENABLE, 0, drv->tcs[ACTIVE_TCS].mask);
+
+	return devm_of_platform_populate(&pdev->dev);
+}
+
+static const struct of_device_id rpmh_drv_match[] = {
+	{ .compatible = "qcom,rpmh-rsc", },
+	{ }
+};
+
+static struct platform_driver rpmh_driver = {
+	.probe = rpmh_rsc_probe,
+	.driver = {
+		  .name = "rpmh",
+		  .of_match_table = rpmh_drv_match,
+	},
+};
+
+static int __init rpmh_driver_init(void)
+{
+	return platform_driver_register(&rpmh_driver);
+}
+arch_initcall(rpmh_driver_init);
diff --git a/include/dt-bindings/soc/qcom,rpmh-rsc.h b/include/dt-bindings/soc/qcom,rpmh-rsc.h
new file mode 100644
index 000000000000..868f998ea998
--- /dev/null
+++ b/include/dt-bindings/soc/qcom,rpmh-rsc.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __DT_QCOM_RPMH_RSC_H__
+#define __DT_QCOM_RPMH_RSC_H__
+
+#define SLEEP_TCS	0
+#define WAKE_TCS	1
+#define ACTIVE_TCS	2
+#define CONTROL_TCS	3
+
+#endif /* __DT_QCOM_RPMH_RSC_H__ */
diff --git a/include/soc/qcom/tcs.h b/include/soc/qcom/tcs.h
new file mode 100644
index 000000000000..262876a59e86
--- /dev/null
+++ b/include/soc/qcom/tcs.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __SOC_QCOM_TCS_H__
+#define __SOC_QCOM_TCS_H__
+
+#define MAX_RPMH_PAYLOAD	16
+
+/**
+ * rpmh_state: state for the request
+ *
+ * RPMH_SLEEP_STATE:       State of the resource when the processor subsystem
+ *                         is powered down. There is no client using the
+ *                         resource actively.
+ * RPMH_WAKE_ONLY_STATE:   Resume resource state to the value previously
+ *                         requested before the processor was powered down.
+ * RPMH_ACTIVE_ONLY_STATE: Active or AMC mode requests. Resource state
+ *                         is aggregated immediately.
+ */
+enum rpmh_state {
+	RPMH_SLEEP_STATE,
+	RPMH_WAKE_ONLY_STATE,
+	RPMH_ACTIVE_ONLY_STATE,
+};
+
+/**
+ * struct tcs_cmd: an individual request to RPMH.
+ *
+ * @addr: the address of the resource slv_id:18:16 | offset:0:15
+ * @data: the resource state request
+ * @wait: wait for this request to be complete before sending the next
+ */
+struct tcs_cmd {
+	u32 addr;
+	u32 data;
+	u32 wait;
+};
+
+/**
+ * struct tcs_request: A set of tcs_cmds sent together in a TCS
+ *
+ * @state:          state for the request.
+ * @wait_for_compl: wait until we get a response from the h/w accelerator
+ * @num_cmds:       the number of @cmds in this request
+ * @cmds:           an array of tcs_cmds
+ */
+struct tcs_request {
+	enum rpmh_state state;
+	u32 wait_for_compl;
+	u32 num_cmds;
+	struct tcs_cmd *cmds;
+};
+
+#endif /* __SOC_QCOM_TCS_H__ */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
