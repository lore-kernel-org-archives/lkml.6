Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F97C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E2B214C5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56E2B214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933879AbeGFRK0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:10:26 -0400
Received: from shelob.surriel.com ([96.67.55.147]:50708 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932483AbeGFRKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:10:25 -0400
Received: from [2603:3005:d05:2b00:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fbUFR-0007TK-Mu; Fri, 06 Jul 2018 13:10:21 -0400
Date:   Fri, 6 Jul 2018 13:10:19 -0400
From:   Rik van Riel <riel@surriel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "kirill.shutemov" <kirill.shutemov@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        kernel-team <kernel-team@fb.com>
Subject: [PATCH] Revert "mm: always flush VMA ranges affected by
 zap_page_range"
Message-ID: <20180706131019.51e3a5f0@imladris.surriel.com>
In-Reply-To: <1530896635.5350.25.camel@surriel.com>
References: <1530896635.5350.25.camel@surriel.com>
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was a bug in Linux that could cause madvise (and mprotect?)
system calls to return to userspace without the TLB having been
flushed for all the pages involved.

This could happen when multiple threads of a process made simultaneous
madvise and/or mprotect calls.

This was noticed in the summer of 2017, at which time two solutions
were created:
56236a59556c ("mm: refactor TLB gathering API")
99baac21e458 ("mm: fix MADV_[FREE|DONTNEED] TLB flush miss problem")
and
4647706ebeee ("mm: always flush VMA ranges affected by zap_page_range")

We need only one of these solutions, and the former appears to be
a little more efficient than the latter, so revert that one.

This reverts commit 4647706ebeee6e50f7b9f922b095f4ec94d581c3.
---
 mm/memory.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 7206a634270b..9d472e00fc2d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1603,20 +1603,8 @@ void zap_page_range(struct vm_area_struct *vma, unsigned long start,
 	tlb_gather_mmu(&tlb, mm, start, end);
 	update_hiwater_rss(mm);
 	mmu_notifier_invalidate_range_start(mm, start, end);
-	for ( ; vma && vma->vm_start < end; vma = vma->vm_next) {
+	for ( ; vma && vma->vm_start < end; vma = vma->vm_next)
 		unmap_single_vma(&tlb, vma, start, end, NULL);
-
-		/*
-		 * zap_page_range does not specify whether mmap_sem should be
-		 * held for read or write. That allows parallel zap_page_range
-		 * operations to unmap a PTE and defer a flush meaning that
-		 * this call observes pte_none and fails to flush the TLB.
-		 * Rather than adding a complex API, ensure that no stale
-		 * TLB entries exist when this call returns.
-		 */
-		flush_tlb_range(vma, start, end);
-	}
-
 	mmu_notifier_invalidate_range_end(mm, start, end);
 	tlb_finish_mmu(&tlb, start, end);
 }
-- 
2.14.4


