Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752518AbeEPICg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 04:02:36 -0400
Received: from mga07.intel.com ([134.134.136.100]:29720 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752573AbeEPIBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 04:01:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="39721054"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 2/2] x86/boot/compressed/64: Fix moving page table out of trampoline memory
Date: Wed, 16 May 2018 11:01:29 +0300
Message-Id: <20180516080131.27913-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516080131.27913-1-kirill.shutemov@linux.intel.com>
References: <20180516080131.27913-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Fixes: e9d0e6330eb8 ("x86/boot/compressed/64: Prepare new top-level page table for trampoline")
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
@@ -134,7 +126,7 @@ struct paging_config paging_prepare(void)
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
-- 
2.17.0
