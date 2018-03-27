Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752118AbeC0Hsz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 03:48:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53769 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbeC0Hsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 03:48:54 -0400
Date: Tue, 27 Mar 2018 00:48:31 -0700
From: tip-bot for David Rientjes <tipbot@zytor.com>
Message-ID: <tip-fc5d1073cae299de4517755a910df4f12a6a438f@git.kernel.org>
Cc: tglx@linutronix.de, torvalds@linux-foundation.org, rientjes@google.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com, labbott@redhat.com,
        mingo@kernel.org
Reply-To: tglx@linutronix.de, torvalds@linux-foundation.org,
        rientjes@google.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        hpa@zytor.com, labbott@redhat.com, mingo@kernel.org
In-Reply-To: <alpine.DEB.2.20.1803262325540.256524@chino.kir.corp.google.com>
References: <alpine.DEB.2.20.1803262325540.256524@chino.kir.corp.google.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/32: Remove unused node_memmap_size_bytes() &
 CONFIG_NEED_NODE_MEMMAP_SIZE logic
Git-Commit-ID: fc5d1073cae299de4517755a910df4f12a6a438f
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

Commit-ID:  fc5d1073cae299de4517755a910df4f12a6a438f
Gitweb:     https://git.kernel.org/tip/fc5d1073cae299de4517755a910df4f12a6a438f
Author:     David Rientjes <rientjes@google.com>
AuthorDate: Mon, 26 Mar 2018 23:27:21 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 27 Mar 2018 08:45:02 +0200

x86/mm/32: Remove unused node_memmap_size_bytes() & CONFIG_NEED_NODE_MEMMAP_SIZE logic

node_memmap_size_bytes() has been unused since the v3.9 kernel, so remove it.

Signed-off-by: David Rientjes <rientjes@google.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Fixes: f03574f2d5b2 ("x86-32, mm: Rip out x86_32 NUMA remapping code")
Link: http://lkml.kernel.org/r/alpine.DEB.2.20.1803262325540.256524@chino.kir.corp.google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/Kconfig       |  4 ----
 arch/x86/mm/numa_32.c  | 11 -----------
 include/linux/mmzone.h |  5 -----
 mm/sparse.c            | 22 ----------------------
 4 files changed, 42 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 18233e459bff..739aff253d17 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1608,10 +1608,6 @@ config ARCH_HAVE_MEMORY_PRESENT
 	def_bool y
 	depends on X86_32 && DISCONTIGMEM
 
-config NEED_NODE_MEMMAP_SIZE
-	def_bool y
-	depends on X86_32 && (DISCONTIGMEM || SPARSEMEM)
-
 config ARCH_FLATMEM_ENABLE
 	def_bool y
 	depends on X86_32 && !NUMA
diff --git a/arch/x86/mm/numa_32.c b/arch/x86/mm/numa_32.c
index aca6295350f3..e8a4a09e20f1 100644
--- a/arch/x86/mm/numa_32.c
+++ b/arch/x86/mm/numa_32.c
@@ -60,17 +60,6 @@ void memory_present(int nid, unsigned long start, unsigned long end)
 	}
 	printk(KERN_CONT "\n");
 }
-
-unsigned long node_memmap_size_bytes(int nid, unsigned long start_pfn,
-					      unsigned long end_pfn)
-{
-	unsigned long nr_pages = end_pfn - start_pfn;
-
-	if (!nr_pages)
-		return 0;
-
-	return (nr_pages + 1) * sizeof(struct page);
-}
 #endif
 
 extern unsigned long highend_pfn, highstart_pfn;
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 7522a6987595..a2db4576e499 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -816,10 +816,6 @@ int local_memory_node(int node_id);
 static inline int local_memory_node(int node_id) { return node_id; };
 #endif
 
-#ifdef CONFIG_NEED_NODE_MEMMAP_SIZE
-unsigned long __init node_memmap_size_bytes(int, unsigned long, unsigned long);
-#endif
-
 /*
  * zone_idx() returns 0 for the ZONE_DMA zone, 1 for the ZONE_NORMAL zone, etc.
  */
@@ -1289,7 +1285,6 @@ struct mminit_pfnnid_cache {
 #endif
 
 void memory_present(int nid, unsigned long start, unsigned long end);
-unsigned long __init node_memmap_size_bytes(int, unsigned long, unsigned long);
 
 /*
  * If it is possible to have holes within a MAX_ORDER_NR_PAGES, then we
diff --git a/mm/sparse.c b/mm/sparse.c
index 7af5e7a92528..79b26f98d793 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -235,28 +235,6 @@ void __init memory_present(int nid, unsigned long start, unsigned long end)
 	}
 }
 
-/*
- * Only used by the i386 NUMA architecures, but relatively
- * generic code.
- */
-unsigned long __init node_memmap_size_bytes(int nid, unsigned long start_pfn,
-						     unsigned long end_pfn)
-{
-	unsigned long pfn;
-	unsigned long nr_pages = 0;
-
-	mminit_validate_memmodel_limits(&start_pfn, &end_pfn);
-	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
-		if (nid != early_pfn_to_nid(pfn))
-			continue;
-
-		if (pfn_present(pfn))
-			nr_pages += PAGES_PER_SECTION;
-	}
-
-	return nr_pages * sizeof(struct page);
-}
-
 /*
  * Subtle, we encode the real pfn into the mem_map such that
  * the identity pfn - section_mem_map will return the actual
