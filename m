Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755473AbeDTOr6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:47:58 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:46805 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755239AbeDTOqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:46:04 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Max Filippov <jcmvbkbc@gmail.com>, Chris Zankel <chris@zankel.net>,
        linux-xtensa@linux-xtensa.org
Date: Fri, 20 Apr 2018 09:38:11 -0500
Message-Id: <20180420143811.9994-22-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87604mhrnb.fsf@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
X-XM-SPF: eid=1f9XFN-0006Ha-Dp;;;mid=<20180420143811.9994-22-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/S5WJW2aoH/ri6jqto97FrhZ6RdjhvbtE=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  0.1 XMSolicitRefs_0 Weightloss drug
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;linux-arch@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 268 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.6 (1.0%), b_tie_ro: 1.82 (0.7%), parse: 0.74 (0.3%),
        extract_message_metadata: 15 (5.8%), get_uri_detail_list: 2.3 (0.8%),
        tests_pri_-1000: 10 (3.6%), tests_pri_-950: 1.16 (0.4%), tests_pri_-900: 0.96
        (0.4%), tests_pri_-400: 24 (9.0%), check_bayes: 23 (8.6%), b_tokenize: 8
        (3.1%), b_tok_get_all: 7 (2.7%), b_comp_prob: 2.1 (0.8%), b_tok_touch_all:
        3.1 (1.2%), b_finish: 0.56 (0.2%), tests_pri_0: 207 (77.1%),
        check_dkim_signature: 0.49 (0.2%), check_dkim_adsp: 2.6 (1.0%),
        tests_pri_500: 4.0 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 22/22] signal/xtensa: Use force_sig_fault where appropriate
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

Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: linux-xtensa@linux-xtensa.org
Cc: linux-xtensa@linux-xtensa.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/xtensa/kernel/traps.c | 10 +---------
 arch/xtensa/mm/fault.c     | 19 +++++--------------
 2 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 90b509f65b6f..86507fa7c2d7 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -323,8 +323,6 @@ do_illegal_instruction(struct pt_regs *regs)
 void
 do_unaligned_user (struct pt_regs *regs)
 {
-	siginfo_t info;
-
 	__die_if_kernel("Unhandled unaligned exception in kernel",
 			regs, SIGKILL);
 
@@ -334,13 +332,7 @@ do_unaligned_user (struct pt_regs *regs)
 			    "(pid = %d, pc = %#010lx)\n",
 			    regs->excvaddr, current->comm,
 			    task_pid_nr(current), regs->pc);
-	clear_siginfo(&info);
-	info.si_signo = SIGBUS;
-	info.si_errno = 0;
-	info.si_code = BUS_ADRALN;
-	info.si_addr = (void *) regs->excvaddr;
-	force_sig_info(SIGBUS, &info, current);
-
+	force_sig_fault(SIGBUS, BUS_ADRALN, (void *) regs->excvaddr, current);
 }
 #endif
 
diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
index f9323a3e61ce..c111a833205a 100644
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -39,14 +39,13 @@ void do_page_fault(struct pt_regs *regs)
 	struct mm_struct *mm = current->mm;
 	unsigned int exccause = regs->exccause;
 	unsigned int address = regs->excvaddr;
-	siginfo_t info;
+	int code;
 
 	int is_write, is_exec;
 	int fault;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
-	clear_siginfo(&info);
-	info.si_code = SEGV_MAPERR;
+	code = SEGV_MAPERR;
 
 	/* We fault-in kernel-space virtual memory on-demand. The
 	 * 'reference' page table is init_mm.pgd.
@@ -92,7 +91,7 @@ void do_page_fault(struct pt_regs *regs)
 	 */
 
 good_area:
-	info.si_code = SEGV_ACCERR;
+	code = SEGV_ACCERR;
 
 	if (is_write) {
 		if (!(vma->vm_flags & VM_WRITE))
@@ -158,11 +157,7 @@ void do_page_fault(struct pt_regs *regs)
 	if (user_mode(regs)) {
 		current->thread.bad_vaddr = address;
 		current->thread.error_code = is_write;
-		info.si_signo = SIGSEGV;
-		info.si_errno = 0;
-		/* info.si_code has been set above */
-		info.si_addr = (void *) address;
-		force_sig_info(SIGSEGV, &info, current);
+		force_sig_fault(SIGSEGV, code, (void *) address, current);
 		return;
 	}
 	bad_page_fault(regs, address, SIGSEGV);
@@ -187,11 +182,7 @@ void do_page_fault(struct pt_regs *regs)
 	 * or user mode.
 	 */
 	current->thread.bad_vaddr = address;
-	info.si_code = SIGBUS;
-	info.si_errno = 0;
-	info.si_code = BUS_ADRERR;
-	info.si_addr = (void *) address;
-	force_sig_info(SIGBUS, &info, current);
+	force_sig_fault(SIGBUS, BUS_ADRERR, (void *) address, current);
 
 	/* Kernel mode? Handle exceptions or die */
 	if (!user_mode(regs))
-- 
2.14.1
