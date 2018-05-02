Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751318AbeEBUuP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 16:50:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750939AbeEBUuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 16:50:10 -0400
Date: Wed, 2 May 2018 15:50:09 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: perf: fuzzer causes stack going in wrong direction warnings
Message-ID: <20180502205009.codkvscnh4j4hm6b@treble>
References: <alpine.DEB.2.21.1801091052010.16446@macbook-air>
 <20180109160551.GK3040@hirez.programming.kicks-ass.net>
 <20180109170716.bqmexpmywwr4bwuv@treble>
 <20180111052538.2qhj6oxnc24xumhk@treble>
 <alpine.DEB.2.21.1801111358580.22460@macbook-air>
 <20180111192112.d35nkotzklicd27c@treble>
 <alpine.DEB.2.21.1805010925140.19413@macbook-air>
 <20180501135850.enx4waqd5d7yowlj@treble>
 <alpine.DEB.2.21.1805011557240.19937@macbook-air>
 <20180501220458.p3rgwzh3jcqt4jmm@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180501220458.p3rgwzh3jcqt4jmm@treble>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 05:04:58PM -0500, Josh Poimboeuf wrote:
> On Tue, May 01, 2018 at 03:59:31PM -0400, Vince Weaver wrote:
> > On Tue, 1 May 2018, Josh Poimboeuf wrote:
> > 
> > > Can you try the following patch?
> > 
> > I applied the patch, but the warnings don't really look that different.
> > 
> > [   62.220322] WARNING: stack recursion on stack type 4
> > [   62.220326] WARNING: can't dereference registers at 000000009ca2e86d for ip swapgs_restore_regs_and_return_to_usermode+0x79/0x87
> > [  367.597013] WARNING: stack going in the wrong direction? ip=native_sched_clock+0x9/0x90
> 
> Bummer.  I'll need to come up with a patch to dump more info.

After looking closer, I realized that at least some of these warnings
are due to bad unwind hints in the entry code.  Can you try this patch
instead of the last one?

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
index 805f52703ee3..c6c54ce30090 100644
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
@@ -1640,6 +1641,7 @@ nmi_restore:
 	 * at the "iret" frame.
 	 */
 	addq	$6*8, %rsp
+	UNWIND_HINT_IRET_REGS
 
 	/*
 	 * Clear "NMI executing".  Set DF first so that we can easily
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
