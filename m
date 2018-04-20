Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755525AbeDTOt2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:49:28 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:44836 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755172AbeDTOqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:46:03 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        James Bottomley <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>,
        linux-parisc@vger.kernel.org
Date: Fri, 20 Apr 2018 09:38:02 -0500
Message-Id: <20180420143811.9994-13-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87604mhrnb.fsf@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
X-XM-SPF: eid=1f9XE7-0006Ha-5D;;;mid=<20180420143811.9994-13-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18D1qBSFZdC3966ZjR5PAF5I9jO5/2sHtw=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.1 XMSolicitRefs_0 Weightloss drug
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *****;linux-arch@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 15035 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 2.6 (0.0%), b_tie_ro: 1.81 (0.0%), parse: 1.72 (0.0%),
        extract_message_metadata: 20 (0.1%), get_uri_detail_list: 6 (0.0%),
        tests_pri_-1000: 2.9 (0.0%), tests_pri_-950: 1.23 (0.0%), tests_pri_-900:
        1.01 (0.0%), tests_pri_-400: 48 (0.3%), check_bayes: 47 (0.3%), b_tokenize:
        20 (0.1%), b_tok_get_all: 14 (0.1%), b_comp_prob: 3.8 (0.0%),
        b_tok_touch_all: 6 (0.0%), b_finish: 1.41 (0.0%), tests_pri_0: 520 (3.5%),
        check_dkim_signature: 0.64 (0.0%), check_dkim_adsp: 2.9 (0.0%),
        tests_pri_500: 14434 (96.0%), poll_dns_idle: 14422 (95.9%), rewrite_mail:
        0.00 (0.0%)
Subject: [REVIEW][PATCH 13/22] signal/parisc: Use force_sig_fault where appropriate
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Filling in struct siginfo before calling force_sig_info a tedious and
error prone process, where once in a great while the wrong fields
are filled out, and siginfo has been inconsistently cleared.

Simplify this process by using the helper force_sig_fault.  Which
takes as a parameters all of the information it needs, ensures
all of the fiddly bits of filling in struct siginfo are done properly
and then calls force_sig_info.

In short about a 5 line reduction in code for every time force_sig_info
is called, which makes the calling function clearer.

Cc: James Bottomley <jejb@parisc-linux.org>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/parisc/kernel/ptrace.c    | 11 ++------
 arch/parisc/kernel/traps.c     | 63 ++++++++++++++----------------------------
 arch/parisc/kernel/unaligned.c | 16 +++--------
 arch/parisc/math-emu/driver.c  |  9 ++----
 arch/parisc/mm/fault.c         | 25 +++++++----------
 5 files changed, 39 insertions(+), 85 deletions(-)

diff --git a/arch/parisc/kernel/ptrace.c b/arch/parisc/kernel/ptrace.c
index b1c12ceb1c88..7aa1d4d0d444 100644
--- a/arch/parisc/kernel/ptrace.c
+++ b/arch/parisc/kernel/ptrace.c
@@ -76,8 +76,6 @@ void user_enable_single_step(struct task_struct *task)
 	set_tsk_thread_flag(task, TIF_SINGLESTEP);
 
 	if (pa_psw(task)->n) {
-		struct siginfo si;
-
 		/* Nullified, just crank over the queue. */
 		task_regs(task)->iaoq[0] = task_regs(task)->iaoq[1];
 		task_regs(task)->iasq[0] = task_regs(task)->iasq[1];
@@ -90,12 +88,9 @@ void user_enable_single_step(struct task_struct *task)
 		ptrace_disable(task);
 		/* Don't wake up the task, but let the
 		   parent know something happened. */
-		clear_siginfo(&si);
-		si.si_code = TRAP_TRACE;
-		si.si_addr = (void __user *) (task_regs(task)->iaoq[0] & ~3);
-		si.si_signo = SIGTRAP;
-		si.si_errno = 0;
-		force_sig_info(SIGTRAP, &si, task);
+		force_sig_fault(SIGTRAP, TRAP_TRACE,
+				(void __user *) (task_regs(task)->iaoq[0] & ~3),
+				task);
 		/* notify_parent(task, SIGCHLD); */
 		return;
 	}
