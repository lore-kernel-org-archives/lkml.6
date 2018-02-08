Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbeBHMzg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 07:55:36 -0500
Received: from mga07.intel.com ([134.134.136.100]:2801 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752028AbeBHMzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 07:55:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,478,1511856000";
   d="scan'208";a="16279867"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] x86/mm: Decouple dynamic __PHYSICAL_MASK from AMD SME
Date: Thu,  8 Feb 2018 15:55:24 +0300
Message-Id: <20180208125524.88795-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD SME claims one bit from physical address to indicate whether the
page is encrypted or not. To achieve that we clear out the bit from
__PHYSICAL_MASK.

The capability to adjust __PHYSICAL_MASK is required beyond AMD SME.
For instance for upcoming Intel Multi-Key Total Memory Encryption.

Let's factor it out into separate feature with own Kconfig handle.

It also helps with overhead of AMD SME. It saves more than 3k in .text
on defconfig + AMD_MEM_ENCRYPT:

	add/remove: 3/2 grow/shrink: 5/110 up/down: 189/-3753 (-3564)

We would need to return to this once we have infrastructure to patch
constants in code. That's good candidate for it.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/Kconfig                     | 4 ++++
 arch/x86/boot/compressed/pagetable.c | 3 +++
 arch/x86/include/asm/page_types.h    | 8 +++++++-
 arch/x86/mm/mem_encrypt.c            | 3 +++
 arch/x86/mm/pgtable.c                | 5 +++++
 5 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b52cdf48ad26..ffd9ef3f6ca6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -332,6 +332,9 @@ config ARCH_SUPPORTS_UPROBES
 config FIX_EARLYCON_MEM
 	def_bool y
 
+config DYNAMIC_PHYSICAL_MASK
+	bool
+
 config PGTABLE_LEVELS
 	int
 	default 5 if X86_5LEVEL
@@ -1469,6 +1472,7 @@ config ARCH_HAS_MEM_ENCRYPT
 config AMD_MEM_ENCRYPT
 	bool "AMD Secure Memory Encryption (SME) support"
 	depends on X86_64 && CPU_SUP_AMD
+	select DYNAMIC_PHYSICAL_MASK
 	---help---
 	  Say yes to enable support for the encryption of system memory.
 	  This requires an AMD processor that supports Secure Memory
diff --git a/arch/x86/boot/compressed/pagetable.c b/arch/x86/boot/compressed/pagetable.c
index b5e5e02f8cde..4318ac0af815 100644
--- a/arch/x86/boot/compressed/pagetable.c
+++ b/arch/x86/boot/compressed/pagetable.c
@@ -16,6 +16,9 @@
 #define __pa(x)  ((unsigned long)(x))
 #define __va(x)  ((void *)((unsigned long)(x)))
 
+/* No need in adjustable __PHYSICAL_MASK during decompresssion phase */
+#undef CONFIG_DYNAMIC_PHYSICAL_MASK
+
 /*
  * The pgtable.h and mm/ident_map.c includes make use of the SME related
  * information which is not used in the compressed image support. Un-define
diff --git a/arch/x86/include/asm/page_types.h b/arch/x86/include/asm/page_types.h
index 1e53560a84bb..c85e15010f48 100644
--- a/arch/x86/include/asm/page_types.h
+++ b/arch/x86/include/asm/page_types.h
@@ -17,7 +17,6 @@
 #define PUD_PAGE_SIZE		(_AC(1, UL) << PUD_SHIFT)
 #define PUD_PAGE_MASK		(~(PUD_PAGE_SIZE-1))
 
-#define __PHYSICAL_MASK		((phys_addr_t)(__sme_clr((1ULL << __PHYSICAL_MASK_SHIFT) - 1)))
 #define __VIRTUAL_MASK		((1UL << __VIRTUAL_MASK_SHIFT) - 1)
 
 /* Cast *PAGE_MASK to a signed type so that it is sign-extended if
@@ -55,6 +54,13 @@
 
 #ifndef __ASSEMBLY__
 
+#ifdef CONFIG_DYNAMIC_PHYSICAL_MASK
+extern phys_addr_t physical_mask;
+#define __PHYSICAL_MASK		physical_mask
+#else
+#define __PHYSICAL_MASK		((phys_addr_t)((1ULL << __PHYSICAL_MASK_SHIFT) - 1))
+#endif
+
 extern int devmem_is_allowed(unsigned long pagenr);
 
 extern unsigned long max_low_pfn_mapped;
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 1a53071e2e17..18954f97f3da 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -999,6 +999,7 @@ void __init __nostackprotector sme_enable(struct boot_params *bp)
 		/* SEV state cannot be controlled by a command line option */
 		sme_me_mask = me_mask;
 		sev_enabled = true;
+		physical_mask &= ~sme_me_mask;
 		return;
 	}
 
@@ -1033,4 +1034,6 @@ void __init __nostackprotector sme_enable(struct boot_params *bp)
 		sme_me_mask = 0;
 	else
 		sme_me_mask = active_by_default ? me_mask : 0;
+
+	physical_mask &= ~sme_me_mask;
 }
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 004abf9ebf12..a4dfe85f2fd8 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -7,6 +7,11 @@
 #include <asm/fixmap.h>
 #include <asm/mtrr.h>
 
+#ifdef CONFIG_DYNAMIC_PHYSICAL_MASK
+phys_addr_t physical_mask __ro_after_init = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
+EXPORT_SYMBOL(physical_mask);
+#endif
+
 #define PGALLOC_GFP (GFP_KERNEL_ACCOUNT | __GFP_ZERO)
 
 #ifdef CONFIG_HIGHPTE
-- 
2.15.1
