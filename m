Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754228AbeDTD2A (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 23:28:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753964AbeDTD16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 23:27:58 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF832170D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jaegeuk@kernel.org
Date: Thu, 19 Apr 2018 20:27:57 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        chao@kernel.org
Subject: Re: [PATCH 3/5] f2fs: avoid stucking GC due to atomic write
Message-ID: <20180420032757.GG39280@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180418094505.98888-1-yuchao0@huawei.com>
 <20180418094505.98888-3-yuchao0@huawei.com>
 <20180420031238.GC39280@jaegeuk-macbookpro.roam.corp.google.com>
 <bc1936b6-52ee-cf29-4773-9a5b9bb68f29@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc1936b6-52ee-cf29-4773-9a5b9bb68f29@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/20, Chao Yu wrote:
> On 2018/4/20 11:12, Jaegeuk Kim wrote:
> > On 04/18, Chao Yu wrote:
> >> f2fs doesn't allow abuse on atomic write class interface, so except
> >> limiting in-mem pages' total memory usage capacity, we need to limit
> >> atomic-write usage as well when filesystem is seriously fragmented,
> >> otherwise we may run into infinite loop during foreground GC because
> >> target blocks in victim segment are belong to atomic opened file for
> >> long time.
> >>
> >> Now, we will detect failure due to atomic write in foreground GC, if
> >> the count exceeds threshold, we will drop all atomic written data in
> >> cache, by this, I expect it can keep our system running safely to
> >> prevent Dos attack.
> >>
> >> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >>  fs/f2fs/f2fs.h    |  1 +
> >>  fs/f2fs/file.c    |  5 +++++
> >>  fs/f2fs/gc.c      | 27 +++++++++++++++++++++++----
> >>  fs/f2fs/gc.h      |  3 +++
> >>  fs/f2fs/segment.c |  1 +
> >>  fs/f2fs/segment.h |  2 ++
> >>  6 files changed, 35 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >> index c1c3a1d11186..3453288d6a71 100644
> >> --- a/fs/f2fs/f2fs.h
> >> +++ b/fs/f2fs/f2fs.h
> >> @@ -2249,6 +2249,7 @@ enum {
> >>  	FI_EXTRA_ATTR,		/* indicate file has extra attribute */
> >>  	FI_PROJ_INHERIT,	/* indicate file inherits projectid */
> >>  	FI_PIN_FILE,		/* indicate file should not be gced */
> >> +	FI_ATOMIC_REVOKE_REQUEST,/* indicate atomic committed data has been dropped */
> >>  };
> >>  
> >>  static inline void __mark_inode_dirty_flag(struct inode *inode,
> >> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >> index 7c90ded5a431..cddd9aee1bb2 100644
> >> --- a/fs/f2fs/file.c
> >> +++ b/fs/f2fs/file.c
> >> @@ -1698,6 +1698,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
> >>  skip_flush:
> >>  	set_inode_flag(inode, FI_HOT_DATA);
> >>  	set_inode_flag(inode, FI_ATOMIC_FILE);
> >> +	clear_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
> >>  	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
> >>  
> >>  	F2FS_I(inode)->inmem_task = current;
> >> @@ -1746,6 +1747,10 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
> >>  		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 1, false);
> >>  	}
> >>  err_out:
> >> +	if (is_inode_flag_set(inode, FI_ATOMIC_REVOKE_REQUEST)) {
> >> +		clear_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
> >> +		ret = -EINVAL;
> >> +	}
> >>  	up_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
> >>  	inode_unlock(inode);
> >>  	mnt_drop_write_file(filp);
> >> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> >> index bfb7a4a3a929..495876ca62b6 100644
> >> --- a/fs/f2fs/gc.c
> >> +++ b/fs/f2fs/gc.c
> >> @@ -135,6 +135,8 @@ int start_gc_thread(struct f2fs_sb_info *sbi)
> >>  	gc_th->gc_urgent = 0;
> >>  	gc_th->gc_wake= 0;
> >>  
> >> +	gc_th->atomic_file = 0;
> >> +
> >>  	sbi->gc_thread = gc_th;
> >>  	init_waitqueue_head(&sbi->gc_thread->gc_wait_queue_head);
> >>  	sbi->gc_thread->f2fs_gc_task = kthread_run(gc_thread_func, sbi,
> >> @@ -603,7 +605,7 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
> >>   * This can be used to move blocks, aka LBAs, directly on disk.
> >>   */
> >>  static void move_data_block(struct inode *inode, block_t bidx,
> >> -					unsigned int segno, int off)
> >> +				int gc_type, unsigned int segno, int off)
> >>  {
> >>  	struct f2fs_io_info fio = {
> >>  		.sbi = F2FS_I_SB(inode),
> >> @@ -630,8 +632,10 @@ static void move_data_block(struct inode *inode, block_t bidx,
> >>  	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
> >>  		goto out;
> >>  
> >> -	if (f2fs_is_atomic_file(inode))
> >> +	if (f2fs_is_atomic_file(inode)) {
> >> +		F2FS_I_SB(inode)->gc_thread->atomic_file++;
> >>  		goto out;
> >> +	}
> >>  
> >>  	if (f2fs_is_pinned_file(inode)) {
> >>  		f2fs_pin_file_control(inode, true);
> >> @@ -737,8 +741,10 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
> >>  	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
> >>  		goto out;
> >>  
> >> -	if (f2fs_is_atomic_file(inode))
> >> +	if (f2fs_is_atomic_file(inode)) {
> >> +		F2FS_I_SB(inode)->gc_thread->atomic_file++;
> >>  		goto out;
> >> +	}
> >>  	if (f2fs_is_pinned_file(inode)) {
> >>  		if (gc_type == FG_GC)
> >>  			f2fs_pin_file_control(inode, true);
> >> @@ -900,7 +906,8 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
> >>  			start_bidx = start_bidx_of_node(nofs, inode)
> >>  								+ ofs_in_node;
> >>  			if (f2fs_encrypted_file(inode))
> >> -				move_data_block(inode, start_bidx, segno, off);
> >> +				move_data_block(inode, start_bidx, gc_type,
> >> +								segno, off);
> >>  			else
> >>  				move_data_page(inode, start_bidx, gc_type,
> >>  								segno, off);
> >> @@ -1017,6 +1024,8 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
> >>  		.ilist = LIST_HEAD_INIT(gc_list.ilist),
> >>  		.iroot = RADIX_TREE_INIT(GFP_NOFS),
> >>  	};
> >> +	unsigned int last_atomic_file = sbi->gc_thread->atomic_file;
> >> +	unsigned int skipped_round = 0, round = 0;
> >>  
> >>  	trace_f2fs_gc_begin(sbi->sb, sync, background,
> >>  				get_pages(sbi, F2FS_DIRTY_NODES),
> >> @@ -1068,11 +1077,21 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
> >>  		sec_freed++;
> >>  	total_freed += seg_freed;
> >>  
> >> +	if (gc_type == FG_GC) {
> >> +		if (sbi->gc_thread->atomic_file > last_atomic_file)
> >> +			skipped_round++;
> >> +		last_atomic_file = sbi->gc_thread->atomic_file;
> > 
> > How about resetting ->atomic_file to zero?
> 
> Since we will show this stat number through sysfs entry, it'd better to keep its
> data?

Alright, but we need to manage overflow?

> 
> Thanks,
> 
> > 
> >> +		round++;
> >> +	}
> >> +
> >>  	if (gc_type == FG_GC)
> >>  		sbi->cur_victim_sec = NULL_SEGNO;
> >>  
> >>  	if (!sync) {
> >>  		if (has_not_enough_free_secs(sbi, sec_freed, 0)) {
> >> +			if (skipped_round > MAX_SKIP_ATOMIC_COUNT &&
> >> +				skipped_round * 2 >= round)
> >> +				drop_inmem_pages_all(sbi);
> >>  			segno = NULL_SEGNO;
> >>  			goto gc_more;
> >>  		}
> >> diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
> >> index b0045d4c8d1e..bc1d21d46ae7 100644
> >> --- a/fs/f2fs/gc.h
> >> +++ b/fs/f2fs/gc.h
> >> @@ -39,6 +39,9 @@ struct f2fs_gc_kthread {
> >>  	unsigned int gc_idle;
> >>  	unsigned int gc_urgent;
> >>  	unsigned int gc_wake;
> >> +
> >> +	/* for stuck statistic */
> >> +	unsigned int atomic_file;
> >>  };
> >>  
> >>  struct gc_inode_list {
> >> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >> index d809f731bfd1..831cefa088bc 100644
> >> --- a/fs/f2fs/segment.c
> >> +++ b/fs/f2fs/segment.c
> >> @@ -287,6 +287,7 @@ void drop_inmem_pages_all(struct f2fs_sb_info *sbi)
> >>  	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
> >>  
> >>  	if (inode) {
> >> +		set_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
> >>  		drop_inmem_pages(inode);
> >>  		iput(inode);
> >>  	}
> >> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> >> index 492ad0c86fa9..7702b054689c 100644
> >> --- a/fs/f2fs/segment.h
> >> +++ b/fs/f2fs/segment.h
> >> @@ -215,6 +215,8 @@ struct segment_allocation {
> >>  #define IS_DUMMY_WRITTEN_PAGE(page)			\
> >>  		(page_private(page) == (unsigned long)DUMMY_WRITTEN_PAGE)
> >>  
> >> +#define MAX_SKIP_ATOMIC_COUNT			16
> >> +
> >>  struct inmem_pages {
> >>  	struct list_head list;
> >>  	struct page *page;
> >> -- 
> >> 2.15.0.55.gc2ece9dc4de6
> > 
> > .
> > 
