Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_SIGNED,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D67C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7524B20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="orJzvHmL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jlv5mySo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7524B20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937919AbeFSNMD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:12:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33852 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937879AbeFSNL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:11:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 947F460AFF; Tue, 19 Jun 2018 13:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529413917;
        bh=glYs8JNMS+7ouIsW4Cqhc3hhbaNzzbRgftm4Ucph9A8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=orJzvHmLw3ioq2tVeCvzbzXefBREwAlx1qeS9jY/c2UTQ8PRDHjkysLIjjyp0jK6y
         pTOkVoNJTRggqTKwfdwH22O7iRp7/gviEuCk2SyUOzj6aAoat3hng4Hh5b6j1U0/HJ
         8LWv0yFGHn0zFnBTUPmrPYSx++PoWv/ujZ7sUAiI=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BD51A604A6;
        Tue, 19 Jun 2018 13:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529413916;
        bh=glYs8JNMS+7ouIsW4Cqhc3hhbaNzzbRgftm4Ucph9A8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jlv5mySob3COLT3tlWn3ZrfbKRLDs+GOl2bwvqW8jIO8y3K4FX4XuilMUDYn0S+Dy
         NTbSuAeuxeD/jfYYgOB8js8OrA7KKSo539ffCFcWj9MOWbYbUNg6Sy0WU/3oi5gF4L
         GZVJ68vGw2YCGqh5TaKH7yvvUUqk4Hd8PolI0Bwc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BD51A604A6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   Raju P L S S S N <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org
Subject: [PATCH v12 03/10] drivers: qcom: rpmh-rsc: log RPMH requests in FTRACE
Date:   Tue, 19 Jun 2018 18:41:26 +0530
Message-Id: <1529413893-5520-4-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529413893-5520-1-git-send-email-rplsssn@codeaurora.org>
References: <1529413893-5520-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lina Iyer <ilina@codeaurora.org>

Log sent RPMH requests and interrupt responses in FTRACE.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
[rplsssn@codeaurora.org: rebase to v4.18-rc1 & fix merge conflict]
---

Changes in v7:
	- varible name changes and white space

Changes in v6:
	- struct tcs_response was removed. Fix in trace as well.
Changes in v4:
	- fix compilation issues, use __assign_str
	- use %#x instead of 0x%08x
Changes in v3:
	- Use __string() instead of char *
	- fix TRACE_INCLUDE_PATH

Conflicts:
	drivers/soc/qcom/Makefile
---
 drivers/soc/qcom/Makefile     |  1 +
 drivers/soc/qcom/rpmh-rsc.c   | 11 +++++-
 drivers/soc/qcom/trace-rpmh.h | 82 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/qcom/trace-rpmh.h

diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 4724917..fa90171 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+CFLAGS_rpmh-rsc.o := -I$(src)
 obj-$(CONFIG_QCOM_GENI_SE) +=	qcom-geni-se.o
 obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
 obj-$(CONFIG_QCOM_GLINK_SSR) +=	glink_ssr.o
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index c5e0793..89d41cd 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -23,6 +23,9 @@
 
 #include "rpmh-internal.h"
 
+#define CREATE_TRACE_POINTS
+#include "trace-rpmh.h"
+
 #define RSC_DRV_TCS_OFFSET		672
 #define RSC_DRV_CMD_OFFSET		20
 
@@ -135,7 +138,7 @@ static const struct tcs_request *get_req_from_tcs(struct rsc_drv *drv,
 static irqreturn_t tcs_tx_done(int irq, void *p)
 {
 	struct rsc_drv *drv = p;
-	int i, j;
+	int i, j, err;
 	unsigned long irq_status;
 	const struct tcs_request *req;
 	struct tcs_cmd *cmd;
@@ -149,6 +152,7 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
 			goto skip;
 		}
 
+		err = 0;
 		for (j = 0; j < req->num_cmds; j++) {
 			u32 sts;
 
@@ -159,8 +163,11 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
 			   !(sts & CMD_STATUS_COMPL))) {
 				pr_err("Incomplete request: %s: addr=%#x data=%#x",
 				       drv->name, cmd->addr, cmd->data);
+				err = -EIO;
 			}
 		}
+
+		trace_rpmh_tx_done(drv, i, req, err);
 skip:
 		/* Reclaim the TCS */
 		write_tcs_reg(drv, RSC_DRV_CMD_ENABLE, i, 0);
@@ -194,9 +201,11 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
 		cmd_complete |= cmd->wait << j;
 		msgid = cmd_msgid;
 		msgid |= cmd->wait ? CMD_MSGID_RESP_REQ : 0;
+
 		write_tcs_cmd(drv, RSC_DRV_CMD_MSGID, tcs_id, j, msgid);
 		write_tcs_cmd(drv, RSC_DRV_CMD_ADDR, tcs_id, j, cmd->addr);
 		write_tcs_cmd(drv, RSC_DRV_CMD_DATA, tcs_id, j, cmd->data);
+		trace_rpmh_send_msg(drv, tcs_id, j, msgid, cmd);
 	}
 
 	write_tcs_reg(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, tcs_id, cmd_complete);
diff --git a/drivers/soc/qcom/trace-rpmh.h b/drivers/soc/qcom/trace-rpmh.h
new file mode 100644
index 0000000..feb0cb4
--- /dev/null
+++ b/drivers/soc/qcom/trace-rpmh.h
@@ -0,0 +1,82 @@
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
+	TP_PROTO(struct rsc_drv *d, int m, int n, u32 h,
+		 const struct tcs_cmd *c),
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
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

