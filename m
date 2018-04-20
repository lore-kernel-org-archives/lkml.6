Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755391AbeDTOqO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:46:14 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:46792 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755171AbeDTOqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:46:03 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        James Bottomley <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>,
        linux-parisc@vger.kernel.org
Date: Fri, 20 Apr 2018 09:38:01 -0500
Message-Id: <20180420143811.9994-12-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87604mhrnb.fsf@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
X-XM-SPF: eid=1f9XE5-0006Ha-0n;;;mid=<20180420143811.9994-12-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19+7aR8UAOPisVR28mcInADRn2AZb7oPkk=
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
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;linux-arch@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 261 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 2.7 (1.0%), b_tie_ro: 1.90 (0.7%), parse: 1.33 (0.5%),
        extract_message_metadata: 26 (9.8%), get_uri_detail_list: 3.2 (1.2%),
        tests_pri_-1000: 14 (5.3%), tests_pri_-950: 1.60 (0.6%), tests_pri_-900: 1.32
        (0.5%), tests_pri_-400: 24 (9.3%), check_bayes: 23 (8.8%), b_tokenize: 7
        (2.8%), b_tok_get_all: 6 (2.4%), b_comp_prob: 2.9 (1.1%), b_tok_touch_all:
        3.6 (1.4%), b_finish: 0.83 (0.3%), tests_pri_0: 182 (69.8%),
        check_dkim_signature: 0.56 (0.2%), check_dkim_adsp: 4.7 (1.8%),
        tests_pri_500: 4.3 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 12/22] signal/parisc: Use force_sig_mceerr where appropriate
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In do_page_fault where an mceerr is generated stop and call force_sig_mceerr.
Keeping the mcerr handling logic out of the force_sig_info call below.

This ensures that only and always in the mcerr case is lsb interesting.

This ensures setting set si_lsb in the future won't accidentally
stomp another siginfo field in the non mcerr case.

Cc: James Bottomley <jejb@parisc-linux.org>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/parisc/mm/fault.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
index 657b35096bd8..51215b0048ef 100644
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -354,7 +354,6 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 
 	if (user_mode(regs)) {
 		struct siginfo si;
-		unsigned int lsb = 0;
 
 		clear_siginfo(&si);
 		switch (code) {
@@ -391,26 +390,27 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 
 #ifdef CONFIG_MEMORY_FAILURE
 		if (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
+			unsigned int lsb = 0;
 			printk(KERN_ERR
 	"MCE: Killing %s:%d due to hardware memory corruption fault at %08lx\n",
 			tsk->comm, tsk->pid, address);
-			si.si_signo = SIGBUS;
-			si.si_code = BUS_MCEERR_AR;
+			/*
+			 * Either small page or large page may be poisoned.
+			 * In other words, VM_FAULT_HWPOISON_LARGE and
+			 * VM_FAULT_HWPOISON are mutually exclusive.
+			 */
+			if (fault & VM_FAULT_HWPOISON_LARGE)
+				lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
+			else if (fault & VM_FAULT_HWPOISON)
+				lsb = PAGE_SHIFT;
+
+			force_sig_mceerr(BUS_MCEERR_AR, (void __user *) address,
+					 lsb, current);
+			return;
 		}
 #endif
 
-		/*
-		 * Either small page or large page may be poisoned.
-		 * In other words, VM_FAULT_HWPOISON_LARGE and
-		 * VM_FAULT_HWPOISON are mutually exclusive.
-		 */
-		if (fault & VM_FAULT_HWPOISON_LARGE)
-			lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
-		else if (fault & VM_FAULT_HWPOISON)
-			lsb = PAGE_SHIFT;
-		else
-			show_signal_msg(regs, code, address, tsk, vma);
-		si.si_addr_lsb = lsb;
+		show_signal_msg(regs, code, address, tsk, vma);
 
 		si.si_errno = 0;
 		si.si_addr = (void __user *) address;
-- 
2.14.1
