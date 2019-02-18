Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AB0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7770217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498241;
	bh=yAeS96iylfWdmJ4tGBG9c3Mi38g3VUpkYo42rE46zHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VA2o3MOQrm1BFqy8zu/49n53+UxBEQg1MCORZINHvXxyZUv0PnQiJT574nUFDAOC5
	 LNndUWtIEO66979hO/ILD9lNSsTWrW5COpvWk5V6oOnH8/LMnYcV+EYC75tknrTSyW
	 2hWd1Evlw+bbOYQdOVsVkblHxOUY8x0SHR7cZRiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388003AbfBRN5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:57:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:37598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733067AbfBRN5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:57:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C210217D9;
        Mon, 18 Feb 2019 13:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498232;
        bh=yAeS96iylfWdmJ4tGBG9c3Mi38g3VUpkYo42rE46zHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uTP7bp2jIyf4Rh2EpTwKrXI3Ks6GBQG/9WfqVrhTzN/rRv/sIBgprIPw9U6OE/TKz
         lwtVGZkXtDvGi1kweZCJM9ehcgQSW5G7XMif8oluXefr9clL7zVoDOdWnmg0bQjRnA
         5O9ocYI1PSTjEVRdKrG4jz5S0PPwZ9PM/Jwo1D1c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sandeep Patil <sspatil@android.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 49/62] mm: proc: smaps_rollup: fix pss_locked calculation
Date:   Mon, 18 Feb 2019 14:43:55 +0100
Message-Id: <20190218133510.004172041@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133505.801423074@linuxfoundation.org>
References: <20190218133505.801423074@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sandeep Patil <sspatil@android.com>

commit 27dd768ed8db48beefc4d9e006c58e7a00342bde upstream.

The 'pss_locked' field of smaps_rollup was being calculated incorrectly.
It accumulated the current pss everytime a locked VMA was found.  Fix
that by adding to 'pss_locked' the same time as that of 'pss' if the vma
being walked is locked.

Link: http://lkml.kernel.org/r/20190203065425.14650-1-sspatil@android.com
Fixes: 493b0e9d945f ("mm: add /proc/pid/smaps_rollup")
Signed-off-by: Sandeep Patil <sspatil@android.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Daniel Colascione <dancol@google.com>
Cc: <stable@vger.kernel.org>	[4.14.x, 4.19.x]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/proc/task_mmu.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -459,7 +459,7 @@ struct mem_size_stats {
 };
 
 static void smaps_account(struct mem_size_stats *mss, struct page *page,
-		bool compound, bool young, bool dirty)
+		bool compound, bool young, bool dirty, bool locked)
 {
 	int i, nr = compound ? 1 << compound_order(page) : 1;
 	unsigned long size = nr * PAGE_SIZE;
@@ -486,24 +486,31 @@ static void smaps_account(struct mem_siz
 		else
 			mss->private_clean += size;
 		mss->pss += (u64)size << PSS_SHIFT;
+		if (locked)
+			mss->pss_locked += (u64)size << PSS_SHIFT;
 		return;
 	}
 
 	for (i = 0; i < nr; i++, page++) {
 		int mapcount = page_mapcount(page);
+		unsigned long pss = (PAGE_SIZE << PSS_SHIFT);
 
 		if (mapcount >= 2) {
 			if (dirty || PageDirty(page))
 				mss->shared_dirty += PAGE_SIZE;
 			else
 				mss->shared_clean += PAGE_SIZE;
-			mss->pss += (PAGE_SIZE << PSS_SHIFT) / mapcount;
+			mss->pss += pss / mapcount;
+			if (locked)
+				mss->pss_locked += pss / mapcount;
 		} else {
 			if (dirty || PageDirty(page))
 				mss->private_dirty += PAGE_SIZE;
 			else
 				mss->private_clean += PAGE_SIZE;
-			mss->pss += PAGE_SIZE << PSS_SHIFT;
+			mss->pss += pss;
+			if (locked)
+				mss->pss_locked += pss;
 		}
 	}
 }
@@ -526,6 +533,7 @@ static void smaps_pte_entry(pte_t *pte,
 {
 	struct mem_size_stats *mss = walk->private;
 	struct vm_area_struct *vma = walk->vma;
+	bool locked = !!(vma->vm_flags & VM_LOCKED);
 	struct page *page = NULL;
 
 	if (pte_present(*pte)) {
@@ -568,7 +576,7 @@ static void smaps_pte_entry(pte_t *pte,
 	if (!page)
 		return;
 
-	smaps_account(mss, page, false, pte_young(*pte), pte_dirty(*pte));
+	smaps_account(mss, page, false, pte_young(*pte), pte_dirty(*pte), locked);
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -577,6 +585,7 @@ static void smaps_pmd_entry(pmd_t *pmd,
 {
 	struct mem_size_stats *mss = walk->private;
 	struct vm_area_struct *vma = walk->vma;
+	bool locked = !!(vma->vm_flags & VM_LOCKED);
 	struct page *page;
 
 	/* FOLL_DUMP will return -EFAULT on huge zero page */
@@ -591,7 +600,7 @@ static void smaps_pmd_entry(pmd_t *pmd,
 		/* pass */;
 	else
 		VM_BUG_ON_PAGE(1, page);
-	smaps_account(mss, page, true, pmd_young(*pmd), pmd_dirty(*pmd));
+	smaps_account(mss, page, true, pmd_young(*pmd), pmd_dirty(*pmd), locked);
 }
 #else
 static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
@@ -792,11 +801,8 @@ static int show_smap(struct seq_file *m,
 		}
 	}
 #endif
-
 	/* mmap_sem is held in m_start */
 	walk_page_vma(vma, &smaps_walk);
-	if (vma->vm_flags & VM_LOCKED)
-		mss->pss_locked += mss->pss;
 
 	if (!rollup_mode) {
 		show_map_vma(m, vma, is_pid);


