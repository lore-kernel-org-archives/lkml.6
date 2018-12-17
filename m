Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BCCC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DDFE20645
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732346AbeLQMN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:13:59 -0500
Received: from relay.sw.ru ([185.231.240.75]:42462 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbeLQMN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:13:58 -0500
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gYrmS-0007gf-E7; Mon, 17 Dec 2018 15:13:52 +0300
Subject: [PATCH] mm: Remove __hugepage_set_anon_rmap()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        mike.kravetz@oracle.com, jglisse@redhat.com, ktkhai@virtuozzo.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Mon, 17 Dec 2018 15:13:51 +0300
Message-ID: <154504875359.30235.6237926369392564851.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is identical to __page_set_anon_rmap()
since the time, when it was introduced (8 years ago).
The patch removes the function, and makes its users
to use __page_set_anon_rmap() instead.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/rmap.c |   25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 896c61dbf16c..f0d3bab2f7ad 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1020,7 +1020,7 @@ void page_move_anon_rmap(struct page *page, struct vm_area_struct *vma)
 
 /**
  * __page_set_anon_rmap - set up new anonymous rmap
- * @page:	Page to add to rmap	
+ * @page:	Page or Hugepage to add to rmap
  * @vma:	VM area to add page to.
  * @address:	User virtual address of the mapping	
  * @exclusive:	the page is exclusively owned by the current process
@@ -1921,27 +1921,10 @@ void rmap_walk_locked(struct page *page, struct rmap_walk_control *rwc)
 
 #ifdef CONFIG_HUGETLB_PAGE
 /*
- * The following three functions are for anonymous (private mapped) hugepages.
+ * The following two functions are for anonymous (private mapped) hugepages.
  * Unlike common anonymous pages, anonymous hugepages have no accounting code
  * and no lru code, because we handle hugepages differently from common pages.
  */
-static void __hugepage_set_anon_rmap(struct page *page,
-	struct vm_area_struct *vma, unsigned long address, int exclusive)
-{
-	struct anon_vma *anon_vma = vma->anon_vma;
-
-	BUG_ON(!anon_vma);
-
-	if (PageAnon(page))
-		return;
-	if (!exclusive)
-		anon_vma = anon_vma->root;
-
-	anon_vma = (void *) anon_vma + PAGE_MAPPING_ANON;
-	page->mapping = (struct address_space *) anon_vma;
-	page->index = linear_page_index(vma, address);
-}
-
 void hugepage_add_anon_rmap(struct page *page,
 			    struct vm_area_struct *vma, unsigned long address)
 {
@@ -1953,7 +1936,7 @@ void hugepage_add_anon_rmap(struct page *page,
 	/* address might be in next vma when migration races vma_adjust */
 	first = atomic_inc_and_test(compound_mapcount_ptr(page));
 	if (first)
-		__hugepage_set_anon_rmap(page, vma, address, 0);
+		__page_set_anon_rmap(page, vma, address, 0);
 }
 
 void hugepage_add_new_anon_rmap(struct page *page,
@@ -1961,6 +1944,6 @@ void hugepage_add_new_anon_rmap(struct page *page,
 {
 	BUG_ON(address < vma->vm_start || address >= vma->vm_end);
 	atomic_set(compound_mapcount_ptr(page), 0);
-	__hugepage_set_anon_rmap(page, vma, address, 1);
+	__page_set_anon_rmap(page, vma, address, 1);
 }
 #endif /* CONFIG_HUGETLB_PAGE */

