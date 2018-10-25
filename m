Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896ABECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D5FA2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjUZb1yQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5FA2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbeJYWup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:50:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729754AbeJYWup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:50:45 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D160E2085A;
        Thu, 25 Oct 2018 14:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477067;
        bh=5MT6hHOQSiR3K5zGoFb02vslAvaN31A2HGDpbBWDGiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SjUZb1yQs4Lf/AC5D6g0+mfsmVa8dhwup+82Va/PPwE3hd7JRNg/DfH/TGZrNNtN+
         9lUY5C4HX4GfOgjVVVpGOsvGX3qVEryS2Dzgz/YV5q/etPzY5Yf09uBs2/IXNj6RmF
         0OhnGM1v2u+46zbwQxfNF/AtDukN2lVhICHvMWjY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Maciej W. Rozycki" <macro@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 23/65] MIPS: Fix FCSR Cause bit handling for correct SIGFPE issue
Date:   Thu, 25 Oct 2018 10:16:23 -0400
Message-Id: <20181025141705.213937-23-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Maciej W. Rozycki" <macro@imgtec.com>

[ Upstream commit 5a1aca4469fdccd5b74ba0b4e490173b2b447895 ]

Sanitize FCSR Cause bit handling, following a trail of past attempts:

* commit 4249548454f7 ("MIPS: ptrace: Fix FP context restoration FCSR
regression"),

* commit 443c44032a54 ("MIPS: Always clear FCSR cause bits after
emulation"),

* commit 64bedffe4968 ("MIPS: Clear [MSA]FPE CSR.Cause after
notify_die()"),

* commit b1442d39fac2 ("MIPS: Prevent user from setting FCSR cause
bits"),

* commit b54d2901517d ("Properly handle branch delay slots in connection
with signals.").

Specifically do not mask these bits out in ptrace(2) processing and send
a SIGFPE signal instead whenever a matching pair of an FCSR Cause and
Enable bit is seen as execution of an affected context is about to
resume.  Only then clear Cause bits, and even then do not clear any bits
that are set but masked with the respective Enable bits.  Adjust Cause
bit clearing throughout code likewise, except within the FPU emulator
proper where they are set according to IEEE 754 exceptions raised as the
operation emulated executed.  Do so so that any IEEE 754 exceptions
subject to their default handling are recorded like with operations
executed by FPU hardware.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/14460/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/asm/fpu_emulator.h  | 13 +++++
 arch/mips/include/asm/switch_to.h     | 18 +++++++
 arch/mips/kernel/mips-r2-to-r6-emul.c | 10 ++--
 arch/mips/kernel/ptrace.c             |  7 ++-
 arch/mips/kernel/traps.c              | 72 +++++++++++++++------------
 5 files changed, 78 insertions(+), 42 deletions(-)

diff --git a/arch/mips/include/asm/fpu_emulator.h b/arch/mips/include/asm/fpu_emulator.h
index 2f021cdfba4f..742223716fc8 100644
--- a/arch/mips/include/asm/fpu_emulator.h
+++ b/arch/mips/include/asm/fpu_emulator.h
@@ -66,6 +66,8 @@ extern int do_dsemulret(struct pt_regs *xcp);
 extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
 				    struct mips_fpu_struct *ctx, int has_fpu,
 				    void *__user *fault_addr);
+void force_fcr31_sig(unsigned long fcr31, void __user *fault_addr,
+		     struct task_struct *tsk);
 int process_fpemu_return(int sig, void __user *fault_addr,
 			 unsigned long fcr31);
 int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
@@ -92,4 +94,15 @@ static inline void fpu_emulator_init_fpu(void)
 		set_fpr64(&t->thread.fpu.fpr[i], 0, SIGNALLING_NAN);
 }
 
+/*
+ * Mask the FCSR Cause bits according to the Enable bits, observing
+ * that Unimplemented is always enabled.
+ */
+static inline unsigned long mask_fcr31_x(unsigned long fcr31)
+{
+	return fcr31 & (FPU_CSR_UNI_X |
+			((fcr31 & FPU_CSR_ALL_E) <<
+			 (ffs(FPU_CSR_ALL_X) - ffs(FPU_CSR_ALL_E))));
+}
+
 #endif /* _ASM_FPU_EMULATOR_H */
diff --git a/arch/mips/include/asm/switch_to.h b/arch/mips/include/asm/switch_to.h
index ebb5c0f2f90d..c0ae27971e31 100644
--- a/arch/mips/include/asm/switch_to.h
+++ b/arch/mips/include/asm/switch_to.h
@@ -75,6 +75,22 @@ do {	if (cpu_has_rw_llb) {						\
 	}								\
 } while (0)
 
+/*
+ * Check FCSR for any unmasked exceptions pending set with `ptrace',
+ * clear them and send a signal.
+ */
+#define __sanitize_fcr31(next)						\
+do {									\
+	unsigned long fcr31 = mask_fcr31_x(next->thread.fpu.fcr31);	\
+	void __user *pc;						\
+									\
+	if (unlikely(fcr31)) {						\
+		pc = (void __user *)task_pt_regs(next)->cp0_epc;	\
+		next->thread.fpu.fcr31 &= ~fcr31;			\
+		force_fcr31_sig(fcr31, pc, next);			\
+	}								\
+} while (0)
+
 /*
  * For newly created kernel threads switch_to() will return to
  * ret_from_kernel_thread, newly created user threads to ret_from_fork.
@@ -85,6 +101,8 @@ do {	if (cpu_has_rw_llb) {						\
 do {									\
 	__mips_mt_fpaff_switch_to(prev);				\
 	lose_fpu_inatomic(1, prev);					\
+	if (tsk_used_math(next))					\
+		__sanitize_fcr31(next);					\
 	if (cpu_has_dsp) {						\
 		__save_dsp(prev);					\
 		__restore_dsp(next);					\
diff --git a/arch/mips/kernel/mips-r2-to-r6-emul.c b/arch/mips/kernel/mips-r2-to-r6-emul.c
index cbe0f025856d..7b887027dca2 100644
--- a/arch/mips/kernel/mips-r2-to-r6-emul.c
+++ b/arch/mips/kernel/mips-r2-to-r6-emul.c
@@ -900,7 +900,7 @@ static inline int mipsr2_find_op_func(struct pt_regs *regs, u32 inst,
  * mipsr2_decoder: Decode and emulate a MIPS R2 instruction
  * @regs: Process register set
  * @inst: Instruction to decode and emulate
- * @fcr31: Floating Point Control and Status Register returned
+ * @fcr31: Floating Point Control and Status Register Cause bits returned
  */
 int mipsr2_decoder(struct pt_regs *regs, u32 inst, unsigned long *fcr31)
 {
@@ -1183,13 +1183,13 @@ int mipsr2_decoder(struct pt_regs *regs, u32 inst, unsigned long *fcr31)
 
 		err = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 0,
 					       &fault_addr);
-		*fcr31 = current->thread.fpu.fcr31;
 
 		/*
-		 * We can't allow the emulated instruction to leave any of
-		 * the cause bits set in $fcr31.
+		 * We can't allow the emulated instruction to leave any
+		 * enabled Cause bits set in $fcr31.
 		 */
-		current->thread.fpu.fcr31 &= ~FPU_CSR_ALL_X;
+		*fcr31 = res = mask_fcr31_x(current->thread.fpu.fcr31);
+		current->thread.fpu.fcr31 &= ~res;
 
 		/*
 		 * this is a tricky issue - lose_fpu() uses LL/SC atomics
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 5a869515b393..9d04392f7ef0 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -79,16 +79,15 @@ void ptrace_disable(struct task_struct *child)
 }
 
 /*
- * Poke at FCSR according to its mask.  Don't set the cause bits as
- * this is currently not handled correctly in FP context restoration
- * and will cause an oops if a corresponding enable bit is set.
+ * Poke at FCSR according to its mask.  Set the Cause bits even
+ * if a corresponding Enable bit is set.  This will be noticed at
+ * the time the thread is switched to and SIGFPE thrown accordingly.
  */
 static void ptrace_setfcr31(struct task_struct *child, u32 value)
 {
 	u32 fcr31;
 	u32 mask;
 
-	value &= ~FPU_CSR_ALL_X;
 	fcr31 = child->thread.fpu.fcr31;
 	mask = boot_cpu_data.fpu_msk31;
 	child->thread.fpu.fcr31 = (value & ~mask) | (fcr31 & mask);
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 1b901218e3ae..6abd6b41c13d 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -706,6 +706,32 @@ asmlinkage void do_ov(struct pt_regs *regs)
 	exception_exit(prev_state);
 }
 
+/*
+ * Send SIGFPE according to FCSR Cause bits, which must have already
+ * been masked against Enable bits.  This is impotant as Inexact can
+ * happen together with Overflow or Underflow, and `ptrace' can set
+ * any bits.
+ */
+void force_fcr31_sig(unsigned long fcr31, void __user *fault_addr,
+		     struct task_struct *tsk)
+{
+	struct siginfo si = { .si_addr = fault_addr, .si_signo = SIGFPE };
+
+	if (fcr31 & FPU_CSR_INV_X)
+		si.si_code = FPE_FLTINV;
+	else if (fcr31 & FPU_CSR_DIV_X)
+		si.si_code = FPE_FLTDIV;
+	else if (fcr31 & FPU_CSR_OVF_X)
+		si.si_code = FPE_FLTOVF;
+	else if (fcr31 & FPU_CSR_UDF_X)
+		si.si_code = FPE_FLTUND;
+	else if (fcr31 & FPU_CSR_INE_X)
+		si.si_code = FPE_FLTRES;
+	else
+		si.si_code = __SI_FAULT;
+	force_sig_info(SIGFPE, &si, tsk);
+}
+
 int process_fpemu_return(int sig, void __user *fault_addr, unsigned long fcr31)
 {
 	struct siginfo si = { 0 };
@@ -715,27 +741,7 @@ int process_fpemu_return(int sig, void __user *fault_addr, unsigned long fcr31)
 		return 0;
 
 	case SIGFPE:
-		si.si_addr = fault_addr;
-		si.si_signo = sig;
-		/*
-		 * Inexact can happen together with Overflow or Underflow.
-		 * Respect the mask to deliver the correct exception.
-		 */
-		fcr31 &= (fcr31 & FPU_CSR_ALL_E) <<
-			 (ffs(FPU_CSR_ALL_X) - ffs(FPU_CSR_ALL_E));
-		if (fcr31 & FPU_CSR_INV_X)
-			si.si_code = FPE_FLTINV;
-		else if (fcr31 & FPU_CSR_DIV_X)
-			si.si_code = FPE_FLTDIV;
-		else if (fcr31 & FPU_CSR_OVF_X)
-			si.si_code = FPE_FLTOVF;
-		else if (fcr31 & FPU_CSR_UDF_X)
-			si.si_code = FPE_FLTUND;
-		else if (fcr31 & FPU_CSR_INE_X)
-			si.si_code = FPE_FLTRES;
-		else
-			si.si_code = __SI_FAULT;
-		force_sig_info(sig, &si, current);
+		force_fcr31_sig(fcr31, fault_addr, current);
 		return 1;
 
 	case SIGBUS:
@@ -798,13 +804,13 @@ static int simulate_fp(struct pt_regs *regs, unsigned int opcode,
 	/* Run the emulator */
 	sig = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 1,
 				       &fault_addr);
-	fcr31 = current->thread.fpu.fcr31;
 
 	/*
-	 * We can't allow the emulated instruction to leave any of
-	 * the cause bits set in $fcr31.
+	 * We can't allow the emulated instruction to leave any
+	 * enabled Cause bits set in $fcr31.
 	 */
-	current->thread.fpu.fcr31 &= ~FPU_CSR_ALL_X;
+	fcr31 = mask_fcr31_x(current->thread.fpu.fcr31);
+	current->thread.fpu.fcr31 &= ~fcr31;
 
 	/* Restore the hardware register state */
 	own_fpu(1);
@@ -830,7 +836,7 @@ asmlinkage void do_fpe(struct pt_regs *regs, unsigned long fcr31)
 		goto out;
 
 	/* Clear FCSR.Cause before enabling interrupts */
-	write_32bit_cp1_register(CP1_STATUS, fcr31 & ~FPU_CSR_ALL_X);
+	write_32bit_cp1_register(CP1_STATUS, fcr31 & ~mask_fcr31_x(fcr31));
 	local_irq_enable();
 
 	die_if_kernel("FP exception in kernel code", regs);
@@ -852,13 +858,13 @@ asmlinkage void do_fpe(struct pt_regs *regs, unsigned long fcr31)
 		/* Run the emulator */
 		sig = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 1,
 					       &fault_addr);
-		fcr31 = current->thread.fpu.fcr31;
 
 		/*
-		 * We can't allow the emulated instruction to leave any of
-		 * the cause bits set in $fcr31.
+		 * We can't allow the emulated instruction to leave any
+		 * enabled Cause bits set in $fcr31.
 		 */
-		current->thread.fpu.fcr31 &= ~FPU_CSR_ALL_X;
+		fcr31 = mask_fcr31_x(current->thread.fpu.fcr31);
+		current->thread.fpu.fcr31 &= ~fcr31;
 
 		/* Restore the hardware register state */
 		own_fpu(1);	/* Using the FPU again.	 */
@@ -1431,13 +1437,13 @@ asmlinkage void do_cpu(struct pt_regs *regs)
 
 		sig = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 0,
 					       &fault_addr);
-		fcr31 = current->thread.fpu.fcr31;
 
 		/*
 		 * We can't allow the emulated instruction to leave
-		 * any of the cause bits set in $fcr31.
+		 * any enabled Cause bits set in $fcr31.
 		 */
-		current->thread.fpu.fcr31 &= ~FPU_CSR_ALL_X;
+		fcr31 = mask_fcr31_x(current->thread.fpu.fcr31);
+		current->thread.fpu.fcr31 &= ~fcr31;
 
 		/* Send a signal if required.  */
 		if (!process_fpemu_return(sig, fault_addr, fcr31) && !err)
-- 
2.17.1

