Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF579C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C02223DD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C02223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbeKLVxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 16:53:13 -0500
Received: from relay.sw.ru ([185.231.240.75]:43202 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729569AbeKLVxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 16:53:11 -0500
Received: from [172.16.24.163] (helo=snorch.sw.ru)
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <ptikhomirov@virtuozzo.com>)
        id 1gMAsv-0006JV-RC; Mon, 12 Nov 2018 15:00:05 +0300
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm: cleancache: fix corruption on missed inode invalidation
Date:   Mon, 12 Nov 2018 15:00:03 +0300
Message-Id: <20181112120003.23245-1-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181112113153.GC7175@quack2.suse.cz>
References: <20181112113153.GC7175@quack2.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If all pages are deleted from the mapping by memory reclaim and also
moved to the cleancache:

__delete_from_page_cache
  (no shadow case)
  unaccount_page_cache_page
    cleancache_put_page
  page_cache_delete
    mapping->nrpages -= nr
    (nrpages becomes 0)

We don't clean the cleancache for an inode after final file truncation
(removal).

truncate_inode_pages_final
  check (nrpages || nrexceptional) is false
    no truncate_inode_pages
      no cleancache_invalidate_inode(mapping)

These way when reading the new file created with same inode we may get
these trash leftover pages from cleancache and see wrong data instead of
the contents of the new file.

Fix it by always doing truncate_inode_pages which is already ready for
nrpages == 0 && nrexceptional == 0 case and just invalidates inode.

v2: add comment

Fixes: commit 91b0abe36a7b ("mm + fs: store shadow entries in page cache")
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Vasily Averin <vvs@virtuozzo.com>
Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
---
 mm/truncate.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 45d68e90b703..2c5285767ce5 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -517,9 +517,14 @@ void truncate_inode_pages_final(struct address_space *mapping)
 		 */
 		xa_lock_irq(&mapping->i_pages);
 		xa_unlock_irq(&mapping->i_pages);
-
-		truncate_inode_pages(mapping, 0);
 	}
+
+	/*
+	 * Cleancache needs notification even if there are no pages or shadow
+	 * entries, else we will leave leftover pages in the cleancache for
+	 * a deleted inode.
+	 */
+	truncate_inode_pages(mapping, 0);
 }
 EXPORT_SYMBOL(truncate_inode_pages_final);
 
-- 
2.17.1

