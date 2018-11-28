Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFC8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 03:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBDD20989
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 03:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BBDD20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbeK1Okl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 09:40:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:41326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbeK1Okl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 09:40:41 -0500
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26C7D208E7;
        Wed, 28 Nov 2018 03:40:33 +0000 (UTC)
Date:   Tue, 27 Nov 2018 22:40:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] tracing: Fix fgraph design bug and sched_switch state
 output
Message-ID: <20181127224031.76681fe0@vmware.local.home>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

While rewriting the function graph tracer, I discovered a design flaw that
was introduced by a patch that tried to fix one bug, but by doing so created
another bug. As both bugs corrupt the output (but they do not crash the
kernel), I decided to fix the design such that it could have both bugs
fixed. The original fix, fixed time reporting of the function graph tracer
when doing a max_depth of one. This was code that can test how much the
kernel interferes with userspace. But in doing so, it could corrupt the time
keeping of the function profiler.

The issue is that the curr_ret_stack variable was being used for two
different meanings. One was to keep track of the stack pointer on the
ret_stack (shadow stack used by the function graph tracer), and the other
use case was the graph call depth.  Although, the two may be closely
related, where they got updated was the issue that lead to the two different
bugs that required the two use cases to be updated differently.

The big issue with this fix is that it requires changing each architecture.
The good news is, I was able to remove a lot of code that was duplicated
within the architectures and place it into a single location. Then I could
make the fix in one place.

I pushed this code into linux-next to let it settle over a week, and before
doing so, I cross compiled all the affected architectures to make sure that
they built fine.

In the mean time, I also pulled in a patch that fixes the sched_switch
previous tasks state output, that was not actually correct.


Please pull the latest trace-v4.20-rc3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v4.20-rc3

Tag SHA1: adc352569eb25f7a0ecb4785b595a85315074020
Head SHA1: 3054426dc68e5d63aa6a6e9b91ac4ec78e3f3805


Pavankumar Kondeti (1):
      sched, trace: Fix prev_state output in sched_switch tracepoint

Steven Rostedt (VMware) (18):
      function_graph: Create function_graph_enter() to consolidate architecture code
      x86/function_graph: Simplify with function_graph_enter()
      ARM: function_graph: Simplify with function_graph_enter()
      arm64: function_graph: Simplify with function_graph_enter()
      microblaze: function_graph: Simplify with function_graph_enter()
      MIPS: function_graph: Simplify with function_graph_enter()
      nds32: function_graph: Simplify with function_graph_enter()
      parisc: function_graph: Simplify with function_graph_enter()
      powerpc/function_graph: Simplify with function_graph_enter()
      riscv/function_graph: Simplify with function_graph_enter()
      s390/function_graph: Simplify with function_graph_enter()
      sh/function_graph: Simplify with function_graph_enter()
      sparc/function_graph: Simplify with function_graph_enter()
      function_graph: Make ftrace_push_return_trace() static
      function_graph: Use new curr_ret_depth to manage depth instead of curr_ret_stack
      function_graph: Move return callback before update of curr_ret_stack
      function_graph: Reverse the order of pushing the ret_stack and the callback
      function_graph: Have profiler use curr_ret_stack and not depth

----
 arch/arm/kernel/ftrace.c             | 17 +------------
 arch/arm64/kernel/ftrace.c           | 15 +----------
 arch/microblaze/kernel/ftrace.c      | 15 ++---------
 arch/mips/kernel/ftrace.c            | 14 ++---------
 arch/nds32/kernel/ftrace.c           | 18 ++-----------
 arch/parisc/kernel/ftrace.c          | 17 +++----------
 arch/powerpc/kernel/trace/ftrace.c   | 15 ++---------
 arch/riscv/kernel/ftrace.c           | 14 ++---------
 arch/s390/kernel/ftrace.c            | 13 ++--------
 arch/sh/kernel/ftrace.c              | 16 ++----------
 arch/sparc/kernel/ftrace.c           | 11 +-------
 arch/x86/kernel/ftrace.c             | 15 +----------
 include/linux/ftrace.h               |  4 +--
 include/linux/sched.h                |  1 +
 include/trace/events/sched.h         | 12 ++++++++-
 kernel/trace/ftrace.c                |  7 ++++--
 kernel/trace/trace_functions_graph.c | 49 ++++++++++++++++++++++++++++--------
 17 files changed, 78 insertions(+), 175 deletions(-)
