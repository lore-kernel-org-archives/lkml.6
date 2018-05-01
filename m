Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755492AbeEAN6z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 09:58:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52842 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755259AbeEAN6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 09:58:51 -0400
Date: Tue, 1 May 2018 08:58:50 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: perf: fuzzer causes stack going in wrong direction warnings
Message-ID: <20180501135850.enx4waqd5d7yowlj@treble>
References: <20180109151253.GK6176@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1801091022040.16446@macbook-air>
 <20180109153341.GL6176@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1801091052010.16446@macbook-air>
 <20180109160551.GK3040@hirez.programming.kicks-ass.net>
 <20180109170716.bqmexpmywwr4bwuv@treble>
 <20180111052538.2qhj6oxnc24xumhk@treble>
 <alpine.DEB.2.21.1801111358580.22460@macbook-air>
 <20180111192112.d35nkotzklicd27c@treble>
 <alpine.DEB.2.21.1805010925140.19413@macbook-air>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1805010925140.19413@macbook-air>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 09:29:38AM -0400, Vince Weaver wrote:
> Hello
> 
> I reported this back in January, but I think it got lost since everyone 
> was busy with other more pressing matters.
> 
> But in any case, the perf_fuzzer still can trigger these type of messages 
> and just wanted to see if they were a cause for concern, or just noise.
> 
> [66620.496076] WARNING: can't dereference registers at 0000000051f78a40 for ip interrupt_entry+0xba/0xc0
> [66620.506117] WARNING: stack recursion on stack type 4
> [67126.898984] WARNING: stack going in the wrong direction? ip=native_sched_clock+0xd/0x90
> [67148.214712] WARNING: can't dereference iret registers at 00000000c8f3c864 for ip error_exit+0x20/0x20

Sorry, it did fall off my radar thanks to Spectre/Meltdown.  I just
started looking at some similar reports, so your timing is perfect.

I suspect these warnings are similar to issues I saw before with the FP
unwinder, where it's trying to read the stack of a running task while
the task is simultaneously writing to the stack.  So basically it's
probably just noise, but we should try to get rid of the warnings
because the unwinder is expected to get lost in such a case.

Can you try the following patch?

diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index 563e28d14f2c..5eb796865b5b 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -137,7 +137,9 @@ int get_stack_info(unsigned long *stack, struct task_struct *task,
 	 */
 	if (visit_mask) {
 		if (*visit_mask & (1UL << info->type)) {
-			printk_deferred_once(KERN_WARNING "WARNING: stack recursion on stack type %d\n", info->type);
+			if (task == current)
+				printk_deferred_once(KERN_WARNING "WARNING: stack recursion on stack type %d\n",
+						     info->type);
 			goto unknown;
 		}
 		*visit_mask |= 1UL << info->type;
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index feb28fee6cea..570435c52ca0 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -7,7 +7,14 @@
 #include <asm/orc_lookup.h>
 
 #define orc_warn(fmt, ...) \
-	printk_deferred_once(KERN_WARNING pr_fmt("WARNING: " fmt), ##__VA_ARGS__)
+	printk_deferred_once(KERN_WARNING "WARNING: " fmt, ##__VA_ARGS__)
+
+#define orc_warn_current(fmt, ...)					\
+({									\
+	if (state->task == current)					\
+		printk_deferred_once(KERN_WARNING "WARNING: " fmt,	\
+				     ##__VA_ARGS__);			\
+})
 
 extern int __start_orc_unwind_ip[];
 extern int __stop_orc_unwind_ip[];
@@ -400,8 +407,8 @@ bool unwind_next_frame(struct unwind_state *state)
 
 	case ORC_REG_R10:
 		if (!state->regs || !state->full_regs) {
-			orc_warn("missing regs for base reg R10 at ip %pB\n",
-				 (void *)state->ip);
+			orc_warn_current("missing regs for base reg R10 at ip %pB\n",
+					 (void *)state->ip);
 			goto done;
 		}
 		sp = state->regs->r10;
@@ -409,8 +416,8 @@ bool unwind_next_frame(struct unwind_state *state)
 
 	case ORC_REG_R13:
 		if (!state->regs || !state->full_regs) {
-			orc_warn("missing regs for base reg R13 at ip %pB\n",
-				 (void *)state->ip);
+			orc_warn_current("missing regs for base reg R13 at ip %pB\n",
+					 (void *)state->ip);
 			goto done;
 		}
 		sp = state->regs->r13;
@@ -418,8 +425,8 @@ bool unwind_next_frame(struct unwind_state *state)
 
 	case ORC_REG_DI:
 		if (!state->regs || !state->full_regs) {
-			orc_warn("missing regs for base reg DI at ip %pB\n",
-				 (void *)state->ip);
+			orc_warn_current("missing regs for base reg DI at ip %pB\n",
+					 (void *)state->ip);
 			goto done;
 		}
 		sp = state->regs->di;
@@ -427,8 +434,8 @@ bool unwind_next_frame(struct unwind_state *state)
 
 	case ORC_REG_DX:
 		if (!state->regs || !state->full_regs) {
-			orc_warn("missing regs for base reg DX at ip %pB\n",
-				 (void *)state->ip);
+			orc_warn_current("missing regs for base reg DX at ip %pB\n",
+					 (void *)state->ip);
 			goto done;
 		}
 		sp = state->regs->dx;
@@ -463,8 +470,8 @@ bool unwind_next_frame(struct unwind_state *state)
 
 	case ORC_TYPE_REGS:
 		if (!deref_stack_regs(state, sp, &state->ip, &state->sp)) {
-			orc_warn("can't dereference registers at %p for ip %pB\n",
-				 (void *)sp, (void *)orig_ip);
+			orc_warn_current("can't dereference registers at %p for ip %pB\n",
+					 (void *)sp, (void *)orig_ip);
 			goto done;
 		}
 
@@ -475,8 +482,8 @@ bool unwind_next_frame(struct unwind_state *state)
 
 	case ORC_TYPE_REGS_IRET:
 		if (!deref_stack_iret_regs(state, sp, &state->ip, &state->sp)) {
-			orc_warn("can't dereference iret registers at %p for ip %pB\n",
-				 (void *)sp, (void *)orig_ip);
+			orc_warn_current("can't dereference iret registers at %p for ip %pB\n",
+					 (void *)sp, (void *)orig_ip);
 			goto done;
 		}
 
@@ -518,8 +525,8 @@ bool unwind_next_frame(struct unwind_state *state)
 	if (state->stack_info.type == prev_type &&
 	    on_stack(&state->stack_info, (void *)state->sp, sizeof(long)) &&
 	    state->sp <= prev_sp) {
-		orc_warn("stack going in the wrong direction? ip=%pB\n",
-			 (void *)orig_ip);
+		orc_warn_current("stack going in the wrong direction? ip=%pB\n",
+				 (void *)orig_ip);
 		goto done;
 	}
 
