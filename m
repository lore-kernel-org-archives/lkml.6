Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA3CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0026320663
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0026320663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394866AbeKVWbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:31:00 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15130 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730549AbeKVWbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 17:31:00 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 76C04FA38D2F;
        Thu, 22 Nov 2018 19:51:52 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Thu, 22 Nov 2018
 19:51:50 +0800
Subject: Re: [PATCH 1/2] f2fs: fix sbi->extent_list corruption issue
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>
References: <1542884360-19470-1-git-send-email-stummala@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <a1e799ad-a559-12cc-9f2d-a6f037640a35@huawei.com>
Date:   Thu, 22 Nov 2018 19:51:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1542884360-19470-1-git-send-email-stummala@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/22 18:59, Sahitya Tummala wrote:
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
> Fix this by cleaning up the extent tree of those recovered files
> before freeing up sbi and before next retry.

Would it be more clear to call shrink_dcache_sb earlier to invalid all
inodes and call f2fs_shrink_extent_tree release cached entries and trees in
error path?

BTW, I don't see any benefit of retry flow in fill_super, I guess we can
avoid it to simply fill_super flow?

To Jaegeuk, how do you think?

Thanks,

> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> ---
>  fs/f2fs/extent_cache.c |  6 +++++-
>  fs/f2fs/f2fs.h         |  2 +-
>  fs/f2fs/inode.c        |  2 +-
>  fs/f2fs/super.c        | 10 ++++++++++
>  4 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index 1cb0fcc..763ba83 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -743,7 +743,7 @@ void f2fs_drop_extent_tree(struct inode *inode)
>  		f2fs_mark_inode_dirty_sync(inode, true);
>  }
>  
> -void f2fs_destroy_extent_tree(struct inode *inode)
> +void f2fs_destroy_extent_tree(struct inode *inode, bool force)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	struct extent_tree *et = F2FS_I(inode)->extent_tree;
> @@ -752,6 +752,9 @@ void f2fs_destroy_extent_tree(struct inode *inode)
>  	if (!et)
>  		return;
>  
> +	if (force)
> +		goto destroy_et;
> +
>  	if (inode->i_nlink && !is_bad_inode(inode) &&
>  					atomic_read(&et->node_cnt)) {
>  		mutex_lock(&sbi->extent_tree_lock);
> @@ -761,6 +764,7 @@ void f2fs_destroy_extent_tree(struct inode *inode)
>  		return;
>  	}
>  
> +destroy_et:
>  	/* free all extent info belong to this extent tree */
>  	node_cnt = f2fs_destroy_extent_node(inode);
>  
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 1e03197..db8a919 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3410,7 +3410,7 @@ bool f2fs_check_rb_tree_consistence(struct f2fs_sb_info *sbi,
>  bool f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext);
>  void f2fs_drop_extent_tree(struct inode *inode);
>  unsigned int f2fs_destroy_extent_node(struct inode *inode);
> -void f2fs_destroy_extent_tree(struct inode *inode);
> +void f2fs_destroy_extent_tree(struct inode *inode, bool force);
>  bool f2fs_lookup_extent_cache(struct inode *inode, pgoff_t pgofs,
>  			struct extent_info *ei);
>  void f2fs_update_extent_cache(struct dnode_of_data *dn);
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 91ceee0..39e3ade3 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -649,7 +649,7 @@ void f2fs_evict_inode(struct inode *inode)
>  	f2fs_bug_on(sbi, get_dirty_pages(inode));
>  	f2fs_remove_dirty_inode(inode);
>  
> -	f2fs_destroy_extent_tree(inode);
> +	f2fs_destroy_extent_tree(inode, false);
>  
>  	if (inode->i_nlink || is_bad_inode(inode))
>  		goto no_delete;
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index af58b2c..f41ac43 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3016,6 +3016,15 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
>  	sbi->readdir_ra = 1;
>  }
>  
> +void f2fs_cleanup_extent_cache(struct f2fs_sb_info *sbi)
> +{
> +	struct super_block *sb = sbi->sb;
> +	struct inode *inode, *next;
> +
> +	list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list)
> +		f2fs_destroy_extent_tree(inode, true);
> +}
> +
>  static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  {
>  	struct f2fs_sb_info *sbi;
> @@ -3402,6 +3411,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  	 * falls into an infinite loop in f2fs_sync_meta_pages().
>  	 */
>  	truncate_inode_pages_final(META_MAPPING(sbi));
> +	f2fs_cleanup_extent_cache(sbi);
>  	f2fs_unregister_sysfs(sbi);
>  free_root_inode:
>  	dput(sb->s_root);
> 

