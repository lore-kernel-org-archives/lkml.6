Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C04C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183A820989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298314;
	bh=qvBwKPzPVzzwqNSjQi5U6myavY7ErH/9R/cgQaw2f54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zEszrzoOzqLI5QUgn/DURw57uTxJIU/9+2yvFDswU+dhA/sByC3dzZXRbPz3gPZB8
	 p8XaI25w4KxUNmJXuTJmVd2KXk5bip8V+Zbtu4+I8/5UGlrJMFQLYmMeqjFPPwHo8V
	 9puz9iRqqg3VUOmntViJ30Pu84QTJdFTiU3hY3XA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733197AbeLTJbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:31:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:50116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733179AbeLTJbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:31:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E03220656;
        Thu, 20 Dec 2018 09:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298302;
        bh=qvBwKPzPVzzwqNSjQi5U6myavY7ErH/9R/cgQaw2f54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ae1/edt9qKSJmVaCI4mCg1jdY7/10NAGE0/L96WpUQqAhixgB94hLMLzPx/RI7wYp
         85xdT95rFEldMB5yDO+3r8+YGsbgccghxl9KhbXIS3ZlfrhuVA/Zpksx7mcCoFascu
         8fg1TVukmWx+azHSmOnNyirD86VHmQcbeI5PEAr0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 67/67] Btrfs: fix missing delayed iputs on unmount
Date:   Thu, 20 Dec 2018 10:19:19 +0100
Message-Id: <20181220085906.183047324@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
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

[ Upstream commit d6fd0ae25c6495674dc5a41a8d16bc8e0073276d ]

There's a race between close_ctree() and cleaner_kthread().
close_ctree() sets btrfs_fs_closing(), and the cleaner stops when it
sees it set, but this is racy; the cleaner might have already checked
the bit and could be cleaning stuff. In particular, if it deletes unused
block groups, it will create delayed iputs for the free space cache
inodes. As of "btrfs: don't run delayed_iputs in commit", we're no
longer running delayed iputs after a commit. Therefore, if the cleaner
creates more delayed iputs after delayed iputs are run in
btrfs_commit_super(), we will leak inodes on unmount and get a busy
inode crash from the VFS.

Fix it by parking the cleaner before we actually close anything. Then,
any remaining delayed iputs will always be handled in
btrfs_commit_super(). This also ensures that the commit in close_ctree()
is really the last commit, so we can get rid of the commit in
cleaner_kthread().

The fstest/generic/475 followed by 476 can trigger a crash that
manifests as a slab corruption caused by accessing the freed kthread
structure by a wake up function. Sample trace:

[ 5657.077612] BUG: unable to handle kernel NULL pointer dereference at 00000000000000cc
[ 5657.079432] PGD 1c57a067 P4D 1c57a067 PUD da10067 PMD 0
[ 5657.080661] Oops: 0000 [#1] PREEMPT SMP
[ 5657.081592] CPU: 1 PID: 5157 Comm: fsstress Tainted: G        W         4.19.0-rc8-default+ #323
[ 5657.083703] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.2-0-gf9626cc-prebuilt.qemu-project.org 04/01/2014
[ 5657.086577] RIP: 0010:shrink_page_list+0x2f9/0xe90
[ 5657.091937] RSP: 0018:ffffb5c745c8f728 EFLAGS: 00010287
[ 5657.092953] RAX: 0000000000000074 RBX: ffffb5c745c8f830 RCX: 0000000000000000
[ 5657.094590] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff9a8747fdf3d0
[ 5657.095987] RBP: ffffb5c745c8f9e0 R08: 0000000000000000 R09: 0000000000000000
[ 5657.097159] R10: ffff9a8747fdf5e8 R11: 0000000000000000 R12: ffffb5c745c8f788
[ 5657.098513] R13: ffff9a877f6ff2c0 R14: ffff9a877f6ff2c8 R15: dead000000000200
[ 5657.099689] FS:  00007f948d853b80(0000) GS:ffff9a877d600000(0000) knlGS:0000000000000000
[ 5657.101032] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5657.101953] CR2: 00000000000000cc CR3: 00000000684bd000 CR4: 00000000000006e0
[ 5657.103159] Call Trace:
[ 5657.103776]  shrink_inactive_list+0x194/0x410
[ 5657.104671]  shrink_node_memcg.constprop.84+0x39a/0x6a0
[ 5657.105750]  shrink_node+0x62/0x1c0
[ 5657.106529]  try_to_free_pages+0x1a4/0x500
[ 5657.107408]  __alloc_pages_slowpath+0x2c9/0xb20
[ 5657.108418]  __alloc_pages_nodemask+0x268/0x2b0
[ 5657.109348]  kmalloc_large_node+0x37/0x90
[ 5657.110205]  __kmalloc_node+0x236/0x310
[ 5657.111014]  kvmalloc_node+0x3e/0x70

