Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824E3C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E60020818
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731051AbfBFSAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:00:21 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:39422 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729173AbfBFSAE (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Wed, 6 Feb 2019 13:00:04 -0500
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Wed, 06 Feb 2019 19:00:02 +0100
Received: from linux-r8p5.suse.de (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Wed, 06 Feb 2019 17:59:41 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     jgg@ziepe.ca, akpm@linux-foundation.org
Cc:     dledford@redhat.com, jgg@mellanox.com, jack@suse.cz,
        willy@infradead.org, ira.weiny@intel.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net,
        sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 2/6] drivers/mic/scif: do not use mmap_sem
Date:   Wed,  6 Feb 2019 09:59:16 -0800
Message-Id: <20190206175920.31082-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190206175920.31082-1-dave@stgolabs.net>
References: <20190206175920.31082-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver uses mmap_sem for both pinned_vm accounting and
get_user_pages(). By using gup_fast() and letting the mm handle
the lock if needed, we can no longer rely on the semaphore and
simplify the whole thing.

Cc: sudeep.dutt@intel.com
Cc: ashutosh.dixit@intel.com
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 drivers/misc/mic/scif/scif_rma.c | 36 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/drivers/misc/mic/scif/scif_rma.c b/drivers/misc/mic/scif/scif_rma.c
index 2448368f181e..263b8ad507ea 100644
--- a/drivers/misc/mic/scif/scif_rma.c
+++ b/drivers/misc/mic/scif/scif_rma.c
@@ -272,21 +272,12 @@ static inline void __scif_release_mm(struct mm_struct *mm)
 
 static inline int
 __scif_dec_pinned_vm_lock(struct mm_struct *mm,
-			  int nr_pages, bool try_lock)
+			  int nr_pages)
 {
 	if (!mm || !nr_pages || !scif_ulimit_check)
 		return 0;
-	if (try_lock) {
-		if (!down_write_trylock(&mm->mmap_sem)) {
-			dev_err(scif_info.mdev.this_device,
-				"%s %d err\n", __func__, __LINE__);
-			return -1;
-		}
-	} else {
-		down_write(&mm->mmap_sem);
-	}
+
 	atomic64_sub(nr_pages, &mm->pinned_vm);
-	up_write(&mm->mmap_sem);
 	return 0;
 }
 
@@ -298,16 +289,16 @@ static inline int __scif_check_inc_pinned_vm(struct mm_struct *mm,
 	if (!mm || !nr_pages || !scif_ulimit_check)
 		return 0;
 
-	locked = nr_pages;
-	locked += atomic64_read(&mm->pinned_vm);
 	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+	locked = atomic64_add_return(nr_pages, &mm->pinned_vm);
+
 	if ((locked > lock_limit) && !capable(CAP_IPC_LOCK)) {
+		atomic64_sub(nr_pages, &mm->pinned_vm);
 		dev_err(scif_info.mdev.this_device,
 			"locked(%lu) > lock_limit(%lu)\n",
 			locked, lock_limit);
 		return -ENOMEM;
 	}
-	atomic64_set(&mm->pinned_vm, locked);
 	return 0;
 }
 
@@ -326,7 +317,7 @@ int scif_destroy_window(struct scif_endpt *ep, struct scif_window *window)
 
 	might_sleep();
 	if (!window->temp && window->mm) {
-		__scif_dec_pinned_vm_lock(window->mm, window->nr_pages, 0);
+		__scif_dec_pinned_vm_lock(window->mm, window->nr_pages);
 		__scif_release_mm(window->mm);
 		window->mm = NULL;
 	}
@@ -737,7 +728,7 @@ int scif_unregister_window(struct scif_window *window)
 					    ep->rma_info.dma_chan);
 		} else {
 			if (!__scif_dec_pinned_vm_lock(window->mm,
-						       window->nr_pages, 1)) {
+						       window->nr_pages)) {
 				__scif_release_mm(window->mm);
 				window->mm = NULL;
 			}
@@ -1385,28 +1376,23 @@ int __scif_pin_pages(void *addr, size_t len, int *out_prot,
 		prot |= SCIF_PROT_WRITE;
 retry:
 		mm = current->mm;
-		down_write(&mm->mmap_sem);
 		if (ulimit) {
 			err = __scif_check_inc_pinned_vm(mm, nr_pages);
 			if (err) {
-				up_write(&mm->mmap_sem);
 				pinned_pages->nr_pages = 0;
 				goto error_unmap;
 			}
 		}
 
-		pinned_pages->nr_pages = get_user_pages(
+		pinned_pages->nr_pages = get_user_pages_fast(
 				(u64)addr,
 				nr_pages,
 				(prot & SCIF_PROT_WRITE) ? FOLL_WRITE : 0,
-				pinned_pages->pages,
-				NULL);
-		up_write(&mm->mmap_sem);
+				pinned_pages->pages);
 		if (nr_pages != pinned_pages->nr_pages) {
 			if (try_upgrade) {
 				if (ulimit)
-					__scif_dec_pinned_vm_lock(mm,
-								  nr_pages, 0);
+					__scif_dec_pinned_vm_lock(mm, nr_pages);
 				/* Roll back any pinned pages */
 				for (i = 0; i < pinned_pages->nr_pages; i++) {
 					if (pinned_pages->pages[i])
@@ -1433,7 +1419,7 @@ int __scif_pin_pages(void *addr, size_t len, int *out_prot,
 	return err;
 dec_pinned:
 	if (ulimit)
-		__scif_dec_pinned_vm_lock(mm, nr_pages, 0);
+		__scif_dec_pinned_vm_lock(mm, nr_pages);
 	/* Something went wrong! Rollback */
 error_unmap:
 	pinned_pages->nr_pages = nr_pages;
-- 
2.16.4

