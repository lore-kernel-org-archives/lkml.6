Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752115AbeCVT7r (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 15:59:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36364 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbeCVT62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 15:58:28 -0400
From: Matthew Wilcox <willy@infradead.org>
To: linux-mm@kvack.org
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>,
        Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH 3/4] mm: Add free()
Date: Thu, 22 Mar 2018 12:58:18 -0700
Message-Id: <20180322195819.24271-4-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180322195819.24271-1-willy@infradead.org>
References: <20180322195819.24271-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

free() can free many different kinds of memory.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 include/linux/kernel.h |  2 ++
 mm/util.c              | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 3fd291503576..8bb578938e65 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -933,6 +933,8 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
 			 "pointer type mismatch in container_of()");	\
 	((type *)(__mptr - offsetof(type, member))); })
 
+void free(const void *);
+
 /* Rebuild everything on CONFIG_FTRACE_MCOUNT_RECORD */
 #ifdef CONFIG_FTRACE_MCOUNT_RECORD
 # define REBUILD_DUE_TO_FTRACE_MCOUNT_RECORD
diff --git a/mm/util.c b/mm/util.c
index dc4c7b551aaf..8aa2071059b0 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -26,6 +26,45 @@ static inline int is_kernel_rodata(unsigned long addr)
 		addr < (unsigned long)__end_rodata;
 }
 
+/**
+ * free() - Free memory
+ * @ptr: Pointer to memory
+ *
+ * This function can free almost any type of memory.  It can safely be
+ * called on:
+ * * NULL pointers.
+ * * Pointers to read-only data (will do nothing).
+ * * Pointers to memory allocated from kmalloc().
+ * * Pointers to memory allocated from kmem_cache_alloc().
+ * * Pointers to memory allocated from vmalloc().
+ * * Pointers to memory allocated from alloc_percpu().
+ * * Pointers to memory allocated from __get_free_pages().
+ * * Pointers to memory allocated from page_frag_alloc().
+ *
+ * It cannot free memory allocated by dma_pool_alloc() or dma_alloc_coherent().
+ */
+void free(const void *ptr)
+{
+	struct page *page;
+
+	if (unlikely(ZERO_OR_NULL_PTR(ptr)))
+		return;
+	if (is_kernel_rodata((unsigned long)ptr))
+		return;
+
+	page = virt_to_head_page(ptr);
+	if (likely(PageSlab(page)))
+		return kmem_cache_free(page->slab_cache, (void *)ptr);
+
+	if (is_vmalloc_addr(ptr))
+		return vfree(ptr);
+	if (is_kernel_percpu_address((unsigned long)ptr))
+		free_percpu((void __percpu *)ptr);
+	if (put_page_testzero(page))
+		__put_page(page);
+}
+EXPORT_SYMBOL(free);
+
 /**
  * kfree_const - conditionally free memory
  * @x: pointer to the memory
-- 
2.16.2
