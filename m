Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0558C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732312082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGYRABpy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 732312082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbeLDLN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:13:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:56714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbeLDLHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:07:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5700E2082D;
        Tue,  4 Dec 2018 11:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921655;
        bh=DkxVrxYuyzZnZetkH00MMsg8jbXaBo5o8+mKvl3mPWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fGYRABpyuZ+Hc2l856LRi6IIBBuKSc7jIJKLB0zRpcKbZy0kHR+MFpICJxl4zqRIN
         ZdrqaSktFlKeJhDjKUu69BQP8rKzM7DZe6ZpIWjtun8opi+aCOfQUeIPKEdUrEGy27
         LYA81IcqU4zY7N8dOMr6Lf0mQQuo4ZKeFFryhLTc=
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
Subject: [PATCH 4.9 01/50] mm/huge_memory: rename freeze_page() to unmap_page()
Date:   Tue,  4 Dec 2018 11:49:56 +0100
Message-Id: <20181204103714.548141343@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103714.485546262@linuxfoundation.org>
References: <20181204103714.485546262@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9f7bba700e4e..583ad61cc2f1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1839,7 +1839,7 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
 	}
 }
 
-static void freeze_page(struct page *page)
+static void unmap_page(struct page *page)
 {
 	enum ttu_flags ttu_flags = TTU_IGNORE_MLOCK | TTU_IGNORE_ACCESS |
 		TTU_RMAP_LOCKED;
@@ -1862,7 +1862,7 @@ static void freeze_page(struct page *page)
 	VM_BUG_ON_PAGE(ret, page + i - 1);
 }
 
-static void unfreeze_page(struct page *page)
+static void remap_page(struct page *page)
 {
 	int i;
 
@@ -1971,7 +1971,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 
 	spin_unlock_irqrestore(zone_lru_lock(page_zone(head)), flags);
 
-	unfreeze_page(head);
+	remap_page(head);
 
 	for (i = 0; i < HPAGE_PMD_NR; i++) {
 		struct page *subpage = head + i;
@@ -2138,7 +2138,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	}
 
 	/*
-	 * Racy check if we can split the page, before freeze_page() will
+	 * Racy check if we can split the page, before unmap_page() will
 	 * split PMDs
 	 */
 	if (total_mapcount(head) != page_count(head) - extra_pins - 1) {
@@ -2147,7 +2147,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	}
 
 	mlocked = PageMlocked(page);
-	freeze_page(head);
+	unmap_page(head);
 	VM_BUG_ON_PAGE(compound_mapcount(head), head);
 
 	/* Make sure the page is not on per-CPU pagevec as it takes pin */
@@ -2199,7 +2199,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 fail:		if (mapping)
 			spin_unlock(&mapping->tree_lock);
 		spin_unlock_irqrestore(zone_lru_lock(page_zone(head)), flags);
-		unfreeze_page(head);
+		remap_page(head);
 		ret = -EBUSY;
 	}
 
-- 
2.17.1



