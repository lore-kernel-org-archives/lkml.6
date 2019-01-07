Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE973C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9586B2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865837;
	bh=PVmZp9BPgPEiT66bAMCwztngdbI2n7DRxDG2HrXjzio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kVSjQRcHoYVggJLgsoze5EmxNtVX0GC9tO/sU9fd1T8wKQAJhBxLd8Ywf5m+uBHLH
	 5KMAOmzBG45hyfScmULQ9PlWd4gUY+fr89NAQvIzMEXbB0Hp33pf9ziYtVdSbqETAm
	 bzDSpwAjck1omLbYn4oGenaLM+gYCeJa+Xe6h9bk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbfAGM5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:57:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:44906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729026AbfAGM5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:57:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C7C9206BB;
        Mon,  7 Jan 2019 12:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865831;
        bh=PVmZp9BPgPEiT66bAMCwztngdbI2n7DRxDG2HrXjzio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1sYe0vQPVEe/0dOVKe78NVh9pAOLD/ZIoGxXNMVxfsXi1oGjMcJUxXMQdUR8oJgJd
         nrtzPrY9RY0YjqHv9b6XQR9nNhjTfhJKxGr2yTPnPXEiLM6UH8HXnG4pHFG3euUfiy
         I+h6v0cVnLcwxxudB1u5gtqMkaCefMWyeim8/kpI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 131/170] Btrfs: send, fix race with transaction commits that create snapshots
Date:   Mon,  7 Jan 2019 13:32:38 +0100
Message-Id: <20190107104508.415449636@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit be6821f82c3cc36e026f5afd10249988852b35ea upstream.

If we create a snapshot of a snapshot currently being used by a send
operation, we can end up with send failing unexpectedly (returning
-ENOENT error to user space for example). The following diagram shows
how this happens.

            CPU 1                                   CPU2                                CPU3

 btrfs_ioctl_send()
  (...)
                                     create_snapshot()
                                      -> creates snapshot of a
                                         root used by the send
                                         task
                                      btrfs_commit_transaction()
                                       create_pending_snapshot()
  __get_inode_info()
   btrfs_search_slot()
    btrfs_search_slot_get_root()
     down_read commit_root_sem

     get reference on eb of the
     commit root
      -> eb with bytenr == X

     up_read commit_root_sem

                                        btrfs_cow_block(root node)
                                         btrfs_free_tree_block()
                                          -> creates delayed ref to
                                             free the extent

                                       btrfs_run_delayed_refs()
                                        -> runs the delayed ref,
                                           adds extent to
                                           fs_info->pinned_extents

                                       btrfs_finish_extent_commit()
                                        unpin_extent_range()
                                         -> marks extent as free
                                            in the free space cache

                                      transaction commit finishes

                                                                       btrfs_start_transaction()
                                                                        (...)
                                                                        btrfs_cow_block()
                                                                         btrfs_alloc_tree_block()
                                                                          btrfs_reserve_extent()
                                                                           -> allocates extent at
                                                                              bytenr == X
                                                                          btrfs_init_new_buffer(bytenr X)
                                                                           btrfs_find_create_tree_block()
                                                                            alloc_extent_buffer(bytenr X)
                                                                             find_extent_buffer(bytenr X)
                                                                              -> returns existing eb,
                                                                                 which the send task got

                                                                        (...)
                                                                         -> modifies content of the
                                                                            eb with bytenr == X

    -> uses an eb that now
       belongs to some other
       tree and no more matches
       the commit root of the
       snapshot, resuts will be
       unpredictable

The consequences of this race can be various, and can lead to searches in
the commit root performed by the send task failing unexpectedly (unable to
find inode items, returning -ENOENT to user space, for example) or not
failing because an inode item with the same number was added to the tree
that reused the metadata extent, in which case send can behave incorrectly
in the worst case or just fail later for some reason.

Fix this by performing a copy of the commit root's extent buffer when doing
a search in the context of a send operation.

CC: stable@vger.kernel.org # 4.4.x: 1fc28d8e2e9: Btrfs: move get root out of btrfs_search_slot to a helper
CC: stable@vger.kernel.org # 4.4.x: f9ddfd0592a: Btrfs: remove unused check of skip_locking
CC: stable@vger.kernel.org # 4.4.x
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/ctree.c |   29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2624,14 +2624,27 @@ static struct extent_buffer *btrfs_searc
 	root_lock = BTRFS_READ_LOCK;
 
 	if (p->search_commit_root) {
-		/* The commit roots are read only so we always do read locks */
-		if (p->need_commit_sem)
+		/*
+		 * The commit roots are read only so we always do read locks,
+		 * and we always must hold the commit_root_sem when doing
+		 * searches on them, the only exception is send where we don't
+		 * want to block transaction commits for a long time, so
+		 * we need to clone the commit root in order to avoid races
+		 * with transaction commits that create a snapshot of one of
+		 * the roots used by a send operation.
+		 */
+		if (p->need_commit_sem) {
 			down_read(&fs_info->commit_root_sem);
-		b = root->commit_root;
-		extent_buffer_get(b);
-		level = btrfs_header_level(b);
-		if (p->need_commit_sem)
+			b = btrfs_clone_extent_buffer(root->commit_root);
 			up_read(&fs_info->commit_root_sem);
+			if (!b)
+				return ERR_PTR(-ENOMEM);
+
+		} else {
+			b = root->commit_root;
+			extent_buffer_get(b);
+		}
+		level = btrfs_header_level(b);
 		/*
 		 * Ensure that all callers have set skip_locking when
 		 * p->search_commit_root = 1.
@@ -2757,6 +2770,10 @@ int btrfs_search_slot(struct btrfs_trans
 again:
 	prev_cmp = -1;
 	b = btrfs_search_slot_get_root(root, p, write_lock_level);
+	if (IS_ERR(b)) {
+		ret = PTR_ERR(b);
+		goto done;
+	}
 
 	while (b) {
 		level = btrfs_header_level(b);


