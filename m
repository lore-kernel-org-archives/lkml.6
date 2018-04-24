Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752353AbeDXPct (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:32:49 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:56946 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbeDXPcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:32:41 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>, linux-kernel@vger.kernel.org,
        Albert Ou <albert@sifive.com>
References: <87604mhrnb.fsf@xmission.com>
        <20180420143811.9994-14-ebiederm@xmission.com>
        <20180421072550.GA6973@infradead.org>
Date: Tue, 24 Apr 2018 10:31:15 -0500
In-Reply-To: <20180421072550.GA6973@infradead.org> (Christoph Hellwig's
        message of "Sat, 21 Apr 2018 00:25:50 -0700")
Message-ID: <87lgdcei4c.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fAzvr-0001DY-Vb;;;mid=<87lgdcei4c.fsf_-_@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+WDaj2D/V5/6KE+ux6VW//rK+8b/NktYw=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4846]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Christoph Hellwig <hch@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 195 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.6 (1.4%), b_tie_ro: 1.87 (1.0%), parse: 0.78 (0.4%),
        extract_message_metadata: 16 (8.1%), get_uri_detail_list: 1.46 (0.7%),
        tests_pri_-1000: 9 (4.7%), tests_pri_-950: 1.19 (0.6%), tests_pri_-900: 1.01
        (0.5%), tests_pri_-400: 20 (10.1%), check_bayes: 19 (9.6%), b_tokenize: 6
        (3.2%), b_tok_get_all: 6 (3.0%), b_comp_prob: 1.78 (0.9%), b_tok_touch_all:
        3.0 (1.5%), b_finish: 0.56 (0.3%), tests_pri_0: 138 (70.9%),
        check_dkim_signature: 0.48 (0.2%), check_dkim_adsp: 2.9 (1.5%),
        tests_pri_500: 3.8 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 23/22] signal/riscv: Replace do_trap_siginfo with force_sig_fault
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The function force_sig_fault is just the generic version of
do_trap_siginfo with a (void __user *) instead of an unsigned long
parameter for the address.

So just use force_sig_fault to simplify the code.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <albert@sifive.com>
Cc: linux-riscv@lists.infradead.org
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/riscv/kernel/traps.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 3087940008f4..b99d9dd21fd0 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -63,12 +63,6 @@ void die(struct pt_regs *regs, const char *str)
 		do_exit(SIGSEGV);
 }
 
-static inline void do_trap_siginfo(int signo, int code,
-	unsigned long addr, struct task_struct *tsk)
-{
-	force_sig_fault(signo, code, (void __user *)addr, tsk);
-}
-
 void do_trap(struct pt_regs *regs, int signo, int code,
 	unsigned long addr, struct task_struct *tsk)
 {
@@ -81,7 +75,7 @@ void do_trap(struct pt_regs *regs, int signo, int code,
 		show_regs(regs);
 	}
 
-	do_trap_siginfo(signo, code, addr, tsk);
+	force_sig_fault(signo, code, (void __user *)addr, tsk);
 }
 
 static void do_trap_error(struct pt_regs *regs, int signo, int code,
@@ -143,7 +137,7 @@ asmlinkage void do_trap_break(struct pt_regs *regs)
 	}
 #endif /* CONFIG_GENERIC_BUG */
 
-	do_trap_siginfo(SIGTRAP, TRAP_BRKPT, regs->sepc, current);
+	force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)(regs->sepc), current);
 	regs->sepc += 0x4;
 }
 
-- 
2.14.1