---------------------------
diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index 0142fcfcc3d3..bda949fd84e8 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -183,9 +183,7 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 			   unsigned long frame_pointer)
 {
 	unsigned long return_hooker = (unsigned long) &return_to_handler;
-	struct ftrace_graph_ent trace;
 	unsigned long old;
-	int err;
 
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		return;
@@ -193,21 +191,8 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 	old = *parent;
 	*parent = return_hooker;
 
-	trace.func = self_addr;
-	trace.depth = current->curr_ret_stack + 1;
-
-	/* Only trace if the calling function expects to */
-	if (!ftrace_graph_entry(&trace)) {
+	if (function_graph_enter(old, self_addr, frame_pointer, NULL))
 		*parent = old;
-		return;
-	}
-
-	err = ftrace_push_return_trace(old, self_addr, &trace.depth,
-				       frame_pointer, NULL);
-	if (err == -EBUSY) {
-		*parent = old;
-		return;
-	}
 }
 
 #ifdef CONFIG_DYNAMIC_FTRACE
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 50986e388d2b..57e962290df3 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -216,8 +216,6 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 {
 	unsigned long return_hooker = (unsigned long)&return_to_handler;
 	unsigned long old;
-	struct ftrace_graph_ent trace;
-	int err;
 
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		return;
@@ -229,18 +227,7 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 	 */
 	old = *parent;
 
-	trace.func = self_addr;
-	trace.depth = current->curr_ret_stack + 1;
-
-	/* Only trace if the calling function expects to */
-	if (!ftrace_graph_entry(&trace))
-		return;
-
-	err = ftrace_push_return_trace(old, self_addr, &trace.depth,
-				       frame_pointer, NULL);
-	if (err == -EBUSY)
-		return;
-	else
+	if (!function_graph_enter(old, self_addr, frame_pointer, NULL))
 		*parent = return_hooker;
 }
 
diff --git a/arch/microblaze/kernel/ftrace.c b/arch/microblaze/kernel/ftrace.c
index d57563c58a26..224eea40e1ee 100644
--- a/arch/microblaze/kernel/ftrace.c
+++ b/arch/microblaze/kernel/ftrace.c
@@ -22,8 +22,7 @@
 void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr)
 {
 	unsigned long old;
-	int faulted, err;
-	struct ftrace_graph_ent trace;
+	int faulted;
 	unsigned long return_hooker = (unsigned long)
 				&return_to_handler;
 
@@ -63,18 +62,8 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr)
 		return;
 	}
 
