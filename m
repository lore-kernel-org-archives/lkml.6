Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934965AbeBPLEf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 06:04:35 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54439 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934609AbeBPLEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 06:04:33 -0500
Date: Fri, 16 Feb 2018 02:54:04 -0800
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-9b46a051e43461a9afda2bdd50e0e0ae349341df@git.kernel.org>
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, arjan@linux.intel.com, mingo@kernel.org,
        dwmw2@infradead.org, bp@suse.de, kirill.shutemov@linux.intel.com,
        dan.j.williams@intel.com, tglx@linutronix.de, luto@kernel.org,
        peterz@infradead.org, jpoimboe@redhat.com, dave.hansen@linux.intel.com
Reply-To: jpoimboe@redhat.com, dave.hansen@linux.intel.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, torvalds@linux-foundation.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com, mingo@kernel.org, bp@suse.de,
        dwmw2@infradead.org, dan.j.williams@intel.com, arjan@linux.intel.com
In-Reply-To: <20180214182542.69302-6-kirill.shutemov@linux.intel.com>
References: <20180214182542.69302-6-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Initialize vmemmap_base at boot-time
Git-Commit-ID: 9b46a051e43461a9afda2bdd50e0e0ae349341df
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

Commit-ID:  9b46a051e43461a9afda2bdd50e0e0ae349341df
Gitweb:     https://git.kernel.org/tip/9b46a051e43461a9afda2bdd50e0e0ae349341df
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Wed, 14 Feb 2018 21:25:38 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 16 Feb 2018 10:48:48 +0100

x86/mm: Initialize vmemmap_base at boot-time

vmemmap area has different placement depending on paging mode.
Let's adjust it during early boot accodring to machine capability.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180214182542.69302-6-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/pgtable_64_types.h | 9 +++------
 arch/x86/kernel/head64.c                | 3 ++-
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 6863299..68909a6 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -108,11 +108,8 @@ extern unsigned int ptrs_per_p4d;
 #define VMALLOC_SIZE_TB_L4	32UL
 #define VMALLOC_SIZE_TB_L5	12800UL
 
-#ifdef CONFIG_X86_5LEVEL
-# define __VMEMMAP_BASE		_AC(0xffd4000000000000, UL)
-#else
-# define __VMEMMAP_BASE		_AC(0xffffea0000000000, UL)
-#endif
+#define __VMEMMAP_BASE_L4	0xffffea0000000000
+#define __VMEMMAP_BASE_L5	0xffd4000000000000
 
 #ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
 # define VMALLOC_START		vmalloc_base
@@ -121,7 +118,7 @@ extern unsigned int ptrs_per_p4d;
 #else
 # define VMALLOC_START		__VMALLOC_BASE_L4
 # define VMALLOC_SIZE_TB	VMALLOC_SIZE_TB_L4
-# define VMEMMAP_START		__VMEMMAP_BASE
+# define VMEMMAP_START		__VMEMMAP_BASE_L4
 #endif /* CONFIG_DYNAMIC_MEMORY_LAYOUT */
 
 #define VMALLOC_END		(VMALLOC_START + (VMALLOC_SIZE_TB << 40) - 1)
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 22bf201..795e762 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -53,7 +53,7 @@ unsigned long page_offset_base __ro_after_init = __PAGE_OFFSET_BASE_L4;
 EXPORT_SYMBOL(page_offset_base);
 unsigned long vmalloc_base __ro_after_init = __VMALLOC_BASE_L4;
 EXPORT_SYMBOL(vmalloc_base);
-unsigned long vmemmap_base __ro_after_init = __VMEMMAP_BASE;
+unsigned long vmemmap_base __ro_after_init = __VMEMMAP_BASE_L4;
 EXPORT_SYMBOL(vmemmap_base);
 #endif
 
@@ -88,6 +88,7 @@ static void __head check_la57_support(unsigned long physaddr)
 	*fixup_int(&ptrs_per_p4d, physaddr) = 512;
 	*fixup_long(&page_offset_base, physaddr) = __PAGE_OFFSET_BASE_L5;
 	*fixup_long(&vmalloc_base, physaddr) = __VMALLOC_BASE_L5;
+	*fixup_long(&vmemmap_base, physaddr) = __VMEMMAP_BASE_L5;
 }
 #else
 static void __head check_la57_support(unsigned long physaddr) {}
