Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2517C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA3220663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA3220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbeK0E3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:29:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60622 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbeK0E3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:29:43 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1D9593084298;
        Mon, 26 Nov 2018 17:34:56 +0000 (UTC)
Received: from sky.random (ovpn-120-160.rdu2.redhat.com [10.10.120.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 45B22604CE;
        Mon, 26 Nov 2018 17:34:53 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jann Horn <jannh@google.com>, Peter Xu <peterx@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH 1/5] userfaultfd: use ENOENT instead of EFAULT if the atomic copy user fails
Date:   Mon, 26 Nov 2018 12:34:48 -0500
Message-Id: <20181126173452.26955-2-aarcange@redhat.com>
In-Reply-To: <20181126173452.26955-1-aarcange@redhat.com>
References: <20181126173452.26955-1-aarcange@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 26 Nov 2018 17:34:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We internally used EFAULT to communicate with the caller, switch to
ENOENT, so EFAULT can be used as a non internal retval.

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Hugh Dickins <hughd@google.com>
Cc: stable@vger.kernel.org
Fixes: 4c27fe4c4c84 ("userfaultfd: shmem: add shmem_mcopy_atomic_pte for userfaultfd support")
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 mm/hugetlb.c     | 2 +-
 mm/shmem.c       | 2 +-
 mm/userfaultfd.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7f2a28ab46d5..705a3e9cc910 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4080,7 +4080,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 
 		/* fallback to copy_from_user outside mmap_sem */
 		if (unlikely(ret)) {
-			ret = -EFAULT;
+			ret = -ENOENT;
 			*pagep = page;
 			/* don't free the page */
 			goto out;
diff --git a/mm/shmem.c b/mm/shmem.c
index d44991ea5ed4..353287412c25 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2236,7 +2236,7 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 				*pagep = page;
 				shmem_inode_unacct_blocks(inode, 1);
 				/* don't free the page */
-				return -EFAULT;
+				return -ENOENT;
 			}
 		} else {		/* mfill_zeropage_atomic */
 			clear_highpage(page);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 5029f241908f..46c8949e5f8f 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -48,7 +48,7 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 
 		/* fallback to copy_from_user outside mmap_sem */
 		if (unlikely(ret)) {
-			ret = -EFAULT;
+			ret = -ENOENT;
 			*pagep = page;
 			/* don't free the page */
 			goto out;
@@ -274,7 +274,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
 
 		cond_resched();
 
-		if (unlikely(err == -EFAULT)) {
+		if (unlikely(err == -ENOENT)) {
 			up_read(&dst_mm->mmap_sem);
 			BUG_ON(!page);
 
@@ -530,7 +530,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 				       src_addr, &page, zeropage);
 		cond_resched();
 
-		if (unlikely(err == -EFAULT)) {
+		if (unlikely(err == -ENOENT)) {
 			void *page_kaddr;
 
 			up_read(&dst_mm->mmap_sem);
