Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935536AbeB1Wcr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 17:32:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44488 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935455AbeB1WcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 17:32:10 -0500
From: Matthew Wilcox <willy@infradead.org>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] mm: Mark pages allocated through vmalloc
Date: Wed, 28 Feb 2018 14:31:56 -0800
Message-Id: <20180228223157.9281-4-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180228223157.9281-1-willy@infradead.org>
References: <20180228223157.9281-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Use a bit in page_type to mark pages which have been allocated through
vmalloc.  This can be helpful when debugging or analysing crashdumps.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 include/linux/page-flags.h | 6 ++++++
 mm/vmalloc.c               | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index d151f590bbc6..8142ab716e90 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -643,6 +643,7 @@ PAGEFLAG_FALSE(DoubleMap)
 #define PG_buddy	0x00000080
 #define PG_balloon	0x00000100
 #define PG_kmemcg	0x00000200
+#define PG_vmalloc	0x00000400
 
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
@@ -681,6 +682,11 @@ PAGE_TYPE_OPS(Balloon, balloon)
  */
 PAGE_TYPE_OPS(Kmemcg, kmemcg)
 
+/*
+ * Pages allocated through vmalloc are tagged with this bit.
+ */
+PAGE_TYPE_OPS(Vmalloc, vmalloc)
+
 extern bool is_free_buddy_page(struct page *page);
 
 __PAGEFLAG(Isolated, isolated, PF_ANY);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ebff729cc956..3bc0538fc21b 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1536,6 +1536,7 @@ static void __vunmap(const void *addr, int deallocate_pages)
 			struct page *page = area->pages[i];
 
 			BUG_ON(!page);
+			__ClearPageVmalloc(page);
 			__free_pages(page, 0);
 		}
 
@@ -1705,6 +1706,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 			area->nr_pages = i;
 			goto fail;
 		}
+		__SetPageVmalloc(page);
 		area->pages[i] = page;
 		if (gfpflags_allow_blocking(gfp_mask|highmem_mask))
 			cond_resched();
-- 
2.16.1
