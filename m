Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030296AbeBNNSO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:18:14 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47373 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030219AbeBNNSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:18:12 -0500
Date: Wed, 14 Feb 2018 05:07:51 -0800
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-09e61a779e7f171c50325e6d7108a593afb2e5d4@git.kernel.org>
Cc: tglx@linutronix.de, peterz@infradead.org, bp@suse.de, hpa@zytor.com,
        luto@amacapital.net, torvalds@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com
Reply-To: torvalds@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        tglx@linutronix.de, peterz@infradead.org, hpa@zytor.com, bp@suse.de,
        luto@amacapital.net
In-Reply-To: <20180214111656.88514-9-kirill.shutemov@linux.intel.com>
References: <20180214111656.88514-9-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Make __VIRTUAL_MASK_SHIFT dynamic
Git-Commit-ID: 09e61a779e7f171c50325e6d7108a593afb2e5d4
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

Commit-ID:  09e61a779e7f171c50325e6d7108a593afb2e5d4
Gitweb:     https://git.kernel.org/tip/09e61a779e7f171c50325e6d7108a593afb2e5d4
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Wed, 14 Feb 2018 14:16:55 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 14 Feb 2018 13:11:15 +0100

x86/mm: Make __VIRTUAL_MASK_SHIFT dynamic

For boot-time switching between paging modes, we need to be able to
adjust virtual mask shifts.

The change doesn't affect the kernel image size much:

   text	   data	    bss	    dec	    hex	filename
8628892	4734340	1368064	14731296	 e0c820	vmlinux.before
8628966	4734340	1368064	14731370	 e0c86a	vmlinux.after

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180214111656.88514-9-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/entry_64.S            | 12 ++++++++++++
 arch/x86/include/asm/page_64_types.h |  2 +-
 arch/x86/mm/dump_pagetables.c        | 12 ++++++++++--
 arch/x86/mm/kaslr.c                  |  4 +++-
 4 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 30c8c53..2c06348 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -274,8 +274,20 @@ GLOBAL(entry_SYSCALL_64_after_hwframe)
 	 * Change top bits to match most significant bit (47th or 56th bit
 	 * depending on paging mode) in the address.
 	 */
+#ifdef CONFIG_X86_5LEVEL
+	testl	$1, pgtable_l5_enabled(%rip)
+	jz	1f
+	shl	$(64 - 57), %rcx
+	sar	$(64 - 57), %rcx
+	jmp	2f
+1:
+	shl	$(64 - 48), %rcx
+	sar	$(64 - 48), %rcx
+2:
+#else
 	shl	$(64 - (__VIRTUAL_MASK_SHIFT+1)), %rcx
 	sar	$(64 - (__VIRTUAL_MASK_SHIFT+1)), %rcx
+#endif
 
 	/* If this changed %rcx, it was not canonical */
 	cmpq	%rcx, %r11
diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index d54a3d5..fa7dc7c 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -56,7 +56,7 @@
 #define __PHYSICAL_MASK_SHIFT	52
 
 #ifdef CONFIG_X86_5LEVEL
-#define __VIRTUAL_MASK_SHIFT	56
+#define __VIRTUAL_MASK_SHIFT	(pgtable_l5_enabled ? 56 : 47)
 #else
 #define __VIRTUAL_MASK_SHIFT	47
 #endif
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index 420058b..9efee6f 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -85,8 +85,12 @@ static struct addr_marker address_markers[] = {
 	[VMALLOC_START_NR]	= { 0UL,		"vmalloc() Area" },
 	[VMEMMAP_START_NR]	= { 0UL,		"Vmemmap" },
 #ifdef CONFIG_KASAN
-	[KASAN_SHADOW_START_NR]	= { KASAN_SHADOW_START,	"KASAN shadow" },
-	[KASAN_SHADOW_END_NR]	= { KASAN_SHADOW_END,	"KASAN shadow end" },
+	/*
+	 * These fields get initialized with the (dynamic)
+	 * KASAN_SHADOW_{START,END} values in pt_dump_init().
+	 */
+	[KASAN_SHADOW_START_NR]	= { 0UL,		"KASAN shadow" },
+	[KASAN_SHADOW_END_NR]	= { 0UL,		"KASAN shadow end" },
 #endif
 #ifdef CONFIG_MODIFY_LDT_SYSCALL
 	[LDT_NR]		= { 0UL,		"LDT remap" },
@@ -571,6 +575,10 @@ static int __init pt_dump_init(void)
 #ifdef CONFIG_MODIFY_LDT_SYSCALL
 	address_markers[LDT_NR].start_address = LDT_BASE_ADDR;
 #endif
+#ifdef CONFIG_KASAN
+	address_markers[KASAN_SHADOW_START_NR].start_address = KASAN_SHADOW_START;
+	address_markers[KASAN_SHADOW_END_NR].start_address = KASAN_SHADOW_END;
+#endif
 #endif
 #ifdef CONFIG_X86_32
 	address_markers[VMALLOC_START_NR].start_address = VMALLOC_START;
diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 515b98a..d079878 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -52,7 +52,7 @@ static __initdata struct kaslr_memory_region {
 	unsigned long *base;
 	unsigned long size_tb;
 } kaslr_regions[] = {
-	{ &page_offset_base, 1 << (__PHYSICAL_MASK_SHIFT - TB_SHIFT) /* Maximum */ },
+	{ &page_offset_base, 0 },
 	{ &vmalloc_base, VMALLOC_SIZE_TB },
 	{ &vmemmap_base, 1 },
 };
@@ -93,6 +93,8 @@ void __init kernel_randomize_memory(void)
 	if (!kaslr_memory_enabled())
 		return;
 
+	kaslr_regions[0].size_tb = 1 << (__PHYSICAL_MASK_SHIFT - TB_SHIFT);
+
 	/*
 	 * Update Physical memory mapping to available and
 	 * add padding if needed (especially for memory hotplug support).
