Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E800FC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DD020836
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QwboO2dW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0DD020836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbeH1Stm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:49:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57538 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbeH1Stl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Exkv+LQ8zSJPTyJeFocnVOLnkAEWo8whdsioYoMD2fw=; b=QwboO2dWE2pSRU5AMnJauS/KS
        mMb3BlCJKut71jT7XMq6iIyQvWlifU8RyEEY2yQ0DIXPIY5QUCkvgnOcdjCwRhvthLmzY6eaeZb/L
        NnjPDhHaexzFI23A+siAhvmeAjJiXIErHXJ+AIgxoDN7hG9Q15wMHw/N26JUiTu4Ehe+S13VNjyNs
        ndDeAxQ7+UgWiGsK/24/0JtME0fkkAU+zfoF+q5zLfg5rsheNo8Cq4jjpL7gjkEhGP41qwaFauGzv
        u7rlBgMJDck165FeXdPjkR4CpaBbkVczf6a2x/uLzSaeP0ihS5odedmoreD3p7GKa5OYESZYoOOxh
        uTxiR9mvQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fufR2-0003AM-WE; Tue, 28 Aug 2018 14:57:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Souptick Joarder <jrdr.linux@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] mm: Remove vm_insert_mixed
Date:   Tue, 28 Aug 2018 07:57:20 -0700
Message-Id: <20180828145728.11873-3-willy@infradead.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180828145728.11873-1-willy@infradead.org>
References: <20180828145728.11873-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All callers are now converted to vmf_insert_mixed() so convert
vmf_insert_mixed() from being a compatibility wrapper into the real
function.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 include/linux/mm.h | 15 +--------------
 mm/memory.c        | 14 ++++++++++----
 2 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a61ebe8ad4ca..ce1b24376d72 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2482,7 +2482,7 @@ int vm_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn);
 int vm_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn, pgprot_t pgprot);
-int vm_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
+vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 			pfn_t pfn);
 vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
 		unsigned long addr, pfn_t pfn);
@@ -2501,19 +2501,6 @@ static inline vm_fault_t vmf_insert_page(struct vm_area_struct *vma,
 	return VM_FAULT_NOPAGE;
 }
 
-static inline vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma,
-				unsigned long addr, pfn_t pfn)
-{
-	int err = vm_insert_mixed(vma, addr, pfn);
-
-	if (err == -ENOMEM)
-		return VM_FAULT_OOM;
-	if (err < 0 && err != -EBUSY)
-		return VM_FAULT_SIGBUS;
-
-	return VM_FAULT_NOPAGE;
-}
-
 static inline vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma,
 			unsigned long addr, unsigned long pfn)
 {
diff --git a/mm/memory.c b/mm/memory.c
index c467102a5cbc..f0b123a94426 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1940,13 +1940,19 @@ static int __vm_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 	return insert_pfn(vma, addr, pfn, pgprot, mkwrite);
 }
 
-int vm_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
-			pfn_t pfn)
+vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
+		pfn_t pfn)
 {
-	return __vm_insert_mixed(vma, addr, pfn, false);
+	int err = __vm_insert_mixed(vma, addr, pfn, false);
 
+	if (err == -ENOMEM)
+		return VM_FAULT_OOM;
+	if (err < 0 && err != -EBUSY)
+		return VM_FAULT_SIGBUS;
+
+	return VM_FAULT_NOPAGE;
 }
-EXPORT_SYMBOL(vm_insert_mixed);
+EXPORT_SYMBOL(vmf_insert_mixed);
 
 /*
  *  If the insertion of PTE failed because someone else already added a
-- 
2.18.0

