Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84190C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E81E21920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390504AbeLUVhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 16:37:01 -0500
Received: from mga14.intel.com ([192.55.52.115]:6014 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733050AbeLUVg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 16:36:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Dec 2018 13:36:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,383,1539673200"; 
   d="scan'208";a="112483879"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.154])
  by orsmga003.jf.intel.com with ESMTP; 21 Dec 2018 13:36:58 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v3 2/2] x86/fault: Decode and print #PF oops in human readable form
Date:   Fri, 21 Dec 2018 13:36:57 -0800
Message-Id: <20181221213657.27628-3-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181221213657.27628-1-sean.j.christopherson@intel.com>
References: <20181221213657.27628-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus pointed out that deciphering the raw #PF error code and printing
a more human readable message are two different things, and also that
printing the negative cases is mostly just noise[1].  For example, the
USER bit doesn't mean the fault originated in user code and stating
that an oops wasn't due to a protection keys violation isn't interesting
since an oops on a keys violation is a one-in-a-million scenario.

Remove the per-bit decoding of the error code and instead print:
  - the raw error code
  - why the fault occurred
  - the effective privilege level of the access
  - the type of access
  - whether the fault originated in user code or kernel code

This provides the user with the information needed to triage 99.9% of
oopses without polluting the log with useless information or conflating
the error_code with the CPL.

Sample output:

    BUG: kernel NULL pointer dereference, address = 0000000000000008
    #PF: supervisor-privileged instruction fetch from kernel code
    #PF: error_code(0x0010) - not-present page

    BUG: unable to handle page fault for address = ffffbeef00000000
    #PF: supervisor-privileged instruction fetch from kernel code
    #PF: error_code(0x0010) - not-present page

    BUG: unable to handle page fault for address = ffffc90000230000
    #PF: supervisor-privileged write access from kernel code
    #PF: error_code(0x000b) - reserved bit violation

[1] https://lkml.kernel.org/r/CAHk-=whk_fsnxVMvF1T2fFCaP2WrvSybABrLQCWLJyCvHw6NKA@mail.gmail.com

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/mm/fault.c | 42 +++++++++++-------------------------------
 1 file changed, 11 insertions(+), 31 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 39dccdfef496..a4421cbd230b 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -603,24 +603,9 @@ static void show_ldttss(const struct desc_ptr *gdt, const char *name, u16 index)
 		 name, index, addr, (desc.limit0 | (desc.limit1 << 16)));
 }
 
-/*
- * This helper function transforms the #PF error_code bits into
- * "[PROT] [USER]" type of descriptive, almost human-readable error strings:
- */
-static void err_str_append(unsigned long error_code, char *buf, unsigned long mask, const char *txt)
-{
-	if (error_code & mask) {
-		if (buf[0])
-			strcat(buf, " ");
-		strcat(buf, txt);
-	}
-}
-
 static void
 show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long address)
 {
-	char err_txt[64];
-
 	if (!oops_may_print())
 		return;
 
@@ -651,27 +636,22 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long ad
 		pr_alert("BUG: unable to handle page fault for address = %px\n",
 			(void *)address);
 
-	err_txt[0] = 0;
-
-	/*
-	 * Note: length of these appended strings including the separation space and the
-	 * zero delimiter must fit into err_txt[].
-	 */
-	err_str_append(error_code, err_txt, X86_PF_PROT,  "[PROT]" );
-	err_str_append(error_code, err_txt, X86_PF_WRITE, "[WRITE]");
-	err_str_append(error_code, err_txt, X86_PF_USER,  "[USER]" );
-	err_str_append(error_code, err_txt, X86_PF_RSVD,  "[RSVD]" );
-	err_str_append(error_code, err_txt, X86_PF_INSTR, "[INSTR]");
-	err_str_append(error_code, err_txt, X86_PF_PK,    "[PK]"   );
-
-	pr_alert("#PF error: %s\n", error_code ? err_txt : "[normal kernel read fault]");
+	pr_alert("#PF: %s-privileged %s from %s code\n",
+		 (error_code & X86_PF_USER)  ? "user" : "supervisor",
+		 (error_code & X86_PF_INSTR) ? "instruction fetch" :
+		 (error_code & X86_PF_WRITE) ? "write access" :
+					       "read access",
+			     user_mode(regs) ? "user" : "kernel");
+	pr_alert("#PF: error_code(0x%04lx) - %s\n", error_code,
+		 !(error_code & X86_PF_PROT) ? "not-present page" :
+		 (error_code & X86_PF_RSVD)  ? "reserved bit violation" :
+		 (error_code & X86_PF_PK)    ? "protection keys violation" :
+					       "permissions violation");
 
 	if (!(error_code & X86_PF_USER) && user_mode(regs)) {
 		struct desc_ptr idt, gdt;
 		u16 ldtr, tr;
 
-		pr_alert("This was a system access from user code\n");
-
 		/*
 		 * This can happen for quite a few reasons.  The more obvious
 		 * ones are faults accessing the GDT, or LDT.  Perhaps
-- 
2.19.2

