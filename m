Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B99C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D0720851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="odZQQxwH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46D0720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeLDLXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:23:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:47748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727547AbeLDLCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:02:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2D92214E0;
        Tue,  4 Dec 2018 11:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921319;
        bh=0t54ZmHcDPeWFZTgC3H/F/XmUIqc1sklWTQ6jkrcjf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=odZQQxwH6nxrXZEUdUCMcQvKZMi43+nmw3wM1yutB26Myv9bgzgcOeEtyLfl1oIqv
         qcA4YUUM2n/gvf4wgprdqWxke2F+FyUvzcELRX0kRYjV3f/bt0/0YuBsMUE9Tujtof
         Fdg1O3328D1NE0aRkWEN10R6auQV7PePWMx23D0s=
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
Subject: [PATCH 4.14 004/146] mm/huge_memory: fix lockdep complaint on 32-bit i_size_read()
Date:   Tue,  4 Dec 2018 11:48:10 +0100
Message-Id: <20181204103726.948554664@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
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

commit 006d3ff27e884f80bd7d306b041afc415f63598f upstream.

Huge tmpfs testing, on 32-bit kernel with lockdep enabled, showed that
__split_huge_page() was using i_size_read() while holding the irq-safe
lru_lock and page tree lock, but the 32-bit i_size_read() uses an
irq-unsafe seqlock which should not be nested inside them.

Instead, read the i_size earlier in split_huge_page_to_list(), and pass
the end offset down to __split_huge_page(): all while holding head page
lock, which is enough to prevent truncation of that extent before the
page tree lock has been taken.

Link: http://lkml.kernel.org/r/alpine.LSU.2.11.1811261520070.2275@eggly.anvils
Fixes: baa355fd33142 ("thp: file pages support for split_huge_page()")
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
 mm/huge_memory.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 69ffeb439b0f..930f2aa3bb4d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2362,12 +2362,11 @@ static void __split_huge_page_tail(struct page *head, int tail,
 }
 
 static void __split_huge_page(struct page *page, struct list_head *list,
-		unsigned long flags)
+		pgoff_t end, unsigned long flags)
 {
 	struct page *head = compound_head(page);
 	struct zone *zone = page_zone(head);
 	struct lruvec *lruvec;
-	pgoff_t end = -1;
 	int i;
 
 	lruvec = mem_cgroup_page_lruvec(head, zone->zone_pgdat);
@@ -2375,9 +2374,6 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	/* complete memcg works before add pages to LRU */
 	mem_cgroup_split_huge_fixup(head);
 
-	if (!PageAnon(page))
-		end = DIV_ROUND_UP(i_size_read(head->mapping->host), PAGE_SIZE);
-
 	for (i = HPAGE_PMD_NR - 1; i >= 1; i--) {
 		__split_huge_page_tail(head, i, lruvec, list);
 		/* Some pages can be beyond i_size: drop them from page cache */
@@ -2549,6 +2545,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	int count, mapcount, extra_pins, ret;
 	bool mlocked;
 	unsigned long flags;
+	pgoff_t end;
 
 	VM_BUG_ON_PAGE(is_huge_zero_page(page), page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
@@ -2571,6 +2568,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 			ret = -EBUSY;
 			goto out;
 		}
+		end = -1;
 		mapping = NULL;
 		anon_vma_lock_write(anon_vma);
 	} else {
@@ -2584,6 +2582,15 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 
 		anon_vma = NULL;
 		i_mmap_lock_read(mapping);
+
+		/*
+		 *__split_huge_page() may need to trim off pages beyond EOF:
+		 * but on 32-bit, i_size_read() takes an irq-unsafe seqlock,
+		 * which cannot be nested inside the page tree lock. So note
+		 * end now: i_size itself may be changed at any moment, but
+		 * head page lock is good enough to serialize the trimming.
+		 */
+		end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE);
 	}
 
 	/*
@@ -2633,7 +2640,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		if (mapping)
 			__dec_node_page_state(page, NR_SHMEM_THPS);
 		spin_unlock(&pgdata->split_queue_lock);
-		__split_huge_page(page, list, flags);
+		__split_huge_page(page, list, end, flags);
 		if (PageSwapCache(head)) {
 			swp_entry_t entry = { .val = page_private(head) };
 
-- 
2.17.1



