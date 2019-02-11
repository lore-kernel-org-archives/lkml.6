Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC954C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824002081B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896466;
	bh=CaRf0+k3alWlNObHyy8klRLAGg+lDLyXpfKQXmhzuvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f+MK/NjqkbOe6PlgxkSgZD/jnZZ2eZOgmEsgJZecRAlKMt5JHDa5nwbzNJ1eDawwu
	 xnQJx1z8Sv2DHXczfQdee9v4g5fx4HNZiWdmhjvtJRwaLpQ5JMEVKl2YM8AIwefoId
	 srYnq2lGimSYPq+4ezbv1DIqEQJXspreLHxmGKb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387571AbfBKOrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:47:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:32808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387556AbfBKOrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:47:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61E6C206BA;
        Mon, 11 Feb 2019 14:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896460;
        bh=CaRf0+k3alWlNObHyy8klRLAGg+lDLyXpfKQXmhzuvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SnkaU/XFV+uZcnlW0J1S0B+tEmuW0sghipm2wQJ0kOjOY+u34QuCRZ/5F2Jn0Rj4s
         aXZXqw3sUqs2o0X+Y5Zi66y/ztoXYkohYhc+PZjpVV3dt6GAMzVOaZVUTnOI7Q/ciL
         fn3+FEwA45wkE+QutSfyHAf6byWnj5dJdkcDjXd0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Ethan Lien <ethanlien@synology.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 160/313] btrfs: use tagged writepage to mitigate livelock of snapshot
Date:   Mon, 11 Feb 2019 15:17:20 +0100
Message-Id: <20190211141904.170516750@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

[ Upstream commit 3cd24c698004d2f7668e0eb9fc1f096f533c791b ]

Snapshot is expected to be fast. But if there are writers steadily
creating dirty pages in our subvolume, the snapshot may take a very long
time to complete. To fix the problem, we use tagged writepage for
snapshot flusher as we do in the generic write_cache_pages(), so we can
omit pages dirtied after the snapshot command.

This does not change the semantics regarding which data get to the
snapshot, if there are pages being dirtied during the snapshotting
operation.  There's a sync called before snapshot is taken in old/new
case, any IO in flight just after that may be in the snapshot but this
depends on other system effects that might still sync the IO.

We do a simple snapshot speed test on a Intel D-1531 box:

fio --ioengine=libaio --iodepth=32 --bs=4k --rw=write --size=64G
--direct=0 --thread=1 --numjobs=1 --time_based --runtime=120
--filename=/mnt/sub/testfile --name=job1 --group_reporting & sleep 5;
time btrfs sub snap -r /mnt/sub /mnt/snap; killall fio

original: 1m58sec
patched:  6.54sec

This is the best case for this patch since for a sequential write case,
we omit nearly all pages dirtied after the snapshot command.

For a multi writers, random write test:

fio --ioengine=libaio --iodepth=32 --bs=4k --rw=randwrite --size=64G
--direct=0 --thread=1 --numjobs=4 --time_based --runtime=120
--filename=/mnt/sub/testfile --name=job1 --group_reporting & sleep 5;
time btrfs sub snap -r /mnt/sub /mnt/snap; killall fio

original: 15.83sec
patched:  10.35sec

The improvement is smaller compared to the sequential write case,
since we omit only half of the pages dirtied after snapshot command.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Ethan Lien <ethanlien@synology.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/btrfs_inode.h |  1 +
 fs/btrfs/ctree.h       |  2 +-
 fs/btrfs/extent_io.c   | 17 +++++++++++++++--
 fs/btrfs/inode.c       | 11 +++++++----
 fs/btrfs/ioctl.c       |  2 +-
 5 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 7177d1d33584..45f5cf9cd203 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -29,6 +29,7 @@ enum {
 	BTRFS_INODE_IN_DELALLOC_LIST,
 	BTRFS_INODE_READDIO_NEED_LOCK,
 	BTRFS_INODE_HAS_PROPS,
+	BTRFS_INODE_SNAPSHOT_FLUSH,
 };
 
 /* in memory btrfs inode */
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 2cddfe7806a4..82682da5a40d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3155,7 +3155,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			       struct inode *inode, u64 new_size,
 			       u32 min_type);
 
