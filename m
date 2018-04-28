Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933631AbeD1OHt (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 10:07:49 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:36975 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933579AbeD1OHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 10:07:41 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Linux-Arch <linux-arch@vger.kernel.org>
Cc: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        =?UTF-8?q?Martin=20P=C3=A4rtel?= <martin.partel@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date: Sat, 28 Apr 2018 09:07:02 -0500
Message-Id: <20180428140702.3925-5-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87zi1nctut.fsf_-_@xmission.com>
References: <87zi1nctut.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1fCQVn-0002Sz-84;;;mid=<20180428140702.3925-5-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.116.237.29;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/SzuVNlbNfwhR5lO9Sxh1bpqBwywF3Ye0=
X-SA-Exim-Connect-IP: 68.116.237.29
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.5 XM_Body_Dirty_Words Contains a dirty word
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Linux-Arch <linux-arch@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 569 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.7 (0.6%), b_tie_ro: 2.5 (0.4%), parse: 1.80 (0.3%),
        extract_message_metadata: 35 (6.2%), get_uri_detail_list: 4.8 (0.8%),
        tests_pri_-1000: 16 (2.8%), tests_pri_-950: 1.60 (0.3%), tests_pri_-900: 1.26
        (0.2%), tests_pri_-400: 30 (5.3%), check_bayes: 29 (5.1%), b_tokenize: 10
        (1.8%), b_tok_get_all: 10 (1.7%), b_comp_prob: 2.7 (0.5%), b_tok_touch_all:
        4.0 (0.7%), b_finish: 0.62 (0.1%), tests_pri_0: 229 (40.2%),
        check_dkim_signature: 0.56 (0.1%), check_dkim_adsp: 3.3 (0.6%),
        tests_pri_500: 246 (43.2%), poll_dns_idle: 234 (41.1%), rewrite_mail: 0.00
        (0.0%)
Subject: [REVIEW][PATCH 5/5] signal/um: More carefully relay signals in relay_signal.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a bug in relay signal.  It assumes that when a signal is
relayed the signal never uses a signal independent si_code, such
as SI_USER, SI_KERNEL, SI_QUEUE, ... SI_SIGIO etc.  In practice
siginfo was assuming it was relaying a signal with the SIL_FAULT
layout.  As that is the common cases for the signals it supported
that is a reasonable assumption.

Further user mode linux must be very careful when relaying different
kinds of signals to prevent an information leak.  This means simply
increasing the kinds of signals that are handled in relay_signal
is non-trivial.

Therefore use siginfo_layout and force_sig_fault to simplify
the signal relaying in relay_signal.

By taking advantage of the fact that user mode linux only works
on x86 and x86_64 we can assume that si_trapno can be ignored,
and that si_errno is always zero.

For the signals SIGLL, SIGFPE, SIGSEGV, SIGBUS, and SIGTRAP the only
fault handler I know of that sets si_errno is SIGTRAP TRAP_HWBKPT on a
few oddball architectures.  Those architectures have been modified to
use force_sig_ptrace_errno_trap.

Similarly only a few architectures set __ARCH_SI_TRAPNO.

At the point uml supports those architectures again these additional
cases can be examined and supported if desired in relay_signal.

Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: Martin Pärtel <martin.partel@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-um@lists.infradead.org
Fixes: d3c1cfcdb43e ("um: pass siginfo to guest process")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/um/kernel/trap.c | 38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index d18be983814a..ec9a42c14c56 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -286,9 +286,7 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 
 void relay_signal(int sig, struct siginfo *si, struct uml_pt_regs *regs)
 {
-	struct faultinfo *fi;
-	struct siginfo clean_si;
-
+	int code, err;
 	if (!UPT_IS_USER(regs)) {
 		if (sig == SIGBUS)
 			printk(KERN_ERR "Bus error - the host /dev/shm or /tmp "
@@ -298,29 +296,21 @@ void relay_signal(int sig, struct siginfo *si, struct uml_pt_regs *regs)
 
 	arch_examine_signal(sig, regs);
 
-	clear_siginfo(&clean_si);
-	clean_si.si_signo = si->si_signo;
-	clean_si.si_errno = si->si_errno;
-	clean_si.si_code = si->si_code;
-	switch (sig) {
-	case SIGILL:
-	case SIGFPE:
-	case SIGSEGV:
-	case SIGBUS:
-	case SIGTRAP:
-		fi = UPT_FAULTINFO(regs);
-		clean_si.si_addr = (void __user *) FAULT_ADDRESS(*fi);
+	/* Is the signal layout for the signal known?
+	 * Signal data must be scrubbed to prevent information leaks.
+	 */
+	code = si->si_code;
+	err = si->si_errno;
+	if ((err == 0) && (siginfo_layout(sig, code) == SIL_FAULT)) {
+		struct faultinfo *fi = UPT_FAULTINFO(regs);
 		current->thread.arch.faultinfo = *fi;
-#ifdef __ARCH_SI_TRAPNO
-		clean_si.si_trapno = si->si_trapno;
-#endif
-		break;
-	default:
-		printk(KERN_ERR "Attempted to relay unknown signal %d (si_code = %d)\n",
-			sig, si->si_code);
+		force_sig_fault(sig, code, (void __user *)FAULT_ADDRESS(*fi),
+				current);
+	} else {
+		printk(KERN_ERR "Attempted to relay unknown signal %d (si_code = %d) with errno %d\n",
+		       sig, code, err);
+		force_sig(sig, current);
 	}
-
-	force_sig_info(sig, &clean_si, current);
 }
 
 void bus_handler(int sig, struct siginfo *si, struct uml_pt_regs *regs)
-- 
2.14.1
