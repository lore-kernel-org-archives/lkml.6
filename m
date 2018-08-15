Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AEBC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 09:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C4B2168D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 09:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C4B2168D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbeHOM1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 08:27:44 -0400
Received: from exmail.andestech.com ([59.124.169.137]:14840 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729013AbeHOM1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 08:27:44 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w7F9YVB2011328;
        Wed, 15 Aug 2018 17:34:31 +0800 (GMT-8)
        (envelope-from zong@andestech.com)
Received: from atcsqa06.andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Wed, 15 Aug 2018
 17:35:55 +0800
From:   Zong Li <zong@andestech.com>
To:     <green.hu@gmail.com>, <deanbo422@gmail.com>, <rostedt@goodmis.org>,
        <mingo@redhat.com>, <arnd@arndb.de>, <linux-kernel@vger.kernel.org>
CC:     <zongbox@gmail.com>, <greentime@andestech.com>,
        Zong Li <zong@andestech.com>
Subject: [PATCH 6/6] nds32/stack: Get real return address by using ftrace_graph_ret_addr
Date:   Wed, 15 Aug 2018 17:35:23 +0800
Message-ID: <bf2a5d75b9ab5767cdcd4a85866088848810305e.1534323834.git.zong@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1534323834.git.zong@andestech.com>
References: <cover.1534323834.git.zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w7F9YVB2011328
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function graph tracer has modified the return address to
'return_to_handler' on stack, and provide the 'ftrace_graph_ret_addr' to
get the real return address.

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/nds32/kernel/stacktrace.c |  4 ++++
 arch/nds32/kernel/traps.c      | 30 ++++++------------------------
 2 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/arch/nds32/kernel/stacktrace.c b/arch/nds32/kernel/stacktrace.c
index 8b231e9..36bc870 100644
--- a/arch/nds32/kernel/stacktrace.c
+++ b/arch/nds32/kernel/stacktrace.c
@@ -4,6 +4,7 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
 #include <linux/stacktrace.h>
+#include <linux/ftrace.h>
 
 void save_stack_trace(struct stack_trace *trace)
 {
@@ -16,6 +17,7 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 	unsigned long *fpn;
 	int skip = trace->skip;
 	int savesched;
+	int graph_idx = 0;
 
 	if (tsk == current) {
 		__asm__ __volatile__("\tori\t%0, $fp, #0\n":"=r"(fpn));
@@ -33,6 +35,8 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 		fpp = fpn[FP_OFFSET];
 		if (!__kernel_text_address(lpp))
 			break;
+		else
+			lpp = ftrace_graph_ret_addr(tsk, &graph_idx, lpp, NULL);
 
 		if (savesched || !in_sched_functions(lpp)) {
 			if (skip) {
diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
index f0e9743..7684c8f 100644
--- a/arch/nds32/kernel/traps.c
+++ b/arch/nds32/kernel/traps.c
@@ -8,6 +8,7 @@
 #include <linux/kdebug.h>
 #include <linux/sched/task_stack.h>
 #include <linux/uaccess.h>
+#include <linux/ftrace.h>
 
 #include <asm/proc-fns.h>
 #include <asm/unistd.h>
@@ -94,28 +95,6 @@ static void dump_instr(struct pt_regs *regs)
 	set_fs(fs);
 }
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-#include <linux/ftrace.h>
-static void
-get_real_ret_addr(unsigned long *addr, struct task_struct *tsk, int *graph)
-{
-	if (*addr == (unsigned long)return_to_handler) {
-		int index = tsk->curr_ret_stack;
-
-		if (tsk->ret_stack && index >= *graph) {
-			index -= *graph;
-			*addr = tsk->ret_stack[index].ret;
-			(*graph)++;
-		}
-	}
-}
-#else
-static inline void
-get_real_ret_addr(unsigned long *addr, struct task_struct *tsk, int *graph)
-{
-}
-#endif
-
 #define LOOP_TIMES (100)
 static void __dump(struct task_struct *tsk, unsigned long *base_reg)
 {
@@ -126,7 +105,8 @@ static void __dump(struct task_struct *tsk, unsigned long *base_reg)
 		while (!kstack_end(base_reg)) {
 			ret_addr = *base_reg++;
 			if (__kernel_text_address(ret_addr)) {
-				get_real_ret_addr(&ret_addr, tsk, &graph);
+				ret_addr = ftrace_graph_ret_addr(
+						tsk, &graph, ret_addr, NULL);
 				print_ip_sym(ret_addr);
 			}
 			if (--cnt < 0)
@@ -145,7 +125,9 @@ static void __dump(struct task_struct *tsk, unsigned long *base_reg)
 			next_fp = base_reg[FP_OFFSET];
 #endif
 			if (__kernel_text_address(ret_addr)) {
-				get_real_ret_addr(&ret_addr, tsk, &graph);
+
+				ret_addr = ftrace_graph_ret_addr(
+						tsk, &graph, ret_addr, NULL);
 				print_ip_sym(ret_addr);
 			}
 			if (--cnt < 0)
-- 
2.7.4

