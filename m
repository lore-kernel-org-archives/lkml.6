Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58043C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0958520836
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D81kjOyW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0958520836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbeH1SuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:50:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57758 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbeH1Stq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=f5lhvXrwlCEZ0ayy37d4xw82v+UZxOYyyayLQyFd26E=; b=D81kjOyWnlp6sEQdo7Z74hP0b
        CkgtyOe+BCufAkcsTVDFfvyRmjuJorzKSd0ZH3uSs54b24AWMgaLaIb2A6MTw+KQx+MrpTMi02Qqz
        wrbYJ/eRFobeiQBCh56Ifts/5MPn36Xt68x8cMrPtnIqf9WS5rkTaBSFmQiCvDv38Bii1UQ10FukG
        eBAqS45ksNj9RdULs4L2Fw90XQwQKyzXUMaF8F3Wc8atLNxeskh0NeFPpMf5BjrR/r4TW+plgSjsT
        4/Lb5gcQ6J0nw0YbQLSE1PEmGgG6d67//tDtjuuwYwm4bd2/EU81Z92SlGJWAXVdjba+/mWZ2pWbl
        sGdyZovMg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fufR8-0003DJ-Au; Tue, 28 Aug 2018 14:57:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Souptick Joarder <jrdr.linux@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] mm: Convert __vm_insert_mixed to vm_fault_t
Date:   Tue, 28 Aug 2018 07:57:27 -0700
Message-Id: <20180828145728.11873-10-willy@infradead.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180828145728.11873-1-willy@infradead.org>
References: <20180828145728.11873-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both of its callers currently convert its errno return into a
vm_fault_t, so move the conversion into __vm_insert_mixed.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 mm/memory.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 9e97926fee19..9fef202b4ea7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1915,20 +1915,21 @@ static bool vm_mixed_ok(struct vm_area_struct *vma, pfn_t pfn)
 	return false;
 }
 
-static int __vm_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
-			pfn_t pfn, bool mkwrite)
+static vm_fault_t __vm_insert_mixed(struct vm_area_struct *vma,
+		unsigned long addr, pfn_t pfn, bool mkwrite)
 {
 	pgprot_t pgprot = vma->vm_page_prot;
+	int err;
 
 	BUG_ON(!vm_mixed_ok(vma, pfn));
 
 	if (addr < vma->vm_start || addr >= vma->vm_end)
-		return -EFAULT;
+		return VM_FAULT_SIGBUS;
 
 	track_pfn_insert(vma, &pgprot, pfn);
 
 	if (!pfn_modify_allowed(pfn_t_to_pfn(pfn), pgprot))
-		return -EACCES;
+		return VM_FAULT_SIGBUS;
 
 	/*
 	 * If we don't have pte special, then we have to use the pfn_valid()
@@ -1947,15 +1948,10 @@ static int __vm_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 		 * result in pfn_t_has_page() == false.
 		 */
 		page = pfn_to_page(pfn_t_to_pfn(pfn));
-		return insert_page(vma, addr, page, pgprot);
+		err = insert_page(vma, addr, page, pgprot);
+	} else {
+		err = insert_pfn(vma, addr, pfn, pgprot, mkwrite);
 	}
-	return insert_pfn(vma, addr, pfn, pgprot, mkwrite);
-}
-
-vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
-		pfn_t pfn)
-{
-	int err = __vm_insert_mixed(vma, addr, pfn, false);
 
 	if (err == -ENOMEM)
 		return VM_FAULT_OOM;
@@ -1964,6 +1960,12 @@ vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 
 	return VM_FAULT_NOPAGE;
 }
+
+vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
+		pfn_t pfn)
+{
+	return __vm_insert_mixed(vma, addr, pfn, false);
+}
 EXPORT_SYMBOL(vmf_insert_mixed);
 
 /*
@@ -1971,18 +1973,10 @@ EXPORT_SYMBOL(vmf_insert_mixed);
  *  different entry in the mean time, we treat that as success as we assume
  *  the same entry was actually inserted.
  */
-
 vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
 		unsigned long addr, pfn_t pfn)
 {
-	int err;
-
-	err =  __vm_insert_mixed(vma, addr, pfn, true);
-	if (err == -ENOMEM)
-		return VM_FAULT_OOM;
-	if (err < 0 && err != -EBUSY)
-		return VM_FAULT_SIGBUS;
-	return VM_FAULT_NOPAGE;
+	return __vm_insert_mixed(vma, addr, pfn, true);
 }
 EXPORT_SYMBOL(vmf_insert_mixed_mkwrite);
 
-- 
2.18.0

