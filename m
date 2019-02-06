Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F9FC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6AF3218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731037AbfBFSAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:00:10 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:58924 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730127AbfBFSAG (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Wed, 6 Feb 2019 13:00:06 -0500
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Wed, 06 Feb 2019 19:00:05 +0100
Received: from linux-r8p5.suse.de (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Wed, 06 Feb 2019 17:59:50 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     jgg@ziepe.ca, akpm@linux-foundation.org
Cc:     dledford@redhat.com, jgg@mellanox.com, jack@suse.cz,
        willy@infradead.org, ira.weiny@intel.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.det>
Subject: [PATCH 4/6] drivers/IB,hfi1: do not se mmap_sem
Date:   Wed,  6 Feb 2019 09:59:18 -0800
Message-Id: <20190206175920.31082-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190206175920.31082-1-dave@stgolabs.net>
References: <20190206175920.31082-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver already uses gup_fast() and thus we can just drop
the mmap_sem protection around the pinned_vm counter. Note that
the window between when hfi1_can_pin_pages() is called and the
actual counter is incremented remains the same as mmap_sem was
_only_ used for when ->pinned_vm was touched.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Davidlohr Bueso <dbueso@suse.det>
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

