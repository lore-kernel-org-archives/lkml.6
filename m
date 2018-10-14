Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F54C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F4020645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F4020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbeJNXXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:23:15 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36922 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728030AbeJNXXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:23:15 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiM0-0004cA-G7; Sun, 14 Oct 2018 16:30:52 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLU-0000O5-25; Sun, 14 Oct 2018 16:30:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Matthew Wilcox" <mawilcox@microsoft.com>,
        "Chris Fries" <cfries@google.com>,
        "Michal Hocko" <mhocko@suse.com>, "Jan Kara" <jack@suse.cz>,
        "Johannes Weiner" <hannes@cmpxchg.org>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.923997029@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 182/366] mm/filemap.c: fix NULL pointer in
 page_cache_tree_insert()
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Wilcox <mawilcox@microsoft.com>

commit abc1be13fd113ddef5e2d807a466286b864caed3 upstream.

f2fs specifies the __GFP_ZERO flag for allocating some of its pages.
Unfortunately, the page cache also uses the mapping's GFP flags for
allocating radix tree nodes.  It always masked off the __GFP_HIGHMEM
flag, and masks off __GFP_ZERO in some paths, but not all.  That causes
radix tree nodes to be allocated with a NULL list_head, which causes
backtraces like:

  __list_del_entry+0x30/0xd0
  list_lru_del+0xac/0x1ac
  page_cache_tree_insert+0xd8/0x110

The __GFP_DMA and __GFP_DMA32 flags would also be able to sneak through
if they are ever used.  Fix them all by using GFP_RECLAIM_MASK at the
innermost location, and remove it from earlier in the callchain.

Link: http://lkml.kernel.org/r/20180411060320.14458-2-willy@infradead.org
Fixes: 449dd6984d0e ("mm: keep page cache radix tree nodes in check")
Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
Reported-by: Chris Fries <cfries@google.com>
Debugged-by: Minchan Kim <minchan@kernel.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16:
 - Drop change in page_cache_read(), which always passes GFP_KERNEL
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -529,7 +529,7 @@ int replace_page_cache_page(struct page
 	VM_BUG_ON_PAGE(!PageLocked(new), new);
 	VM_BUG_ON_PAGE(new->mapping, new);
 
-	error = radix_tree_preload(gfp_mask & ~__GFP_HIGHMEM);
+	error = radix_tree_preload(gfp_mask & GFP_RECLAIM_MASK);
 	if (!error) {
 		struct address_space *mapping = old->mapping;
 		void (*freepage)(struct page *);
@@ -576,7 +576,7 @@ static int __add_to_page_cache_locked(st
 	if (error)
 		return error;
 
-	error = radix_tree_maybe_preload(gfp_mask & ~__GFP_HIGHMEM);
+	error = radix_tree_maybe_preload(gfp_mask & GFP_RECLAIM_MASK);
 	if (error) {
 		mem_cgroup_uncharge_cache_page(page);
 		return error;
@@ -1111,8 +1111,7 @@ no_page:
 		if (fgp_flags & FGP_ACCESSED)
 			init_page_accessed(page);
 
-		err = add_to_page_cache_lru(page, mapping, offset,
-				gfp_mask & GFP_RECLAIM_MASK);
+		err = add_to_page_cache_lru(page, mapping, offset, gfp_mask);
 		if (unlikely(err)) {
 			page_cache_release(page);
 			page = NULL;

