Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA18C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 00:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FE0214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 00:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="i8zQf2vH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bgjSgOVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61FE0214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730549AbeISGTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 02:19:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36718 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbeISGTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 02:19:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 42D346020A; Wed, 19 Sep 2018 00:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537317845;
        bh=+0sx1kNtzUL9YRdMUeOdCWO9BzUsBTib7zXHTBSsjnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i8zQf2vHwPzlavfRn+PkUf99xbfuJegjmWGG3Nl+fFPZrREqoryAz3+foFK9BIoIF
         jSiXrOSVXaigWmnmHDqboLL6KMlrtAEl32EOy59ZFU8fCZGGh6e08E0MaMAiLs0G6d
         WhusufPDlsugWMYLj7AmhxbekZkNv2srEmF16cnw=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 121616074D;
        Wed, 19 Sep 2018 00:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537317844;
        bh=+0sx1kNtzUL9YRdMUeOdCWO9BzUsBTib7zXHTBSsjnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bgjSgOVFFIId3jhY67+lc0PgUam4LjJY4FYSOw5rKdLy2U50TO8sKan0FVXAC5MNI
         232zomJ9SXgCZxeHg1Wql/h/RB1LgKbtf2XUaqg9bo7gBmbqTwmtIGKYREymn7lVOv
         FiPdHSfoj1wJbXjZWqbMFqwIYKGGixUR4PCBcops=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 121616074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Wed, 19 Sep 2018 06:13:58 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] f2fs: add new idle interval timing for discard and gc
 paths
Message-ID: <20180919004358.GE22939@codeaurora.org>
References: <1537169458-30361-1-git-send-email-stummala@codeaurora.org>
 <20180918013039.GD79604@jaegeuk-macbookpro.roam.corp.google.com>
 <20180918032516.GD22939@codeaurora.org>
 <20180918163954.GB91945@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918163954.GB91945@jaegeuk-macbookpro.roam.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 09:39:54AM -0700, Jaegeuk Kim wrote:
