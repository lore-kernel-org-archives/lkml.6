Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11710C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CCA218F0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbfBCNuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:50:20 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53094 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728053AbfBCNtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:47 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9Z-0003tf-LT; Sun, 03 Feb 2019 13:49:45 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9X-0006vc-5b; Sun, 03 Feb 2019 14:49:43 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Chris Mason" <clm@fb.com>, "David Sterba" <dsterba@suse.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.703747316@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 084/305] Btrfs: don't clean dirty pages during
 buffered writes
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Mason <clm@fb.com>

commit 7703bdd8d23e6ef057af3253958a793ec6066b28 upstream.

During buffered writes, we follow this basic series of steps:

again:
	lock all the pages
	wait for writeback on all the pages
	Take the extent range lock
	wait for ordered extents on the whole range
	clean all the pages

	if (copy_from_user_in_atomic() hits a fault) {
		drop our locks
		goto again;
	}

	dirty all the pages
	release all the locks

The extra waiting, cleaning and locking are there to make sure we don't
modify pages in flight to the drive, after they've been crc'd.

If some of the pages in the range were already dirty when the write
began, and we need to goto again, we create a window where a dirty page
has been cleaned and unlocked.  It may be reclaimed before we're able to
lock it again, which means we'll read the old contents off the drive and
lose any modifications that had been pending writeback.

We don't actually need to clean the pages.  All of the other locking in
place makes sure we don't start IO on the pages, so we can just leave
them dirty for the duration of the write.

Fixes: 73d59314e6ed (the original btrfs merge)
Signed-off-by: Chris Mason <clm@fb.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[bwh: Backported to 3.16:
 - Keep passing additional argument of GFP_NOFS to clear_extent_bit()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -506,6 +506,16 @@ int btrfs_dirty_pages(struct btrfs_root
 	num_bytes = ALIGN(write_bytes + pos - start_pos, root->sectorsize);
 
 	end_of_last_block = start_pos + num_bytes - 1;
+
+	/*
+	 * The pages may have already been dirty, clear out old accounting so
+	 * we can set things up properly
+	 */
+	clear_extent_bit(&BTRFS_I(inode)->io_tree, start_pos, end_of_last_block,
+			 EXTENT_DIRTY | EXTENT_DELALLOC |
+			 EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG, 0, 0, cached,
+			 GFP_NOFS);
+
 	err = btrfs_set_extent_delalloc(inode, start_pos, end_of_last_block,
 					cached);
 	if (err)
@@ -1408,18 +1418,26 @@ lock_and_cleanup_extent_if_need(struct i
 		if (ordered)
 			btrfs_put_ordered_extent(ordered);
 
-		clear_extent_bit(&BTRFS_I(inode)->io_tree, start_pos,
-				  last_pos, EXTENT_DIRTY | EXTENT_DELALLOC |
-				  EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG,
-				  0, 0, cached_state, GFP_NOFS);
 		*lockstart = start_pos;
 		*lockend = last_pos;
 		ret = 1;
 	}
 
+	/*
+	 * It's possible the pages are dirty right now, but we don't want
+	 * to clean them yet because copy_from_user may catch a page fault
+	 * and we might have to fall back to one page at a time.  If that
+	 * happens, we'll unlock these pages and we'd have a window where
+	 * reclaim could sneak in and drop the once-dirty page on the floor
+	 * without writing it.
+	 *
+	 * We have the pages locked and the extent range locked, so there's
+	 * no way someone can start IO on any dirty pages in this range.
+	 *
+	 * We'll call btrfs_dirty_pages() later on, and that will flip around
+	 * delalloc bits and dirty the pages as required.
+	 */
 	for (i = 0; i < num_pages; i++) {
-		if (clear_page_dirty_for_io(pages[i]))
-			account_page_redirty(pages[i]);
 		set_page_extent_mapped(pages[i]);
 		WARN_ON(!PageLocked(pages[i]));
 	}

