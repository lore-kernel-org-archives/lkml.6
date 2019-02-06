Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE448C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A538B217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbfBFSAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:00:06 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:54017 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730952AbfBFSAF (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Wed, 6 Feb 2019 13:00:05 -0500
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Wed, 06 Feb 2019 19:00:03 +0100
Received: from linux-r8p5.suse.de (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Wed, 06 Feb 2019 17:59:46 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     jgg@ziepe.ca, akpm@linux-foundation.org
Cc:     dledford@redhat.com, jgg@mellanox.com, jack@suse.cz,
        willy@infradead.org, ira.weiny@intel.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net,
        dennis.dalessandro@intel.com, mike.marciniszyn@intel.com,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 3/6] drivers/IB,qib: optimize mmap_sem usage
Date:   Wed,  6 Feb 2019 09:59:17 -0800
Message-Id: <20190206175920.31082-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190206175920.31082-1-dave@stgolabs.net>
References: <20190206175920.31082-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver uses mmap_sem for both pinned_vm accounting and
get_user_pages(). Because rdma drivers might want to use
gup_longterm() in the future we still need some sort of
mmap_sem serialization (as opposed to removing it entirely
by using gup_fast()). Now that pinned_vm is atomic the
writer lock can therefore be converted to reader.

This also fixes a bug that __qib_get_user_pages was not
taking into account the current value of pinned_vm.

Cc: dennis.dalessandro@intel.com
Cc: mike.marciniszyn@intel.com
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 drivers/infiniband/hw/qib/qib_user_pages.c | 73 +++++++++++-------------------
 1 file changed, 27 insertions(+), 46 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_user_pages.c b/drivers/infiniband/hw/qib/qib_user_pages.c
index c6c81022d313..ef8bcf366ddc 100644
--- a/drivers/infiniband/hw/qib/qib_user_pages.c
+++ b/drivers/infiniband/hw/qib/qib_user_pages.c
@@ -49,43 +49,6 @@ static void __qib_release_user_pages(struct page **p, size_t num_pages,
 	}
 }
 
-/*
- * Call with current->mm->mmap_sem held.
- */
-static int __qib_get_user_pages(unsigned long start_page, size_t num_pages,
-				struct page **p)
-{
-	unsigned long lock_limit;
-	size_t got;
-	int ret;
-
-	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
-
-	if (num_pages > lock_limit && !capable(CAP_IPC_LOCK)) {
-		ret = -ENOMEM;
-		goto bail;
-	}
-
-	for (got = 0; got < num_pages; got += ret) {
-		ret = get_user_pages_longterm(start_page + got * PAGE_SIZE,
-					      num_pages - got,
-					      FOLL_WRITE | FOLL_FORCE,
-					      p + got, NULL);
-		if (ret < 0)
-			goto bail_release;
-	}
-
-	atomic64_add(num_pages, &current->mm->pinned_vm);
-
-	ret = 0;
-	goto bail;
-
-bail_release:
-	__qib_release_user_pages(p, got, 0);
-bail:
-	return ret;
-}
-
 /**
  * qib_map_page - a safety wrapper around pci_map_page()
  *
@@ -137,26 +100,44 @@ int qib_map_page(struct pci_dev *hwdev, struct page *page, dma_addr_t *daddr)
 int qib_get_user_pages(unsigned long start_page, size_t num_pages,
 		       struct page **p)
 {
+	unsigned long locked, lock_limit;
+	size_t got;
 	int ret;
 
-	down_write(&current->mm->mmap_sem);
+	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+	locked = atomic64_add_return(num_pages, &current->mm->pinned_vm);
 
-	ret = __qib_get_user_pages(start_page, num_pages, p);
+	if (num_pages > lock_limit && !capable(CAP_IPC_LOCK)) {
+		ret = -ENOMEM;
+		goto bail;
+	}
 
-	up_write(&current->mm->mmap_sem);
+	down_read(&current->mm->mmap_sem);
+	for (got = 0; got < num_pages; got += ret) {
+		ret = get_user_pages_longterm(start_page + got * PAGE_SIZE,
+					      num_pages - got,
+					      FOLL_WRITE | FOLL_FORCE,
+					      p + got, NULL);
+		if (ret < 0) {
+			up_read(&current->mm->mmap_sem);
+			goto bail_release;
+		}
+	}
+	up_read(&current->mm->mmap_sem);
 
+	return 0;
+bail_release:
+	__qib_release_user_pages(p, got, 0);
+bail:
+	atomic64_sub(num_pages, &current->mm->pinned_vm);
 	return ret;
 }
 
 void qib_release_user_pages(struct page **p, size_t num_pages)
 {
-	if (current->mm) /* during close after signal, mm can be NULL */
-		down_write(&current->mm->mmap_sem);
-
 	__qib_release_user_pages(p, num_pages, 1);
 
-	if (current->mm) {
+	/* during close after signal, mm can be NULL */
+	if (current->mm)
 		atomic64_sub(num_pages, &current->mm->pinned_vm);
-		up_write(&current->mm->mmap_sem);
-	}
 }
-- 
2.16.4

