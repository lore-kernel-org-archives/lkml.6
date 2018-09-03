Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CD3C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB162077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CB162077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbeICVxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:53:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47282 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbeICVxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:53:07 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3ACE5D18;
        Mon,  3 Sep 2018 17:31:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <jbacik@fb.com>,
        Omar Sandoval <osandov@fb.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH 4.18 018/123] Btrfs: fix btrfs_write_inode vs delayed iput deadlock
Date:   Mon,  3 Sep 2018 18:56:02 +0200
Message-Id: <20180903165720.264847844@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

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

CC: stable@vger.kernel.org # 3.2+
Signed-off-by: Josef Bacik <jbacik@fb.com>
[Omar: new commit message]
Signed-off-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/inode.c |   26 --------------------------
 fs/btrfs/super.c |    1 -
 2 files changed, 27 deletions(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6027,32 +6027,6 @@ err:
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
-	if (btrfs_fs_closing(root->fs_info) &&
-			btrfs_is_free_space_inode(BTRFS_I(inode)))
-		nolock = true;
-
-	if (wbc->sync_mode == WB_SYNC_ALL) {
-		if (nolock)
-			trans = btrfs_join_transaction_nolock(root);
-		else
-			trans = btrfs_join_transaction(root);
-		if (IS_ERR(trans))
-			return PTR_ERR(trans);
-		ret = btrfs_commit_transaction(trans);
-	}
-	return ret;
-}
-
 /*
  * This is somewhat expensive, updating the tree every time the
  * inode changes.  But, it is most likely to find the inode in cache.
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2331,7 +2331,6 @@ static const struct super_operations btr
 	.sync_fs	= btrfs_sync_fs,
 	.show_options	= btrfs_show_options,
 	.show_devname	= btrfs_show_devname,
-	.write_inode	= btrfs_write_inode,
 	.alloc_inode	= btrfs_alloc_inode,
 	.destroy_inode	= btrfs_destroy_inode,
 	.statfs		= btrfs_statfs,


