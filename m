Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752777AbeBEB3N (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 20:29:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:43456 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752536AbeBEB2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 20:28:03 -0500
From: Davidlohr Bueso <dbueso@suse.de>
To: akpm@linux-foundation.org, mingo@kernel.org
Cc: peterz@infradead.org, ldufour@linux.vnet.ibm.com, jack@suse.cz,
        mhocko@kernel.org, kirill.shutemov@linux.intel.com,
        mawilcox@microsoft.com, mgorman@techsingularity.net, dave@stgolabs.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 08/64] mm: teach lock_page_or_retry() about range locking
Date: Mon,  5 Feb 2018 02:26:58 +0100
Message-Id: <20180205012754.23615-9-dbueso@wotan.suse.de>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20180205012754.23615-1-dbueso@wotan.suse.de>
References: <20180205012754.23615-1-dbueso@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

The mmap_sem locking rules for lock_page_or_retry() depends on
the page being locked upon return, and can get funky. As such
we need to teach the function about mmrange, which is passed
on via vm_fault.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 include/linux/pagemap.h | 7 ++++---
 mm/filemap.c            | 5 +++--
 mm/memory.c             | 3 ++-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 34ce3ebf97d5..e41a734efbe0 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -464,7 +464,7 @@ static inline pgoff_t linear_page_index(struct vm_area_struct *vma,
 extern void __lock_page(struct page *page);
 extern int __lock_page_killable(struct page *page);
 extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
-				unsigned int flags);
+				unsigned int flags, struct range_lock *mmrange);
 extern void unlock_page(struct page *page);
 
 static inline int trylock_page(struct page *page)
@@ -504,10 +504,11 @@ static inline int lock_page_killable(struct page *page)
  * __lock_page_or_retry().
  */
 static inline int lock_page_or_retry(struct page *page, struct mm_struct *mm,
-				     unsigned int flags)
+				     unsigned int flags,
+				     struct range_lock *mmrange)
 {
 	might_sleep();
-	return trylock_page(page) || __lock_page_or_retry(page, mm, flags);
+	return trylock_page(page) || __lock_page_or_retry(page, mm, flags, mmrange);
 }
 
 /*
diff --git a/mm/filemap.c b/mm/filemap.c
index 693f62212a59..6124ede79a4d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1293,7 +1293,7 @@ EXPORT_SYMBOL_GPL(__lock_page_killable);
  * with the page locked and the mmap_sem unperturbed.
  */
 int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
-			 unsigned int flags)
+			 unsigned int flags, struct range_lock *mmrange)
 {
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
 		/*
@@ -2529,7 +2529,8 @@ int filemap_fault(struct vm_fault *vmf)
 			goto no_cached_page;
 	}
 
-	if (!lock_page_or_retry(page, vmf->vma->vm_mm, vmf->flags)) {
+	if (!lock_page_or_retry(page, vmf->vma->vm_mm, vmf->flags,
+				vmf->lockrange)) {
 		put_page(page);
 		return ret | VM_FAULT_RETRY;
 	}
diff --git a/mm/memory.c b/mm/memory.c
index 2d087b0e174d..5adcdc7dee80 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2986,7 +2986,8 @@ int do_swap_page(struct vm_fault *vmf)
 		goto out_release;
 	}
 
-	locked = lock_page_or_retry(page, vma->vm_mm, vmf->flags);
+	locked = lock_page_or_retry(page, vma->vm_mm, vmf->flags,
+				    vmf->lockrange);
 
 	delayacct_clear_flag(DELAYACCT_PF_SWAPIN);
 	if (!locked) {
-- 
2.13.6
