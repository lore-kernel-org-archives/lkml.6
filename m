Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B2BC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE1920882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbfA2Xc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:32:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44456 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbfA2Xc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 18:32:28 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0D5AEC0CB577;
        Tue, 29 Jan 2019 23:32:27 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-48.ams2.redhat.com [10.36.116.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 567FB5C21A;
        Tue, 29 Jan 2019 23:32:18 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Matthew Wilcox <willy@infradead.org>,
        Vratislav Bendel <vbendel@redhat.com>,
        Rafael Aquini <aquini@redhat.com>,
        Konstantin Khlebnikov <k.khlebnikov@samsung.com>,
        Minchan Kim <minchan@kernel.org>, stable@vger.kernel.org
Subject: [PATCH v2] mm: migrate: don't rely on __PageMovable() of newpage after unlocking it
Date:   Wed, 30 Jan 2019 00:32:17 +0100
Message-Id: <20190129233217.10747-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 29 Jan 2019 23:32:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We had a race in the old balloon compaction code before commit b1123ea6d3b3
("mm: balloon: use general non-lru movable page feature") refactored it
that became visible after backporting commit 195a8c43e93d
("virtio-balloon: deflate via a page list") without the refactoring.

The bug existed from commit d6d86c0a7f8d ("mm/balloon_compaction: redesign
ballooned pages management") till commit b1123ea6d3b3 ("mm: balloon: use
general non-lru movable page feature"). commit d6d86c0a7f8d
("mm/balloon_compaction: redesign ballooned pages management") was
backported to 3.12, so the broken kernels are stable kernels [3.12 - 4.7].

There was a subtle race between dropping the page lock of the newpage
in __unmap_and_move() and checking for
__is_movable_balloon_page(newpage).

Just after dropping this page lock, virtio-balloon could go ahead and
deflate the newpage, effectively dequeueing it and clearing PageBalloon,
in turn making __is_movable_balloon_page(newpage) fail.

This resulted in dropping the reference of the newpage via
putback_lru_page(newpage) instead of put_page(newpage), leading to
page->lru getting modified and a !LRU page ending up in the LRU lists.
With commit 195a8c43e93d ("virtio-balloon: deflate via a page list")
backported, one would suddenly get corrupted lists in
release_pages_balloon():
- WARNING: CPU: 13 PID: 6586 at lib/list_debug.c:59 __list_del_entry+0xa1/0xd0
- list_del corruption. prev->next should be ffffe253961090a0, but was dead000000000100

Nowadays this race is no longer possible, but it is hidden behind very
ugly handling of __ClearPageMovable() and __PageMovable().

__ClearPageMovable() will not make __PageMovable() fail, only
PageMovable(). So the new check (__PageMovable(newpage)) will still hold
even after newpage was dequeued by virtio-balloon.

If anybody would ever change that special handling, the BUG would be
introduced again. So instead, make it explicit and use the information
of the original isolated page before migration.

This patch can be backported fairly easy to stable kernels (in contrast
to the refactoring).

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Vratislav Bendel <vbendel@redhat.com>
Cc: Rafael Aquini <aquini@redhat.com>
Cc: Konstantin Khlebnikov <k.khlebnikov@samsung.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: stable@vger.kernel.org # 3.12 - 4.7
Fixes: d6d86c0a7f8d ("mm/balloon_compaction: redesign ballooned pages management")
Reported-by: Vratislav Bendel <vbendel@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Rafael Aquini <aquini@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/migrate.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 4512afab46ac..402198816d1a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1135,10 +1135,13 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 	 * If migration is successful, decrease refcount of the newpage
 	 * which will not free the page because new page owner increased
 	 * refcounter. As well, if it is LRU page, add the page to LRU
-	 * list in here.
+	 * list in here. Use the old state of the isolated source page to
+	 * determine if we migrated a LRU page. newpage was already unlocked
+	 * and possibly modified by its owner - don't rely on the page
+	 * state.
 	 */
 	if (rc == MIGRATEPAGE_SUCCESS) {
-		if (unlikely(__PageMovable(newpage)))
+		if (unlikely(!is_lru))
 			put_page(newpage);
 		else
 			putback_lru_page(newpage);
-- 
2.17.2

