Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426114AbeBOQgh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:36:37 -0500
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:37394 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1426090AbeBOQgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:36:20 -0500
From: Nadav Amit <namit@vmware.com>
To: Ingo Molnar <mingo@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, Willy Tarreau <w@1wt.eu>,
        Nadav Amit <nadav.amit@gmail.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, Nadav Amit <namit@vmware.com>
Subject: [PATCH RFC v2 5/6] x86: Use global pages when PTI is disabled
Date: Thu, 15 Feb 2018 08:36:01 -0800
Message-ID: <20180215163602.61162-6-namit@vmware.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180215163602.61162-1-namit@vmware.com>
References: <20180215163602.61162-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As long as PTI is disabled, it is possible to use global pages, as long
as we remove them once PTI is enabled again. To do so, return the global
bit to __supported_pte_mask and disable global pages using CR4.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/tlbflush.h |  6 ++++++
 arch/x86/mm/init.c              | 14 ++++++--------
 arch/x86/mm/tlb.c               |  3 ++-
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index ea65cf951c49..3a44cb0a9f56 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -319,6 +319,12 @@ static inline void set_cpu_pti_disable(unsigned short disable)
 	WARN_ON_ONCE(preemptible());
 
 	pti_update_user_cs64(cpu_pti_disable(), disable);
+	if (__supported_pte_mask & _PAGE_GLOBAL) {
+		if (disable)
+			cr4_set_bits(X86_CR4_PGE);
+		else
+			cr4_clear_bits(X86_CR4_PGE);
+	}
 	this_cpu_write(cpu_tlbstate.pti_disable, disable);
 }
 
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 82f5252c723a..7f918a59c536 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -161,12 +161,6 @@ struct map_range {
 
 static int page_size_mask;
 
-static void enable_global_pages(void)
-{
-	if (!static_cpu_has(X86_FEATURE_PTI))
-		__supported_pte_mask |= _PAGE_GLOBAL;
-}
-
 static void __init probe_page_size_mask(void)
 {
 	/*
@@ -186,8 +180,10 @@ static void __init probe_page_size_mask(void)
 	/* Enable PGE if available */
 	__supported_pte_mask &= ~_PAGE_GLOBAL;
 	if (boot_cpu_has(X86_FEATURE_PGE)) {
-		cr4_set_bits_and_update_boot(X86_CR4_PGE);
-		enable_global_pages();
+		__supported_pte_mask |= _PAGE_GLOBAL;
+
+		if (!static_cpu_has(X86_FEATURE_PTI))
+			cr4_set_bits_and_update_boot(X86_CR4_PGE);
 	}
 
 	/* Enable 1 GB linear kernel mappings if available: */
@@ -683,6 +679,8 @@ void __init init_mem_mapping(void)
 #else
 	early_ioremap_page_table_range_init();
 #endif
+	if (static_cpu_has(X86_FEATURE_PTI))
+		cr4_clear_bits(X86_CR4_PGE);
 
 	load_cr3(swapper_pg_dir);
 	__flush_tlb_all();
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index c67ef3fb4f35..979c7ec6baab 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -74,7 +74,8 @@ static void choose_new_asid(struct mm_struct *next, u64 next_tlb_gen,
 		return;
 	}
 
-	if (this_cpu_read(cpu_tlbstate.invalidate_other))
+	if (this_cpu_read(cpu_tlbstate.invalidate_other) &&
+	    !mm_pti_disable(next))
 		clear_asid_other();
 
 	for (asid = 0; asid < TLB_NR_DYN_ASIDS; asid++) {
-- 
2.14.1