> On 09/18, Sahitya Tummala wrote:
> > On Mon, Sep 17, 2018 at 06:30:39PM -0700, Jaegeuk Kim wrote:
> > > On 09/17, Sahitya Tummala wrote:
> > > > This helps to control the frequency of submission of discard and
> > > > GC requests independently, based on the need.
> > > > 
> > > > Suggested-by: Chao Yu <yuchao0@huawei.com>
> > > > Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> > > > ---
> > > > v3:
> > > > -don't change gc thread wait_ms in this patch
> > > > -Use the existing function f2fs_time_over() to handle this
> > > > -change f2fs_get_wait_time() to f2fs_time_to_wait()
> > > > 
> > > >  Documentation/ABI/testing/sysfs-fs-f2fs | 17 ++++++++++++++++-
> > > >  fs/f2fs/f2fs.h                          | 28 +++++++++++++++++++++++++---
> > > >  fs/f2fs/gc.c                            |  2 +-
> > > >  fs/f2fs/segment.c                       | 14 +++++---------
> > > >  fs/f2fs/super.c                         |  2 ++
> > > >  fs/f2fs/sysfs.c                         |  5 +++++
> > > >  6 files changed, 54 insertions(+), 14 deletions(-)
> > > > 
> > > > diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> > > > index 94a24ae..3ac4177 100644
> > > > --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> > > > +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> > > > @@ -121,7 +121,22 @@ What:		/sys/fs/f2fs/<disk>/idle_interval
> > > >  Date:		January 2016
> > > >  Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
> > > >  Description:
> > > > -		 Controls the idle timing.
> > > > +		 Controls the idle timing for all paths other than
> > > > +		 discard and gc path.
> > > > +
> > > > +What:		/sys/fs/f2fs/<disk>/discard_idle_interval
> > > > +Date:		September 2018
> > > > +Contact:	"Chao Yu" <yuchao0@huawei.com>
> > > > +Contact:	"Sahitya Tummala" <stummala@codeaurora.org>
> > > > +Description:
> > > > +		 Controls the idle timing for discard path.
> > > > +
> > > > +What:		/sys/fs/f2fs/<disk>/gc_idle_interval
> > > > +Date:		September 2018
> > > > +Contact:	"Chao Yu" <yuchao0@huawei.com>
> > > > +Contact:	"Sahitya Tummala" <stummala@codeaurora.org>
> > > > +Description:
> > > > +		 Controls the idle timing for gc path.
> > > >  
> > > >  What:		/sys/fs/f2fs/<disk>/iostat_enable
> > > >  Date:		August 2017
> > > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > > > index 88b8d50..41e00d3 100644
> > > > --- a/fs/f2fs/f2fs.h
> > > > +++ b/fs/f2fs/f2fs.h
> > > > @@ -1095,6 +1095,8 @@ enum {
> > > >  enum {
> > > >  	CP_TIME,
> > > >  	REQ_TIME,
> > > > +	DISCARD_TIME,
> > > > +	GC_TIME,
> > > >  	MAX_TIME,
> > > >  };
> > > >  
> > > > @@ -1352,11 +1354,31 @@ static inline void f2fs_update_time(struct f2fs_sb_info *sbi, int type)
> > > >  static inline bool f2fs_time_over(struct f2fs_sb_info *sbi, int type)
> > > >  {
> > > >  	unsigned long interval = sbi->interval_time[type] * HZ;
> > > > +	unsigned long last_time;
> > > >  
> > > > -	return time_after(jiffies, sbi->last_time[type] + interval);
> > > > +	if (type == CP_TIME)
> > > > +		last_time = sbi->last_time[CP_TIME];
> > > > +	else
> > > > +		last_time = sbi->last_time[REQ_TIME];
> > > 
> > > Why can't we use just this?
> > > 
> > > 	return time_after(jiffies, sbi->last_time[type] + interval);
> > > 
> > 
> > There is no sbi_->last_time[discard_time] and sbi->last_time[gc_time]. Only
> > sbi->interval_time[discard_time] and sbi->interval_time[gc_time] is defined to
> > determine the idle interval time since the last request time, separately for
> > these two paths.
> 
> If you add enums above, sbi will have last_time slots for DISCARD_TIME/GC_TIME.
> Doesn't it make sense to add the below in f2fs_update_time(), if you want to
> introduce two additional types?
> 
> 	/* DISCARD_TIME and GC_TIME are based on REQ_TIME */
> 	if (type == REQ_TIME) {
> 		sbi->last_time(DISCARD_TIME) = jiffies;
> 		sbi->last_time(GC_TIME) = jiffies;
> 	}
Done.
> 
> > 
> > > > +
> > > > +	return time_after(jiffies, last_time + interval);
> > > > +}
> > > > +
> > > > +static inline unsigned int f2fs_time_to_wait(struct f2fs_sb_info *sbi,
> > > > +						int type)
> > > > +{
> > > > +	unsigned long interval = sbi->interval_time[type] * HZ;
> > > > +	unsigned int wait_ms = 0;
> > > > +	long delta;
> > > > +
> > > > +	delta = (sbi->last_time[REQ_TIME] + interval) - jiffies;
> 
> Then, we can use *type* instead of REQ_TIME?
> 
Done.

> > > > +	if (delta > 0)
> > > > +		wait_ms = jiffies_to_msecs(delta);
> > > > +
> > > > +	return wait_ms;
> > > >  }
> > > >  
> > > > -static inline bool is_idle(struct f2fs_sb_info *sbi)
> > > > +static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
> > > >  {
> > > >  	struct block_device *bdev = sbi->sb->s_bdev;
> > > >  	struct request_queue *q = bdev_get_queue(bdev);
> > > > @@ -1365,7 +1387,7 @@ static inline bool is_idle(struct f2fs_sb_info *sbi)
> > > >  	if (rl->count[BLK_RW_SYNC] || rl->count[BLK_RW_ASYNC])
> > > >  		return false;
> > > >  
> > > > -	return f2fs_time_over(sbi, REQ_TIME);
> > > > +	return f2fs_time_over(sbi, type);
> > > >  }
> > > >  
> > > >  /*
> > > > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > > > index 5c8d004..49e2328 100644
> > > > --- a/fs/f2fs/gc.c
> > > > +++ b/fs/f2fs/gc.c
> > > > @@ -83,7 +83,7 @@ static int gc_thread_func(void *data)
> > > >  		if (!mutex_trylock(&sbi->gc_mutex))
> > > >  			goto next;
> > > >  
> > > > -		if (!is_idle(sbi)) {
> > > > +		if (!is_idle(sbi, GC_TIME)) {
> > > >  			increase_sleep_time(gc_th, &wait_ms);
> > > >  			mutex_unlock(&sbi->gc_mutex);
> > > >  			goto next;
> > > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > > index 187c848..67cf7e4 100644
> > > > --- a/fs/f2fs/segment.c
> > > > +++ b/fs/f2fs/segment.c
> > > > @@ -511,7 +511,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
> > > >  	else
> > > >  		f2fs_build_free_nids(sbi, false, false);
> > > >  
> > > > -	if (!is_idle(sbi) &&
> > > > +	if (!is_idle(sbi, REQ_TIME) &&
> > > >  		(!excess_dirty_nats(sbi) && !excess_dirty_nodes(sbi)))
> > > >  		return;
> > > >  
> > > > @@ -1311,7 +1311,7 @@ static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
> > > >  		if (dc->state != D_PREP)
> > > >  			goto next;
> > > >  
> > > > -		if (dpolicy->io_aware && !is_idle(sbi)) {
> > > > +		if (dpolicy->io_aware && !is_idle(sbi, DISCARD_TIME)) {
> > > >  			io_interrupted = true;
> > > >  			break;
> > > >  		}
> > > > @@ -1371,7 +1371,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
> > > >  			f2fs_bug_on(sbi, dc->state != D_PREP);
> > > >  
> > > >  			if (dpolicy->io_aware && i < dpolicy->io_aware_gran &&
> > > > -								!is_idle(sbi)) {
> > > > +						!is_idle(sbi, DISCARD_TIME)) {
> > > >  				io_interrupted = true;
> > > >  				break;
> > > >  			}
> > > > @@ -1564,8 +1564,6 @@ static int issue_discard_thread(void *data)
> > > >  	struct discard_policy dpolicy;
> > > >  	unsigned int wait_ms = DEF_MIN_DISCARD_ISSUE_TIME;
> > > >  	int issued;
> > > > -	unsigned long interval = sbi->interval_time[REQ_TIME] * HZ;
> > > > -	long delta;
> > > >  
> > > >  	set_freezable();
> > > >  
> > > > @@ -1602,10 +1600,8 @@ static int issue_discard_thread(void *data)
> > > >  			__wait_all_discard_cmd(sbi, &dpolicy);
> > > >  			wait_ms = dpolicy.min_interval;
> > > >  		} else if (issued == -1){
> > > > -			delta = (sbi->last_time[REQ_TIME] + interval) - jiffies;
> > > > -			if (delta > 0)
> > > > -				wait_ms = jiffies_to_msecs(delta);
> > > > -			else
> > > > +			wait_ms = f2fs_time_to_wait(sbi, DISCARD_TIME);
> > > > +			if (!wait_ms)
> > > >  				wait_ms = dpolicy.mid_interval;
> > > >  		} else {
> > > >  			wait_ms = dpolicy.max_interval;
> > > > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > > > index 3106da1..2f67948 100644
> > > > --- a/fs/f2fs/super.c
> > > > +++ b/fs/f2fs/super.c
> > > > @@ -2463,6 +2463,8 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
> > > >  	sbi->dir_level = DEF_DIR_LEVEL;
> > > >  	sbi->interval_time[CP_TIME] = DEF_CP_INTERVAL;
> > > >  	sbi->interval_time[REQ_TIME] = DEF_IDLE_INTERVAL;
> > > > +	sbi->interval_time[DISCARD_TIME] = DEF_IDLE_INTERVAL;
> > > > +	sbi->interval_time[GC_TIME] = DEF_IDLE_INTERVAL;
> > > >  	clear_sbi_flag(sbi, SBI_NEED_FSCK);
> > > >  
> > > >  	for (i = 0; i < NR_COUNT_TYPE; i++)
> > > > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > > > index 81c0e53..0afe99c 100644
> > > > --- a/fs/f2fs/sysfs.c
> > > > +++ b/fs/f2fs/sysfs.c
> > > > @@ -407,6 +407,9 @@ static ssize_t f2fs_feature_show(struct f2fs_attr *a,
> > > >  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, dir_level, dir_level);
> > > >  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, cp_interval, interval_time[CP_TIME]);
> > > >  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, idle_interval, interval_time[REQ_TIME]);
> > > > +F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, discard_idle_interval,
> > > > +					interval_time[DISCARD_TIME]);
> > > > +F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_idle_interval, interval_time[GC_TIME]);
> > > >  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, iostat_enable, iostat_enable);
> > > >  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, readdir_ra, readdir_ra);
> > > >  F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_pin_file_thresh, gc_pin_file_threshold);
> > > > @@ -460,6 +463,8 @@ static ssize_t f2fs_feature_show(struct f2fs_attr *a,
> > > >  	ATTR_LIST(dirty_nats_ratio),
> > > >  	ATTR_LIST(cp_interval),
> > > >  	ATTR_LIST(idle_interval),
> > > > +	ATTR_LIST(discard_idle_interval),
> > > > +	ATTR_LIST(gc_idle_interval),
> > > >  	ATTR_LIST(iostat_enable),
> > > >  	ATTR_LIST(readdir_ra),
> > > >  	ATTR_LIST(gc_pin_file_thresh),
> > > > -- 
> > > > Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
> > > > Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
> > 
> > -- 
> > --
> > Sent by a consultant of the Qualcomm Innovation Center, Inc.
> > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
