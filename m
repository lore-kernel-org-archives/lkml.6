Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABCCC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E486420661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E486420661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbeLIVzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:55:47 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35572 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726577AbeLIVz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:27 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72q-0002pr-G9; Sun, 09 Dec 2018 21:55:24 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72l-0003hi-TS; Sun, 09 Dec 2018 21:55:19 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Andi Kleen" <ak@linux.intel.com>,
        "Jan Kara" <jack@suse.cz>, "Johannes Weiner" <hannes@cmpxchg.org>,
        "Andrey Ryabinin" <aryabinin@virtuozzo.com>,
        "Vasily Averin" <vvs@virtuozzo.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Mel Gorman" <mgorman@techsingularity.net>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Pavel Tikhomirov" <ptikhomirov@virtuozzo.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.880695492@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 325/328] mm: cleancache: fix corruption on missed
 inode invalidation
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

commit 6ff38bd40230af35e446239396e5fc8ebd6a5248 upstream.

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

[akpm@linux-foundation.org: add comment, per Jan]
Link: http://lkml.kernel.org/r/20181112095734.17979-1-ptikhomirov@virtuozzo.com
Fixes: commit 91b0abe36a7b ("mm + fs: store shadow entries in page cache")
Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Reviewed-by: Vasily Averin <vvs@virtuozzo.com>
Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 mm/truncate.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -461,9 +461,13 @@ void truncate_inode_pages_final(struct a
 		 */
 		spin_lock_irq(&mapping->tree_lock);
 		spin_unlock_irq(&mapping->tree_lock);
-
-		truncate_inode_pages(mapping, 0);
 	}
+
+	/*
+	 * Cleancache needs notification even if there are no pages or shadow
+	 * entries.
+	 */
+	truncate_inode_pages(mapping, 0);
 }
 EXPORT_SYMBOL(truncate_inode_pages_final);
 

