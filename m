Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967481AbeBNLSU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 06:18:20 -0500
Received: from mga18.intel.com ([134.134.136.126]:46030 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967374AbeBNLRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 06:17:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,512,1511856000";
   d="scan'208";a="17619924"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>, Borislav Petkov <bp@suse.de>,
        Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 5/9] x86/mm: Make LDT_BASE_ADDR dynamic
Date: Wed, 14 Feb 2018 14:16:52 +0300
Message-Id: <20180214111656.88514-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180214111656.88514-1-kirill.shutemov@linux.intel.com>
References: <20180214111656.88514-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LDT_BASE_ADDR has different value in 4- and 5-level paging
configurations.

We need to make it dynamic in preparation for boot-time switching
between paging modes.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/pgtable_64_types.h | 9 +++++----
 arch/x86/mm/dump_pagetables.c           | 5 ++++-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 5e2d724f8f47..903e4d054bcb 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -92,18 +92,19 @@ extern unsigned int pgtable_l5_enabled;
  */
 #define MAXMEM			_AC(__AC(1, UL) << MAX_PHYSMEM_BITS, UL)
 
+#define LDT_PGD_ENTRY_L4	-3UL
+#define LDT_PGD_ENTRY_L5	-112UL
+#define LDT_PGD_ENTRY		(pgtable_l5_enabled ? LDT_PGD_ENTRY_L5 : LDT_PGD_ENTRY_L4)
+#define LDT_BASE_ADDR		(LDT_PGD_ENTRY << PGDIR_SHIFT)
+
 #ifdef CONFIG_X86_5LEVEL
 # define VMALLOC_SIZE_TB	_AC(12800, UL)
 # define __VMALLOC_BASE		_AC(0xffa0000000000000, UL)
 # define __VMEMMAP_BASE		_AC(0xffd4000000000000, UL)
-# define LDT_PGD_ENTRY		_AC(-112, UL)
-# define LDT_BASE_ADDR		(LDT_PGD_ENTRY << PGDIR_SHIFT)
 #else
 # define VMALLOC_SIZE_TB	_AC(32, UL)
 # define __VMALLOC_BASE		_AC(0xffffc90000000000, UL)
 # define __VMEMMAP_BASE		_AC(0xffffea0000000000, UL)
-# define LDT_PGD_ENTRY		_AC(-3, UL)
-# define LDT_BASE_ADDR		(LDT_PGD_ENTRY << PGDIR_SHIFT)
 #endif
 
 #ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index 2a4849e92831..a89f2dbc3531 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -89,7 +89,7 @@ static struct addr_marker address_markers[] = {
 	[KASAN_SHADOW_END_NR]	= { KASAN_SHADOW_END,	"KASAN shadow end" },
 #endif
 #ifdef CONFIG_MODIFY_LDT_SYSCALL
-	[LDT_NR]		= { LDT_BASE_ADDR,	"LDT remap" },
+	[LDT_NR]		= { 0UL,		"LDT remap" },
 #endif
 	[CPU_ENTRY_AREA_NR]	= { CPU_ENTRY_AREA_BASE,"CPU entry Area" },
 #ifdef CONFIG_X86_ESPFIX64
@@ -570,6 +570,9 @@ static int __init pt_dump_init(void)
 	address_markers[LOW_KERNEL_NR].start_address = PAGE_OFFSET;
 	address_markers[VMALLOC_START_NR].start_address = VMALLOC_START;
 	address_markers[VMEMMAP_START_NR].start_address = VMEMMAP_START;
+#ifdef CONFIG_MODIFY_LDT_SYSCALL
+	address_markers[LDT_NR].start_address = LDT_BASE_ADDR;
+#endif
 #endif
 #ifdef CONFIG_X86_32
 	address_markers[VMALLOC_START_NR].start_address = VMALLOC_START;
-- 
2.15.1
