Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B728FC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D0A20671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D0A20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbeGYUzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 16:55:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57232 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730308AbeGYUzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 16:55:10 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5576ED08;
        Wed, 25 Jul 2018 19:42:02 +0000 (UTC)
Date:   Wed, 25 Jul 2018 12:42:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3 1/3] mm: Introduce vma_init()
Message-Id: <20180725124201.bcfec6827706fc87273f05bb@linux-foundation.org>
In-Reply-To: <20180725123924.g2yvgie2iz2txmek@kshutemo-mobl1>
References: <20180724121139.62570-1-kirill.shutemov@linux.intel.com>
        <20180724121139.62570-2-kirill.shutemov@linux.intel.com>
        <20180724130308.bbd46afc3703af4c5e1d6868@linux-foundation.org>
        <CA+55aFz1Vj3b2w-nOBdV5=WwsCYhSBprjPjGog6=_=q75Z5Z-w@mail.gmail.com>
        <20180724134158.676dfa7a4da16adbab3b851c@linux-foundation.org>
        <20180725123924.g2yvgie2iz2txmek@kshutemo-mobl1>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jul 2018 15:39:24 +0300 "Kirill A. Shutemov" <kirill@shutemov.name> wrote:

> There are few more:
> 
> arch/arm64/include/asm/tlb.h:   struct vm_area_struct vma = { .vm_mm = tlb->mm, };
> arch/arm64/mm/hugetlbpage.c:    struct vm_area_struct vma = { .vm_mm = mm };
> arch/arm64/mm/hugetlbpage.c:    struct vm_area_struct vma = { .vm_mm = mm };

I'n not understanding.  Your "mm: use vma_init() to initialize VMAs on
stack and data segments" addressed all those?

--- a/arch/arm64/include/asm/tlb.h~mm-use-vma_init-to-initialize-vmas-on-stack-and-data-segments
+++ a/arch/arm64/include/asm/tlb.h
@@ -37,7 +37,9 @@ static inline void __tlb_remove_table(vo
 
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
-	struct vm_area_struct vma = { .vm_mm = tlb->mm, };
+	struct vm_area_struct vma;
+
+	vma_init(&vma, tlb->mm);
 
 	/*
 	 * The ASID allocator will either invalidate the ASID or mark
--- a/arch/arm64/mm/hugetlbpage.c~mm-use-vma_init-to-initialize-vmas-on-stack-and-data-segments
+++ a/arch/arm64/mm/hugetlbpage.c
@@ -108,11 +108,13 @@ static pte_t get_clear_flush(struct mm_s
 			     unsigned long pgsize,
 			     unsigned long ncontig)
 {
-	struct vm_area_struct vma = { .vm_mm = mm };
+	struct vm_area_struct vma;
 	pte_t orig_pte = huge_ptep_get(ptep);
 	bool valid = pte_valid(orig_pte);
 	unsigned long i, saddr = addr;
 
+	vma_init(&vma, mm);
+
 	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++) {
 		pte_t pte = ptep_get_and_clear(mm, addr, ptep);
 
@@ -145,9 +147,10 @@ static void clear_flush(struct mm_struct
 			     unsigned long pgsize,
 			     unsigned long ncontig)
 {
-	struct vm_area_struct vma = { .vm_mm = mm };
+	struct vm_area_struct vma;
 	unsigned long i, saddr = addr;
 
+	vma_init(&vma, mm);
 	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
 		pte_clear(mm, addr, ptep);
 

