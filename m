Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B495C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E0A20663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E0A20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbeK0E3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:29:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbeK0E3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:29:45 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2DB1030015EC;
        Mon, 26 Nov 2018 17:34:57 +0000 (UTC)
Received: from sky.random (ovpn-120-160.rdu2.redhat.com [10.10.120.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 48017608F3;
        Mon, 26 Nov 2018 17:34:53 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jann Horn <jannh@google.com>, Peter Xu <peterx@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH 3/5] userfaultfd: shmem/hugetlbfs: only allow to register VM_MAYWRITE vmas
Date:   Mon, 26 Nov 2018 12:34:50 -0500
Message-Id: <20181126173452.26955-4-aarcange@redhat.com>
In-Reply-To: <20181126173452.26955-1-aarcange@redhat.com>
References: <20181126173452.26955-1-aarcange@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 26 Nov 2018 17:34:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the VMA to register the uffd onto is found, check that it has
VM_MAYWRITE set before allowing registration. This way we inherit all
common code checks before allowing to fill file holes in shmem and
hugetlbfs with UFFDIO_COPY.

The userfaultfd memory model is not applicable for readonly files
unless it's a MAP_PRIVATE.

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Hugh Dickins <hughd@google.com>
Reported-by: Jann Horn <jannh@google.com>
Fixes: 4c27fe4c4c84 ("userfaultfd: shmem: add shmem_mcopy_atomic_pte for userfaultfd support")
Fixes: ff62a3421044 ("hugetlb: implement memfd sealing")
Cc: stable@vger.kernel.org
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 fs/userfaultfd.c | 15 +++++++++++++++
 mm/userfaultfd.c | 15 ++++++---------
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 356d2b8568c1..cd58939dc977 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1361,6 +1361,19 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		ret = -EINVAL;
 		if (!vma_can_userfault(cur))
 			goto out_unlock;
+
+		/*
+		 * UFFDIO_COPY will fill file holes even without
+		 * PROT_WRITE. This check enforces that if this is a
+		 * MAP_SHARED, the process has write permission to the backing
+		 * file. If VM_MAYWRITE is set it also enforces that on a
+		 * MAP_SHARED vma: there is no F_WRITE_SEAL and no further
+		 * F_WRITE_SEAL can be taken until the vma is destroyed.
+		 */
+		ret = -EPERM;
+		if (unlikely(!(cur->vm_flags & VM_MAYWRITE)))
+			goto out_unlock;
+
 		/*
 		 * If this vma contains ending address, and huge pages
 		 * check alignment.
@@ -1406,6 +1419,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		BUG_ON(!vma_can_userfault(vma));
 		BUG_ON(vma->vm_userfaultfd_ctx.ctx &&
 		       vma->vm_userfaultfd_ctx.ctx != ctx);
+		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
 
 		/*
 		 * Nothing to do: this vma is already registered into this
@@ -1552,6 +1566,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 		cond_resched();
 
 		BUG_ON(!vma_can_userfault(vma));
+		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
 
 		/*
 		 * Nothing to do: this vma is already registered into this
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 471b6457f95f..43cf314cfddd 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -205,8 +205,9 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 		if (!dst_vma || !is_vm_hugetlb_page(dst_vma))
 			goto out_unlock;
 		/*
-		 * Only allow __mcopy_atomic_hugetlb on userfaultfd
-		 * registered ranges.
+		 * Check the vma is registered in uffd, this is
+		 * required to enforce the VM_MAYWRITE check done at
+		 * uffd registration time.
 		 */
 		if (!dst_vma->vm_userfaultfd_ctx.ctx)
 			goto out_unlock;
@@ -459,13 +460,9 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 	if (!dst_vma)
 		goto out_unlock;
 	/*
-	 * Be strict and only allow __mcopy_atomic on userfaultfd
-	 * registered ranges to prevent userland errors going
-	 * unnoticed. As far as the VM consistency is concerned, it
-	 * would be perfectly safe to remove this check, but there's
-	 * no useful usage for __mcopy_atomic ouside of userfaultfd
-	 * registered ranges. This is after all why these are ioctls
-	 * belonging to the userfaultfd and not syscalls.
+	 * Check the vma is registered in uffd, this is required to
+	 * enforce the VM_MAYWRITE check done at uffd registration
+	 * time.
 	 */
 	if (!dst_vma->vm_userfaultfd_ctx.ctx)
 		goto out_unlock;
