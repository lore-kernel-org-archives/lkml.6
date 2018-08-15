Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5120C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 21:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2694320BF2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 21:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uILbxRtJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2694320BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbeHPADp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 20:03:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41898 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbeHPADp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 20:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nh2knEOpfILba34IAgdfY+CzwvbuSIyaKvzipMDi0Fk=; b=uILbxRtJmxFPXEKOafgglHiCU
        cbbrSnz5yYRkIG3lVq5Niz1C5uk09xPYH3d9i07MKrWTt2d0pXnS4w2AxZoypMr5EhsffFQS0szuy
        74bd4GWyZS2CFm4hwW3N5wBUHhRUcc6PLqfLmjGOiAUJbQaaQTNlncGzIWWegzpc1qOB6FDRWSXYa
        Tt1TIHjZNvH2gJFdGQhdDhLKoIFMRaDGsFvS+Ms6BkAuYnx4SVKq0Vyl+1qdsdntXq5OcZQdqbbER
        C3/pn52BaO6SH38NO61pm0wm/DHJrJ/NJmZvZqwtgIb+G4ATlkUNhBvG9982PnmWuxDYUXy1u4dD/
        Qx04Hx9lw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fq334-0002Qh-LJ; Wed, 15 Aug 2018 21:09:46 +0000
Date:   Wed, 15 Aug 2018 14:09:46 -0700
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
Message-ID: <20180815210946.GA28919@bombadil.infradead.org>
References: <1534358990-85530-1-git-send-email-yang.shi@linux.alibaba.com>
 <1534358990-85530-4-git-send-email-yang.shi@linux.alibaba.com>
 <20180815191606.GA4201@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815191606.GA4201@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 12:16:06PM -0700, Matthew Wilcox wrote:
> (not even compiled, and I can see a good opportunity for combining the
> VM_LOCKED loop with the has_uprobes loop)

I was rushing to get that sent earlier.  Here it is tidied up to
actually compile.

Note the diffstat:

 mmap.c |   71 ++++++++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 42 insertions(+), 29 deletions(-)

I think that's a pretty small extra price to pay for having this improved
scalability.

diff --git a/mm/mmap.c b/mm/mmap.c
index de699523c0b7..b77bb3908f8c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2802,7 +2802,9 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	      struct list_head *uf)
 {
 	unsigned long end;
-	struct vm_area_struct *vma, *prev, *last;
+	struct vm_area_struct *vma, *prev, *last, *tmp;
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
+		res = -ENOMEM;
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
 
@@ -2866,25 +2870,31 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 		 * split, despite we could. This is unlikely enough
 		 * failure that it's not worth optimizing it for.
 		 */
-		int error = userfaultfd_unmap_prep(vma, start, end, uf);
-		if (error)
-			return error;
+		res = userfaultfd_unmap_prep(vma, start, end, uf);
+		if (res)
+			goto unlock;
 	}
 
 	/*
 	 * unlock any mlock()ed ranges before detaching vmas
+	 * and check to see if there's any reason we might have to hold
+	 * the mmap_sem write-locked while unmapping regions.
 	 */
-	if (mm->locked_vm) {
-		struct vm_area_struct *tmp = vma;
-		while (tmp && tmp->vm_start < end) {
-			if (tmp->vm_flags & VM_LOCKED) {
-				mm->locked_vm -= vma_pages(tmp);
-				munlock_vma_pages_all(tmp);
-			}
-			tmp = tmp->vm_next;
+	downgrade = true;
+
+	for (tmp = vma; tmp && tmp->vm_start < end; tmp = tmp->vm_next) {
+		if (tmp->vm_flags & VM_LOCKED) {
+			mm->locked_vm -= vma_pages(tmp);
+			munlock_vma_pages_all(tmp);
 		}
+		if (tmp->vm_file &&
+				has_uprobes(tmp, tmp->vm_start, tmp->vm_end))
+			downgrade = false;
 	}
 
+	if (downgrade)
+		downgrade_write(&mm->mmap_sem);
+
 	/*
 	 * Remove the vma's, and unmap the actual pages
 	 */
@@ -2896,7 +2906,14 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
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
@@ -2905,11 +2922,7 @@ int vm_munmap(unsigned long start, size_t len)
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
