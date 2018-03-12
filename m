Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752592AbeCLKDc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 06:03:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:16063 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751881AbeCLKC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 06:02:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,460,1515484800";
   d="scan'208";a="23561803"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>, Borislav Petkov <bp@suse.de>,
        Andi Kleen <ak@linux.intel.com>, Matthew Wilcox <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 2/4] x86/boot/compressed/64: Use stack from trampoline memory
Date: Mon, 12 Mar 2018 13:02:44 +0300
Message-Id: <20180312100246.89175-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180312100246.89175-1-kirill.shutemov@linux.intel.com>
References: <20180312100246.89175-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the first step on using trampoline memory, let's make 32-bit code use
stack there.

Separate stack is required to return back from trampoline and we cannot
user stack from 64-bit mode as it may be above 4G.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/boot/compressed/head_64.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index f0c3a2f7e528..0014459d9bcb 100644
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
 
+	/* Setup new stack */
+	leal	TRAMPOLINE_32BIT_STACK_END(%ecx), %esp
+
 	/* Disable paging */
 	movl	%cr0, %eax
 	btrl	$X86_CR0_PG_BIT, %eax
-- 
2.16.1