-int btrfs_start_delalloc_inodes(struct btrfs_root *root);
+int btrfs_start_delalloc_snapshot(struct btrfs_root *root);
 int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, int nr);
 int btrfs_set_extent_delalloc(struct inode *inode, u64 start, u64 end,
 			      unsigned int extra_bits,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4dd6faab02bb..79f82f2ec4d5 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3928,12 +3928,25 @@ static int extent_write_cache_pages(struct address_space *mapping,
 			range_whole = 1;
 		scanned = 1;
 	}
-	if (wbc->sync_mode == WB_SYNC_ALL)
+
+	/*
+	 * We do the tagged writepage as long as the snapshot flush bit is set
+	 * and we are the first one who do the filemap_flush() on this inode.
+	 *
+	 * The nr_to_write == LONG_MAX is needed to make sure other flushers do
+	 * not race in and drop the bit.
+	 */
+	if (range_whole && wbc->nr_to_write == LONG_MAX &&
+	    test_and_clear_bit(BTRFS_INODE_SNAPSHOT_FLUSH,
+			       &BTRFS_I(inode)->runtime_flags))
+		wbc->tagged_writepages = 1;
+
+	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
 		tag = PAGECACHE_TAG_TOWRITE;
 	else
 		tag = PAGECACHE_TAG_DIRTY;
 retry:
-	if (wbc->sync_mode == WB_SYNC_ALL)
+	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
 		tag_pages_for_writeback(mapping, index, end);
 	done_index = index;
 	while (!done && !nr_to_write_done && (index <= end) &&
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 83b3a626c796..59f361f7d0c1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10005,7 +10005,7 @@ static struct btrfs_delalloc_work *btrfs_alloc_delalloc_work(struct inode *inode
  * some fairly slow code that needs optimization. This walks the list
  * of all the inodes with pending delalloc and forces them to disk.
  */
-static int start_delalloc_inodes(struct btrfs_root *root, int nr)
+static int start_delalloc_inodes(struct btrfs_root *root, int nr, bool snapshot)
 {
 	struct btrfs_inode *binode;
 	struct inode *inode;
@@ -10033,6 +10033,9 @@ static int start_delalloc_inodes(struct btrfs_root *root, int nr)
 		}
 		spin_unlock(&root->delalloc_lock);
 
+		if (snapshot)
+			set_bit(BTRFS_INODE_SNAPSHOT_FLUSH,
+				&binode->runtime_flags);
 		work = btrfs_alloc_delalloc_work(inode);
 		if (!work) {
 			iput(inode);
@@ -10066,7 +10069,7 @@ out:
 	return ret;
 }
 
-int btrfs_start_delalloc_inodes(struct btrfs_root *root)
+int btrfs_start_delalloc_snapshot(struct btrfs_root *root)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	int ret;
@@ -10074,7 +10077,7 @@ int btrfs_start_delalloc_inodes(struct btrfs_root *root)
 	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
 		return -EROFS;
 
-	ret = start_delalloc_inodes(root, -1);
+	ret = start_delalloc_inodes(root, -1, true);
 	if (ret > 0)
 		ret = 0;
 	return ret;
@@ -10103,7 +10106,7 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, int nr)
 			       &fs_info->delalloc_roots);
 		spin_unlock(&fs_info->delalloc_root_lock);
 
-		ret = start_delalloc_inodes(root, nr);
+		ret = start_delalloc_inodes(root, nr, false);
 		btrfs_put_fs_root(root);
 		if (ret < 0)
 			goto out;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index c9152155fcbf..8bf9cce11213 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -778,7 +778,7 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 	wait_event(root->subv_writers->wait,
 		   percpu_counter_sum(&root->subv_writers->counter) == 0);
 
-	ret = btrfs_start_delalloc_inodes(root);
+	ret = btrfs_start_delalloc_snapshot(root);
 	if (ret)
 		goto dec_and_free;
 
-- 
2.19.1



