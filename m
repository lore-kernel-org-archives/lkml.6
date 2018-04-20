Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755303AbeDTOkI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:40:08 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:46109 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755168AbeDTOkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:40:04 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-alpha@vger.kernel.org
Date: Fri, 20 Apr 2018 09:37:50 -0500
Message-Id: <20180420143811.9994-1-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87604mhrnb.fsf@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
X-XM-SPF: eid=1f9XCi-0006Ha-Gb;;;mid=<20180420143811.9994-1-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+ZnRCjZoXuFdnGrPrMRR84bgq6TyTxu5c=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.1 XMSolicitRefs_0 Weightloss drug
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;linux-arch@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1580 ms - load_scoreonly_sql: 0.25 (0.0%),
        signal_user_changed: 7 (0.4%), b_tie_ro: 4.1 (0.3%), parse: 3.0 (0.2%),
        extract_message_metadata: 47 (3.0%), get_uri_detail_list: 10 (0.6%),
        tests_pri_-1000: 20 (1.2%), tests_pri_-950: 2.8 (0.2%), tests_pri_-900: 2.1
        (0.1%), tests_pri_-400: 60 (3.8%), check_bayes: 57 (3.6%), b_tokenize: 30
        (1.9%), b_tok_get_all: 12 (0.8%), b_comp_prob: 6 (0.4%), b_tok_touch_all: 4.8
        (0.3%), b_finish: 0.93 (0.1%), tests_pri_0: 1368 (86.6%),
        check_dkim_signature: 1.52 (0.1%), check_dkim_adsp: 6 (0.4%), tests_pri_500:
        60 (3.8%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 01/22] signal/alpha: Use send_sig_fault where appropriate
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Filling in struct siginfo before calling send_sig_info a tedious and
error prone process, where once in a great while the wrong fields
are filled out, and siginfo has been inconsistently cleared.

Simplify this process by using the helper send_sig_fault.  Which
takes as a parameters all of the information it needs, ensures
all of the fiddly bits of filling in struct siginfo are done properly
and then calls send_sig_info.

In short about a 5 line reduction in code for every time send_sig_info
is called, which makes the calling function clearer.

Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-alpha@vger.kernel.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/alpha/kernel/osf_sys.c | 10 ++-----
 arch/alpha/kernel/signal.c  | 22 +++-----------
 arch/alpha/kernel/traps.c   | 71 +++++++++++----------------------------------
 3 files changed, 24 insertions(+), 79 deletions(-)

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index bb3619118926..6e921754c8fc 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -871,7 +871,6 @@ SYSCALL_DEFINE5(osf_setsysinfo, unsigned long, op, void __user *, buffer,
 		   send a signal.  Old exceptions are not signaled.  */
 		fex = (exc >> IEEE_STATUS_TO_EXCSUM_SHIFT) & swcr;
  		if (fex) {
-			siginfo_t info;
 			int si_code = FPE_FLTUNK;
 
 			if (fex & IEEE_TRAP_ENABLE_DNO) si_code = FPE_FLTUND;
@@ -881,12 +880,9 @@ SYSCALL_DEFINE5(osf_setsysinfo, unsigned long, op, void __user *, buffer,
 			if (fex & IEEE_TRAP_ENABLE_DZE) si_code = FPE_FLTDIV;
 			if (fex & IEEE_TRAP_ENABLE_INV) si_code = FPE_FLTINV;
 
-			clear_siginfo(&info);
-			info.si_signo = SIGFPE;
-			info.si_errno = 0;
-			info.si_code = si_code;
-			info.si_addr = NULL;  /* FIXME */
- 			send_sig_info(SIGFPE, &info, current);
+			send_sig_fault(SIGFPE, si_code,
+				       (void __user *)NULL,  /* FIXME */
+				       0, current);
  		}
 		return 0;
 	}
diff --git a/arch/alpha/kernel/signal.c b/arch/alpha/kernel/signal.c
index cd306e602313..8c0c4ee0be6e 100644
--- a/arch/alpha/kernel/signal.c
+++ b/arch/alpha/kernel/signal.c
@@ -219,15 +219,8 @@ do_sigreturn(struct sigcontext __user *sc)
 
 	/* Send SIGTRAP if we're single-stepping: */
 	if (ptrace_cancel_bpt (current)) {
-		siginfo_t info;
-
-		clear_siginfo(&info);
-		info.si_signo = SIGTRAP;
-		info.si_errno = 0;
-		info.si_code = TRAP_BRKPT;
-		info.si_addr = (void __user *) regs->pc;
-		info.si_trapno = 0;
-		send_sig_info(SIGTRAP, &info, current);
+		send_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *) regs->pc, 0,
+			       current);
 	}
 	return;
 
