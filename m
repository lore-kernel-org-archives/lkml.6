Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753912AbeDSWQ4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 18:16:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57138 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753729AbeDSWQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 18:16:48 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 983BC6081C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v6 03/10] drivers: qcom: rpmh-rsc: log RPMH requests in FTRACE
Date: Thu, 19 Apr 2018 16:16:28 -0600
Message-Id: <20180419221635.17849-4-ilina@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419221635.17849-1-ilina@codeaurora.org>
References: <20180419221635.17849-1-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Log sent RPMH requests and interrupt responses in FTRACE.

Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---

Changes in v6:
	- struct tcs_response was removed. Fix in trace as well.
Changes in v4:
	- fix compilation issues, use __assign_str
	- use %#x instead of 0x%08x
Changes in v3:
	- Use __string() instead of char *
	- fix TRACE_INCLUDE_PATH
---
 drivers/soc/qcom/Makefile     |  1 +
 drivers/soc/qcom/rpmh-rsc.c   | 10 ++++-
 drivers/soc/qcom/trace-rpmh.h | 81 +++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/qcom/trace-rpmh.h

diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 39d3a059ee50..cb6300f6a8e9 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+CFLAGS_rpmh-rsc.o := -I$(src)
 obj-$(CONFIG_QCOM_GLINK_SSR) +=	glink_ssr.o
 obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
 obj-$(CONFIG_QCOM_MDT_LOADER)	+= mdt_loader.o
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 77ca9371cb85..9216ef478b81 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -24,6 +24,9 @@
 
 #include "rpmh-internal.h"
 
+#define CREATE_TRACE_POINTS
+#include "trace-rpmh.h"
+
 #define RSC_DRV_TCS_OFFSET		672
 #define RSC_DRV_CMD_OFFSET		20
 
@@ -132,7 +135,7 @@ static const struct tcs_request *get_req_from_tcs(struct rsc_drv *drv, int m)
 static irqreturn_t tcs_tx_done(int irq, void *p)
 {
 	struct rsc_drv *drv = p;
-	int m, i;
+	int m, i, err;
 	unsigned long irq_status;
 	const struct tcs_request *req;
 	struct tcs_cmd *cmd;
@@ -140,6 +143,7 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
 	irq_status = read_tcs_reg(drv, RSC_DRV_IRQ_STATUS, 0, 0);
 
 	for_each_set_bit(m, &irq_status, BITS_PER_LONG) {
+		err = 0;
 		req = get_req_from_tcs(drv, m);
 		if (!req) {
 			WARN_ON(1);
@@ -156,8 +160,11 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
 			   !(sts & CMD_STATUS_COMPL))) {
 				pr_err("Incomplete request: %s: addr=%#x data=%#x",
 				       drv->name, cmd->addr, cmd->data);
+				err = -EIO;
 			}
 		}
+
+		trace_rpmh_tx_done(drv, m, req, err);
 skip:
 		/* Reclaim the TCS */
 		write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, m, 0);
@@ -194,6 +201,7 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int m, int n,
 		write_tcs_cmd(drv, RSC_DRV_CMD_MSGID, m, j, msgid);
 		write_tcs_cmd(drv, RSC_DRV_CMD_ADDR, m, j, cmd->addr);
 		write_tcs_cmd(drv, RSC_DRV_CMD_DATA, m, j, cmd->data);
+		trace_rpmh_send_msg(drv, m, j, msgid, cmd);
 	}
 
 	write_tcs_reg(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, m, cmd_complete);
diff --git a/drivers/soc/qcom/trace-rpmh.h b/drivers/soc/qcom/trace-rpmh.h
new file mode 100644
index 000000000000..4d0934ce8f1c
--- /dev/null
+++ b/drivers/soc/qcom/trace-rpmh.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ */
+
+#if !defined(_TRACE_RPMH_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_RPMH_H
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM rpmh
+
+#include <linux/tracepoint.h>
+#include "rpmh-internal.h"
+
+TRACE_EVENT(rpmh_tx_done,
+
+	TP_PROTO(struct rsc_drv *d, int m, const struct tcs_request *r, int e),
+
+	TP_ARGS(d, m, r, e),
+
+	TP_STRUCT__entry(
+			 __string(name, d->name)
+			 __field(int, m)
+			 __field(u32, addr)
+			 __field(u32, data)
+			 __field(int, err)
+	),
+
+	TP_fast_assign(
+		       __assign_str(name, d->name);
+		       __entry->m = m;
+		       __entry->addr = r->cmds[0].addr;
+		       __entry->data = r->cmds[0].data;
+		       __entry->err = e;
+	),
+
+	TP_printk("%s: ack: tcs-m: %d addr: %#x data: %#x errno: %d",
+		  __get_str(name), __entry->m, __entry->addr, __entry->data,
+		  __entry->err)
+);
+
+TRACE_EVENT(rpmh_send_msg,
+
+	TP_PROTO(struct rsc_drv *d, int m, int n, u32 h, const struct tcs_cmd *c),
+
+	TP_ARGS(d, m, n, h, c),
+
+	TP_STRUCT__entry(
+			 __string(name, d->name)
+			 __field(int, m)
+			 __field(int, n)
+			 __field(u32, hdr)
+			 __field(u32, addr)
+			 __field(u32, data)
+			 __field(bool, wait)
+	),
+
+	TP_fast_assign(
+		       __assign_str(name, d->name);
+		       __entry->m = m;
+		       __entry->n = n;
+		       __entry->hdr = h;
+		       __entry->addr = c->addr;
+		       __entry->data = c->data;
+		       __entry->wait = c->wait;
+	),
+
+	TP_printk("%s: send-msg: tcs(m): %d cmd(n): %d msgid: %#x addr: %#x data: %#x complete: %d",
+		  __get_str(name), __entry->m, __entry->n, __entry->hdr,
+		  __entry->addr, __entry->data, __entry->wait)
+);
+
+#endif /* _TRACE_RPMH_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace-rpmh
+
+#include <trace/define_trace.h>
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