diff --git a/arch/parisc/kernel/traps.c b/arch/parisc/kernel/traps.c
index 98f9f2f85940..132b09c657ff 100644
--- a/arch/parisc/kernel/traps.c
+++ b/arch/parisc/kernel/traps.c
@@ -297,14 +297,8 @@ void die_if_kernel(char *str, struct pt_regs *regs, long err)
 #define GDB_BREAK_INSN 0x10004
 static void handle_gdb_break(struct pt_regs *regs, int wot)
 {
-	struct siginfo si;
-
-	clear_siginfo(&si);
-	si.si_signo = SIGTRAP;
-	si.si_errno = 0;
-	si.si_code = wot;
-	si.si_addr = (void __user *) (regs->iaoq[0] & ~3);
-	force_sig_info(SIGTRAP, &si, current);
+	force_sig_fault(SIGTRAP, wot,
+			(void __user *) (regs->iaoq[0] & ~3), current);
 }
 
 static void handle_break(struct pt_regs *regs)
@@ -488,9 +482,8 @@ void notrace handle_interruption(int code, struct pt_regs *regs)
 {
 	unsigned long fault_address = 0;
 	unsigned long fault_space = 0;
-	struct siginfo si;
+	int si_code;
 
-	clear_siginfo(&si);
 	if (code == 1)
 	    pdc_console_restart();  /* switch back to pdc if HPMC */
 	else
@@ -573,7 +566,7 @@ void notrace handle_interruption(int code, struct pt_regs *regs)
 	case  8:
 		/* Illegal instruction trap */
 		die_if_kernel("Illegal instruction", regs, code);
-		si.si_code = ILL_ILLOPC;
+		si_code = ILL_ILLOPC;
 		goto give_sigill;
 
 	case  9:
@@ -584,7 +577,7 @@ void notrace handle_interruption(int code, struct pt_regs *regs)
 	case 10:
 		/* Privileged operation trap */
 		die_if_kernel("Privileged operation", regs, code);
-		si.si_code = ILL_PRVOPC;
+		si_code = ILL_PRVOPC;
 		goto give_sigill;
 
 	case 11:
@@ -607,20 +600,16 @@ void notrace handle_interruption(int code, struct pt_regs *regs)
 		}
 
 		die_if_kernel("Privileged register usage", regs, code);
-		si.si_code = ILL_PRVREG;
+		si_code = ILL_PRVREG;
 	give_sigill:
-		si.si_signo = SIGILL;
-		si.si_errno = 0;
-		si.si_addr = (void __user *) regs->iaoq[0];
-		force_sig_info(SIGILL, &si, current);
+		force_sig_fault(SIGILL, si_code,
+				(void __user *) regs->iaoq[0], current);
 		return;
 
 	case 12:
 		/* Overflow Trap, let the userland signal handler do the cleanup */
-		si.si_signo = SIGFPE;
-		si.si_code = FPE_INTOVF;
-		si.si_addr = (void __user *) regs->iaoq[0];
-		force_sig_info(SIGFPE, &si, current);
+		force_sig_fault(SIGFPE, FPE_INTOVF,
+				(void __user *) regs->iaoq[0], current);
 		return;
 		
 	case 13:
@@ -628,13 +617,11 @@ void notrace handle_interruption(int code, struct pt_regs *regs)
 		   The condition succeeds in an instruction which traps
 		   on condition  */
 		if(user_mode(regs)){
-			si.si_signo = SIGFPE;
 			/* Let userspace app figure it out from the insn pointed
 			 * to by si_addr.
 			 */
-			si.si_code = FPE_CONDTRAP;
-			si.si_addr = (void __user *) regs->iaoq[0];
-			force_sig_info(SIGFPE, &si, current);
+			force_sig_fault(SIGFPE, FPE_CONDTRAP,
+					(void __user *) regs->iaoq[0], current);
 			return;
 		} 
 		/* The kernel doesn't want to handle condition codes */
