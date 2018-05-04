Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751508AbeEDQZ7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 12:25:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41480 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751423AbeEDQZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 12:25:58 -0400
Date: Fri, 4 May 2018 11:25:57 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: perf: fuzzer causes stack going in wrong direction warnings
Message-ID: <20180504162557.iodmglq3duomz6c2@treble>
References: <20180109170716.bqmexpmywwr4bwuv@treble>
 <20180111052538.2qhj6oxnc24xumhk@treble>
 <alpine.DEB.2.21.1801111358580.22460@macbook-air>
 <20180111192112.d35nkotzklicd27c@treble>
 <alpine.DEB.2.21.1805010925140.19413@macbook-air>
 <20180501135850.enx4waqd5d7yowlj@treble>
 <alpine.DEB.2.21.1805011557240.19937@macbook-air>
 <20180501220458.p3rgwzh3jcqt4jmm@treble>
 <20180502205009.codkvscnh4j4hm6b@treble>
 <alpine.DEB.2.21.1805041033230.6376@macbook-air>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1805041033230.6376@macbook-air>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 10:35:53AM -0400, Vince Weaver wrote:
> On Wed, 2 May 2018, Josh Poimboeuf wrote:
> 
> > After looking closer, I realized that at least some of these warnings
> > are due to bad unwind hints in the entry code.  Can you try this patch
> > instead of the last one?
> 
> with just this new patch applied I still get warnings such as this:
> 
> [  469.436218] WARNING: can't dereference registers at 00000000886d9235 for ip apic_timer_interrupt+0xa/0x20
> [  790.499655] WARNING: stack recursion on stack type 2
> [  790.907092] WARNING: stack going in the wrong direction? ip=native_sched_clock+0x9/0x90
> [ 3632.876656] WARNING: can't dereference iret registers at 000000001754e5aa for ip nmi_restore+0x16/0x2b
> [ 3650.161250] WARNING: missing regs for base reg R10 at ip native_sched_clock+0xd/0x90

The 'nmi_restore' warning points to a bug in my patch, but the others
are head scratchers.  Here's a patch which combines the first two
patches, plus improves the existing warnings a bit.  Can you try it?

Also, any tips for reproducing this locally?  I cloned the perf fuzzer
github.  Is it as simple as just "make" and "./run_tests.sh"?

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index be63330c5511..73f5d4c10304 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -165,6 +165,7 @@ For 32-bit we have the following conventions - kernel is built with
 	.endif
 	popq %rdx
 	popq %rsi
+	UNWIND_HINT_IRET_REGS offset=16
 	.if \pop_rdi
 	popq %rdi
 	.endif
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 805f52703ee3..2908ed2ef698 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -306,7 +306,6 @@ GLOBAL(entry_SYSCALL_64_after_hwframe)
 	 */
 syscall_return_via_sysret:
 	/* rcx and r11 are already restored (see code above) */
-	UNWIND_HINT_EMPTY
 	POP_REGS pop_rdi=0 skip_r11rcx=1
 
 	/*
@@ -315,6 +314,7 @@ syscall_return_via_sysret:
 	 */
 	movq	%rsp, %rdi
 	movq	PER_CPU_VAR(cpu_tss_rw + TSS_sp0), %rsp
+	UNWIND_HINT_EMPTY
 
 	pushq	RSP-RDI(%rdi)	/* RSP */
 	pushq	(%rdi)		/* RDI */
@@ -666,6 +666,7 @@ GLOBAL(swapgs_restore_regs_and_return_to_usermode)
 	 */
 	movq	%rsp, %rdi
 	movq	PER_CPU_VAR(cpu_tss_rw + TSS_sp0), %rsp
+	UNWIND_HINT_EMPTY
 
 	/* Copy the IRET frame to the trampoline stack. */
 	pushq	6*8(%rdi)	/* SS */
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index 563e28d14f2c..d8dbf7c3c2f1 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -137,7 +137,9 @@ int get_stack_info(unsigned long *stack, struct task_struct *task,
 	 */
 	if (visit_mask) {
 		if (*visit_mask & (1UL << info->type)) {
-			printk_deferred_once(KERN_WARNING "WARNING: stack recursion on stack type %d\n", info->type);
+			if (task == current)
+				printk_deferred(KERN_WARNING "WARNING: stack recursion on stack type %d\n",
+						info->type);
 			goto unknown;
 		}
 		*visit_mask |= 1UL << info->type;
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index feb28fee6cea..1324ffdb861d 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -7,7 +7,14 @@
 #include <asm/orc_lookup.h>
 
 #define orc_warn(fmt, ...) \
-	printk_deferred_once(KERN_WARNING pr_fmt("WARNING: " fmt), ##__VA_ARGS__)
+	printk_deferred(KERN_WARNING pr_fmt("WARNING: " fmt), ##__VA_ARGS__)
+
+#define orc_warn_current(fmt, ...)					\
+({									\
+	if (state->task == current)					\
+		printk_deferred(KERN_WARNING "WARNING: " fmt,		\
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
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 92b6a2c21631..d66f14bb6c50 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1239,7 +1239,7 @@ static int update_insn_state_regs(struct instruction *insn, struct insn_state *s
 	struct cfi_reg *cfa = &state->cfa;
 	struct stack_op *op = &insn->stack_op;
 
-	if (cfa->base != CFI_SP)
+	if (cfa->base != CFI_SP && cfa->base != CFI_SP_INDIRECT)
 		return 0;
 
 	/* push */
