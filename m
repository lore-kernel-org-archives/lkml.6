Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755400AbeDTOkl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:40:41 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:44224 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755165AbeDTOkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:40:37 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org
Date: Fri, 20 Apr 2018 09:37:52 -0500
Message-Id: <20180420143811.9994-3-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87604mhrnb.fsf@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
X-XM-SPF: eid=1f9XD3-0006Ha-3u;;;mid=<20180420143811.9994-3-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/NlapnllvD6eFaAY9a2h9zvzZedSmBsyY=
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
X-Spam-Timing: total 15021 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.3 (0.0%), b_tie_ro: 1.60 (0.0%), parse: 0.63 (0.0%),
        extract_message_metadata: 11 (0.1%), get_uri_detail_list: 1.30 (0.0%),
        tests_pri_-1000: 2.5 (0.0%), tests_pri_-950: 1.12 (0.0%), tests_pri_-900:
        0.90 (0.0%), tests_pri_-400: 17 (0.1%), check_bayes: 16 (0.1%), b_tokenize: 5
        (0.0%), b_tok_get_all: 6 (0.0%), b_comp_prob: 1.53 (0.0%), b_tok_touch_all:
        2.5 (0.0%), b_finish: 0.52 (0.0%), tests_pri_0: 127 (0.8%),
        check_dkim_signature: 0.41 (0.0%), check_dkim_adsp: 2.6 (0.0%),
        tests_pri_500: 14856 (98.9%), poll_dns_idle: 14848 (98.8%), rewrite_mail:
        0.00 (0.0%)
Subject: [REVIEW][PATCH 03/22] signal/c6x: Use force_sig_fault where appropriate
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

Cc: Mark Salter <msalter@redhat.com>
Cc: Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
Cc: linux-c6x-dev@linux-c6x.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/c6x/kernel/traps.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/c6x/kernel/traps.c b/arch/c6x/kernel/traps.c
index c5feee4542b0..5c60aea3b75a 100644
--- a/arch/c6x/kernel/traps.c
+++ b/arch/c6x/kernel/traps.c
@@ -244,9 +244,7 @@ static struct exception_info eexcept_table[128] = {
 static void do_trap(struct exception_info *except_info, struct pt_regs *regs)
 {
 	unsigned long addr = instruction_pointer(regs);
-	siginfo_t info;
 
-	clear_siginfo(&info);
 	if (except_info->code != TRAP_BRKPT)
 		pr_err("TRAP: %s PC[0x%lx] signo[%d] code[%d]\n",
 		       except_info->kernel_str, regs->pc,
@@ -254,12 +252,8 @@ static void do_trap(struct exception_info *except_info, struct pt_regs *regs)
 
 	die_if_kernel(except_info->kernel_str, regs, addr);
 
-	info.si_signo = except_info->signo;
-	info.si_errno = 0;
-	info.si_code  = except_info->code;
-	info.si_addr  = (void __user *)addr;
-
-	force_sig_info(except_info->signo, &info, current);
+	force_sig_fault(except_info->signo, except_info->code,
+			(void __user *)addr, current);
 }
 
 /*
-- 
2.14.1
