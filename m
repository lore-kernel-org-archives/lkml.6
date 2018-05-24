Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935390AbeEXBAj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 21:00:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:34349 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935280AbeEXBAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 21:00:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,435,1520924400";
   d="scan'208";a="42362529"
From: "Huang, Ying" <ying.huang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>, Andi Kleen <andi.kleen@intel.com>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Hugh Dickins <hughd@google.com>, Minchan Kim <minchan@kernel.org>,
        Shaohua Li <shli@fb.com>, Christopher Lameter <cl@linux.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH -V2 -mm 1/4] mm, clear_huge_page: Move order algorithm into a separate function
Date: Thu, 24 May 2018 08:58:48 +0800
Message-Id: <20180524005851.4079-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180524005851.4079-1-ying.huang@intel.com>
References: <20180524005851.4079-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

In commit c79b57e462b5d ("mm: hugetlb: clear target sub-page last when
clearing huge page"), to keep the cache lines of the target subpage
hot, the order to clear the subpages in the huge page in
clear_huge_page() is changed to clearing the subpage which is furthest
from the target subpage firstly, and the target subpage last.  This
optimization could be applied to copying huge page too with the same
order algorithm.  To avoid code duplication and reduce maintenance
overhead, in this patch, the order algorithm is moved out of
clear_huge_page() into a separate function: process_huge_page().  So
that we can use it for copying huge page too.

This will change the direct calls to clear_user_highpage() into the
indirect calls.  But with the proper inline support of the compilers,
the indirect call will be optimized to be the direct call.  Our tests
show no performance change with the patch.

This patch is a code cleanup without functionality change.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Shaohua Li <shli@fb.com>
Cc: Christopher Lameter <cl@linux.com>
---
 mm/memory.c | 90 ++++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 56 insertions(+), 34 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 14578158ed20..b9f573a81bbd 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4569,71 +4569,93 @@ EXPORT_SYMBOL(__might_fault);
 #endif
 
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
-static void clear_gigantic_page(struct page *page,
-				unsigned long addr,
-				unsigned int pages_per_huge_page)
-{
-	int i;
-	struct page *p = page;
-
-	might_sleep();
-	for (i = 0; i < pages_per_huge_page;
-	     i++, p = mem_map_next(p, page, i)) {
-		cond_resched();
-		clear_user_highpage(p, addr + i * PAGE_SIZE);
-	}
-}
-void clear_huge_page(struct page *page,
-		     unsigned long addr_hint, unsigned int pages_per_huge_page)
+/*
+ * Process all subpages of the specified huge page with the specified
+ * operation.  The target subpage will be processed last to keep its
+ * cache lines hot.
+ */
+static inline void process_huge_page(
+	unsigned long addr_hint, unsigned int pages_per_huge_page,
+	void (*process_subpage)(unsigned long addr, int idx, void *arg),
+	void *arg)
 {
 	int i, n, base, l;
 	unsigned long addr = addr_hint &
 		~(((unsigned long)pages_per_huge_page << PAGE_SHIFT) - 1);
 
-	if (unlikely(pages_per_huge_page > MAX_ORDER_NR_PAGES)) {
-		clear_gigantic_page(page, addr, pages_per_huge_page);
-		return;
-	}
-
-	/* Clear sub-page to access last to keep its cache lines hot */
+	/* Process target subpage last to keep its cache lines hot */
 	might_sleep();
 	n = (addr_hint - addr) / PAGE_SIZE;
 	if (2 * n <= pages_per_huge_page) {
-		/* If sub-page to access in first half of huge page */
+		/* If target subpage in first half of huge page */
 		base = 0;
 		l = n;
-		/* Clear sub-pages at the end of huge page */
+		/* Process subpages at the end of huge page */
 		for (i = pages_per_huge_page - 1; i >= 2 * n; i--) {
 			cond_resched();
-			clear_user_highpage(page + i, addr + i * PAGE_SIZE);
+			process_subpage(addr + i * PAGE_SIZE, i, arg);
 		}
 	} else {
-		/* If sub-page to access in second half of huge page */
+		/* If target subpage in second half of huge page */
 		base = pages_per_huge_page - 2 * (pages_per_huge_page - n);
 		l = pages_per_huge_page - n;
-		/* Clear sub-pages at the begin of huge page */
+		/* Process subpages at the begin of huge page */
 		for (i = 0; i < base; i++) {
 			cond_resched();
-			clear_user_highpage(page + i, addr + i * PAGE_SIZE);
+			process_subpage(addr + i * PAGE_SIZE, i, arg);
 		}
 	}
 	/*
-	 * Clear remaining sub-pages in left-right-left-right pattern
-	 * towards the sub-page to access
+	 * Process remaining subpages in left-right-left-right pattern
+	 * towards the target subpage
 	 */
 	for (i = 0; i < l; i++) {
 		int left_idx = base + i;
 		int right_idx = base + 2 * l - 1 - i;
 
 		cond_resched();
-		clear_user_highpage(page + left_idx,
-				    addr + left_idx * PAGE_SIZE);
+		process_subpage(addr + left_idx * PAGE_SIZE, left_idx, arg);
 		cond_resched();
-		clear_user_highpage(page + right_idx,
-				    addr + right_idx * PAGE_SIZE);
+		process_subpage(addr + right_idx * PAGE_SIZE, right_idx, arg);
 	}
 }
 
+static void clear_gigantic_page(struct page *page,
+				unsigned long addr,
+				unsigned int pages_per_huge_page)
+{
+	int i;
+	struct page *p = page;
+
+	might_sleep();
+	for (i = 0; i < pages_per_huge_page;
+	     i++, p = mem_map_next(p, page, i)) {
+		cond_resched();
+		clear_user_highpage(p, addr + i * PAGE_SIZE);
+	}
+}
+
+static void clear_subpage(unsigned long addr, int idx, void *arg)
+{
+	struct page *page = arg;
+
+	clear_user_highpage(page + idx, addr);
+}
+
+void clear_huge_page(struct page *page,
+		     unsigned long addr_hint, unsigned int pages_per_huge_page)
+{
+	unsigned long addr = addr_hint &
+		~(((unsigned long)pages_per_huge_page << PAGE_SHIFT) - 1);
+
+	if (unlikely(pages_per_huge_page > MAX_ORDER_NR_PAGES)) {
+		clear_gigantic_page(page, addr, pages_per_huge_page);
+		return;
+	}
+
+	process_huge_page(addr_hint, pages_per_huge_page, clear_subpage, page);
+}
+
 static void copy_user_gigantic_page(struct page *dst, struct page *src,
 				    unsigned long addr,
 				    struct vm_area_struct *vma,
-- 
2.16.1
