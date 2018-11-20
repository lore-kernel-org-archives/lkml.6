Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B00C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F2B2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F2B2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbeKUO0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 09:26:34 -0500
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:2110 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727874AbeKUO0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 09:26:11 -0500
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 20 Nov 2018 19:52:59 -0800
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id B710FB1872;
        Tue, 20 Nov 2018 22:53:30 -0500 (EST)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, <linux_dti@icloud.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v6 10/10] x86/alternative: remove the return value of text_poke_*()
Date:   Tue, 20 Nov 2018 12:35:45 -0800
Message-ID: <20181120203545.34928-11-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181120203545.34928-1-namit@vmware.com>
References: <20181120203545.34928-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of text_poke_early() and text_poke_bp() is useless.
Remove it.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/text-patching.h |  4 ++--
 arch/x86/kernel/alternative.c        | 11 ++++-------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index a75eed841eed..c90678fd391a 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -18,7 +18,7 @@ static inline void apply_paravirt(struct paravirt_patch_site *start,
 #define __parainstructions_end	NULL
 #endif
 
-extern void *text_poke_early(void *addr, const void *opcode, size_t len);
+extern void text_poke_early(void *addr, const void *opcode, size_t len);
 
 /*
  * Clear and restore the kernel write-protection flag on the local CPU.
@@ -37,7 +37,7 @@ extern void *text_poke_early(void *addr, const void *opcode, size_t len);
 extern void *text_poke(void *addr, const void *opcode, size_t len);
 extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
 extern int poke_int3_handler(struct pt_regs *regs);
-extern void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
+extern void text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
 extern int after_bootmem;
 extern __ro_after_init struct mm_struct *poking_mm;
 extern __ro_after_init unsigned long poking_addr;
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 18415e3b6000..2740ad2c6f21 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -264,7 +264,7 @@ static void __init_or_module add_nops(void *insns, unsigned int len)
 
 extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
 extern s32 __smp_locks[], __smp_locks_end[];
-void *text_poke_early(void *addr, const void *opcode, size_t len);
+void text_poke_early(void *addr, const void *opcode, size_t len);
 
 /*
  * Are we looking at a near JMP with a 1 or 4-byte displacement.
@@ -666,8 +666,8 @@ void __init alternative_instructions(void)
  * instructions. And on the local CPU you need to be protected again NMI or MCE
  * handlers seeing an inconsistent instruction while you patch.
  */
-void *__init_or_module text_poke_early(void *addr, const void *opcode,
-				       size_t len)
+void __init_or_module text_poke_early(void *addr, const void *opcode,
+				      size_t len)
 {
 	unsigned long flags;
 
@@ -690,7 +690,6 @@ void *__init_or_module text_poke_early(void *addr, const void *opcode,
 		 * that causes hangs on some VIA CPUs.
 		 */
 	}
-	return addr;
 }
 
 __ro_after_init struct mm_struct *poking_mm;
@@ -893,7 +892,7 @@ int poke_int3_handler(struct pt_regs *regs)
  *	  replacing opcode
  *	- sync cores
  */
-void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
+void text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
 {
 	unsigned char int3 = 0xcc;
 
@@ -935,7 +934,5 @@ void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
 	 * the writing of the new instruction.
 	 */
 	bp_patching_in_progress = false;
-
-	return addr;
 }
 
-- 
2.17.1

