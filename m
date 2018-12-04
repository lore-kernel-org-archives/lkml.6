Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5A8C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715972087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKh4pjJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715972087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbeLDLLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:11:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:58534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727966AbeLDLI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:08:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 809AE214DA;
        Tue,  4 Dec 2018 11:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921736;
        bh=jADkIUU7tKslPLFky3POOsNSMWPr9qZNj/A0FvMfAkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pKh4pjJtgeShd2cWf7sneXoKekvv7rZ0pcjkq1eBLWcqBBm5QJtTQ2kftzyQTeHMR
         S4tOrPVGuLizzdoyFID2A1liop2GzdbL9c0QsYmIttB3oujMOIp0GWS/FyDlk39ypU
         L/y4U+5y+daCmdGvkA3KwStTt5vAvUZM2zI2XF8E=
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
Subject: [PATCH 4.9 04/50] mm/huge_memory: fix lockdep complaint on 32-bit i_size_read()
Date:   Tue,  4 Dec 2018 11:49:59 +0100
Message-Id: <20181204103714.706343333@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103714.485546262@linuxfoundation.org>
References: <20181204103714.485546262@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
index 5beb62fa3d30..7ea8da990b9d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1925,12 +1925,11 @@ static void __split_huge_page_tail(struct page *head, int tail,
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
@@ -1938,9 +1937,6 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	/* complete memcg works before add pages to LRU */
 	mem_cgroup_split_huge_fixup(head);
 
-	if (!PageAnon(page))
-		end = DIV_ROUND_UP(i_size_read(head->mapping->host), PAGE_SIZE);
-
 	for (i = HPAGE_PMD_NR - 1; i >= 1; i--) {
 		__split_huge_page_tail(head, i, lruvec, list);
 		/* Some pages can be beyond i_size: drop them from page cache */
@@ -2093,6 +2089,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	int count, mapcount, extra_pins, ret;
 	bool mlocked;
 	unsigned long flags;
+	pgoff_t end;
 
 	VM_BUG_ON_PAGE(is_huge_zero_page(page), page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
@@ -2114,6 +2111,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 			goto out;
 		}
 		extra_pins = 0;
+		end = -1;
 		mapping = NULL;
 		anon_vma_lock_write(anon_vma);
 	} else {
@@ -2129,6 +2127,15 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		extra_pins = HPAGE_PMD_NR;
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
@@ -2178,7 +2185,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		if (mapping)
 			__dec_node_page_state(page, NR_SHMEM_THPS);
 		spin_unlock(&pgdata->split_queue_lock);
-		__split_huge_page(page, list, flags);
+		__split_huge_page(page, list, end, flags);
 		ret = 0;
 	} else {
 		if (IS_ENABLED(CONFIG_DEBUG_VM) && mapcount) {
-- 
2.17.1



