Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966788AbeEJRi0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 13:38:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:61125 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966673AbeEJRiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 13:38:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,386,1520924400";
   d="scan'208";a="57578846"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 2/2] x86/boot/compressed/64: Fix moving page table out of trampoline memory
Date: Thu, 10 May 2018 20:38:06 +0300
Message-Id: <20180510173806.4332-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180510173806.4332-1-kirill.shutemov@linux.intel.com>
References: <20180510173806.4332-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

top_pgtable address has to be calculated relative to where the kernel
image will be relocated for decompression, not relative to position of
kernel is running at the moment. We do the same for the rest of page
table we use the stage. It makes them safe from being overwritten during
decompression.

Calculate the address of top_pgtable in assembly and pass down to
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
index 6cbb2d64c91e..1acf7b5d16cf 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -385,10 +385,14 @@ trampoline_return:
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
 
@@ -689,3 +693,10 @@ boot_stack_end:
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
