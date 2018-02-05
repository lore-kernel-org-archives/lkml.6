Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753042AbeBEBmx (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 20:42:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:43856 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752395AbeBEB2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 20:28:07 -0500
From: Davidlohr Bueso <dbueso@suse.de>
To: akpm@linux-foundation.org, mingo@kernel.org
Cc: peterz@infradead.org, ldufour@linux.vnet.ibm.com, jack@suse.cz,
        mhocko@kernel.org, kirill.shutemov@linux.intel.com,
        mawilcox@microsoft.com, mgorman@techsingularity.net, dave@stgolabs.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 12/64] fs/userfaultfd: teach userfaultfd_must_wait() about range locking
Date: Mon,  5 Feb 2018 02:27:02 +0100
Message-Id: <20180205012754.23615-13-dbueso@wotan.suse.de>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20180205012754.23615-1-dbueso@wotan.suse.de>
References: <20180205012754.23615-1-dbueso@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

And make use of mm_is_locked() which is why we pass down the
vmf->lockrange.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 fs/userfaultfd.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index e3089865fd52..883fbffb284e 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -217,13 +217,14 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 					 struct vm_area_struct *vma,
 					 unsigned long address,
 					 unsigned long flags,
-					 unsigned long reason)
+					 unsigned long reason,
+					 struct range_lock *mmrange)
 {
 	struct mm_struct *mm = ctx->mm;
 	pte_t *pte;
 	bool ret = true;
 
-	VM_BUG_ON(!rwsem_is_locked(&mm->mmap_sem));
+	VM_BUG_ON(!mm_is_locked(mm, mmrange));
 
 	pte = huge_pte_offset(mm, address, vma_mmu_pagesize(vma));
 	if (!pte)
@@ -247,7 +248,8 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 					 struct vm_area_struct *vma,
 					 unsigned long address,
 					 unsigned long flags,
-					 unsigned long reason)
+					 unsigned long reason,
+					 struct range_lock *mmrange)
 {
 	return false;	/* should never get here */
 }
@@ -263,7 +265,8 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 					 unsigned long address,
 					 unsigned long flags,
-					 unsigned long reason)
+					 unsigned long reason,
+					 struct range_lock *mmrange)
 {
 	struct mm_struct *mm = ctx->mm;
 	pgd_t *pgd;
@@ -273,7 +276,7 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	pte_t *pte;
 	bool ret = true;
 
-	VM_BUG_ON(!rwsem_is_locked(&mm->mmap_sem));
+	VM_BUG_ON(!mm_is_locked(mm, mmrange));
 
 	pgd = pgd_offset(mm, address);
 	if (!pgd_present(*pgd))
@@ -365,7 +368,7 @@ int handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	 * Coredumping runs without mmap_sem so we can only check that
 	 * the mmap_sem is held, if PF_DUMPCORE was not set.
 	 */
-	WARN_ON_ONCE(!rwsem_is_locked(&mm->mmap_sem));
+	WARN_ON_ONCE(!mm_is_locked(mm, vmf->lockrange));
 
 	ctx = vmf->vma->vm_userfaultfd_ctx.ctx;
 	if (!ctx)
@@ -473,11 +476,12 @@ int handle_userfault(struct vm_fault *vmf, unsigned long reason)
 
 	if (!is_vm_hugetlb_page(vmf->vma))
 		must_wait = userfaultfd_must_wait(ctx, vmf->address, vmf->flags,
-						  reason);
+						  reason, vmf->lockrange);
 	else
 		must_wait = userfaultfd_huge_must_wait(ctx, vmf->vma,
 						       vmf->address,
-						       vmf->flags, reason);
+						       vmf->flags, reason,
+						       vmf->lockrange);
 	up_read(&mm->mmap_sem);
 
 	if (likely(must_wait && !READ_ONCE(ctx->released) &&
-- 
2.13.6
