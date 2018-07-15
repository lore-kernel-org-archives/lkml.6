Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A458EECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 02:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B29208CC
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 02:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iwg/e8dM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B29208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387696AbeGOCrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 22:47:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731985AbeGOCrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 22:47:20 -0400
Received: from localhost (unknown [104.132.152.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55AA52089F;
        Sun, 15 Jul 2018 02:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531621567;
        bh=cz3Y0xRvYv8r/jicsBp5qfec24v7U1J3oNvMW6cv13c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iwg/e8dM5K4m29ev5aS8+9bewrdItZdGlltV1iFtkxddza/um9qPlG6XDpomyZww6
         fhD41dXhr/zAjk1bCYUIBT47fT7hPEcz1tPY07LEcT9IetMPoNp+gVo4KIMjxPTHAg
         50FjHpeDpCJlNZWIr5fS3AVjyS9YQXhgM43cX/p0=
Date:   Sun, 15 Jul 2018 11:26:03 +0900
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Chao Yu <yuchao0@huawei.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 1/1] f2fs: checkpoint disabling
Message-ID: <20180715022603.GC11571@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180712015347.55992-1-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712015347.55992-1-drosen@google.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11, Daniel Rosenberg wrote:
> This adds a lightweight non-persistent snapshotting scheme to f2fs.
> 
> To use, mount with the option checkpoint=disable, and to return to
> normal operation, remount with checkpoint=enable. If the filesystem
> is shut down before remounting with checkpoint=enable, it will revert
> back to its apparent state when it was first mounted with
> checkpoint=disable. This is useful for situations where you wish to be
> able to roll back the state of the disk in case of some critical
> failure.
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> ---
> 
> This probably needs some work in the mount/remount areas to ensure it
> plays nicely with all combinations of other options.
> I'm also unsure how it should interact with statfs.
> 
> It currently handles accounting for free space in checkpoint disabled
> mode by setting up addition tracking for free data blocks, node blocks,
> and segments. These are used in inc_valid_block_cnt and inc_valid_node_cnt
> to track what the state will be once the blocks are actually allocated.
> We choose new current segments in SSR mode first to avoid the edge case
> where the disk is not yet full, but we only have dirty segments remaining
> that happen to not be of the right type. We also agressively add segments
> to the dirty list instead of pre-free when it is possible to reuse them to
> allow us to continue without a checkpoint as long as possible.
> 
>  Documentation/filesystems/f2fs.txt |   5 ++
>  fs/f2fs/data.c                     |  21 ++++++
>  fs/f2fs/f2fs.h                     |  63 +++++++++++++++-
>  fs/f2fs/file.c                     |  18 +++++
>  fs/f2fs/gc.c                       |   4 +
>  fs/f2fs/segment.c                  |  96 +++++++++++-------------
>  fs/f2fs/segment.h                  |  66 +++++++++++++++++
>  fs/f2fs/super.c                    | 115 +++++++++++++++++++++++++++--
>  8 files changed, 326 insertions(+), 62 deletions(-)
> 
> diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
> index 69f8de9957397..a026b353a99d4 100644
> --- a/Documentation/filesystems/f2fs.txt
> +++ b/Documentation/filesystems/f2fs.txt
> @@ -193,6 +193,11 @@ fsync_mode=%s          Control the policy of fsync. Currently supports "posix",
>                         non-atomic files likewise "nobarrier" mount option.
>  test_dummy_encryption  Enable dummy encryption, which provides a fake fscrypt
>                         context. The fake fscrypt context is used by xfstests.
> +checkpoint=%s          Set to "disable" to turn off checkpointing. Set to "enable"
> +                       to reenable checkpointing. Is enabled by default. While
> +                       disabled, any unmounting or unexpected shutdowns will cause
> +                       the filesystem contents to appear as they did when the
> +                       filesystem was mounted with that option.
>  
>  ================================================================================
>  DEBUGFS ENTRIES
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 83d4cff445f53..b3fa713fd42bf 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1654,9 +1654,20 @@ bool f2fs_should_update_inplace(struct inode *inode, struct f2fs_io_info *fio)
>  bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	struct seg_entry *se;
> +	unsigned int segno, offset;
>  
>  	if (test_opt(sbi, LFS))
>  		return true;
> +	if (test_opt(sbi, DISABLE_CHECKPOINT)) {

		struct seg_entry *se;
		unsigned int segno, offset;

> +		if (fio->old_blkaddr == NULL_ADDR)
		                        ---------
					NEW_ADDR

> +			return true;
> +		segno = GET_SEGNO(sbi, fio->old_blkaddr);
> +		se = get_seg_entry(sbi, segno);
> +		offset = GET_BLKOFF_FROM_SEG0(sbi, fio->old_blkaddr);
> +		if (f2fs_test_bit(offset, se->ckpt_valid_map))
> +			return true;
> +	}
>  	if (S_ISDIR(inode->i_mode))
>  		return true;
>  	if (f2fs_is_atomic_file(inode))
> @@ -1684,9 +1695,12 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
>  {
>  	struct page *page = fio->page;
>  	struct inode *inode = page->mapping->host;
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	struct dnode_of_data dn;
>  	struct extent_info ei = {0,0,0};
>  	bool ipu_force = false;
> +	bool need_tmp_grab = test_opt(sbi, DISABLE_CHECKPOINT);
> +	blkcnt_t tmp_block = 1;
>  	int err = 0;
>  
>  	set_new_dnode(&dn, inode, NULL, NULL, 0);
> @@ -1750,6 +1764,11 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
>  	if (err)
>  		goto out_writepage;
>  
> +	if (need_tmp_grab) {
> +		err = inc_valid_block_count(sbi, dn.inode, &tmp_block);
> +		if (err)
> +			goto out_writepage;
> +	}
>  	set_page_writeback(page);
>  	ClearPageError(page);
>  
> @@ -1759,6 +1778,8 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
>  	set_inode_flag(inode, FI_APPEND_WRITE);
>  	if (page->index == 0)
>  		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
> +	if (need_tmp_grab)
> +		dec_valid_block_count(sbi, dn.inode, tmp_block);
>  out_writepage:
>  	f2fs_put_dnode(&dn);
>  out:
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index fe80eb637075c..024b6b971e214 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -97,6 +97,7 @@ extern char *fault_name[FAULT_MAX];
>  #define F2FS_MOUNT_QUOTA		0x00400000
>  #define F2FS_MOUNT_INLINE_XATTR_SIZE	0x00800000
>  #define F2FS_MOUNT_RESERVE_ROOT		0x01000000
> +#define F2FS_MOUNT_DISABLE_CHECKPOINT	0x02000000
>  
>  #define F2FS_OPTION(sbi)	((sbi)->mount_opt)
>  #define clear_opt(sbi, option)	(F2FS_OPTION(sbi).opt &= ~F2FS_MOUNT_##option)
> @@ -175,6 +176,7 @@ enum {
>  #define	CP_RECOVERY	0x00000008
>  #define	CP_DISCARD	0x00000010
>  #define CP_TRIMMED	0x00000020
> +#define CP_PAUSE	0x00000040
>  
>  #define MAX_DISCARD_BLOCKS(sbi)		BLKS_PER_SEC(sbi)
>  #define DEF_MAX_DISCARD_REQUEST		8	/* issue 8 discards per round */
> @@ -1067,6 +1069,7 @@ enum {
>  	SBI_NEED_SB_WRITE,			/* need to recover superblock */
>  	SBI_NEED_CP,				/* need to checkpoint */
>  	SBI_IS_SHUTDOWN,			/* shutdown by ioctl */
> +	SBI_CP_DISABLED,			/* CP was disabled last mount */
>  };
>  
>  enum {
> @@ -1192,6 +1195,12 @@ struct f2fs_sb_info {
>  	block_t reserved_blocks;		/* configurable reserved blocks */
>  	block_t current_reserved_blocks;	/* current reserved blocks */
>  
> +	/* Additional tracking for no checkpoint mode */
> +	block_t unusable_block_count;		/* # of blocks saved by last cp */
> +	block_t free_ssr_data_block;
> +	block_t free_ssr_node_block;
> +	block_t free_segments;
> +
>  	unsigned int nquota_files;		/* # of quota sysfile */
>  
>  	u32 s_next_generation;			/* for NFS support */
> @@ -1643,7 +1652,7 @@ static inline void f2fs_i_blocks_write(struct inode *, block_t, bool, bool);
>  static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
>  				 struct inode *inode, blkcnt_t *count)
>  {
> -	blkcnt_t diff = 0, release = 0;
> +	blkcnt_t diff = 0, release = 0, seg_diff = 0, seg_rel = 0;
>  	block_t avail_user_block_count;
>  	int ret;
>  
> @@ -1671,6 +1680,8 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
>  
>  	if (!__allow_reserved_blocks(sbi, inode, true))
>  		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
> +	if (test_opt(sbi, DISABLE_CHECKPOINT))
> +		avail_user_block_count -= sbi->unusable_block_count;
>  
>  	if (unlikely(sbi->total_valid_block_count > avail_user_block_count)) {
>  		diff = sbi->total_valid_block_count - avail_user_block_count;
> @@ -1681,18 +1692,51 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
>  		sbi->total_valid_block_count -= diff;
>  		if (!*count) {
>  			spin_unlock(&sbi->stat_lock);
> -			percpu_counter_sub(&sbi->alloc_valid_block_count, diff);

Please rebase on top of another fix for this.

>  			goto enospc;
>  		}
>  	}

	if (likely(!test_opt(sbi, DISABLE_CHECKPOINT)))
		goto normal;

> +	if (test_opt(sbi, DISABLE_CHECKPOINT)) {
> +		if (unlikely(*count > sbi->free_ssr_data_block)) {
> +			/* We'll need to pull from free. */
> +			blkcnt_t needed = *count - sbi->free_ssr_data_block;
> +			blkcnt_t new_segs = ((needed - 1) >>
> +						sbi->log_blocks_per_seg) + 1;
> +
> +			/* Check if we have enough free */
> +			if (unlikely(new_segs > sbi->free_segments)) {
> +				seg_diff = new_segs - sbi->free_segments;
> +
> +				seg_rel = ((needed - 1) %
> +						sbi->log_blocks_per_seg) + 1;
> +				seg_rel += (seg_diff - 1) <<
> +							sbi->log_blocks_per_seg;
> +				new_segs -= seg_diff;
> +				*count -= seg_rel;
> +				release += seg_rel;
> +				if (!*count) {
> +					spin_unlock(&sbi->stat_lock);
> +					goto enospc;
> +				}
> +			}
> +
> +			sbi->free_segments -= new_segs;
> +			sbi->free_ssr_data_block += new_segs <<
> +							sbi->log_blocks_per_seg;
> +
> +		}
> +		sbi->free_ssr_data_block -= *count;
> +	}

normal:

>  	spin_unlock(&sbi->stat_lock);
>  
> -	if (unlikely(release))
> +	if (unlikely(release)) {
> +		percpu_counter_sub(&sbi->alloc_valid_block_count, release);
>  		dquot_release_reservation_block(inode, release);
> +	}
>  	f2fs_i_blocks_write(inode, *count, true, true);
>  	return 0;
>  
>  enospc:
> +	percpu_counter_sub(&sbi->alloc_valid_block_count, release);
>  	dquot_release_reservation_block(inode, release);
>  	return -ENOSPC;
>  }
> @@ -1878,6 +1922,8 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
>  
>  	if (!__allow_reserved_blocks(sbi, inode, false))
>  		valid_block_count += F2FS_OPTION(sbi).root_reserved_blocks;
> +	if (test_opt(sbi, DISABLE_CHECKPOINT))
> +		valid_block_count += sbi->unusable_block_count;
>  
>  	if (unlikely(valid_block_count > sbi->user_block_count)) {
>  		spin_unlock(&sbi->stat_lock);
> @@ -1890,6 +1936,17 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
>  		goto enospc;
>  	}
>  
> +	if (test_opt(sbi, DISABLE_CHECKPOINT)) {
> +		if (unlikely(!sbi->free_ssr_node_block)) {
> +			if (unlikely(!sbi->free_segments)) {
> +				spin_unlock(&sbi->stat_lock);
> +				goto enospc;
> +			}
> +			sbi->free_segments--;
> +		}
> +		sbi->free_ssr_node_block--;
> +	}
> +
>  	sbi->total_valid_node_count++;
>  	sbi->total_valid_block_count++;
>  	spin_unlock(&sbi->stat_lock);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 8af6683e022be..1f9a8119e17da 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -150,6 +150,9 @@ static inline enum cp_reason_type need_do_checkpoint(struct inode *inode)
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	enum cp_reason_type cp_reason = CP_NO_NEEDED;
>  
> +	if (test_opt(sbi, DISABLE_CHECKPOINT))
> +		return CP_NO_NEEDED;
> +
>  	if (!S_ISREG(inode->i_mode))
>  		cp_reason = CP_NON_REGULAR;
>  	else if (inode->i_nlink != 1)
> @@ -2046,6 +2049,9 @@ static int f2fs_ioc_gc(struct file *filp, unsigned long arg)
>  	if (f2fs_readonly(sbi->sb))
>  		return -EROFS;
>  
> +	if (test_opt(sbi, DISABLE_CHECKPOINT))
> +		return -EINVAL;
> +
>  	ret = mnt_want_write_file(filp);
>  	if (ret)
>  		return ret;
> @@ -2088,6 +2094,9 @@ static int f2fs_ioc_gc_range(struct file *filp, unsigned long arg)
>  		return -EINVAL;
>  	}
>  
> +	if (test_opt(sbi, DISABLE_CHECKPOINT))
> +		return -EINVAL;
> +
>  	ret = mnt_want_write_file(filp);
>  	if (ret)
>  		return ret;
> @@ -2123,6 +2132,12 @@ static int f2fs_ioc_f2fs_write_checkpoint(struct file *filp, unsigned long arg)
>  	if (f2fs_readonly(sbi->sb))
>  		return -EROFS;
>  
> +	if (test_opt(sbi, DISABLE_CHECKPOINT)) {
> +		f2fs_msg(sbi->sb, KERN_INFO,
> +			"Skipping Checkpoint. Checkpoints currently disabled.");
> +		return -EINVAL;
> +	}
> +
>  	ret = mnt_want_write_file(filp);
>  	if (ret)
>  		return ret;
> @@ -2489,6 +2504,9 @@ static int f2fs_ioc_flush_device(struct file *filp, unsigned long arg)
>  	if (f2fs_readonly(sbi->sb))
>  		return -EROFS;
>  
> +	if (test_opt(sbi, DISABLE_CHECKPOINT))
> +		return -EINVAL;
> +
>  	if (copy_from_user(&range, (struct f2fs_flush_device __user *)arg,
>  							sizeof(range)))
>  		return -EFAULT;
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 9093be6e7a7db..4100dced6c309 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -60,6 +60,9 @@ static int gc_thread_func(void *data)
>  		}
>  #endif
>  
> +		if (test_opt(sbi, DISABLE_CHECKPOINT))
> +			goto do_balance;
> +
>  		if (!sb_start_write_trylock(sbi->sb))
>  			continue;
>  
> @@ -105,6 +108,7 @@ static int gc_thread_func(void *data)
>  		trace_f2fs_background_gc(sbi->sb, wait_ms,
>  				prefree_segments(sbi), free_segments(sbi));
>  
> +do_balance:
>  		/* balancing f2fs's metadata periodically */
>  		f2fs_balance_fs_bg(sbi);
>  next:
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 9efce174c51a9..608bf53d81f54 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -179,6 +179,10 @@ bool f2fs_need_SSR(struct f2fs_sb_info *sbi)
>  		return false;
>  	if (sbi->gc_mode == GC_URGENT)
>  		return true;
> +	if (test_opt(sbi, DISABLE_CHECKPOINT))
> +		return true;
> +	if (sbi->gc_thread && sbi->gc_thread->gc_urgent)
> +		return true;
>  
>  	return free_sections(sbi) <= (node_secs + 2 * dent_secs + imeta_secs +
>  			SM_I(sbi)->min_ssr_sections + reserved_sections(sbi));
> @@ -479,7 +483,8 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
>  	 * We should do GC or end up with checkpoint, if there are so many dirty
>  	 * dir/node pages without enough free segments.
>  	 */
> -	if (has_not_enough_free_secs(sbi, 0, 0)) {
> +	if (has_not_enough_free_secs(sbi, 0, 0) &&
> +			!test_opt(sbi, DISABLE_CHECKPOINT)) {
>  		mutex_lock(&sbi->gc_mutex);
>  		f2fs_gc(sbi, false, false, NULL_SEGNO);
>  	}
> @@ -519,8 +524,10 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
>  			f2fs_sync_dirty_inodes(sbi, FILE_INODE);
>  			blk_finish_plug(&plug);
>  		}
> -		f2fs_sync_fs(sbi->sb, true);
> -		stat_inc_bg_cp_count(sbi->stat_info);
> +		if (!test_opt(sbi, DISABLE_CHECKPOINT)) {
> +			f2fs_sync_fs(sbi->sb, true);
> +			stat_inc_bg_cp_count(sbi->stat_info);
> +		}
>  	}
>  }
>  
> @@ -735,52 +742,6 @@ int f2fs_flush_device_cache(struct f2fs_sb_info *sbi)
>  	return ret;
>  }
>  
> -static void __locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
> -		enum dirty_type dirty_type)
> -{
> -	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
> -
> -	/* need not be added */
> -	if (IS_CURSEG(sbi, segno))
> -		return;
> -
> -	if (!test_and_set_bit(segno, dirty_i->dirty_segmap[dirty_type]))
> -		dirty_i->nr_dirty[dirty_type]++;
> -
> -	if (dirty_type == DIRTY) {
> -		struct seg_entry *sentry = get_seg_entry(sbi, segno);
> -		enum dirty_type t = sentry->type;
> -
> -		if (unlikely(t >= DIRTY)) {
> -			f2fs_bug_on(sbi, 1);
> -			return;
> -		}
> -		if (!test_and_set_bit(segno, dirty_i->dirty_segmap[t]))
> -			dirty_i->nr_dirty[t]++;
> -	}
> -}
> -
> -static void __remove_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
> -		enum dirty_type dirty_type)
> -{
> -	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
> -
> -	if (test_and_clear_bit(segno, dirty_i->dirty_segmap[dirty_type]))
> -		dirty_i->nr_dirty[dirty_type]--;
> -
> -	if (dirty_type == DIRTY) {
> -		struct seg_entry *sentry = get_seg_entry(sbi, segno);
> -		enum dirty_type t = sentry->type;
> -
> -		if (test_and_clear_bit(segno, dirty_i->dirty_segmap[t]))
> -			dirty_i->nr_dirty[t]--;
> -
> -		if (get_valid_blocks(sbi, segno, true) == 0)
> -			clear_bit(GET_SEC_FROM_SEG(sbi, segno),
> -						dirty_i->victim_secmap);
> -	}
> -}
> -

