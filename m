Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967445AbeBNLRh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 06:17:37 -0500
Received: from mga02.intel.com ([134.134.136.20]:5270 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967414AbeBNLRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 06:17:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,512,1511856000";
   d="scan'208";a="34604565"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>, Borislav Petkov <bp@suse.de>,
        Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 7/9] x86/mm: Make MAX_PHYSADDR_BITS and MAX_PHYSMEM_BITS dynamic
Date: Wed, 14 Feb 2018 14:16:54 +0300
Message-Id: <20180214111656.88514-8-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180214111656.88514-1-kirill.shutemov@linux.intel.com>
References: <20180214111656.88514-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For boot-time switching between paging modes, we need to be able to
adjust size of physical address space at runtime.

As part of making physical address space size variable, we have to make
X86_5LEVEL dependent on SPARSEMEM_VMEMMAP. !SPARSEMEM_VMEMMAP
configuration doesn't build with variable MAX_PHYSMEM_BITS.

For !SPARSEMEM_VMEMMAP SECTIONS_WIDTH depends on MAX_PHYSMEM_BITS:

SECTIONS_WIDTH
  SECTIONS_SHIFT
    MAX_PHYSMEM_BITS

And SECTIONS_WIDTH is used on pre-processor stage, it doesn't work if it's
dyncamic. See include/linux/page-flags-layout.h.

Affect on kernel image size:

   text	   data	    bss	    dec	    hex	filename
8628393	4734340	1368064	14730797	 e0c62d	vmlinux.before
8628892	4734340	1368064	14731296	 e0c820	vmlinux.after

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/Kconfig                        | 1 +
 arch/x86/include/asm/pgtable_64_types.h | 2 +-
 arch/x86/include/asm/sparsemem.h        | 9 ++-------
 arch/x86/kernel/setup.c                 | 5 ++---
 4 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f925274ddf79..0d780a3ee924 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1472,6 +1472,7 @@ config X86_PAE
 config X86_5LEVEL
 	bool "Enable 5-level page tables support"
 	select DYNAMIC_MEMORY_LAYOUT
+	select SPARSEMEM_VMEMMAP
 	depends on X86_64
 	---help---
 	  5-level paging enables access to larger address space:
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 0c48d80e11d4..59d971c85de5 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -95,7 +95,7 @@ extern unsigned int ptrs_per_p4d;
  * range must not overlap with anything except the KASAN shadow area, which
  * is correct as KASAN disables KASLR.
  */
-#define MAXMEM			_AC(__AC(1, UL) << MAX_PHYSMEM_BITS, UL)
+#define MAXMEM			(1UL << MAX_PHYSMEM_BITS)
 
 #define LDT_PGD_ENTRY_L4	-3UL
 #define LDT_PGD_ENTRY_L5	-112UL
diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
index 4fc1e9d3c43e..4617a2bf123c 100644
--- a/arch/x86/include/asm/sparsemem.h
+++ b/arch/x86/include/asm/sparsemem.h
@@ -27,13 +27,8 @@
 # endif
 #else /* CONFIG_X86_32 */
 # define SECTION_SIZE_BITS	27 /* matt - 128 is convenient right now */
-# ifdef CONFIG_X86_5LEVEL
-#  define MAX_PHYSADDR_BITS	52
-#  define MAX_PHYSMEM_BITS	52
-# else
-#  define MAX_PHYSADDR_BITS	44
-#  define MAX_PHYSMEM_BITS	46
-# endif
+# define MAX_PHYSADDR_BITS	(pgtable_l5_enabled ? 52 : 44)
+# define MAX_PHYSMEM_BITS	(pgtable_l5_enabled ? 52 : 46)
 #endif
 
 #endif /* CONFIG_SPARSEMEM */
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 1ae67e982af7..399d0f7fa8f1 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -189,9 +189,7 @@ struct ist_info ist_info;
 #endif
 
 #else
-struct cpuinfo_x86 boot_cpu_data __read_mostly = {
-	.x86_phys_bits = MAX_PHYSMEM_BITS,
-};
+struct cpuinfo_x86 boot_cpu_data __read_mostly;
 EXPORT_SYMBOL(boot_cpu_data);
 #endif
 
@@ -851,6 +849,7 @@ void __init setup_arch(char **cmdline_p)
 	__flush_tlb_all();
 #else
 	printk(KERN_INFO "Command line: %s\n", boot_command_line);
+	boot_cpu_data.x86_phys_bits = MAX_PHYSMEM_BITS;
 #endif
 
 	/*
-- 
2.15.1
