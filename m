Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DFBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED122086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfARJBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:01:45 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2200 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726288AbfARJBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:01:45 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 441C4BD7157229702AC5;
        Fri, 18 Jan 2019 17:01:43 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Fri, 18 Jan 2019
 17:01:42 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: run gc/discard jobs when put_super
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190117051700.52062-1-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <0c76260f-52a5-a9cd-eeb5-532139237c31@huawei.com>
Date:   Fri, 18 Jan 2019 17:01:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190117051700.52062-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/17 13:17, Jaegeuk Kim wrote:
> When we umount f2fs, we need to avoid long delay due to discard commands, which
> is actually taking tens of seconds, if storage is very slow on UNMAP. So, this
> patch introduces timeout-based work on it. In addition to discard commands, we
> can also do GC during the given time period.
> 
> By default, let me give 4 seconds for GC and 4 seconds for discard.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/f2fs.h    |  7 ++++++-
>  fs/f2fs/gc.c      | 17 +++++++++++++++++
>  fs/f2fs/segment.c | 14 ++++++++++----
>  fs/f2fs/super.c   | 37 ++++++++++++++++++-------------------
>  fs/f2fs/sysfs.c   |  6 ++++++
>  5 files changed, 57 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 7df41cd1eb35..e56364a2e597 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -191,6 +191,8 @@ enum {
>  #define DEF_CP_INTERVAL			60	/* 60 secs */
>  #define DEF_IDLE_INTERVAL		5	/* 5 secs */
>  #define DEF_DISABLE_INTERVAL		5	/* 5 secs */
> +#define DEF_UMOUNT_GC_TIMEOUT		4	/* 4 secs */
> +#define DEF_UMOUNT_DISCARD_TIMEOUT	4	/* 4 secs */
>  
>  struct cp_control {
>  	int reason;
> @@ -1110,6 +1112,8 @@ enum {
>  	DISCARD_TIME,
>  	GC_TIME,
>  	DISABLE_TIME,
> +	UMOUNT_GC_TIMEOUT,
> +	UMOUNT_DISCARD_TIMEOUT,
>  	MAX_TIME,
>  };
>  
> @@ -3007,7 +3011,7 @@ void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr);
>  bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
>  void f2fs_drop_discard_cmd(struct f2fs_sb_info *sbi);
>  void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi);
> -bool f2fs_wait_discard_bios(struct f2fs_sb_info *sbi);
> +bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi);
>  void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>  					struct cp_control *cpc);
>  void f2fs_dirty_to_prefree(struct f2fs_sb_info *sbi);
> @@ -3151,6 +3155,7 @@ block_t f2fs_start_bidx_of_node(unsigned int node_ofs, struct inode *inode);
>  int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background,
>  			unsigned int segno);
>  void f2fs_build_gc_manager(struct f2fs_sb_info *sbi);
> +int f2fs_gc_timeout(struct f2fs_sb_info *sbi, int time);
>  
>  /*
>   * recovery.c
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 195cf0f9d9ef..ccfc807e4095 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -159,6 +159,23 @@ void f2fs_stop_gc_thread(struct f2fs_sb_info *sbi)
>  	sbi->gc_thread = NULL;
>  }
>  
> +int f2fs_gc_timeout(struct f2fs_sb_info *sbi, int time_type)
> +{
> +	int err = 0;
> +
> +	f2fs_update_time(sbi, time_type);
> +
> +	while (!f2fs_time_over(sbi, time_type)) {
> +		mutex_lock(&sbi->gc_mutex);
> +		err = f2fs_gc(sbi, true, false, NULL_SEGNO);
> +		if (err == -ENODATA)
> +			err = 0;

Then we need to break here? since there is no more victim.

> +		if (err && err != -EAGAIN)
> +			break;
> +	}
> +	return err;
> +}
> +
>  static int select_gc_type(struct f2fs_sb_info *sbi, int gc_type)
>  {
>  	int gc_mode = (gc_type == BG_GC) ? GC_CB : GC_GREEDY;
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 9b79056d705d..cbdb64237f8e 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1415,7 +1415,7 @@ static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
>  }
>  
>  static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
> -					struct discard_policy *dpolicy)
> +			struct discard_policy *dpolicy, int timeout)

How about treating timeout as one part of disacard_policy? So that

__init_discard_policy()
{

	dpolicy->timeout = MAX_TIME;

	if (discard_type == DPOLICY_BG) {
...
	} else if (discard_type == DPOLICY_UMOUNT) {
		dpolicy->timeout = UMOUNT_DISCARD_TIMEOUT;
		...
	}
}

>  {
>  	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
>  	struct list_head *pend_list;
> @@ -1424,7 +1424,13 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>  	int i, issued = 0;
>  	bool io_interrupted = false;
>  
> +	if (timeout != MAX_TIME)
> +		f2fs_update_time(sbi, timeout);
> +
>  	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
> +		if (timeout != MAX_TIME && f2fs_time_over(sbi, timeout))
> +			break;
> +
>  		if (i + 1 < dpolicy->granularity)
>  			break;
>  
> @@ -1611,7 +1617,7 @@ void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi)
>  }
>  
>  /* This comes from f2fs_put_super */
> -bool f2fs_wait_discard_bios(struct f2fs_sb_info *sbi)
> +bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi)
>  {
>  	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
>  	struct discard_policy dpolicy;
> @@ -1619,7 +1625,7 @@ bool f2fs_wait_discard_bios(struct f2fs_sb_info *sbi)
>  
>  	__init_discard_policy(sbi, &dpolicy, DPOLICY_UMOUNT,
>  					dcc->discard_granularity);
> -	__issue_discard_cmd(sbi, &dpolicy);
> +	__issue_discard_cmd(sbi, &dpolicy, UMOUNT_DISCARD_TIMEOUT);
>  	dropped = __drop_discard_cmd(sbi);
>  
>  	/* just to make sure there is no pending discard commands */
> @@ -1672,7 +1678,7 @@ static int issue_discard_thread(void *data)
>  
>  		sb_start_intwrite(sbi->sb);
>  
> -		issued = __issue_discard_cmd(sbi, &dpolicy);
> +		issued = __issue_discard_cmd(sbi, &dpolicy, MAX_TIME);
>  		if (issued > 0) {
>  			__wait_all_discard_cmd(sbi, &dpolicy);
>  			wait_ms = dpolicy.min_interval;
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index cbd97dc280fb..5fa7cb9d4e71 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1029,6 +1029,15 @@ static void f2fs_put_super(struct super_block *sb)
>  	int i;
>  	bool dropped;
>  
> +	/* run some GCs when un-mounting the partition */
> +	f2fs_gc_timeout(sbi, UMOUNT_GC_TIMEOUT);
> +
> +	/* be sure to wait for any on-going discard commands */
> +	dropped = f2fs_issue_discard_timeout(sbi);
> +
> +	/* sync dirty data */
> +	sync_filesystem(sbi->sb);

After this checkpoint, it may generate more pending discard extents, so we
may less chance to write next checkpoint with CP_TRIMMED flag.

So how about reverse order of f2fs_issue_discard_timeout() and
sync_filesystem()?

> +
>  	f2fs_quota_off_umount(sb);
>  
>  	/* prevent remaining shrinker jobs */
> @@ -1044,17 +1053,12 @@ static void f2fs_put_super(struct super_block *sb)
>  		struct cp_control cpc = {
>  			.reason = CP_UMOUNT,
>  		};
> -		f2fs_write_checkpoint(sbi, &cpc);
> -	}
>  
> -	/* be sure to wait for any on-going discard commands */
> -	dropped = f2fs_wait_discard_bios(sbi);
> +		if ((f2fs_hw_support_discard(sbi) ||
> +				f2fs_hw_should_discard(sbi)) &&
> +				!sbi->discard_blks && !dropped)
> +			cpc.reason |= CP_TRIMMED;
>  
> -	if ((f2fs_hw_support_discard(sbi) || f2fs_hw_should_discard(sbi)) &&
> -					!sbi->discard_blks && !dropped) {
> -		struct cp_control cpc = {
> -			.reason = CP_UMOUNT | CP_TRIMMED,
> -		};
>  		f2fs_write_checkpoint(sbi, &cpc);
>  	}
>  
> @@ -1463,16 +1467,9 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
>  
>  	sbi->sb->s_flags |= SB_ACTIVE;
>  
> -	f2fs_update_time(sbi, DISABLE_TIME);
> -
> -	while (!f2fs_time_over(sbi, DISABLE_TIME)) {
> -		mutex_lock(&sbi->gc_mutex);
> -		err = f2fs_gc(sbi, true, false, NULL_SEGNO);
> -		if (err == -ENODATA)
> -			break;
> -		if (err && err != -EAGAIN)
> -			return err;
> -	}
> +	err = f2fs_gc_timeout(sbi, DISABLE_TIME);
> +	if (err)
> +		return err;
>  
>  	err = sync_filesystem(sbi->sb);
>  	if (err)
> @@ -2706,6 +2703,8 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
>  	sbi->interval_time[DISCARD_TIME] = DEF_IDLE_INTERVAL;
>  	sbi->interval_time[GC_TIME] = DEF_IDLE_INTERVAL;
>  	sbi->interval_time[DISABLE_TIME] = DEF_DISABLE_INTERVAL;
> +	sbi->interval_time[UMOUNT_GC_TIMEOUT] = DEF_UMOUNT_GC_TIMEOUT;
> +	sbi->interval_time[UMOUNT_DISCARD_TIMEOUT] = DEF_UMOUNT_DISCARD_TIMEOUT;
>  	clear_sbi_flag(sbi, SBI_NEED_FSCK);
>  
>  	for (i = 0; i < NR_COUNT_TYPE; i++)
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 02d4012a9183..47f25eac9d67 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -420,6 +420,10 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, idle_interval, interval_time[REQ_TIME]);
>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, discard_idle_interval,
>  					interval_time[DISCARD_TIME]);
>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_idle_interval, interval_time[GC_TIME]);
> +F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info,
> +		umount_gc_timeout, interval_time[UMOUNT_GC_TIMEOUT]);
> +F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info,
> +		umount_discard_timeout, interval_time[UMOUNT_DISCARD_TIMEOUT]);

Need extra two sysfs manual entry?

Thanks,

>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, iostat_enable, iostat_enable);
>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, readdir_ra, readdir_ra);
>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_pin_file_thresh, gc_pin_file_threshold);
> @@ -477,6 +481,8 @@ static struct attribute *f2fs_attrs[] = {
>  	ATTR_LIST(idle_interval),
>  	ATTR_LIST(discard_idle_interval),
>  	ATTR_LIST(gc_idle_interval),
> +	ATTR_LIST(umount_gc_timeout),
> +	ATTR_LIST(umount_discard_timeout),
>  	ATTR_LIST(iostat_enable),
>  	ATTR_LIST(readdir_ra),
>  	ATTR_LIST(gc_pin_file_thresh),
> 

