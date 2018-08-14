Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F2CC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 04:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D7D21749
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 04:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwjqtZP0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D7D21749
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731628AbeHNHE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 03:04:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731280AbeHNHE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 03:04:28 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4003C21742;
        Tue, 14 Aug 2018 04:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534220347;
        bh=+vl/A9TYWJLOusitEmgiaiTHYFab2MYY5R4UvgaBxOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gwjqtZP08jS78vvnAZNh9ORD3+bl3dgH4wwcnx43t3DhwD97UGU0EXtZgbJScc4YM
         a2Xwiv+gY2ouGPnOIv06fc0ZqnDaq9ZDCJZey6tLcTwhVFOx2TQhpBgz8NWN/XK6JW
         Tisr6JlzXkiG7tQjWizTVfV9HrYyJXLctw/LOZAs=
Date:   Mon, 13 Aug 2018 21:19:06 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH 2/2] f2fs: tune discard speed with storage usage rate
Message-ID: <20180814041906.GC52730@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180810100806.9298-1-yuchao0@huawei.com>
 <20180810100806.9298-2-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810100806.9298-2-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10, Chao Yu wrote:
> Previously, discard speed was fixed mostly, and in high usage rate
> device, we will speed up issuing discard, but it doesn't make sense
> that in a non-full filesystem, we still issue discard with slow speed.

Could you please elaborate the problem in more detail? The speed depends
on how many candidates?

Thanks,

