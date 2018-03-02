Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161292AbeCBQnt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:43:49 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40896 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967977AbeCBQnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:43:35 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A37566072E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From: Lina Iyer <ilina@codeaurora.org>
To: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v3 03/10] drivers: qcom: rpmh-rsc: log RPMH requests in FTRACE
Date: Fri,  2 Mar 2018 09:43:10 -0700
Message-Id: <20180302164317.10554-4-ilina@codeaurora.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302164317.10554-1-ilina@codeaurora.org>
References: <20180302164317.10554-1-ilina@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Log sent RPMH requests and interrupt responses in FTRACE.

Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---

Changes in v3:
	- Use __string() instead of char *
	- fix TRACE_INCLUDE_PATH
---
 drivers/soc/qcom/Makefile     |  1 +
 drivers/soc/qcom/rpmh-rsc.c   |  6 +++
 drivers/soc/qcom/trace-rpmh.h | 89 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+)
 create mode 100644 drivers/soc/qcom/trace-rpmh.h

diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index e7d04f0e3616..bb013d56b5a1 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+CFLAGS_rpmh-rsc.o := -I$(src)
 obj-$(CONFIG_QCOM_GLINK_SSR) +=	glink_ssr.o
 obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
 obj-$(CONFIG_QCOM_MDT_LOADER)	+= mdt_loader.o
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 6cb91a0114ee..4322e23a2ba6 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -24,6 +24,9 @@
 
 #include "rpmh-internal.h"
 
+#define CREATE_TRACE_POINTS
+#include "trace-rpmh.h"
+
 #define RSC_DRV_TCS_OFFSET		672
 #define RSC_DRV_CMD_OFFSET		20
 
@@ -239,6 +242,7 @@ static irqreturn_t tcs_irq_handler(int irq, void *p)
 		/* Reclaim the TCS */
 		write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, m, 0, 0);
 		write_tcs_reg(drv, RSC_DRV_IRQ_CLEAR, 0, 0, BIT(m));
+		trace_rpmh_notify_irq(drv, resp);
 		atomic_set(&drv->tcs_in_use[m], 0);
 		send_tcs_response(resp);
 	}
@@ -270,6 +274,7 @@ static void tcs_notify_tx_done(unsigned long data)
 				       struct tcs_response, list);
 		list_del(&resp->list);
 		spin_unlock_irqrestore(&drv->drv_lock, flags);
+		trace_rpmh_notify_tx_done(drv, resp);
 		free_response(resp);
 	}
 }
@@ -298,6 +303,7 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int m, int n,
 		write_tcs_reg(drv, RSC_DRV_CMD_MSGID, m, j, msgid);
 		write_tcs_reg(drv, RSC_DRV_CMD_ADDR, m, j, cmd->addr);
 		write_tcs_reg(drv, RSC_DRV_CMD_DATA, m, j, cmd->data);
+		trace_rpmh_send_msg(drv, m, j, msgid, cmd);
 	}
 
 	write_tcs_reg(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, m, 0, cmd_complete);
diff --git a/drivers/soc/qcom/trace-rpmh.h b/drivers/soc/qcom/trace-rpmh.h
new file mode 100644
index 000000000000..b23ad8457224
--- /dev/null
+++ b/drivers/soc/qcom/trace-rpmh.h
@@ -0,0 +1,89 @@
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
+DECLARE_EVENT_CLASS(rpmh_notify,
+
+	TP_PROTO(struct rsc_drv *d, struct tcs_response *r),
+
+	TP_ARGS(d, r),
+
+	TP_STRUCT__entry(
+		__string(name, d->name)
+		__field(int, m)
+		__field(u32, addr)
+		__field(int, errno)
+	),
+
+	TP_fast_assign(
+		__assign_string(name, d->name);
+		__entry->m = r->m;
+		__entry->addr = r->msg->payload[0].addr;
+		__entry->errno = r->err;
+	),
+
+	TP_printk("%s: ack: tcs-m:%d addr: 0x%08x errno: %d",
+		 __get_str(name), __entry->m, __entry->addr, __entry->errno)
+);
+
+DEFINE_EVENT(rpmh_notify, rpmh_notify_irq,
+	TP_PROTO(struct rsc_drv *d, struct tcs_response *r),
+	TP_ARGS(d, r)
+);
+
+DEFINE_EVENT(rpmh_notify, rpmh_notify_tx_done,
+	TP_PROTO(struct rsc_drv *d, struct tcs_response *r),
+	TP_ARGS(d, r)
+);
+
+
+TRACE_EVENT(rpmh_send_msg,
+
+	TP_PROTO(struct rsc_drv *d, int m, int n, u32 h, struct tcs_cmd *c),
+
+	TP_ARGS(d, m, n, h, c),
+
+	TP_STRUCT__entry(
+		__string(name, d->name)
+		__field(int, m)
+		__field(int, n)
+		__field(u32, hdr)
+		__field(u32, addr)
+		__field(u32, data)
+		__field(bool, complete)
+	),
+
+	TP_fast_assign(
+		__assign_string(name, d->name);
+		__entry->m = m;
+		__entry->n = n;
+		__entry->hdr = h;
+		__entry->addr = c->addr;
+		__entry->data = c->data;
+		__entry->complete = c->complete;
+	),
+
+	TP_printk("%s: send-msg: tcs(m): %d cmd(n): %d msgid: 0x%08x addr: 0x%08x data: 0x%08x complete: %d",
+			__get_str(name), __entry->m, __entry->n, __entry->hdr,
+			__entry->addr, __entry->data, __entry->complete)
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
