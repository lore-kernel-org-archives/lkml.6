Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755408AbeDTOt0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:49:26 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:44838 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755191AbeDTOqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:46:03 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        user-mode-linux-devel@lists.sourceforge.net
Date: Fri, 20 Apr 2018 09:38:09 -0500
Message-Id: <20180420143811.9994-20-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87604mhrnb.fsf@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
X-XM-SPF: eid=1f9XF4-0006Ha-Ji;;;mid=<20180420143811.9994-20-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18yuPZdMSWqSSSaIQyLPGU4B6gpz8EzN9Q=
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
        *  0.5 XM_Body_Dirty_Words Contains a dirty word
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.1 XMSolicitRefs_0 Weightloss drug
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;linux-arch@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 15029 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.2 (0.0%), b_tie_ro: 2.3 (0.0%), parse: 0.94 (0.0%),
        extract_message_metadata: 16 (0.1%), get_uri_detail_list: 2.7 (0.0%),
        tests_pri_-1000: 2.8 (0.0%), tests_pri_-950: 1.17 (0.0%), tests_pri_-900:
        0.96 (0.0%), tests_pri_-400: 25 (0.2%), check_bayes: 23 (0.2%), b_tokenize: 9
        (0.1%), b_tok_get_all: 7 (0.0%), b_comp_prob: 2.0 (0.0%), b_tok_touch_all:
        3.5 (0.0%), b_finish: 0.56 (0.0%), tests_pri_0: 216 (1.4%),
        check_dkim_signature: 0.48 (0.0%), check_dkim_adsp: 2.7 (0.0%),
        tests_pri_500: 14760 (98.2%), poll_dns_idle: 14750 (98.1%), rewrite_mail:
        0.00 (0.0%)
Subject: [REVIEW][PATCH 20/22] signal/um: Use force_sig_fault where appropriate
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

Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/um/kernel/ptrace.c | 13 +++----------
 arch/um/kernel/trap.c   | 26 ++++++++------------------
 2 files changed, 11 insertions(+), 28 deletions(-)

diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
index bc2a516c190f..1a1d88a4d940 100644
--- a/arch/um/kernel/ptrace.c
+++ b/arch/um/kernel/ptrace.c
@@ -115,17 +115,10 @@ long arch_ptrace(struct task_struct *child, long request,
 static void send_sigtrap(struct task_struct *tsk, struct uml_pt_regs *regs,
 		  int error_code)
 {
-	struct siginfo info;
-
-	memset(&info, 0, sizeof(info));
-	info.si_signo = SIGTRAP;
-	info.si_code = TRAP_BRKPT;
-
-	/* User-mode eip? */
-	info.si_addr = UPT_IS_USER(regs) ? (void __user *) UPT_IP(regs) : NULL;
-
 	/* Send us the fake SIGTRAP */
-	force_sig_info(SIGTRAP, &info, tsk);
+	force_sig_fault(SIGTRAP, TRAP_BRKPT,
+			/* User-mode eip? */
+			UPT_IS_USER(regs) ? (void __user *) UPT_IP(regs) : NULL, tsk);
 }
 
 /*
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 5f0ff17cd790..48b70dcb6963 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -162,14 +162,9 @@ static void show_segv_info(struct uml_pt_regs *regs)
 
 static void bad_segv(struct faultinfo fi, unsigned long ip)
 {
-	struct siginfo si;
-
-	clear_siginfo(&si);
-	si.si_signo = SIGSEGV;
-	si.si_code = SEGV_ACCERR;
-	si.si_addr = (void __user *) FAULT_ADDRESS(fi);
 	current->thread.arch.faultinfo = fi;
-	force_sig_info(SIGSEGV, &si, current);
+	force_sig_fault(SIGSEGV, SEGV_ACCERR, (void __user *) FAULT_ADDRESS(fi),
+			current);
 }
 
 void fatal_sigsegv(void)
@@ -215,13 +210,12 @@ void segv_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 		   struct uml_pt_regs *regs)
 {
-	struct siginfo si;
 	jmp_buf *catcher;
+	int si_code;
 	int err;
 	int is_write = FAULT_WRITE(fi);
 	unsigned long address = FAULT_ADDRESS(fi);
 
-	clear_siginfo(&si);
 	if (!is_user && regs)
 		current->thread.segv_regs = container_of(regs, struct pt_regs, regs);
 
@@ -241,7 +235,7 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 
 	if (SEGV_IS_FIXABLE(&fi))
 		err = handle_page_fault(address, ip, is_write, is_user,
-					&si.si_code);
+					&si_code);
 	else {
 		err = -EFAULT;
 		/*
@@ -273,18 +267,14 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 	show_segv_info(regs);
 
 	if (err == -EACCES) {
-		si.si_signo = SIGBUS;
-		si.si_errno = 0;
-		si.si_code = BUS_ADRERR;
-		si.si_addr = (void __user *)address;
 		current->thread.arch.faultinfo = fi;
-		force_sig_info(SIGBUS, &si, current);
+		force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address,
+				current);
 	} else {
 		BUG_ON(err != -EFAULT);
-		si.si_signo = SIGSEGV;
-		si.si_addr = (void __user *) address;
 		current->thread.arch.faultinfo = fi;
-		force_sig_info(SIGSEGV, &si, current);
+		force_sig_fault(SIGSEGV, si_code, (void __user *) address,
+				current);
 	}
 
 out:
-- 
2.14.1
