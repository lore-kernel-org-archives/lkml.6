Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755474AbeDTOlc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:41:32 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:46256 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755295AbeDTOlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:41:05 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>
Date: Fri, 20 Apr 2018 09:37:58 -0500
Message-Id: <20180420143811.9994-9-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87604mhrnb.fsf@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
X-XM-SPF: eid=1f9XDV-0006Ha-Aj;;;mid=<20180420143811.9994-9-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18rLsQ50xUZyustg48GN5Qaya9kljWH/bQ=
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
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.1 XMSolicitRefs_0 Weightloss drug
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;linux-arch@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 15023 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.9 (0.0%), b_tie_ro: 4.0 (0.0%), parse: 0.79 (0.0%),
        extract_message_metadata: 10 (0.1%), get_uri_detail_list: 2.3 (0.0%),
        tests_pri_-1000: 2.7 (0.0%), tests_pri_-950: 1.20 (0.0%), tests_pri_-900:
        0.96 (0.0%), tests_pri_-400: 24 (0.2%), check_bayes: 23 (0.2%), b_tokenize: 9
        (0.1%), b_tok_get_all: 7 (0.0%), b_comp_prob: 2.00 (0.0%), b_tok_touch_all:
        2.9 (0.0%), b_finish: 0.55 (0.0%), tests_pri_0: 230 (1.5%),
        check_dkim_signature: 0.71 (0.0%), check_dkim_adsp: 3.8 (0.0%),
        tests_pri_500: 14746 (98.2%), poll_dns_idle: 14738 (98.1%), rewrite_mail:
        0.00 (0.0%)
Subject: [REVIEW][PATCH 09/22] signal/nds32: Use force_sig_fault where appropriate
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

Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/nds32/kernel/traps.c | 20 ++++----------------
 arch/nds32/mm/fault.c     | 19 +++++--------------
 2 files changed, 9 insertions(+), 30 deletions(-)

diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
index 46911768f4b5..636d1c7aa895 100644
--- a/arch/nds32/kernel/traps.c
+++ b/arch/nds32/kernel/traps.c
@@ -222,20 +222,13 @@ void die_if_kernel(const char *str, struct pt_regs *regs, int err)
 
 int bad_syscall(int n, struct pt_regs *regs)
 {
-	siginfo_t info;
-
 	if (current->personality != PER_LINUX) {
 		send_sig(SIGSEGV, current, 1);
 		return regs->uregs[0];
 	}
 
-	clear_siginfo(&info);
-	info.si_signo = SIGILL;
-	info.si_errno = 0;
-	info.si_code = ILL_ILLTRP;
-	info.si_addr = (void __user *)instruction_pointer(regs) - 4;
-
-	force_sig_info(SIGILL, &info, current);
+	force_sig_fault(SIGILL, ILL_ILLTRP,
+			(void __user *)instruction_pointer(regs) - 4, current);
 	die_if_kernel("Oops - bad syscall", regs, n);
 	return regs->uregs[0];
 }
@@ -288,16 +281,11 @@ void __init early_trap_init(void)
 void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs,
 		  int error_code, int si_code)
 {
-	struct siginfo info;
-
 	tsk->thread.trap_no = ENTRY_DEBUG_RELATED;
 	tsk->thread.error_code = error_code;
 
-	clear_siginfo(&info);
-	info.si_signo = SIGTRAP;
-	info.si_code = si_code;
-	info.si_addr = (void __user *)instruction_pointer(regs);
-	force_sig_info(SIGTRAP, &info, tsk);
+	force_sig_fault(SIGTRAP, si_code
+			(void __user *)instruction_pointer(regs), tsk);
 }
 
 void do_debug_trap(unsigned long entry, unsigned long addr,
diff --git a/arch/nds32/mm/fault.c b/arch/nds32/mm/fault.c
index 876ee01ff80a..9bdb7c3ecbb6 100644
--- a/arch/nds32/mm/fault.c
+++ b/arch/nds32/mm/fault.c
@@ -72,16 +72,15 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 	struct task_struct *tsk;
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
-	siginfo_t info;
+	int si_code;
 	int fault;
 	unsigned int mask = VM_READ | VM_WRITE | VM_EXEC;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
-	clear_siginfo(&info);
 	error_code = error_code & (ITYPE_mskINST | ITYPE_mskETYPE);
 	tsk = current;
 	mm = tsk->mm;
-	info.si_code = SEGV_MAPERR;
+	si_code = SEGV_MAPERR;
 	/*
 	 * We fault-in kernel-space virtual memory on-demand. The
 	 * 'reference' page table is init_mm.pgd.
@@ -162,7 +161,7 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 	 */
 
 good_area:
-	info.si_code = SEGV_ACCERR;
+	si_code = SEGV_ACCERR;
 
 	/* first do some preliminary protection checks */
 	if (entry == ENTRY_PTE_NOT_PRESENT) {
@@ -267,11 +266,7 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 		tsk->thread.address = addr;
 		tsk->thread.error_code = error_code;
 		tsk->thread.trap_no = entry;
-		info.si_signo = SIGSEGV;
-		info.si_errno = 0;
-		/* info.si_code has been set above */
-		info.si_addr = (void *)addr;
-		force_sig_info(SIGSEGV, &info, tsk);
+		force_sig_fault(SIGSEGV, si_code, (void __user *)addr, tsk);
 		return;
 	}
 
@@ -340,11 +335,7 @@ void do_page_fault(unsigned long entry, unsigned long addr,
 	tsk->thread.address = addr;
 	tsk->thread.error_code = error_code;
 	tsk->thread.trap_no = entry;
-	info.si_signo = SIGBUS;
-	info.si_errno = 0;
-	info.si_code = BUS_ADRERR;
-	info.si_addr = (void *)addr;
-	force_sig_info(SIGBUS, &info, tsk);
+	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)addr, tsk);
 
 	return;
 
-- 
2.14.1