> 
> Anyway, it comes out undiscarded block makes FTL GC be lower efficient
> and causing high lifetime overhead.
> 
> Let's tune discard speed as below:
> 
> a. adjust default issue interval:
> 		original	after
> min_interval:	50ms		100ms
> mid_interval:	500ms		1000ms
> max_interval:	60000ms		10000ms
> 
> b. if last time we stop issuing discard due to IO interruption of user,
> let's reset all {min,mid,max}_interval to default one.
> 
> c. tune {min,mid,max}_interval with below calculation method:
> 
> base_interval = default_interval / 10;
> total_interval = default_interval - base_interval;
> interval = base_interval + total_interval * (100 - dev_util) / 100;
> 
> For example:
> min_interval (:100ms)
> dev_util (%)	interval (ms)
> 0		100
> 10		91
> 20		82
> 30		73
> ...
> 80		28
> 90		19
> 100		10
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/f2fs.h    | 11 ++++----
>  fs/f2fs/segment.c | 64 +++++++++++++++++++++++++++++++++++++----------
>  fs/f2fs/segment.h |  9 +++++++
>  fs/f2fs/super.c   |  2 +-
>  4 files changed, 67 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 273ffdaf4891..a1dd2e1c3cb9 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -185,10 +185,9 @@ enum {
>  
>  #define MAX_DISCARD_BLOCKS(sbi)		BLKS_PER_SEC(sbi)
>  #define DEF_MAX_DISCARD_REQUEST		8	/* issue 8 discards per round */
> -#define DEF_MIN_DISCARD_ISSUE_TIME	50	/* 50 ms, if exists */
> -#define DEF_MID_DISCARD_ISSUE_TIME	500	/* 500 ms, if device busy */
> -#define DEF_MAX_DISCARD_ISSUE_TIME	60000	/* 60 s, if no candidates */
> -#define DEF_DISCARD_URGENT_UTIL		80	/* do more discard over 80% */
> +#define DEF_MIN_DISCARD_ISSUE_TIME	100	/* 100 ms, if exists */
> +#define DEF_MID_DISCARD_ISSUE_TIME	1000	/* 1000 ms, if device busy */
> +#define DEF_MAX_DISCARD_ISSUE_TIME	10000	/* 10000 ms, if no candidates */
>  #define DEF_CP_INTERVAL			60	/* 60 secs */
>  #define DEF_IDLE_INTERVAL		5	/* 5 secs */
>  
> @@ -248,7 +247,8 @@ struct discard_entry {
>  };
>  
>  /* default discard granularity of inner discard thread, unit: block count */
> -#define DEFAULT_DISCARD_GRANULARITY		1
> +#define MID_DISCARD_GRANULARITY			16
> +#define MIN_DISCARD_GRANULARITY			1
>  
>  /* max discard pend list number */
>  #define MAX_PLIST_NUM		512
> @@ -330,6 +330,7 @@ struct discard_cmd_control {
>  	atomic_t discard_cmd_cnt;		/* # of cached cmd count */
>  	struct rb_root root;			/* root of discard rb-tree */
>  	bool rbtree_check;			/* config for consistence check */
> +	bool io_interrupted;			/* last state of io interrupted */
>  };
>  
>  /* for the list of fsync inodes, used only during recovery */
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 8b52e8dfb12f..9564aaf1f27b 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -968,6 +968,44 @@ static void __check_sit_bitmap(struct f2fs_sb_info *sbi,
>  #endif
>  }
>  
> +static void __adjust_discard_speed(unsigned int *interval,
> +				unsigned int def_interval, int dev_util)
> +{
> +	unsigned int base_interval, total_interval;
> +
> +	base_interval = def_interval / 10;
> +	total_interval = def_interval - base_interval;
> +
> +	/*
> +	 * if def_interval = 100, adjusted interval should be in range of
> +	 * [10, 100].
> +	 */
> +	*interval = base_interval + total_interval * (100 - dev_util) / 100;
> +}
> +
> +static void __tune_discard_policy(struct f2fs_sb_info *sbi,
> +					struct discard_policy *dpolicy)
> +{
> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +	int dev_util;
> +
> +	if (dcc->io_interrupted) {
> +		dpolicy->min_interval = DEF_MIN_DISCARD_ISSUE_TIME;
> +		dpolicy->mid_interval = DEF_MID_DISCARD_ISSUE_TIME;
> +		dpolicy->max_interval = DEF_MAX_DISCARD_ISSUE_TIME;
> +		return;
> +	}
> +
> +	dev_util = dev_utilization(sbi);
> +
> +	__adjust_discard_speed(&dpolicy->min_interval,
> +				DEF_MIN_DISCARD_ISSUE_TIME, dev_util);
> +	__adjust_discard_speed(&dpolicy->mid_interval,
> +				DEF_MID_DISCARD_ISSUE_TIME, dev_util);
> +	__adjust_discard_speed(&dpolicy->max_interval,
> +				DEF_MAX_DISCARD_ISSUE_TIME, dev_util);
> +}
> +
>  static void __init_discard_policy(struct f2fs_sb_info *sbi,
>  				struct discard_policy *dpolicy,
>  				int discard_type, unsigned int granularity)
> @@ -982,20 +1020,11 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
>  	dpolicy->io_aware_gran = MAX_PLIST_NUM;
>  
>  	if (discard_type == DPOLICY_BG) {
> -		dpolicy->min_interval = DEF_MIN_DISCARD_ISSUE_TIME;
> -		dpolicy->mid_interval = DEF_MID_DISCARD_ISSUE_TIME;
> -		dpolicy->max_interval = DEF_MAX_DISCARD_ISSUE_TIME;
>  		dpolicy->io_aware = true;
>  		dpolicy->sync = false;
>  		dpolicy->ordered = true;
> -		if (utilization(sbi) > DEF_DISCARD_URGENT_UTIL) {
> -			dpolicy->granularity = 1;
> -			dpolicy->max_interval = DEF_MIN_DISCARD_ISSUE_TIME;
> -		}
> +		__tune_discard_policy(sbi, dpolicy);
>  	} else if (discard_type == DPOLICY_FORCE) {
> -		dpolicy->min_interval = DEF_MIN_DISCARD_ISSUE_TIME;
> -		dpolicy->mid_interval = DEF_MID_DISCARD_ISSUE_TIME;
> -		dpolicy->max_interval = DEF_MAX_DISCARD_ISSUE_TIME;
>  		dpolicy->io_aware = false;
>  	} else if (discard_type == DPOLICY_FSTRIM) {
>  		dpolicy->io_aware = false;
> @@ -1353,6 +1382,8 @@ static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
>  	if (!issued && io_interrupted)
>  		issued = -1;
>  
> +	dcc->io_interrupted = io_interrupted;
> +
>  	return issued;
>  }
>  
> @@ -1370,7 +1401,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>  		if (i + 1 < dpolicy->granularity)
>  			break;
>  
> -		if (i < DEFAULT_DISCARD_GRANULARITY && dpolicy->ordered)
> +		if (i < MID_DISCARD_GRANULARITY && dpolicy->ordered)
>  			return __issue_discard_cmd_orderly(sbi, dpolicy);
>  
>  		pend_list = &dcc->pend_list[i];
> @@ -1407,6 +1438,8 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>  	if (!issued && io_interrupted)
>  		issued = -1;
>  
> +	dcc->io_interrupted = io_interrupted;
> +
>  	return issued;
>  }
>  
> @@ -1576,7 +1609,11 @@ static int issue_discard_thread(void *data)
>  	struct f2fs_sb_info *sbi = data;
>  	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
>  	wait_queue_head_t *q = &dcc->discard_wait_queue;
> -	struct discard_policy dpolicy;
> +	struct discard_policy dpolicy = {
> +		.min_interval = DEF_MIN_DISCARD_ISSUE_TIME,
> +		.mid_interval = DEF_MID_DISCARD_ISSUE_TIME,
> +		.max_interval = DEF_MAX_DISCARD_ISSUE_TIME,
> +	};
>  	unsigned int wait_ms = DEF_MIN_DISCARD_ISSUE_TIME;
>  	int issued;
>  
> @@ -1929,7 +1966,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>  	if (!dcc)
>  		return -ENOMEM;
>  
> -	dcc->discard_granularity = DEFAULT_DISCARD_GRANULARITY;
> +	dcc->discard_granularity = MIN_DISCARD_GRANULARITY;
>  	INIT_LIST_HEAD(&dcc->entry_list);
>  	for (i = 0; i < MAX_PLIST_NUM; i++)
>  		INIT_LIST_HEAD(&dcc->pend_list[i]);
> @@ -1945,6 +1982,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>  	dcc->next_pos = 0;
>  	dcc->root = RB_ROOT;
>  	dcc->rbtree_check = false;
> +	dcc->io_interrupted = false;
>  
>  	init_waitqueue_head(&dcc->discard_wait_queue);
>  	SM_I(sbi)->dcc_info = dcc;
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 422b0ceb1eaa..63b4da72cd34 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -616,6 +616,15 @@ static inline int utilization(struct f2fs_sb_info *sbi)
>  					sbi->user_block_count);
>  }
>  
> +static inline int dev_utilization(struct f2fs_sb_info *sbi)
> +{
> +	unsigned int dev_blks;
> +
> +	dev_blks = valid_user_blocks(sbi) + SM_I(sbi)->dcc_info->undiscard_blks;
> +	return div_u64((u64)dev_blks * 100,
> +			MAIN_SEGS(sbi) << sbi->log_blocks_per_seg);
> +}
> +
>  /*
>   * Sometimes f2fs may be better to drop out-of-place update policy.
>   * And, users can control the policy through sysfs entries.
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index b055f2ea77c5..55ed76daad23 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2862,7 +2862,7 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
>  	/* adjust parameters according to the volume size */
>  	if (sm_i->main_segments <= SMALL_VOLUME_SEGMENTS) {
>  		F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_REUSE;
> -		sm_i->dcc_info->discard_granularity = 1;
> +		sm_i->dcc_info->discard_granularity = MIN_DISCARD_GRANULARITY;
>  		sm_i->ipu_policy = 1 << F2FS_IPU_FORCE;
>  	}
>  
> -- 
> 2.18.0.rc1
