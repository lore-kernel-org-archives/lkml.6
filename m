Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAF7C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464972251E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDbZRHQC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 464972251E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731666AbeKMPrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:47:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:60886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731518AbeKMPrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:47:06 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9D2F22513;
        Tue, 13 Nov 2018 05:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088239;
        bh=6mLMxvWq1b5Wgb1O0XaUhDi1D4EP82leXGTlxVcdTvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QDbZRHQC2QDEItdXIHN2c+j/94iJx1z2bliP+SqG6WFjcCMdB7DMC1JC2uq2di6Dt
         NT9gvR0JmwhIPjkFqXDN+y5dLFu74TKAQtuiPkncPAKdPex6qPnTPh+VBRNRYjWU8B
         9jWvQbPr4zEB+J8pP2su6mNnY0fl8sxU+d9wc9rU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 4.19 37/44] mm: thp: fix MADV_DONTNEED vs migrate_misplaced_transhuge_page race condition
Date:   Tue, 13 Nov 2018 00:49:43 -0500
Message-Id: <20181113054950.77898-37-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113054950.77898-1-sashal@kernel.org>
References: <20181113054950.77898-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Arcangeli <aarcange@redhat.com>

[ Upstream commit d7c3393413fe7e7dc54498ea200ea94742d61e18 ]

Patch series "migrate_misplaced_transhuge_page race conditions".

Aaron found a new instance of the THP MADV_DONTNEED race against
pmdp_clear_flush* variants, that was apparently left unfixed.

While looking into the race found by Aaron, I may have found two more
issues in migrate_misplaced_transhuge_page.

These race conditions would not cause kernel instability, but they'd
corrupt userland data or leave data non zero after MADV_DONTNEED.

I did only minor testing, and I don't expect to be able to reproduce this
(especially the lack of ->invalidate_range before migrate_page_copy,
requires the latest iommu hardware or infiniband to reproduce).  The last
patch is noop for x86 and it needs further review from maintainers of
archs that implement flush_cache_range() (not in CC yet).

To avoid confusion, it's not the first patch that introduces the bug fixed
in the second patch, even before removing the
pmdp_huge_clear_flush_notify, that _notify suffix was called after
migrate_page_copy already run.

This patch (of 3):

This is a corollary of ced108037c2aa ("thp: fix MADV_DONTNEED vs.  numa
balancing race"), 58ceeb6bec8 ("thp: fix MADV_DONTNEED vs.  MADV_FREE
race") and 5b7abeae3af8c ("thp: fix MADV_DONTNEED vs clear soft dirty
race).

When the above three fixes where posted Dave asked
https://lkml.kernel.org/r/929b3844-aec2-0111-fef7-8002f9d4e2b9@intel.com
but apparently this was missed.

The pmdp_clear_flush* in migrate_misplaced_transhuge_page() was introduced
in a54a407fbf7 ("mm: Close races between THP migration and PMD numa
clearing").

The important part of such commit is only the part where the page lock is
not released until the first do_huge_pmd_numa_page() finished disarming
the pagenuma/protnone.

The addition of pmdp_clear_flush() wasn't beneficial to such commit and
there's no commentary about such an addition either.

I guess the pmdp_clear_flush() in such commit was added just in case for
safety, but it ended up introducing the MADV_DONTNEED race condition found
by Aaron.

At that point in time nobody thought of such kind of MADV_DONTNEED race
conditions yet (they were fixed later) so the code may have looked more
robust by adding the pmdp_clear_flush().

This specific race condition won't destabilize the kernel, but it can
confuse userland because after MADV_DONTNEED the memory won't be zeroed
out.

This also optimizes the code and removes a superfluous TLB flush.

[akpm@linux-foundation.org: reflow comment to 80 cols, fix grammar and typo (beacuse)]
Link: http://lkml.kernel.org/r/20181013002430.698-2-aarcange@redhat.com
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
Reported-by: Aaron Tomlin <atomlin@redhat.com>
Acked-by: Mel Gorman <mgorman@suse.de>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Jerome Glisse <jglisse@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/migrate.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 84381b55b2bd..1f634b1563b6 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2029,15 +2029,26 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 	entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 
 	/*
-	 * Clear the old entry under pagetable lock and establish the new PTE.
-	 * Any parallel GUP will either observe the old page blocking on the
-	 * page lock, block on the page table lock or observe the new page.
-	 * The SetPageUptodate on the new page and page_add_new_anon_rmap
-	 * guarantee the copy is visible before the pagetable update.
+	 * Overwrite the old entry under pagetable lock and establish
+	 * the new PTE. Any parallel GUP will either observe the old
+	 * page blocking on the page lock, block on the page table
+	 * lock or observe the new page. The SetPageUptodate on the
+	 * new page and page_add_new_anon_rmap guarantee the copy is
+	 * visible before the pagetable update.
 	 */
 	flush_cache_range(vma, mmun_start, mmun_end);
 	page_add_anon_rmap(new_page, vma, mmun_start, true);
-	pmdp_huge_clear_flush_notify(vma, mmun_start, pmd);
+	/*
+	 * At this point the pmd is numa/protnone (i.e. non present) and the TLB
+	 * has already been flushed globally.  So no TLB can be currently
+	 * caching this non present pmd mapping.  There's no need to clear the
+	 * pmd before doing set_pmd_at(), nor to flush the TLB after
+	 * set_pmd_at().  Clearing the pmd here would introduce a race
+	 * condition against MADV_DONTNEED, because MADV_DONTNEED only holds the
+	 * mmap_sem for reading.  If the pmd is set to NULL at any given time,
+	 * MADV_DONTNEED won't wait on the pmd lock and it'll skip clearing this
+	 * pmd.
+	 */
 	set_pmd_at(mm, mmun_start, pmd, entry);
 	update_mmu_cache_pmd(vma, address, &entry);
 
@@ -2051,7 +2062,7 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 	 * No need to double call mmu_notifier->invalidate_range() callback as
 	 * the above pmdp_huge_clear_flush_notify() did already call it.
 	 */
-	mmu_notifier_invalidate_range_only_end(mm, mmun_start, mmun_end);
+	mmu_notifier_invalidate_range_end(mm, mmun_start, mmun_end);
 
 	/* Take an "isolate" reference and put new page on the LRU. */
 	get_page(new_page);
-- 
2.17.1