@@ -743,14 +730,10 @@ void notrace handle_interruption(int code, struct pt_regs *regs)
 			return;
 
 		die_if_kernel("Protection id trap", regs, code);
-		si.si_code = SEGV_MAPERR;
-		si.si_signo = SIGSEGV;
-		si.si_errno = 0;
-		if (code == 7)
-		    si.si_addr = (void __user *) regs->iaoq[0];
-		else
-		    si.si_addr = (void __user *) regs->ior;
-		force_sig_info(SIGSEGV, &si, current);
+		force_sig_fault(SIGSEGV, SEGV_MAPERR,
+				(code == 7)?
+				((void __user *) regs->iaoq[0]) :
+				((void __user *) regs->ior), current);
 		return;
 
 	case 28: 
@@ -764,11 +747,8 @@ void notrace handle_interruption(int code, struct pt_regs *regs)
 				"handle_interruption() pid=%d command='%s'\n",
 				task_pid_nr(current), current->comm);
 			/* SIGBUS, for lack of a better one. */
-			si.si_signo = SIGBUS;
-			si.si_code = BUS_OBJERR;
-			si.si_errno = 0;
-			si.si_addr = (void __user *) regs->ior;
-			force_sig_info(SIGBUS, &si, current);
+			force_sig_fault(SIGBUS, BUS_OBJERR,
+					(void __user *)regs->ior, current);
 			return;
 		}
 		pdc_chassis_send_status(PDC_CHASSIS_DIRECT_PANIC);
@@ -783,11 +763,8 @@ void notrace handle_interruption(int code, struct pt_regs *regs)
 				"User fault %d on space 0x%08lx, pid=%d command='%s'\n",
 				code, fault_space,
 				task_pid_nr(current), current->comm);
-		si.si_signo = SIGSEGV;
-		si.si_errno = 0;
-		si.si_code = SEGV_MAPERR;
-		si.si_addr = (void __user *) regs->ior;
-		force_sig_info(SIGSEGV, &si, current);
+		force_sig_fault(SIGSEGV, SEGV_MAPERR,
+				(void __user *)regs->ior, current);
 		return;
 	    }
 	}
diff --git a/arch/parisc/kernel/unaligned.c b/arch/parisc/kernel/unaligned.c
index 30b7c7f6c471..932bfc0b7cd8 100644
--- a/arch/parisc/kernel/unaligned.c
+++ b/arch/parisc/kernel/unaligned.c
@@ -452,10 +452,8 @@ void handle_unaligned(struct pt_regs *regs)
 	unsigned long newbase = R1(regs->iir)?regs->gr[R1(regs->iir)]:0;
 	int modify = 0;
 	int ret = ERR_NOTHANDLED;
-	struct siginfo si;
 	register int flop=0;	/* true if this is a flop */
 
-	clear_siginfo(&si);
 	__inc_irq_stat(irq_unaligned_count);
 
 	/* log a message with pacing */
@@ -691,21 +689,15 @@ void handle_unaligned(struct pt_regs *regs)
 
 		if (ret == ERR_PAGEFAULT)
 		{
-			si.si_signo = SIGSEGV;
-			si.si_errno = 0;
-			si.si_code = SEGV_MAPERR;
-			si.si_addr = (void __user *)regs->ior;
-			force_sig_info(SIGSEGV, &si, current);
+			force_sig_fault(SIGSEGV, SEGV_MAPERR,
+					(void __user *)regs->ior, current);
 		}
 		else
 		{
 force_sigbus:
 			/* couldn't handle it ... */
-			si.si_signo = SIGBUS;
-			si.si_errno = 0;
-			si.si_code = BUS_ADRALN;
-			si.si_addr = (void __user *)regs->ior;
-			force_sig_info(SIGBUS, &si, current);
+			force_sig_fault(SIGBUS, BUS_ADRALN,
+					(void __user *)regs->ior, current);
 		}
 		
 		return;
