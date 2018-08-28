Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54262C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A0420836
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oYzGoW05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02A0420836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbeH1Stq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:49:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57688 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbeH1Stp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Q+UtRyNvNkwYnshT9IkFBgwFupwwt2dJy++I8w/l5mU=; b=oYzGoW05CqFQL9d7Wkcj3bKW9
        znlj55QGfDaTL/naoO577ByyBAkfDOxFGhfmN2B8Vtb8TmcgE3GrUvnk7fq0A+UXkfA2xXGrcPm2R
        Uko7H+DU4M3ZMUXfzAjiUpyiFsp84GCPUEw7XoB2Wp4WrSCZUCIu8r+3ctF9jOpOlfi07Xrye1MY6
        cqrLzuONDrr6gMClBHGuuhO5okGid+7MmOCu7O4xLEDh4+TK62ER0AXRxtYebBDe+PxFK3On46XE9
        qx/s4wZCi4lBmQQfBP7Dc8n3nBk+zCbnSjY/StK6NH+AyUfk9EaeeIzxFcRbNW3VUzlBUaRWCrSVW
        Cb8JBN3jg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fufR6-0003CJ-Ql; Tue, 28 Aug 2018 14:57:40 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Souptick Joarder <jrdr.linux@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] mm: Remove vm_insert_pfn
Date:   Tue, 28 Aug 2018 07:57:25 -0700
Message-Id: <20180828145728.11873-8-willy@infradead.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180828145728.11873-1-willy@infradead.org>
References: <20180828145728.11873-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All callers are now converted to vmf_insert_pfn so convert
vmf_insert_pfn() from being a compatibility wrapper around vm_insert_pfn()
to being a compatibility wrapper around vmf_insert_pfn_prot().

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 include/linux/mm.h | 15 +------------
 mm/memory.c        | 54 +++++++++++++++++++++++++---------------------
 2 files changed, 30 insertions(+), 39 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1552c67c835e..bd5e2469b637 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2478,7 +2478,7 @@ struct vm_area_struct *find_extend_vma(struct mm_struct *, unsigned long addr);
 int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
 			unsigned long pfn, unsigned long size, pgprot_t);
 int vm_insert_page(struct vm_area_struct *, unsigned long addr, struct page *);
-int vm_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
+vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn);
 vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn, pgprot_t pgprot);
@@ -2501,19 +2501,6 @@ static inline vm_fault_t vmf_insert_page(struct vm_area_struct *vma,
 	return VM_FAULT_NOPAGE;
 }
 
-static inline vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma,
-			unsigned long addr, unsigned long pfn)
-{
-	int err = vm_insert_pfn(vma, addr, pfn);
-
-	if (err == -ENOMEM)
-		return VM_FAULT_OOM;
-	if (err < 0 && err != -EBUSY)
-		return VM_FAULT_SIGBUS;
-
-	return VM_FAULT_NOPAGE;
-}
-
 static inline vm_fault_t vmf_error(int err)
 {
 	if (err == -ENOMEM)
diff --git a/mm/memory.c b/mm/memory.c
index 8392a104a36d..d5ccbadd81c1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1849,30 +1849,6 @@ static int vm_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 	return ret;
 }
 
-/**
- * vm_insert_pfn - insert single pfn into user vma
- * @vma: user vma to map to
- * @addr: target user address of this page
- * @pfn: source kernel pfn
- *
- * Similar to vm_insert_page, this allows drivers to insert individual pages
- * they've allocated into a user vma. Same comments apply.
- *
- * This function should only be called from a vm_ops->fault handler, and
- * in that case the handler should return NULL.
- *
- * vma cannot be a COW mapping.
- *
- * As this is called only for pages that do not currently exist, we
- * do not need to flush old virtual caches or the TLB.
- */
-int vm_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
-			unsigned long pfn)
-{
-	return vm_insert_pfn_prot(vma, addr, pfn, vma->vm_page_prot);
-}
-EXPORT_SYMBOL(vm_insert_pfn);
-
 /**
  * vmf_insert_pfn_prot - insert single pfn into user vma with specified pgprot
  * @vma: user vma to map to
@@ -1885,9 +1861,10 @@ EXPORT_SYMBOL(vm_insert_pfn);
  *
  * This only makes sense for IO mappings, and it makes no sense for
  * COW mappings.  In general, using multiple vmas is preferable;
- * vm_insert_pfn_prot should only be used if using multiple VMAs is
+ * vmf_insert_pfn_prot should only be used if using multiple VMAs is
  * impractical.
  *
+ * Context: Process context.  May allocate using %GFP_KERNEL.
  * Return: vm_fault_t value.
  */
 vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
@@ -1904,6 +1881,33 @@ vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 }
 EXPORT_SYMBOL(vmf_insert_pfn_prot);
 
+/**
+ * vmf_insert_pfn - insert single pfn into user vma
+ * @vma: user vma to map to
+ * @addr: target user address of this page
+ * @pfn: source kernel pfn
+ *
+ * Similar to vm_insert_page, this allows drivers to insert individual pages
+ * they've allocated into a user vma. Same comments apply.
+ *
+ * This function should only be called from a vm_ops->fault handler, and
+ * in that case the handler should return the result of this function.
+ *
+ * vma cannot be a COW mapping.
+ *
+ * As this is called only for pages that do not currently exist, we
+ * do not need to flush old virtual caches or the TLB.
+ *
+ * Context: Process context.  May allocate using %GFP_KERNEL.
+ * Return: vm_fault_t value.
+ */
+vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
+			unsigned long pfn)
+{
+	return vmf_insert_pfn_prot(vma, addr, pfn, vma->vm_page_prot);
+}
+EXPORT_SYMBOL(vmf_insert_pfn);
+
 static bool vm_mixed_ok(struct vm_area_struct *vma, pfn_t pfn)
 {
 	/* these checks mirror the abort conditions in vm_normal_page */
-- 
2.18.0

