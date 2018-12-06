Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6E5C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C81021479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107234;
	bh=evcEFR+wNZayOZyJrwTz3VEI3noPP1QoclYSnfBTSuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=riFfo30sTgnoZjap1RrBuvhezCYeNYKYxnhhIHjMY4TZMbuUipR6XbWKMZ7tx09as
	 STNURcXcapCAIFubQO1a1y/+xNoCj2NuWWr+O3rbuSdSLKt2dTWRqEFs43gGaHmTW6
	 FMhBh8/MMEx8V6TeiT5E2btMW0StjsrfMMB+jEEg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C81021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbeLFOkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:40:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:44584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729955AbeLFOka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:40:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52D1B2082B;
        Thu,  6 Dec 2018 14:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107228;
        bh=evcEFR+wNZayOZyJrwTz3VEI3noPP1QoclYSnfBTSuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0xZao61omPJUfo5M7BYEB65OLDq90uHBiQi+xRJevg0MtRGuppQHxn8yPMF69IIvq
         X/TgjfD+1rtgmotxZx9gNCSwsa6+0ZLGRpyh0v2rz7ntO25+JfzZdVqqj493Pr45Y4
         M6jgFakfW2AN0EEHsbjsVeJ+o4Qo6eCsqS1rWP98=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 23/41] userfaultfd: shmem: add i_size checks
Date:   Thu,  6 Dec 2018 15:39:03 +0100
Message-Id: <20181206142951.728671243@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206142949.757402551@linuxfoundation.org>
References: <20181206142949.757402551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrea Arcangeli <aarcange@redhat.com>

commit e2a50c1f64145a04959df2442305d57307e5395a upstream.

With MAP_SHARED: recheck the i_size after taking the PT lock, to
serialize against truncate with the PT lock.  Delete the page from the
pagecache if the i_size_read check fails.

With MAP_PRIVATE: check the i_size after the PT lock before mapping
anonymous memory or zeropages into the MAP_PRIVATE shmem mapping.

A mostly irrelevant cleanup: like we do the delete_from_page_cache()
pagecache removal after dropping the PT lock, the PT lock is a spinlock
so drop it before the sleepable page lock.

Link: http://lkml.kernel.org/r/20181126173452.26955-5-aarcange@redhat.com
Fixes: 4c27fe4c4c84 ("userfaultfd: shmem: add shmem_mcopy_atomic_pte for userfaultfd support")
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Hugh Dickins <hughd@google.com>
Reported-by: Jann Horn <jannh@google.com>
Cc: <stable@vger.kernel.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/shmem.c       |   18 ++++++++++++++++--
 mm/userfaultfd.c |   26 ++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 4 deletions(-)

--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2264,6 +2264,7 @@ static int shmem_mfill_atomic_pte(struct
 	struct page *page;
 	pte_t _dst_pte, *dst_pte;
 	int ret;
+	pgoff_t offset, max_off;
 
 	ret = -ENOMEM;
 	if (!shmem_inode_acct_block(inode, 1))
@@ -2301,6 +2302,12 @@ static int shmem_mfill_atomic_pte(struct
 	__SetPageSwapBacked(page);
 	__SetPageUptodate(page);
 
+	ret = -EFAULT;
+	offset = linear_page_index(dst_vma, dst_addr);
+	max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	if (unlikely(offset >= max_off))
+		goto out_release;
+
 	ret = mem_cgroup_try_charge_delay(page, dst_mm, gfp, &memcg, false);
 	if (ret)
 		goto out_release;
@@ -2319,8 +2326,14 @@ static int shmem_mfill_atomic_pte(struct
 	if (dst_vma->vm_flags & VM_WRITE)
 		_dst_pte = pte_mkwrite(pte_mkdirty(_dst_pte));
 
-	ret = -EEXIST;
 	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
+
+	ret = -EFAULT;
+	max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	if (unlikely(offset >= max_off))
+		goto out_release_uncharge_unlock;
+
+	ret = -EEXIST;
 	if (!pte_none(*dst_pte))
 		goto out_release_uncharge_unlock;
 
@@ -2338,13 +2351,14 @@ static int shmem_mfill_atomic_pte(struct
 
 	/* No need to invalidate - it was non-present before */
 	update_mmu_cache(dst_vma, dst_addr, dst_pte);
-	unlock_page(page);
 	pte_unmap_unlock(dst_pte, ptl);
+	unlock_page(page);
 	ret = 0;
 out:
 	return ret;
 out_release_uncharge_unlock:
 	pte_unmap_unlock(dst_pte, ptl);
+	delete_from_page_cache(page);
 out_release_uncharge:
 	mem_cgroup_cancel_charge(page, memcg, false);
 out_release:
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -33,6 +33,8 @@ static int mcopy_atomic_pte(struct mm_st
 	void *page_kaddr;
 	int ret;
 	struct page *page;
+	pgoff_t offset, max_off;
+	struct inode *inode;
 
 	if (!*pagep) {
 		ret = -ENOMEM;
@@ -73,8 +75,17 @@ static int mcopy_atomic_pte(struct mm_st
 	if (dst_vma->vm_flags & VM_WRITE)
 		_dst_pte = pte_mkwrite(pte_mkdirty(_dst_pte));
 
-	ret = -EEXIST;
 	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
+	if (dst_vma->vm_file) {
+		/* the shmem MAP_PRIVATE case requires checking the i_size */
+		inode = dst_vma->vm_file->f_inode;
+		offset = linear_page_index(dst_vma, dst_addr);
+		max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+		ret = -EFAULT;
+		if (unlikely(offset >= max_off))
+			goto out_release_uncharge_unlock;
+	}
+	ret = -EEXIST;
 	if (!pte_none(*dst_pte))
 		goto out_release_uncharge_unlock;
 
@@ -108,11 +119,22 @@ static int mfill_zeropage_pte(struct mm_
 	pte_t _dst_pte, *dst_pte;
 	spinlock_t *ptl;
 	int ret;
+	pgoff_t offset, max_off;
+	struct inode *inode;
 
 	_dst_pte = pte_mkspecial(pfn_pte(my_zero_pfn(dst_addr),
 					 dst_vma->vm_page_prot));
-	ret = -EEXIST;
 	dst_pte = pte_offset_map_lock(dst_mm, dst_pmd, dst_addr, &ptl);
+	if (dst_vma->vm_file) {
+		/* the shmem MAP_PRIVATE case requires checking the i_size */
+		inode = dst_vma->vm_file->f_inode;
+		offset = linear_page_index(dst_vma, dst_addr);
+		max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+		ret = -EFAULT;
+		if (unlikely(offset >= max_off))
+			goto out_unlock;
+	}
+	ret = -EEXIST;
 	if (!pte_none(*dst_pte))
 		goto out_unlock;
 	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);


