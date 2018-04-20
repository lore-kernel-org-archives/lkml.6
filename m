Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755465AbeDTOlK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:41:10 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:44306 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755422AbeDTOlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:41:07 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ley Foon Tan <lftan@altera.com>, nios2-dev@lists.rocketboards.org
Date: Fri, 20 Apr 2018 09:37:59 -0500
Message-Id: <20180420143811.9994-10-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87604mhrnb.fsf@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
X-XM-SPF: eid=1f9XDm-0006Ha-3B;;;mid=<20180420143811.9994-10-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/Rfks/bGhNbFsw14qlQx5twKxOfLeyIMI=
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
        *  0.1 XMSolicitRefs_0 Weightloss drug
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;linux-arch@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 212 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 3.5 (1.6%), b_tie_ro: 2.3 (1.1%), parse: 1.27 (0.6%),
        extract_message_metadata: 21 (9.8%), get_uri_detail_list: 1.82 (0.9%),
        tests_pri_-1000: 11 (5.0%), tests_pri_-950: 1.48 (0.7%), tests_pri_-900: 1.21
        (0.6%), tests_pri_-400: 20 (9.6%), check_bayes: 19 (9.1%), b_tokenize: 6
        (3.0%), b_tok_get_all: 6 (2.8%), b_comp_prob: 2.2 (1.0%), b_tok_touch_all:
        2.6 (1.2%), b_finish: 0.67 (0.3%), tests_pri_0: 142 (67.0%),
        check_dkim_signature: 0.51 (0.2%), check_dkim_adsp: 3.3 (1.5%),
        tests_pri_500: 7 (3.3%), poll_dns_idle: 0.37 (0.2%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 10/22] signal/nios2: Use force_sig_fault where appropriate
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

Cc: Ley Foon Tan <lftan@altera.com>
Cc: nios2-dev@lists.rocketboards.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/nios2/kernel/traps.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/nios2/kernel/traps.c b/arch/nios2/kernel/traps.c
index a69861d3e1a3..3bc3cd22b750 100644
--- a/arch/nios2/kernel/traps.c
+++ b/arch/nios2/kernel/traps.c
@@ -26,14 +26,7 @@ static DEFINE_SPINLOCK(die_lock);
 
 static void _send_sig(int signo, int code, unsigned long addr)
 {
-	siginfo_t info;
-
-	clear_siginfo(&info);
-	info.si_signo = signo;
-	info.si_errno = 0;
-	info.si_code = code;
-	info.si_addr = (void __user *) addr;
-	force_sig_info(signo, &info, current);
+	force_sig_fault(signo, code, (void __user *) addr, current);
 }
 
 void die(const char *str, struct pt_regs *regs, long err)
-- 
2.14.1
