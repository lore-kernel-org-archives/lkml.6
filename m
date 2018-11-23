Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67388C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 03:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F7720672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 03:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dHO8t3Tv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Bo92dJ6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F7720672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408043AbeKWOYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 09:24:50 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37148 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393088AbeKWOYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 09:24:50 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 50EBC606DB; Fri, 23 Nov 2018 03:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542944544;
        bh=nynsI0kZEexZFuImh7SAzRBeRwXdDYhTK29Boc/12rE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dHO8t3Tv5AX8DKrNexHxUCQ+QlWdT7Z234ul3O+HzpmUF2D3nGQ/QKPgILvAAcAQR
         dLt/xNFpw5y8sjUBtXlc8Mv1qi6shoUN9ABBlJJjariHhCecxHtodeqCTX7/6TWmHD
         TizexAuOYwJdlK6VUiDqC7kkn6hR8J59HMq0WlCA=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AD3F5606DB;
        Fri, 23 Nov 2018 03:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542944543;
        bh=nynsI0kZEexZFuImh7SAzRBeRwXdDYhTK29Boc/12rE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bo92dJ6xUSvKvUIOxTPj86/ooA9iyaqzLNLrsJQlDqg9XpLUtqeVgsyJtGevPr5iy
         lYAdPaNB1XRlHGh+wGU42NcznNEaZ0g3GVHwu3OEwg+yPPPbFoLuA869dxgaX4JioW
         fe+ac9pMEB17YgeALTcShM0BJGeJrupnT0K1Oy1c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AD3F5606DB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Fri, 23 Nov 2018 09:12:18 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] f2fs: fix sbi->extent_list corruption issue
Message-ID: <20181123034218.GA9838@codeaurora.org>
References: <1542884360-19470-1-git-send-email-stummala@codeaurora.org>
 <a1e799ad-a559-12cc-9f2d-a6f037640a35@huawei.com>
 <20181122121107.GB52295@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122121107.GB52295@jaegeuk-macbookpro.roam.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 04:11:07AM -0800, Jaegeuk Kim wrote:
> On 11/22, Chao Yu wrote:
> > On 2018/11/22 18:59, Sahitya Tummala wrote:
> > > When there is a failure in f2fs_fill_super() after/during
> > > the recovery of fsync'd nodes, it frees the current sbi and
> > > retries again. This time the mount is successful, but the files
> > > that got recovered before retry, still holds the extent tree,
> > > whose extent nodes list is corrupted since sbi and sbi->extent_list
> > > is freed up. The list_del corruption issue is observed when the
> > > file system is getting unmounted and when those recoverd files extent
> > > node is being freed up in the below context.
> > > 
> > > list_del corruption. prev->next should be fffffff1e1ef5480, but was (null)
> > > <...>
> > > kernel BUG at kernel/msm-4.14/lib/list_debug.c:53!
> > > task: fffffff1f46f2280 task.stack: ffffff8008068000
> > > lr : __list_del_entry_valid+0x94/0xb4
> > > pc : __list_del_entry_valid+0x94/0xb4
> > > <...>
> > > Call trace:
> > > __list_del_entry_valid+0x94/0xb4
> > > __release_extent_node+0xb0/0x114
> > > __free_extent_tree+0x58/0x7c
> > > f2fs_shrink_extent_tree+0xdc/0x3b0
> > > f2fs_leave_shrinker+0x28/0x7c
> > > f2fs_put_super+0xfc/0x1e0
> > > generic_shutdown_super+0x70/0xf4
> > > kill_block_super+0x2c/0x5c
> > > kill_f2fs_super+0x44/0x50
> > > deactivate_locked_super+0x60/0x8c
> > > deactivate_super+0x68/0x74
> > > cleanup_mnt+0x40/0x78
> > > __cleanup_mnt+0x1c/0x28
> > > task_work_run+0x48/0xd0
> > > do_notify_resume+0x678/0xe98
> > > work_pending+0x8/0x14
> > > 
> > > Fix this by cleaning up the extent tree of those recovered files
> > > before freeing up sbi and before next retry.
> > 
> > Would it be more clear to call shrink_dcache_sb earlier to invalid all
> > inodes and call f2fs_shrink_extent_tree release cached entries and trees in
> > error path?
> 
> Agreed.
> 
I have tried doing shrink_dcache_sb() earlier but that doesn't call
f2fs_shrink_extent_tree(). So I have moved f2fs_join_shrinker() earlier and 
tried calling f2fs_leave_shrinker() in the error path. That helps to clean up
the cached extent nodes. However, I see that extent tree is left intact for
those recovered files, which should not be a problem as it gets freed as part
of next umount/rm. Only one small problem I see with this is - during rm/umount when
those previoulsy recovered files are being evicted, extent tree memory gets
free'd but the counter sbi->total_ext_tree gets invalid as these recovered
files are not present as part of current sbi->extent_tree_root. So i have come
up with this patch below to fix this. Let me know if this looks good?

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 1cb0fcc..3e4801e 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -654,9 +654,9 @@ unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
 		}
 		f2fs_bug_on(sbi, atomic_read(&et->node_cnt));
 		list_del_init(&et->list);
-		radix_tree_delete(&sbi->extent_tree_root, et->ino);
+		if (radix_tree_delete(&sbi->extent_tree_root, et->ino))
+			atomic_dec(&sbi->total_ext_tree);
 		kmem_cache_free(extent_tree_slab, et);
-		atomic_dec(&sbi->total_ext_tree);
 		atomic_dec(&sbi->total_zombie_tree);
 		tree_cnt++;
 
@@ -767,7 +767,8 @@ void f2fs_destroy_extent_tree(struct inode *inode)
 	/* delete extent tree entry in radix tree */
 	mutex_lock(&sbi->extent_tree_lock);
 	f2fs_bug_on(sbi, atomic_read(&et->node_cnt));
-	radix_tree_delete(&sbi->extent_tree_root, inode->i_ino);
+	if (radix_tree_delete(&sbi->extent_tree_root, inode->i_ino))
+		atomic_dec(&sbi->total_ext_tree);
 	kmem_cache_free(extent_tree_slab, et);
 	atomic_dec(&sbi->total_ext_tree);
 	mutex_unlock(&sbi->extent_tree_lock);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index af58b2c..3e5588f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3295,6 +3295,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	if (err)
 		goto free_root_inode;
 
+	f2fs_join_shrinker(sbi);
 #ifdef CONFIG_QUOTA
 	/* Enable quota usage during mount */
 	if (f2fs_sb_has_quota_ino(sb) && !f2fs_readonly(sb)) {
@@ -3379,8 +3380,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 			sbi->valid_super_block ? 1 : 2, err);
 	}
 
-	f2fs_join_shrinker(sbi);
-
 	f2fs_tuning_parameters(sbi);
 
 	f2fs_msg(sbi->sb, KERN_NOTICE, "Mounted with checkpoint version = %llx",
@@ -3402,6 +3401,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	 * falls into an infinite loop in f2fs_sync_meta_pages().
 	 */
 	truncate_inode_pages_final(META_MAPPING(sbi));
+	shrink_dcache_sb(sb);
+	f2fs_leave_shrinker(sbi);
 	f2fs_unregister_sysfs(sbi);
 free_root_inode:
 	dput(sb->s_root);
@@ -3445,7 +3446,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	/* give only one another chance */
 	if (retry) {
 		retry = false;
-		shrink_dcache_sb(sb);
 		goto try_onemore;
 	}
 	return err;

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
