Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E98C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E22720665
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SbkuXTm8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eH2L56tU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfADIFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 03:05:43 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57842 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfADIFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 03:05:43 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 12DAF60591; Fri,  4 Jan 2019 08:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546589142;
        bh=oLh3uk4WXWvf2nW2RhQW1Sf6A1lSwglsW68u1ASbH0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SbkuXTm8TazX9ssVfxWO+Ve4g2mg3JeHNPooQQWWns8jRZdUvnVCIGtBPX/dOxASQ
         qYEyYypBe/0asHFDivrnNFHj/WWbleVa0SJKKOESLc8lhBV3+ifbSA1O6rSiu1VvlG
         EofnmVUGw1ZXGv3kCkgILFsha2R0nog0r482GDgQ=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 57B77602FE;
        Fri,  4 Jan 2019 08:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546589140;
        bh=oLh3uk4WXWvf2nW2RhQW1Sf6A1lSwglsW68u1ASbH0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eH2L56tUHYTNCJMk/EMjC7g9bxk71er7s8jK18TJeL8CWncPvGAH9fFvHiDVrftGg
         OoamD948Rm2WuQKlO/brt6ejr1mUr63TxeP5meweHrnsqHSoa+3xHNlxSGbTQonHF0
         25sYQrh8e/UHtrB9SiYpzaaRu7T0KB/7z8obz8Hc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 57B77602FE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Fri, 4 Jan 2019 13:35:35 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: fix sbi->extent_list corruption issue
Message-ID: <20190104080535.GB8475@codeaurora.org>
References: <1543207640-31033-1-git-send-email-stummala@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543207640-31033-1-git-send-email-stummala@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 10:17:20AM +0530, Sahitya Tummala wrote:
> When there is a failure in f2fs_fill_super() after/during
> the recovery of fsync'd nodes, it frees the current sbi and
> retries again. This time the mount is successful, but the files
> that got recovered before retry, still holds the extent tree,
> whose extent nodes list is corrupted since sbi and sbi->extent_list
> is freed up. The list_del corruption issue is observed when the
> file system is getting unmounted and when those recoverd files extent
> node is being freed up in the below context.
> 
> list_del corruption. prev->next should be fffffff1e1ef5480, but was (null)
> <...>
> kernel BUG at kernel/msm-4.14/lib/list_debug.c:53!
> task: fffffff1f46f2280 task.stack: ffffff8008068000
> lr : __list_del_entry_valid+0x94/0xb4
> pc : __list_del_entry_valid+0x94/0xb4
> <...>
> Call trace:
> __list_del_entry_valid+0x94/0xb4
> __release_extent_node+0xb0/0x114
> __free_extent_tree+0x58/0x7c
> f2fs_shrink_extent_tree+0xdc/0x3b0
> f2fs_leave_shrinker+0x28/0x7c
> f2fs_put_super+0xfc/0x1e0
> generic_shutdown_super+0x70/0xf4
> kill_block_super+0x2c/0x5c
> kill_f2fs_super+0x44/0x50
> deactivate_locked_super+0x60/0x8c
> deactivate_super+0x68/0x74
> cleanup_mnt+0x40/0x78
> __cleanup_mnt+0x1c/0x28
> task_work_run+0x48/0xd0
> do_notify_resume+0x678/0xe98
> work_pending+0x8/0x14
> 
> Fix this by cleaning up inodes, extent tree and nodes of those
> recovered files before freeing up sbi and before next retry.
> 
Hi Jaegeuk, Chao,

I have observed another scenario where the similar list corruption issue
can happen with sbi->inode_list as well. If recover_fsync_data()
fails at some point in write_checkpoint() due to some error and if
those recovered inodes are still dirty, then after the mount is
successful, this issue is observed when that dirty inode is under 
writeback.

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

I think it is better to cleanup those inodes completely before freeing sbi
and before next retry as done in this patch. Would you like to re-consider
this patch for this new issue?

Please share your comments.

Thanks,

> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> ---
> v2:
> -call evict_inodes() and f2fs_shrink_extent_tree() to cleanup inodes
> 
>  fs/f2fs/f2fs.h     |  1 +
>  fs/f2fs/shrinker.c |  2 +-
>  fs/f2fs/super.c    | 13 ++++++++++++-
>  3 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 1e03197..aaee63b 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3407,6 +3407,7 @@ struct rb_entry *f2fs_lookup_rb_tree_ret(struct rb_root_cached *root,
>  bool f2fs_check_rb_tree_consistence(struct f2fs_sb_info *sbi,
>  						struct rb_root_cached *root);
>  unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink);
> +unsigned long __count_extent_cache(struct f2fs_sb_info *sbi);
>  bool f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext);
>  void f2fs_drop_extent_tree(struct inode *inode);
>  unsigned int f2fs_destroy_extent_node(struct inode *inode);
> diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
> index 9e13db9..7e3c13b 100644
> --- a/fs/f2fs/shrinker.c
> +++ b/fs/f2fs/shrinker.c
> @@ -30,7 +30,7 @@ static unsigned long __count_free_nids(struct f2fs_sb_info *sbi)
>  	return count > 0 ? count : 0;
>  }
>  
> -static unsigned long __count_extent_cache(struct f2fs_sb_info *sbi)
> +unsigned long __count_extent_cache(struct f2fs_sb_info *sbi)
>  {
>  	return atomic_read(&sbi->total_zombie_tree) +
>  				atomic_read(&sbi->total_ext_node);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index af58b2c..769e7b1 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3016,6 +3016,16 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
>  	sbi->readdir_ra = 1;
>  }
>  
> +static void f2fs_cleanup_inodes(struct f2fs_sb_info *sbi)
> +{
> +	struct super_block *sb = sbi->sb;
> +
> +	sync_filesystem(sb);
> +	shrink_dcache_sb(sb);
> +	evict_inodes(sb);
> +	f2fs_shrink_extent_tree(sbi, __count_extent_cache(sbi));
> +}
> +
>  static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  {
>  	struct f2fs_sb_info *sbi;
> @@ -3402,6 +3412,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  	 * falls into an infinite loop in f2fs_sync_meta_pages().
>  	 */
>  	truncate_inode_pages_final(META_MAPPING(sbi));
> +	/* cleanup recovery and quota inodes */
> +	f2fs_cleanup_inodes(sbi);
>  	f2fs_unregister_sysfs(sbi);
>  free_root_inode:
>  	dput(sb->s_root);
> @@ -3445,7 +3457,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  	/* give only one another chance */
>  	if (retry) {
>  		retry = false;
> -		shrink_dcache_sb(sb);
>  		goto try_onemore;
>  	}
>  	return err;
> -- 
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
> 

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
