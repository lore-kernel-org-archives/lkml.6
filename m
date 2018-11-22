Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB41C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883F6204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 883F6204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391010AbeKVWzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 17:55:37 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:46062 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732390AbeKVWzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 17:55:37 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 04F1CAACC4862;
        Thu, 22 Nov 2018 20:16:21 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Thu, 22 Nov 2018
 20:16:17 +0800
Subject: Re: [PATCH 2/2] f2fs: fix memory leak of quota files extent tree and
 it's nodes
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>
References: <1542884360-19470-1-git-send-email-stummala@codeaurora.org>
 <1542884360-19470-2-git-send-email-stummala@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <47e3b4e7-c1a6-f130-5765-d212ac9de367@huawei.com>
Date:   Thu, 22 Nov 2018 20:16:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1542884360-19470-2-git-send-email-stummala@codeaurora.org>
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
> When there is a failure in f2fs_fill_super() after the quota is
> enabled, then f2fs_quota_off_umount() is called in the error handling.
> Then sbi is freed up and f2fs_fill_super() retries again.
> But f2fs_quota_off_umount() doesn't guarantee that quota file's extent
> tree/nodes are removed/freed. It will just add to sbi->zombie_list,
> if those files are referenced. In the next retry, quota is enabled
> again with the new extent tree and nodes, causing memory leak for the
> previously allocated memory.
> 
> Fix this by cleaning up the sbi->zombie_list before freeing sbi and
> before the next retry.

I guess we can fix this issue with the same way as the comment I add in
your previous patch, how do you think?

Thanks,

> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> ---
>  fs/f2fs/extent_cache.c | 21 +++++++++++++++++++++
>  fs/f2fs/f2fs.h         |  1 +
>  fs/f2fs/super.c        |  5 +++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index 763ba83..c2bcd88 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -629,6 +629,27 @@ static void f2fs_update_extent_tree_range(struct inode *inode,
>  		f2fs_mark_inode_dirty_sync(inode, true);
>  }
>  
> +void f2fs_cleanup_zombie_list(struct f2fs_sb_info *sbi)
> +{
> +	struct extent_tree *et, *next;
> +
> +	mutex_lock(&sbi->extent_tree_lock);
> +	list_for_each_entry_safe(et, next, &sbi->zombie_list, list) {
> +		if (atomic_read(&et->node_cnt)) {
> +			write_lock(&et->lock);
> +			__free_extent_tree(sbi, et);
> +			write_unlock(&et->lock);
> +		}
> +		f2fs_bug_on(sbi, atomic_read(&et->node_cnt));
> +		list_del_init(&et->list);
> +		radix_tree_delete(&sbi->extent_tree_root, et->ino);
> +		kmem_cache_free(extent_tree_slab, et);
> +		atomic_dec(&sbi->total_ext_tree);
> +		atomic_dec(&sbi->total_zombie_tree);
> +	}
> +	mutex_unlock(&sbi->extent_tree_lock);
> +}
> +
>  unsigned int f2fs_shrink_extent_tree(struct f2fs_sb_info *sbi, int nr_shrink)
>  {
>  	struct extent_tree *et, *next;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index db8a919..6807815 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3419,6 +3419,7 @@ void f2fs_update_extent_cache_range(struct dnode_of_data *dn,
>  void f2fs_init_extent_cache_info(struct f2fs_sb_info *sbi);
>  int __init f2fs_create_extent_cache(void);
>  void f2fs_destroy_extent_cache(void);
> +void f2fs_cleanup_zombie_list(struct f2fs_sb_info *sbi);
>  
>  /*
>   * sysfs.c
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index f41ac43..521fe3f 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3023,6 +3023,11 @@ void f2fs_cleanup_extent_cache(struct f2fs_sb_info *sbi)
>  
>  	list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list)
>  		f2fs_destroy_extent_tree(inode, true);
> +
> +	f2fs_cleanup_zombie_list(sbi);
> +
> +	f2fs_bug_on(sbi, !list_empty(&sbi->zombie_list));
> +	f2fs_bug_on(sbi, !list_empty(&sbi->extent_list));
>  }
>  
>  static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
> 

