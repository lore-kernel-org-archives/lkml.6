Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031159AbeEZGLo (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 02:11:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8148 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031077AbeEZGLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 02:11:43 -0400
Subject: Re: [PATCH v2] f2fs: let fstrim issue discard commands in lower
 priority
To: Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20180525051031.36443-1-jaegeuk@kernel.org>
 <20180525194916.GA52740@jaegeuk-macbookpro.roam.corp.google.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <c96fbf7f-edfa-29c0-2364-31e943737500@huawei.com>
Date: Sat, 26 May 2018 14:11:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180525194916.GA52740@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/5/26 3:49, Jaegeuk Kim wrote:
> The fstrim gathers huge number of large discard commands, and tries to issue
> without IO awareness, which results in long user-perceive IO latencies on
> READ, WRITE, and FLUSH in UFS. We've observed some of commands take several
> seconds due to long discard latency.
> 
> This patch limits the maximum size to 2MB per candidate, and check IO congestion
> when issuing them to disk.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> 
> Change log from v1:
>  - wait all discard bios in put_super & congested case in trimfs
> 
>  fs/f2fs/f2fs.h    |   4 +-
>  fs/f2fs/segment.c | 139 +++++++++++++++++++++++++---------------------
>  2 files changed, 78 insertions(+), 65 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 3cc56b4df03f..6e0677aff8ca 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -178,6 +178,7 @@ enum {
>  
>  #define MAX_DISCARD_BLOCKS(sbi)		BLKS_PER_SEC(sbi)
>  #define DEF_MAX_DISCARD_REQUEST		8	/* issue 8 discards per round */
> +#define DEF_MAX_DISCARD_LEN		512	/* Max. 2MB per discard */
>  #define DEF_MIN_DISCARD_ISSUE_TIME	50	/* 50 ms, if exists */
>  #define DEF_MID_DISCARD_ISSUE_TIME	500	/* 500 ms, if device busy */
>  #define DEF_MAX_DISCARD_ISSUE_TIME	60000	/* 60 s, if no candidates */
> @@ -698,7 +699,8 @@ static inline void set_extent_info(struct extent_info *ei, unsigned int fofs,
>  static inline bool __is_discard_mergeable(struct discard_info *back,
>  						struct discard_info *front)
>  {
> -	return back->lstart + back->len == front->lstart;
> +	return (back->lstart + back->len == front->lstart) &&
> +		(back->len + front->len < DEF_MAX_DISCARD_LEN);
>  }
>  
>  static inline bool __is_discard_back_mergeable(struct discard_info *cur,
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index c67d92bf2968..0150719e580d 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1139,68 +1139,6 @@ static int __queue_discard_cmd(struct f2fs_sb_info *sbi,
>  	return 0;
>  }
>  
> -static void __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
> -					struct discard_policy *dpolicy,
> -					unsigned int start, unsigned int end)
> -{
> -	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> -	struct discard_cmd *prev_dc = NULL, *next_dc = NULL;
> -	struct rb_node **insert_p = NULL, *insert_parent = NULL;
> -	struct discard_cmd *dc;
> -	struct blk_plug plug;
> -	int issued;
> -
> -next:
> -	issued = 0;
> -
> -	mutex_lock(&dcc->cmd_lock);
> -	f2fs_bug_on(sbi, !__check_rb_tree_consistence(sbi, &dcc->root));
> -
> -	dc = (struct discard_cmd *)__lookup_rb_tree_ret(&dcc->root,
> -					NULL, start,
> -					(struct rb_entry **)&prev_dc,
> -					(struct rb_entry **)&next_dc,
> -					&insert_p, &insert_parent, true);
> -	if (!dc)
> -		dc = next_dc;
> -
> -	blk_start_plug(&plug);
> -
> -	while (dc && dc->lstart <= end) {
> -		struct rb_node *node;
> -
> -		if (dc->len < dpolicy->granularity)
> -			goto skip;
> -
> -		if (dc->state != D_PREP) {
> -			list_move_tail(&dc->list, &dcc->fstrim_list);
> -			goto skip;
> -		}
> -
> -		__submit_discard_cmd(sbi, dpolicy, dc);
> -
> -		if (++issued >= dpolicy->max_requests) {
> -			start = dc->lstart + dc->len;
> -
> -			blk_finish_plug(&plug);
> -			mutex_unlock(&dcc->cmd_lock);
> -
> -			schedule();
> -
> -			goto next;
> -		}
> -skip:
> -		node = rb_next(&dc->rb_node);
> -		dc = rb_entry_safe(node, struct discard_cmd, rb_node);
> -
> -		if (fatal_signal_pending(current))
> -			break;
> -	}
> -
> -	blk_finish_plug(&plug);
> -	mutex_unlock(&dcc->cmd_lock);
> -}
> -
>  static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>  					struct discard_policy *dpolicy)
>  {
> @@ -1341,7 +1279,18 @@ static unsigned int __wait_discard_cmd_range(struct f2fs_sb_info *sbi,
>  static void __wait_all_discard_cmd(struct f2fs_sb_info *sbi,
>  						struct discard_policy *dpolicy)
>  {
> -	__wait_discard_cmd_range(sbi, dpolicy, 0, UINT_MAX);
> +	struct discard_policy dp;
> +
> +	if (dpolicy) {
> +		__wait_discard_cmd_range(sbi, dpolicy, 0, UINT_MAX);
> +		return;
> +	}
> +
> +	/* wait all */
> +	init_discard_policy(&dp, DPOLICY_FSTRIM, 1);
> +	__wait_discard_cmd_range(sbi, &dp, 0, UINT_MAX);
> +	init_discard_policy(&dp, DPOLICY_UMOUNT, 1);
> +	__wait_discard_cmd_range(sbi, &dp, 0, UINT_MAX);
>  }
>  
>  /* This should be covered by global mutex, &sit_i->sentry_lock */
> @@ -1389,8 +1338,9 @@ bool f2fs_wait_discard_bios(struct f2fs_sb_info *sbi)
>  	init_discard_policy(&dpolicy, DPOLICY_UMOUNT, dcc->discard_granularity);
>  	__issue_discard_cmd(sbi, &dpolicy);
>  	dropped = __drop_discard_cmd(sbi);
> -	__wait_all_discard_cmd(sbi, &dpolicy);
>  
> +	/* just to make sure there is no pending discard commands */
> +	__wait_all_discard_cmd(sbi, NULL);
>  	return dropped;
>  }
>  
> @@ -2397,6 +2347,67 @@ bool exist_trim_candidates(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	return has_candidate;
>  }
>  
> +static void __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
> +					struct discard_policy *dpolicy,
> +					unsigned int start, unsigned int end)
> +{
> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +	struct discard_cmd *prev_dc = NULL, *next_dc = NULL;
> +	struct rb_node **insert_p = NULL, *insert_parent = NULL;
> +	struct discard_cmd *dc;
> +	struct blk_plug plug;
> +	int issued;
> +
> +next:
> +	issued = 0;
> +
> +	mutex_lock(&dcc->cmd_lock);
> +	f2fs_bug_on(sbi, !__check_rb_tree_consistence(sbi, &dcc->root));
> +
> +	dc = (struct discard_cmd *)__lookup_rb_tree_ret(&dcc->root,
> +					NULL, start,
> +					(struct rb_entry **)&prev_dc,
> +					(struct rb_entry **)&next_dc,
> +					&insert_p, &insert_parent, true);
> +	if (!dc)
> +		dc = next_dc;
> +
> +	blk_start_plug(&plug);
> +
> +	while (dc && dc->lstart <= end) {
> +		struct rb_node *node;
> +
> +		if (dc->len < dpolicy->granularity)
> +			goto skip;
> +
> +		if (dc->state != D_PREP) {
> +			list_move_tail(&dc->list, &dcc->fstrim_list);
> +			goto skip;
> +		}
> +
> +		__submit_discard_cmd(sbi, dpolicy, dc);
> +
> +		if (++issued >= dpolicy->max_requests) {
> +			start = dc->lstart + dc->len;
> +
> +			blk_finish_plug(&plug);
> +			mutex_unlock(&dcc->cmd_lock);
> +			__wait_all_discard_cmd(sbi, NULL);

We need to propagate return value from __wait_discard_cmd_range to
__wait_all_discard_cmd, and then stat trimmed block count with return value of
__wait_all_discard_cmd, otherwise, we will get wrong trimmed block count in
f2fs_trim_fs.

Thanks,

> +			congestion_wait(BLK_RW_ASYNC, HZ/50);
> +			goto next;
> +		}
> +skip:
> +		node = rb_next(&dc->rb_node);
> +		dc = rb_entry_safe(node, struct discard_cmd, rb_node);
> +
> +		if (fatal_signal_pending(current))
> +			break;
> +	}
> +
> +	blk_finish_plug(&plug);
> +	mutex_unlock(&dcc->cmd_lock);
> +}
> +
>  int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
>  {
>  	__u64 start = F2FS_BYTES_TO_BLK(range->start);
> 
