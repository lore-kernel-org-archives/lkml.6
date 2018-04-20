Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755434AbeDTOrk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:47:40 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:44854 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755265AbeDTOqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:46:05 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Date: Fri, 20 Apr 2018 09:38:05 -0500
Message-Id: <20180420143811.9994-16-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87604mhrnb.fsf@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
X-XM-SPF: eid=1f9XES-0006Ha-G0;;;mid=<20180420143811.9994-16-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19azVYOH3SdfiJMspUSwNIKtjNNxhe0aBs=
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
X-Spam-Timing: total 780 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.1 (0.4%), b_tie_ro: 2.1 (0.3%), parse: 1.42 (0.2%),
        extract_message_metadata: 37 (4.8%), get_uri_detail_list: 5 (0.6%),
        tests_pri_-1000: 15 (2.0%), tests_pri_-950: 2.4 (0.3%), tests_pri_-900: 1.90
        (0.2%), tests_pri_-400: 39 (5.0%), check_bayes: 37 (4.7%), b_tokenize: 16
        (2.0%), b_tok_get_all: 8 (1.1%), b_comp_prob: 4.3 (0.5%), b_tok_touch_all:
        2.2 (0.3%), b_finish: 0.85 (0.1%), tests_pri_0: 666 (85.3%),
        check_dkim_signature: 1.04 (0.1%), check_dkim_adsp: 5 (0.7%), tests_pri_500:
        8 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 16/22] signal/sh: Use force_sig_fault where appropriate
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

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/sh/kernel/traps_32.c | 19 +++++--------------
 arch/sh/math-emu/math.c   |  9 ++-------
 arch/sh/mm/fault.c        | 10 +---------
 3 files changed, 8 insertions(+), 30 deletions(-)

diff --git a/arch/sh/kernel/traps_32.c b/arch/sh/kernel/traps_32.c
index e85e59c3d6df..660a4bc17698 100644
--- a/arch/sh/kernel/traps_32.c
+++ b/arch/sh/kernel/traps_32.c
@@ -477,7 +477,6 @@ asmlinkage void do_address_error(struct pt_regs *regs,
 {
 	unsigned long error_code = 0;
 	mm_segment_t oldfs;
-	siginfo_t info;
 	insn_size_t instruction;
 	int tmp;
 
@@ -537,12 +536,7 @@ asmlinkage void do_address_error(struct pt_regs *regs,
 		       "access (PC %lx PR %lx)\n", current->comm, regs->pc,
 		       regs->pr);
 
-		clear_siginfo(&info);
-		info.si_signo = SIGBUS;
-		info.si_errno = 0;
-		info.si_code = si_code;
-		info.si_addr = (void __user *)address;
-		force_sig_info(SIGBUS, &info, current);
+		force_sig_fault(SIGBUS, si_code, (void __user *)address, current);
 	} else {
 		inc_unaligned_kernel_access();
 
@@ -599,20 +593,17 @@ int is_dsp_inst(struct pt_regs *regs)
 #ifdef CONFIG_CPU_SH2A
 asmlinkage void do_divide_error(unsigned long r4)
 {
-	siginfo_t info;
+	int code;
 
-	clear_siginfo(&info);
 	switch (r4) {
 	case TRAP_DIVZERO_ERROR:
-		info.si_code = FPE_INTDIV;
+		code = FPE_INTDIV;
 		break;
 	case TRAP_DIVOVF_ERROR:
-		info.si_code = FPE_INTOVF;
+		code = FPE_INTOVF;
 		break;
 	}
-
-	info.si_signo = SIGFPE;
-	force_sig_info(info.si_signo, &info, current);
+	force_sig_fault(SIGFPE, code, NULL, current);
 }
 #endif
 
diff --git a/arch/sh/math-emu/math.c b/arch/sh/math-emu/math.c
index d6d2213df078..a0fa8fc88739 100644
--- a/arch/sh/math-emu/math.c
+++ b/arch/sh/math-emu/math.c
@@ -507,7 +507,6 @@ static int ieee_fpe_handler(struct pt_regs *regs)
 	unsigned short insn = *(unsigned short *)regs->pc;
 	unsigned short finsn;
 	unsigned long nextpc;
-	siginfo_t info;
 	int nib[4] = {
 		(insn >> 12) & 0xf,
 		(insn >> 8) & 0xf,
@@ -560,12 +559,8 @@ static int ieee_fpe_handler(struct pt_regs *regs)
 				~(FPSCR_CAUSE_MASK | FPSCR_FLAG_MASK);
 			task_thread_info(tsk)->status |= TS_USEDFPU;
 		} else {
-			clear_siginfo(&info);
-			info.si_signo = SIGFPE;
-			info.si_errno = 0;
-			info.si_code = FPE_FLTINV;
-			info.si_addr = (void __user *)regs->pc;
-			force_sig_info(SIGFPE, &info, tsk);
+			force_sig_fault(SIGFPE, FPE_FLTINV,
+					(void __user *)regs->pc, tsk);
 		}
 
 		regs->pc = nextpc;
diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index 4c98b6f20e02..b8e7bb84b6b1 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -42,15 +42,7 @@ static void
 force_sig_info_fault(int si_signo, int si_code, unsigned long address,
 		     struct task_struct *tsk)
 {
-	siginfo_t info;
-
-	clear_siginfo(&info);
-	info.si_signo	= si_signo;
-	info.si_errno	= 0;
-	info.si_code	= si_code;
-	info.si_addr	= (void __user *)address;
-
-	force_sig_info(si_signo, &info, tsk);
+	force_sig_fault(si_signo, si_code, (void __user *)address, tsk);
 }
 
 /*
-- 
2.14.1
