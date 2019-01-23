Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCACC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABAE32183F
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfAWMPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:15:17 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2295 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726029AbfAWMPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:15:16 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1208ABA1543D788A30C8;
        Wed, 23 Jan 2019 20:15:14 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Wed, 23 Jan 2019
 20:15:13 +0800
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: run discard jobs when put_super
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190123000229.45236-1-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <2afde906-0bbc-7464-104b-237343ed218b@huawei.com>
Date:   Wed, 23 Jan 2019 20:15:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190123000229.45236-1-jaegeuk@kernel.org>
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
> When we umount f2fs, we need to avoid long delay due to discard commands, which
> is actually taking tens of seconds, if storage is very slow on UNMAP. So, this
> patch introduces timeout-based work on it.
> 
> By default, let me give 5 seconds for discard.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs |  7 +++++++
>  fs/f2fs/f2fs.h                          |  5 ++++-
>  fs/f2fs/segment.c                       | 11 ++++++++++-
>  fs/f2fs/super.c                         | 17 ++++++++---------
>  fs/f2fs/sysfs.c                         |  3 +++
>  5 files changed, 32 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index a7ce33199457..91822ce25831 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -86,6 +86,13 @@ Description:
>  		The unit size is one block, now only support configuring in range
>  		of [1, 512].
>  
> +What:          /sys/fs/f2fs/<disk>/umount_discard_timeout
> +Date:          January 2019
> +Contact:       "Jaegeuk Kim" <jaegeuk@kernel.org>
> +Description:
> +		Set timeout to issue discard commands during umount.
> +		Default: 5 secs
> +
>  What:		/sys/fs/f2fs/<disk>/max_victim_search
>  Date:		January 2014
>  Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 0f564883e078..6b6ec5600089 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -191,6 +191,7 @@ enum {
>  #define DEF_CP_INTERVAL			60	/* 60 secs */
>  #define DEF_IDLE_INTERVAL		5	/* 5 secs */
>  #define DEF_DISABLE_INTERVAL		5	/* 5 secs */
> +#define DEF_UMOUNT_DISCARD_TIMEOUT	5	/* 5 secs */
>  
>  struct cp_control {
>  	int reason;
> @@ -310,6 +311,7 @@ struct discard_policy {
>  	bool sync;			/* submit discard with REQ_SYNC flag */
>  	bool ordered;			/* issue discard by lba order */
>  	unsigned int granularity;	/* discard granularity */
> +	int timeout;			/* discard timeout for put_super */
>  };
>  
>  struct discard_cmd_control {
> @@ -1110,6 +1112,7 @@ enum {
>  	DISCARD_TIME,
>  	GC_TIME,
>  	DISABLE_TIME,
> +	UMOUNT_DISCARD_TIMEOUT,
>  	MAX_TIME,

After the patch, MAX_TIME will be 6, so if we set @timeout to 6 via sysfs,
the configuration will not be enabled due to below condition, right?

+	if (dpolicy->timeout != MAX_TIME)
+		f2fs_update_time(sbi, dpolicy->timeout);

>  };
>  
> @@ -3006,7 +3009,7 @@ void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr);
>  bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
>  void f2fs_drop_discard_cmd(struct f2fs_sb_info *sbi);
>  void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi);
> -bool f2fs_wait_discard_bios(struct f2fs_sb_info *sbi);
> +bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi);
>  void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>  					struct cp_control *cpc);
>  void f2fs_dirty_to_prefree(struct f2fs_sb_info *sbi);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 9b79056d705d..97e0faf09ebf 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1037,6 +1037,7 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
>  
>  	dpolicy->max_requests = DEF_MAX_DISCARD_REQUEST;
>  	dpolicy->io_aware_gran = MAX_PLIST_NUM;
> +	dpolicy->timeout = MAX_TIME;
>  
>  	if (discard_type == DPOLICY_BG) {
>  		dpolicy->min_interval = DEF_MIN_DISCARD_ISSUE_TIME;
> @@ -1424,7 +1425,14 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>  	int i, issued = 0;
>  	bool io_interrupted = false;
>  
> +	if (dpolicy->timeout != MAX_TIME)
> +		f2fs_update_time(sbi, dpolicy->timeout);
> +
>  	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
> +		if (dpolicy->timeout != MAX_TIME &&
> +				f2fs_time_over(sbi, dpolicy->timeout))
> +			break;
> +
>  		if (i + 1 < dpolicy->granularity)
>  			break;
>  
> @@ -1611,7 +1619,7 @@ void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi)
>  }
>  
>  /* This comes from f2fs_put_super */
> -bool f2fs_wait_discard_bios(struct f2fs_sb_info *sbi)
> +bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi)
>  {
>  	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
>  	struct discard_policy dpolicy;
> @@ -1619,6 +1627,7 @@ bool f2fs_wait_discard_bios(struct f2fs_sb_info *sbi)
>  
>  	__init_discard_policy(sbi, &dpolicy, DPOLICY_UMOUNT,
>  					dcc->discard_granularity);
> +	dpolicy.timeout = UMOUNT_DISCARD_TIMEOUT;
>  	__issue_discard_cmd(sbi, &dpolicy);
>  	dropped = __drop_discard_cmd(sbi);
>  
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index ea514acede36..7998ff5418f2 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1029,6 +1029,9 @@ static void f2fs_put_super(struct super_block *sb)
>  	int i;
>  	bool dropped;
>  
> +	/* be sure to wait for any on-going discard commands */
> +	dropped = f2fs_issue_discard_timeout(sbi);
> +
>  	f2fs_quota_off_umount(sb);
>  
>  	/* prevent remaining shrinker jobs */
> @@ -1044,17 +1047,12 @@ static void f2fs_put_super(struct super_block *sb)
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

Still, there will be problematic as I commented in last patch, could you
check that?

Thanks,

>  	}
>  
> @@ -2706,6 +2704,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
>  	sbi->interval_time[DISCARD_TIME] = DEF_IDLE_INTERVAL;
>  	sbi->interval_time[GC_TIME] = DEF_IDLE_INTERVAL;
>  	sbi->interval_time[DISABLE_TIME] = DEF_DISABLE_INTERVAL;
> +	sbi->interval_time[UMOUNT_DISCARD_TIMEOUT] = DEF_UMOUNT_DISCARD_TIMEOUT;
>  	clear_sbi_flag(sbi, SBI_NEED_FSCK);
>  
>  	for (i = 0; i < NR_COUNT_TYPE; i++)
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 5b83e1d66cb3..18c627e8fc90 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -426,6 +426,8 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, idle_interval, interval_time[REQ_TIME]);
>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, discard_idle_interval,
>  					interval_time[DISCARD_TIME]);
>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_idle_interval, interval_time[GC_TIME]);
> +F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info,
> +		umount_discard_timeout, interval_time[UMOUNT_DISCARD_TIMEOUT]);
>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, iostat_enable, iostat_enable);
>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, readdir_ra, readdir_ra);
>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_pin_file_thresh, gc_pin_file_threshold);
> @@ -483,6 +485,7 @@ static struct attribute *f2fs_attrs[] = {
>  	ATTR_LIST(idle_interval),
>  	ATTR_LIST(discard_idle_interval),
>  	ATTR_LIST(gc_idle_interval),
> +	ATTR_LIST(umount_discard_timeout),
>  	ATTR_LIST(iostat_enable),
>  	ATTR_LIST(readdir_ra),
>  	ATTR_LIST(gc_pin_file_thresh),
> 

