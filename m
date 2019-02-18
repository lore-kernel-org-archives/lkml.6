Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAB2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2741221736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550500734;
	bh=TC74ZQxgvfw/3hjT7lDcK9BhTObZrKIUuwkivQ74oTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LB5CVa6P6dUdIASHUbhXIyzhIjZ5bTQn+DUgbjX8Ny9/n7HUoOFuMYYyDEf4IT/7J
	 zcCr7tJ6UEOqwGmmv6QpLkIM07ke1PwLDAu4OQNEWdTeWbrMXGPdkwjZ4coF0erCf7
	 b8oSBCMb7ZBYArV3/XxdULi+xHyFx8qmi2tc+V5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733031AbfBRNxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:53:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:33482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732667AbfBRNxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:53:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 627B321901;
        Mon, 18 Feb 2019 13:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498022;
        bh=TC74ZQxgvfw/3hjT7lDcK9BhTObZrKIUuwkivQ74oTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xnJ14NeMzV0uAHCfo7NG2iu5RHLn/DboejIQDs6FJJdeITcWMi0I3eO/XDqrymQB8
         KBp34nP556yxP0TQG29c7PF0EZ0exlOFTl25aXTRdqUbqoJgCkFA2jY59Ficew8gKx
         I/01aLE6ryyVUFoil3hh07NPLjN4UXZcGcXcVK/E=
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
Subject: [PATCH 4.19 85/85] mm: proc: smaps_rollup: fix pss_locked calculation
Date:   Mon, 18 Feb 2019 14:43:51 +0100
Message-Id: <20190218133508.155800483@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133459.758004711@linuxfoundation.org>
References: <20190218133459.758004711@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -423,7 +423,7 @@ struct mem_size_stats {
 };
 
 static void smaps_account(struct mem_size_stats *mss, struct page *page,
-		bool compound, bool young, bool dirty)
+		bool compound, bool young, bool dirty, bool locked)
 {
 	int i, nr = compound ? 1 << compound_order(page) : 1;
 	unsigned long size = nr * PAGE_SIZE;
@@ -450,24 +450,31 @@ static void smaps_account(struct mem_siz
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
@@ -490,6 +497,7 @@ static void smaps_pte_entry(pte_t *pte,
 {
 	struct mem_size_stats *mss = walk->private;
 	struct vm_area_struct *vma = walk->vma;
+	bool locked = !!(vma->vm_flags & VM_LOCKED);
 	struct page *page = NULL;
 
 	if (pte_present(*pte)) {
@@ -532,7 +540,7 @@ static void smaps_pte_entry(pte_t *pte,
 	if (!page)
 		return;
 
-	smaps_account(mss, page, false, pte_young(*pte), pte_dirty(*pte));
+	smaps_account(mss, page, false, pte_young(*pte), pte_dirty(*pte), locked);
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -541,6 +549,7 @@ static void smaps_pmd_entry(pmd_t *pmd,
 {
 	struct mem_size_stats *mss = walk->private;
 	struct vm_area_struct *vma = walk->vma;
+	bool locked = !!(vma->vm_flags & VM_LOCKED);
 	struct page *page;
 
 	/* FOLL_DUMP will return -EFAULT on huge zero page */
@@ -555,7 +564,7 @@ static void smaps_pmd_entry(pmd_t *pmd,
 		/* pass */;
 	else
 		VM_BUG_ON_PAGE(1, page);
-	smaps_account(mss, page, true, pmd_young(*pmd), pmd_dirty(*pmd));
+	smaps_account(mss, page, true, pmd_young(*pmd), pmd_dirty(*pmd), locked);
 }
 #else
 static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
@@ -737,11 +746,8 @@ static void smap_gather_stats(struct vm_
 		}
 	}
 #endif
-
 	/* mmap_sem is held in m_start */
 	walk_page_vma(vma, &smaps_walk);
-	if (vma->vm_flags & VM_LOCKED)
-		mss->pss_locked += mss->pss;
 }
 
 #define SEQ_PUT_DEC(str, val) \