@@ -254,15 +247,8 @@ do_rt_sigreturn(struct rt_sigframe __user *frame)
 
 	/* Send SIGTRAP if we're single-stepping: */
 	if (ptrace_cancel_bpt (current)) {
-		siginfo_t info;
-
-		clear_siginfo(&info);
-		info.si_signo = SIGTRAP;
-		info.si_errno = 0;
-		info.si_code = TRAP_BRKPT;
-		info.si_addr = (void __user *) regs->pc;
-		info.si_trapno = 0;
-		send_sig_info(SIGTRAP, &info, current);
+		send_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *) regs->pc, 0,
+			       current);
 	}
 	return;
 
diff --git a/arch/alpha/kernel/traps.c b/arch/alpha/kernel/traps.c
index 242c83d86ace..106a1692fca0 100644
--- a/arch/alpha/kernel/traps.c
+++ b/arch/alpha/kernel/traps.c
@@ -213,7 +213,6 @@ do_entArith(unsigned long summary, unsigned long write_mask,
 	    struct pt_regs *regs)
 {
 	long si_code = FPE_FLTINV;
-	siginfo_t info;
 
 	if (summary & 1) {
 		/* Software-completion summary bit is set, so try to
@@ -228,21 +227,14 @@ do_entArith(unsigned long summary, unsigned long write_mask,
 	}
 	die_if_kernel("Arithmetic fault", regs, 0, NULL);
 
-	clear_siginfo(&info);
-	info.si_signo = SIGFPE;
-	info.si_errno = 0;
-	info.si_code = si_code;
-	info.si_addr = (void __user *) regs->pc;
-	send_sig_info(SIGFPE, &info, current);
+	send_sig_fault(SIGFPE, si_code, (void __user *) regs->pc, 0, current);
 }
 
 asmlinkage void
 do_entIF(unsigned long type, struct pt_regs *regs)
 {
-	siginfo_t info;
 	int signo, code;
 
-	clear_siginfo(&info);
 	if ((regs->ps & ~IPL_MAX) == 0) {
 		if (type == 1) {
 			const unsigned int *data
@@ -272,31 +264,20 @@ do_entIF(unsigned long type, struct pt_regs *regs)
 
 	switch (type) {
 	      case 0: /* breakpoint */
-		info.si_signo = SIGTRAP;
-		info.si_errno = 0;
-		info.si_code = TRAP_BRKPT;
-		info.si_trapno = 0;
-		info.si_addr = (void __user *) regs->pc;
-
 		if (ptrace_cancel_bpt(current)) {
 			regs->pc -= 4;	/* make pc point to former bpt */
 		}
 
-		send_sig_info(SIGTRAP, &info, current);
+		send_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->pc, 0,
+			       current);
 		return;
 
 	      case 1: /* bugcheck */
-		info.si_signo = SIGTRAP;
-		info.si_errno = 0;
-		info.si_code = TRAP_UNK;
-		info.si_addr = (void __user *) regs->pc;
-		info.si_trapno = 0;
-		send_sig_info(SIGTRAP, &info, current);
+		send_sig_fault(SIGTRAP, TRAP_UNK, (void __user *) regs->pc, 0,
+			       current);
 		return;
 		
 	      case 2: /* gentrap */
-		info.si_addr = (void __user *) regs->pc;
-		info.si_trapno = regs->r16;
 		switch ((long) regs->r16) {
 		case GEN_INTOVF:
 			signo = SIGFPE;
@@ -354,11 +335,8 @@ do_entIF(unsigned long type, struct pt_regs *regs)
 			break;
 		}
 
-		info.si_signo = signo;
-		info.si_errno = 0;
-		info.si_code = code;
-		info.si_addr = (void __user *) regs->pc;
-		send_sig_info(signo, &info, current);
+		send_sig_fault(signo, code, (void __user *) regs->pc, regs->r16,
+			       current);
 		return;
 
 	      case 4: /* opDEC */
@@ -382,11 +360,9 @@ do_entIF(unsigned long type, struct pt_regs *regs)
 			if (si_code == 0)
 				return;
 			if (si_code > 0) {
-				info.si_signo = SIGFPE;
-				info.si_errno = 0;
-				info.si_code = si_code;
-				info.si_addr = (void __user *) regs->pc;
-				send_sig_info(SIGFPE, &info, current);
+				send_sig_fault(SIGFPE, si_code,
+					       (void __user *) regs->pc, 0,
+					       current);
 				return;
 			}
 		}
