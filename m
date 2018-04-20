Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755447AbeDTOlG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:41:06 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:44260 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755422AbeDTOks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:40:48 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>,
        linux-mips@linux-mips.org
Date: Fri, 20 Apr 2018 09:37:57 -0500
Message-Id: <20180420143811.9994-8-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87604mhrnb.fsf@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
X-XM-SPF: eid=1f9XDS-0006Ha-E2;;;mid=<20180420143811.9994-8-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+5sRO94VmF1h3VehRh4SlfoAgy3OUrY6M=
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
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  1.0 T_XMDrugObfuBody_09 obfuscated drug references
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;linux-arch@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1199 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.3 (0.3%), b_tie_ro: 2.2 (0.2%), parse: 2.1 (0.2%),
        extract_message_metadata: 36 (3.0%), get_uri_detail_list: 8 (0.7%),
        tests_pri_-1000: 12 (1.0%), tests_pri_-950: 2.2 (0.2%), tests_pri_-900: 1.83
        (0.2%), tests_pri_-400: 54 (4.5%), check_bayes: 52 (4.3%), b_tokenize: 26
        (2.2%), b_tok_get_all: 11 (0.9%), b_comp_prob: 6 (0.5%), b_tok_touch_all: 4.2
        (0.4%), b_finish: 0.90 (0.1%), tests_pri_0: 1071 (89.3%),
        check_dkim_signature: 1.20 (0.1%), check_dkim_adsp: 6 (0.5%), tests_pri_500:
        10 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 08/22] signal/mips: Use force_sig_fault where appropriate
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

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/mips/kernel/traps.c | 65 ++++++++++++++----------------------------------
 arch/mips/mm/fault.c     | 19 ++++----------
 2 files changed, 23 insertions(+), 61 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 967e9e4e795e..66ec4b0b484d 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -699,17 +699,11 @@ static int simulate_sync(struct pt_regs *regs, unsigned int opcode)
 asmlinkage void do_ov(struct pt_regs *regs)
 {
 	enum ctx_state prev_state;
-	siginfo_t info;
-
-	clear_siginfo(&info);
-	info.si_signo = SIGFPE;
-	info.si_code = FPE_INTOVF;
-	info.si_addr = (void __user *)regs->cp0_epc;
 
 	prev_state = exception_enter();
 	die_if_kernel("Integer overflow", regs);
 
-	force_sig_info(SIGFPE, &info, current);
+	force_sig_fault(SIGFPE, FPE_INTOVF, (void __user *)regs->cp0_epc, current);
 	exception_exit(prev_state);
 }
 
