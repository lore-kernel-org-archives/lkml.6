Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6A1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2EF20873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2EF20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mansr.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbeK1Bwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 20:52:33 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:48648 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbeK1Bwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 20:52:32 -0500
X-Greylist: delayed 564 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Nov 2018 20:52:32 EST
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id DBB20149B5; Tue, 27 Nov 2018 14:44:58 +0000 (GMT)
From:   Mans Rullgard <mans@mansr.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] mm: fix insert_pfn() return value
Date:   Tue, 27 Nov 2018 14:43:51 +0000
Message-Id: <20181127144351.9137-1-mans@mansr.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9b5a8e00d479 ("mm: convert insert_pfn() to vm_fault_t") accidentally
made insert_pfn() always return an error.  Fix this.

Fixes: 9b5a8e00d479 ("mm: convert insert_pfn() to vm_fault_t")
Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 mm/memory.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 4ad2d293ddc2..15baf50e3908 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1524,12 +1524,14 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 			pfn_t pfn, pgprot_t prot, bool mkwrite)
 {
 	struct mm_struct *mm = vma->vm_mm;
+	int retval;
 	pte_t *pte, entry;
 	spinlock_t *ptl;
 
 	pte = get_locked_pte(mm, addr, &ptl);
 	if (!pte)
 		return VM_FAULT_OOM;
+	retval = VM_FAULT_NOPAGE;
 	if (!pte_none(*pte)) {
 		if (mkwrite) {
 			/*
@@ -1567,9 +1569,10 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 	set_pte_at(mm, addr, pte, entry);
 	update_mmu_cache(vma, addr, pte); /* XXX: why not for insert_page? */
 
+	retval = 0;
 out_unlock:
 	pte_unmap_unlock(pte, ptl);
-	return VM_FAULT_NOPAGE;
+	return retval;
 }
 
 /**
-- 
2.19.2

