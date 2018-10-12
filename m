Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B70EC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D018F20865
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D018F20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbeJLXnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:43:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21178 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728730AbeJLXnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:43:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1D11A309D39C;
        Fri, 12 Oct 2018 16:10:09 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-125-5.rdu2.redhat.com [10.10.125.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 848DA7ADDF;
        Fri, 12 Oct 2018 16:10:06 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Nellans <dnellans@nvidia.com>,
        Ingo Molnar <mingo@elte.hu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Minchan Kim <minchan@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH] mm/thp: fix call to mmu_notifier in set_pmd_migration_entry()
Date:   Fri, 12 Oct 2018 12:09:53 -0400
Message-Id: <20181012160953.5841-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 12 Oct 2018 16:10:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

Inside set_pmd_migration_entry() we are holding page table locks and
thus we can not sleep so we can not call invalidate_range_start/end()

So remove call to mmu_notifier_invalidate_range_start/end() and add
call to mmu_notifier_invalidate_range(). Note that we are already
calling mmu_notifier_invalidate_range_start/end() inside the function
calling set_pmd_migration_entry() (see try_to_unmap_one()).

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Reported-by: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Zi Yan <zi.yan@cs.rutgers.edu>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: David Nellans <dnellans@nvidia.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
---
 mm/huge_memory.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 533f9b00147d..93cb80fe12cb 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2885,9 +2885,6 @@ void set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 	if (!(pvmw->pmd && !pvmw->pte))
 		return;
 
-	mmu_notifier_invalidate_range_start(mm, address,
-			address + HPAGE_PMD_SIZE);
-
 	flush_cache_range(vma, address, address + HPAGE_PMD_SIZE);
 	pmdval = *pvmw->pmd;
 	pmdp_invalidate(vma, address, pvmw->pmd);
@@ -2898,11 +2895,9 @@ void set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 	if (pmd_soft_dirty(pmdval))
 		pmdswp = pmd_swp_mksoft_dirty(pmdswp);
 	set_pmd_at(mm, address, pvmw->pmd, pmdswp);
+	mmu_notifier_invalidate_range(mm, address, address + HPAGE_PMD_SIZE);
 	page_remove_rmap(page, true);
 	put_page(page);
-
-	mmu_notifier_invalidate_range_end(mm, address,
-			address + HPAGE_PMD_SIZE);
 }
 
 void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
-- 
2.17.2

