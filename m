Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755367AbeDTOqM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:46:12 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:36378 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755165AbeDTOqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:46:01 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org
Date: Fri, 20 Apr 2018 09:38:00 -0500
Message-Id: <20180420143811.9994-11-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87604mhrnb.fsf@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
X-XM-SPF: eid=1f9XDo-0006Ha-5m;;;mid=<20180420143811.9994-11-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19Ihac0nOE8QLMTjZdFYtG7hgPS6xFmrWI=
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
X-Spam-Timing: total 15037 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.7 (0.0%), b_tie_ro: 1.86 (0.0%), parse: 0.85 (0.0%),
        extract_message_metadata: 20 (0.1%), get_uri_detail_list: 3.2 (0.0%),
        tests_pri_-1000: 3.0 (0.0%), tests_pri_-950: 1.28 (0.0%), tests_pri_-900:
        1.05 (0.0%), tests_pri_-400: 40 (0.3%), check_bayes: 39 (0.3%), b_tokenize:
        20 (0.1%), b_tok_get_all: 9 (0.1%), b_comp_prob: 2.2 (0.0%), b_tok_touch_all:
        5 (0.0%), b_finish: 0.64 (0.0%), tests_pri_0: 342 (2.3%),
        check_dkim_signature: 0.52 (0.0%), check_dkim_adsp: 3.4 (0.0%),
        tests_pri_500: 14624 (97.3%), poll_dns_idle: 14606 (97.1%), rewrite_mail:
        0.00 (0.0%)
Subject: [REVIEW][PATCH 11/22] signal/openrisc: Use force_sig_fault where appropriate
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

Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: openrisc@lists.librecores.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/openrisc/kernel/traps.c | 33 ++++-----------------------------
 arch/openrisc/mm/fault.c     | 19 +++++--------------
 2 files changed, 9 insertions(+), 43 deletions(-)

diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index 1610b1d65a11..fac246e6f37a 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -250,28 +250,16 @@ void __init trap_init(void)
 
 asmlinkage void do_trap(struct pt_regs *regs, unsigned long address)
 {
-	siginfo_t info;
-	clear_siginfo(&info);
-	info.si_signo = SIGTRAP;
-	info.si_code = TRAP_TRACE;
-	info.si_addr = (void *)address;
-	force_sig_info(SIGTRAP, &info, current);
+	force_sig_fault(SIGTRAP, TRAP_TRACE, (void __user *)address, current);
 
 	regs->pc += 4;
 }
 
 asmlinkage void do_unaligned_access(struct pt_regs *regs, unsigned long address)
 {
-	siginfo_t info;
-
 	if (user_mode(regs)) {
 		/* Send a SIGBUS */
-		clear_siginfo(&info);
-		info.si_signo = SIGBUS;
-		info.si_errno = 0;
-		info.si_code = BUS_ADRALN;
-		info.si_addr = (void __user *)address;
-		force_sig_info(SIGBUS, &info, current);
+		force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)address, current);
 	} else {
 		printk("KERNEL: Unaligned Access 0x%.8lx\n", address);
 		show_registers(regs);
@@ -282,16 +270,9 @@ asmlinkage void do_unaligned_access(struct pt_regs *regs, unsigned long address)
 
 asmlinkage void do_bus_fault(struct pt_regs *regs, unsigned long address)
 {
-	siginfo_t info;
-
 	if (user_mode(regs)) {
 		/* Send a SIGBUS */
-		clear_siginfo(&info);
-		info.si_signo = SIGBUS;
-		info.si_errno = 0;
-		info.si_code = BUS_ADRERR;
-		info.si_addr = (void *)address;
-		force_sig_info(SIGBUS, &info, current);
+		force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address, current);
 	} else {		/* Kernel mode */
 		printk("KERNEL: Bus error (SIGBUS) 0x%.8lx\n", address);
 		show_registers(regs);
@@ -466,7 +447,6 @@ static inline void simulate_swa(struct pt_regs *regs, unsigned long address,
 asmlinkage void do_illegal_instruction(struct pt_regs *regs,
 				       unsigned long address)
 {
-	siginfo_t info;
 	unsigned int op;
 	unsigned int insn = *((unsigned int *)address);
 
@@ -487,12 +467,7 @@ asmlinkage void do_illegal_instruction(struct pt_regs *regs,
 
 	if (user_mode(regs)) {
 		/* Send a SIGILL */
-		clear_siginfo(&info);
-		info.si_signo = SIGILL;
-		info.si_errno = 0;
-		info.si_code = ILL_ILLOPC;
-		info.si_addr = (void *)address;
-		force_sig_info(SIGBUS, &info, current);
+		force_sig_fault(SIGILL, ILL_ILLOPC, (void __user *)address, current);
 	} else {		/* Kernel mode */
 		printk("KERNEL: Illegal instruction (SIGILL) 0x%.8lx\n",
 		       address);
diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index 68be33e4ae17..9f011d16cc46 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -52,11 +52,10 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 	struct task_struct *tsk;
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
-	siginfo_t info;
+	int si_code;
 	int fault;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
-	clear_siginfo(&info);
 	tsk = current;
 
 	/*
@@ -98,7 +97,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 	}
 
 	mm = tsk->mm;
-	info.si_code = SEGV_MAPERR;
+	si_code = SEGV_MAPERR;
 
 	/*
 	 * If we're in an interrupt or have no user
@@ -140,7 +139,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 	 */
 
 good_area:
-	info.si_code = SEGV_ACCERR;
+	si_code = SEGV_ACCERR;
 
 	/* first do some preliminary protection checks */
 
@@ -214,11 +213,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 	/* User mode accesses just cause a SIGSEGV */
 
 	if (user_mode(regs)) {
-		info.si_signo = SIGSEGV;
-		info.si_errno = 0;
-		/* info.si_code has been set above */
-		info.si_addr = (void *)address;
-		force_sig_info(SIGSEGV, &info, tsk);
+		force_sig_fault(SIGSEGV, si_code, (void __user *)address, tsk);
 		return;
 	}
 
@@ -283,11 +278,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * Send a sigbus, regardless of whether we were in kernel
 	 * or user mode.
 	 */
-	info.si_signo = SIGBUS;
-	info.si_errno = 0;
-	info.si_code = BUS_ADRERR;
-	info.si_addr = (void *)address;
-	force_sig_info(SIGBUS, &info, tsk);
+	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address, tsk);
 
 	/* Kernel mode? Handle exceptions or die */
 	if (!user_mode(regs))
-- 
2.14.1
