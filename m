Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E92816070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752149AbeFFLoM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 07:44:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41005 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751729AbeFFLoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 07:44:11 -0400
Date: Wed, 6 Jun 2018 04:43:00 -0700
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-94d49eb30e854c84d1319095b5dd0405a7da9362@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mingo@kernel.org,
        thomas.lendacky@amd.com
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
          kirill.shutemov@linux.intel.com, mingo@kernel.org,
          thomas.lendacky@amd.com
In-Reply-To: <20180518113028.79825-1-kirill.shutemov@linux.intel.com>
References: <20180518113028.79825-1-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm: Decouple dynamic __PHYSICAL_MASK from AMD
 SME
Git-Commit-ID: 94d49eb30e854c84d1319095b5dd0405a7da9362
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

Commit-ID:  94d49eb30e854c84d1319095b5dd0405a7da9362
Gitweb:     https://git.kernel.org/tip/94d49eb30e854c84d1319095b5dd0405a7da9362
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Fri, 18 May 2018 14:30:28 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 6 Jun 2018 13:38:01 +0200

x86/mm: Decouple dynamic __PHYSICAL_MASK from AMD SME

AMD SME claims one bit from physical address to indicate whether the
page is encrypted or not. To achieve that we clear out the bit from
__PHYSICAL_MASK.

The capability to adjust __PHYSICAL_MASK is required beyond AMD SME.
For instance for upcoming Intel Multi-Key Total Memory Encryption.

Factor it out into a separate feature with own Kconfig handle.

It also helps with overhead of AMD SME. It saves more than 3k in .text
on defconfig + AMD_MEM_ENCRYPT:

	add/remove: 3/2 grow/shrink: 5/110 up/down: 189/-3753 (-3564)

We would need to return to this once we have infrastructure to patch
constants in code. That's good candidate for it.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-mm@kvack.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/20180518113028.79825-1-kirill.shutemov@linux.intel.com

---
 arch/x86/Kconfig                    | 4 ++++
 arch/x86/boot/compressed/kaslr_64.c | 5 +++++
 arch/x86/include/asm/page_types.h   | 8 +++++++-
 arch/x86/mm/mem_encrypt_identity.c  | 3 +++
 arch/x86/mm/pgtable.c               | 5 +++++
 5 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c07f492b871a..43a8fc476296 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -337,6 +337,9 @@ config ARCH_SUPPORTS_UPROBES
 config FIX_EARLYCON_MEM
 	def_bool y
 
+config DYNAMIC_PHYSICAL_MASK
+	bool
+
 config PGTABLE_LEVELS
 	int
 	default 5 if X86_5LEVEL
@@ -1508,6 +1511,7 @@ config ARCH_HAS_MEM_ENCRYPT
 config AMD_MEM_ENCRYPT
 	bool "AMD Secure Memory Encryption (SME) support"
 	depends on X86_64 && CPU_SUP_AMD
+	select DYNAMIC_PHYSICAL_MASK
 	---help---
 	  Say yes to enable support for the encryption of system memory.
 	  This requires an AMD processor that supports Secure Memory
diff --git a/arch/x86/boot/compressed/kaslr_64.c b/arch/x86/boot/compressed/kaslr_64.c
index 522d11431433..748456c365f4 100644
--- a/arch/x86/boot/compressed/kaslr_64.c
+++ b/arch/x86/boot/compressed/kaslr_64.c
@@ -69,6 +69,8 @@ static struct alloc_pgt_data pgt_data;
 /* The top level page table entry pointer. */
 static unsigned long top_level_pgt;
 
+phys_addr_t physical_mask = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
+
 /*
  * Mapping information structure passed to kernel_ident_mapping_init().
  * Due to relocation, pointers must be assigned at run time not build time.
@@ -81,6 +83,9 @@ void initialize_identity_maps(void)
 	/* If running as an SEV guest, the encryption mask is required. */
 	set_sev_encryption_mask();
 
+	/* Exclude the encryption mask from __PHYSICAL_MASK */
+	physical_mask &= ~sme_me_mask;
+
 	/* Init mapping_info with run-time function/buffer pointers. */
 	mapping_info.alloc_pgt_page = alloc_pgt_page;
 	mapping_info.context = &pgt_data;
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
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 1b2197d13832..7ae36868aed2 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -527,6 +527,7 @@ void __init sme_enable(struct boot_params *bp)
 		/* SEV state cannot be controlled by a command line option */
 		sme_me_mask = me_mask;
 		sev_enabled = true;
+		physical_mask &= ~sme_me_mask;
 		return;
 	}
 
@@ -561,4 +562,6 @@ void __init sme_enable(struct boot_params *bp)
 		sme_me_mask = 0;
 	else
 		sme_me_mask = active_by_default ? me_mask : 0;
+
+	physical_mask &= ~sme_me_mask;
 }
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index ffc8c13c50e4..3ca59cf7a7f9 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -8,6 +8,11 @@
 #include <asm/fixmap.h>
 #include <asm/mtrr.h>
 
+#ifdef CONFIG_DYNAMIC_PHYSICAL_MASK
+phys_addr_t physical_mask __ro_after_init = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
+EXPORT_SYMBOL(physical_mask);
+#endif
+
 #define PGALLOC_GFP (GFP_KERNEL_ACCOUNT | __GFP_ZERO)
 
 #ifdef CONFIG_HIGHPTE
