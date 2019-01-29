Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF37C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A314E214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbfA2Qyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:54:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36384 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728635AbfA2Qyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 11:54:43 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D7C3A4D21;
        Tue, 29 Jan 2019 16:54:43 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-122-2.rdu2.redhat.com [10.10.122.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2772C102BCEB;
        Tue, 29 Jan 2019 16:54:42 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 04/10] mm/hmm: improve and rename hmm_vma_fault() to hmm_range_fault()
Date:   Tue, 29 Jan 2019 11:54:22 -0500
Message-Id: <20190129165428.3931-5-jglisse@redhat.com>
In-Reply-To: <20190129165428.3931-1-jglisse@redhat.com>
References: <20190129165428.3931-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 29 Jan 2019 16:54:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

Rename for consistency between code, comments and documentation. Also
improves the comments on all the possible returns values. Improve the
function by returning the number of populated entries in pfns array.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/hmm.h | 13 ++++++-
 mm/hmm.c            | 93 ++++++++++++++++++++-------------------------
 2 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index ddf49c1b1f5e..ccf2b630447e 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -391,7 +391,18 @@ bool hmm_vma_range_done(struct hmm_range *range);
  *
  * See the function description in mm/hmm.c for further documentation.
  */
-int hmm_vma_fault(struct hmm_range *range, bool block);
+long hmm_range_fault(struct hmm_range *range, bool block);
+
+/* This is a temporary helper to avoid merge conflict between trees. */
+static inline int hmm_vma_fault(struct hmm_range *range, bool block)
+{
+	long ret = hmm_range_fault(range, block);
+	if (ret == -EBUSY)
+		ret = -EAGAIN;
+	else if (ret == -EAGAIN)
+		ret = -EBUSY;
+	return ret < 0 ? ret : 0;
+}
 
 /* Below are for HMM internal use only! Not to be used by device driver! */
 void hmm_mm_destroy(struct mm_struct *mm);
diff --git a/mm/hmm.c b/mm/hmm.c
index 0d9ecd3337e5..04235455b4d2 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -344,13 +344,13 @@ static int hmm_vma_do_fault(struct mm_walk *walk, unsigned long addr,
 	flags |= write_fault ? FAULT_FLAG_WRITE : 0;
 	ret = handle_mm_fault(vma, addr, flags);
 	if (ret & VM_FAULT_RETRY)
-		return -EBUSY;
+		return -EAGAIN;
 	if (ret & VM_FAULT_ERROR) {
 		*pfn = range->values[HMM_PFN_ERROR];
 		return -EFAULT;
 	}
 
-	return -EAGAIN;
+	return -EBUSY;
 }
 
 static int hmm_pfns_bad(unsigned long addr,
@@ -376,7 +376,7 @@ static int hmm_pfns_bad(unsigned long addr,
  * @fault: should we fault or not ?
  * @write_fault: write fault ?
  * @walk: mm_walk structure
- * Returns: 0 on success, -EAGAIN after page fault, or page fault error
+ * Returns: 0 on success, -EBUSY after page fault, or page fault error
  *
  * This function will be called whenever pmd_none() or pte_none() returns true,
  * or whenever there is no page directory covering the virtual address range.
@@ -399,12 +399,12 @@ static int hmm_vma_walk_hole_(unsigned long addr, unsigned long end,
 
 			ret = hmm_vma_do_fault(walk, addr, write_fault,
 					       &pfns[i]);
-			if (ret != -EAGAIN)
+			if (ret != -EBUSY)
 				return ret;
 		}
 	}
 
-	return (fault || write_fault) ? -EAGAIN : 0;
+	return (fault || write_fault) ? -EBUSY : 0;
 }
 
 static inline void hmm_pte_need_fault(const struct hmm_vma_walk *hmm_vma_walk,
@@ -535,11 +535,11 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	uint64_t orig_pfn = *pfn;
 
 	*pfn = range->values[HMM_PFN_NONE];
-	cpu_flags = pte_to_hmm_pfn_flags(range, pte);
-	hmm_pte_need_fault(hmm_vma_walk, orig_pfn, cpu_flags,
-			   &fault, &write_fault);
+	fault = write_fault = false;
 
 	if (pte_none(pte)) {
+		hmm_pte_need_fault(hmm_vma_walk, orig_pfn, 0,
+				   &fault, &write_fault);
 		if (fault || write_fault)
 			goto fault;
 		return 0;
@@ -578,7 +578,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 				hmm_vma_walk->last = addr;
 				migration_entry_wait(vma->vm_mm,
 						     pmdp, addr);
-				return -EAGAIN;
+				return -EBUSY;
 			}
 			return 0;
 		}
@@ -586,6 +586,10 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 		/* Report error for everything else */
 		*pfn = range->values[HMM_PFN_ERROR];
 		return -EFAULT;
