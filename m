Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306EAC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59CB22391
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 19:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wmv2diPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C59CB22391
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbeHIWZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 18:25:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:41732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726931AbeHIWZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 18:25:41 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AA8E2238C;
        Thu,  9 Aug 2018 19:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533844758;
        bh=bZfKCEPnJqxQamfBFAxjjvQwgTBlLhwKJtr4R/86KuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wmv2diPYnN/zSJEZ3EBolA+smgxLnoaPQfeUS13d4tFCSFzI5/i06IsLZDUc3RP4B
         kIpukR7EEB/BkweL3p3PUweGKguF0Ya8XBPAz2Le3JmcV2sjoZ+WT5fZ2ZPvxLOCwu
         /hndSeJ02tEDuKST0IOGDneyj46Wajx3iDjLZnrM=
Date:   Thu, 9 Aug 2018 12:59:17 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: avoid fi->i_gc_rwsem[WRITE] lock in
 f2fs_gc
Message-ID: <20180809195917.GA27087@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180730013242.15647-1-jaegeuk@kernel.org>
 <20180804222954.GB35077@jaegeuk-macbookpro.roam.corp.google.com>
 <20180805163450.GB55836@jaegeuk-macbookpro.roam.corp.google.com>
 <16d7f719-268f-99f4-c5b2-fc893b557f11@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16d7f719-268f-99f4-c5b2-fc893b557f11@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09, Chao Yu wrote:
