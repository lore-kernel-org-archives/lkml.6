Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755435AbeDTOmT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:42:19 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:46200 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755297AbeDTOkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:40:39 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org
Date: Fri, 20 Apr 2018 09:37:53 -0500
Message-Id: <20180420143811.9994-4-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87604mhrnb.fsf@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
X-XM-SPF: eid=1f9XDJ-0006Ha-SB;;;mid=<20180420143811.9994-4-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/NJPy2dLQbV/bT8Nx9MRnBMYJrpzdy2Do=
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
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;linux-arch@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 680 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.0 (0.4%), b_tie_ro: 2.1 (0.3%), parse: 1.34 (0.2%),
        extract_message_metadata: 31 (4.6%), get_uri_detail_list: 4.2 (0.6%),
        tests_pri_-1000: 12 (1.8%), tests_pri_-950: 2.1 (0.3%), tests_pri_-900: 1.75
        (0.3%), tests_pri_-400: 42 (6.1%), check_bayes: 39 (5.8%), b_tokenize: 14
        (2.1%), b_tok_get_all: 12 (1.7%), b_comp_prob: 4.3 (0.6%), b_tok_touch_all:
        4.2 (0.6%), b_finish: 2.00 (0.3%), tests_pri_0: 572 (84.2%),
        check_dkim_signature: 0.91 (0.1%), check_dkim_adsp: 5.0 (0.7%),
        tests_pri_500: 9 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 04/22] signal/hexagon: Use force_sig_fault as appropriate
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

Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/hexagon/kernel/traps.c | 10 ++--------
 arch/hexagon/mm/vm_fault.c  | 21 +++++++--------------
 2 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
index 1ff6a6a7b97c..91ee04842c22 100644
--- a/arch/hexagon/kernel/traps.c
+++ b/arch/hexagon/kernel/traps.c
@@ -412,11 +412,6 @@ void do_trap0(struct pt_regs *regs)
 	case TRAP_DEBUG:
 		/* Trap0 0xdb is debug breakpoint */
 		if (user_mode(regs)) {
-			struct siginfo info;
-
-			clear_siginfo(&info);
-			info.si_signo = SIGTRAP;
-			info.si_errno = 0;
 			/*
 			 * Some architecures add some per-thread state
 			 * to distinguish between breakpoint traps and
@@ -424,9 +419,8 @@ void do_trap0(struct pt_regs *regs)
 			 * set the si_code value appropriately, or we
 			 * may want to use a different trap0 flavor.
 			 */
-			info.si_code = TRAP_BRKPT;
-			info.si_addr = (void __user *) pt_elr(regs);
-			force_sig_info(SIGTRAP, &info, current);
+			force_sig_fault(SIGTRAP, TRAP_BRKPT,
+					(void __user *) pt_elr(regs), current);
 		} else {
 #ifdef CONFIG_KGDB
 			kgdb_handle_exception(pt_cause(regs), SIGTRAP,
diff --git a/arch/hexagon/mm/vm_fault.c b/arch/hexagon/mm/vm_fault.c
index 2ad92edc877c..933bbcef5363 100644
--- a/arch/hexagon/mm/vm_fault.c
+++ b/arch/hexagon/mm/vm_fault.c
@@ -50,13 +50,12 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 {
 	struct vm_area_struct *vma;
 	struct mm_struct *mm = current->mm;
-	siginfo_t info;
+	int si_signo;
 	int si_code = SEGV_MAPERR;
 	int fault;
 	const struct exception_table_entry *fixup;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
-	clear_siginfo(&info);
 	/*
 	 * If we're in an interrupt or have no user context,
 	 * then must not take the fault.
@@ -141,28 +140,22 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 	 * unable to fix up the page fault.
 	 */
 	if (fault & VM_FAULT_SIGBUS) {
-		info.si_signo = SIGBUS;
-		info.si_code = BUS_ADRERR;
+		si_signo = SIGBUS;
+		si_code = BUS_ADRERR;
 	}
 	/* Address is not in the memory map */
 	else {
-		info.si_signo = SIGSEGV;
-		info.si_code = SEGV_ACCERR;
+		si_signo = SIGSEGV;
+		si_code  = SEGV_ACCERR;
 	}
-	info.si_errno = 0;
-	info.si_addr = (void __user *)address;
-	force_sig_info(info.si_signo, &info, current);
+	force_sig_fault(si_signo, si_code, (void __user *)address, current);
 	return;
 
 bad_area:
 	up_read(&mm->mmap_sem);
 
 	if (user_mode(regs)) {
-		info.si_signo = SIGSEGV;
-		info.si_errno = 0;
-		info.si_code = si_code;
-		info.si_addr = (void *)address;
-		force_sig_info(info.si_signo, &info, current);
+		force_sig_fault(SIGSEGV, si_code, (void __user *)address, current);
 		return;
 	}
 	/* Kernel-mode fault falls through */
-- 
2.14.1