Can we keep the above functions, since it's a bit hard to review the code.

Let me take a look at the change with more time.

Thanks,

>  /*
>   * Should not occur error such as -ENOMEM.
>   * Adding dirty entry into seglist is not critical operation.
> @@ -789,7 +750,7 @@ static void __remove_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
>  static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
>  {
>  	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
> -	unsigned short valid_blocks;
> +	unsigned short valid_blocks, ckpt_valid_blocks;
>  
>  	if (segno == NULL_SEGNO || IS_CURSEG(sbi, segno))
>  		return;
> @@ -797,8 +758,10 @@ static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
>  	mutex_lock(&dirty_i->seglist_lock);
>  
>  	valid_blocks = get_valid_blocks(sbi, segno, false);
> +	ckpt_valid_blocks = get_ckpt_valid_blocks(sbi, segno);
>  
> -	if (valid_blocks == 0) {
> +	if (valid_blocks == 0 && (ckpt_valid_blocks == sbi->blocks_per_seg ||
> +					!test_opt(sbi, DISABLE_CHECKPOINT))) {
>  		__locate_dirty_segment(sbi, segno, PRE);
>  		__remove_dirty_segment(sbi, segno, DIRTY);
>  	} else if (valid_blocks < sbi->blocks_per_seg) {
> @@ -1852,7 +1815,8 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
>  			sbi->discard_blks--;
>  
>  		/* don't overwrite by SSR to keep node chain */
> -		if (IS_NODESEG(se->type)) {
> +		if (IS_NODESEG(se->type) &&
> +				!test_opt(sbi, DISABLE_CHECKPOINT)) {
>  			if (!f2fs_test_and_set_bit(offset, se->ckpt_valid_map))
>  				se->ckpt_valid_blocks++;
>  		}
> @@ -1874,6 +1838,25 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
>  			f2fs_bug_on(sbi, 1);
>  			se->valid_blocks++;
>  			del = 0;
> +		} else {
> +			/* If checkpoints are off, we must not reuse data that
> +			 * was used in the previous checkpoint. If it was used
> +			 * before, we must track that to know how much space we
> +			 * really have
> +			 */
> +			if (f2fs_test_bit(offset, se->ckpt_valid_map)) {
> +				spin_lock(&sbi->stat_lock);
> +				sbi->unusable_block_count++;
> +				spin_unlock(&sbi->stat_lock);
> +			} else {
> +				spin_lock(&sbi->stat_lock);
> +				if (IS_DATASEG(se->type))
> +					sbi->free_ssr_data_block++;
> +				else
> +					sbi->free_ssr_node_block++;
> +				spin_unlock(&sbi->stat_lock);
> +			}
> +
>  		}
>  
>  		if (f2fs_discard_en(sbi) &&
> @@ -2163,7 +2146,8 @@ static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
>  		return SIT_I(sbi)->last_victim[ALLOC_NEXT];
>  
>  	/* find segments from 0 to reuse freed segments */
> -	if (F2FS_OPTION(sbi).alloc_mode == ALLOC_MODE_REUSE)
> +	if (F2FS_OPTION(sbi).alloc_mode == ALLOC_MODE_REUSE
> +			|| test_opt(sbi, DISABLE_CHECKPOINT))
>  		return 0;
>  
>  	return CURSEG_I(sbi, type)->segno;
> @@ -2315,7 +2299,8 @@ static void allocate_segment_by_default(struct f2fs_sb_info *sbi,
>  	else if (!is_set_ckpt_flags(sbi, CP_CRC_RECOVERY_FLAG) &&
>  					type == CURSEG_WARM_NODE)
>  		new_curseg(sbi, type, false);
> -	else if (curseg->alloc_type == LFS && is_next_segment_free(sbi, type))
> +	else if (curseg->alloc_type == LFS && is_next_segment_free(sbi, type) &&
> +			!test_opt(sbi, DISABLE_CHECKPOINT))
>  		new_curseg(sbi, type, false);
>  	else if (f2fs_need_SSR(sbi) && get_ssr_segment(sbi, type))
>  		change_curseg(sbi, type);
> @@ -3476,6 +3461,9 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  			sit_i->dirty_sentries--;
>  			ses->entry_cnt--;
>  		}
> +		spin_lock(&sbi->stat_lock);
> +		sbi->unusable_block_count = 0;
> +		spin_unlock(&sbi->stat_lock);
>  
>  		if (to_journal)
>  			up_write(&curseg->journal_rwsem);
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index f18fc82fbe998..9789cadc16569 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -342,6 +342,12 @@ static inline unsigned int get_valid_blocks(struct f2fs_sb_info *sbi,
>  		return get_seg_entry(sbi, segno)->valid_blocks;
>  }
>  
> +static inline unsigned int get_ckpt_valid_blocks(struct f2fs_sb_info *sbi,
> +				unsigned int segno)
> +{
> +	return get_seg_entry(sbi, segno)->ckpt_valid_blocks;
> +}
> +
>  static inline void seg_info_from_raw_sit(struct seg_entry *se,
>  					struct f2fs_sit_entry *rs)
>  {
> @@ -521,6 +527,66 @@ static inline unsigned int dirty_segments(struct f2fs_sb_info *sbi)
>  		DIRTY_I(sbi)->nr_dirty[DIRTY_COLD_NODE];
>  }
>  
> +static inline void __locate_dirty_segment(struct f2fs_sb_info *sbi,
> +		unsigned int segno, enum dirty_type dirty_type)
> +{
> +	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
> +
> +	/* need not be added */
> +	if (IS_CURSEG(sbi, segno))
> +		return;
> +
> +	if (!test_and_set_bit(segno, dirty_i->dirty_segmap[dirty_type]))
> +		dirty_i->nr_dirty[dirty_type]++;
> +
> +	if (dirty_type == DIRTY) {
> +		struct seg_entry *sentry = get_seg_entry(sbi, segno);
> +		enum dirty_type t = sentry->type;
> +
> +		if (unlikely(t >= DIRTY)) {
> +			f2fs_bug_on(sbi, 1);
> +			return;
> +		}
> +		if (!test_and_set_bit(segno, dirty_i->dirty_segmap[t]))
> +			dirty_i->nr_dirty[t]++;
> +	}
> +}
> +
> +static inline void __remove_dirty_segment(struct f2fs_sb_info *sbi,
> +		unsigned int segno, enum dirty_type dirty_type)
> +{
> +	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
> +
> +	if (test_and_clear_bit(segno, dirty_i->dirty_segmap[dirty_type]))
> +		dirty_i->nr_dirty[dirty_type]--;
> +
> +	if (dirty_type == DIRTY) {
> +		struct seg_entry *sentry = get_seg_entry(sbi, segno);
> +		enum dirty_type t = sentry->type;
> +
> +		if (test_and_clear_bit(segno, dirty_i->dirty_segmap[t]))
> +			dirty_i->nr_dirty[t]--;
> +
> +		if (get_valid_blocks(sbi, segno, true) == 0)
> +			clear_bit(GET_SEC_FROM_SEG(sbi, segno),
> +						dirty_i->victim_secmap);
> +	}
> +}
> +
> +/* This moves currently empty dirty blocks to prefree. Must hold seglist_lock */
> +static inline void dirty_to_prefree(struct f2fs_sb_info *sbi)
> +{
> +	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
> +	unsigned int segno;
> +
> +	for_each_set_bit(segno, dirty_i->dirty_segmap[DIRTY], MAIN_SEGS(sbi)) {
> +		if (!get_valid_blocks(sbi, segno, false)) {
> +			__locate_dirty_segment(sbi, segno, PRE);
> +			__remove_dirty_segment(sbi, segno, DIRTY);
> +		}
> +	}
> +}
> +
>  static inline int overprovision_segments(struct f2fs_sb_info *sbi)
>  {
>  	return SM_I(sbi)->ovp_segments;
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 1cb5d1e4fcfd2..78b46f1b9000e 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -132,6 +132,7 @@ enum {
>  	Opt_alloc,
>  	Opt_fsync,
>  	Opt_test_dummy_encryption,
> +	Opt_checkpoint,
>  	Opt_err,
>  };
>  
> @@ -189,6 +190,7 @@ static match_table_t f2fs_tokens = {
>  	{Opt_alloc, "alloc_mode=%s"},
>  	{Opt_fsync, "fsync_mode=%s"},
>  	{Opt_test_dummy_encryption, "test_dummy_encryption"},
> +	{Opt_checkpoint, "checkpoint=%s"},
>  	{Opt_err, NULL},
>  };
>  
> @@ -764,6 +766,23 @@ static int parse_options(struct super_block *sb, char *options)
>  					"Test dummy encryption mount option ignored");
>  #endif
>  			break;
> +		case Opt_checkpoint:
> +			name = match_strdup(&args[0]);
> +			if (!name)
> +				return -ENOMEM;
> +
> +			if (strlen(name) == 6 &&
> +					!strncmp(name, "enable", 6)) {
> +				clear_opt(sbi, DISABLE_CHECKPOINT);
> +			} else if (strlen(name) == 7 &&
> +					!strncmp(name, "disable", 7)) {
> +				set_opt(sbi, DISABLE_CHECKPOINT);
> +			} else {
> +				kfree(name);
> +				return -EINVAL;
> +			}
> +			kfree(name);
> +			break;
>  		default:
>  			f2fs_msg(sb, KERN_ERR,
>  				"Unrecognized mount option \"%s\" or missing value",
> @@ -809,6 +828,11 @@ static int parse_options(struct super_block *sb, char *options)
>  		}
>  	}
>  
> +	if (test_opt(sbi, DISABLE_CHECKPOINT) && test_opt(sbi, LFS)) {
> +		f2fs_msg(sb, KERN_ERR,
> +				"LFS not compatible with checkpoint=disable\n");
> +	}
> +
>  	/* Not pass down write hints if the number of active logs is lesser
>  	 * than NR_CURSEG_TYPE.
>  	 */
> @@ -996,8 +1020,9 @@ static void f2fs_put_super(struct super_block *sb)
>  	 * But, the previous checkpoint was not done by umount, it needs to do
>  	 * clean checkpoint again.
>  	 */
> -	if (is_sbi_flag_set(sbi, SBI_IS_DIRTY) ||
> -			!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
> +	if ((is_sbi_flag_set(sbi, SBI_IS_DIRTY) ||
> +			!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) &&
> +			!test_opt(sbi, DISABLE_CHECKPOINT)) {
>  		struct cp_control cpc = {
>  			.reason = CP_UMOUNT,
>  		};
> @@ -1007,7 +1032,8 @@ static void f2fs_put_super(struct super_block *sb)
>  	/* be sure to wait for any on-going discard commands */
>  	dropped = f2fs_wait_discard_bios(sbi);
>  
> -	if (f2fs_discard_en(sbi) && !sbi->discard_blks && !dropped) {
> +	if (f2fs_discard_en(sbi) && !sbi->discard_blks && !dropped &&
> +			!test_opt(sbi, DISABLE_CHECKPOINT)) {
>  		struct cp_control cpc = {
>  			.reason = CP_UMOUNT | CP_TRIMMED,
>  		};
> @@ -1064,6 +1090,8 @@ int f2fs_sync_fs(struct super_block *sb, int sync)
>  
>  	if (unlikely(f2fs_cp_error(sbi)))
>  		return 0;
> +	if (test_opt(sbi, DISABLE_CHECKPOINT))
> +		return 0;
>  
>  	trace_f2fs_sync_fs(sb, sync);
>  
> @@ -1162,7 +1190,8 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  
>  	buf->f_blocks = total_count - start_count;
>  	buf->f_bfree = user_block_count - valid_user_blocks(sbi) -
> -						sbi->current_reserved_blocks;
> +						sbi->current_reserved_blocks -
> +						sbi->unusable_block_count;
>  	if (buf->f_bfree > F2FS_OPTION(sbi).root_reserved_blocks)
>  		buf->f_bavail = buf->f_bfree -
>  				F2FS_OPTION(sbi).root_reserved_blocks;
> @@ -1338,6 +1367,9 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>  	else if (F2FS_OPTION(sbi).alloc_mode == ALLOC_MODE_REUSE)
>  		seq_printf(seq, ",alloc_mode=%s", "reuse");
>  
> +	if (test_opt(sbi, DISABLE_CHECKPOINT))
> +		seq_puts(seq, ",checkpoint=disable");
> +
>  	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_POSIX)
>  		seq_printf(seq, ",fsync_mode=%s", "posix");
>  	else if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
> @@ -1362,6 +1394,7 @@ static void default_options(struct f2fs_sb_info *sbi)
>  	set_opt(sbi, INLINE_DENTRY);
>  	set_opt(sbi, EXTENT_CACHE);
>  	set_opt(sbi, NOHEAP);
> +	clear_opt(sbi, DISABLE_CHECKPOINT);
>  	sbi->sb->s_flags |= SB_LAZYTIME;
>  	set_opt(sbi, FLUSH_MERGE);
>  	if (f2fs_sb_has_blkzoned(sbi->sb)) {
> @@ -1384,6 +1417,60 @@ static void default_options(struct f2fs_sb_info *sbi)
>  #ifdef CONFIG_QUOTA
>  static int f2fs_enable_quotas(struct super_block *sb);
>  #endif
> +
> +static void f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
> +{
> +	struct cp_control cpc;
> +	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
> +	unsigned int segno;
> +	int type;
> +
> +	set_sbi_flag(sbi, SBI_CP_DISABLED);
> +
> +	cpc.reason = CP_PAUSE;
> +
> +	mutex_lock(&sbi->gc_mutex);
> +	write_checkpoint(sbi, &cpc);
> +	mutex_unlock(&sbi->gc_mutex);
> +
> +	mutex_lock(&dirty_i->seglist_lock);
> +	for (type = 0; type < NR_CURSEG_TYPE; type++) {
> +		for_each_set_bit(segno, dirty_i->dirty_segmap[type],
> +							MAIN_SEGS(sbi)) {
> +			if (IS_DATASEG(type))
> +				sbi->free_ssr_data_block +=
> +					get_valid_blocks(sbi, segno, false);
> +			else
> +				sbi->free_ssr_node_block +=
> +					get_valid_blocks(sbi, segno, false);
> +		}
> +	}
> +	sbi->free_segments = FREE_I(sbi)->free_segments;
> +	mutex_unlock(&dirty_i->seglist_lock);
> +}
> +
> +static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
> +{
> +	struct super_block *sb = sbi->sb;
> +	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
> +
> +	clear_sbi_flag(sbi, SBI_CP_DISABLED);
> +	writeback_inodes_sb(sb, WB_REASON_SYNC);
> +	sync_inodes_sb(sb);
> +
> +	mutex_lock(&dirty_i->seglist_lock);
> +	dirty_to_prefree(sbi);
> +	sbi->free_segments = 0;
> +	sbi->free_ssr_data_block = 0;
> +	sbi->free_ssr_node_block = 0;
> +	mutex_unlock(&dirty_i->seglist_lock);
> +
> +	set_sbi_flag(sbi, SBI_IS_DIRTY);
> +	set_sbi_flag(sbi, SBI_IS_CLOSE);
> +	f2fs_sync_fs(sb, 1);
> +	clear_sbi_flag(sbi, SBI_IS_CLOSE);
> +}
> +
>  static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> @@ -1393,6 +1480,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>  	bool need_restart_gc = false;
>  	bool need_stop_gc = false;
>  	bool no_extent_cache = !test_opt(sbi, EXTENT_CACHE);
> +	bool disable_checkpoint = test_opt(sbi, DISABLE_CHECKPOINT);
> +	bool checkpoint_changed;
>  #ifdef CONFIG_QUOTA
>  	int i, j;
>  #endif
> @@ -1437,6 +1526,8 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>  	err = parse_options(sb, data);
>  	if (err)
>  		goto restore_opts;
> +	checkpoint_changed =
> +			disable_checkpoint != test_opt(sbi, DISABLE_CHECKPOINT);
>  
>  	/*
>  	 * Previous and new state of filesystem is RO,
> @@ -1498,6 +1589,13 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>  		clear_sbi_flag(sbi, SBI_IS_CLOSE);
>  	}
>  
> +	if (checkpoint_changed) {
> +		if (test_opt(sbi, DISABLE_CHECKPOINT))
> +			f2fs_disable_checkpoint(sbi);
> +		else
> +			f2fs_enable_checkpoint(sbi);
> +	}
> +
>  	/*
>  	 * We stop issue flush thread if FS is mounted as RO
>  	 * or if flush_merge is not passed in mount option.
> @@ -2944,7 +3042,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  		goto free_meta;
>  
>  	/* recover fsynced data */
> -	if (!test_opt(sbi, DISABLE_ROLL_FORWARD)) {
> +	if (!test_opt(sbi, DISABLE_ROLL_FORWARD) &&
> +			!is_sbi_flag_set(sbi, SBI_CP_DISABLED)) {
>  		/*
>  		 * mount should be failed, when device has readonly mode, and
>  		 * previous checkpoint was not done by clean system shutdown.
> @@ -3010,6 +3109,12 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  				cur_cp_version(F2FS_CKPT(sbi)));
>  	f2fs_update_time(sbi, CP_TIME);
>  	f2fs_update_time(sbi, REQ_TIME);
> +
> +	if (test_opt(sbi, DISABLE_CHECKPOINT))
> +		f2fs_disable_checkpoint(sbi);
> +	else if (is_sbi_flag_set(sbi, SBI_CP_DISABLED))
> +		f2fs_enable_checkpoint(sbi);
> +
>  	return 0;
>  
>  free_meta:
> -- 
> 2.18.0.203.gfac676dfb9-goog
