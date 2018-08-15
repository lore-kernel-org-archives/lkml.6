Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4CCC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2554E2150A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LCYGbOdL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2554E2150A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbeHOWJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 18:09:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59216 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbeHOWJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 18:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mRx99AdQa3QU0PBzukXJTI2K0zCt/ZW0ZmraPqJqYJI=; b=LCYGbOdLuA0PMDMFFWkk4fsLG
        TKCbTiZLuQHsVMBdpepDh1UfaC7PbS6geXm9lN1vVwtiX2Hqki27kGIILSs/JYFvpGmXhAznExv5S
        wGsbgSW+ZpvpBCeKJsNaPKHAEUF+bKvjTYIyjO88NLCEKH1zl62DKmrQKd6OUhz/vVux2TIqQLvWh
        PhlcnsP7PXImlksa8xxvnvcMkVD4rfMdJCt68D76zelYYrz99JhKNb8ACaiqhDkmNc4mg/k+ki94/
        irAjez0VFN7mHsMBTzrr4uEkTeW6OlhQBHZdjkSdbqRFKIUuv5LsGWjp4vfNpTxBCzL1HdP09/0qV
        M1CijRXDw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fq1H5-000488-0p; Wed, 15 Aug 2018 19:16:07 +0000
Date:   Wed, 15 Aug 2018 12:16:06 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mhocko@kernel.org, ldufour@linux.vnet.ibm.com,
        kirill@shutemov.name, vbabka@suse.cz, akpm@linux-foundation.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v8 PATCH 3/5] mm: mmap: zap pages with read mmap_sem in
 munmap
Message-ID: <20180815191606.GA4201@bombadil.infradead.org>
References: <1534358990-85530-1-git-send-email-yang.shi@linux.alibaba.com>
 <1534358990-85530-4-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534358990-85530-4-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 02:49:48AM +0800, Yang Shi wrote:
