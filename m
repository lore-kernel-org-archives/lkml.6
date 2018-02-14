Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967867AbeBNNQU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:16:20 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55415 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967846AbeBNNQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:16:17 -0500
Date: Wed, 14 Feb 2018 05:04:51 -0800
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-02390b87a9459937cdb299e6b34ff33992512ec7@git.kernel.org>
Cc: hpa@zytor.com, tglx@linutronix.de, sergey.senozhatsky.work@gmail.com,
        bp@suse.de, linux-kernel@vger.kernel.org, minchan@kernel.org,
        mingo@kernel.org, kirill.shutemov@linux.intel.com,
        torvalds@linux-foundation.org, ngupta@vflare.org, luto@amacapital.net,
        peterz@infradead.org
Reply-To: ngupta@vflare.org, luto@amacapital.net,
        torvalds@linux-foundation.org, kirill.shutemov@linux.intel.com,
        mingo@kernel.org, peterz@infradead.org,
        sergey.senozhatsky.work@gmail.com, tglx@linutronix.de, hpa@zytor.com,
        minchan@kernel.org, bp@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20180214111656.88514-3-kirill.shutemov@linux.intel.com>
References: <20180214111656.88514-3-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] mm/zsmalloc: Prepare to variable MAX_PHYSMEM_BITS
Git-Commit-ID: 02390b87a9459937cdb299e6b34ff33992512ec7
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

Commit-ID:  02390b87a9459937cdb299e6b34ff33992512ec7
Gitweb:     https://git.kernel.org/tip/02390b87a9459937cdb299e6b34ff33992512ec7
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Wed, 14 Feb 2018 14:16:49 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 14 Feb 2018 13:11:13 +0100

mm/zsmalloc: Prepare to variable MAX_PHYSMEM_BITS

With boot-time switching between paging mode we will have variable
MAX_PHYSMEM_BITS.

Let's use the maximum variable possible for CONFIG_X86_5LEVEL=y
configuration to define zsmalloc data structures.

The patch introduces MAX_POSSIBLE_PHYSMEM_BITS to cover such case.
It also suits well to handle PAE special case.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Nitin Gupta <ngupta@vflare.org>
Acked-by: Minchan Kim <minchan@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180214111656.88514-3-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/pgtable-3level_types.h |  1 +
 arch/x86/include/asm/pgtable_64_types.h     |  2 ++
 mm/zsmalloc.c                               | 13 +++++++------
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/pgtable-3level_types.h b/arch/x86/include/asm/pgtable-3level_types.h
index 876b4c7..6a59a6d 100644
--- a/arch/x86/include/asm/pgtable-3level_types.h
+++ b/arch/x86/include/asm/pgtable-3level_types.h
@@ -44,5 +44,6 @@ typedef union {
  */
 #define PTRS_PER_PTE	512
 
+#define MAX_POSSIBLE_PHYSMEM_BITS	36
 
 #endif /* _ASM_X86_PGTABLE_3LEVEL_DEFS_H */
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 6b8f73d..7168de7 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -40,6 +40,8 @@ typedef struct { pteval_t pte; } pte_t;
 #define P4D_SIZE	(_AC(1, UL) << P4D_SHIFT)
 #define P4D_MASK	(~(P4D_SIZE - 1))
 
+#define MAX_POSSIBLE_PHYSMEM_BITS	52
+
 #else /* CONFIG_X86_5LEVEL */
 
 /*
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index c301350..b7f61cd 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -84,18 +84,19 @@
  * This is made more complicated by various memory models and PAE.
  */
 
-#ifndef MAX_PHYSMEM_BITS
-#ifdef CONFIG_HIGHMEM64G
-#define MAX_PHYSMEM_BITS 36
-#else /* !CONFIG_HIGHMEM64G */
+#ifndef MAX_POSSIBLE_PHYSMEM_BITS
+#ifdef MAX_PHYSMEM_BITS
+#define MAX_POSSIBLE_PHYSMEM_BITS MAX_PHYSMEM_BITS
+#else
 /*
  * If this definition of MAX_PHYSMEM_BITS is used, OBJ_INDEX_BITS will just
  * be PAGE_SHIFT
  */
-#define MAX_PHYSMEM_BITS BITS_PER_LONG
+#define MAX_POSSIBLE_PHYSMEM_BITS BITS_PER_LONG
 #endif
 #endif
-#define _PFN_BITS		(MAX_PHYSMEM_BITS - PAGE_SHIFT)
+
+#define _PFN_BITS		(MAX_POSSIBLE_PHYSMEM_BITS - PAGE_SHIFT)
 
 /*
  * Memory for allocating for handle keeps object position by
