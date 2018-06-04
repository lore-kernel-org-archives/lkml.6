Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753859AbeFDHEx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:04:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753279AbeFDHEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:04:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Ivan Kalvachev <ikalvachev@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.16 47/47] mm: fix the NULL mapping case in __isolate_lru_page()
Date: Mon,  4 Jun 2018 08:58:59 +0200
Message-Id: <20180604065551.482797482@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065549.468488465@linuxfoundation.org>
References: <20180604065549.468488465@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hugh Dickins <hughd@google.com>

commit 145e1a71e090575c74969e3daa8136d1e5b99fc8 upstream.

George Boole would have noticed a slight error in 4.16 commit
69d763fc6d3a ("mm: pin address_space before dereferencing it while
isolating an LRU page").  Fix it, to match both the comment above it,
and the original behaviour.

Although anonymous pages are not marked PageDirty at first, we have an
old habit of calling SetPageDirty when a page is removed from swap
cache: so there's a category of ex-swap pages that are easily
migratable, but were inadvertently excluded from compaction's async
migration in 4.16.

Link: http://lkml.kernel.org/r/alpine.LSU.2.11.1805302014001.12558@eggly.anvils
Fixes: 69d763fc6d3a ("mm: pin address_space before dereferencing it while isolating an LRU page")
Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Minchan Kim <minchan@kernel.org>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Reported-by:  Ivan Kalvachev <ikalvachev@gmail.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/vmscan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1392,7 +1392,7 @@ int __isolate_lru_page(struct page *page
 				return ret;
 
 			mapping = page_mapping(page);
-			migrate_dirty = mapping && mapping->a_ops->migratepage;
+			migrate_dirty = !mapping || mapping->a_ops->migratepage;
 			unlock_page(page);
 			if (!migrate_dirty)
 				return ret;
