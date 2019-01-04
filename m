Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2627C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C35218D3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546634029;
	bh=HIZx89COUNTQ0vOq+O4dejPmJcy9CZQzDQuw261Pwd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ub5OLoxRfXgj1uqGuHOeF9SLzJamoPFPDBgJwkiOEA0MY7wL/RO74pXgiOJBk/hLj
	 2fFVFiBzYFB/WXJiSi2IPZe1R56dUiqYhuExOQN1KssXyj3suiw/T17+opv+08bi59
	 HF64rFsBXROT2lfKa/4XylzAOS8WhRtMVSKto6Ug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfADUdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 15:33:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:50540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbfADUdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 15:33:31 -0500
Received: from localhost (unknown [104.132.1.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0FDF218D3;
        Fri,  4 Jan 2019 20:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546634010;
        bh=HIZx89COUNTQ0vOq+O4dejPmJcy9CZQzDQuw261Pwd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RLKs963snpHYoDhB33IX/qNAxlV1/k0mmEZJ5lzB2whFy+VDcSvTdt2DVCccBeDdw
         mGunpkeJLFi2XqynvPzgA89XdJIn1+P+aZ29mnsU8yCNBQC1ALUyf01pMZNB3kdufP
         xM4BmoKKSqocFShfvbvORQikb/++/xb2iUDRZprc=
Date:   Fri, 4 Jan 2019 12:33:29 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Sahitya Tummala <stummala@codeaurora.org>
Cc:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: fix sbi->extent_list corruption issue
Message-ID: <20190104203329.GA57873@jaegeuk-macbookpro.roam.corp.google.com>
References: <1543207640-31033-1-git-send-email-stummala@codeaurora.org>
 <20190104080535.GB8475@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104080535.GB8475@codeaurora.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04, Sahitya Tummala wrote:
> On Mon, Nov 26, 2018 at 10:17:20AM +0530, Sahitya Tummala wrote:
> > When there is a failure in f2fs_fill_super() after/during
> > the recovery of fsync'd nodes, it frees the current sbi and
> > retries again. This time the mount is successful, but the files
> > that got recovered before retry, still holds the extent tree,
> > whose extent nodes list is corrupted since sbi and sbi->extent_list
> > is freed up. The list_del corruption issue is observed when the
> > file system is getting unmounted and when those recoverd files extent
> > node is being freed up in the below context.
> > 
> > list_del corruption. prev->next should be fffffff1e1ef5480, but was (null)
> > <...>
> > kernel BUG at kernel/msm-4.14/lib/list_debug.c:53!
> > task: fffffff1f46f2280 task.stack: ffffff8008068000
> > lr : __list_del_entry_valid+0x94/0xb4
> > pc : __list_del_entry_valid+0x94/0xb4
> > <...>
> > Call trace:
> > __list_del_entry_valid+0x94/0xb4
> > __release_extent_node+0xb0/0x114
> > __free_extent_tree+0x58/0x7c
> > f2fs_shrink_extent_tree+0xdc/0x3b0
> > f2fs_leave_shrinker+0x28/0x7c
> > f2fs_put_super+0xfc/0x1e0
> > generic_shutdown_super+0x70/0xf4
> > kill_block_super+0x2c/0x5c
> > kill_f2fs_super+0x44/0x50
> > deactivate_locked_super+0x60/0x8c
> > deactivate_super+0x68/0x74
> > cleanup_mnt+0x40/0x78
> > __cleanup_mnt+0x1c/0x28
> > task_work_run+0x48/0xd0
> > do_notify_resume+0x678/0xe98
> > work_pending+0x8/0x14
> > 
> > Fix this by cleaning up inodes, extent tree and nodes of those
> > recovered files before freeing up sbi and before next retry.
> > 
> Hi Jaegeuk, Chao,
> 
> I have observed another scenario where the similar list corruption issue
> can happen with sbi->inode_list as well. If recover_fsync_data()
> fails at some point in write_checkpoint() due to some error and if
> those recovered inodes are still dirty, then after the mount is
> successful, this issue is observed when that dirty inode is under 
> writeback.

recover_fsync_data() does iget/iput in pair, and destroy_fsync_dnodes() drops
its dirty list and call iput(), when there is an error. So, after then, there'd
be no dirty inodes. If there's no error, checkpoint() flushes quota/dentry pages
in dirty inodes as well. Can we check where this dirty inode came from?

Oh, one sceanrio can be an error by f2fs_disable_checkpoint() which will do GC.

> 
> [   90.400500] list_del corruption. prev->next should be ffffffed1f566208, but was (null)
> [   90.675349] Call trace:
> [   90.677869]  __list_del_entry_valid+0x94/0xb4
> [   90.682351]  remove_dirty_inode+0xac/0x114
> [   90.686563]  __f2fs_write_data_pages+0x6a8/0x6c8
> [   90.691302]  f2fs_write_data_pages+0x40/0x4c
> [   90.695695]  do_writepages+0x80/0xf0
> [   90.699372]  __writeback_single_inode+0xdc/0x4ac
> [   90.704113]  writeback_sb_inodes+0x280/0x440
> [   90.708501]  wb_writeback+0x1b8/0x3d0
> [   90.712267]  wb_workfn+0x1a8/0x4d4
> [   90.715765]  process_one_work+0x1c0/0x3d4
> [   90.719883]  worker_thread+0x224/0x344
> [   90.723739]  kthread+0x120/0x130
> [   90.727055]  ret_from_fork+0x10/0x18
> 
> I think it is better to cleanup those inodes completely before freeing sbi
> and before next retry as done in this patch. Would you like to re-consider
> this patch for this new issue?

The patch was merged in mainline already.
Could you take a look at this patch?

From cb1d20e640402beed300c2bdce79311ee8a781ad Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri, 4 Jan 2019 12:29:00 -0800
Subject: [PATCH] f2fs: sync filesystem after roll-forward recovery

Some works after roll-forward recovery can get an error which will release
all the data structures. Let's flush them in order to make it clean.

One possible corruption came from:

[   90.400500] list_del corruption. prev->next should be ffffffed1f566208, but was (null)
[   90.675349] Call trace:
[   90.677869]  __list_del_entry_valid+0x94/0xb4
[   90.682351]  remove_dirty_inode+0xac/0x114
[   90.686563]  __f2fs_write_data_pages+0x6a8/0x6c8
[   90.691302]  f2fs_write_data_pages+0x40/0x4c
[   90.695695]  do_writepages+0x80/0xf0
[   90.699372]  __writeback_single_inode+0xdc/0x4ac
[   90.704113]  writeback_sb_inodes+0x280/0x440
[   90.708501]  wb_writeback+0x1b8/0x3d0
[   90.712267]  wb_workfn+0x1a8/0x4d4
[   90.715765]  process_one_work+0x1c0/0x3d4
[   90.719883]  worker_thread+0x224/0x344
[   90.723739]  kthread+0x120/0x130
[   90.727055]  ret_from_fork+0x10/0x18

Reported-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 547cb7459be7..bb02186293a3 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3357,7 +3357,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	if (test_opt(sbi, DISABLE_CHECKPOINT)) {
 		err = f2fs_disable_checkpoint(sbi);
 		if (err)
-			goto free_meta;
+			goto sync_free_meta;
 	} else if (is_set_ckpt_flags(sbi, CP_DISABLED_FLAG)) {
 		f2fs_enable_checkpoint(sbi);
 	}
@@ -3370,7 +3370,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		/* After POR, we can run background GC thread.*/
 		err = f2fs_start_gc_thread(sbi);
 		if (err)
-			goto free_meta;
+			goto sync_free_meta;
 	}
 	kvfree(options);
 
@@ -3392,6 +3392,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	f2fs_update_time(sbi, REQ_TIME);
 	return 0;
 
+sync_free_meta:
+	/* safe to flush all the data */
+	sync_filesystem(sbi->sb);
+
 free_meta:
 	/* flush dirty orphan inode objects */
 	f2fs_sync_inode_meta(sbi);
-- 
2.19.0.605.g01d371f741-goog

