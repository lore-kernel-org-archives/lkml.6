Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967405AbeBNLRP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 06:17:15 -0500
Received: from mga18.intel.com ([134.134.136.126]:46030 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967374AbeBNLRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 06:17:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,512,1511856000";
   d="scan'208";a="29951844"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>, Borislav Petkov <bp@suse.de>,
        Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 4/9] x86: Introduce pgtable_l5_enabled
Date: Wed, 14 Feb 2018 14:16:51 +0300
Message-Id: <20180214111656.88514-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180214111656.88514-1-kirill.shutemov@linux.intel.com>
References: <20180214111656.88514-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new flag would indicate what paging mode we are in.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/boot/compressed/kaslr.c        | 4 ++++
 arch/x86/include/asm/pgtable_32_types.h | 2 ++
 arch/x86/include/asm/pgtable_64_types.h | 6 ++++++
 arch/x86/kernel/head64.c                | 5 +++++
 4 files changed, 17 insertions(+)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 8199a6187251..bd69e1830fbe 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -46,6 +46,10 @@
 #define STATIC
 #include <linux/decompress/mm.h>
 
+#ifdef CONFIG_X86_5LEVEL
+unsigned int pgtable_l5_enabled __ro_after_init = 1;
+#endif
+
 extern unsigned long get_cmd_line_ptr(void);
 
 /* Simplified build-specific string for starting entropy. */
diff --git a/arch/x86/include/asm/pgtable_32_types.h b/arch/x86/include/asm/pgtable_32_types.h
index 0777e18a1d23..e3225e83db7d 100644
--- a/arch/x86/include/asm/pgtable_32_types.h
+++ b/arch/x86/include/asm/pgtable_32_types.h
@@ -15,6 +15,8 @@
 # include <asm/pgtable-2level_types.h>
 #endif
 
+#define pgtable_l5_enabled 0
+
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE - 1))
 
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index a0db91ab63b8..5e2d724f8f47 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -20,6 +20,12 @@ typedef unsigned long	pgprotval_t;
 
 typedef struct { pteval_t pte; } pte_t;
 
+#ifdef CONFIG_X86_5LEVEL
+extern unsigned int pgtable_l5_enabled;
+#else
+#define pgtable_l5_enabled 0
+#endif
+
 #endif	/* !__ASSEMBLY__ */
 
 #define SHARED_KERNEL_PMD	0
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index bf5c9ba63ba1..17d00d1886de 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -39,6 +39,11 @@ extern pmd_t early_dynamic_pgts[EARLY_DYNAMIC_PAGE_TABLES][PTRS_PER_PMD];
 static unsigned int __initdata next_early_pgt;
 pmdval_t early_pmd_flags = __PAGE_KERNEL_LARGE & ~(_PAGE_GLOBAL | _PAGE_NX);
 
+#ifdef CONFIG_X86_5LEVEL
+unsigned int pgtable_l5_enabled __ro_after_init = 1;
+EXPORT_SYMBOL(pgtable_l5_enabled);
+#endif
+
 #ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
 unsigned long page_offset_base __ro_after_init = __PAGE_OFFSET_BASE;
 EXPORT_SYMBOL(page_offset_base);
-- 
2.15.1
