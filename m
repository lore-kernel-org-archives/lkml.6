Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB01FC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 09:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1B62168D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 09:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1B62168D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbeHOM1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 08:27:31 -0400
Received: from exmail.andestech.com ([59.124.169.137]:56943 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729013AbeHOM1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 08:27:30 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w7F9YBxt011249;
        Wed, 15 Aug 2018 17:34:11 +0800 (GMT-8)
        (envelope-from zong@andestech.com)
Received: from atcsqa06.andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Wed, 15 Aug 2018
 17:35:35 +0800
From:   Zong Li <zong@andestech.com>
To:     <green.hu@gmail.com>, <deanbo422@gmail.com>, <rostedt@goodmis.org>,
        <mingo@redhat.com>, <arnd@arndb.de>, <linux-kernel@vger.kernel.org>
CC:     <zongbox@gmail.com>, <greentime@andestech.com>,
        Zong Li <zong@andestech.com>
Subject: [PATCH 2/6] nds32/ftrace: Support static function graph tracer
Date:   Wed, 15 Aug 2018 17:35:19 +0800
Message-ID: <86f20b97f95b0e9ab6301368acb0f6f31b9ae276.1534323834.git.zong@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1534323834.git.zong@andestech.com>
References: <cover.1534323834.git.zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w7F9YBxt011249
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains implementation of static function graph tracer.

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/nds32/Kconfig         |  1 +
 arch/nds32/kernel/ftrace.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index af30e1a..ae1a94ca 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -41,6 +41,7 @@ config NDS32
 	select RTC_LIB
 	select THREAD_INFO_IN_TASK
 	select HAVE_FUNCTION_TRACER
+	select HAVE_FUNCTION_GRAPH_TRACER
 	help
 	  Andes(nds32) Linux support.
 
diff --git a/arch/nds32/kernel/ftrace.c b/arch/nds32/kernel/ftrace.c
index 563f64c..707fce7 100644
--- a/arch/nds32/kernel/ftrace.c
+++ b/arch/nds32/kernel/ftrace.c
@@ -6,6 +6,8 @@
 
 extern void (*ftrace_trace_function)(unsigned long, unsigned long,
 				     struct ftrace_ops*, struct pt_regs*);
+extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace);
+extern void ftrace_graph_caller(void);
 
 noinline void __naked ftrace_stub(unsigned long ip, unsigned long parent_ip,
 				  struct ftrace_ops *op, struct pt_regs *regs)
@@ -23,6 +25,73 @@ noinline void _mcount(unsigned long parent_ip)
 		ftrace_trace_function(ip - MCOUNT_INSN_SIZE, parent_ip,
 				      NULL, NULL);
 
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	if (ftrace_graph_return != (trace_func_graph_ret_t)ftrace_stub
+	    || ftrace_graph_entry != ftrace_graph_entry_stub)
+		ftrace_graph_caller();
+#endif
+
 	/* restore all state by the compiler epilogue */
 }
 EXPORT_SYMBOL(_mcount);
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
+			   unsigned long frame_pointer)
+{
+	unsigned long return_hooker = (unsigned long)&return_to_handler;
+	struct ftrace_graph_ent trace;
+	unsigned long old;
+	int err;
+
+	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+		return;
+
+	old = *parent;
+
+	trace.func = self_addr;
+	trace.depth = current->curr_ret_stack + 1;
+
+	/* Only trace if the calling function expects to */
+	if (!ftrace_graph_entry(&trace))
+		return;
+
+	err = ftrace_push_return_trace(old, self_addr, &trace.depth,
+				       frame_pointer, NULL);
+
+	if (err == -EBUSY)
+		return;
+
+	*parent = return_hooker;
+}
+
+noinline void ftrace_graph_caller(void)
+{
+	unsigned long *parent_ip =
+		(unsigned long *)(__builtin_frame_address(2) - 4);
+
+	unsigned long selfpc =
+		(unsigned long)(__builtin_return_address(1) - MCOUNT_INSN_SIZE);
+
+	unsigned long frame_pointer =
+		(unsigned long)__builtin_frame_address(3);
+
+	prepare_ftrace_return(parent_ip, selfpc, frame_pointer);
+}
+
+extern unsigned long ftrace_return_to_handler(unsigned long frame_pointer);
+void __naked return_to_handler(void)
+{
+	__asm__ __volatile__ (
+		/* save state needed by the ABI     */
+		"smw.adm $r0,[$sp],$r1,#0x0  \n\t"
+
+		/* get original return address      */
+		"move $r0, $fp               \n\t"
+		"bal ftrace_return_to_handler\n\t"
+		"move $lp, $r0               \n\t"
+
+		/* restore state nedded by the ABI  */
+		"lmw.bim $r0,[$sp],$r1,#0x0  \n\t");
+}
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-- 
2.7.4

