Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751767AbeBAHUL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 02:20:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751679AbeBAHUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 02:20:09 -0500
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com, tglx@linutronix.de,
        douly.fnst@cn.fujitsu.com, Baoquan He <bhe@redhat.com>
Subject: [PATCH 1/2] mm/sparsemem: Defer the ms->section_mem_map clearing a little later
Date: Thu,  1 Feb 2018 15:19:55 +0800
Message-Id: <20180201071956.14365-2-bhe@redhat.com>
In-Reply-To: <20180201071956.14365-1-bhe@redhat.com>
References: <20180201071956.14365-1-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will make sure number of sections marked as present won't be changed
in sparse_init(), so that for_each_present_section_nr() can iterate
each of them. This is preparation for later fix.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/sparse-vmemmap.c |  1 -
 mm/sparse.c         | 15 ++++++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 17acf01791fa..315bea91e276 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -324,7 +324,6 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
 		ms = __nr_to_section(pnum);
 		pr_err("%s: sparsemem memory map backing failed some memory will not be available\n",
 		       __func__);
-		ms->section_mem_map = 0;
 	}
 
 	if (vmemmap_buf_start) {
diff --git a/mm/sparse.c b/mm/sparse.c
index 2609aba121e8..54eba92b72a1 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -478,7 +478,6 @@ void __init sparse_mem_maps_populate_node(struct page **map_map,
 		ms = __nr_to_section(pnum);
 		pr_err("%s: sparsemem memory map backing failed some memory will not be available\n",
 		       __func__);
-		ms->section_mem_map = 0;
 	}
 }
 #endif /* !CONFIG_SPARSEMEM_VMEMMAP */
@@ -610,17 +609,27 @@ void __init sparse_init(void)
 #endif
 
 	for_each_present_section_nr(0, pnum) {
+		struct mem_section *ms;
+		ms = __nr_to_section(pnum);
 		usemap = usemap_map[pnum];
-		if (!usemap)
+		if (!usemap) {
+#ifdef CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
+			ms->section_mem_map = 0;
+#endif
 			continue;
+		}
 
 #ifdef CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
 		map = map_map[pnum];
 #else
 		map = sparse_early_mem_map_alloc(pnum);
 #endif
-		if (!map)
+		if (!map) {
+#ifdef CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
+			ms->section_mem_map = 0;
+#endif
 			continue;
+		}
 
 		sparse_init_one_section(__nr_to_section(pnum), pnum, map,
 								usemap);
-- 
2.13.6
