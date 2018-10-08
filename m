Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BEEC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43DA621479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cykYG8ci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43DA621479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbeJIB64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:58:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbeJIB6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:58:55 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25B082087D;
        Mon,  8 Oct 2018 18:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024349;
        bh=h2yjm4eQxMnysgqHx0JoBIRK6SzNXyUVlgG4cLsI07o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cykYG8ci42aLD/0y8tYp0smzL+boxOr1sOlbJye9d1lvLzWJgEWVFIHmJbzQyHW+A
         NTmKSsJFweLS7wCwSMExkwyy3LvAx9ru+pXQ6s1TgYy/QP6gdeWP4EmIxfm4CMiqiH
         e9t8tnBvkxL3TngMwpJJ1pkAdAIK2wWxLZJjt5xA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robbie Ko <robbieko@synology.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 004/168] Btrfs: fix unexpected failure of nocow buffered writes after snapshotting when low on space
Date:   Mon,  8 Oct 2018 20:29:44 +0200
Message-Id: <20181008175620.210470934@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robbie Ko <robbieko@synology.com>

[ Upstream commit 8ecebf4d767e2307a946c8905278d6358eda35c3 ]

Commit e9894fd3e3b3 ("Btrfs: fix snapshot vs nocow writting") forced
nocow writes to fallback to COW, during writeback, when a snapshot is
created. This resulted in writes made before creating the snapshot to
unexpectedly fail with ENOSPC during writeback when success (0) was
returned to user space through the write system call.

The steps leading to this problem are:

1. When it's not possible to allocate data space for a write, the
   buffered write path checks if a NOCOW write is possible.  If it is,
   it will not reserve space and success (0) is returned to user space.

2. Then when a snapshot is created, the root's will_be_snapshotted
   atomic is incremented and writeback is triggered for all inode's that
   belong to the root being snapshotted. Incrementing that atomic forces
   all previous writes to fallback to COW during writeback (running
   delalloc).

3. This results in the writeback for the inodes to fail and therefore
   setting the ENOSPC error in their mappings, so that a subsequent
   fsync on them will report the error to user space. So it's not a
   completely silent data loss (since fsync will report ENOSPC) but it's
   a very unexpected and undesirable behaviour, because if a clean
   shutdown/unmount of the filesystem happens without previous calls to
   fsync, it is expected to have the data present in the files after
   mounting the filesystem again.

So fix this by adding a new atomic named snapshot_force_cow to the
root structure which prevents this behaviour and works the following way:

1. It is incremented when we start to create a snapshot after triggering
   writeback and before waiting for writeback to finish.

2. This new atomic is now what is used by writeback (running delalloc)
   to decide whether we need to fallback to COW or not. Because we
   incremented this new atomic after triggering writeback in the
   snapshot creation ioctl, we ensure that all buffered writes that
   happened before snapshot creation will succeed and not fallback to
   COW (which would make them fail with ENOSPC).

3. The existing atomic, will_be_snapshotted, is kept because it is used
   to force new buffered writes, that start after we started
   snapshotting, to reserve data space even when NOCOW is possible.
   This makes these writes fail early with ENOSPC when there's no
   available space to allocate, preventing the unexpected behaviour of
   writeback later failing with ENOSPC due to a fallback to COW mode.

Fixes: e9894fd3e3b3 ("Btrfs: fix snapshot vs nocow writting")
Signed-off-by: Robbie Ko <robbieko@synology.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/ctree.h   |    1 +
 fs/btrfs/disk-io.c |    1 +
 fs/btrfs/inode.c   |   25 ++++---------------------
 fs/btrfs/ioctl.c   |   16 ++++++++++++++++
 4 files changed, 22 insertions(+), 21 deletions(-)