diff --git a/arch/parisc/math-emu/driver.c b/arch/parisc/math-emu/driver.c
index 0d10efb53361..0590e05571d1 100644
--- a/arch/parisc/math-emu/driver.c
+++ b/arch/parisc/math-emu/driver.c
@@ -81,7 +81,6 @@ int
 handle_fpe(struct pt_regs *regs)
 {
 	extern void printbinary(unsigned long x, int nbits);
-	struct siginfo si;
 	unsigned int orig_sw, sw;
 	int signalcode;
 	/* need an intermediate copy of float regs because FPU emulation
@@ -93,7 +92,6 @@ handle_fpe(struct pt_regs *regs)
 	 */
 	__u64 frcopy[36];
 
-	clear_siginfo(&si);
 	memcpy(frcopy, regs->fr, sizeof regs->fr);
 	frcopy[32] = 0;
 
@@ -118,11 +116,8 @@ handle_fpe(struct pt_regs *regs)
 
 	memcpy(regs->fr, frcopy, sizeof regs->fr);
 	if (signalcode != 0) {
-	    si.si_signo = signalcode >> 24;
-	    si.si_errno = 0;
-	    si.si_code = signalcode & 0xffffff;
-	    si.si_addr = (void __user *) regs->iaoq[0];
-	    force_sig_info(si.si_signo, &si, current);
+	    force_sig_fault(signalcode >> 24, signalcode & 0xffffff,
+			    (void __user *) regs->iaoq[0], current);
 	    return -1;
 	}
 
diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
index 51215b0048ef..a80117980fc2 100644
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -353,23 +353,22 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 	up_read(&mm->mmap_sem);
 
 	if (user_mode(regs)) {
-		struct siginfo si;
+		int signo, si_code;
 
-		clear_siginfo(&si);
 		switch (code) {
 		case 15:	/* Data TLB miss fault/Data page fault */
 			/* send SIGSEGV when outside of vma */
 			if (!vma ||
 			    address < vma->vm_start || address >= vma->vm_end) {
-				si.si_signo = SIGSEGV;
-				si.si_code = SEGV_MAPERR;
+				signo = SIGSEGV;
+				si_code = SEGV_MAPERR;
 				break;
 			}
 
 			/* send SIGSEGV for wrong permissions */
 			if ((vma->vm_flags & acc_type) != acc_type) {
-				si.si_signo = SIGSEGV;
-				si.si_code = SEGV_ACCERR;
+				signo = SIGSEGV;
+				si_code = SEGV_ACCERR;
 				break;
 			}
 
@@ -377,17 +376,16 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 			/* fall through */
 		case 17:	/* NA data TLB miss / page fault */
 		case 18:	/* Unaligned access - PCXS only */
-			si.si_signo = SIGBUS;
-			si.si_code = (code == 18) ? BUS_ADRALN : BUS_ADRERR;
+			signo = SIGBUS;
+			si_code = (code == 18) ? BUS_ADRALN : BUS_ADRERR;
 			break;
 		case 16:	/* Non-access instruction TLB miss fault */
 		case 26:	/* PCXL: Data memory access rights trap */
 		default:
-			si.si_signo = SIGSEGV;
-			si.si_code = (code == 26) ? SEGV_ACCERR : SEGV_MAPERR;
+			signo = SIGSEGV;
+			si_code = (code == 26) ? SEGV_ACCERR : SEGV_MAPERR;
 			break;
 		}
-
 #ifdef CONFIG_MEMORY_FAILURE
 		if (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
 			unsigned int lsb = 0;
@@ -409,12 +407,9 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 			return;
 		}
 #endif
-
 		show_signal_msg(regs, code, address, tsk, vma);
 
-		si.si_errno = 0;
-		si.si_addr = (void __user *) address;
-		force_sig_info(si.si_signo, &si, current);
+		force_sig_fault(signo, si_code, (void __user *) address, current);
 		return;
 	}
 
-- 
2.14.1
