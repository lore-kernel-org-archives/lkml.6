Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851DDC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 02:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A6121477
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 02:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ku9QaMy9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A6121477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387854AbeHPFmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 01:42:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58306 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731184AbeHPFmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 01:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=faxjcFdpEC766ltR91iVAfQ1HE+MjueEHAx3zpkEd7Q=; b=Ku9QaMy9FLJ5qGCaxVnhHOQDM
        A9o5Nzy1xlHFtCjhZK9aieqAWJAB3wJGFaWvyOTxNeEdOeZPnWcfgr7KrvznfzCyW5ztZd/pUaXGg
        up+0N21FJpWnUyD7dBQYQ/RYcfg9LwU59aBVWsVXCagaElpoN3cC9WDUKkalUeCZCmGYYS1xvFCUa
        1KITCFOEj2BFgUPhmGux5VmnCoPTbIXTUeUZl37CdSPJmE6xZCG1d0yi53f38Hmh1wxSBlzH6D0BO
        m4G+VT1UYr5+J3XQbtKinIG9Er7FI4OONkAk/wX01LzzZ/KaITlPdITNIs101bLO+S1dY503pr7NW
        EeGRRJ0zQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fq8JI-0006wT-OO; Thu, 16 Aug 2018 02:46:52 +0000
Date:   Wed, 15 Aug 2018 19:46:52 -0700
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
Message-ID: <20180816024652.GA11808@bombadil.infradead.org>
References: <1534358990-85530-1-git-send-email-yang.shi@linux.alibaba.com>
 <1534358990-85530-4-git-send-email-yang.shi@linux.alibaba.com>
 <20180815191606.GA4201@bombadil.infradead.org>
 <20180815210946.GA28919@bombadil.infradead.org>
 <78e658dd-bdb0-09ca-9af5-b523c7ff529f@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78e658dd-bdb0-09ca-9af5-b523c7ff529f@linux.alibaba.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 02:54:13PM -0700, Yang Shi wrote:
> 
> 
> On 8/15/18 2:09 PM, Matthew Wilcox wrote:
> > On Wed, Aug 15, 2018 at 12:16:06PM -0700, Matthew Wilcox wrote:
> > > (not even compiled, and I can see a good opportunity for combining the
> > > VM_LOCKED loop with the has_uprobes loop)
> > I was rushing to get that sent earlier.  Here it is tidied up to
> > actually compile.
> 
> Thanks for the example. Yes, I believe the code still can be compacted to
> save some lines. However, the cover letter and the commit log of this patch
> has elaborated the discussion in the earlier reviews about why we do it in
> this way.

You mean the other callers which need to hold mmap_sem write-locked for
longer?  I hadn't really considered those; how about this?

 mmap.c |   47 +++++++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index de699523c0b7..06dc31d1da8c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2798,11 +2798,11 @@ int split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
  * work.  This now handles partial unmappings.
  * Jeremy Fitzhardinge <jeremy@goop.org>
  */
-int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
-	      struct list_head *uf)
+static int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
+	      struct list_head *uf, bool downgrade)
 {
 	unsigned long end;
-	struct vm_area_struct *vma, *prev, *last;
+	struct vm_area_struct *vma, *prev, *last, *tmp;
 
 	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start)
 		return -EINVAL;
@@ -2816,7 +2816,7 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	if (!vma)
 		return 0;
 	prev = vma->vm_prev;
-	/* we have  start < vma->vm_end  */
+	/* we have start < vma->vm_end  */
 
 	/* if it doesn't overlap, we have nothing.. */
 	end = start + len;
@@ -2873,18 +2873,22 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 
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
@@ -2896,7 +2900,13 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	/* Fix up all other VM information */
 	remove_vma_list(mm, vma);
 
-	return 0;
+	return downgrade ? 1 : 0;
+}
+
+int do_unmap(struct mm_struct *mm, unsigned long start, size_t len,
+		struct list_head *uf)
+{
+	return __do_munmap(mm, start, len, uf, false);
 }
 
 int vm_munmap(unsigned long start, size_t len)
@@ -2905,11 +2915,12 @@ int vm_munmap(unsigned long start, size_t len)
 	struct mm_struct *mm = current->mm;
 	LIST_HEAD(uf);
 
-	if (down_write_killable(&mm->mmap_sem))
-		return -EINTR;
-
-	ret = do_munmap(mm, start, len, &uf);
-	up_write(&mm->mmap_sem);
+	down_write(&mm->mmap_sem);
+	ret = __do_munmap(mm, start, len, &uf, true);
+	if (ret == 1)
+		up_read(&mm->mmap_sem);
+	else
+		up_write(&mm->mmap_sem);
 	userfaultfd_unmap_complete(mm, &uf);
 	return ret;
 }