-	err = ftrace_push_return_trace(old, self_addr, &trace.depth, 0, NULL);
-	if (err == -EBUSY) {
+	if (function_graph_enter(old, self_addr, 0, NULL))
 		*parent = old;
-		return;
-	}
-
-	trace.func = self_addr;
-	/* Only trace if the calling function expects to */
-	if (!ftrace_graph_entry(&trace)) {
-		current->curr_ret_stack--;
-		*parent = old;
-	}
 }
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index 7f3dfdbc3657..b122cbb4aad1 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -322,7 +322,6 @@ void prepare_ftrace_return(unsigned long *parent_ra_addr, unsigned long self_ra,
 			   unsigned long fp)
 {
 	unsigned long old_parent_ra;
-	struct ftrace_graph_ent trace;
 	unsigned long return_hooker = (unsigned long)
 	    &return_to_handler;
 	int faulted, insns;
@@ -369,12 +368,6 @@ void prepare_ftrace_return(unsigned long *parent_ra_addr, unsigned long self_ra,
 	if (unlikely(faulted))
 		goto out;
 
-	if (ftrace_push_return_trace(old_parent_ra, self_ra, &trace.depth, fp,
-				     NULL) == -EBUSY) {
-		*parent_ra_addr = old_parent_ra;
-		return;
-	}
-
 	/*
 	 * Get the recorded ip of the current mcount calling site in the
 	 * __mcount_loc section, which will be used to filter the function
@@ -382,13 +375,10 @@ void prepare_ftrace_return(unsigned long *parent_ra_addr, unsigned long self_ra,
 	 */
 
 	insns = core_kernel_text(self_ra) ? 2 : MCOUNT_OFFSET_INSNS + 1;
-	trace.func = self_ra - (MCOUNT_INSN_SIZE * insns);
+	self_ra -= (MCOUNT_INSN_SIZE * insns);
 
-	/* Only trace if the calling function expects to */
-	if (!ftrace_graph_entry(&trace)) {
-		current->curr_ret_stack--;
+	if (function_graph_enter(old_parent_ra, self_ra, fp, NULL))
 		*parent_ra_addr = old_parent_ra;
-	}
 	return;
 out:
 	ftrace_graph_stop();
diff --git a/arch/nds32/kernel/ftrace.c b/arch/nds32/kernel/ftrace.c
index a0a9679ad5de..8a41372551ff 100644
--- a/arch/nds32/kernel/ftrace.c
+++ b/arch/nds32/kernel/ftrace.c
@@ -211,29 +211,15 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 			   unsigned long frame_pointer)
 {
 	unsigned long return_hooker = (unsigned long)&return_to_handler;
-	struct ftrace_graph_ent trace;
 	unsigned long old;
-	int err;
 
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		return;
 
 	old = *parent;
 
-	trace.func = self_addr;
-	trace.depth = current->curr_ret_stack + 1;
-
-	/* Only trace if the calling function expects to */
-	if (!ftrace_graph_entry(&trace))
-		return;
-
-	err = ftrace_push_return_trace(old, self_addr, &trace.depth,
-				       frame_pointer, NULL);
-
-	if (err == -EBUSY)
-		return;
-
-	*parent = return_hooker;
+	if (!function_graph_enter(old, self_addr, frame_pointer, NULL))
+		*parent = return_hooker;
 }
 
 noinline void ftrace_graph_caller(void)
diff --git a/arch/parisc/kernel/ftrace.c b/arch/parisc/kernel/ftrace.c
index 6fa8535d3cce..e46a4157a894 100644
--- a/arch/parisc/kernel/ftrace.c
+++ b/arch/parisc/kernel/ftrace.c
@@ -30,7 +30,6 @@ static void __hot prepare_ftrace_return(unsigned long *parent,
 					unsigned long self_addr)
 {
 	unsigned long old;
-	struct ftrace_graph_ent trace;
 	extern int parisc_return_to_handler;
 
 	if (unlikely(ftrace_graph_is_dead()))
@@ -41,19 +40,9 @@ static void __hot prepare_ftrace_return(unsigned long *parent,
 
 	old = *parent;
 
-	trace.func = self_addr;
-	trace.depth = current->curr_ret_stack + 1;
-
-	/* Only trace if the calling function expects to */
-	if (!ftrace_graph_entry(&trace))
-		return;
-
-        if (ftrace_push_return_trace(old, self_addr, &trace.depth,
-				     0, NULL) == -EBUSY)
-                return;
-
-	/* activate parisc_return_to_handler() as return point */
-	*parent = (unsigned long) &parisc_return_to_handler;
+	if (!function_graph_enter(old, self_addr, 0, NULL))
+		/* activate parisc_return_to_handler() as return point */
+		*parent = (unsigned long) &parisc_return_to_handler;
 }
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 4bf051d3e21e..b65c8a34ad6e 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -950,7 +950,6 @@ int ftrace_disable_ftrace_graph_caller(void)
  */
 unsigned long prepare_ftrace_return(unsigned long parent, unsigned long ip)
 {
-	struct ftrace_graph_ent trace;
 	unsigned long return_hooker;
 
 	if (unlikely(ftrace_graph_is_dead()))
@@ -961,18 +960,8 @@ unsigned long prepare_ftrace_return(unsigned long parent, unsigned long ip)
 
 	return_hooker = ppc_function_entry(return_to_handler);
 
-	trace.func = ip;
-	trace.depth = current->curr_ret_stack + 1;
-
-	/* Only trace if the calling function expects to */
-	if (!ftrace_graph_entry(&trace))
-		goto out;
-
-	if (ftrace_push_return_trace(parent, ip, &trace.depth, 0,
-				     NULL) == -EBUSY)
-		goto out;
-
-	parent = return_hooker;
+	if (!function_graph_enter(parent, ip, 0, NULL))
+		parent = return_hooker;
 out:
 	return parent;
 }
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 1157b6b52d25..c433f6d3dd64 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -132,7 +132,6 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 {
 	unsigned long return_hooker = (unsigned long)&return_to_handler;
 	unsigned long old;
-	struct ftrace_graph_ent trace;
 	int err;
 
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
@@ -144,17 +143,8 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 	 */
 	old = *parent;
 
-	trace.func = self_addr;
-	trace.depth = current->curr_ret_stack + 1;
-
-	if (!ftrace_graph_entry(&trace))
-		return;
-
-	err = ftrace_push_return_trace(old, self_addr, &trace.depth,
-				       frame_pointer, parent);
-	if (err == -EBUSY)
-		return;
-	*parent = return_hooker;
+	if (function_graph_enter(old, self_addr, frame_pointer, parent))
+		*parent = return_hooker;
 }
 
 #ifdef CONFIG_DYNAMIC_FTRACE
diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
index 84be7f02d0c2..39b13d71a8fe 100644
--- a/arch/s390/kernel/ftrace.c
+++ b/arch/s390/kernel/ftrace.c
@@ -203,22 +203,13 @@ device_initcall(ftrace_plt_init);
  */
 unsigned long prepare_ftrace_return(unsigned long parent, unsigned long ip)
 {
-	struct ftrace_graph_ent trace;
-
 	if (unlikely(ftrace_graph_is_dead()))
 		goto out;
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		goto out;
 	ip -= MCOUNT_INSN_SIZE;
-	trace.func = ip;
-	trace.depth = current->curr_ret_stack + 1;
-	/* Only trace if the calling function expects to. */
-	if (!ftrace_graph_entry(&trace))
-		goto out;
-	if (ftrace_push_return_trace(parent, ip, &trace.depth, 0,
-				     NULL) == -EBUSY)
-		goto out;
-	parent = (unsigned long) return_to_handler;
+	if (!function_graph_enter(parent, ip, 0, NULL))
+		parent = (unsigned long) return_to_handler;
 out:
 	return parent;
 }
diff --git a/arch/sh/kernel/ftrace.c b/arch/sh/kernel/ftrace.c
index 96dd9f7da250..1b04270e5460 100644
--- a/arch/sh/kernel/ftrace.c
+++ b/arch/sh/kernel/ftrace.c
@@ -321,8 +321,7 @@ int ftrace_disable_ftrace_graph_caller(void)
 void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr)
 {
 	unsigned long old;
-	int faulted, err;
-	struct ftrace_graph_ent trace;
+	int faulted;
 	unsigned long return_hooker = (unsigned long)&return_to_handler;
 
 	if (unlikely(ftrace_graph_is_dead()))
@@ -365,18 +364,7 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr)
 		return;
 	}
 
