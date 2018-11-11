Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662C7C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320D820872
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVfFldpX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 320D820872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387423AbeKLJit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:38:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:38896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733073AbeKLISn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:43 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0655921582;
        Sun, 11 Nov 2018 22:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975327;
        bh=zuwDMMBiaKJ+nIOjehGjTSrpcotekcLCqWkcV2adCHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eVfFldpXXZ/Pd1MsqCzozZ86GyICmy3Y/Xt4gucXUbfhg6ZuU9Y1n5dG/y56Dsd1i
         f9HciSucjL8h+yrJoARQ/IFwoT0BA0+oFYVOIqPgKn/oKsDQryO+A0H53pzS4YllJI
         CySp4KdLo65IdTEkzn0orD/J6lo3ku8i0jeJBkV8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 337/361] Btrfs: dont clean dirty pages during buffered writes
Date:   Sun, 11 Nov 2018 14:21:24 -0800
Message-Id: <20181111221700.394979909@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

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
CC: stable@vger.kernel.org # v4.4+
Signed-off-by: Chris Mason <clm@fb.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/file.c |   29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -531,6 +531,14 @@ int btrfs_dirty_pages(struct inode *inod
 
 	end_of_last_block = start_pos + num_bytes - 1;
 
+	/*
+	 * The pages may have already been dirty, clear out old accounting so
+	 * we can set things up properly
+	 */
+	clear_extent_bit(&BTRFS_I(inode)->io_tree, start_pos, end_of_last_block,
+			 EXTENT_DIRTY | EXTENT_DELALLOC |
+			 EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG, 0, 0, cached);
+
 	if (!btrfs_is_free_space_inode(BTRFS_I(inode))) {
 		if (start_pos >= isize &&
 		    !(BTRFS_I(inode)->flags & BTRFS_INODE_PREALLOC)) {
@@ -1500,18 +1508,27 @@ lock_and_cleanup_extent_if_need(struct b
 		}
 		if (ordered)
 			btrfs_put_ordered_extent(ordered);
-		clear_extent_bit(&inode->io_tree, start_pos, last_pos,
-				 EXTENT_DIRTY | EXTENT_DELALLOC |
-				 EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG,
-				 0, 0, cached_state);
+
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


