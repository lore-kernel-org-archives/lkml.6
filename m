Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57F9C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE56207E0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549278685;
	bh=QMAYWQ+Y5sITw0PEWN0KbN0Pwg98aGU6tJdJtbcRqd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kwm6bqtB55jVmI/wmarrYRwJiuOzYBZSC3p9zPrqsxS/cmZkwQeeDwiJlLV+Wfn6k
	 R+aRfVTIDs8M3U2fJZ65Cpb0l16EIaevtdwGIe16A9sWCn4mz6zsspNjMLHfkPHRI3
	 CXPLDSEked/DVs36zH+F4qWglVh3I1BqD6nuV/pw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbfBDLLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:11:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:37398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727650AbfBDKjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:39:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94EE62070C;
        Mon,  4 Feb 2019 10:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276764;
        bh=QMAYWQ+Y5sITw0PEWN0KbN0Pwg98aGU6tJdJtbcRqd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iX39yvpxgO8qwA8jzNa60ThVAYEklHwqlhot6h0wggx2YT8P+0IyviD5UDLnl4Iuy
         cK1toBUlF3m64MqcERDisiS/tBMsCdcFU/f22H80fbcAuMoF1jrkemzCczyeQRFocd
         RuwFtDoruC9W83ZV5kWXDr6FWIx9PUdwB73iafpI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Vratislav Bendel <vbendel@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Rafael Aquini <aquini@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Matthew Wilcox <willy@infradead.org>,
        Konstantin Khlebnikov <k.khlebnikov@samsung.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3.18 31/31] mm: migrate: dont rely on __PageMovable() of newpage after unlocking it
Date:   Mon,  4 Feb 2019 11:36:46 +0100
Message-Id: <20190204103604.510009530@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103557.903263774@linuxfoundation.org>
References: <20190204103557.903263774@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Hildenbrand <david@redhat.com>

commit e0a352fabce61f730341d119fbedf71ffdb8663f upstream.

We had a race in the old balloon compaction code before b1123ea6d3b3
("mm: balloon: use general non-lru movable page feature") refactored it
that became visible after backporting 195a8c43e93d ("virtio-balloon:
deflate via a page list") without the refactoring.

The bug existed from commit d6d86c0a7f8d ("mm/balloon_compaction:
redesign ballooned pages management") till b1123ea6d3b3 ("mm: balloon:
use general non-lru movable page feature").  d6d86c0a7f8d
("mm/balloon_compaction: redesign ballooned pages management") was
backported to 3.12, so the broken kernels are stable kernels [3.12 -
4.7].

There was a subtle race between dropping the page lock of the newpage in
__unmap_and_move() and checking for __is_movable_balloon_page(newpage).

Just after dropping this page lock, virtio-balloon could go ahead and
deflate the newpage, effectively dequeueing it and clearing PageBalloon,
in turn making __is_movable_balloon_page(newpage) fail.

This resulted in dropping the reference of the newpage via
putback_lru_page(newpage) instead of put_page(newpage), leading to
page->lru getting modified and a !LRU page ending up in the LRU lists.
With 195a8c43e93d ("virtio-balloon: deflate via a page list")
backported, one would suddenly get corrupted lists in
release_pages_balloon():

- WARNING: CPU: 13 PID: 6586 at lib/list_debug.c:59 __list_del_entry+0xa1/0xd0
- list_del corruption. prev->next should be ffffe253961090a0, but was dead000000000100

Nowadays this race is no longer possible, but it is hidden behind very
ugly handling of __ClearPageMovable() and __PageMovable().

__ClearPageMovable() will not make __PageMovable() fail, only
PageMovable().  So the new check (__PageMovable(newpage)) will still
hold even after newpage was dequeued by virtio-balloon.

If anybody would ever change that special handling, the BUG would be
introduced again.  So instead, make it explicit and use the information
of the original isolated page before migration.

This patch can be backported fairly easy to stable kernels (in contrast
to the refactoring).

Link: http://lkml.kernel.org/r/20190129233217.10747-1-david@redhat.com
Fixes: d6d86c0a7f8d ("mm/balloon_compaction: redesign ballooned pages management")
Signed-off-by: David Hildenbrand <david@redhat.com>
Reported-by: Vratislav Bendel <vbendel@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Rafael Aquini <aquini@redhat.com>
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
Cc: <stable@vger.kernel.org>	[3.12 - 4.7]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/migrate.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -943,6 +943,7 @@ static int unmap_and_move(new_page_t get
 	int rc = 0;
 	int *result = NULL;
 	struct page *newpage = get_new_page(page, private, &result);
+	bool is_lru = !isolated_balloon_page(page);
 
 	if (!newpage)
 		return -ENOMEM;
@@ -975,12 +976,14 @@ out:
 	/*
 	 * If migration was not successful and there's a freeing callback, use
 	 * it.  Otherwise, putback_lru_page() will drop the reference grabbed
-	 * during isolation.
+	 * during isolation. Use the old state of the isolated source page to
+	 * determine if we migrated a LRU page. newpage was already unlocked
+	 * and possibly modified by its owner - don't rely on the page state.
 	 */
 	if (rc != MIGRATEPAGE_SUCCESS && put_new_page) {
 		ClearPageSwapBacked(newpage);
 		put_new_page(newpage, private);
-	} else if (unlikely(__is_movable_balloon_page(newpage))) {
+	} else if (rc == MIGRATEPAGE_SUCCESS && unlikely(!is_lru)) {
 		/* drop our reference, page already in the balloon */
 		put_page(newpage);
 	} else


