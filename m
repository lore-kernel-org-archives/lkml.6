Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CC9C31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6380C2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfAURnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:43:07 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:55497 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbfAURnG (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Mon, 21 Jan 2019 12:43:06 -0500
Received: from localhost.localdomain (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Mon, 21 Jan 2019 10:42:57 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     dledford@redhat.com, jgg@mellanox.com, jack@suse.de,
        ira.weiny@intel.com, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, mike.marciniszyn@intel.com,
        dennis.dalessandro@intel.com, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 4/6] drivers/IB,hfi1: do not se mmap_sem
Date:   Mon, 21 Jan 2019 09:42:18 -0800
Message-Id: <20190121174220.10583-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190121174220.10583-1-dave@stgolabs.net>
References: <20190121174220.10583-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver already uses gup_fast() and thus we can just drop
the mmap_sem protection around the pinned_vm counter. Note that
the window between when hfi1_can_pin_pages() is called and the
actual counter is incremented remains the same as mmap_sem was
_only_ used for when ->pinned_vm was touched.

Cc: mike.marciniszyn@intel.com
Cc: dennis.dalessandro@intel.com
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 drivers/infiniband/hw/hfi1/user_pages.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/user_pages.c b/drivers/infiniband/hw/hfi1/user_pages.c
index 40a6e434190f..24b592c6522e 100644
--- a/drivers/infiniband/hw/hfi1/user_pages.c
+++ b/drivers/infiniband/hw/hfi1/user_pages.c
@@ -91,9 +91,7 @@ bool hfi1_can_pin_pages(struct hfi1_devdata *dd, struct mm_struct *mm,
 	/* Convert to number of pages */
 	size = DIV_ROUND_UP(size, PAGE_SIZE);
 
-	down_read(&mm->mmap_sem);
 	pinned = atomic64_read(&mm->pinned_vm);
-	up_read(&mm->mmap_sem);
 
 	/* First, check the absolute limit against all pinned pages. */
 	if (pinned + npages >= ulimit && !can_lock)
@@ -111,9 +109,7 @@ int hfi1_acquire_user_pages(struct mm_struct *mm, unsigned long vaddr, size_t np
 	if (ret < 0)
 		return ret;
 
-	down_write(&mm->mmap_sem);
 	atomic64_add(ret, &mm->pinned_vm);
-	up_write(&mm->mmap_sem);
 
 	return ret;
 }
@@ -130,8 +126,6 @@ void hfi1_release_user_pages(struct mm_struct *mm, struct page **p,
 	}
 
 	if (mm) { /* during close after signal, mm can be NULL */
-		down_write(&mm->mmap_sem);
 		atomic64_sub(npages, &mm->pinned_vm);
-		up_write(&mm->mmap_sem);
 	}
 }
-- 
2.16.4

