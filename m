Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755342AbeDTOkW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:40:22 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:46148 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755159AbeDTOkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:40:20 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-alpha@vger.kernel.org
Date: Fri, 20 Apr 2018 09:37:51 -0500
Message-Id: <20180420143811.9994-2-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87604mhrnb.fsf@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
X-XM-SPF: eid=1f9XCm-0006Ha-9p;;;mid=<20180420143811.9994-2-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/uiJ7sAT4hexccBTnj12FhxL6ETtFKXZc=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.1 XMSolicitRefs_0 Weightloss drug
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;linux-arch@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 15035 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.3 (0.0%), b_tie_ro: 1.48 (0.0%), parse: 1.11 (0.0%),
        extract_message_metadata: 24 (0.2%), get_uri_detail_list: 3.3 (0.0%),
        tests_pri_-1000: 4.2 (0.0%), tests_pri_-950: 1.64 (0.0%), tests_pri_-900:
        1.35 (0.0%), tests_pri_-400: 32 (0.2%), check_bayes: 30 (0.2%), b_tokenize:
        13 (0.1%), b_tok_get_all: 9 (0.1%), b_comp_prob: 3.1 (0.0%), b_tok_touch_all:
        2.8 (0.0%), b_finish: 0.58 (0.0%), tests_pri_0: 193 (1.3%),
        check_dkim_signature: 0.47 (0.0%), check_dkim_adsp: 2.7 (0.0%),
        tests_pri_500: 14772 (98.2%), poll_dns_idle: 14762 (98.2%), rewrite_mail:
        0.00 (0.0%)
Subject: [REVIEW][PATCH 02/22] signal/alpha: Use force_sig_fault where appropriate
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

Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-alpha@vger.kernel.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/alpha/kernel/traps.c |  9 +--------
 arch/alpha/mm/fault.c     | 15 ++-------------
 2 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/arch/alpha/kernel/traps.c b/arch/alpha/kernel/traps.c
index 106a1692fca0..bc9627698796 100644
--- a/arch/alpha/kernel/traps.c
+++ b/arch/alpha/kernel/traps.c
@@ -400,16 +400,9 @@ do_entIF(unsigned long type, struct pt_regs *regs)
 asmlinkage void
 do_entDbg(struct pt_regs *regs)
 {
-	siginfo_t info;
-
 	die_if_kernel("Instruction fault", regs, 0, NULL);
 
-	clear_siginfo(&info);
-	info.si_signo = SIGILL;
-	info.si_errno = 0;
-	info.si_code = ILL_ILLOPC;
-	info.si_addr = (void __user *) regs->pc;
-	force_sig_info(SIGILL, &info, current);
+	force_sig_fault(SIGILL, ILL_ILLOPC, (void __user *)regs->pc, 0, current);
 }
 
 
diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index 7f2202a9f50a..de2bd217adad 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -88,11 +88,8 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 	struct mm_struct *mm = current->mm;
 	const struct exception_table_entry *fixup;
 	int fault, si_code = SEGV_MAPERR;
-	siginfo_t info;
 	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
-	clear_siginfo(&info);
-
 	/* As of EV6, a load into $31/$f31 is a prefetch, and never faults
 	   (or is suppressed by the PALcode).  Support that for older CPUs
 	   by ignoring such an instruction.  */
@@ -223,21 +220,13 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 	up_read(&mm->mmap_sem);
 	/* Send a sigbus, regardless of whether we were in kernel
 	   or user mode.  */
-	info.si_signo = SIGBUS;
-	info.si_errno = 0;
-	info.si_code = BUS_ADRERR;
-	info.si_addr = (void __user *) address;
-	force_sig_info(SIGBUS, &info, current);
+	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *) address, 0, current);
 	if (!user_mode(regs))
 		goto no_context;
 	return;
 
  do_sigsegv:
-	info.si_signo = SIGSEGV;
-	info.si_errno = 0;
-	info.si_code = si_code;
-	info.si_addr = (void __user *) address;
-	force_sig_info(SIGSEGV, &info, current);
+	force_sig_fault(SIGSEGV, si_code, (void __user *) address, 0, current);
 	return;
 
 #ifdef CONFIG_ALPHA_LARGE_VMALLOC
-- 
2.14.1
