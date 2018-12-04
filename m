Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10BBC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B622087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="buUsTaYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B622087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbeLDKzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:55:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:37956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbeLDKzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:55:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F38020878;
        Tue,  4 Dec 2018 10:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543920914;
        bh=o/3UjfKQBy9qqirgytoWIwUXoMCeek3R1BcTPkDkunU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=buUsTaYv3hQIjfozhZJpwwwO+C5o/YguOxhkpNZg1Z9tt5ruVmD7nyxrJ/X0PAcn7
         Ukogp2VWHSyIKAjKYCsrsZGcNIjAuk3J6VTJzDS1vysfkDXnPChTEy15jpcjGcf4Zp
         jzD36Qje87TV8IkUwjjq2NrgfmtGuWEc6nA0Syoc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 001/139] mm/huge_memory: rename freeze_page() to unmap_page()
Date:   Tue,  4 Dec 2018 11:48:02 +0100
Message-Id: <20181204103650.008125728@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 906f9cdfc2a0800f13683f9e4ebdfd08c12ee81b upstream.

The term "freeze" is used in several ways in the kernel, and in mm it
has the particular meaning of forcing page refcount temporarily to 0.
freeze_page() is just too confusing a name for a function that unmaps a
page: rename it unmap_page(), and rename unfreeze_page() remap_page().

Went to change the mention of freeze_page() added later in mm/rmap.c,
but found it to be incorrect: ordinary page reclaim reaches there too;
but the substance of the comment still seems correct, so edit it down.

Link: http://lkml.kernel.org/r/alpine.LSU.2.11.1811261514080.2275@eggly.anvils
Fixes: e9b61f19858a5 ("thp: reintroduce split_huge_page()")
Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Jerome Glisse <jglisse@redhat.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: <stable@vger.kernel.org>	[4.8+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/huge_memory.c | 12 ++++++------
 mm/rmap.c        | 13 +++----------
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index deed97fba979..ef573d719eb4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2322,7 +2322,7 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
 	}
 }
 
-static void freeze_page(struct page *page)
+static void unmap_page(struct page *page)
 {
 	enum ttu_flags ttu_flags = TTU_IGNORE_MLOCK | TTU_IGNORE_ACCESS |
 		TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD;
@@ -2337,7 +2337,7 @@ static void freeze_page(struct page *page)
 	VM_BUG_ON_PAGE(!unmap_success, page);
 }
 
-static void unfreeze_page(struct page *page)
+static void remap_page(struct page *page)
 {
 	int i;
 	if (PageTransHuge(page)) {
@@ -2454,7 +2454,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 
 	spin_unlock_irqrestore(zone_lru_lock(page_zone(head)), flags);
 
-	unfreeze_page(head);
+	remap_page(head);
 
 	for (i = 0; i < HPAGE_PMD_NR; i++) {
 		struct page *subpage = head + i;
@@ -2635,7 +2635,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	}
 
 	/*
-	 * Racy check if we can split the page, before freeze_page() will
+	 * Racy check if we can split the page, before unmap_page() will
 	 * split PMDs
 	 */
 	if (!can_split_huge_page(head, &extra_pins)) {
@@ -2644,7 +2644,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	}
 
 	mlocked = PageMlocked(page);
-	freeze_page(head);
+	unmap_page(head);
 	VM_BUG_ON_PAGE(compound_mapcount(head), head);
 
 	/* Make sure the page is not on per-CPU pagevec as it takes pin */
@@ -2701,7 +2701,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 fail:		if (mapping)
 			xa_unlock(&mapping->i_pages);
 		spin_unlock_irqrestore(zone_lru_lock(page_zone(head)), flags);
-		unfreeze_page(head);
+		remap_page(head);
 		ret = -EBUSY;
 	}
 
diff --git a/mm/rmap.c b/mm/rmap.c
index 1e79fac3186b..85b7f9423352 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1627,16 +1627,9 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 						      address + PAGE_SIZE);
 		} else {
 			/*
-			 * We should not need to notify here as we reach this
-			 * case only from freeze_page() itself only call from
-			 * split_huge_page_to_list() so everything below must
-			 * be true:
-			 *   - page is not anonymous
-			 *   - page is locked
-			 *
-			 * So as it is a locked file back page thus it can not
-			 * be remove from the page cache and replace by a new
-			 * page before mmu_notifier_invalidate_range_end so no
+			 * This is a locked file-backed page, thus it cannot
+			 * be removed from the page cache and replaced by a new
+			 * page before mmu_notifier_invalidate_range_end, so no
 			 * concurrent thread might update its page table to
 			 * point at new page while a device still is using this
 			 * page.
-- 
2.17.1



