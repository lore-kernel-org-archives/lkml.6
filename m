Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030215AbeBNNQr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:16:47 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54097 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967713AbeBNNQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:16:46 -0500
Date: Wed, 14 Feb 2018 05:06:23 -0800
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-5c7919bb1994f8dc7fed219a5db09e6bb9d473a5@git.kernel.org>
Cc: luto@amacapital.net, hpa@zytor.com, peterz@infradead.org,
        torvalds@linux-foundation.org, mingo@kernel.org, bp@suse.de,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        tglx@linutronix.de
Reply-To: kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@suse.de, mingo@kernel.org, hpa@zytor.com,
        peterz@infradead.org, torvalds@linux-foundation.org,
        luto@amacapital.net
In-Reply-To: <20180214111656.88514-6-kirill.shutemov@linux.intel.com>
References: <20180214111656.88514-6-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Make LDT_BASE_ADDR dynamic
Git-Commit-ID: 5c7919bb1994f8dc7fed219a5db09e6bb9d473a5
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

Commit-ID:  5c7919bb1994f8dc7fed219a5db09e6bb9d473a5
Gitweb:     https://git.kernel.org/tip/5c7919bb1994f8dc7fed219a5db09e6bb9d473a5
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Wed, 14 Feb 2018 14:16:52 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 14 Feb 2018 13:11:14 +0100

x86/mm: Make LDT_BASE_ADDR dynamic

LDT_BASE_ADDR has different value in 4- and 5-level paging
configurations.

We need to make it dynamic in preparation for boot-time switching
between paging modes.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180214111656.88514-6-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/pgtable_64_types.h | 9 +++++----
 arch/x86/mm/dump_pagetables.c           | 5 ++++-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 5e2d724..903e4d05 100644
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
index 2a4849e..a89f2db 100644
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
