Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933587AbeEWPMm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 11:12:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46480 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933522AbeEWPMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 11:12:31 -0400
From: David Hildenbrand <david@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Reza Arbab <arbab@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v1 09/10] mm/memory_hotplug: teach offline_pages() to not try forever
Date: Wed, 23 May 2018 17:11:50 +0200
Message-Id: <20180523151151.6730-10-david@redhat.com>
In-Reply-To: <20180523151151.6730-1-david@redhat.com>
References: <20180523151151.6730-1-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can easily happen that we get stuck forever trying to offline pages -
e.g. on persistent errors.

Let's add a way to change this behavior and fail fast.

This is interesting if offline_pages() is called from a driver and we
just want to find some block to offline.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rashmica Gupta <rashmica.g@gmail.com>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Reza Arbab <arbab@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/platforms/powernv/memtrace.c |  2 +-
 drivers/base/memory.c                     |  2 +-
 include/linux/memory_hotplug.h            |  8 ++++----
 mm/memory_hotplug.c                       | 14 ++++++++++----
 4 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
index fc222a0c2ac4..8ce71f7e1558 100644
--- a/arch/powerpc/platforms/powernv/memtrace.c
+++ b/arch/powerpc/platforms/powernv/memtrace.c
@@ -110,7 +110,7 @@ static bool memtrace_offline_pages(u32 nid, u64 start_pfn, u64 nr_pages)
 	walk_memory_range(start_pfn, end_pfn, (void *)MEM_GOING_OFFLINE,
 			  change_memblock_state);
 
-	if (offline_pages(start_pfn, nr_pages)) {
+	if (offline_pages(start_pfn, nr_pages, true)) {
 		walk_memory_range(start_pfn, end_pfn, (void *)MEM_ONLINE,
 				  change_memblock_state);
 		return false;
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 3b8616551561..c785e4c01b23 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -248,7 +248,7 @@ memory_block_action(struct memory_block *mem, unsigned long action)
 		ret = online_pages(start_pfn, nr_pages, mem->online_type);
 		break;
 	case MEM_OFFLINE:
-		ret = offline_pages(start_pfn, nr_pages);
+		ret = offline_pages(start_pfn, nr_pages, true);
 		break;
 	default:
 		WARN(1, KERN_WARNING "%s(%ld, %ld) unknown action: "
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 497e28f5b000..ae53017b54df 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -303,7 +303,8 @@ static inline void pgdat_resize_init(struct pglist_data *pgdat) {}
 
 extern bool is_mem_section_removable(unsigned long pfn, unsigned long nr_pages);
 extern void try_offline_node(int nid);
-extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages);
+extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
+			 bool retry_forever);
 extern void remove_memory(int nid, u64 start, u64 size);
 
 #else
@@ -315,7 +316,8 @@ static inline bool is_mem_section_removable(unsigned long pfn,
 
 static inline void try_offline_node(int nid) {}
 
-static inline int offline_pages(unsigned long start_pfn, unsigned long nr_pages)
+static inline int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
+				bool retry_forever)
 {
 	return -EINVAL;
 }
@@ -333,9 +335,7 @@ extern int arch_add_memory(int nid, u64 start, u64 size,
 		struct vmem_altmap *altmap, bool want_memblock);
 extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
 		unsigned long nr_pages, struct vmem_altmap *altmap);
-extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages);
 extern bool is_memblock_offlined(struct memory_block *mem);
-extern void remove_memory(int nid, u64 start, u64 size);
 extern int sparse_add_one_section(struct pglist_data *pgdat,
 		unsigned long start_pfn, struct vmem_altmap *altmap);
 extern void sparse_remove_one_section(struct zone *zone, struct mem_section *ms,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 1610e214bfc8..3a5845a33910 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1633,8 +1633,8 @@ static void node_states_clear_node(int node, struct memory_notify *arg)
 		node_clear_state(node, N_MEMORY);
 }
 
-static int __ref __offline_pages(unsigned long start_pfn,
-		  unsigned long end_pfn)
+static int __ref __offline_pages(unsigned long start_pfn, unsigned long end_pfn,
+				 bool retry_forever)
 {
 	unsigned long pfn, nr_pages;
 	long offlined_pages;
@@ -1686,6 +1686,10 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	pfn = scan_movable_pages(start_pfn, end_pfn);
 	if (pfn) { /* We have movable pages */
 		ret = do_migrate_range(pfn, end_pfn);
+		if (ret && !retry_forever) {
+			ret = -EBUSY;
+			goto failed_removal;
+		}
 		goto repeat;
 	}
 
@@ -1752,6 +1756,7 @@ static int __ref __offline_pages(unsigned long start_pfn,
  * offline_pages - offline pages in a given range (that are currently online)
  * @start_pfn: start pfn of the memory range
  * @nr_pages: the number of pages
+ * @retry_forever: weather to retry (possibly) forever
  *
  * This function tries to offline the given pages. The alignment/size that
  * can be used is given by offline_nr_pages.
@@ -1764,9 +1769,10 @@ static int __ref __offline_pages(unsigned long start_pfn,
  *
  * Must be protected by mem_hotplug_begin() or a device_lock
  */
-int offline_pages(unsigned long start_pfn, unsigned long nr_pages)
+int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
+		  bool retry_forever)
 {
-	return __offline_pages(start_pfn, start_pfn + nr_pages);
+	return __offline_pages(start_pfn, start_pfn + nr_pages, retry_forever);
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
-- 
2.17.0
