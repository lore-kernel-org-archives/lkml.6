Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935519AbeB1WcZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 17:32:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44522 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935479AbeB1WcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 17:32:11 -0500
From: Matthew Wilcox <willy@infradead.org>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] mm: Mark pages in use for page tables
Date: Wed, 28 Feb 2018 14:31:57 -0800
Message-Id: <20180228223157.9281-5-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180228223157.9281-1-willy@infradead.org>
References: <20180228223157.9281-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Define a new PageTable bit in the page_type and use it to mark pages in
use as page tables.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 include/linux/mm.h         | 2 ++
 include/linux/page-flags.h | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ad06d42adb1a..7a15042d6828 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1829,6 +1829,7 @@ static inline bool pgtable_page_ctor(struct page *page)
 {
 	if (!ptlock_init(page))
 		return false;
+	__SetPageTable(page);
 	inc_zone_page_state(page, NR_PAGETABLE);
 	return true;
 }
@@ -1836,6 +1837,7 @@ static inline bool pgtable_page_ctor(struct page *page)
 static inline void pgtable_page_dtor(struct page *page)
 {
 	pte_lock_deinit(page);
+	__ClearPageTable(page);
 	dec_zone_page_state(page, NR_PAGETABLE);
 }
 
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 8142ab716e90..ac6bab90849c 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -644,6 +644,7 @@ PAGEFLAG_FALSE(DoubleMap)
 #define PG_balloon	0x00000100
 #define PG_kmemcg	0x00000200
 #define PG_vmalloc	0x00000400
+#define PG_table	0x00000800
 
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
@@ -687,6 +688,11 @@ PAGE_TYPE_OPS(Kmemcg, kmemcg)
  */
 PAGE_TYPE_OPS(Vmalloc, vmalloc)
 
+/*
+ * Marks pages in use as page tables.
+ */
+PAGE_TYPE_OPS(Table, table)
+
 extern bool is_free_buddy_page(struct page *page);
 
 __PAGEFLAG(Isolated, isolated, PF_ANY);
-- 
2.16.1
