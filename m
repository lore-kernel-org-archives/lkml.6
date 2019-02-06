Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9750EC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C21620818
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbfBFSAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:00:34 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:36715 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729173AbfBFSAc (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Wed, 6 Feb 2019 13:00:32 -0500
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Wed, 06 Feb 2019 19:00:30 +0100
Received: from linux-r8p5.suse.de (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Wed, 06 Feb 2019 17:59:58 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     jgg@ziepe.ca, akpm@linux-foundation.org
Cc:     dledford@redhat.com, jgg@mellanox.com, jack@suse.cz,
        willy@infradead.org, ira.weiny@intel.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 6/6] drivers/IB,core: reduce scope of mmap_sem
Date:   Wed,  6 Feb 2019 09:59:20 -0800
Message-Id: <20190206175920.31082-7-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190206175920.31082-1-dave@stgolabs.net>
References: <20190206175920.31082-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ib_umem_get() uses gup_longterm() and relies on the lock to
stabilze the vma_list, so we cannot really get rid of mmap_sem
altogether, but now that the counter is atomic, we can get of
some complexity that mmap_sem brings with only pinned_vm.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 drivers/infiniband/core/umem.c | 41 ++---------------------------------------
 1 file changed, 2 insertions(+), 39 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 678abe1afcba..b69d3efa8712 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -165,15 +165,12 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
 
 	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 
-	down_write(&mm->mmap_sem);
-	new_pinned = atomic64_read(&mm->pinned_vm) + npages;
+	new_pinned = atomic64_add_return(npages, &mm->pinned_vm);
 	if (new_pinned > lock_limit && !capable(CAP_IPC_LOCK)) {
-		up_write(&mm->mmap_sem);
+		atomic64_sub(npages, &mm->pinned_vm);
 		ret = -ENOMEM;
 		goto out;
 	}
-	atomic64_set(&mm->pinned_vm, new_pinned);
-	up_write(&mm->mmap_sem);
 
 	cur_base = addr & PAGE_MASK;
 
@@ -233,9 +230,7 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
 umem_release:
 	__ib_umem_release(context->device, umem, 0);
 vma:
-	down_write(&mm->mmap_sem);
 	atomic64_sub(ib_umem_num_pages(umem), &mm->pinned_vm);
-	up_write(&mm->mmap_sem);
 out:
 	if (vma_list)
 		free_page((unsigned long) vma_list);
@@ -258,25 +253,12 @@ static void __ib_umem_release_tail(struct ib_umem *umem)
 		kfree(umem);
 }
 
-static void ib_umem_release_defer(struct work_struct *work)
-{
-	struct ib_umem *umem = container_of(work, struct ib_umem, work);
-
-	down_write(&umem->owning_mm->mmap_sem);
-	atomic64_sub(ib_umem_num_pages(umem), &umem->owning_mm->pinned_vm);
-	up_write(&umem->owning_mm->mmap_sem);
-
-	__ib_umem_release_tail(umem);
-}
-
 /**
  * ib_umem_release - release memory pinned with ib_umem_get
  * @umem: umem struct to release
  */
 void ib_umem_release(struct ib_umem *umem)
 {
-	struct ib_ucontext *context = umem->context;
-
 	if (umem->is_odp) {
 		ib_umem_odp_release(to_ib_umem_odp(umem));
 		__ib_umem_release_tail(umem);
@@ -285,26 +267,7 @@ void ib_umem_release(struct ib_umem *umem)
 
 	__ib_umem_release(umem->context->device, umem, 1);
 
-	/*
-	 * We may be called with the mm's mmap_sem already held.  This
-	 * can happen when a userspace munmap() is the call that drops
-	 * the last reference to our file and calls our release
-	 * method.  If there are memory regions to destroy, we'll end
-	 * up here and not be able to take the mmap_sem.  In that case
-	 * we defer the vm_locked accounting a workqueue.
-	 */
-	if (context->closing) {
-		if (!down_write_trylock(&umem->owning_mm->mmap_sem)) {
-			INIT_WORK(&umem->work, ib_umem_release_defer);
-			queue_work(ib_wq, &umem->work);
-			return;
-		}
-	} else {
-		down_write(&umem->owning_mm->mmap_sem);
-	}
 	atomic64_sub(ib_umem_num_pages(umem), &umem->owning_mm->pinned_vm);
-	up_write(&umem->owning_mm->mmap_sem);
-
 	__ib_umem_release_tail(umem);
 }
 EXPORT_SYMBOL(ib_umem_release);
-- 
2.16.4