-	err = ftrace_push_return_trace(old, self_addr, &trace.depth, 0, NULL);
-	if (err == -EBUSY) {
+	if (function_graph_enter(old, self_addr, 0, NULL))
 		__raw_writel(old, parent);
-		return;
-	}
-
-	trace.func = self_addr;
-
-	/* Only trace if the calling function expects to */
-	if (!ftrace_graph_entry(&trace)) {
-		current->curr_ret_stack--;
-		__raw_writel(old, parent);
-	}
 }
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/arch/sparc/kernel/ftrace.c b/arch/sparc/kernel/ftrace.c
index 915dda4ae412..684b84ce397f 100644
--- a/arch/sparc/kernel/ftrace.c
+++ b/arch/sparc/kernel/ftrace.c
@@ -126,20 +126,11 @@ unsigned long prepare_ftrace_return(unsigned long parent,
 				    unsigned long frame_pointer)
 {
 	unsigned long return_hooker = (unsigned long) &return_to_handler;
-	struct ftrace_graph_ent trace;
 
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		return parent + 8UL;
 
-	trace.func = self_addr;
-	trace.depth = current->curr_ret_stack + 1;
-
-	/* Only trace if the calling function expects to */
-	if (!ftrace_graph_entry(&trace))
-		return parent + 8UL;
-
-	if (ftrace_push_return_trace(parent, self_addr, &trace.depth,
-				     frame_pointer, NULL) == -EBUSY)
+	if (function_graph_enter(parent, self_addr, frame_pointer, NULL))
 		return parent + 8UL;
 
 	return return_hooker;
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 01ebcb6f263e..7ee8067cbf45 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -994,7 +994,6 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
 {
 	unsigned long old;
 	int faulted;
-	struct ftrace_graph_ent trace;
 	unsigned long return_hooker = (unsigned long)
 				&return_to_handler;
 
@@ -1046,19 +1045,7 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
 		return;
 	}
 
-	trace.func = self_addr;
-	trace.depth = current->curr_ret_stack + 1;
-
-	/* Only trace if the calling function expects to */
-	if (!ftrace_graph_entry(&trace)) {
+	if (function_graph_enter(old, self_addr, frame_pointer, parent))
 		*parent = old;
-		return;
-	}
-
-	if (ftrace_push_return_trace(old, self_addr, &trace.depth,
-				     frame_pointer, parent) == -EBUSY) {
-		*parent = old;
-		return;
-	}
 }
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index a397907e8d72..dd16e8218db3 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -777,8 +777,8 @@ struct ftrace_ret_stack {
 extern void return_to_handler(void);
 
 extern int
-ftrace_push_return_trace(unsigned long ret, unsigned long func, int *depth,
-			 unsigned long frame_pointer, unsigned long *retp);
+function_graph_enter(unsigned long ret, unsigned long func,
+		     unsigned long frame_pointer, unsigned long *retp);
 
 unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 				    unsigned long ret, unsigned long *retp);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index a51c13c2b1a0..d6183a55e8eb 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1116,6 +1116,7 @@ struct task_struct {
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	/* Index of current stored address in ret_stack: */
 	int				curr_ret_stack;
+	int				curr_ret_depth;
 
 	/* Stack of return addresses for return function tracing: */
 	struct ftrace_ret_stack		*ret_stack;
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index f07b270d4fc4..9a4bdfadab07 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -107,6 +107,8 @@ DEFINE_EVENT(sched_wakeup_template, sched_wakeup_new,
 #ifdef CREATE_TRACE_POINTS
 static inline long __trace_sched_switch_state(bool preempt, struct task_struct *p)
 {
+	unsigned int state;
+
 #ifdef CONFIG_SCHED_DEBUG
 	BUG_ON(p != current);
 #endif /* CONFIG_SCHED_DEBUG */
@@ -118,7 +120,15 @@ static inline long __trace_sched_switch_state(bool preempt, struct task_struct *
 	if (preempt)
 		return TASK_REPORT_MAX;
 
-	return 1 << task_state_index(p);
+	/*
+	 * task_state_index() uses fls() and returns a value from 0-8 range.
+	 * Decrement it by 1 (except TASK_RUNNING state i.e 0) before using
+	 * it for left shift operation to get the correct task->state
+	 * mapping.
+	 */
+	state = task_state_index(p);
+
+	return state ? (1 << (state - 1)) : state;
 }
 #endif /* CREATE_TRACE_POINTS */
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f536f601bd46..77734451cb05 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -817,7 +817,7 @@ function_profile_call(unsigned long ip, unsigned long parent_ip,
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 static int profile_graph_entry(struct ftrace_graph_ent *trace)
 {
-	int index = trace->depth;
+	int index = current->curr_ret_stack;
 
 	function_profile_call(trace->func, 0, NULL, NULL);
 
@@ -852,7 +852,7 @@ static void profile_graph_return(struct ftrace_graph_ret *trace)
 	if (!fgraph_graph_time) {
 		int index;
 
-		index = trace->depth;
+		index = current->curr_ret_stack;
 
 		/* Append this call time to the parent time to subtract */
 		if (index)
@@ -6814,6 +6814,7 @@ static int alloc_retstack_tasklist(struct ftrace_ret_stack **ret_stack_list)
 			atomic_set(&t->tracing_graph_pause, 0);
 			atomic_set(&t->trace_overrun, 0);
 			t->curr_ret_stack = -1;
+			t->curr_ret_depth = -1;
 			/* Make sure the tasks see the -1 first: */
 			smp_wmb();
 			t->ret_stack = ret_stack_list[start++];
@@ -7038,6 +7039,7 @@ graph_init_task(struct task_struct *t, struct ftrace_ret_stack *ret_stack)
 void ftrace_graph_init_idle_task(struct task_struct *t, int cpu)
 {
 	t->curr_ret_stack = -1;
+	t->curr_ret_depth = -1;
 	/*
 	 * The idle task has no parent, it either has its own
 	 * stack or no stack at all.
@@ -7068,6 +7070,7 @@ void ftrace_graph_init_task(struct task_struct *t)
 	/* Make sure we do not use the parent ret_stack */
 	t->ret_stack = NULL;
 	t->curr_ret_stack = -1;
+	t->curr_ret_depth = -1;
 
 	if (ftrace_graph_active) {
 		struct ftrace_ret_stack *ret_stack;
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 169b3c44ee97..2561460d7baf 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -118,8 +118,8 @@ print_graph_duration(struct trace_array *tr, unsigned long long duration,
 		     struct trace_seq *s, u32 flags);
 
 /* Add a function return address to the trace stack on thread info.*/
-int
-ftrace_push_return_trace(unsigned long ret, unsigned long func, int *depth,
+static int
+ftrace_push_return_trace(unsigned long ret, unsigned long func,
 			 unsigned long frame_pointer, unsigned long *retp)
 {
 	unsigned long long calltime;
@@ -177,9 +177,31 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func, int *depth,
 #ifdef HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
 	current->ret_stack[index].retp = retp;
 #endif
-	*depth = current->curr_ret_stack;
+	return 0;
+}
+
+int function_graph_enter(unsigned long ret, unsigned long func,
+			 unsigned long frame_pointer, unsigned long *retp)
+{
+	struct ftrace_graph_ent trace;
+
+	trace.func = func;
+	trace.depth = ++current->curr_ret_depth;
+
+	if (ftrace_push_return_trace(ret, func,
+				     frame_pointer, retp))
+		goto out;
+
+	/* Only trace if the calling function expects to */
+	if (!ftrace_graph_entry(&trace))
+		goto out_ret;
 
 	return 0;
+ out_ret:
+	current->curr_ret_stack--;
+ out:
+	current->curr_ret_depth--;
+	return -EBUSY;
 }
 
 /* Retrieve a function return address to the trace stack on thread info.*/
@@ -241,7 +263,13 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
 	trace->func = current->ret_stack[index].func;
 	trace->calltime = current->ret_stack[index].calltime;
 	trace->overrun = atomic_read(&current->trace_overrun);
-	trace->depth = index;
+	trace->depth = current->curr_ret_depth--;
+	/*
+	 * We still want to trace interrupts coming in if
+	 * max_depth is set to 1. Make sure the decrement is
+	 * seen before ftrace_graph_return.
+	 */
+	barrier();
 }
 
 /*
@@ -255,6 +283,12 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 
 	ftrace_pop_return_trace(&trace, &ret, frame_pointer);
 	trace.rettime = trace_clock_local();
+	ftrace_graph_return(&trace);
+	/*
+	 * The ftrace_graph_return() may still access the current
+	 * ret_stack structure, we need to make sure the update of
+	 * curr_ret_stack is after that.
+	 */
 	barrier();
 	current->curr_ret_stack--;
 	/*
@@ -267,13 +301,6 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 		return ret;
 	}
 
-	/*
-	 * The trace should run after decrementing the ret counter
-	 * in case an interrupt were to come in. We don't want to
-	 * lose the interrupt if max_depth is set.
-	 */
-	ftrace_graph_return(&trace);
-
 	if (unlikely(!ret)) {
 		ftrace_graph_stop();
 		WARN_ON(1);
