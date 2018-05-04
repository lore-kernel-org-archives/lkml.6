Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbeEDTAm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 15:00:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751522AbeEDTAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 15:00:40 -0400
Date: Fri, 4 May 2018 12:00:39 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        chao@kernel.org
Subject: Re: [PATCH v2] f2fs: avoid stucking GC due to atomic write
Message-ID: <20180504184313.GC27993@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180424025136.44247-1-yuchao0@huawei.com>
 <20180426155449.GG68594@jaegeuk-macbookpro.roam.corp.google.com>
 <b110085f-bcc2-c744-762d-123cea4d6b5b@huawei.com>
 <20180428023433.GB10595@jaegeuk-macbookpro.roam.corp.google.com>
 <b7257bc0-d65a-3ee5-bdd7-300f3903383e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7257bc0-d65a-3ee5-bdd7-300f3903383e@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02, Chao Yu wrote:
> On 2018/4/28 10:34, Jaegeuk Kim wrote:
> > On 04/27, Chao Yu wrote:
> >> On 2018/4/26 23:54, Jaegeuk Kim wrote:
> >>> On 04/24, Chao Yu wrote:
> >>>> f2fs doesn't allow abuse on atomic write class interface, so except
> >>>> limiting in-mem pages' total memory usage capacity, we need to limit
> >>>> atomic-write usage as well when filesystem is seriously fragmented,
> >>>> otherwise we may run into infinite loop during foreground GC because
> >>>> target blocks in victim segment are belong to atomic opened file for
> >>>> long time.
> >>>
> >>> How about using fi->i_gc_failure likewise pin_file?
> >>
> >> OK, how about changing it to array fi->i_gc_failure[MAX_GC_FAILURE], and change
> >> the type to unsigned long long to avoid overflow?
> > 
> > It'd be enough to share i_gc_failure between the types, IMO.
> 
> IMO, for atomic case, we don't need to persist the count into on-disk
> i_gc_failure, as we only care about in-mem value instead of on-disk one.
> Another concern is that if both functionalities are used, we can not decide to
> drop atomic written data due to the failure value which may be only increased by
> a pinned file.

Then, okay with the array. :P

