Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932102AbeCLMUB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 08:20:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39919 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbeCLMT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 08:19:59 -0400
Date: Mon, 12 Mar 2018 05:19:14 -0700
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-f7ff53e4702be9ac49deacd518dd243de45c9980@git.kernel.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org,
        tglx@linutronix.de, peterz@infradead.org, bp@suse.de,
        gorcunov@openvz.org, jpoimboe@redhat.com, dvlasenk@redhat.com,
        bp@alien8.de, brgerst@gmail.com, hpa@zytor.com, luto@amacapital.net,
        willy@infradead.org, torvalds@linux-foundation.org,
        kirill.shutemov@linux.intel.com
Reply-To: bp@alien8.de, hpa@zytor.com, brgerst@gmail.com, dvlasenk@redhat.com,
        jpoimboe@redhat.com, kirill.shutemov@linux.intel.com,
        luto@amacapital.net, torvalds@linux-foundation.org,
        willy@infradead.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        mingo@kernel.org, luto@kernel.org, bp@suse.de, gorcunov@openvz.org,
        peterz@infradead.org
In-Reply-To: <20180312100246.89175-3-kirill.shutemov@linux.intel.com>
References: <20180312100246.89175-3-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/boot/compressed/64: Use stack from trampoline
 memory
Git-Commit-ID: f7ff53e4702be9ac49deacd518dd243de45c9980
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f7ff53e4702be9ac49deacd518dd243de45c9980
Gitweb:     https://git.kernel.org/tip/f7ff53e4702be9ac49deacd518dd243de45c9980
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Mon, 12 Mar 2018 13:02:44 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Mar 2018 11:49:24 +0100

x86/boot/compressed/64: Use stack from trampoline memory

As the first step on using trampoline memory, let's make 32-bit code use
stack there.

Separate stack is required to return back from trampoline and we cannot
user stack from 64-bit mode as it may be above 4G.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Borislav Petkov <bp@suse.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180312100246.89175-3-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/head_64.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index f0c3a2f7e528..12915511be61 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -33,6 +33,7 @@
 #include <asm/processor-flags.h>
 #include <asm/asm-offsets.h>
 #include <asm/bootparam.h>
+#include "pgtable.h"
 
 /*
  * Locally defined symbols should be marked hidden:
@@ -359,6 +360,8 @@ ENTRY(startup_64)
 	pushq	%rax
 	lretq
 lvl5:
+	/* Restore the stack, the 32-bit trampoline uses its own stack */
+	leaq	boot_stack_end(%rbx), %rsp
 
 	/*
 	 * cleanup_trampoline() would restore trampoline memory.
@@ -513,6 +516,9 @@ compatible_mode:
 	movl	%eax, %ds
 	movl	%eax, %ss
 
+	/* Set up new stack */
+	leal	TRAMPOLINE_32BIT_STACK_END(%ecx), %esp
+
 	/* Disable paging */
 	movl	%cr0, %eax
 	btrl	$X86_CR0_PG_BIT, %eax