> +static int do_munmap_zap_rlock(struct mm_struct *mm, unsigned long start,
> +			       size_t len, struct list_head *uf)
> +{
> +	unsigned long end;
> +	struct vm_area_struct *start_vma, *prev, *vma;
> +	int ret = 0;
> +
> +	if (!addr_ok(start, len))
> +		return -EINVAL;
> +
> +	len = PAGE_ALIGN(len);
> +
> +	end = start + len;
> +
> +	/*
> +	 * Need write mmap_sem to split vmas and detach vmas
> +	 * splitting vma up-front to save PITA to clean if it is failed
> +	 */
> +	if (down_write_killable(&mm->mmap_sem))
> +		return -EINTR;
> +
> +	start_vma = munmap_lookup_vma(mm, start, end);
> +	if (!start_vma)
> +		goto out;
> +	if (IS_ERR(start_vma)) {
> +		ret = PTR_ERR(start_vma);
> +		goto out;
> +	}
> +
> +	prev = start_vma->vm_prev;
> +
> +	if (unlikely(uf)) {
> +		ret = userfaultfd_unmap_prep(start_vma, start, end, uf);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	/*
> +	 * Unmapping vmas, which have:
> +	 *   VM_HUGETLB or
> +	 *   VM_PFNMAP or
> +	 *   uprobes
> +	 * need get done with write mmap_sem held since they may update
> +	 * vm_flags. Deal with such mappings with regular do_munmap() call.
> +	 */
> +	for (vma = start_vma; vma && vma->vm_start < end; vma = vma->vm_next) {
> +		if ((vma->vm_file &&
> +		    has_uprobes(vma, vma->vm_start, vma->vm_end)) ||
> +		    (vma->vm_flags & (VM_HUGETLB | VM_PFNMAP)))
> +			goto regular_path;

but ... that's going to redo all the work you already did!  Why not just this:

(not even compiled, and I can see a good opportunity for combining the
VM_LOCKED loop with the has_uprobes loop)

diff --git a/mm/mmap.c b/mm/mmap.c
index de699523c0b7..8d121db36efc 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2803,6 +2803,8 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 {
 	unsigned long end;
 	struct vm_area_struct *vma, *prev, *last;
+	int res = 0;
+	bool downgrade = false;
 
 	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start)
 		return -EINVAL;
@@ -2811,17 +2813,20 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	if (len == 0)
 		return -EINVAL;
 
+	if (down_write_killable(&mm->mmap_sem))
+		return -EINTR;
+
 	/* Find the first overlapping VMA */
 	vma = find_vma(mm, start);
 	if (!vma)
-		return 0;
+		goto unlock;
 	prev = vma->vm_prev;
-	/* we have  start < vma->vm_end  */
+	/* we have start < vma->vm_end  */
 
 	/* if it doesn't overlap, we have nothing.. */
 	end = start + len;
 	if (vma->vm_start >= end)
-		return 0;
+		goto unlock;
 
 	/*
 	 * If we need to split any vma, do it now to save pain later.
@@ -2831,28 +2836,27 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	 * places tmp vma above, and higher split_vma places tmp vma below.
 	 */
 	if (start > vma->vm_start) {
-		int error;
-
 		/*
 		 * Make sure that map_count on return from munmap() will
 		 * not exceed its limit; but let map_count go just above
 		 * its limit temporarily, to help free resources as expected.
 		 */
+		res = -ENOMEM
 		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
-			return -ENOMEM;
+			goto unlock;
 
-		error = __split_vma(mm, vma, start, 0);
-		if (error)
-			return error;
+		res = __split_vma(mm, vma, start, 0);
+		if (res)
+			goto unlock;
 		prev = vma;
 	}
 
 	/* Does it split the last one? */
 	last = find_vma(mm, end);
 	if (last && end > last->vm_start) {
-		int error = __split_vma(mm, last, end, 1);
-		if (error)
-			return error;
+		res = __split_vma(mm, last, end, 1);
+		if (res)
+			goto unlock;
 	}
 	vma = prev ? prev->vm_next : mm->mmap;
 
@@ -2866,9 +2870,19 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 		 * split, despite we could. This is unlikely enough
 		 * failure that it's not worth optimizing it for.
 		 */
-		int error = userfaultfd_unmap_prep(vma, start, end, uf);
-		if (error)
-			return error;
+		result = userfaultfd_unmap_prep(vma, start, end, uf);
+		if (result)
+			goto unlock;
+	}
+
+	downgrade = true;
+
+	for (vma = start_vma; vma && vma->vm_start < end; vma = vma->vm_next) {
+		if (vma->vm_file &&
+				has_uprobes(vma, vma->vm_start, vma->vm_end)) {
+			downgrade = false;
+			break;
+		}
 	}
 
 	/*
@@ -2885,6 +2899,9 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 		}
 	}
 
+	if (downgrade)
+		downgrade_write(&mm->mmap_sem);
+
 	/*
 	 * Remove the vma's, and unmap the actual pages
 	 */
@@ -2896,7 +2913,14 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	/* Fix up all other VM information */
 	remove_vma_list(mm, vma);
 
-	return 0;
+	res = 0;
+unlock:
+	if (downgrade) {
+		up_read(&mm->mmap_sem);
+	} else {
+		up_write(&mm->mmap_sem);
+	}
+	return res;
 }
 
 int vm_munmap(unsigned long start, size_t len)
@@ -2905,11 +2929,7 @@ int vm_munmap(unsigned long start, size_t len)
 	struct mm_struct *mm = current->mm;
 	LIST_HEAD(uf);
 
-	if (down_write_killable(&mm->mmap_sem))
-		return -EINTR;
-
 	ret = do_munmap(mm, start, len, &uf);
-	up_write(&mm->mmap_sem);
 	userfaultfd_unmap_complete(mm, &uf);
 	return ret;
 }