--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1277,6 +1277,7 @@ struct btrfs_root {
 	int send_in_progress;
 	struct btrfs_subvolume_writers *subv_writers;
 	atomic_t will_be_snapshotted;
+	atomic_t snapshot_force_cow;
 
 	/* For qgroup metadata reserved space */
 	spinlock_t qgroup_meta_rsv_lock;
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1217,6 +1217,7 @@ static void __setup_root(struct btrfs_ro
 	atomic_set(&root->log_batch, 0);
 	refcount_set(&root->refs, 1);
 	atomic_set(&root->will_be_snapshotted, 0);
+	atomic_set(&root->snapshot_force_cow, 0);
 	root->log_transid = 0;
 	root->log_transid_committed = -1;
 	root->last_log_commit = 0;
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1275,7 +1275,7 @@ static noinline int run_delalloc_nocow(s
 	u64 disk_num_bytes;
 	u64 ram_bytes;
 	int extent_type;
-	int ret, err;
+	int ret;
 	int type;
 	int nocow;
 	int check_prev = 1;
@@ -1407,11 +1407,8 @@ next_slot:
 			 * if there are pending snapshots for this root,
 			 * we fall into common COW way.
 			 */
-			if (!nolock) {
-				err = btrfs_start_write_no_snapshotting(root);
-				if (!err)
-					goto out_check;
-			}
+			if (!nolock && atomic_read(&root->snapshot_force_cow))
+				goto out_check;
 			/*
 			 * force cow if csum exists in the range.
 			 * this ensure that csum for a given extent are
@@ -1420,9 +1417,6 @@ next_slot:
 			ret = csum_exist_in_range(fs_info, disk_bytenr,
 						  num_bytes);
 			if (ret) {
-				if (!nolock)
-					btrfs_end_write_no_snapshotting(root);
-
 				/*
 				 * ret could be -EIO if the above fails to read
 				 * metadata.
@@ -1435,11 +1429,8 @@ next_slot:
 				WARN_ON_ONCE(nolock);
 				goto out_check;
 			}
-			if (!btrfs_inc_nocow_writers(fs_info, disk_bytenr)) {
-				if (!nolock)
-					btrfs_end_write_no_snapshotting(root);
+			if (!btrfs_inc_nocow_writers(fs_info, disk_bytenr))
 				goto out_check;
-			}
 			nocow = 1;
 		} else if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
 			extent_end = found_key.offset +
@@ -1453,8 +1444,6 @@ next_slot:
 out_check:
 		if (extent_end <= start) {
 			path->slots[0]++;
-			if (!nolock && nocow)
-				btrfs_end_write_no_snapshotting(root);
 			if (nocow)
 				btrfs_dec_nocow_writers(fs_info, disk_bytenr);
 			goto next_slot;
@@ -1476,8 +1465,6 @@ out_check:
 					     end, page_started, nr_written, 1,
 					     NULL);
 			if (ret) {
-				if (!nolock && nocow)
-					btrfs_end_write_no_snapshotting(root);
 				if (nocow)
 					btrfs_dec_nocow_writers(fs_info,
 								disk_bytenr);
@@ -1497,8 +1484,6 @@ out_check:
 					  ram_bytes, BTRFS_COMPRESS_NONE,
 					  BTRFS_ORDERED_PREALLOC);
 			if (IS_ERR(em)) {
-				if (!nolock && nocow)
-					btrfs_end_write_no_snapshotting(root);
 				if (nocow)
 					btrfs_dec_nocow_writers(fs_info,
 								disk_bytenr);
@@ -1537,8 +1522,6 @@ out_check:
 					     EXTENT_CLEAR_DATA_RESV,
 					     PAGE_UNLOCK | PAGE_SET_PRIVATE2);
 
-		if (!nolock && nocow)
-			btrfs_end_write_no_snapshotting(root);
 		cur_offset = extent_end;
 
 		/*
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -761,6 +761,7 @@ static int create_snapshot(struct btrfs_
 	struct btrfs_pending_snapshot *pending_snapshot;
 	struct btrfs_trans_handle *trans;
 	int ret;
+	bool snapshot_force_cow = false;
 
 	if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
 		return -EINVAL;
@@ -777,6 +778,11 @@ static int create_snapshot(struct btrfs_
 		goto free_pending;
 	}
 
+	/*
+	 * Force new buffered writes to reserve space even when NOCOW is
+	 * possible. This is to avoid later writeback (running dealloc) to
+	 * fallback to COW mode and unexpectedly fail with ENOSPC.
+	 */
 	atomic_inc(&root->will_be_snapshotted);
 	smp_mb__after_atomic();
 	/* wait for no snapshot writes */
@@ -787,6 +793,14 @@ static int create_snapshot(struct btrfs_
 	if (ret)
 		goto dec_and_free;
 
+	/*
+	 * All previous writes have started writeback in NOCOW mode, so now
+	 * we force future writes to fallback to COW mode during snapshot
+	 * creation.
+	 */
+	atomic_inc(&root->snapshot_force_cow);
+	snapshot_force_cow = true;
+
 	btrfs_wait_ordered_extents(root, U64_MAX, 0, (u64)-1);
 
 	btrfs_init_block_rsv(&pending_snapshot->block_rsv,
@@ -851,6 +865,8 @@ static int create_snapshot(struct btrfs_
 fail:
 	btrfs_subvolume_release_metadata(fs_info, &pending_snapshot->block_rsv);
 dec_and_free:
+	if (snapshot_force_cow)
+		atomic_dec(&root->snapshot_force_cow);
 	if (atomic_dec_and_test(&root->will_be_snapshotted))
 		wake_up_var(&root->will_be_snapshotted);
 free_pending:


