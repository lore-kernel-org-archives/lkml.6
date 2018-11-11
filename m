Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF85DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE69214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipgrssHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE69214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404419AbeKLIi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:38:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:56460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404337AbeKLIXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:23:19 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65C91223C7;
        Sun, 11 Nov 2018 22:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975601;
        bh=VXLUv8HCCkP/RXXe1Qze3KEaSQgXcCMPL46xnMMgUKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ipgrssHdzXM0cp6x+19m6ag68BU2KMzgreHD1lWB6Z63DwcCk9mhdCOCXekuYAWpO
         LpjAc5LF1XREjqaE8nITEXDTzeYeDEhkFrJGV7DmRbK/gPmiJvIzlbxH1AFZAERG/H
         /IHW1AP3XU6hyUCLvzNB7fpU57E9ao2HWUW2WT/U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.14 217/222] btrfs: move the dio_sem higher up the callchain
Date:   Sun, 11 Nov 2018 14:25:14 -0800
Message-Id: <20181111221705.746162018@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josef Bacik <josef@toxicpanda.com>

commit c495144bc6962186feae31d687596d2472000e45 upstream.

We're getting a lockdep splat because we take the dio_sem under the
log_mutex.  What we really need is to protect fsync() from logging an
extent map for an extent we never waited on higher up, so just guard the
whole thing with dio_sem.

======================================================
WARNING: possible circular locking dependency detected
4.18.0-rc4-xfstests-00025-g5de5edbaf1d4 #411 Not tainted
------------------------------------------------------
aio-dio-invalid/30928 is trying to acquire lock:
0000000092621cfd (&mm->mmap_sem){++++}, at: get_user_pages_unlocked+0x5a/0x1e0

but task is already holding lock:
00000000cefe6b35 (&ei->dio_sem){++++}, at: btrfs_direct_IO+0x3be/0x400

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #5 (&ei->dio_sem){++++}:
       lock_acquire+0xbd/0x220
       down_write+0x51/0xb0
       btrfs_log_changed_extents+0x80/0xa40
       btrfs_log_inode+0xbaf/0x1000
       btrfs_log_inode_parent+0x26f/0xa80
       btrfs_log_dentry_safe+0x50/0x70
       btrfs_sync_file+0x357/0x540
       do_fsync+0x38/0x60
       __ia32_sys_fdatasync+0x12/0x20
       do_fast_syscall_32+0x9a/0x2f0
       entry_SYSENTER_compat+0x84/0x96

-> #4 (&ei->log_mutex){+.+.}:
       lock_acquire+0xbd/0x220
       __mutex_lock+0x86/0xa10
       btrfs_record_unlink_dir+0x2a/0xa0
       btrfs_unlink+0x5a/0xc0
       vfs_unlink+0xb1/0x1a0
       do_unlinkat+0x264/0x2b0
       do_fast_syscall_32+0x9a/0x2f0
       entry_SYSENTER_compat+0x84/0x96

-> #3 (sb_internal#2){.+.+}:
       lock_acquire+0xbd/0x220
       __sb_start_write+0x14d/0x230
       start_transaction+0x3e6/0x590
       btrfs_evict_inode+0x475/0x640
       evict+0xbf/0x1b0
       btrfs_run_delayed_iputs+0x6c/0x90
       cleaner_kthread+0x124/0x1a0
       kthread+0x106/0x140
       ret_from_fork+0x3a/0x50

-> #2 (&fs_info->cleaner_delayed_iput_mutex){+.+.}:
       lock_acquire+0xbd/0x220
       __mutex_lock+0x86/0xa10
       btrfs_alloc_data_chunk_ondemand+0x197/0x530
       btrfs_check_data_free_space+0x4c/0x90
       btrfs_delalloc_reserve_space+0x20/0x60
       btrfs_page_mkwrite+0x87/0x520
       do_page_mkwrite+0x31/0xa0
       __handle_mm_fault+0x799/0xb00
       handle_mm_fault+0x7c/0xe0
       __do_page_fault+0x1d3/0x4a0
       async_page_fault+0x1e/0x30

-> #1 (sb_pagefaults){.+.+}:
       lock_acquire+0xbd/0x220
       __sb_start_write+0x14d/0x230
       btrfs_page_mkwrite+0x6a/0x520
       do_page_mkwrite+0x31/0xa0
       __handle_mm_fault+0x799/0xb00
       handle_mm_fault+0x7c/0xe0
       __do_page_fault+0x1d3/0x4a0
       async_page_fault+0x1e/0x30

-> #0 (&mm->mmap_sem){++++}:
       __lock_acquire+0x42e/0x7a0
       lock_acquire+0xbd/0x220
       down_read+0x48/0xb0
       get_user_pages_unlocked+0x5a/0x1e0
       get_user_pages_fast+0xa4/0x150
       iov_iter_get_pages+0xc3/0x340
       do_direct_IO+0xf93/0x1d70
       __blockdev_direct_IO+0x32d/0x1c20
       btrfs_direct_IO+0x227/0x400
       generic_file_direct_write+0xcf/0x180
       btrfs_file_write_iter+0x308/0x58c
       aio_write+0xf8/0x1d0
       io_submit_one+0x3a9/0x620
       __ia32_compat_sys_io_submit+0xb2/0x270
       do_int80_syscall_32+0x5b/0x1a0
       entry_INT80_compat+0x88/0xa0

