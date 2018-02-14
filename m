Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967853AbeBNNQR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:16:17 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49865 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967717AbeBNNQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:16:16 -0500
Date: Wed, 14 Feb 2018 05:05:52 -0800
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-e626e6bb0dfaca41487241d49ce0ae827716101a@git.kernel.org>
Cc: kirill.shutemov@linux.intel.com, luto@amacapital.net,
        peterz@infradead.org, torvalds@linux-foundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, bp@suse.de,
        tglx@linutronix.de
Reply-To: luto@amacapital.net, kirill.shutemov@linux.intel.com, hpa@zytor.com,
        torvalds@linux-foundation.org, peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@suse.de
In-Reply-To: <20180214111656.88514-5-kirill.shutemov@linux.intel.com>
References: <20180214111656.88514-5-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Introduce 'pgtable_l5_enabled'
Git-Commit-ID: e626e6bb0dfaca41487241d49ce0ae827716101a
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

Commit-ID:  e626e6bb0dfaca41487241d49ce0ae827716101a
Gitweb:     https://git.kernel.org/tip/e626e6bb0dfaca41487241d49ce0ae827716101a
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Wed, 14 Feb 2018 14:16:51 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 14 Feb 2018 13:11:14 +0100

x86/mm: Introduce 'pgtable_l5_enabled'

The new flag would indicate what paging mode we are in.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180214111656.88514-5-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/kaslr.c        | 4 ++++
 arch/x86/include/asm/pgtable_32_types.h | 2 ++
 arch/x86/include/asm/pgtable_64_types.h | 6 ++++++
 arch/x86/kernel/head64.c                | 5 +++++
 4 files changed, 17 insertions(+)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 8199a61..bd69e18 100644
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
index 0777e18..e3225e8 100644
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
index a0db91a..5e2d724 100644
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
index bf5c9ba..17d00d1 100644
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
