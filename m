Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCEFC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1FC2081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B1FC2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbeLIWHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:07:32 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37218 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726859AbeLIWH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:07:28 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73I-0002iZ-JT; Sun, 09 Dec 2018 21:55:52 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72c-0003M0-CB; Sun, 09 Dec 2018 21:55:10 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David Sterba" <dsterba@suse.com>,
        "Omar Sandoval" <osandov@fb.com>, "Josef Bacik" <jbacik@fb.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.9981088@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 110/328] Btrfs: fix btrfs_write_inode vs delayed iput
 deadlock
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

From: Josef Bacik <jbacik@fb.com>

commit 3c4276936f6fbe52884b4ea4e6cc120b890a0f9f upstream.

We recently ran into the following deadlock involving
btrfs_write_inode():

[  +0.005066]  __schedule+0x38e/0x8c0
[  +0.007144]  schedule+0x36/0x80
[  +0.006447]  bit_wait+0x11/0x60
[  +0.006446]  __wait_on_bit+0xbe/0x110
[  +0.007487]  ? bit_wait_io+0x60/0x60
[  +0.007319]  __inode_wait_for_writeback+0x96/0xc0
[  +0.009568]  ? autoremove_wake_function+0x40/0x40
[  +0.009565]  inode_wait_for_writeback+0x21/0x30
[  +0.009224]  evict+0xb0/0x190
[  +0.006099]  iput+0x1a8/0x210
[  +0.006103]  btrfs_run_delayed_iputs+0x73/0xc0
[  +0.009047]  btrfs_commit_transaction+0x799/0x8c0
[  +0.009567]  btrfs_write_inode+0x81/0xb0
[  +0.008008]  __writeback_single_inode+0x267/0x320
[  +0.009569]  writeback_sb_inodes+0x25b/0x4e0
[  +0.008702]  wb_writeback+0x102/0x2d0
[  +0.007487]  wb_workfn+0xa4/0x310
[  +0.006794]  ? wb_workfn+0xa4/0x310
[  +0.007143]  process_one_work+0x150/0x410
[  +0.008179]  worker_thread+0x6d/0x520
[  +0.007490]  kthread+0x12c/0x160
[  +0.006620]  ? put_pwq_unlocked+0x80/0x80
[  +0.008185]  ? kthread_park+0xa0/0xa0
[  +0.007484]  ? do_syscall_64+0x53/0x150
[  +0.007837]  ret_from_fork+0x29/0x40

Writeback calls:

btrfs_write_inode
  btrfs_commit_transaction
    btrfs_run_delayed_iputs

If iput() is called on that same inode, evict() will wait for writeback
forever.

btrfs_write_inode() was originally added way back in 4730a4bc5bf3
("btrfs_dirty_inode") to support O_SYNC writes. However, ->write_inode()
hasn't been used for O_SYNC since 148f948ba877 ("vfs: Introduce new
helpers for syncing after writing to O_SYNC file or IS_SYNC inode"), so
btrfs_write_inode() is actually unnecessary (and leads to a bunch of
unnecessary commits). Get rid of it, which also gets rid of the
deadlock.

Signed-off-by: Josef Bacik <jbacik@fb.com>
[Omar: new commit message]
Signed-off-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[bwh: Backported to 3.16: deleted function is slightly different]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5542,31 +5542,6 @@ err:
 	return ret;
 }
 
-int btrfs_write_inode(struct inode *inode, struct writeback_control *wbc)
-{
-	struct btrfs_root *root = BTRFS_I(inode)->root;
-	struct btrfs_trans_handle *trans;
-	int ret = 0;
-	bool nolock = false;
-
-	if (test_bit(BTRFS_INODE_DUMMY, &BTRFS_I(inode)->runtime_flags))
-		return 0;
-
-	if (btrfs_fs_closing(root->fs_info) && btrfs_is_free_space_inode(inode))
-		nolock = true;
-
-	if (wbc->sync_mode == WB_SYNC_ALL) {
-		if (nolock)
-			trans = btrfs_join_transaction_nolock(root);
-		else
-			trans = btrfs_join_transaction(root);
-		if (IS_ERR(trans))
-			return PTR_ERR(trans);
-		ret = btrfs_commit_transaction(trans, root);
-	}
-	return ret;
-}
-
 /*
  * This is somewhat expensive, updating the tree every time the
  * inode changes.  But, it is most likely to find the inode in cache.
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1852,7 +1852,6 @@ static const struct super_operations btr
 	.sync_fs	= btrfs_sync_fs,
 	.show_options	= btrfs_show_options,
 	.show_devname	= btrfs_show_devname,
-	.write_inode	= btrfs_write_inode,
 	.alloc_inode	= btrfs_alloc_inode,
 	.destroy_inode	= btrfs_destroy_inode,
 	.statfs		= btrfs_statfs,