other info that might help us debug this:

Chain exists of:
  &mm->mmap_sem --> &ei->log_mutex --> &ei->dio_sem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ei->dio_sem);
                               lock(&ei->log_mutex);
                               lock(&ei->dio_sem);
  lock(&mm->mmap_sem);

 *** DEADLOCK ***

1 lock held by aio-dio-invalid/30928:
 #0: 00000000cefe6b35 (&ei->dio_sem){++++}, at: btrfs_direct_IO+0x3be/0x400

stack backtrace:
CPU: 0 PID: 30928 Comm: aio-dio-invalid Not tainted 4.18.0-rc4-xfstests-00025-g5de5edbaf1d4 #411
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
Call Trace:
 dump_stack+0x7c/0xbb
 print_circular_bug.isra.37+0x297/0x2a4
 check_prev_add.constprop.45+0x781/0x7a0
 ? __lock_acquire+0x42e/0x7a0
 validate_chain.isra.41+0x7f0/0xb00
 __lock_acquire+0x42e/0x7a0
 lock_acquire+0xbd/0x220
 ? get_user_pages_unlocked+0x5a/0x1e0
 down_read+0x48/0xb0
 ? get_user_pages_unlocked+0x5a/0x1e0
 get_user_pages_unlocked+0x5a/0x1e0
 get_user_pages_fast+0xa4/0x150
 iov_iter_get_pages+0xc3/0x340
 do_direct_IO+0xf93/0x1d70
 ? __alloc_workqueue_key+0x358/0x490
 ? __blockdev_direct_IO+0x14b/0x1c20
 __blockdev_direct_IO+0x32d/0x1c20
 ? btrfs_run_delalloc_work+0x40/0x40
 ? can_nocow_extent+0x490/0x490
 ? kvm_clock_read+0x1f/0x30
 ? can_nocow_extent+0x490/0x490
 ? btrfs_run_delalloc_work+0x40/0x40
 btrfs_direct_IO+0x227/0x400
 ? btrfs_run_delalloc_work+0x40/0x40
 generic_file_direct_write+0xcf/0x180
 btrfs_file_write_iter+0x308/0x58c
 aio_write+0xf8/0x1d0
 ? kvm_clock_read+0x1f/0x30
 ? __might_fault+0x3e/0x90
 io_submit_one+0x3a9/0x620
 ? io_submit_one+0xe5/0x620
 __ia32_compat_sys_io_submit+0xb2/0x270
 do_int80_syscall_32+0x5b/0x1a0
 entry_INT80_compat+0x88/0xa0

CC: stable@vger.kernel.org # 4.14+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/file.c     |   12 ++++++++++++
 fs/btrfs/tree-log.c |    2 --
 2 files changed, 12 insertions(+), 2 deletions(-)

--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2078,6 +2078,14 @@ int btrfs_sync_file(struct file *file, l
 		goto out;
 
 	inode_lock(inode);
+
+	/*
+	 * We take the dio_sem here because the tree log stuff can race with
+	 * lockless dio writes and get an extent map logged for an extent we
+	 * never waited on.  We need it this high up for lockdep reasons.
+	 */
+	down_write(&BTRFS_I(inode)->dio_sem);
+
 	atomic_inc(&root->log_batch);
 	full_sync = test_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
 			     &BTRFS_I(inode)->runtime_flags);
@@ -2129,6 +2137,7 @@ int btrfs_sync_file(struct file *file, l
 		ret = start_ordered_ops(inode, start, end);
 	}
 	if (ret) {
+		up_write(&BTRFS_I(inode)->dio_sem);
 		inode_unlock(inode);
 		goto out;
 	}
@@ -2184,6 +2193,7 @@ int btrfs_sync_file(struct file *file, l
 		 * checked called fsync.
 		 */
 		ret = filemap_check_wb_err(inode->i_mapping, file->f_wb_err);
+		up_write(&BTRFS_I(inode)->dio_sem);
 		inode_unlock(inode);
 		goto out;
 	}
@@ -2208,6 +2218,7 @@ int btrfs_sync_file(struct file *file, l
 	trans = btrfs_start_transaction(root, 0);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
+		up_write(&BTRFS_I(inode)->dio_sem);
 		inode_unlock(inode);
 		goto out;
 	}
@@ -2229,6 +2240,7 @@ int btrfs_sync_file(struct file *file, l
 	 * file again, but that will end up using the synchronization
 	 * inside btrfs_sync_log to keep things safe.
 	 */
+	up_write(&BTRFS_I(inode)->dio_sem);
 	inode_unlock(inode);
 
 	/*
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4362,7 +4362,6 @@ static int btrfs_log_changed_extents(str
 
 	INIT_LIST_HEAD(&extents);
 
-	down_write(&inode->dio_sem);
 	write_lock(&tree->lock);
 	test_gen = root->fs_info->last_trans_committed;
 	logged_start = start;
@@ -4443,7 +4442,6 @@ process:
 	}
 	WARN_ON(!list_empty(&extents));
 	write_unlock(&tree->lock);
-	up_write(&inode->dio_sem);
 
 	btrfs_release_path(path);
 	if (!ret)


