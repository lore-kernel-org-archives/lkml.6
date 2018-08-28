Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5B2C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC0CA208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gwdwUXwV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC0CA208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbeH1Stn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:49:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57568 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728282AbeH1Stm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MPOh18HfFI3D3qSQeEm7RAc4dBhfYVRBxG/Jp7MGb8U=; b=gwdwUXwVHUb+yjYLSQ7uXxNle
        iTvkBjjB7hHT5jDlE+qxrDsLGOah2ss92jz8D9z6XrjY4jPWf2sYnDQDkhIE6sku/mnWtWUEipAa9
        VfHlXoNmqxiU95qUu3La02KpeJNy+fKAi4/070Syd/XRVbO5yfW7Q5r745sRB7wjipfbb7AszP4x2
        VklhihwljeMySBvKD1VMO41Tv3mOjXQVQdeKK9ZU4CAtzXSP76x9ARjgt+zfqg5yFHdMlnWVtJ2nX
        W66fZC2Uw9oLb76QpHxz2XzzQwEkwlQ7GyJg8XWlBgbWkHNx+nv3TylSI/AencqXcST+LjtB1WFMd
        4mU+/iLqA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fufR3-0003An-N6; Tue, 28 Aug 2018 14:57:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Souptick Joarder <jrdr.linux@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] mm: Introduce vmf_insert_pfn_prot
Date:   Tue, 28 Aug 2018 07:57:21 -0700
Message-Id: <20180828145728.11873-4-willy@infradead.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180828145728.11873-1-willy@infradead.org>
References: <20180828145728.11873-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like vm_insert_pfn_prot(), but returns a vm_fault_t instead of an errno.
Also unexport vm_insert_pfn_prot as it has no modular users.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 include/linux/mm.h |  2 ++
 mm/memory.c        | 47 ++++++++++++++++++++++++++++++----------------
 2 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ce1b24376d72..e8bc1a16d44c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2482,6 +2482,8 @@ int vm_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn);
 int vm_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn, pgprot_t pgprot);
+vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
+			unsigned long pfn, pgprot_t pgprot);
 vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 			pfn_t pfn);
 vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
diff --git a/mm/memory.c b/mm/memory.c
index f0b123a94426..8c116c0f64d8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1843,21 +1843,6 @@ int vm_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 }
 EXPORT_SYMBOL(vm_insert_pfn);
 
-/**
- * vm_insert_pfn_prot - insert single pfn into user vma with specified pgprot
- * @vma: user vma to map to
- * @addr: target user address of this page
- * @pfn: source kernel pfn
- * @pgprot: pgprot flags for the inserted page
- *
- * This is exactly like vm_insert_pfn, except that it allows drivers to
- * to override pgprot on a per-page basis.
- *
- * This only makes sense for IO mappings, and it makes no sense for
- * cow mappings.  In general, using multiple vmas is preferable;
- * vm_insert_pfn_prot should only be used if using multiple VMAs is
- * impractical.
- */
 int vm_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn, pgprot_t pgprot)
 {
@@ -1887,7 +1872,37 @@ int vm_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 
 	return ret;
 }
-EXPORT_SYMBOL(vm_insert_pfn_prot);
+
+/**
+ * vmf_insert_pfn_prot - insert single pfn into user vma with specified pgprot
+ * @vma: user vma to map to
+ * @addr: target user address of this page
+ * @pfn: source kernel pfn
+ * @pgprot: pgprot flags for the inserted page
+ *
+ * This is exactly like vmf_insert_pfn(), except that it allows drivers to
+ * to override pgprot on a per-page basis.
+ *
+ * This only makes sense for IO mappings, and it makes no sense for
+ * COW mappings.  In general, using multiple vmas is preferable;
+ * vm_insert_pfn_prot should only be used if using multiple VMAs is
+ * impractical.
+ *
+ * Return: vm_fault_t value.
+ */
+vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
+			unsigned long pfn, pgprot_t pgprot)
+{
+	int err = vm_insert_pfn_prot(vma, addr, pfn, pgprot);
+
+	if (err == -ENOMEM)
+		return VM_FAULT_OOM;
+	if (err < 0 && err != -EBUSY)
+		return VM_FAULT_SIGBUS;
+
+	return VM_FAULT_NOPAGE;
+}
+EXPORT_SYMBOL(vmf_insert_pfn_prot);
 
 static bool vm_mixed_ok(struct vm_area_struct *vma, pfn_t pfn)
 {
-- 
2.18.0

