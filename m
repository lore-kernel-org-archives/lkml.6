Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030281AbeBNNRu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:17:50 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46869 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030268AbeBNNRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:17:48 -0500
Date: Wed, 14 Feb 2018 05:07:24 -0800
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-162434e7f58b21f0b6c9cc5fb02222cd7d9064cc@git.kernel.org>
Cc: peterz@infradead.org, torvalds@linux-foundation.org,
        kirill.shutemov@linux.intel.com, hpa@zytor.com, tglx@linutronix.de,
        luto@amacapital.net, linux-kernel@vger.kernel.org, mingo@kernel.org,
        bp@suse.de
Reply-To: luto@amacapital.net, linux-kernel@vger.kernel.org, bp@suse.de,
        mingo@kernel.org, tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        hpa@zytor.com, torvalds@linux-foundation.org, peterz@infradead.org
In-Reply-To: <20180214111656.88514-8-kirill.shutemov@linux.intel.com>
References: <20180214111656.88514-8-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Make MAX_PHYSADDR_BITS and MAX_PHYSMEM_BITS
 dynamic
Git-Commit-ID: 162434e7f58b21f0b6c9cc5fb02222cd7d9064cc
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

Commit-ID:  162434e7f58b21f0b6c9cc5fb02222cd7d9064cc
Gitweb:     https://git.kernel.org/tip/162434e7f58b21f0b6c9cc5fb02222cd7d9064cc
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Wed, 14 Feb 2018 14:16:54 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 14 Feb 2018 13:11:15 +0100

x86/mm: Make MAX_PHYSADDR_BITS and MAX_PHYSMEM_BITS dynamic

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

Effect on kernel image size:

   text	   data	    bss	    dec	    hex	filename
8628393	4734340	1368064	14730797	 e0c62d	vmlinux.before
8628892	4734340	1368064	14731296	 e0c820	vmlinux.after

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180214111656.88514-8-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/Kconfig                        | 1 +
 arch/x86/include/asm/pgtable_64_types.h | 2 +-
 arch/x86/include/asm/sparsemem.h        | 9 ++-------
 arch/x86/kernel/setup.c                 | 5 ++---
 4 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9225648..fcc3f88 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1431,6 +1431,7 @@ config X86_PAE
 config X86_5LEVEL
 	bool "Enable 5-level page tables support"
 	select DYNAMIC_MEMORY_LAYOUT
+	select SPARSEMEM_VMEMMAP
 	depends on X86_64
 	---help---
 	  5-level paging enables access to larger address space:
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 0c48d80..59d971c 100644
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
index 4fc1e9d..4617a2b 100644
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
index 1ae67e9..399d0f7 100644
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
