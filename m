Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755330AbeDTOqK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:46:10 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:46782 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755162AbeDTOqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:46:01 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        user-mode-linux-devel@lists.sourceforge.net
Date: Fri, 20 Apr 2018 09:38:08 -0500
Message-Id: <20180420143811.9994-19-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87604mhrnb.fsf@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
X-XM-SPF: eid=1f9XF2-0006Ha-IS;;;mid=<20180420143811.9994-19-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+NKTwDTgL2nyk43WvG212L9P6YuhmcM28=
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
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.5 XM_Body_Dirty_Words Contains a dirty word
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;linux-arch@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 277 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.5 (1.3%), b_tie_ro: 2.4 (0.9%), parse: 0.88 (0.3%),
        extract_message_metadata: 17 (6.0%), get_uri_detail_list: 2.2 (0.8%),
        tests_pri_-1000: 8 (2.8%), tests_pri_-950: 1.18 (0.4%), tests_pri_-900: 0.96
        (0.3%), tests_pri_-400: 26 (9.5%), check_bayes: 25 (9.2%), b_tokenize: 7
        (2.6%), b_tok_get_all: 8 (2.8%), b_comp_prob: 2.1 (0.7%), b_tok_touch_all: 7
        (2.4%), b_finish: 0.58 (0.2%), tests_pri_0: 210 (75.9%),
        check_dkim_signature: 0.67 (0.2%), check_dkim_adsp: 3.6 (1.3%),
        tests_pri_500: 7 (2.4%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 19/22] signal/um: Use force_sig_fault in relay_signal.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today user mode linux only works on x86 and x86_64 and this allows
simplifications of relay_signal.

- x86 always set si_errno to 0 in fault handlers.
- x86 does not implement si_trapno.
- Only si_codes between SI_USER and SI_KERNEL have a fault address.

Therefore warn if si_errno is set (it should never be).
Use force_sig_info in the case where we know we have a good fault.

For signals whose content it is not clear how to relay use plain
force_sig and let the signal sending code come up with an
appropriate generic siginfo.

Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/um/kernel/trap.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index d4d38520c4c6..5f0ff17cd790 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -296,9 +296,6 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 
 void relay_signal(int sig, struct siginfo *si, struct uml_pt_regs *regs)
 {
-	struct faultinfo *fi;
-	struct siginfo clean_si;
-
 	if (!UPT_IS_USER(regs)) {
 		if (sig == SIGBUS)
 			printk(KERN_ERR "Bus error - the host /dev/shm or /tmp "
@@ -308,29 +305,30 @@ void relay_signal(int sig, struct siginfo *si, struct uml_pt_regs *regs)
 
 	arch_examine_signal(sig, regs);
 
-	clear_siginfo(&clean_si);
-	clean_si.si_signo = si->si_signo;
-	clean_si.si_errno = si->si_errno;
-	clean_si.si_code = si->si_code;
+	if (unlikely(si->si_errno)) {
+		printk(KERN_ERR "Attempted to relay signal %d (si_code = %d) with errno %d\n",
+		       sig, si->si_code, si->si_errno);
+	}
 	switch (sig) {
 	case SIGILL:
 	case SIGFPE:
 	case SIGSEGV:
 	case SIGBUS:
 	case SIGTRAP:
-		fi = UPT_FAULTINFO(regs);
-		clean_si.si_addr = (void __user *) FAULT_ADDRESS(*fi);
-		current->thread.arch.faultinfo = *fi;
-#ifdef __ARCH_SI_TRAPNO
-		clean_si.si_trapno = si->si_trapno;
-#endif
-		break;
+		if ((si->si_code > SI_USER) && (si->si_code < SI_KERNEL)) {
+			struct faultinfo *fi = UPT_FAULTINFO(regs);
+			current->thread.arch.faultinfo = *fi;
+			force_sig_fault(sig, si->si_code,
+					(void __user *)FAULT_ADDRESS(*fi),
+					current);
+			break;
+		}
 	default:
 		printk(KERN_ERR "Attempted to relay unknown signal %d (si_code = %d)\n",
 			sig, si->si_code);
 	}
 
-	force_sig_info(sig, &clean_si, current);
+	force_sig(sig, current);
 }
 
 void bus_handler(int sig, struct siginfo *si, struct uml_pt_regs *regs)
-- 
2.14.1
