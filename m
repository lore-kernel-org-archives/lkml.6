Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FCFC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808BE2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D72+Rkym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808BE2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbeIJU4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:56:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727777AbeIJU4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:56:32 -0400
Received: from [192.168.0.101] (unknown [49.77.179.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1BBD20865;
        Mon, 10 Sep 2018 16:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536595306;
        bh=rXSsl8GYfAU9a1YEpzOUywOhqK6u5s46jLHS9bBFcWs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=D72+Rkymp5OdKv0S1WP8gVQM9ZjA9PjSp33balLRDPX7zMfhQo/8PJLDZ0bdiPPc/
         BFj3iIEvs/q4pOkRd4Ju/pNnsROhgIVy7gHc5nQtYmJGSCTgU1xZzIYvo1fnAFcAkV
         mqPvVWou4EWm93IIb6tw1GIx5L4ff9x09/npO7vg=
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add new idle interval timing for
 discard and gc paths
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org
References: <1536551252-24256-1-git-send-email-stummala@codeaurora.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <5d74d46b-8141-f048-9c0a-459c82b2c449@kernel.org>
Date:   Tue, 11 Sep 2018 00:01:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536551252-24256-1-git-send-email-stummala@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/10 11:47, Sahitya Tummala wrote:
> This helps to control the frequency of submission of discard and
> GC requests independently, based on the need. The sleep timing of
> GC thread is now aligned with this idle time when the dev is busy,
> to avoid unnecessary periodic wakeups.
> 
> Suggested-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> ---
> v2:
> -fix __issue_discard_cmd_orderly() path
> 
>  Documentation/ABI/testing/sysfs-fs-f2fs | 17 ++++++++++++++++-
>  fs/f2fs/f2fs.h                          | 31 +++++++++++++++++++++++++++----
>  fs/f2fs/gc.c                            |  6 ++++--
>  fs/f2fs/segment.c                       | 16 ++++++----------
>  fs/f2fs/super.c                         |  2 ++
>  fs/f2fs/sysfs.c                         |  5 +++++
>  6 files changed, 60 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 94a24ae..3ac4177 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -121,7 +121,22 @@ What:		/sys/fs/f2fs/<disk>/idle_interval
>  Date:		January 2016
>  Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
>  Description:
> -		 Controls the idle timing.
> +		 Controls the idle timing for all paths other than
> +		 discard and gc path.
> +
> +What:		/sys/fs/f2fs/<disk>/discard_idle_interval
> +Date:		September 2018
> +Contact:	"Chao Yu" <yuchao0@huawei.com>
> +Contact:	"Sahitya Tummala" <stummala@codeaurora.org>
> +Description:
> +		 Controls the idle timing for discard path.
> +
> +What:		/sys/fs/f2fs/<disk>/gc_idle_interval
> +Date:		September 2018
> +Contact:	"Chao Yu" <yuchao0@huawei.com>
> +Contact:	"Sahitya Tummala" <stummala@codeaurora.org>
> +Description:
> +		 Controls the idle timing for gc path.
>  
>  What:		/sys/fs/f2fs/<disk>/iostat_enable
>  Date:		August 2017
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index abf9256..6070681 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1093,6 +1093,8 @@ enum {
>  enum {
>  	CP_TIME,
>  	REQ_TIME,
> +	DISCARD_TIME,
> +	GC_TIME,
>  	MAX_TIME,
>  };
>  
> @@ -1347,14 +1349,35 @@ static inline void f2fs_update_time(struct f2fs_sb_info *sbi, int type)
>  	sbi->last_time[type] = jiffies;
>  }
>  
> -static inline bool f2fs_time_over(struct f2fs_sb_info *sbi, int type)
> +static inline bool f2fs_time_over_cp(struct f2fs_sb_info *sbi)
> +{
> +	unsigned long interval = sbi->interval_time[CP_TIME] * HZ;
> +
> +	return time_after(jiffies, sbi->last_time[CP_TIME] + interval);
> +}
> +
> +static inline bool f2fs_time_over_req(struct f2fs_sb_info *sbi, int type)
> +{
> +	unsigned long interval = sbi->interval_time[type] * HZ;
> +
> +	return time_after(jiffies, sbi->last_time[REQ_TIME] + interval);
> +}
> +
> +static inline unsigned int f2fs_get_wait_time(struct f2fs_sb_info *sbi,
> +						int type)
>  {
>  	unsigned long interval = sbi->interval_time[type] * HZ;
> +	unsigned int wait_ms = 0;
> +	long delta;
> +
> +	delta = (sbi->last_time[REQ_TIME] + interval) - jiffies;
> +	if (delta > 0)
> +		wait_ms = jiffies_to_msecs(delta);
>  
> -	return time_after(jiffies, sbi->last_time[type] + interval);
> +	return wait_ms;
>  }
>  
> -static inline bool is_idle(struct f2fs_sb_info *sbi)
> +static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
>  {
>  	struct block_device *bdev = sbi->sb->s_bdev;
>  	struct request_queue *q = bdev_get_queue(bdev);
> @@ -1363,7 +1386,7 @@ static inline bool is_idle(struct f2fs_sb_info *sbi)
>  	if (rl->count[BLK_RW_SYNC] || rl->count[BLK_RW_ASYNC])
>  		return false;
>  
> -	return f2fs_time_over(sbi, REQ_TIME);
> +	return f2fs_time_over_req(sbi, type);
>  }
>  
>  /*
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 5c8d004..c0bafea 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -83,8 +83,10 @@ static int gc_thread_func(void *data)
>  		if (!mutex_trylock(&sbi->gc_mutex))
>  			goto next;
>  
> -		if (!is_idle(sbi)) {
> -			increase_sleep_time(gc_th, &wait_ms);
> +		if (!is_idle(sbi, GC_TIME)) {
> +			wait_ms = f2fs_get_wait_time(sbi, GC_TIME);

It seems this patch changes the method of increasing wait_ms here, if device is
busy, we may wake up GC thread earlier than before, not sure we should do this.

To Jaegeuk, how do you think of this?

Thanks,

> +			if (!wait_ms)
> +				increase_sleep_time(gc_th, &wait_ms);
>  			mutex_unlock(&sbi->gc_mutex);
>  			goto next;
>  		}
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index c5024f8..2d15733 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -511,7 +511,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
>  	else
>  		f2fs_build_free_nids(sbi, false, false);
>  
> -	if (!is_idle(sbi) &&
> +	if (!is_idle(sbi, REQ_TIME) &&
>  		(!excess_dirty_nats(sbi) && !excess_dirty_nodes(sbi)))
>  		return;
>  
> @@ -521,7 +521,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
>  			excess_prefree_segs(sbi) ||
>  			excess_dirty_nats(sbi) ||
>  			excess_dirty_nodes(sbi) ||
> -			f2fs_time_over(sbi, CP_TIME)) {
> +			f2fs_time_over_cp(sbi)) {
>  		if (test_opt(sbi, DATA_FLUSH)) {
>  			struct blk_plug plug;
>  
> @@ -1311,7 +1311,7 @@ static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
>  		if (dc->state != D_PREP)
>  			goto next;
>  
> -		if (dpolicy->io_aware && !is_idle(sbi)) {
> +		if (dpolicy->io_aware && !is_idle(sbi, DISCARD_TIME)) {
>  			io_interrupted = true;
>  			break;
>  		}
> @@ -1371,7 +1371,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>  			f2fs_bug_on(sbi, dc->state != D_PREP);
>  
>  			if (dpolicy->io_aware && i < dpolicy->io_aware_gran &&
> -								!is_idle(sbi)) {
> +						!is_idle(sbi, DISCARD_TIME)) {
>  				io_interrupted = true;
>  				break;
>  			}
> @@ -1564,8 +1564,6 @@ static int issue_discard_thread(void *data)
>  	struct discard_policy dpolicy;
>  	unsigned int wait_ms = DEF_MIN_DISCARD_ISSUE_TIME;
>  	int issued;
> -	unsigned long interval = sbi->interval_time[REQ_TIME] * HZ;
> -	long delta;
>  
>  	set_freezable();
>  
> @@ -1602,10 +1600,8 @@ static int issue_discard_thread(void *data)
>  			__wait_all_discard_cmd(sbi, &dpolicy);
>  			wait_ms = dpolicy.min_interval;
>  		} else if (issued == -1){
> -			delta = (sbi->last_time[REQ_TIME] + interval) - jiffies;
> -			if (delta > 0)
> -				wait_ms = jiffies_to_msecs(delta);
> -			else
> +			wait_ms = f2fs_get_wait_time(sbi, DISCARD_TIME);
> +			if (!wait_ms)
>  				wait_ms = dpolicy.mid_interval;
>  		} else {
>  			wait_ms = dpolicy.max_interval;
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 896b885..1706f45 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2423,6 +2423,8 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
>  	sbi->dir_level = DEF_DIR_LEVEL;
>  	sbi->interval_time[CP_TIME] = DEF_CP_INTERVAL;
>  	sbi->interval_time[REQ_TIME] = DEF_IDLE_INTERVAL;
> +	sbi->interval_time[DISCARD_TIME] = DEF_IDLE_INTERVAL;
> +	sbi->interval_time[GC_TIME] = DEF_IDLE_INTERVAL;
>  	clear_sbi_flag(sbi, SBI_NEED_FSCK);
>  
>  	for (i = 0; i < NR_COUNT_TYPE; i++)
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 81c0e53..0afe99c 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -407,6 +407,9 @@ static ssize_t f2fs_feature_show(struct f2fs_attr *a,
>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, dir_level, dir_level);
>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, cp_interval, interval_time[CP_TIME]);
>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, idle_interval, interval_time[REQ_TIME]);
> +F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, discard_idle_interval,
> +					interval_time[DISCARD_TIME]);
> +F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_idle_interval, interval_time[GC_TIME]);
>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, iostat_enable, iostat_enable);
>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, readdir_ra, readdir_ra);
>  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_pin_file_thresh, gc_pin_file_threshold);
> @@ -460,6 +463,8 @@ static ssize_t f2fs_feature_show(struct f2fs_attr *a,
>  	ATTR_LIST(dirty_nats_ratio),
>  	ATTR_LIST(cp_interval),
>  	ATTR_LIST(idle_interval),
> +	ATTR_LIST(discard_idle_interval),
> +	ATTR_LIST(gc_idle_interval),
>  	ATTR_LIST(iostat_enable),
>  	ATTR_LIST(readdir_ra),
>  	ATTR_LIST(gc_pin_file_thresh),
> 
