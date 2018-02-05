Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752813AbeBEBcE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 20:32:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:44106 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752682AbeBEB32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 20:29:28 -0500
From: Davidlohr Bueso <dbueso@suse.de>
To: akpm@linux-foundation.org, mingo@kernel.org
Cc: peterz@infradead.org, ldufour@linux.vnet.ibm.com, jack@suse.cz,
        mhocko@kernel.org, kirill.shutemov@linux.intel.com,
        mawilcox@microsoft.com, mgorman@techsingularity.net, dave@stgolabs.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 56/64] drivers/android: use mm locking wrappers
Date: Mon,  5 Feb 2018 02:27:46 +0100
Message-Id: <20180205012754.23615-57-dbueso@wotan.suse.de>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20180205012754.23615-1-dbueso@wotan.suse.de>
References: <20180205012754.23615-1-dbueso@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

The binder_alloc_free_page() shrinker callback can call
zap_page_range(), which needs mmap_sem. Use mm locking
wrappers, no change in semantics.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 drivers/android/binder_alloc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 5a426c877dfb..191724983638 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -194,6 +194,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 	struct vm_area_struct *vma = NULL;
 	struct mm_struct *mm = NULL;
 	bool need_mm = false;
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 
 	binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
 		     "%d: %s pages %pK-%pK\n", alloc->pid,
@@ -219,7 +220,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 		mm = alloc->vma_vm_mm;
 
 	if (mm) {
-		down_write(&mm->mmap_sem);
+		mm_write_lock(mm, &mmrange);
 		vma = alloc->vma;
 	}
 
@@ -288,7 +289,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 		/* vm_insert_page does not seem to increment the refcount */
 	}
 	if (mm) {
-		up_write(&mm->mmap_sem);
+		mm_write_unlock(mm, &mmrange);
 		mmput(mm);
 	}
 	return 0;
@@ -321,7 +322,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 	}
 err_no_vma:
 	if (mm) {
-		up_write(&mm->mmap_sem);
+		mm_write_unlock(mm, &mmrange);
 		mmput(mm);
 	}
 	return vma ? -ENOMEM : -ESRCH;
@@ -914,6 +915,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 	uintptr_t page_addr;
 	size_t index;
 	struct vm_area_struct *vma;
+	DEFINE_RANGE_LOCK_FULL(mmrange);
 
 	alloc = page->alloc;
 	if (!mutex_trylock(&alloc->mutex))
@@ -929,7 +931,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 		if (!mmget_not_zero(alloc->vma_vm_mm))
 			goto err_mmget;
 		mm = alloc->vma_vm_mm;
-		if (!down_write_trylock(&mm->mmap_sem))
+		if (!mm_write_trylock(mm, &mmrange))
 			goto err_down_write_mmap_sem_failed;
 	}
 
@@ -945,7 +947,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
 
 		trace_binder_unmap_user_end(alloc, index);
 
-		up_write(&mm->mmap_sem);
+		mm_write_unlock(mm, &mmrange);
 		mmput(mm);
 	}
 
-- 
2.13.6
