Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 4b7RKUjIHVs0fgAAmS7hNA
	; Mon, 11 Jun 2018 01:30:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 34F1060792; Mon, 11 Jun 2018 01:30:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6C91C601D2;
	Mon, 11 Jun 2018 01:30:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6C91C601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932188AbeFKBaZ convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 21 others);
        Sun, 10 Jun 2018 21:30:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45153 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753714AbeFKBaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 21:30:24 -0400
Received: from wld62.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w5B1U2nd3570021
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sun, 10 Jun 2018 18:30:02 -0700
Date: Sun, 10 Jun 2018 18:29:54 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20180610141911.52948-10-namit@vmware.com>
References: <20180610141911.52948-1-namit@vmware.com> <20180610141911.52948-10-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v3 9/9] x86: jump-labels: use macros instead of inline assembly
To: Nadav Amit <namit@vmware.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
CC: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>
From: hpa@zytor.com
Message-ID: <FF974700-F60D-4083-836C-0D4A2557FA16@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 10, 2018 7:19:11 AM PDT, Nadav Amit <namit@vmware.com> wrote:
>Use assembly macros for jump-labels and call them from inline assembly.
>This not only makes the code more readable, but also improves
>compilation decision, specifically inline decisions which GCC base on
>the number of new lines in inline assembly.
>
>As a result the code size is slightly increased.
>
>   text	   data	    bss	    dec	    hex	filename
>18163528 10226300 2957312 31347140 1de51c4 ./vmlinux before
>18163608 10227348 2957312 31348268 1de562c ./vmlinux after (+1128)
>
>And functions such as intel_pstate_adjust_policy_max(),
>kvm_cpu_accept_dm_intr(), kvm_register_read() are inlined.
>
>Cc: Thomas Gleixner <tglx@linutronix.de>
>Cc: Ingo Molnar <mingo@redhat.com>
>Cc: "H. Peter Anvin" <hpa@zytor.com>
>Cc: x86@kernel.org
>Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Cc: Kate Stewart <kstewart@linuxfoundation.org>
>Cc: Philippe Ombredanne <pombredanne@nexb.com>
>
>Signed-off-by: Nadav Amit <namit@vmware.com>
>---
> arch/x86/include/asm/jump_label.h | 65 ++++++++++++++++++-------------
> arch/x86/kernel/macros.S          |  1 +
> 2 files changed, 39 insertions(+), 27 deletions(-)
>
>diff --git a/arch/x86/include/asm/jump_label.h
>b/arch/x86/include/asm/jump_label.h
>index 8c0de4282659..ea0633a41122 100644
>--- a/arch/x86/include/asm/jump_label.h
>+++ b/arch/x86/include/asm/jump_label.h
>@@ -2,19 +2,6 @@
> #ifndef _ASM_X86_JUMP_LABEL_H
> #define _ASM_X86_JUMP_LABEL_H
> 
>-#ifndef HAVE_JUMP_LABEL
>-/*
>- * For better or for worse, if jump labels (the gcc extension) are
>missing,
>- * then the entire static branch patching infrastructure is compiled
>out.
>- * If that happens, the code in here will malfunction.  Raise a
>compiler
>- * error instead.
>- *
>- * In theory, jump labels and the static branch patching
>infrastructure
>- * could be decoupled to fix this.
>- */
>-#error asm/jump_label.h included on a non-jump-label kernel
>-#endif
>-
> #define JUMP_LABEL_NOP_SIZE 5
> 
> #ifdef CONFIG_X86_64
>@@ -28,18 +15,27 @@
> 
> #ifndef __ASSEMBLY__
> 
>+#ifndef HAVE_JUMP_LABEL
>+/*
>+ * For better or for worse, if jump labels (the gcc extension) are
>missing,
>+ * then the entire static branch patching infrastructure is compiled
>out.
>+ * If that happens, the code in here will malfunction.  Raise a
>compiler
>+ * error instead.
>+ *
>+ * In theory, jump labels and the static branch patching
>infrastructure
>+ * could be decoupled to fix this.
>+ */
>+#error asm/jump_label.h included on a non-jump-label kernel
>+#endif
>+
> #include <linux/stringify.h>
> #include <linux/types.h>
> 
>static __always_inline bool arch_static_branch(struct static_key *key,
>bool branch)
> {
>-	asm_volatile_goto("1:"
>-		".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"
>-		".pushsection __jump_table,  \"aw\" \n\t"
>-		_ASM_ALIGN "\n\t"
>-		_ASM_PTR "1b, %l[l_yes], %c0 + %c1 \n\t"
>-		".popsection \n\t"
>-		: :  "i" (key), "i" (branch) : : l_yes);
>+	asm_volatile_goto("STATIC_BRANCH_GOTO l_yes=\"%l[l_yes]\" key=\"%c0\"
>"
>+			  "branch=\"%c1\""
>+			: :  "i" (key), "i" (branch) : : l_yes);
> 
> 	return false;
> l_yes:
>@@ -48,13 +44,8 @@ static __always_inline bool
>arch_static_branch(struct static_key *key, bool bran
> 
>static __always_inline bool arch_static_branch_jump(struct static_key
>*key, bool branch)
> {
>-	asm_volatile_goto("1:"
>-		".byte 0xe9\n\t .long %l[l_yes] - 2f\n\t"
>-		"2:\n\t"
>-		".pushsection __jump_table,  \"aw\" \n\t"
>-		_ASM_ALIGN "\n\t"
>-		_ASM_PTR "1b, %l[l_yes], %c0 + %c1 \n\t"
>-		".popsection \n\t"
>+	asm_volatile_goto("STATIC_BRANCH_JUMP_GOTO l_yes=\"%l[l_yes]\"
>key=\"%c0\" "
>+			  "branch=\"%c1\""
> 		: :  "i" (key), "i" (branch) : : l_yes);
> 
> 	return false;
>@@ -108,6 +99,26 @@ struct jump_entry {
> 	.popsection
> .endm
> 
>+.macro STATIC_BRANCH_GOTO l_yes:req key:req branch:req
>+1:
>+	.byte STATIC_KEY_INIT_NOP
>+	.pushsection __jump_table, "aw"
>+	_ASM_ALIGN
>+	_ASM_PTR 1b, \l_yes, \key + \branch
>+	.popsection
>+.endm
>+
>+.macro STATIC_BRANCH_JUMP_GOTO l_yes:req key:req branch:req
>+1:
>+	.byte 0xe9
>+	.long \l_yes - 2f
>+2:
>+	.pushsection __jump_table, "aw"
>+	_ASM_ALIGN
>+	_ASM_PTR 1b, \l_yes, \key + \branch
>+	.popsection
>+.endm
>+
> #endif	/* __ASSEMBLY__ */
> 
> #endif
>diff --git a/arch/x86/kernel/macros.S b/arch/x86/kernel/macros.S
>index bf8b9c93e255..161c95059044 100644
>--- a/arch/x86/kernel/macros.S
>+++ b/arch/x86/kernel/macros.S
>@@ -13,3 +13,4 @@
> #include <asm/paravirt.h>
> #include <asm/asm.h>
> #include <asm/cpufeature.h>
>+#include <asm/jump_label.h>

If the code size increases, do you have any metrics for improvement?

That being said, I do like the readability improvements and the ability to use gas macros in assembly as opposed to cpp macros wrapped in different ways for C and assembly.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
