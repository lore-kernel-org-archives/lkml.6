Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755501AbeDTOsD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:48:03 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:44848 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755226AbeDTOqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:46:04 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        linux-riscv@lists.infradead.org
Date: Fri, 20 Apr 2018 09:38:03 -0500
Message-Id: <20180420143811.9994-14-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87604mhrnb.fsf@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
X-XM-SPF: eid=1f9XEN-0006Ha-Vu;;;mid=<20180420143811.9994-14-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX184+zbdD9QuV7wRWMkaXqcMxJEIryKhjlo=
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
        *  0.1 XMSolicitRefs_0 Weightloss drug
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;linux-arch@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 188 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.4 (1.3%), b_tie_ro: 1.58 (0.8%), parse: 0.66 (0.4%),
        extract_message_metadata: 15 (8.0%), get_uri_detail_list: 1.37 (0.7%),
        tests_pri_-1000: 9 (4.6%), tests_pri_-950: 1.17 (0.6%), tests_pri_-900: 1.00
        (0.5%), tests_pri_-400: 21 (10.9%), check_bayes: 20 (10.4%), b_tokenize: 5
        (2.9%), b_tok_get_all: 7 (3.5%), b_comp_prob: 1.75 (0.9%), b_tok_touch_all:
        2.5 (1.3%), b_finish: 0.58 (0.3%), tests_pri_0: 132 (70.2%),
        check_dkim_signature: 0.44 (0.2%), check_dkim_adsp: 2.3 (1.2%),
        tests_pri_500: 3.9 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 14/22] signal/riscv: Use force_sig_fault where appropriate
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

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <albert@sifive.com>
Cc: linux-riscv@lists.infradead.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/riscv/kernel/traps.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 48aa6471cede..3087940008f4 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -66,14 +66,7 @@ void die(struct pt_regs *regs, const char *str)
 static inline void do_trap_siginfo(int signo, int code,
 	unsigned long addr, struct task_struct *tsk)
 {
-	siginfo_t info;
-
-	clear_siginfo(&info);
-	info.si_signo = signo;
-	info.si_errno = 0;
-	info.si_code = code;
-	info.si_addr = (void __user *)addr;
-	force_sig_info(signo, &info, tsk);
+	force_sig_fault(signo, code, (void __user *)addr, tsk);
 }
 
 void do_trap(struct pt_regs *regs, int signo, int code,
-- 
2.14.1