@@ -722,32 +716,27 @@ asmlinkage void do_ov(struct pt_regs *regs)
 void force_fcr31_sig(unsigned long fcr31, void __user *fault_addr,
 		     struct task_struct *tsk)
 {
-	struct siginfo si;
-
-	clear_siginfo(&si);
-	si.si_addr = fault_addr;
-	si.si_signo = SIGFPE;
+	int si_code;
 
 	if (fcr31 & FPU_CSR_INV_X)
-		si.si_code = FPE_FLTINV;
+		si_code = FPE_FLTINV;
 	else if (fcr31 & FPU_CSR_DIV_X)
-		si.si_code = FPE_FLTDIV;
+		si_code = FPE_FLTDIV;
 	else if (fcr31 & FPU_CSR_OVF_X)
-		si.si_code = FPE_FLTOVF;
+		si_code = FPE_FLTOVF;
 	else if (fcr31 & FPU_CSR_UDF_X)
-		si.si_code = FPE_FLTUND;
+		si_code = FPE_FLTUND;
 	else if (fcr31 & FPU_CSR_INE_X)
-		si.si_code = FPE_FLTRES;
+		si_code = FPE_FLTRES;
 
-	force_sig_info(SIGFPE, &si, tsk);
+	force_sig_fault(SIGFPE, si_code, fault_addr, tsk);
 }
 
 int process_fpemu_return(int sig, void __user *fault_addr, unsigned long fcr31)
 {
-	struct siginfo si;
+	int si_code;
 	struct vm_area_struct *vma;
 
-	clear_siginfo(&si);
 	switch (sig) {
 	case 0:
 		return 0;
@@ -757,23 +746,18 @@ int process_fpemu_return(int sig, void __user *fault_addr, unsigned long fcr31)
 		return 1;
 
 	case SIGBUS:
-		si.si_addr = fault_addr;
-		si.si_signo = sig;
-		si.si_code = BUS_ADRERR;
-		force_sig_info(sig, &si, current);
+		force_sig_fault(SIGBUS, BUS_ADRERR, fault_addr, current);
 		return 1;
 
 	case SIGSEGV:
-		si.si_addr = fault_addr;
-		si.si_signo = sig;
 		down_read(&current->mm->mmap_sem);
 		vma = find_vma(current->mm, (unsigned long)fault_addr);
 		if (vma && (vma->vm_start <= (unsigned long)fault_addr))
-			si.si_code = SEGV_ACCERR;
+			si_code = SEGV_ACCERR;
 		else
-			si.si_code = SEGV_MAPERR;
+			si_code = SEGV_MAPERR;
 		up_read(&current->mm->mmap_sem);
-		force_sig_info(sig, &si, current);
+		force_sig_fault(SIGSEGV, si_code, fault_addr, current);
 		return 1;
 
 	default:
@@ -896,10 +880,8 @@ asmlinkage void do_fpe(struct pt_regs *regs, unsigned long fcr31)
 void do_trap_or_bp(struct pt_regs *regs, unsigned int code, int si_code,
 	const char *str)
 {
-	siginfo_t info;
 	char b[40];
 
-	clear_siginfo(&info);
 #ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
 	if (kgdb_ll_trap(DIE_TRAP, str, regs, code, current->thread.trap_nr,
 			 SIGTRAP) == NOTIFY_STOP)
@@ -921,13 +903,9 @@ void do_trap_or_bp(struct pt_regs *regs, unsigned int code, int si_code,
 	case BRK_DIVZERO:
 		scnprintf(b, sizeof(b), "%s instruction in kernel code", str);
 		die_if_kernel(b, regs);
-		if (code == BRK_DIVZERO)
-			info.si_code = FPE_INTDIV;
-		else
-			info.si_code = FPE_INTOVF;
-		info.si_signo = SIGFPE;
-		info.si_addr = (void __user *) regs->cp0_epc;
-		force_sig_info(SIGFPE, &info, current);
+		force_sig_fault(SIGFPE,
+				code == BRK_DIVZERO ? FPE_INTDIV : FPE_INTOVF,
+				(void __user *) regs->cp0_epc, current);
 		break;
 	case BRK_BUG:
 		die_if_kernel("Kernel bug detected", regs);
@@ -952,9 +930,7 @@ void do_trap_or_bp(struct pt_regs *regs, unsigned int code, int si_code,
 		scnprintf(b, sizeof(b), "%s instruction in kernel code", str);
 		die_if_kernel(b, regs);
 		if (si_code) {
-			info.si_signo = SIGTRAP;
-			info.si_code = si_code;
-			force_sig_info(SIGTRAP, &info, current);
+			force_sig_fault(SIGTRAP, si_code, NULL,	current);
 		} else {
 			force_sig(SIGTRAP, current);
 		}
@@ -1506,13 +1482,8 @@ asmlinkage void do_mdmx(struct pt_regs *regs)
  */
 asmlinkage void do_watch(struct pt_regs *regs)
 {
-	siginfo_t info;
 	enum ctx_state prev_state;
 
-	clear_siginfo(&info);
-	info.si_signo = SIGTRAP;
-	info.si_code = TRAP_HWBKPT;
-
 	prev_state = exception_enter();
 	/*
 	 * Clear WP (bit 22) bit of cause register so we don't loop
@@ -1528,7 +1499,7 @@ asmlinkage void do_watch(struct pt_regs *regs)
 	if (test_tsk_thread_flag(current, TIF_LOAD_WATCH)) {
 		mips_read_watch_registers();
 		local_irq_enable();
-		force_sig_info(SIGTRAP, &info, current);
+		force_sig_fault(SIGTRAP, TRAP_HWBKPT, NULL, current);
 	} else {
 		mips_clear_watch_registers();
 		local_irq_enable();
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index 75392becd933..5f71f2b903b7 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -42,7 +42,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 	struct task_struct *tsk = current;
 	struct mm_struct *mm = tsk->mm;
 	const int field = sizeof(unsigned long) * 2;
-	siginfo_t info;
+	int si_code;
 	int fault;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
@@ -63,8 +63,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 		return;
 #endif
 
-	clear_siginfo(&info);
-	info.si_code = SEGV_MAPERR;
+	si_code = SEGV_MAPERR;
 
 	/*
 	 * We fault-in kernel-space virtual memory on-demand. The
@@ -113,7 +112,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
  * we can handle it..
  */
 good_area:
-	info.si_code = SEGV_ACCERR;
+	si_code = SEGV_ACCERR;
 
 	if (write) {
 		if (!(vma->vm_flags & VM_WRITE))
@@ -224,11 +223,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 			pr_cont("\n");
 		}
 		current->thread.trap_nr = (regs->cp0_cause >> 2) & 0x1f;
-		info.si_signo = SIGSEGV;
-		info.si_errno = 0;
-		/* info.si_code has been set above */
-		info.si_addr = (void __user *) address;
-		force_sig_info(SIGSEGV, &info, tsk);
+		force_sig_fault(SIGSEGV, si_code, (void __user *)address, tsk);
 		return;
 	}
 
@@ -284,11 +279,7 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 #endif
 	current->thread.trap_nr = (regs->cp0_cause >> 2) & 0x1f;
 	tsk->thread.cp0_badvaddr = address;
-	info.si_signo = SIGBUS;
-	info.si_errno = 0;
-	info.si_code = BUS_ADRERR;
-	info.si_addr = (void __user *) address;
-	force_sig_info(SIGBUS, &info, tsk);
+	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address, tsk);
 
 	return;
 #ifndef CONFIG_64BIT
-- 
2.14.1