+	} else {
+		cpu_flags = pte_to_hmm_pfn_flags(range, pte);
+		hmm_pte_need_fault(hmm_vma_walk, orig_pfn, cpu_flags,
+				   &fault, &write_fault);
 	}
 
 	if (fault || write_fault)
@@ -636,7 +640,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		if (fault || write_fault) {
 			hmm_vma_walk->last = addr;
 			pmd_migration_entry_wait(vma->vm_mm, pmdp);
-			return -EAGAIN;
+			return -EBUSY;
 		}
 		return 0;
 	} else if (!pmd_present(pmd))
@@ -858,53 +862,36 @@ bool hmm_vma_range_done(struct hmm_range *range)
 EXPORT_SYMBOL(hmm_vma_range_done);
 
 /*
- * hmm_vma_fault() - try to fault some address in a virtual address range
+ * hmm_range_fault() - try to fault some address in a virtual address range
  * @range: range being faulted
  * @block: allow blocking on fault (if true it sleeps and do not drop mmap_sem)
- * Returns: 0 success, error otherwise (-EAGAIN means mmap_sem have been drop)
+ * Returns: 0 on success ortherwise:
+ *      -EINVAL:
+ *              Invalid argument
+ *      -ENOMEM:
+ *              Out of memory.
+ *      -EPERM:
+ *              Invalid permission (for instance asking for write and range
+ *              is read only).
+ *      -EAGAIN:
+ *              If you need to retry and mmap_sem was drop. This can only
+ *              happens if block argument is false.
+ *      -EBUSY:
+ *              If the the range is being invalidated and you should wait for
+ *              invalidation to finish.
+ *      -EFAULT:
+ *              Invalid (ie either no valid vma or it is illegal to access that
+ *              range), number of valid pages in range->pfns[] (from range start
+ *              address).
  *
  * This is similar to a regular CPU page fault except that it will not trigger
- * any memory migration if the memory being faulted is not accessible by CPUs.
+ * any memory migration if the memory being faulted is not accessible by CPUs
+ * and caller does not ask for migration.
  *
  * On error, for one virtual address in the range, the function will mark the
  * corresponding HMM pfn entry with an error flag.
- *
- * Expected use pattern:
- * retry:
- *   down_read(&mm->mmap_sem);
- *   // Find vma and address device wants to fault, initialize hmm_pfn_t
- *   // array accordingly
- *   ret = hmm_vma_fault(range, write, block);
- *   switch (ret) {
- *   case -EAGAIN:
- *     hmm_vma_range_done(range);
- *     // You might want to rate limit or yield to play nicely, you may
- *     // also commit any valid pfn in the array assuming that you are
- *     // getting true from hmm_vma_range_monitor_end()
- *     goto retry;
- *   case 0:
- *     break;
- *   case -ENOMEM:
- *   case -EINVAL:
- *   case -EPERM:
- *   default:
- *     // Handle error !
- *     up_read(&mm->mmap_sem)
- *     return;
- *   }
- *   // Take device driver lock that serialize device page table update
- *   driver_lock_device_page_table_update();
- *   hmm_vma_range_done(range);
- *   // Commit pfns we got from hmm_vma_fault()
- *   driver_unlock_device_page_table_update();
- *   up_read(&mm->mmap_sem)
- *
- * YOU MUST CALL hmm_vma_range_done() AFTER THIS FUNCTION RETURN SUCCESS (0)
- * BEFORE FREEING THE range struct OR YOU WILL HAVE SERIOUS MEMORY CORRUPTION !
- *
- * YOU HAVE BEEN WARNED !
  */
-int hmm_vma_fault(struct hmm_range *range, bool block)
+long hmm_range_fault(struct hmm_range *range, bool block)
 {
 	struct vm_area_struct *vma = range->vma;
 	unsigned long start = range->start;
@@ -976,7 +963,8 @@ int hmm_vma_fault(struct hmm_range *range, bool block)
 	do {
 		ret = walk_page_range(start, range->end, &mm_walk);
 		start = hmm_vma_walk.last;
-	} while (ret == -EAGAIN);
+		/* Keep trying while the range is valid. */
+	} while (ret == -EBUSY && range->valid);
 
 	if (ret) {
 		unsigned long i;
@@ -986,6 +974,7 @@ int hmm_vma_fault(struct hmm_range *range, bool block)
 			       range->end);
 		hmm_vma_range_done(range);
 		hmm_put(hmm);
+		return ret;
 	} else {
 		/*
 		 * Transfer hmm reference to the range struct it will be drop
@@ -995,9 +984,9 @@ int hmm_vma_fault(struct hmm_range *range, bool block)
 		range->hmm = hmm;
 	}
 
-	return ret;
+	return (hmm_vma_walk.last - range->start) >> PAGE_SHIFT;
 }
-EXPORT_SYMBOL(hmm_vma_fault);
+EXPORT_SYMBOL(hmm_range_fault);
 #endif /* IS_ENABLED(CONFIG_HMM_MIRROR) */
 
 
-- 
2.17.2

