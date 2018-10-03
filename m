Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9246EC64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53AFA21477
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53AFA21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeJDEW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 00:22:57 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:14656 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727071AbeJDEWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 00:22:48 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 3 Oct 2018 14:32:27 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id BFF1F407CB;
        Wed,  3 Oct 2018 14:32:32 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>
Subject: [PATCH v9 10/10] x86: jump-labels: use macros instead of inline assembly
Date:   Wed, 3 Oct 2018 14:31:00 -0700
Message-ID: <20181003213100.189959-11-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181003213100.189959-1-namit@vmware.com>
References: <20181003213100.189959-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use assembly macros for jump-labels and call them from inline assembly.
This not only makes the code more readable, but also improves
compilation decision, specifically inline decisions which GCC base on
the number of new lines in inline assembly.

As a result the code size is slightly increased.

   text	   data	    bss	    dec	    hex	filename
18163528 10226300 2957312 31347140 1de51c4 ./vmlinux before
18163608 10227348 2957312 31348268 1de562c ./vmlinux after (+1128)

And functions such as intel_pstate_adjust_policy_max(),
kvm_cpu_accept_dm_intr(), kvm_register_readl() are inlined.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/entry/calling.h          |  2 +-
 arch/x86/include/asm/jump_label.h | 77 +++++++++++--------------------
 arch/x86/kernel/macros.S          |  1 +
 3 files changed, 30 insertions(+), 50 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 352e70cd33e8..708b46a54578 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -338,7 +338,7 @@ For 32-bit we have the following conventions - kernel is built with
 .macro CALL_enter_from_user_mode
 #ifdef CONFIG_CONTEXT_TRACKING
 #ifdef HAVE_JUMP_LABEL
-	STATIC_JUMP_IF_FALSE .Lafter_call_\@, context_tracking_enabled, def=0
+	STATIC_BRANCH_JMP l_yes=.Lafter_call_\@, key=context_tracking_enabled, branch=1
 #endif
 	call enter_from_user_mode
 .Lafter_call_\@:
diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 8c0de4282659..4606a7101f97 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -2,19 +2,6 @@
 #ifndef _ASM_X86_JUMP_LABEL_H
 #define _ASM_X86_JUMP_LABEL_H
 
-#ifndef HAVE_JUMP_LABEL
-/*
- * For better or for worse, if jump labels (the gcc extension) are missing,
- * then the entire static branch patching infrastructure is compiled out.
- * If that happens, the code in here will malfunction.  Raise a compiler
- * error instead.
- *
- * In theory, jump labels and the static branch patching infrastructure
- * could be decoupled to fix this.
- */
-#error asm/jump_label.h included on a non-jump-label kernel
-#endif
-
 #define JUMP_LABEL_NOP_SIZE 5
 
 #ifdef CONFIG_X86_64
@@ -28,18 +15,27 @@
 
 #ifndef __ASSEMBLY__
 
+#ifndef HAVE_JUMP_LABEL
+/*
+ * For better or for worse, if jump labels (the gcc extension) are missing,
+ * then the entire static branch patching infrastructure is compiled out.
+ * If that happens, the code in here will malfunction.  Raise a compiler
+ * error instead.
+ *
+ * In theory, jump labels and the static branch patching infrastructure
+ * could be decoupled to fix this.
+ */
+#error asm/jump_label.h included on a non-jump-label kernel
+#endif
+
 #include <linux/stringify.h>
 #include <linux/types.h>
 
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("1:"
-		".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"
-		".pushsection __jump_table,  \"aw\" \n\t"
-		_ASM_ALIGN "\n\t"
-		_ASM_PTR "1b, %l[l_yes], %c0 + %c1 \n\t"
-		".popsection \n\t"
-		: :  "i" (key), "i" (branch) : : l_yes);
+	asm_volatile_goto("STATIC_BRANCH_NOP l_yes=\"%l[l_yes]\" key=\"%c0\" "
+			  "branch=\"%c1\""
+			: :  "i" (key), "i" (branch) : : l_yes);
 
 	return false;
 l_yes:
@@ -48,13 +44,8 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 
 static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("1:"
-		".byte 0xe9\n\t .long %l[l_yes] - 2f\n\t"
-		"2:\n\t"
-		".pushsection __jump_table,  \"aw\" \n\t"
-		_ASM_ALIGN "\n\t"
-		_ASM_PTR "1b, %l[l_yes], %c0 + %c1 \n\t"
-		".popsection \n\t"
+	asm_volatile_goto("STATIC_BRANCH_JMP l_yes=\"%l[l_yes]\" key=\"%c0\" "
+			  "branch=\"%c1\""
 		: :  "i" (key), "i" (branch) : : l_yes);
 
 	return false;
@@ -76,35 +67,23 @@ struct jump_entry {
 
 #else	/* __ASSEMBLY__ */
 
-.macro STATIC_JUMP_IF_TRUE target, key, def
-.Lstatic_jump_\@:
-	.if \def
-	/* Equivalent to "jmp.d32 \target" */
-	.byte		0xe9
-	.long		\target - .Lstatic_jump_after_\@
-.Lstatic_jump_after_\@:
-	.else
-	.byte		STATIC_KEY_INIT_NOP
-	.endif
+.macro STATIC_BRANCH_NOP l_yes:req key:req branch:req
+1:
+	.byte STATIC_KEY_INIT_NOP
 	.pushsection __jump_table, "aw"
 	_ASM_ALIGN
-	_ASM_PTR	.Lstatic_jump_\@, \target, \key
+	_ASM_PTR 1b, \l_yes, \key + \branch
 	.popsection
 .endm
 
-.macro STATIC_JUMP_IF_FALSE target, key, def
-.Lstatic_jump_\@:
-	.if \def
-	.byte		STATIC_KEY_INIT_NOP
-	.else
-	/* Equivalent to "jmp.d32 \target" */
-	.byte		0xe9
-	.long		\target - .Lstatic_jump_after_\@
-.Lstatic_jump_after_\@:
-	.endif
+.macro STATIC_BRANCH_JMP l_yes:req key:req branch:req
+1:
+	.byte 0xe9
+	.long \l_yes - 2f
+2:
 	.pushsection __jump_table, "aw"
 	_ASM_ALIGN
-	_ASM_PTR	.Lstatic_jump_\@, \target, \key + 1
+	_ASM_PTR 1b, \l_yes, \key + \branch
 	.popsection
 .endm
 
diff --git a/arch/x86/kernel/macros.S b/arch/x86/kernel/macros.S
index bf8b9c93e255..161c95059044 100644
--- a/arch/x86/kernel/macros.S
+++ b/arch/x86/kernel/macros.S
@@ -13,3 +13,4 @@
 #include <asm/paravirt.h>
 #include <asm/asm.h>
 #include <asm/cpufeature.h>
+#include <asm/jump_label.h>
-- 
2.17.1

