Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147B6C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE6220867
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dh+f9bbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE6220867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbeH1Str (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:49:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57774 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728530AbeH1Str (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ttwMQNsa+nr6K2+Si0fY85CCjll5fRpBEwDl7EOBPac=; b=Dh+f9bbXLCApjDEKWa2hER8L3
        Wh33eqmk3Ffnt6bAoUzFEs4oUmgW1inUoCZrlcvHSD0A+MnJUSknAuG7Cklv9dGzwb+mgst/bgD3e
        80EOMSyChfozNqJpneV9z78JoHRco1iK0qAb6ATO+t4oyEXyTJ8NcVtOhCZTA4WcV1JR7Y8sjMM69
        V6nqZ7ydokBhjzPO1QvETxpQeWalEjwUbZvOR0Ug0GLY5ckVhByxE/1m2IyML5bKAYIzU/IFDPIQO
        QwLhEEpjJ+M7GucHvM5vysuEtwJIeVTdlucLBln4dlufVC4Fz6hPokhetdKy/X8NBI/VjkFCCms9p
        keoVqD1gA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fufR8-0003Dk-W6; Tue, 28 Aug 2018 14:57:43 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Souptick Joarder <jrdr.linux@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] mm: Convert insert_pfn to vm_fault_t
Date:   Tue, 28 Aug 2018 07:57:28 -0700
Message-Id: <20180828145728.11873-11-willy@infradead.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180828145728.11873-1-willy@infradead.org>
References: <20180828145728.11873-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All callers convert its errno into a vm_fault_t, so convert it to
return a vm_fault_t directly.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 mm/memory.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 9fef202b4ea7..368b65390762 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1767,19 +1767,16 @@ int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
 }
 EXPORT_SYMBOL(vm_insert_page);
 
-static int insert_pfn(struct vm_area_struct *vma, unsigned long addr,
+static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 			pfn_t pfn, pgprot_t prot, bool mkwrite)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	int retval;
 	pte_t *pte, entry;
 	spinlock_t *ptl;
 
-	retval = -ENOMEM;
 	pte = get_locked_pte(mm, addr, &ptl);
 	if (!pte)
-		goto out;
-	retval = -EBUSY;
+		return VM_FAULT_OOM;
 	if (!pte_none(*pte)) {
 		if (mkwrite) {
 			/*
@@ -1812,11 +1809,9 @@ static int insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 	set_pte_at(mm, addr, pte, entry);
 	update_mmu_cache(vma, addr, pte); /* XXX: why not for insert_page? */
 
-	retval = 0;
 out_unlock:
 	pte_unmap_unlock(pte, ptl);
-out:
-	return retval;
+	return VM_FAULT_NOPAGE;
 }
 
 /**
@@ -1840,8 +1835,6 @@ static int insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn, pgprot_t pgprot)
 {
-	int err;
-
 	/*
 	 * Technically, architectures with pte_special can avoid all these
 	 * restrictions (same for remap_pfn_range).  However we would like
@@ -1862,15 +1855,8 @@ vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 
 	track_pfn_insert(vma, &pgprot, __pfn_to_pfn_t(pfn, PFN_DEV));
 
-	err = insert_pfn(vma, addr, __pfn_to_pfn_t(pfn, PFN_DEV), pgprot,
+	return insert_pfn(vma, addr, __pfn_to_pfn_t(pfn, PFN_DEV), pgprot,
 			false);
-
-	if (err == -ENOMEM)
-		return VM_FAULT_OOM;
-	if (err < 0 && err != -EBUSY)
-		return VM_FAULT_SIGBUS;
-
-	return VM_FAULT_NOPAGE;
 }
 EXPORT_SYMBOL(vmf_insert_pfn_prot);
 
@@ -1950,7 +1936,7 @@ static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
 		page = pfn_to_page(pfn_t_to_pfn(pfn));
 		err = insert_page(vma, addr, page, pgprot);
 	} else {
-		err = insert_pfn(vma, addr, pfn, pgprot, mkwrite);
+		return insert_pfn(vma, addr, pfn, pgprot, mkwrite);
 	}
 
 	if (err == -ENOMEM)
-- 
2.18.0

