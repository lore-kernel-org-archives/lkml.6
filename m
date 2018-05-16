Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752482AbeEPKhn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:37:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37101 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbeEPKhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:37:41 -0400
Date: Wed, 16 May 2018 03:36:22 -0700
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-589bb62be316401603453c7d2d3c60ad8b9c3cf3@git.kernel.org>
Cc: peterz@infradead.org, hpa@zytor.com, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, hughd@google.com, mingo@kernel.org,
        torvalds@linux-foundation.org, tglx@linutronix.de
Reply-To: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com, hpa@zytor.com, hughd@google.com
In-Reply-To: <20180516080131.27913-3-kirill.shutemov@linux.intel.com>
References: <20180516080131.27913-3-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/boot/compressed/64: Fix moving page table out
 of trampoline memory
Git-Commit-ID: 589bb62be316401603453c7d2d3c60ad8b9c3cf3
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

Commit-ID:  589bb62be316401603453c7d2d3c60ad8b9c3cf3
Gitweb:     https://git.kernel.org/tip/589bb62be316401603453c7d2d3c60ad8b9c3cf3
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Wed, 16 May 2018 11:01:29 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 16 May 2018 12:15:13 +0200

x86/boot/compressed/64: Fix moving page table out of trampoline memory

cleanup_trampoline() relocates the top-level page table out of
trampoline memory. We use 'top_pgtable' as our new top-level page table.

But if the 'top_pgtable' would be referenced from C in a usual way,
the address of the table will be calculated relative to RIP.
After kernel gets relocated, the address will be in the middle of
decompression buffer and the page table may get overwritten.
This leads to a crash.

We calculate the address of other page tables relative to the relocation
address. It makes them safe. We should do the same for 'top_pgtable'.

Calculate the address of 'top_pgtable' in assembly and pass down to
cleanup_trampoline().

Move the page table to .pgtable section where the rest of page tables
are. The section is @nobits so we save 4k in kernel image.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Hugh Dickins <hughd@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: e9d0e6330eb8 ("x86/boot/compressed/64: Prepare new top-level page table for trampoline")
Link: http://lkml.kernel.org/r/20180516080131.27913-3-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/head_64.S    | 11 +++++++++++
 arch/x86/boot/compressed/pgtable_64.c | 14 +++-----------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index d17af6a4bfc9..8169e8b7a4dc 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -389,10 +389,14 @@ trampoline_return:
 	/*
 	 * cleanup_trampoline() would restore trampoline memory.
 	 *
+	 * RDI is address of the page table to use instead of page table
+	 * in trampoline memory (if required).
+	 *
 	 * RSI holds real mode data and needs to be preserved across
 	 * this function call.
 	 */
 	pushq	%rsi
+	leaq	top_pgtable(%rbx), %rdi
 	call	cleanup_trampoline
 	popq	%rsi
 
@@ -691,3 +695,10 @@ boot_stack_end:
 	.balign 4096
 pgtable:
 	.fill BOOT_PGT_SIZE, 1, 0
+
+/*
+ * The page table is going to be used instead of page table in the trampoline
+ * memory.
+ */
+top_pgtable:
+	.fill PAGE_SIZE, 1, 0
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 32af1cbcd903..a362fa0b849c 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -22,14 +22,6 @@ struct paging_config {
 /* Buffer to preserve trampoline memory */
 static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
 
-/*
- * The page table is going to be used instead of page table in the trampoline
- * memory.
- *
- * It must not be in BSS as BSS is cleared after cleanup_trampoline().
- */
-static char top_pgtable[PAGE_SIZE] __aligned(PAGE_SIZE) __section(.data);
-
 /*
  * Trampoline address will be printed by extract_kernel() for debugging
  * purposes.
@@ -134,7 +126,7 @@ out:
 	return paging_config;
 }
 
-void cleanup_trampoline(void)
+void cleanup_trampoline(void *pgtable)
 {
 	void *trampoline_pgtable;
 
@@ -145,8 +137,8 @@ void cleanup_trampoline(void)
 	 * if it's there.
 	 */
 	if ((void *)__native_read_cr3() == trampoline_pgtable) {
-		memcpy(top_pgtable, trampoline_pgtable, PAGE_SIZE);
-		native_write_cr3((unsigned long)top_pgtable);
+		memcpy(pgtable, trampoline_pgtable, PAGE_SIZE);
+		native_write_cr3((unsigned long)pgtable);
 	}
 
 	/* Restore trampoline memory */