> On 2018/8/6 0:34, Jaegeuk Kim wrote:
> > The f2fs_gc() called by f2fs_balance_fs() requires to be called outside of
> > fi->i_gc_rwsem[WRITE], since f2fs_gc() can try to grab it in a loop.
> > 
> > If it hits the miximum retrials in GC, let's give a chance to release
> > gc_mutex for a short time in order not to go into live lock in the worst
> > case.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  v3
> >   - don't revoke atomic_writes all the time due to gc_rwsem
> >   - keep lock order in f2fs_commit_inmem_pages
> > 
> >  fs/f2fs/f2fs.h    |  1 +
> >  fs/f2fs/file.c    | 76 ++++++++++++++++++++++++-----------------------
> >  fs/f2fs/gc.c      | 24 +++++++++++----
> >  fs/f2fs/segment.c |  6 +++-
> >  fs/f2fs/segment.h |  2 +-
> >  5 files changed, 64 insertions(+), 45 deletions(-)
> > 
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 1647a13be7f9..0c65c3146ead 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1234,6 +1234,7 @@ struct f2fs_sb_info {
> >  	unsigned int gc_mode;			/* current GC state */
> >  	/* for skip statistic */
> >  	unsigned long long skipped_atomic_files[2];	/* FG_GC and BG_GC */
> > +	unsigned long long skipped_gc_rwsem;		/* FG_GC only */
> >  
> >  	/* threshold for gc trials on pinned files */
> >  	u64 gc_pin_file_threshold;
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 67c9c2d4e2d9..4e2e3938f474 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -1180,25 +1180,31 @@ static int __exchange_data_block(struct inode *src_inode,
> >  	return ret;
> >  }
> >  
> > -static int f2fs_do_collapse(struct inode *inode, pgoff_t start, pgoff_t end)
> > +static int f2fs_do_collapse(struct inode *inode, loff_t offset, loff_t len)
> >  {
> >  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> >  	pgoff_t nrpages = (i_size_read(inode) + PAGE_SIZE - 1) / PAGE_SIZE;
> > +	pgoff_t start = offset >> PAGE_SHIFT;
> > +	pgoff_t end = (offset + len) >> PAGE_SHIFT;
> >  	int ret;
> >  
> >  	f2fs_balance_fs(sbi, true);
> > -	f2fs_lock_op(sbi);
> >  
> > -	f2fs_drop_extent_tree(inode);
> > +	/* avoid gc operation during block exchange */
> > +	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> >  
> > +	f2fs_lock_op(sbi);
> > +	f2fs_drop_extent_tree(inode);
> > +	truncate_pagecache(inode, offset);
> >  	ret = __exchange_data_block(inode, inode, end, start, nrpages - end, true);
> >  	f2fs_unlock_op(sbi);
> > +
> > +	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> >  	return ret;
> >  }
> >  
> >  static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
> >  {
> > -	pgoff_t pg_start, pg_end;
> >  	loff_t new_size;
> >  	int ret;
> >  
> > @@ -1213,21 +1219,13 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
> >  	if (ret)
> >  		return ret;
> >  
> > -	pg_start = offset >> PAGE_SHIFT;
> > -	pg_end = (offset + len) >> PAGE_SHIFT;
> > -
> > -	/* avoid gc operation during block exchange */
> > -	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> > -
> >  	down_write(&F2FS_I(inode)->i_mmap_sem);
> >  	/* write out all dirty pages from offset */
> >  	ret = filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
> >  	if (ret)
> >  		goto out_unlock;
> >  
> > -	truncate_pagecache(inode, offset);
> > -
> > -	ret = f2fs_do_collapse(inode, pg_start, pg_end);
> > +	ret = f2fs_do_collapse(inode, offset, len);
> >  	if (ret)
> >  		goto out_unlock;
> >  
> > @@ -1243,7 +1241,6 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
> >  		f2fs_i_size_write(inode, new_size);
> >  out_unlock:
> >  	up_write(&F2FS_I(inode)->i_mmap_sem);
> > -	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> >  	return ret;
> >  }
> >  
> > @@ -1418,9 +1415,6 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
> >  
> >  	f2fs_balance_fs(sbi, true);
> >  
> > -	/* avoid gc operation during block exchange */
> > -	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> > -
> >  	down_write(&F2FS_I(inode)->i_mmap_sem);
> >  	ret = f2fs_truncate_blocks(inode, i_size_read(inode), true);
> >  	if (ret)
> > @@ -1431,13 +1425,15 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
> >  	if (ret)
> >  		goto out;
> >  
> > -	truncate_pagecache(inode, offset);
> > -
> >  	pg_start = offset >> PAGE_SHIFT;
> >  	pg_end = (offset + len) >> PAGE_SHIFT;
> >  	delta = pg_end - pg_start;
> >  	idx = (i_size_read(inode) + PAGE_SIZE - 1) / PAGE_SIZE;
> >  
> > +	/* avoid gc operation during block exchange */
> > +	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> > +	truncate_pagecache(inode, offset);
> > +
> >  	while (!ret && idx > pg_start) {
> >  		nr = idx - pg_start;
> >  		if (nr > delta)
> > @@ -1451,6 +1447,7 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
> >  					idx + delta, nr, false);
> >  		f2fs_unlock_op(sbi);
> >  	}
> > +	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> >  
> >  	/* write out all moved pages, if possible */
> >  	filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
> > @@ -1460,7 +1457,6 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
> >  		f2fs_i_size_write(inode, new_size);
> >  out:
> >  	up_write(&F2FS_I(inode)->i_mmap_sem);
> > -	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> >  	return ret;
> >  }
> >  
> > @@ -1707,8 +1703,6 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
> >  
> >  	inode_lock(inode);
> >  
> > -	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> > -
> >  	if (f2fs_is_atomic_file(inode)) {
> >  		if (is_inode_flag_set(inode, FI_ATOMIC_REVOKE_REQUEST))
> >  			ret = -EINVAL;
> > @@ -1719,6 +1713,8 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
> >  	if (ret)
> >  		goto out;
> >  
> > +	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> > +
> >  	if (!get_dirty_pages(inode))
> >  		goto skip_flush;
> >  
> > @@ -1726,18 +1722,20 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
> >  		"Unexpected flush for atomic writes: ino=%lu, npages=%u",
> >  					inode->i_ino, get_dirty_pages(inode));
> >  	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
> > -	if (ret)
> > +	if (ret) {
> > +		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> >  		goto out;
> > +	}
> >  skip_flush:
> >  	set_inode_flag(inode, FI_ATOMIC_FILE);
> >  	clear_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
> > -	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
> > +	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> >  
> > +	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
> >  	F2FS_I(inode)->inmem_task = current;
> >  	stat_inc_atomic_write(inode);
> >  	stat_update_max_atomic_write(inode);
> >  out:
> > -	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> >  	inode_unlock(inode);
> >  	mnt_drop_write_file(filp);
> >  	return ret;
> > @@ -1755,9 +1753,9 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
> >  	if (ret)
> >  		return ret;
> >  
> > -	inode_lock(inode);
> > +	f2fs_balance_fs(F2FS_I_SB(inode), true);
> >  
> > -	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> > +	inode_lock(inode);
> >  
> >  	if (f2fs_is_volatile_file(inode)) {
> >  		ret = -EINVAL;
> > @@ -1783,7 +1781,6 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
> >  		clear_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
> >  		ret = -EINVAL;
> >  	}
> > -	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> >  	inode_unlock(inode);
> >  	mnt_drop_write_file(filp);
> >  	return ret;
> > @@ -2379,15 +2376,10 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
> >  	}
> >  
> >  	inode_lock(src);
> > -	down_write(&F2FS_I(src)->i_gc_rwsem[WRITE]);
> >  	if (src != dst) {
> >  		ret = -EBUSY;
> >  		if (!inode_trylock(dst))
> >  			goto out;
> > -		if (!down_write_trylock(&F2FS_I(dst)->i_gc_rwsem[WRITE])) {
> > -			inode_unlock(dst);
> > -			goto out;
> > -		}
> >  	}
> >  
> >  	ret = -EINVAL;
> > @@ -2432,6 +2424,14 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
> >  		goto out_unlock;
> >  
> >  	f2fs_balance_fs(sbi, true);
> > +
> > +	down_write(&F2FS_I(src)->i_gc_rwsem[WRITE]);
> > +	if (src != dst) {
> > +		ret = -EBUSY;
> > +		if (!down_write_trylock(&F2FS_I(dst)->i_gc_rwsem[WRITE]))
> > +			goto out_src;
> > +	}
> > +
> >  	f2fs_lock_op(sbi);
> >  	ret = __exchange_data_block(src, dst, pos_in >> F2FS_BLKSIZE_BITS,
> >  				pos_out >> F2FS_BLKSIZE_BITS,
> > @@ -2444,13 +2444,15 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
> >  			f2fs_i_size_write(dst, dst_osize);
> >  	}
> >  	f2fs_unlock_op(sbi);
> > -out_unlock:
> > -	if (src != dst) {
> > +
> > +	if (src != dst)
> >  		up_write(&F2FS_I(dst)->i_gc_rwsem[WRITE]);
> > +out_src:
> > +	up_write(&F2FS_I(src)->i_gc_rwsem[WRITE]);
> > +out_unlock:
> > +	if (src != dst)
> >  		inode_unlock(dst);
> > -	}
> >  out:
> > -	up_write(&F2FS_I(src)->i_gc_rwsem[WRITE]);
> >  	inode_unlock(src);
> >  	return ret;
> >  }
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index e352fbd33848..d816c328f02b 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -884,6 +884,7 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
> >  			if (!down_write_trylock(
> >  				&F2FS_I(inode)->i_gc_rwsem[WRITE])) {
> >  				iput(inode);
> > +				sbi->skipped_gc_rwsem++;
> >  				continue;
> >  			}
> >  
> > @@ -913,6 +914,7 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
> >  					continue;
> >  				if (!down_write_trylock(
> >  						&fi->i_gc_rwsem[WRITE])) {
> > +					sbi->skipped_gc_rwsem++;
> >  					up_write(&fi->i_gc_rwsem[READ]);
> >  					continue;
> >  				}
> > @@ -1062,6 +1064,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
> >  				prefree_segments(sbi));
> >  
> >  	cpc.reason = __get_cp_reason(sbi);
> > +	sbi->skipped_gc_rwsem = 0;
> >  gc_more:
> >  	if (unlikely(!(sbi->sb->s_flags & SB_ACTIVE))) {
> >  		ret = -EINVAL;
> > @@ -1103,7 +1106,8 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
> >  	total_freed += seg_freed;
> >  
> >  	if (gc_type == FG_GC) {
> > -		if (sbi->skipped_atomic_files[FG_GC] > last_skipped)
> > +		if (sbi->skipped_atomic_files[FG_GC] > last_skipped ||
> > +						sbi->skipped_gc_rwsem)
> >  			skipped_round++;
> >  		last_skipped = sbi->skipped_atomic_files[FG_GC];
> >  		round++;
> > @@ -1112,15 +1116,23 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
> >  	if (gc_type == FG_GC)
> >  		sbi->cur_victim_sec = NULL_SEGNO;
> >  
> > -	if (!sync) {
> > -		if (has_not_enough_free_secs(sbi, sec_freed, 0)) {
> > -			if (skipped_round > MAX_SKIP_ATOMIC_COUNT &&
> > -				skipped_round * 2 >= round)
> > -				f2fs_drop_inmem_pages_all(sbi, true);
> > +	if (sync)
> > +		goto stop;
> > +
> > +	if (has_not_enough_free_secs(sbi, sec_freed, 0)) {
> > +		if (skipped_round <= MAX_SKIP_GC_COUNT ||
> > +					skipped_round * 2 < round) {
> >  			segno = NULL_SEGNO;
> >  			goto gc_more;
> >  		}
> >  
> > +		if (sbi->skipped_atomic_files[FG_GC] == last_skipped &&
> 
> For fggc, sbi->skipped_atomic_files[FG_GC] should always be last_skipped, since
> we assigned above.
> 
> > +				sbi->skipped_atomic_files[FG_GC] >
> > +						sbi->skipped_gc_rwsem) {
> > +			f2fs_drop_inmem_pages_all(sbi, true);
> > +			segno = NULL_SEGNO;
> > +			goto gc_more;
> 
> I guess what you mean is:
> 
> atomic_skipped = sbi->skipped_atomic_files[FG_GC] - last_skipped;
> 
> if (atomic_skipped && atomic_skipped > sbi->skipped_gc_rwsem)
> 	f2fs_drop_inmem_pages_all();
> 
> Is that right?

Yup, how about this?

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index d816c328f02b..cb510fb36523 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1052,6 +1052,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 		.iroot = RADIX_TREE_INIT(gc_list.iroot, GFP_NOFS),
 	};
 	unsigned long long last_skipped = sbi->skipped_atomic_files[FG_GC];
+	unsigned long long first_skipped;
 	unsigned int skipped_round = 0, round = 0;
 
 	trace_f2fs_gc_begin(sbi->sb, sync, background,
@@ -1064,8 +1065,10 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 				prefree_segments(sbi));
 
 	cpc.reason = __get_cp_reason(sbi);
-	sbi->skipped_gc_rwsem = 0;
 gc_more:
+	sbi->skipped_gc_rwsem = 0;
+	first_skipped = last_skipped;
+
 	if (unlikely(!(sbi->sb->s_flags & SB_ACTIVE))) {
 		ret = -EINVAL;
 		goto stop;
@@ -1126,8 +1129,8 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 			goto gc_more;
 		}
 
-		if (sbi->skipped_atomic_files[FG_GC] == last_skipped &&
-				sbi->skipped_atomic_files[FG_GC] >
+		if (first_skipped < last_skipped &&
+				(last_skipped - first_skipped) >
 						sbi->skipped_gc_rwsem) {
 			f2fs_drop_inmem_pages_all(sbi, true);
 			segno = NULL_SEGNO;
