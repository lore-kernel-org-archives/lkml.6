Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BADC46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 14:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1B121899
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 14:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcEWZNZk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C1B121899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbeHEQr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 12:47:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbeHEQr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 12:47:29 -0400
Received: from [192.168.0.101] (unknown [49.77.238.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B49E021898;
        Sun,  5 Aug 2018 14:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533480159;
        bh=znawiGXgLW+VrQfTHMwOMeoDpOBic5oySzQltcC+5XE=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=HcEWZNZkuasHmc3ozhBIAmumLficegfuIBGx6L0P8uxqKEhbglaOxRj73L17aCI09
         aSQ4Z+K+T8yQ9/w2h3wH3vOa0hhvAoHqGaRDQLEkp6dvNfD6n0YLnHKaGpDk+lIZMA
         jURVMgMuzr6aCQpXm7D2PtiP4LhEquEeSGw8nR40=
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: avoid fi->i_gc_rwsem[WRITE] lock in
 f2fs_gc
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20180730013242.15647-1-jaegeuk@kernel.org>
 <20180804222954.GB35077@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <chao@kernel.org>
X-Enigmail-Draft-Status: N11100
Message-ID: <4ab08c78-4a3a-4161-9c6f-2835829c95c3@kernel.org>
Date:   Sun, 5 Aug 2018 22:42:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180804222954.GB35077@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/5 6:29, Jaegeuk Kim wrote:
> The f2fs_gc() called by f2fs_balance_fs() requires to be called outside of
> fi->i_gc_rwsem[WRITE], since f2fs_gc() can try to grab it in a loop.
> 
> If it hits the miximum retrials in GC, let's give a chance to release
> gc_mutex for a short time in order not to go into live lock in the worst
> case.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> v2 log from v1:
>  - keep lock order: i_gc_rwsem -> lock_op
> 
>  fs/f2fs/f2fs.h    |  1 +
>  fs/f2fs/file.c    | 76 ++++++++++++++++++++++++-----------------------
>  fs/f2fs/gc.c      | 22 ++++++++++----
>  fs/f2fs/segment.c |  5 +++-
>  fs/f2fs/segment.h |  2 +-
>  5 files changed, 61 insertions(+), 45 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index a9447c7d6570..50349780001b 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1223,6 +1223,7 @@ struct f2fs_sb_info {
>  	unsigned int gc_mode;			/* current GC state */
>  	/* for skip statistic */
>  	unsigned long long skipped_atomic_files[2];	/* FG_GC and BG_GC */
> +	unsigned long long skipped_gc_rwsem;		/* FG_GC only */
>  
>  	/* threshold for gc trials on pinned files */
>  	u64 gc_pin_file_threshold;
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 78c1bd6b8497..7bcf47f41ef1 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1179,25 +1179,31 @@ static int __exchange_data_block(struct inode *src_inode,
>  	return ret;
>  }
>  
> -static int f2fs_do_collapse(struct inode *inode, pgoff_t start, pgoff_t end)
> +static int f2fs_do_collapse(struct inode *inode, loff_t offset, loff_t len)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	pgoff_t nrpages = (i_size_read(inode) + PAGE_SIZE - 1) / PAGE_SIZE;
> +	pgoff_t start = offset >> PAGE_SHIFT;
> +	pgoff_t end = (offset + len) >> PAGE_SHIFT;
>  	int ret;
>  
>  	f2fs_balance_fs(sbi, true);
> -	f2fs_lock_op(sbi);
>  
> -	f2fs_drop_extent_tree(inode);
> +	/* avoid gc operation during block exchange */
> +	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>  
> +	f2fs_lock_op(sbi);
> +	f2fs_drop_extent_tree(inode);
> +	truncate_pagecache(inode, offset);
>  	ret = __exchange_data_block(inode, inode, end, start, nrpages - end, true);
>  	f2fs_unlock_op(sbi);
> +
> +	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>  	return ret;
>  }
>  
>  static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
>  {
> -	pgoff_t pg_start, pg_end;
>  	loff_t new_size;
>  	int ret;
>  
> @@ -1212,21 +1218,13 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
>  	if (ret)
>  		return ret;
>  
> -	pg_start = offset >> PAGE_SHIFT;
> -	pg_end = (offset + len) >> PAGE_SHIFT;
> -
> -	/* avoid gc operation during block exchange */
> -	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> -
>  	down_write(&F2FS_I(inode)->i_mmap_sem);
>  	/* write out all dirty pages from offset */
>  	ret = filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
>  	if (ret)
>  		goto out_unlock;
>  
> -	truncate_pagecache(inode, offset);
> -
> -	ret = f2fs_do_collapse(inode, pg_start, pg_end);
> +	ret = f2fs_do_collapse(inode, offset, len);
>  	if (ret)
>  		goto out_unlock;
>  
> @@ -1242,7 +1240,6 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
>  		f2fs_i_size_write(inode, new_size);
>  out_unlock:
>  	up_write(&F2FS_I(inode)->i_mmap_sem);
> -	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>  	return ret;
>  }
>  
> @@ -1417,9 +1414,6 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
>  
>  	f2fs_balance_fs(sbi, true);
>  
> -	/* avoid gc operation during block exchange */
> -	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> -
>  	down_write(&F2FS_I(inode)->i_mmap_sem);
>  	ret = f2fs_truncate_blocks(inode, i_size_read(inode), true);
>  	if (ret)
> @@ -1430,13 +1424,15 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
>  	if (ret)
>  		goto out;
>  
> -	truncate_pagecache(inode, offset);
> -
>  	pg_start = offset >> PAGE_SHIFT;
>  	pg_end = (offset + len) >> PAGE_SHIFT;
>  	delta = pg_end - pg_start;
>  	idx = (i_size_read(inode) + PAGE_SIZE - 1) / PAGE_SIZE;
>  
> +	/* avoid gc operation during block exchange */
> +	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> +	truncate_pagecache(inode, offset);
> +
>  	while (!ret && idx > pg_start) {
>  		nr = idx - pg_start;
>  		if (nr > delta)
> @@ -1450,6 +1446,7 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
>  					idx + delta, nr, false);
>  		f2fs_unlock_op(sbi);
>  	}
> +	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>  
>  	/* write out all moved pages, if possible */
>  	filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
> @@ -1459,7 +1456,6 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
>  		f2fs_i_size_write(inode, new_size);
>  out:
>  	up_write(&F2FS_I(inode)->i_mmap_sem);
> -	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>  	return ret;
>  }
>  
> @@ -1706,8 +1702,6 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
>  
>  	inode_lock(inode);
>  
> -	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> -
>  	if (f2fs_is_atomic_file(inode)) {
>  		if (is_inode_flag_set(inode, FI_ATOMIC_REVOKE_REQUEST))
>  			ret = -EINVAL;
> @@ -1718,6 +1712,8 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
>  	if (ret)
>  		goto out;
>  
> +	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> +
>  	if (!get_dirty_pages(inode))
>  		goto skip_flush;
>  
> @@ -1725,18 +1721,20 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
>  		"Unexpected flush for atomic writes: ino=%lu, npages=%u",
>  					inode->i_ino, get_dirty_pages(inode));
>  	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
> -	if (ret)
> +	if (ret) {
> +		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>  		goto out;
> +	}
>  skip_flush:
>  	set_inode_flag(inode, FI_ATOMIC_FILE);
>  	clear_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
> -	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
> +	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>  
> +	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
>  	F2FS_I(inode)->inmem_task = current;
>  	stat_inc_atomic_write(inode);
>  	stat_update_max_atomic_write(inode);
>  out:
> -	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>  	inode_unlock(inode);
>  	mnt_drop_write_file(filp);
>  	return ret;
> @@ -1754,9 +1752,9 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
>  	if (ret)
>  		return ret;
>  
> -	inode_lock(inode);
> +	f2fs_balance_fs(F2FS_I_SB(inode), true);
>  
> -	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> +	inode_lock(inode);
>  
>  	if (f2fs_is_volatile_file(inode)) {
>  		ret = -EINVAL;
> @@ -1782,7 +1780,6 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
>  		clear_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
>  		ret = -EINVAL;
>  	}
> -	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>  	inode_unlock(inode);
>  	mnt_drop_write_file(filp);
>  	return ret;
> @@ -2378,15 +2375,10 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
>  	}
>  
>  	inode_lock(src);
> -	down_write(&F2FS_I(src)->i_gc_rwsem[WRITE]);
>  	if (src != dst) {
>  		ret = -EBUSY;
>  		if (!inode_trylock(dst))
>  			goto out;
> -		if (!down_write_trylock(&F2FS_I(dst)->i_gc_rwsem[WRITE])) {
> -			inode_unlock(dst);
> -			goto out;
> -		}
>  	}
>  
>  	ret = -EINVAL;
> @@ -2431,6 +2423,14 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
>  		goto out_unlock;
>  
>  	f2fs_balance_fs(sbi, true);
> +
> +	down_write(&F2FS_I(src)->i_gc_rwsem[WRITE]);
> +	if (src != dst) {
> +		ret = -EBUSY;
> +		if (!down_write_trylock(&F2FS_I(dst)->i_gc_rwsem[WRITE]))
> +			goto out_src;
> +	}
> +
>  	f2fs_lock_op(sbi);
>  	ret = __exchange_data_block(src, dst, pos_in >> F2FS_BLKSIZE_BITS,
>  				pos_out >> F2FS_BLKSIZE_BITS,
> @@ -2443,13 +2443,15 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
>  			f2fs_i_size_write(dst, dst_osize);
>  	}
>  	f2fs_unlock_op(sbi);
> -out_unlock:
> -	if (src != dst) {
> +
> +	if (src != dst)
>  		up_write(&F2FS_I(dst)->i_gc_rwsem[WRITE]);
> +out_src:
> +	up_write(&F2FS_I(src)->i_gc_rwsem[WRITE]);
> +out_unlock:
> +	if (src != dst)
>  		inode_unlock(dst);
> -	}
>  out:
> -	up_write(&F2FS_I(src)->i_gc_rwsem[WRITE]);
>  	inode_unlock(src);
>  	return ret;
>  }
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index e352fbd33848..cac317e37306 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -884,6 +884,7 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>  			if (!down_write_trylock(
>  				&F2FS_I(inode)->i_gc_rwsem[WRITE])) {
>  				iput(inode);
> +				sbi->skipped_gc_rwsem++;
>  				continue;
>  			}
>  
> @@ -913,6 +914,7 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>  					continue;
>  				if (!down_write_trylock(
>  						&fi->i_gc_rwsem[WRITE])) {
> +					sbi->skipped_gc_rwsem++;
>  					up_write(&fi->i_gc_rwsem[READ]);
>  					continue;
>  				}
> @@ -1062,6 +1064,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>  				prefree_segments(sbi));
>  
>  	cpc.reason = __get_cp_reason(sbi);
> +	sbi->skipped_gc_rwsem = 0;
>  gc_more:
>  	if (unlikely(!(sbi->sb->s_flags & SB_ACTIVE))) {
>  		ret = -EINVAL;
> @@ -1103,7 +1106,8 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>  	total_freed += seg_freed;
>  
>  	if (gc_type == FG_GC) {
> -		if (sbi->skipped_atomic_files[FG_GC] > last_skipped)
> +		if (sbi->skipped_atomic_files[FG_GC] > last_skipped ||
> +						sbi->skipped_gc_rwsem)

There should be other foreground ops like DIO can race with GC, in such case, if
we increase sbi->skipped_gc_rwsem, and call f2fs_drop_inmem_pages_all() to drop
inmem pages later, it doesn't help?

>  			skipped_round++;
>  		last_skipped = sbi->skipped_atomic_files[FG_GC];
>  		round++;
> @@ -1112,15 +1116,21 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>  	if (gc_type == FG_GC)
>  		sbi->cur_victim_sec = NULL_SEGNO;
>  
> -	if (!sync) {
> -		if (has_not_enough_free_secs(sbi, sec_freed, 0)) {
> -			if (skipped_round > MAX_SKIP_ATOMIC_COUNT &&
> -				skipped_round * 2 >= round)
> -				f2fs_drop_inmem_pages_all(sbi, true);
> +	if (sync)
> +		goto stop;
> +
> +	if (has_not_enough_free_secs(sbi, sec_freed, 0)) {
> +		if (skipped_round <= MAX_SKIP_GC_COUNT ||
> +					skipped_round * 2 < round) {
>  			segno = NULL_SEGNO;
>  			goto gc_more;
>  		}
>  
> +		if (sbi->skipped_atomic_files[FG_GC] == last_skipped) {
> +			f2fs_drop_inmem_pages_all(sbi, true);
> +			segno = NULL_SEGNO;
> +			goto gc_more;
> +		}
>  		if (gc_type == FG_GC)
>  			ret = f2fs_write_checkpoint(sbi, &cpc);
>  	}
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 3662e1f429b4..15b3b095fd58 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -444,10 +444,12 @@ int f2fs_commit_inmem_pages(struct inode *inode)
>  	struct f2fs_inode_info *fi = F2FS_I(inode);
>  	int err;
>  
> -	f2fs_balance_fs(sbi, true);
> +	f2fs_balance_fs(F2FS_I_SB(inode), true);

We don't need to change sbi to F2FS_I_SB(inode).

down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);

Thanks,

> +
>  	f2fs_lock_op(sbi);
>  
>  	set_inode_flag(inode, FI_ATOMIC_COMMIT);
> +	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>  
>  	mutex_lock(&fi->inmem_lock);
>  	err = __f2fs_commit_inmem_pages(inode);
> @@ -458,6 +460,7 @@ int f2fs_commit_inmem_pages(struct inode *inode)
>  	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
>  	mutex_unlock(&fi->inmem_lock);
>  
> +	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>  	clear_inode_flag(inode, FI_ATOMIC_COMMIT);
>  
>  	f2fs_unlock_op(sbi);
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 50495515f0a0..b3d9e317ff0c 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -215,7 +215,7 @@ struct segment_allocation {
>  #define IS_DUMMY_WRITTEN_PAGE(page)			\
>  		(page_private(page) == (unsigned long)DUMMY_WRITTEN_PAGE)
>  
> -#define MAX_SKIP_ATOMIC_COUNT			16
> +#define MAX_SKIP_GC_COUNT			16
>  
>  struct inmem_pages {
>  	struct list_head list;
> 
