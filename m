Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6DEC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED2220880
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED2220880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbeI3ESh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:18:37 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51918 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728698AbeI3ESc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:32 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N6B-0000HB-My; Sat, 29 Sep 2018 22:48:27 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5x-0006tS-4l; Sat, 29 Sep 2018 22:48:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.28558439@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 057/131] proc: drop handling non-linear mappings
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

commit 1da4b35b001481df99a6dcab12d5d39a876f7056 upstream.

We have to handle non-linear mappings for /proc/PID/{smaps,clear_refs}
which is unused now.  Let's drop it.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16:
 - Deleted code is slightly different
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -436,7 +436,6 @@ struct mem_size_stats {
 	unsigned long anonymous;
 	unsigned long anonymous_thp;
 	unsigned long swap;
-	unsigned long nonlinear;
 	u64 pss;
 };
 
@@ -446,7 +445,6 @@ static void smaps_pte_entry(pte_t ptent,
 {
 	struct mem_size_stats *mss = walk->private;
 	struct vm_area_struct *vma = mss->vma;
-	pgoff_t pgoff = linear_page_index(vma, addr);
 	struct page *page = NULL;
 	int mapcount;
 
@@ -459,9 +457,6 @@ static void smaps_pte_entry(pte_t ptent,
 			mss->swap += ptent_size;
 		else if (is_migration_entry(swpent))
 			page = migration_entry_to_page(swpent);
-	} else if (pte_file(ptent)) {
-		if (pte_to_pgoff(ptent) != pgoff)
-			mss->nonlinear += ptent_size;
 	}
 
 	if (!page)
@@ -470,9 +465,6 @@ static void smaps_pte_entry(pte_t ptent,
 	if (PageAnon(page))
 		mss->anonymous += ptent_size;
 
-	if (page->index != pgoff)
-		mss->nonlinear += ptent_size;
-
 	mss->resident += ptent_size;
 	/* Accumulate the size in pages that have been accessed. */
 	if (pte_young(ptent) || PageReferenced(page))
@@ -554,7 +546,6 @@ static void show_smap_vma_flags(struct s
 		[ilog2(VM_ACCOUNT)]	= "ac",
 		[ilog2(VM_NORESERVE)]	= "nr",
 		[ilog2(VM_HUGETLB)]	= "ht",
-		[ilog2(VM_NONLINEAR)]	= "nl",
 		[ilog2(VM_ARCH_1)]	= "ar",
 		[ilog2(VM_DONTDUMP)]	= "dd",
 #ifdef CONFIG_MEM_SOFT_DIRTY
@@ -628,10 +619,6 @@ static int show_smap(struct seq_file *m,
 		   (vma->vm_flags & VM_LOCKED) ?
 			(unsigned long)(mss.pss >> (10 + PSS_SHIFT)) : 0);
 
-	if (vma->vm_flags & VM_NONLINEAR)
-		seq_printf(m, "Nonlinear:      %8lu kB\n",
-				mss.nonlinear >> 10);
-
 	show_smap_vma_flags(m, vma);
 
 	if (m->count < m->size)  /* vma is copied successfully */
@@ -735,8 +722,6 @@ static inline void clear_soft_dirty(stru
 		ptent = pte_clear_flags(ptent, _PAGE_SOFT_DIRTY);
 	} else if (is_swap_pte(ptent)) {
 		ptent = pte_swp_clear_soft_dirty(ptent);
-	} else if (pte_file(ptent)) {
-		ptent = pte_file_clear_soft_dirty(ptent);
 	}
 
 	set_pte_at(vma->vm_mm, addr, pte, ptent);