@@ -411,11 +387,7 @@ do_entIF(unsigned long type, struct pt_regs *regs)
 		      ;
 	}
 
-	info.si_signo = SIGILL;
-	info.si_errno = 0;
-	info.si_code = ILL_ILLOPC;
-	info.si_addr = (void __user *) regs->pc;
-	send_sig_info(SIGILL, &info, current);
+	send_sig_fault(SIGILL, ILL_ILLOPC, (void __user *)regs->pc, 0, current);
 }
 
 /* There is an ifdef in the PALcode in MILO that enables a 
@@ -761,11 +733,9 @@ do_entUnaUser(void __user * va, unsigned long opcode,
 
 	unsigned long tmp1, tmp2, tmp3, tmp4;
 	unsigned long fake_reg, *reg_addr = &fake_reg;
-	siginfo_t info;
+	int si_code;
 	long error;
 
-	clear_siginfo(&info);
-
 	/* Check the UAC bits to decide what the user wants us to do
 	   with the unaliged access.  */
 
@@ -986,34 +956,27 @@ do_entUnaUser(void __user * va, unsigned long opcode,
 
 give_sigsegv:
 	regs->pc -= 4;  /* make pc point to faulting insn */
-	info.si_signo = SIGSEGV;
-	info.si_errno = 0;
 
 	/* We need to replicate some of the logic in mm/fault.c,
 	   since we don't have access to the fault code in the
 	   exception handling return path.  */
 	if ((unsigned long)va >= TASK_SIZE)
-		info.si_code = SEGV_ACCERR;
+		si_code = SEGV_ACCERR;
 	else {
 		struct mm_struct *mm = current->mm;
 		down_read(&mm->mmap_sem);
 		if (find_vma(mm, (unsigned long)va))
-			info.si_code = SEGV_ACCERR;
+			si_code = SEGV_ACCERR;
 		else
-			info.si_code = SEGV_MAPERR;
+			si_code = SEGV_MAPERR;
 		up_read(&mm->mmap_sem);
 	}
-	info.si_addr = va;
-	send_sig_info(SIGSEGV, &info, current);
+	send_sig_fault(SIGSEGV, si_code, va, 0, current);
 	return;
 
 give_sigbus:
 	regs->pc -= 4;
-	info.si_signo = SIGBUS;
-	info.si_errno = 0;
-	info.si_code = BUS_ADRALN;
-	info.si_addr = va;
-	send_sig_info(SIGBUS, &info, current);
+	send_sig_fault(SIGBUS, BUS_ADRALN, va, 0, current);
 	return;
 }
 
-- 
2.14.1
