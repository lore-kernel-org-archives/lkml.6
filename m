Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36190C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025AE21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfAXIm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:42:56 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:56358 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727363AbfAXIm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 03:42:56 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8841E5BB4F345BFE8413;
        Thu, 24 Jan 2019 16:42:53 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Thu, 24 Jan 2019
 16:42:51 +0800
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: sync filesystem after roll-forward
 recovery
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190123000229.45236-1-jaegeuk@kernel.org>
 <20190123000229.45236-2-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <fc1eab1c-f752-c44a-6ebf-338b1fdad741@huawei.com>
Date:   Thu, 24 Jan 2019 16:42:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190123000229.45236-2-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/23 8:02, Jaegeuk Kim wrote:
> Some works after roll-forward recovery can get an error which will release
> all the data structures. Let's flush them in order to make it clean.
> 
> One possible corruption came from:
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
> Reported-by: Sahitya Tummala <stummala@codeaurora.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/checkpoint.c |  5 +++--
>  fs/f2fs/node.c       |  4 +++-
>  fs/f2fs/super.c      | 42 +++++++++++++++++++++++++++++++-----------
>  3 files changed, 37 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index f955cd3e0677..ccccf0ce2f06 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -306,8 +306,9 @@ static int f2fs_write_meta_pages(struct address_space *mapping,
>  		goto skip_write;
>  
>  	/* collect a number of dirty meta pages and write together */
> -	if (wbc->for_kupdate ||
> -		get_pages(sbi, F2FS_DIRTY_META) < nr_pages_to_skip(sbi, META))
> +	if (wbc->sync_mode != WB_SYNC_ALL &&
> +			get_pages(sbi, F2FS_DIRTY_META) <
> +					nr_pages_to_skip(sbi, META))
>  		goto skip_write;
>  
>  	/* if locked failed, cp will flush dirty pages instead */
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 4f450e573312..f6ff84e29749 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1920,7 +1920,9 @@ static int f2fs_write_node_pages(struct address_space *mapping,
>  	f2fs_balance_fs_bg(sbi);
>  
>  	/* collect a number of dirty node pages and write together */
> -	if (get_pages(sbi, F2FS_DIRTY_NODES) < nr_pages_to_skip(sbi, NODE))
> +	if (wbc->sync_mode != WB_SYNC_ALL &&
> +			get_pages(sbi, F2FS_DIRTY_NODES) <
> +					nr_pages_to_skip(sbi, NODE))
>  		goto skip_write;
>  
>  	if (wbc->sync_mode == WB_SYNC_ALL)
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 7998ff5418f2..2af0db2b738e 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1456,9 +1456,16 @@ static int f2fs_enable_quotas(struct super_block *sb);
>  
>  static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
>  {
> +	unsigned int s_flags = sbi->sb->s_flags;
>  	struct cp_control cpc;
> -	int err;
> +	int err = 0;
> +	int ret;
>  
> +	if (s_flags & SB_RDONLY) {
> +		f2fs_msg(sbi->sb, KERN_ERR,
> +				"checkpoint=disable on readonly fs");
> +		return -EINVAL;
> +	}
>  	sbi->sb->s_flags |= SB_ACTIVE;
>  
>  	f2fs_update_time(sbi, DISABLE_TIME);
> @@ -1466,18 +1473,24 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
>  	while (!f2fs_time_over(sbi, DISABLE_TIME)) {
>  		mutex_lock(&sbi->gc_mutex);
>  		err = f2fs_gc(sbi, true, false, NULL_SEGNO);
> -		if (err == -ENODATA)
> +		if (err == -ENODATA) {
> +			err = 0;
>  			break;
> +		}
>  		if (err && err != -EAGAIN)
> -			return err;
> +			break;

Should be?

if (err) {
	if (err == -EAGAIN)
		err = 0;
	else
		break;
}

Thanks,

>  	}
>  
> -	err = sync_filesystem(sbi->sb);
> -	if (err)
> -		return err;
> +	ret = sync_filesystem(sbi->sb);
> +	if (ret || err) {
> +		err = ret ? ret: err;
> +		goto restore_flag;
> +	}
>  
> -	if (f2fs_disable_cp_again(sbi))
> -		return -EAGAIN;
> +	if (f2fs_disable_cp_again(sbi)) {
> +		err = -EAGAIN;
> +		goto restore_flag;
> +	}
>  
>  	mutex_lock(&sbi->gc_mutex);
>  	cpc.reason = CP_PAUSE;
> @@ -1486,7 +1499,9 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
>  
>  	sbi->unusable_block_count = 0;
>  	mutex_unlock(&sbi->gc_mutex);
> -	return 0;
> +restore_flag:
> +	sbi->sb->s_flags = s_flags;	/* Restore MS_RDONLY status */
> +	return err;
>  }
>  
>  static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
> @@ -3356,7 +3371,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  	if (test_opt(sbi, DISABLE_CHECKPOINT)) {
>  		err = f2fs_disable_checkpoint(sbi);
>  		if (err)
> -			goto free_meta;
> +			goto sync_free_meta;
>  	} else if (is_set_ckpt_flags(sbi, CP_DISABLED_FLAG)) {
>  		f2fs_enable_checkpoint(sbi);
>  	}
> @@ -3369,7 +3384,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  		/* After POR, we can run background GC thread.*/
>  		err = f2fs_start_gc_thread(sbi);
>  		if (err)
> -			goto free_meta;
> +			goto sync_free_meta;
>  	}
>  	kvfree(options);
>  
> @@ -3391,6 +3406,11 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  	f2fs_update_time(sbi, REQ_TIME);
>  	return 0;
>  
> +sync_free_meta:
> +	/* safe to flush all the data */
> +	sync_filesystem(sbi->sb);
> +	retry = false;
> +
>  free_meta:
>  #ifdef CONFIG_QUOTA
>  	f2fs_truncate_quota_inode_pages(sb);
> 