Fixes: 30928e9baac2 ("btrfs: don't run delayed_iputs in commit")
Signed-off-by: Omar Sandoval <osandov@fb.com>
Reviewed-by: David Sterba <dsterba@suse.com>
[ add trace ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/disk-io.c | 51 ++++++++++++++--------------------------------
 1 file changed, 15 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 834a3f5ef642..d4a7f7ca4145 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1656,9 +1656,8 @@ static int cleaner_kthread(void *arg)
 	struct btrfs_root *root = arg;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	int again;
-	struct btrfs_trans_handle *trans;
 
-	do {
+	while (1) {
 		again = 0;
 
 		/* Make the cleaner go to sleep early. */
@@ -1707,42 +1706,16 @@ static int cleaner_kthread(void *arg)
 		 */
 		btrfs_delete_unused_bgs(fs_info);
 sleep:
+		if (kthread_should_park())
+			kthread_parkme();
+		if (kthread_should_stop())
+			return 0;
 		if (!again) {
 			set_current_state(TASK_INTERRUPTIBLE);
-			if (!kthread_should_stop())
-				schedule();
+			schedule();
 			__set_current_state(TASK_RUNNING);
 		}
-	} while (!kthread_should_stop());
-
-	/*
-	 * Transaction kthread is stopped before us and wakes us up.
-	 * However we might have started a new transaction and COWed some
-	 * tree blocks when deleting unused block groups for example. So
-	 * make sure we commit the transaction we started to have a clean
-	 * shutdown when evicting the btree inode - if it has dirty pages
-	 * when we do the final iput() on it, eviction will trigger a
-	 * writeback for it which will fail with null pointer dereferences
-	 * since work queues and other resources were already released and
-	 * destroyed by the time the iput/eviction/writeback is made.
-	 */
-	trans = btrfs_attach_transaction(root);
-	if (IS_ERR(trans)) {
-		if (PTR_ERR(trans) != -ENOENT)
-			btrfs_err(fs_info,
-				  "cleaner transaction attach returned %ld",
-				  PTR_ERR(trans));
-	} else {
-		int ret;
-
-		ret = btrfs_commit_transaction(trans);
-		if (ret)
-			btrfs_err(fs_info,
-				  "cleaner open transaction commit returned %d",
-				  ret);
 	}
-
-	return 0;
 }
 
 static int transaction_kthread(void *arg)
@@ -3923,6 +3896,13 @@ void close_ctree(struct btrfs_fs_info *fs_info)
 	int ret;
 
 	set_bit(BTRFS_FS_CLOSING_START, &fs_info->flags);
+	/*
+	 * We don't want the cleaner to start new transactions, add more delayed
+	 * iputs, etc. while we're closing. We can't use kthread_stop() yet
+	 * because that frees the task_struct, and the transaction kthread might
+	 * still try to wake up the cleaner.
+	 */
+	kthread_park(fs_info->cleaner_kthread);
 
 	/* wait for the qgroup rescan worker to stop */
 	btrfs_qgroup_wait_for_completion(fs_info, false);
@@ -3950,9 +3930,8 @@ void close_ctree(struct btrfs_fs_info *fs_info)
 
 	if (!sb_rdonly(fs_info->sb)) {
 		/*
-		 * If the cleaner thread is stopped and there are
-		 * block groups queued for removal, the deletion will be
-		 * skipped when we quit the cleaner thread.
+		 * The cleaner kthread is stopped, so do one final pass over
+		 * unused block groups.
 		 */
 		btrfs_delete_unused_bgs(fs_info);
 
-- 
2.19.1



