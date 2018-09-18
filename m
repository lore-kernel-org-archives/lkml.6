Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D47BECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2C9214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="weUCX4FN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2C9214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbeIRHAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 03:00:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbeIRHAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 03:00:42 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B688620C0E;
        Tue, 18 Sep 2018 01:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537234239;
        bh=xRbmF8otpqW/nil6EOdDCUsR3FGPSQ4nBbM1g4p0N18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=weUCX4FNW+uWfqI4GMw7W/mgpWzRNLfk2QpNYjpBzJgu8HGI5viLdw1d4+sbI9O28
         BIjWNZAtU4UsZQZbQ63fOm6o06ntk9ZbLbJA25KH/dx2jkTLHOp34qX13D6f4F6u41
         5gMdkyHn2z444K99nYLYFYuLvsABKTwgOVRV0inE=
Date:   Mon, 17 Sep 2018 18:30:39 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Sahitya Tummala <stummala@codeaurora.org>
Cc:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] f2fs: add new idle interval timing for discard and gc
 paths
Message-ID: <20180918013039.GD79604@jaegeuk-macbookpro.roam.corp.google.com>
References: <1537169458-30361-1-git-send-email-stummala@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537169458-30361-1-git-send-email-stummala@codeaurora.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/17, Sahitya Tummala wrote:
> This helps to control the frequency of submission of discard and
> GC requests independently, based on the need.
> 
> Suggested-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> ---
> v3:
> -don't change gc thread wait_ms in this patch
> -Use the existing function f2fs_time_over() to handle this
> -change f2fs_get_wait_time() to f2fs_time_to_wait()
> 
>  Documentation/ABI/testing/sysfs-fs-f2fs | 17 ++++++++++++++++-
>  fs/f2fs/f2fs.h                          | 28 +++++++++++++++++++++++++---
>  fs/f2fs/gc.c                            |  2 +-
>  fs/f2fs/segment.c                       | 14 +++++---------
>  fs/f2fs/super.c                         |  2 ++
>  fs/f2fs/sysfs.c                         |  5 +++++
>  6 files changed, 54 insertions(+), 14 deletions(-)
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
> index 88b8d50..41e00d3 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1095,6 +1095,8 @@ enum {
>  enum {
>  	CP_TIME,
>  	REQ_TIME,
> +	DISCARD_TIME,
> +	GC_TIME,
>  	MAX_TIME,
>  };
>  
> @@ -1352,11 +1354,31 @@ static inline void f2fs_update_time(struct f2fs_sb_info *sbi, int type)
>  static inline bool f2fs_time_over(struct f2fs_sb_info *sbi, int type)
>  {
>  	unsigned long interval = sbi->interval_time[type] * HZ;
> +	unsigned long last_time;
>  
> -	return time_after(jiffies, sbi->last_time[type] + interval);
> +	if (type == CP_TIME)
> +		last_time = sbi->last_time[CP_TIME];
> +	else
> +		last_time = sbi->last_time[REQ_TIME];

Why can't we use just this?

	return time_after(jiffies, sbi->last_time[type] + interval);

> +
> +	return time_after(jiffies, last_time + interval);
> +}
> +
> +static inline unsigned int f2fs_time_to_wait(struct f2fs_sb_info *sbi,
> +						int type)
> +{
> +	unsigned long interval = sbi->interval_time[type] * HZ;
> +	unsigned int wait_ms = 0;
> +	long delta;
> +
> +	delta = (sbi->last_time[REQ_TIME] + interval) - jiffies;
> +	if (delta > 0)
> +		wait_ms = jiffies_to_msecs(delta);
> +
> +	return wait_ms;
>  }
>  
> -static inline bool is_idle(struct f2fs_sb_info *sbi)
> +static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
>  {
>  	struct block_device *bdev = sbi->sb->s_bdev;
>  	struct request_queue *q = bdev_get_queue(bdev);
> @@ -1365,7 +1387,7 @@ static inline bool is_idle(struct f2fs_sb_info *sbi)
>  	if (rl->count[BLK_RW_SYNC] || rl->count[BLK_RW_ASYNC])
>  		return false;
>  
> -	return f2fs_time_over(sbi, REQ_TIME);
> +	return f2fs_time_over(sbi, type);
>  }
>  
>  /*
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 5c8d004..49e2328 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -83,7 +83,7 @@ static int gc_thread_func(void *data)
>  		if (!mutex_trylock(&sbi->gc_mutex))
>  			goto next;
>  
> -		if (!is_idle(sbi)) {
> +		if (!is_idle(sbi, GC_TIME)) {
>  			increase_sleep_time(gc_th, &wait_ms);
>  			mutex_unlock(&sbi->gc_mutex);
>  			goto next;
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 187c848..67cf7e4 100644
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
> +			wait_ms = f2fs_time_to_wait(sbi, DISCARD_TIME);
> +			if (!wait_ms)
>  				wait_ms = dpolicy.mid_interval;
>  		} else {
>  			wait_ms = dpolicy.max_interval;
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 3106da1..2f67948 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2463,6 +2463,8 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
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
> -- 
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
