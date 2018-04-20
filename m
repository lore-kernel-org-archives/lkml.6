Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755440AbeDTOku (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:40:50 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:44253 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755160AbeDTOkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:40:45 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michal Simek <monstr@monstr.eu>
Date: Fri, 20 Apr 2018 09:37:56 -0500
Message-Id: <20180420143811.9994-7-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87604mhrnb.fsf@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
X-XM-SPF: eid=1f9XDQ-0006Ha-1j;;;mid=<20180420143811.9994-7-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/CeKj8uKU97zAH3M6UK1hNg5q8AZPldsI=
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
X-Spam-Timing: total 638 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 3.1 (0.5%), b_tie_ro: 2.1 (0.3%), parse: 1.21 (0.2%),
        extract_message_metadata: 30 (4.7%), get_uri_detail_list: 3.0 (0.5%),
        tests_pri_-1000: 12 (1.9%), tests_pri_-950: 2.1 (0.3%), tests_pri_-900: 1.72
        (0.3%), tests_pri_-400: 31 (4.8%), check_bayes: 29 (4.5%), b_tokenize: 11
        (1.7%), b_tok_get_all: 7 (1.1%), b_comp_prob: 3.3 (0.5%), b_tok_touch_all:
        2.4 (0.4%), b_finish: 1.16 (0.2%), tests_pri_0: 430 (67.5%),
        check_dkim_signature: 0.82 (0.1%), check_dkim_adsp: 4.6 (0.7%),
        tests_pri_500: 120 (18.8%), poll_dns_idle: 109 (17.0%), rewrite_mail: 0.00
        (0.0%)
Subject: [REVIEW][PATCH 07/22] signal/microblaze: Use force_sig_fault where appropriate
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

Cc: Michal Simek <monstr@monstr.eu>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/microblaze/kernel/exceptions.c | 9 +--------
 arch/microblaze/mm/fault.c          | 9 +--------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/microblaze/kernel/exceptions.c b/arch/microblaze/kernel/exceptions.c
index 443ec1feacb4..eafff21fcb0e 100644
--- a/arch/microblaze/kernel/exceptions.c
+++ b/arch/microblaze/kernel/exceptions.c
@@ -60,17 +60,10 @@ asmlinkage void sw_exception(struct pt_regs *regs)
 
 void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
 {
-	siginfo_t info;
-
 	if (kernel_mode(regs))
 		die("Exception in kernel mode", regs, signr);
 
-	clear_siginfo(&info);
-	info.si_signo = signr;
-	info.si_errno = 0;
-	info.si_code = code;
-	info.si_addr = (void __user *) addr;
-	force_sig_info(signr, &info, current);
+	force_sig_fault(signr, code, (void __user *)addr, current);
 }
 
 asmlinkage void full_exception(struct pt_regs *regs, unsigned int type,
diff --git a/arch/microblaze/mm/fault.c b/arch/microblaze/mm/fault.c
index 1251d380df47..af607447c683 100644
--- a/arch/microblaze/mm/fault.c
+++ b/arch/microblaze/mm/fault.c
@@ -289,14 +289,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
 do_sigbus:
 	up_read(&mm->mmap_sem);
 	if (user_mode(regs)) {
-		siginfo_t info;
-
-		clear_siginfo(&info);
-		info.si_signo = SIGBUS;
-		info.si_errno = 0;
-		info.si_code = BUS_ADRERR;
-		info.si_addr = (void __user *)address;
-		force_sig_info(SIGBUS, &info, current);
+		force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address, current);
 		return;
 	}
 	bad_page_fault(regs, address, SIGBUS);
-- 
2.14.1
