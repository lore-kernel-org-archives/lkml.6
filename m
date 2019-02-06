Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097A4C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA84220818
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731071AbfBFSAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:00:30 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:35597 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729173AbfBFSAa (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Wed, 6 Feb 2019 13:00:30 -0500
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Wed, 06 Feb 2019 19:00:28 +0100
Received: from linux-r8p5.suse.de (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Wed, 06 Feb 2019 17:59:54 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     jgg@ziepe.ca, akpm@linux-foundation.org
Cc:     dledford@redhat.com, jgg@mellanox.com, jack@suse.cz,
        willy@infradead.org, ira.weiny@intel.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net, benve@cisco.com,
        neescoba@cisco.com, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 5/6] drivers/IB,usnic: reduce scope of mmap_sem
Date:   Wed,  6 Feb 2019 09:59:19 -0800
Message-Id: <20190206175920.31082-6-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190206175920.31082-1-dave@stgolabs.net>
References: <20190206175920.31082-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usnic_uiom_get_pages() uses gup_longterm() so we cannot really
get rid of mmap_sem altogether in the driver, but we can get
rid of some complexity that mmap_sem brings with only pinned_vm.
We can get rid of the wq altogether as we no longer need to
defer work to unpin pages as the counter is now atomic. We
also share the lock.

Cc: benve@cisco.com
Cc: neescoba@cisco.com
Acked-by: Parvi Kaustubhi <pkaustub@cisco.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 drivers/infiniband/hw/usnic/usnic_ib_main.c |  2 -
 drivers/infiniband/hw/usnic/usnic_uiom.c    | 58 +++--------------------------
 drivers/infiniband/hw/usnic/usnic_uiom.h    |  1 -
 3 files changed, 6 insertions(+), 55 deletions(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_ib_main.c b/drivers/infiniband/hw/usnic/usnic_ib_main.c
index 3201dd1899c7..1d363b706314 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_main.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_main.c
@@ -691,7 +691,6 @@ static int __init usnic_ib_init(void)
 out_pci_unreg:
 	pci_unregister_driver(&usnic_ib_pci_driver);
 out_umem_fini:
-	usnic_uiom_fini();
 
 	return err;
 }
@@ -704,7 +703,6 @@ static void __exit usnic_ib_destroy(void)
 	unregister_inetaddr_notifier(&usnic_ib_inetaddr_notifier);
 	unregister_netdevice_notifier(&usnic_ib_netdevice_notifier);
 	pci_unregister_driver(&usnic_ib_pci_driver);
-	usnic_uiom_fini();
 }
 
 MODULE_DESCRIPTION("Cisco VIC (usNIC) Verbs Driver");
diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.c b/drivers/infiniband/hw/usnic/usnic_uiom.c
index 854436a2b437..06862a6af185 100644
--- a/drivers/infiniband/hw/usnic/usnic_uiom.c
+++ b/drivers/infiniband/hw/usnic/usnic_uiom.c
@@ -47,8 +47,6 @@
 #include "usnic_uiom.h"
 #include "usnic_uiom_interval_tree.h"
 
