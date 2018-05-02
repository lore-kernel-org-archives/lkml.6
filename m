Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751889AbeEBQI2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 12:08:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:22478 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751525AbeEBQI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 12:08:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,354,1520924400";
   d="scan'208";a="38728085"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] x86/boot/compressed: Exclude 'top_pgtable' from relocation
Date: Wed,  2 May 2018 19:08:16 +0300
Message-Id: <20180502160816.35986-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

startup_64() copies kernel (including .data section) to the new place.
It's required for safe in-place decompression.

This is a problem if the original place is referenced: by mistake I've
put 'top_pgtable' into .data section and the address is loaded into CR3.
If the original place gets overwritten during image decompression the
kernel will crash and the machine will be rebooted.

Move 'top_pgtable' into .pgtable section where the rest of page tables
are. This section is not subject for relocation.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: e9d0e6330eb8 ("x86/boot/compressed/64: Prepare new top-level page table for trampoline")
---
 arch/x86/boot/compressed/head_64.S    | 8 ++++++++
 arch/x86/boot/compressed/pgtable_64.c | 4 +---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index fca012baba19..c433c21703e6 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -649,3 +649,11 @@ boot_stack_end:
 	.balign 4096
 pgtable:
 	.fill BOOT_PGT_SIZE, 1, 0
+
+/*
+ * The page table is going to be used instead of page table in the trampoline
+ * memory.
+ */
+	.global top_pgtable
+top_pgtable:
+	.fill PAGE_SIZE, 1, 0
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 32af1cbcd903..3a0578f54550 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -25,10 +25,8 @@ static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
 /*
  * The page table is going to be used instead of page table in the trampoline
  * memory.
- *
- * It must not be in BSS as BSS is cleared after cleanup_trampoline().
  */
-static char top_pgtable[PAGE_SIZE] __aligned(PAGE_SIZE) __section(.data);
+extern char *top_pgtable;
 
 /*
  * Trampoline address will be printed by extract_kernel() for debugging
-- 
2.17.0