> 
> Thanks,
> 
> > 
> >>
> >> enum {
> >> 	GC_FAILURE_PIN,
> >> 	GC_FAILURE_ATOMIC,
> >> 	MAX_GC_FAILURE
> >> }
> >>
> >> Thanks,
> >>
> >>>
> >>>>
> >>>> Now, we will detect failure due to atomic write in foreground GC, if
> >>>> the count exceeds threshold, we will drop all atomic written data in
> >>>> cache, by this, I expect it can keep our system running safely to
> >>>> prevent Dos attack.
> >>>>
> >>>> In addition, his patch adds to show GC skip information in debugfs,
> >>>> now it just shows count of skipped caused by atomic write.
> >>>>
> >>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >>>> ---
> >>>> v2:
> >>>> - add to show skip info in debugfs.
> >>>>  fs/f2fs/debug.c   |  8 ++++++++
> >>>>  fs/f2fs/f2fs.h    |  2 ++
> >>>>  fs/f2fs/file.c    |  5 +++++
> >>>>  fs/f2fs/gc.c      | 29 +++++++++++++++++++++++++----
> >>>>  fs/f2fs/gc.h      |  3 +++
> >>>>  fs/f2fs/segment.c |  1 +
> >>>>  fs/f2fs/segment.h |  2 ++
> >>>>  7 files changed, 46 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
> >>>> index 0fbd674c66fb..607b258a9b61 100644
> >>>> --- a/fs/f2fs/debug.c
> >>>> +++ b/fs/f2fs/debug.c
> >>>> @@ -104,6 +104,10 @@ static void update_general_status(struct f2fs_sb_info *sbi)
> >>>>  	si->avail_nids = NM_I(sbi)->available_nids;
> >>>>  	si->alloc_nids = NM_I(sbi)->nid_cnt[PREALLOC_NID];
> >>>>  	si->bg_gc = sbi->bg_gc;
> >>>> +	si->skipped_atomic_files[BG_GC] =
> >>>> +			sbi->gc_thread->skipped_atomic_files[BG_GC];
> >>>> +	si->skipped_atomic_files[FG_GC] =
> >>>> +			sbi->gc_thread->skipped_atomic_files[FG_GC];
> >>>>  	si->util_free = (int)(free_user_blocks(sbi) >> sbi->log_blocks_per_seg)
> >>>>  		* 100 / (int)(sbi->user_block_count >> sbi->log_blocks_per_seg)
> >>>>  		/ 2;
> >>>> @@ -341,6 +345,10 @@ static int stat_show(struct seq_file *s, void *v)
> >>>>  				si->bg_data_blks);
> >>>>  		seq_printf(s, "  - node blocks : %d (%d)\n", si->node_blks,
> >>>>  				si->bg_node_blks);
> >>>> +		seq_printf(s, "Skipped : atomic write %llu (%llu)\n",
> >>>> +				si->skipped_atomic_files[BG_GC] +
> >>>> +				si->skipped_atomic_files[FG_GC],
> >>>> +				si->skipped_atomic_files[BG_GC]);
> >>>>  		seq_puts(s, "\nExtent Cache:\n");
> >>>>  		seq_printf(s, "  - Hit Count: L1-1:%llu L1-2:%llu L2:%llu\n",
> >>>>  				si->hit_largest, si->hit_cached,
> >>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >>>> index 75d3b4875429..c2b92cb377c6 100644
> >>>> --- a/fs/f2fs/f2fs.h
> >>>> +++ b/fs/f2fs/f2fs.h
> >>>> @@ -2254,6 +2254,7 @@ enum {
> >>>>  	FI_EXTRA_ATTR,		/* indicate file has extra attribute */
> >>>>  	FI_PROJ_INHERIT,	/* indicate file inherits projectid */
> >>>>  	FI_PIN_FILE,		/* indicate file should not be gced */
> >>>> +	FI_ATOMIC_REVOKE_REQUEST,/* indicate atomic committed data has been dropped */
> >>>>  };
> >>>>  
> >>>>  static inline void __mark_inode_dirty_flag(struct inode *inode,
> >>>> @@ -3010,6 +3011,7 @@ struct f2fs_stat_info {
> >>>>  	int bg_node_segs, bg_data_segs;
> >>>>  	int tot_blks, data_blks, node_blks;
> >>>>  	int bg_data_blks, bg_node_blks;
> >>>> +	unsigned long long skipped_atomic_files[2];
> >>>>  	int curseg[NR_CURSEG_TYPE];
> >>>>  	int cursec[NR_CURSEG_TYPE];
> >>>>  	int curzone[NR_CURSEG_TYPE];
> >>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >>>> index a352804af244..0cfa65c21d3f 100644
> >>>> --- a/fs/f2fs/file.c
> >>>> +++ b/fs/f2fs/file.c
> >>>> @@ -1702,6 +1702,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
> >>>>  skip_flush:
> >>>>  	set_inode_flag(inode, FI_HOT_DATA);
> >>>>  	set_inode_flag(inode, FI_ATOMIC_FILE);
> >>>> +	clear_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
> >>>>  	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
> >>>>  
> >>>>  	F2FS_I(inode)->inmem_task = current;
> >>>> @@ -1750,6 +1751,10 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
> >>>>  		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 1, false);
> >>>>  	}
> >>>>  err_out:
> >>>> +	if (is_inode_flag_set(inode, FI_ATOMIC_REVOKE_REQUEST)) {
> >>>> +		clear_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
> >>>> +		ret = -EINVAL;
> >>>> +	}
> >>>>  	up_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
> >>>>  	inode_unlock(inode);
> >>>>  	mnt_drop_write_file(filp);
> >>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> >>>> index 2febb84b2fd6..ec6cb7b417a1 100644
> >>>> --- a/fs/f2fs/gc.c
> >>>> +++ b/fs/f2fs/gc.c
> >>>> @@ -135,6 +135,9 @@ int init_gc_context(struct f2fs_sb_info *sbi)
> >>>>  
> >>>>  	init_rwsem(&gc_th->gc_rwsem);
> >>>>  
> >>>> +	gc_th->skipped_atomic_files[BG_GC] = 0;
> >>>> +	gc_th->skipped_atomic_files[FG_GC] = 0;
> >>>> +
> >>>>  	sbi->gc_thread = gc_th;
> >>>>  
> >>>>  	return 0;
> >>>> @@ -629,7 +632,7 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
> >>>>   * This can be used to move blocks, aka LBAs, directly on disk.
> >>>>   */
> >>>>  static void move_data_block(struct inode *inode, block_t bidx,
> >>>> -					unsigned int segno, int off)
> >>>> +				int gc_type, unsigned int segno, int off)
> >>>>  {
> >>>>  	struct f2fs_io_info fio = {
> >>>>  		.sbi = F2FS_I_SB(inode),
> >>>> @@ -656,8 +659,10 @@ static void move_data_block(struct inode *inode, block_t bidx,
> >>>>  	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
> >>>>  		goto out;
> >>>>  
> >>>> -	if (f2fs_is_atomic_file(inode))
> >>>> +	if (f2fs_is_atomic_file(inode)) {
> >>>> +		GC_I(F2FS_I_SB(inode))->skipped_atomic_files[gc_type]++;
> >>>>  		goto out;
> >>>> +	}
> >>>>  
> >>>>  	if (f2fs_is_pinned_file(inode)) {
> >>>>  		f2fs_pin_file_control(inode, true);
> >>>> @@ -763,8 +768,10 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
> >>>>  	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
> >>>>  		goto out;
> >>>>  
> >>>> -	if (f2fs_is_atomic_file(inode))
> >>>> +	if (f2fs_is_atomic_file(inode)) {
> >>>> +		GC_I(F2FS_I_SB(inode))->skipped_atomic_files[gc_type]++;
> >>>>  		goto out;
> >>>> +	}
> >>>>  	if (f2fs_is_pinned_file(inode)) {
> >>>>  		if (gc_type == FG_GC)
> >>>>  			f2fs_pin_file_control(inode, true);
> >>>> @@ -926,7 +933,8 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
> >>>>  			start_bidx = start_bidx_of_node(nofs, inode)
> >>>>  								+ ofs_in_node;
> >>>>  			if (f2fs_post_read_required(inode))
> >>>> -				move_data_block(inode, start_bidx, segno, off);
> >>>> +				move_data_block(inode, start_bidx, gc_type,
> >>>> +								segno, off);
> >>>>  			else
> >>>>  				move_data_page(inode, start_bidx, gc_type,
> >>>>  								segno, off);
> >>>> @@ -1043,6 +1051,9 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
> >>>>  		.ilist = LIST_HEAD_INIT(gc_list.ilist),
> >>>>  		.iroot = RADIX_TREE_INIT(gc_list.iroot, GFP_NOFS),
> >>>>  	};
> >>>> +	unsigned long long last_skipped =
> >>>> +			GC_I(sbi)->skipped_atomic_files[FG_GC];
> >>>> +	unsigned int skipped_round = 0, round = 0;
> >>>>  
> >>>>  	trace_f2fs_gc_begin(sbi->sb, sync, background,
> >>>>  				get_pages(sbi, F2FS_DIRTY_NODES),
> >>>> @@ -1094,11 +1105,21 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
> >>>>  		sec_freed++;
> >>>>  	total_freed += seg_freed;
> >>>>  
> >>>> +	if (gc_type == FG_GC) {
> >>>> +		if (GC_I(sbi)->skipped_atomic_files[FG_GC] > last_skipped)
> >>>> +			skipped_round++;
> >>>> +		last_skipped = GC_I(sbi)->skipped_atomic_files[FG_GC];
> >>>> +		round++;
> >>>> +	}
> >>>> +
> >>>>  	if (gc_type == FG_GC)
> >>>>  		sbi->cur_victim_sec = NULL_SEGNO;
> >>>>  
> >>>>  	if (!sync) {
> >>>>  		if (has_not_enough_free_secs(sbi, sec_freed, 0)) {
> >>>> +			if (skipped_round > MAX_SKIP_ATOMIC_COUNT &&
> >>>> +				skipped_round * 2 >= round)
> >>>> +				drop_inmem_pages_all(sbi);
> >>>>  			segno = NULL_SEGNO;
> >>>>  			goto gc_more;
> >>>>  		}
> >>>> diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
> >>>> index 9a5b273328c2..9aa341cc4347 100644
> >>>> --- a/fs/f2fs/gc.h
> >>>> +++ b/fs/f2fs/gc.h
> >>>> @@ -40,6 +40,9 @@ struct f2fs_gc_kthread {
> >>>>  	unsigned int gc_idle;
> >>>>  	unsigned int gc_urgent;
> >>>>  	unsigned int gc_wake;
> >>>> +
> >>>> +	/* for skip statistic */
> >>>> +	unsigned long long skipped_atomic_files[2];
> >>>>  };
> >>>>  
> >>>>  struct gc_inode_list {
> >>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >>>> index f787eea1b2f6..ce108a909d66 100644
> >>>> --- a/fs/f2fs/segment.c
> >>>> +++ b/fs/f2fs/segment.c
> >>>> @@ -293,6 +293,7 @@ void drop_inmem_pages_all(struct f2fs_sb_info *sbi)
> >>>>  	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
> >>>>  
> >>>>  	if (inode) {
> >>>> +		set_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
> >>>>  		drop_inmem_pages(inode);
> >>>>  		iput(inode);
> >>>>  	}
> >>>> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> >>>> index 492ad0c86fa9..7702b054689c 100644
> >>>> --- a/fs/f2fs/segment.h
> >>>> +++ b/fs/f2fs/segment.h
> >>>> @@ -215,6 +215,8 @@ struct segment_allocation {
> >>>>  #define IS_DUMMY_WRITTEN_PAGE(page)			\
> >>>>  		(page_private(page) == (unsigned long)DUMMY_WRITTEN_PAGE)
> >>>>  
> >>>> +#define MAX_SKIP_ATOMIC_COUNT			16
> >>>> +
> >>>>  struct inmem_pages {
> >>>>  	struct list_head list;
> >>>>  	struct page *page;
> >>>> -- 
> >>>> 2.15.0.55.gc2ece9dc4de6
> >>>
> >>> .
> >>>
> > 
> > .
> > 