-static struct workqueue_struct *usnic_uiom_wq;
-
 #define USNIC_UIOM_PAGE_CHUNK						\
 	((PAGE_SIZE - offsetof(struct usnic_uiom_chunk, page_list))	/\
 	((void *) &((struct usnic_uiom_chunk *) 0)->page_list[1] -	\
@@ -127,9 +125,9 @@ static int usnic_uiom_get_pages(unsigned long addr, size_t size, int writable,
 	npages = PAGE_ALIGN(size + (addr & ~PAGE_MASK)) >> PAGE_SHIFT;
 
 	uiomr->owning_mm = mm = current->mm;
-	down_write(&mm->mmap_sem);
+	down_read(&mm->mmap_sem);
 
-	locked = npages + atomic64_read(&current->mm->pinned_vm);
+	locked = atomic64_add_return(npages, &current->mm->pinned_vm);
 	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 
 	if ((locked > lock_limit) && !capable(CAP_IPC_LOCK)) {
@@ -184,14 +182,13 @@ static int usnic_uiom_get_pages(unsigned long addr, size_t size, int writable,
 	}
 
 out:
-	if (ret < 0)
+	if (ret < 0) {
 		usnic_uiom_put_pages(chunk_list, 0);
-	else {
-		atomic64_set(&mm->pinned_vm, locked);
+		atomic64_sub(npages, &current->mm->pinned_vm);
+	} else
 		mmgrab(uiomr->owning_mm);
-	}
 
-	up_write(&mm->mmap_sem);
+	up_read(&mm->mmap_sem);
 	free_page((unsigned long) page_list);
 	return ret;
 }
@@ -435,43 +432,12 @@ static inline size_t usnic_uiom_num_pages(struct usnic_uiom_reg *uiomr)
 	return PAGE_ALIGN(uiomr->length + uiomr->offset) >> PAGE_SHIFT;
 }
 
-static void usnic_uiom_release_defer(struct work_struct *work)
-{
-	struct usnic_uiom_reg *uiomr =
-		container_of(work, struct usnic_uiom_reg, work);
-
-	down_write(&uiomr->owning_mm->mmap_sem);
-	atomic64_sub(usnic_uiom_num_pages(uiomr), &uiomr->owning_mm->pinned_vm);
-	up_write(&uiomr->owning_mm->mmap_sem);
-
-	__usnic_uiom_release_tail(uiomr);
-}
-
 void usnic_uiom_reg_release(struct usnic_uiom_reg *uiomr,
 			    struct ib_ucontext *context)
 {
 	__usnic_uiom_reg_release(uiomr->pd, uiomr, 1);
 
-	/*
-	 * We may be called with the mm's mmap_sem already held.  This
-	 * can happen when a userspace munmap() is the call that drops
-	 * the last reference to our file and calls our release
-	 * method.  If there are memory regions to destroy, we'll end
-	 * up here and not be able to take the mmap_sem.  In that case
-	 * we defer the vm_locked accounting to a workqueue.
-	 */
-	if (context->closing) {
-		if (!down_write_trylock(&uiomr->owning_mm->mmap_sem)) {
-			INIT_WORK(&uiomr->work, usnic_uiom_release_defer);
-			queue_work(usnic_uiom_wq, &uiomr->work);
-			return;
-		}
-	} else {
-		down_write(&uiomr->owning_mm->mmap_sem);
-	}
 	atomic64_sub(usnic_uiom_num_pages(uiomr), &uiomr->owning_mm->pinned_vm);
-	up_write(&uiomr->owning_mm->mmap_sem);
-
 	__usnic_uiom_release_tail(uiomr);
 }
 
@@ -600,17 +566,5 @@ int usnic_uiom_init(char *drv_name)
 		return -EPERM;
 	}
 
-	usnic_uiom_wq = create_workqueue(drv_name);
-	if (!usnic_uiom_wq) {
-		usnic_err("Unable to alloc wq for drv %s\n", drv_name);
-		return -ENOMEM;
-	}
-
 	return 0;
 }
-
-void usnic_uiom_fini(void)
-{
-	flush_workqueue(usnic_uiom_wq);
-	destroy_workqueue(usnic_uiom_wq);
-}
diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.h b/drivers/infiniband/hw/usnic/usnic_uiom.h
index b86a9731071b..c88cfa087e3a 100644
--- a/drivers/infiniband/hw/usnic/usnic_uiom.h
+++ b/drivers/infiniband/hw/usnic/usnic_uiom.h
@@ -93,5 +93,4 @@ struct usnic_uiom_reg *usnic_uiom_reg_get(struct usnic_uiom_pd *pd,
 void usnic_uiom_reg_release(struct usnic_uiom_reg *uiomr,
 			    struct ib_ucontext *ucontext);
 int usnic_uiom_init(char *drv_name);
-void usnic_uiom_fini(void);
 #endif /* USNIC_UIOM_H_ */
-- 
2.16.4

