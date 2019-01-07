Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17960C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D328D206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865829;
	bh=MRGctBwpvb4QyUrmZomdGmVfkQ362hqLbp+qcdU4EPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NOaEV7MBUqiPi8s/zk98ESbtRGprxPETNSll/4KQQg9bdafMzReJOIwCqpZtHy5zN
	 OyuhtaCgmiQPWYvCUhiJQrf5HCo2XPM1p40H1twowZjI6PHrW8NRPKX4bmnE+glo2h
	 zUB05aG+5dQaH6MEA+h/qy6wYXzAjZKo+A4KLszw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbfAGM5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:57:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:44864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729026AbfAGM5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:57:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C6C4206BB;
        Mon,  7 Jan 2019 12:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865824;
        bh=MRGctBwpvb4QyUrmZomdGmVfkQ362hqLbp+qcdU4EPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0nBJIkPCR/w4VJKXHmiSDi/PraCE1IkKeW9mMepFxgNW2MU8H9+UNW76xI+Pnhw+a
         Pge8YI1sZ4hhp5X9nOjZHpqjaGXSAQxeRzOGxtGExtBO/sHLyCw9s2/b9Dk5lTSKWt
         vsag0qKBdRItI9aJp7Ot/JG4/YAXc9U1SL1Y3JCk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 130/170] btrfs: run delayed items before dropping the snapshot
Date:   Mon,  7 Jan 2019 13:32:37 +0100
Message-Id: <20190107104508.307476777@linuxfoundation.org>
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

From: Josef Bacik <jbacik@fb.com>

commit 0568e82dbe2510fc1fa664f58e5c997d3f1e649e upstream.

With my delayed refs patches in place we started seeing a large amount
of aborts in __btrfs_free_extent:

 BTRFS error (device sdb1): unable to find ref byte nr 91947008 parent 0 root 35964  owner 1 offset 0
 Call Trace:
  ? btrfs_merge_delayed_refs+0xaf/0x340
  __btrfs_run_delayed_refs+0x6ea/0xfc0
  ? btrfs_set_path_blocking+0x31/0x60
  btrfs_run_delayed_refs+0xeb/0x180
  btrfs_commit_transaction+0x179/0x7f0
  ? btrfs_check_space_for_delayed_refs+0x30/0x50
  ? should_end_transaction.isra.19+0xe/0x40
  btrfs_drop_snapshot+0x41c/0x7c0
  btrfs_clean_one_deleted_snapshot+0xb5/0xd0
  cleaner_kthread+0xf6/0x120
  kthread+0xf8/0x130
  ? btree_invalidatepage+0x90/0x90
  ? kthread_bind+0x10/0x10
  ret_from_fork+0x35/0x40

This was because btrfs_drop_snapshot depends on the root not being
modified while it's dropping the snapshot.  It will unlock the root node
(and really every node) as it walks down the tree, only to re-lock it
when it needs to do something.  This is a problem because if we modify
the tree we could cow a block in our path, which frees our reference to
that block.  Then once we get back to that shared block we'll free our
reference to it again, and get ENOENT when trying to lookup our extent
reference to that block in __btrfs_free_extent.

This is ultimately happening because we have delayed items left to be
processed for our deleted snapshot _after_ all of the inodes are closed
for the snapshot.  We only run the delayed inode item if we're deleting
the inode, and even then we do not run the delayed insertions or delayed
removals.  These can be run at any point after our final inode does its
last iput, which is what triggers the snapshot deletion.  We can end up
with the snapshot deletion happening and then have the delayed items run
on that file system, resulting in the above problem.

This problem has existed forever, however my patches made it much easier
to hit as I wake up the cleaner much more often to deal with delayed
iputs, which made us more likely to start the snapshot dropping work
before the transaction commits, which is when the delayed items would
generally be run.  Before, generally speaking, we would run the delayed
items, commit the transaction, and wakeup the cleaner thread to start
deleting snapshots, which means we were less likely to hit this problem.
You could still hit it if you had multiple snapshots to be deleted and
ended up with lots of delayed items, but it was definitely harder.

Fix for now by simply running all the delayed items before starting to
drop the snapshot.  We could make this smarter in the future by making
the delayed items per-root, and then simply drop any delayed items for
roots that we are going to delete.  But for now just a quick and easy
solution is the safest.

CC: stable@vger.kernel.org # 4.4+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/extent-tree.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -8911,6 +8911,10 @@ int btrfs_drop_snapshot(struct btrfs_roo
 		goto out_free;
 	}
 
+	err = btrfs_run_delayed_items(trans);
+	if (err)
+		goto out_end_trans;
+
 	if (block_rsv)
 		trans->block_rsv = block_rsv;
 


