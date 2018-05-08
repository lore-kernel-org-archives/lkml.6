Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754051AbeEHDRv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 23:17:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753896AbeEHDRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 23:17:50 -0400
Date: Mon, 7 May 2018 20:17:48 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        chao@kernel.org
Subject: Re: [PATCH v4] f2fs: fix to avoid race during access gc_thread
 pointer
Message-ID: <20180508031748.GB17507@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180507122659.86536-1-yuchao0@huawei.com>
 <20180507213610.GC83867@jaegeuk-macbookpro.roam.corp.google.com>
 <afc69260-b07d-107a-20e2-132c171ce85f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afc69260-b07d-107a-20e2-132c171ce85f@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08, Chao Yu wrote:
> On 2018/5/8 5:36, Jaegeuk Kim wrote:
> > On 05/07, Chao Yu wrote:
> >> Thread A			Thread B		Thread C
> >> - f2fs_remount
> >>  - stop_gc_thread
> >> 				- f2fs_sbi_store
> >> 							- issue_discard_thread
> >>    sbi->gc_thread = NULL;
> >> 				  sbi->gc_thread->gc_wake = 1
> >> 							  access sbi->gc_thread->gc_urgent
> >>
> >> Previously, we allocate memory for sbi->gc_thread based on background
> >> gc thread mount option, the memory can be released if we turn off
> >> that mount option, but still there are several places access gc_thread
> >> pointer without considering race condition, result in NULL point
> >> dereference.
> >>
> >> In order to fix this issue, introduce gc_rwsem to exclude those operations.
> >>
> >> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >> v4:
> >> - use introduced sbi.gc_rwsem lock instead of sb.s_umount.
> > 
> > We can use this first.
> > 
> >>From e62e8d3ece6ee8a4aeac8ffd6161d25851f8b3f0 Mon Sep 17 00:00:00 2001
> > From: Jaegeuk Kim <jaegeuk@kernel.org>
> > Date: Mon, 7 May 2018 14:22:40 -0700
> > Subject: [PATCH] f2fs: introduce sbi->gc_mode to determine the policy
> > 
> > This is to avoid sbi->gc_thread pointer access.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/f2fs.h    |  8 ++++++++
> >  fs/f2fs/gc.c      | 28 ++++++++++++----------------
> >  fs/f2fs/gc.h      |  2 --
> >  fs/f2fs/segment.c |  4 ++--
> >  fs/f2fs/sysfs.c   | 33 +++++++++++++++++++++++++--------
> >  5 files changed, 47 insertions(+), 28 deletions(-)
> > 
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 80490a7991a7..779d8b26878c 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1065,6 +1065,13 @@ enum {
> >  	MAX_TIME,
> >  };
> >  
> > +enum {
> > +	GC_NORMAL,
> > +	GC_IDLE_CB,
> > +	GC_IDLE_GREEDY,
> > +	GC_URGENT,
> > +};
> > +
> >  enum {
> >  	WHINT_MODE_OFF,		/* not pass down write hints */
> >  	WHINT_MODE_USER,	/* try to pass down hints given by users */
> > @@ -1193,6 +1200,7 @@ struct f2fs_sb_info {
> >  	struct mutex gc_mutex;			/* mutex for GC */
> >  	struct f2fs_gc_kthread	*gc_thread;	/* GC thread */
> >  	unsigned int cur_victim_sec;		/* current victim section num */
> > +	unsigned int gc_mode;			/* current GC state */
> >  
> >  	/* threshold for gc trials on pinned files */
> >  	u64 gc_pin_file_threshold;
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index 9bb2ddbbed1e..7ec8ea75dfde 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -76,7 +76,7 @@ static int gc_thread_func(void *data)
> >  		 * invalidated soon after by user update or deletion.
> >  		 * So, I'd like to wait some time to collect dirty segments.
> >  		 */
> > -		if (gc_th->gc_urgent) {
> > +		if (sbi->gc_mode == GC_URGENT) {
> >  			wait_ms = gc_th->urgent_sleep_time;
> >  			mutex_lock(&sbi->gc_mutex);
> >  			goto do_gc;
> > @@ -131,8 +131,6 @@ int start_gc_thread(struct f2fs_sb_info *sbi)
> >  	gc_th->max_sleep_time = DEF_GC_THREAD_MAX_SLEEP_TIME;
> >  	gc_th->no_gc_sleep_time = DEF_GC_THREAD_NOGC_SLEEP_TIME;
> >  
> > -	gc_th->gc_idle = 0;
> > -	gc_th->gc_urgent = 0;
> >  	gc_th->gc_wake= 0;
> >  
> >  	sbi->gc_thread = gc_th;
> > @@ -158,21 +156,19 @@ void stop_gc_thread(struct f2fs_sb_info *sbi)
> >  	sbi->gc_thread = NULL;
> >  }
> >  
> > -static int select_gc_type(struct f2fs_gc_kthread *gc_th, int gc_type)
> > +static int select_gc_type(struct f2fs_sb_info *sbi, int gc_type)
> >  {
> >  	int gc_mode = (gc_type == BG_GC) ? GC_CB : GC_GREEDY;
> >  
> > -	if (!gc_th)
> > -		return gc_mode;
> > -
> > -	if (gc_th->gc_idle) {
> > -		if (gc_th->gc_idle == 1)
> > -			gc_mode = GC_CB;
> > -		else if (gc_th->gc_idle == 2)
> > -			gc_mode = GC_GREEDY;
> > -	}
> > -	if (gc_th->gc_urgent)
> > +	switch (sbi->gc_mode) {
> > +	case GC_IDLE_CB:
> > +		gc_mode = GC_CB;
> > +		break;
> > +	case GC_IDLE_GREEDY:
> > +	case GC_URGENT:
> >  		gc_mode = GC_GREEDY;
> > +		break;
> > +	}
> >  	return gc_mode;
> >  }
> >  
> > @@ -187,7 +183,7 @@ static void select_policy(struct f2fs_sb_info *sbi, int gc_type,
> >  		p->max_search = dirty_i->nr_dirty[type];
> >  		p->ofs_unit = 1;
> >  	} else {
> > -		p->gc_mode = select_gc_type(sbi->gc_thread, gc_type);
> > +		p->gc_mode = select_gc_type(sbi, gc_type);
> >  		p->dirty_segmap = dirty_i->dirty_segmap[DIRTY];
> >  		p->max_search = dirty_i->nr_dirty[DIRTY];
> >  		p->ofs_unit = sbi->segs_per_sec;
> > @@ -195,7 +191,7 @@ static void select_policy(struct f2fs_sb_info *sbi, int gc_type,
> >  
> >  	/* we need to check every dirty segments in the FG_GC case */
> >  	if (gc_type != FG_GC &&
> > -			(sbi->gc_thread && !sbi->gc_thread->gc_urgent) &&
> > +			(sbi->gc_mode != GC_URGENT) &&
> >  			p->max_search > sbi->max_victim_search)
> >  		p->max_search = sbi->max_victim_search;
> >  
> > diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
> > index b0045d4c8d1e..c8619e408009 100644
> > --- a/fs/f2fs/gc.h
> > +++ b/fs/f2fs/gc.h
> > @@ -36,8 +36,6 @@ struct f2fs_gc_kthread {
> >  	unsigned int no_gc_sleep_time;
> >  
> >  	/* for changing gc mode */
> > -	unsigned int gc_idle;
> > -	unsigned int gc_urgent;
> >  	unsigned int gc_wake;
> >  };
> >  
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 503a98abdb2f..5a7ed06291e0 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -177,7 +177,7 @@ bool need_SSR(struct f2fs_sb_info *sbi)
> >  
> >  	if (test_opt(sbi, LFS))
> >  		return false;
> > -	if (sbi->gc_thread && sbi->gc_thread->gc_urgent)
> > +	if (sbi->gc_mode == GC_URGENT)
> >  		return true;
> >  
> >  	return free_sections(sbi) <= (node_secs + 2 * dent_secs + imeta_secs +
> > @@ -1418,7 +1418,7 @@ static int issue_discard_thread(void *data)
> >  		if (dcc->discard_wake)
> >  			dcc->discard_wake = 0;
> >  
> > -		if (sbi->gc_thread && sbi->gc_thread->gc_urgent)
> > +		if (sbi->gc_mode == GC_URGENT)
> >  			init_discard_policy(&dpolicy, DPOLICY_FORCE, 1);
> >  
> >  		sb_start_intwrite(sbi->sb);
> > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > index 6d8d8f41e517..dd940d156af6 100644
> > --- a/fs/f2fs/sysfs.c
> > +++ b/fs/f2fs/sysfs.c
> > @@ -248,16 +248,33 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
> >  	if (!strcmp(a->attr.name, "trim_sections"))
> >  		return -EINVAL;
> >  
> > +	if (!strcmp(a->attr.name, "gc_urgent")) {
> > +		if (t >= 1) {
> > +			sbi->gc_mode = GC_URGENT;
> > +			if (sbi->gc_thread) {
> > +				wake_up_interruptible_all(
> > +					&sbi->gc_thread->gc_wait_queue_head);
> > +				wake_up_discard_thread(sbi, true);
> > +			}
> > +		} else {
> > +			sbi->gc_mode = GC_NORMAL;
> > +		}
> > +		return count;
> > +	}
> > +	if (!strcmp(a->attr.name, "gc_idle")) {
> > +		if (t == GC_IDLE_CB)
> > +			sbi->gc_mode = GC_IDLE_CB;
> > +		else if (t == GC_IDLE_GREEDY)
> > +			sbi->gc_mode = GC_IDLE_GREEDY;
> > +		else
> > +			sbi->gc_mode = GC_NORMAL;
> > +		return count;
> > +	}
> > +
> >  	*ui = t;
> >  
> >  	if (!strcmp(a->attr.name, "iostat_enable") && *ui == 0)
> >  		f2fs_reset_iostat(sbi);
> > -	if (!strcmp(a->attr.name, "gc_urgent") && t == 1 && sbi->gc_thread) {
> > -		sbi->gc_thread->gc_wake = 1;
> > -		wake_up_interruptible_all(&sbi->gc_thread->gc_wait_queue_head);
> > -		wake_up_discard_thread(sbi, true);
> > -	}
> > -
> >  	return count;
> >  }
> >  
> > @@ -349,8 +366,8 @@ F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_urgent_sleep_time,
> >  F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_min_sleep_time, min_sleep_time);
> >  F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_max_sleep_time, max_sleep_time);
> >  F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_no_gc_sleep_time, no_gc_sleep_time);
> 
> All above parameters will be accessed via '*ui = t;', in order to avoid that, we
> need to move all gc_* configuration fields into sbi, so leaving f2fs_gc_kthread
> all most empty.

What I said was to use down_read(&sbi->sb->s_umount); in sysfs.c on top of this.

> IMO, just merge my v1 patch is OK? since that patch makes better
> encapsulation, so that background GC related parameter can still locate in
> independent f2fs_gc_kthread structure rather in common f2fs_sb_info structure.
> 
> Thanks,
> 
> > -F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_idle, gc_idle);
> > -F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_urgent, gc_urgent);
> > +F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_idle, gc_mode);
> > +F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_urgent, gc_mode);
> >  F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, reclaim_segments, rec_prefree_segments);
> >  F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_small_discards, max_discards);
> >  F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, discard_granularity, discard_granularity);
> > 
