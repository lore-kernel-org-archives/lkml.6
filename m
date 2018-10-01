Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C00C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 01:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9676020840
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 01:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bG4geolH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9676020840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbeJAIPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 04:15:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbeJAIPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 04:15:23 -0400
Received: from [192.168.0.101] (unknown [121.237.253.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B5DC2083C;
        Mon,  1 Oct 2018 01:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538358001;
        bh=TsRgpONZedJH1q2I9WD2zLZASS8ZEhZQnOiSoD1obe0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bG4geolH+HZgcW7FU7dMbtRAKMbHEdRD8LmjZApFBZ5ODZGm2KQccQGdbewb/qYRH
         OWsbkyTE3Hl7wU0v3g4nbSgK0dAszLrrMaOumfqlZf0tj5IJa9BNsyu6l9viuK+/Ig
         v83aiRKEJaPRHn1d6DRayFlkkD4ipLhw83M/Usiw=
Subject: Re: [PATCH v11] f2fs: guarantee journalled quota data by checkpoint
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Weichao Guo <guoweichao@huawei.com>
References: <20180920120500.21026-1-chao@kernel.org>
 <20181001000618.GC17407@jaegeuk-macbookpro.roam.corp.google.com>
 <cd4d60b9-3f24-d408-610a-af57e0cb0165@kernel.org>
 <20181001012911.GF17407@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <73df627f-5b12-71cd-9a52-41f187d5516d@kernel.org>
Date:   Mon, 1 Oct 2018 09:39:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181001012911.GF17407@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-1 9:29, Jaegeuk Kim wrote:
> On 10/01, Chao Yu wrote:
>> Hi Jaegeuk,
>>
>> On 2018-10-1 8:06, Jaegeuk Kim wrote:
>>> Hi Chao,
>>>
>>> This fails on fsstress with godown without fault injection. Could you please
>>> test a bit? I assumed that this patch should give no fsck failure along with
>>> valid checkpoint having no flag.
>>
>> Okay, let me reproduce with that case.
>>
>>>
>>> BTW, I'm in doubt that f2fs_lock_all covers entire quota modification. What
>>> about prepare_write_begin() -> f2fs_get_block() ... -> inc_valid_block_count()?
>>
>> If quota data changed in above path, we will detect that in below condition:
>>
>> block_operation()
>>
>> 	down_write(&sbi->node_change);
>>
>> 	if (__need_flush_quota(sbi)) {
>> 		up_write(&sbi->node_change);
>> 		f2fs_unlock_all(sbi);
>> 		goto retry_flush_quotas;
>> 	}
>>
>> So there is no problem?
> 
> We may need to check quota is dirty, since we have no way to detect by
> f2fs structures?

Below condition can check that.

static bool __need_flush_quota(struct f2fs_sb_info *sbi)
{
...
	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_FLUSH))
		return true;
	if (get_pages(sbi, F2FS_DIRTY_QDATA))
		return true;
...
}

static int f2fs_dquot_mark_dquot_dirty(struct dquot *dquot)
{
...
	ret = dquot_mark_dquot_dirty(dquot);

	/* if we are using journalled quota */
	if (is_journalled_quota(sbi))
		set_sbi_flag(sbi, SBI_QUOTA_NEED_FLUSH);
...
}

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>> On 09/20, Chao Yu wrote:
>>>> From: Chao Yu <yuchao0@huawei.com>
>>>>
>>>> For journalled quota mode, let checkpoint to flush dquot dirty data
>>>> and quota file data to guarntee persistence of all quota sysfile in
>>>> last checkpoint, by this way, we can avoid corrupting quota sysfile
>>>> when encountering SPO.
>>>>
>>>> The implementation is as below:
>>>>
>>>> 1. add a global state SBI_QUOTA_NEED_FLUSH to indicate that there is
>>>> cached dquot metadata changes in quota subsystem, and later checkpoint
>>>> should:
>>>>  a) flush dquot metadata into quota file.
>>>>  b) flush quota file to storage to keep file usage be consistent.
>>>>
>>>> 2. add a global state SBI_QUOTA_NEED_REPAIR to indicate that quota
>>>> operation failed due to -EIO or -ENOSPC, so later,
>>>>  a) checkpoint will skip syncing dquot metadata.
>>>>  b) CP_QUOTA_NEED_FSCK_FLAG will be set in last cp pack to give a
>>>>     hint for fsck repairing.
>>>>
>>>> 3. add a global state SBI_QUOTA_SKIP_FLUSH, in checkpoint, if quota
>>>> data updating is very heavy, it may cause hungtask in block_operation().
>>>> To avoid this, if our retry time exceed threshold, let's just skip
>>>> flushing and retry in next checkpoint().
>>>>
>>>> Signed-off-by: Weichao Guo <guoweichao@huawei.com>
>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>> ---
>>>> v11:
>>>> - transfer quota data if fsynced inode's i_{u,g}id changed during
>>>> recovery.
>>>>  fs/f2fs/checkpoint.c    |  56 +++++++++++++++++--
>>>>  fs/f2fs/data.c          |  18 ++++--
>>>>  fs/f2fs/f2fs.h          |  50 ++++++++++++++---
>>>>  fs/f2fs/file.c          |  31 ++++++++---
>>>>  fs/f2fs/inline.c        |   4 +-
>>>>  fs/f2fs/inode.c         |  11 +++-
>>>>  fs/f2fs/namei.c         |   4 --
>>>>  fs/f2fs/recovery.c      |  43 +++++++++++++-
>>>>  fs/f2fs/super.c         | 120 ++++++++++++++++++++++++++++++++++++----
>>>>  include/linux/f2fs_fs.h |   1 +
>>>>  10 files changed, 289 insertions(+), 49 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>>> index d312d2829d5a..d624d7983197 100644
>>>> --- a/fs/f2fs/checkpoint.c
>>>> +++ b/fs/f2fs/checkpoint.c
>>>> @@ -1083,6 +1083,21 @@ static void __prepare_cp_block(struct f2fs_sb_info *sbi)
>>>>  	ckpt->next_free_nid = cpu_to_le32(last_nid);
>>>>  }
>>>>  
>>>> +static bool __need_flush_quota(struct f2fs_sb_info *sbi)
>>>> +{
>>>> +	if (!is_journalled_quota(sbi))
>>>> +		return false;
>>>> +	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
>>>> +		return false;
>>>> +	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR))
>>>> +		return false;
>>>> +	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_FLUSH))
>>>> +		return true;
>>>> +	if (get_pages(sbi, F2FS_DIRTY_QDATA))
>>>> +		return true;
>>>> +	return false;
>>>> +}
>>>> +
>>>>  /*
>>>>   * Freeze all the FS-operations for checkpoint.
>>>>   */
>>>> @@ -1094,12 +1109,30 @@ static int block_operations(struct f2fs_sb_info *sbi)
>>>>  		.for_reclaim = 0,
>>>>  	};
>>>>  	struct blk_plug plug;
>>>> -	int err = 0;
>>>> +	int err = 0, cnt = 0;
>>>>  
>>>>  	blk_start_plug(&plug);
>>>>  
>>>> -retry_flush_dents:
>>>> +retry_flush_quotas:
>>>> +	if (__need_flush_quota(sbi)) {
>>>> +		if (++cnt > DEFAULT_RETRY_QUOTA_FLUSH_COUNT) {
>>>> +			set_sbi_flag(sbi, SBI_QUOTA_SKIP_FLUSH);
>>>> +			f2fs_lock_all(sbi);
>>>> +			goto retry_flush_dents;
>>>> +		}
>>>> +		clear_sbi_flag(sbi, SBI_QUOTA_NEED_FLUSH);
>>>> +
>>>> +		f2fs_quota_sync(sbi->sb, -1);
>>>> +	}
>>>> +
>>>>  	f2fs_lock_all(sbi);
>>>> +	if (__need_flush_quota(sbi)) {
>>>> +		f2fs_unlock_all(sbi);
>>>> +		cond_resched();
>>>> +		goto retry_flush_quotas;
>>>> +	}
>>>> +
>>>> +retry_flush_dents:
>>>>  	/* write all the dirty dentry pages */
>>>>  	if (get_pages(sbi, F2FS_DIRTY_DENTS)) {
>>>>  		f2fs_unlock_all(sbi);
>>>> @@ -1107,7 +1140,7 @@ static int block_operations(struct f2fs_sb_info *sbi)
>>>>  		if (err)
>>>>  			goto out;
>>>>  		cond_resched();
>>>> -		goto retry_flush_dents;
>>>> +		goto retry_flush_quotas;
>>>>  	}
>>>>  
>>>>  	/*
>>>> @@ -1116,6 +1149,12 @@ static int block_operations(struct f2fs_sb_info *sbi)
>>>>  	 */
>>>>  	down_write(&sbi->node_change);
>>>>  
>>>> +	if (__need_flush_quota(sbi)) {
>>>> +		up_write(&sbi->node_change);
>>>> +		f2fs_unlock_all(sbi);
>>>> +		goto retry_flush_quotas;
>>>> +	}
>>>> +
>>>>  	if (get_pages(sbi, F2FS_DIRTY_IMETA)) {
>>>>  		up_write(&sbi->node_change);
>>>>  		f2fs_unlock_all(sbi);
>>>> @@ -1123,7 +1162,7 @@ static int block_operations(struct f2fs_sb_info *sbi)
>>>>  		if (err)
>>>>  			goto out;
>>>>  		cond_resched();
>>>> -		goto retry_flush_dents;
>>>> +		goto retry_flush_quotas;
>>>>  	}
>>>>  
>>>>  retry_flush_nodes:
>>>> @@ -1214,6 +1253,14 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>>  	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
>>>>  		__set_ckpt_flags(ckpt, CP_FSCK_FLAG);
>>>>  
>>>> +	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
>>>> +		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
>>>> +	else
>>>> +		__clear_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
>>>> +
>>>> +	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR))
>>>> +		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
>>>> +
>>>>  	/* set this flag to activate crc|cp_ver for recovery */
>>>>  	__set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG);
>>>>  	__clear_ckpt_flags(ckpt, CP_NOCRC_RECOVERY_FLAG);
>>>> @@ -1421,6 +1468,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>>  
>>>>  	clear_sbi_flag(sbi, SBI_IS_DIRTY);
>>>>  	clear_sbi_flag(sbi, SBI_NEED_CP);
>>>> +	clear_sbi_flag(sbi, SBI_QUOTA_SKIP_FLUSH);
>>>>  	__set_cp_next_pack(sbi);
>>>>  
>>>>  	/*
>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>> index 57c0823d22e0..b96f8588d565 100644
>>>> --- a/fs/f2fs/data.c
>>>> +++ b/fs/f2fs/data.c
>>>> @@ -46,7 +46,7 @@ static bool __is_cp_guaranteed(struct page *page)
>>>>  			inode->i_ino ==  F2FS_NODE_INO(sbi) ||
>>>>  			S_ISDIR(inode->i_mode) ||
>>>>  			(S_ISREG(inode->i_mode) &&
>>>> -			is_inode_flag_set(inode, FI_ATOMIC_FILE)) ||
>>>> +			(f2fs_is_atomic_file(inode) || IS_NOQUOTA(inode))) ||
>>>>  			is_cold_data(page))
>>>>  		return true;
>>>>  	return false;
>>>> @@ -975,7 +975,7 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
>>>>  	return err;
>>>>  }
>>>>  
>>>> -static inline void __do_map_lock(struct f2fs_sb_info *sbi, int flag, bool lock)
>>>> +void __do_map_lock(struct f2fs_sb_info *sbi, int flag, bool lock)
>>>>  {
>>>>  	if (flag == F2FS_GET_BLOCK_PRE_AIO) {
>>>>  		if (lock)
>>>> @@ -1716,6 +1716,8 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
>>>>  		return true;
>>>>  	if (S_ISDIR(inode->i_mode))
>>>>  		return true;
>>>> +	if (IS_NOQUOTA(inode))
>>>> +		return true;
>>>>  	if (f2fs_is_atomic_file(inode))
>>>>  		return true;
>>>>  	if (fio) {
>>>> @@ -1960,7 +1962,7 @@ static int __write_data_page(struct page *page, bool *submitted,
>>>>  	}
>>>>  
>>>>  	unlock_page(page);
>>>> -	if (!S_ISDIR(inode->i_mode))
>>>> +	if (!S_ISDIR(inode->i_mode) && !IS_NOQUOTA(inode))
>>>>  		f2fs_balance_fs(sbi, need_balance_fs);
>>>>  
>>>>  	if (unlikely(f2fs_cp_error(sbi))) {
>>>> @@ -2151,6 +2153,8 @@ static inline bool __should_serialize_io(struct inode *inode,
>>>>  {
>>>>  	if (!S_ISREG(inode->i_mode))
>>>>  		return false;
>>>> +	if (IS_NOQUOTA(inode))
>>>> +		return false;
>>>>  	if (wbc->sync_mode != WB_SYNC_ALL)
>>>>  		return true;
>>>>  	if (get_dirty_pages(inode) >= SM_I(F2FS_I_SB(inode))->min_seq_blocks)
>>>> @@ -2180,7 +2184,8 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
>>>>  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
>>>>  		goto skip_write;
>>>>  
>>>> -	if (S_ISDIR(inode->i_mode) && wbc->sync_mode == WB_SYNC_NONE &&
>>>> +	if ((S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode)) &&
>>>> +			wbc->sync_mode == WB_SYNC_NONE &&
>>>>  			get_dirty_pages(inode) < nr_pages_to_skip(sbi, DATA) &&
>>>>  			f2fs_available_free_memory(sbi, DIRTY_DENTS))
>>>>  		goto skip_write;
>>>> @@ -2245,7 +2250,7 @@ static void f2fs_write_failed(struct address_space *mapping, loff_t to)
>>>>  		down_write(&F2FS_I(inode)->i_mmap_sem);
>>>>  
>>>>  		truncate_pagecache(inode, i_size);
>>>> -		f2fs_truncate_blocks(inode, i_size, true);
>>>> +		f2fs_truncate_blocks(inode, i_size, true, true);
>>>>  
>>>>  		up_write(&F2FS_I(inode)->i_mmap_sem);
>>>>  		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>>>> @@ -2380,7 +2385,8 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
>>>>  	if (err)
>>>>  		goto fail;
>>>>  
>>>> -	if (need_balance && has_not_enough_free_secs(sbi, 0, 0)) {
>>>> +	if (need_balance && !IS_NOQUOTA(inode) &&
>>>> +			has_not_enough_free_secs(sbi, 0, 0)) {
>>>>  		unlock_page(page);
>>>>  		f2fs_balance_fs(sbi, true);
>>>>  		lock_page(page);
>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>> index 917b2ca76aac..b5e400be73e0 100644
>>>> --- a/fs/f2fs/f2fs.h
>>>> +++ b/fs/f2fs/f2fs.h
>>>> @@ -525,6 +525,9 @@ enum {
>>>>  
>>>>  #define DEFAULT_RETRY_IO_COUNT	8	/* maximum retry read IO count */
>>>>  
>>>> +/* maximum retry quota flush count */
>>>> +#define DEFAULT_RETRY_QUOTA_FLUSH_COUNT		8
>>>> +
>>>>  #define F2FS_LINK_MAX	0xffffffff	/* maximum link count per file */
>>>>  
>>>>  #define MAX_DIR_RA_PAGES	4	/* maximum ra pages of dir */
>>>> @@ -1088,6 +1091,9 @@ enum {
>>>>  	SBI_NEED_CP,				/* need to checkpoint */
>>>>  	SBI_IS_SHUTDOWN,			/* shutdown by ioctl */
>>>>  	SBI_IS_RECOVERED,			/* recovered orphan/data */
>>>> +	SBI_QUOTA_NEED_FLUSH,			/* need to flush quota info in CP */
>>>> +	SBI_QUOTA_SKIP_FLUSH,			/* skip flushing quota in current CP */
>>>> +	SBI_QUOTA_NEED_REPAIR,			/* quota file may be corrupted */
>>>>  };
>>>>  
>>>>  enum {
>>>> @@ -1891,12 +1897,18 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
>>>>  {
>>>>  	block_t	valid_block_count;
>>>>  	unsigned int valid_node_count;
>>>> -	bool quota = inode && !is_inode;
>>>> +	int err;
>>>>  
>>>> -	if (quota) {
>>>> -		int ret = dquot_reserve_block(inode, 1);
>>>> -		if (ret)
>>>> -			return ret;
>>>> +	if (is_inode) {
>>>> +		if (inode) {
>>>> +			err = dquot_alloc_inode(inode);
>>>> +			if (err)
>>>> +				return err;
>>>> +		}
>>>> +	} else {
>>>> +		err = dquot_reserve_block(inode, 1);
>>>> +		if (err)
>>>> +			return err;
>>>>  	}
>>>>  
>>>>  	if (time_to_inject(sbi, FAULT_BLOCK)) {
>>>> @@ -1938,8 +1950,12 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
>>>>  	return 0;
>>>>  
>>>>  enospc:
>>>> -	if (quota)
>>>> +	if (is_inode) {
>>>> +		if (inode)
>>>> +			dquot_free_inode(inode);
>>>> +	} else {
>>>>  		dquot_release_reservation_block(inode, 1);
>>>> +	}
>>>>  	return -ENOSPC;
>>>>  }
>>>>  
>>>> @@ -1960,7 +1976,9 @@ static inline void dec_valid_node_count(struct f2fs_sb_info *sbi,
>>>>  
>>>>  	spin_unlock(&sbi->stat_lock);
>>>>  
>>>> -	if (!is_inode)
>>>> +	if (is_inode)
>>>> +		dquot_free_inode(inode);
>>>> +	else
>>>>  		f2fs_i_blocks_write(inode, 1, false, true);
>>>>  }
>>>>  
>>>> @@ -2739,7 +2757,8 @@ static inline bool is_valid_data_blkaddr(struct f2fs_sb_info *sbi,
>>>>   */
>>>>  int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync);
>>>>  void f2fs_truncate_data_blocks(struct dnode_of_data *dn);
>>>> -int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock);
>>>> +int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock,
>>>> +							bool buf_write);
>>>>  int f2fs_truncate(struct inode *inode);
>>>>  int f2fs_getattr(const struct path *path, struct kstat *stat,
>>>>  			u32 request_mask, unsigned int flags);
>>>> @@ -2827,6 +2846,7 @@ static inline int f2fs_add_link(struct dentry *dentry, struct inode *inode)
>>>>  int f2fs_inode_dirtied(struct inode *inode, bool sync);
>>>>  void f2fs_inode_synced(struct inode *inode);
>>>>  int f2fs_enable_quota_files(struct f2fs_sb_info *sbi, bool rdonly);
>>>> +int f2fs_quota_sync(struct super_block *sb, int type);
>>>>  void f2fs_quota_off_umount(struct super_block *sb);
>>>>  int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover);
>>>>  int f2fs_sync_fs(struct super_block *sb, int sync);
>>>> @@ -3025,6 +3045,7 @@ struct page *f2fs_get_lock_data_page(struct inode *inode, pgoff_t index,
>>>>  struct page *f2fs_get_new_data_page(struct inode *inode,
>>>>  			struct page *ipage, pgoff_t index, bool new_i_size);
>>>>  int f2fs_do_write_data_page(struct f2fs_io_info *fio);
>>>> +void __do_map_lock(struct f2fs_sb_info *sbi, int flag, bool lock);
>>>>  int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>>>>  			int create, int flag);
>>>>  int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>>>> @@ -3456,3 +3477,16 @@ extern void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate,
>>>>  #endif
>>>>  
>>>>  #endif
>>>> +
>>>> +static inline bool is_journalled_quota(struct f2fs_sb_info *sbi)
>>>> +{
>>>> +#ifdef CONFIG_QUOTA
>>>> +	if (f2fs_sb_has_quota_ino(sbi->sb))
>>>> +		return true;
>>>> +	if (F2FS_OPTION(sbi).s_qf_names[USRQUOTA] ||
>>>> +		F2FS_OPTION(sbi).s_qf_names[GRPQUOTA] ||
>>>> +		F2FS_OPTION(sbi).s_qf_names[PRJQUOTA])
>>>> +		return true;
>>>> +#endif
>>>> +	return false;
>>>> +}
>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>> index 357422a4c319..a75f3e145bf1 100644
>>>> --- a/fs/f2fs/file.c
>>>> +++ b/fs/f2fs/file.c
>>>> @@ -586,7 +586,8 @@ static int truncate_partial_data_page(struct inode *inode, u64 from,
>>>>  	return 0;
>>>>  }
>>>>  
>>>> -int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock)
>>>> +int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock,
>>>> +							bool buf_write)
>>>>  {
>>>>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>>>  	struct dnode_of_data dn;
>>>> @@ -594,6 +595,7 @@ int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock)
>>>>  	int count = 0, err = 0;
>>>>  	struct page *ipage;
>>>>  	bool truncate_page = false;
>>>> +	int flag = buf_write ? F2FS_GET_BLOCK_PRE_AIO : F2FS_GET_BLOCK_PRE_DIO;
>>>>  
>>>>  	trace_f2fs_truncate_blocks_enter(inode, from);
>>>>  
>>>> @@ -603,7 +605,7 @@ int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock)
>>>>  		goto free_partial;
>>>>  
>>>>  	if (lock)
>>>> -		f2fs_lock_op(sbi);
>>>> +		__do_map_lock(sbi, flag, true);
>>>>  
>>>>  	ipage = f2fs_get_node_page(sbi, inode->i_ino);
>>>>  	if (IS_ERR(ipage)) {
>>>> @@ -641,7 +643,7 @@ int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock)
>>>>  	err = f2fs_truncate_inode_blocks(inode, free_from);
>>>>  out:
>>>>  	if (lock)
>>>> -		f2fs_unlock_op(sbi);
>>>> +		__do_map_lock(sbi, flag, false);
>>>>  free_partial:
>>>>  	/* lastly zero out the first data page */
>>>>  	if (!err)
>>>> @@ -676,7 +678,7 @@ int f2fs_truncate(struct inode *inode)
>>>>  			return err;
>>>>  	}
>>>>  
>>>> -	err = f2fs_truncate_blocks(inode, i_size_read(inode), true);
>>>> +	err = f2fs_truncate_blocks(inode, i_size_read(inode), true, false);
>>>>  	if (err)
>>>>  		return err;
>>>>  
>>>> @@ -785,9 +787,24 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
>>>>  		!uid_eq(attr->ia_uid, inode->i_uid)) ||
>>>>  		(attr->ia_valid & ATTR_GID &&
>>>>  		!gid_eq(attr->ia_gid, inode->i_gid))) {
>>>> +		f2fs_lock_op(F2FS_I_SB(inode));
>>>>  		err = dquot_transfer(inode, attr);
>>>> -		if (err)
>>>> +		if (err) {
>>>> +			set_sbi_flag(F2FS_I_SB(inode),
>>>> +					SBI_QUOTA_NEED_REPAIR);
>>>> +			f2fs_unlock_op(F2FS_I_SB(inode));
>>>>  			return err;
>>>> +		}
>>>> +		/*
>>>> +		 * update uid/gid under lock_op(), so that dquot and inode can
>>>> +		 * be updated atomically.
>>>> +		 */
>>>> +		if (attr->ia_valid & ATTR_UID)
>>>> +			inode->i_uid = attr->ia_uid;
>>>> +		if (attr->ia_valid & ATTR_GID)
>>>> +			inode->i_gid = attr->ia_gid;
>>>> +		f2fs_mark_inode_dirty_sync(inode, true);
>>>> +		f2fs_unlock_op(F2FS_I_SB(inode));
>>>>  	}
>>>>  
>>>>  	if (attr->ia_valid & ATTR_SIZE) {
>>>> @@ -1242,7 +1259,7 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
>>>>  	new_size = i_size_read(inode) - len;
>>>>  	truncate_pagecache(inode, new_size);
>>>>  
>>>> -	ret = f2fs_truncate_blocks(inode, new_size, true);
>>>> +	ret = f2fs_truncate_blocks(inode, new_size, true, false);
>>>>  	up_write(&F2FS_I(inode)->i_mmap_sem);
>>>>  	if (!ret)
>>>>  		f2fs_i_size_write(inode, new_size);
>>>> @@ -1427,7 +1444,7 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
>>>>  	f2fs_balance_fs(sbi, true);
>>>>  
>>>>  	down_write(&F2FS_I(inode)->i_mmap_sem);
>>>> -	ret = f2fs_truncate_blocks(inode, i_size_read(inode), true);
>>>> +	ret = f2fs_truncate_blocks(inode, i_size_read(inode), true, false);
>>>>  	up_write(&F2FS_I(inode)->i_mmap_sem);
>>>>  	if (ret)
>>>>  		return ret;
>>>> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
>>>> index 425d740f87fd..cb31a719b048 100644
>>>> --- a/fs/f2fs/inline.c
>>>> +++ b/fs/f2fs/inline.c
>>>> @@ -298,7 +298,7 @@ bool f2fs_recover_inline_data(struct inode *inode, struct page *npage)
>>>>  		clear_inode_flag(inode, FI_INLINE_DATA);
>>>>  		f2fs_put_page(ipage, 1);
>>>>  	} else if (ri && (ri->i_inline & F2FS_INLINE_DATA)) {
>>>> -		if (f2fs_truncate_blocks(inode, 0, false))
>>>> +		if (f2fs_truncate_blocks(inode, 0, false, false))
>>>>  			return false;
>>>>  		goto process_inline;
>>>>  	}
>>>> @@ -470,7 +470,7 @@ static int f2fs_add_inline_entries(struct inode *dir, void *inline_dentry)
>>>>  	return 0;
>>>>  punch_dentry_pages:
>>>>  	truncate_inode_pages(&dir->i_data, 0);
>>>> -	f2fs_truncate_blocks(dir, 0, false);
>>>> +	f2fs_truncate_blocks(dir, 0, false, false);
>>>>  	f2fs_remove_dirty_inode(dir);
>>>>  	return err;
>>>>  }
>>>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>>>> index 86e7333d60c1..3c278e63d1a3 100644
>>>> --- a/fs/f2fs/inode.c
>>>> +++ b/fs/f2fs/inode.c
>>>> @@ -645,7 +645,11 @@ void f2fs_evict_inode(struct inode *inode)
>>>>  	if (inode->i_nlink || is_bad_inode(inode))
>>>>  		goto no_delete;
>>>>  
>>>> -	dquot_initialize(inode);
>>>> +	err = dquot_initialize(inode);
>>>> +	if (err) {
>>>> +		err = 0;
>>>> +		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
>>>> +	}
>>>>  
>>>>  	f2fs_remove_ino_entry(sbi, inode->i_ino, APPEND_INO);
>>>>  	f2fs_remove_ino_entry(sbi, inode->i_ino, UPDATE_INO);
>>>> @@ -677,9 +681,10 @@ void f2fs_evict_inode(struct inode *inode)
>>>>  		goto retry;
>>>>  	}
>>>>  
>>>> -	if (err)
>>>> +	if (err) {
>>>>  		f2fs_update_inode_page(inode);
>>>> -	dquot_free_inode(inode);
>>>> +		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
>>>> +	}
>>>>  	sb_end_intwrite(inode->i_sb);
>>>>  no_delete:
>>>>  	dquot_drop(inode);
>>>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
>>>> index 9ad451ac2cec..b65491a63115 100644
>>>> --- a/fs/f2fs/namei.c
>>>> +++ b/fs/f2fs/namei.c
>>>> @@ -71,10 +71,6 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
>>>>  	if (err)
>>>>  		goto fail_drop;
>>>>  
>>>> -	err = dquot_alloc_inode(inode);
>>>> -	if (err)
>>>> -		goto fail_drop;
>>>> -
>>>>  	set_inode_flag(inode, FI_NEW_INODE);
>>>>  
>>>>  	/* If the directory encrypted, then we should encrypt the inode. */
>>>> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
>>>> index 41f2c0fe6d8e..70f05650191e 100644
>>>> --- a/fs/f2fs/recovery.c
>>>> +++ b/fs/f2fs/recovery.c
>>>> @@ -191,6 +191,33 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
>>>>  	return err;
>>>>  }
>>>>  
>>>> +static int recover_quota_data(struct inode *inode, struct page *page)
>>>> +{
>>>> +	struct f2fs_inode *raw = F2FS_INODE(page);
>>>> +	struct iattr attr;
>>>> +	uid_t i_uid = le32_to_cpu(raw->i_uid);
>>>> +	gid_t i_gid = le32_to_cpu(raw->i_gid);
>>>> +	int err;
>>>> +
>>>> +	memset(&attr, 0, sizeof(attr));
>>>> +
>>>> +	attr.ia_uid = make_kuid(inode->i_sb->s_user_ns, i_uid);
>>>> +	attr.ia_gid = make_kgid(inode->i_sb->s_user_ns, i_gid);
>>>> +
>>>> +	if (!uid_eq(attr.ia_uid, inode->i_uid))
>>>> +		attr.ia_valid |= ATTR_UID;
>>>> +	if (!gid_eq(attr.ia_gid, inode->i_gid))
>>>> +		attr.ia_valid |= ATTR_GID;
>>>> +
>>>> +	if (!attr.ia_valid)
>>>> +		return 0;
>>>> +
>>>> +	err = dquot_transfer(inode, &attr);
>>>> +	if (err)
>>>> +		set_sbi_flag(F2FS_I_SB(inode), SBI_QUOTA_NEED_REPAIR);
>>>> +	return err;
>>>> +}
>>>> +
>>>>  static void recover_inline_flags(struct inode *inode, struct f2fs_inode *ri)
>>>>  {
>>>>  	if (ri->i_inline & F2FS_PIN_FILE)
>>>> @@ -203,12 +230,18 @@ static void recover_inline_flags(struct inode *inode, struct f2fs_inode *ri)
>>>>  		clear_inode_flag(inode, FI_DATA_EXIST);
>>>>  }
>>>>  
>>>> -static void recover_inode(struct inode *inode, struct page *page)
>>>> +static int recover_inode(struct inode *inode, struct page *page)
>>>>  {
>>>>  	struct f2fs_inode *raw = F2FS_INODE(page);
>>>>  	char *name;
>>>> +	int err;
>>>>  
>>>>  	inode->i_mode = le16_to_cpu(raw->i_mode);
>>>> +
>>>> +	err = recover_quota_data(inode, page);
>>>> +	if (err)
>>>> +		return err;
>>>> +
>>>>  	i_uid_write(inode, le32_to_cpu(raw->i_uid));
>>>>  	i_gid_write(inode, le32_to_cpu(raw->i_gid));
>>>>  	f2fs_i_size_write(inode, le64_to_cpu(raw->i_size));
>>>> @@ -231,6 +264,7 @@ static void recover_inode(struct inode *inode, struct page *page)
>>>>  	f2fs_msg(inode->i_sb, KERN_NOTICE,
>>>>  		"recover_inode: ino = %x, name = %s, inline = %x",
>>>>  			ino_of_node(page), name, raw->i_inline);
>>>> +	return 0;
>>>>  }
>>>>  
>>>>  static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
>>>> @@ -597,8 +631,11 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
>>>>  		 * In this case, we can lose the latest inode(x).
>>>>  		 * So, call recover_inode for the inode update.
>>>>  		 */
>>>> -		if (IS_INODE(page))
>>>> -			recover_inode(entry->inode, page);
>>>> +		if (IS_INODE(page)) {
>>>> +			err = recover_inode(entry->inode, page);
>>>> +			if (err)
>>>> +				break;
>>>> +		}
>>>>  		if (entry->last_dentry == blkaddr) {
>>>>  			err = recover_dentry(entry->inode, page, dir_list);
>>>>  			if (err) {
>>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>>> index 945468968d4e..3a46c9b81188 100644
>>>> --- a/fs/f2fs/super.c
>>>> +++ b/fs/f2fs/super.c
>>>> @@ -1689,6 +1689,13 @@ static qsize_t *f2fs_get_reserved_space(struct inode *inode)
>>>>  
>>>>  static int f2fs_quota_on_mount(struct f2fs_sb_info *sbi, int type)
>>>>  {
>>>> +
>>>> +	if (is_set_ckpt_flags(sbi, CP_QUOTA_NEED_FSCK_FLAG)) {
>>>> +		f2fs_msg(sbi->sb, KERN_ERR,
>>>> +			"quota sysfile may be corrupted, skip loading it");
>>>> +		return 0;
>>>> +	}
>>>> +
>>>>  	return dquot_quota_on_mount(sbi->sb, F2FS_OPTION(sbi).s_qf_names[type],
>>>>  					F2FS_OPTION(sbi).s_jquota_fmt, type);
>>>>  }
>>>> @@ -1759,7 +1766,14 @@ static int f2fs_enable_quotas(struct super_block *sb)
>>>>  		test_opt(F2FS_SB(sb), PRJQUOTA),
>>>>  	};
>>>>  
>>>> -	sb_dqopt(sb)->flags |= DQUOT_QUOTA_SYS_FILE | DQUOT_NOLIST_DIRTY;
>>>> +	if (is_set_ckpt_flags(F2FS_SB(sb), CP_QUOTA_NEED_FSCK_FLAG)) {
>>>> +		f2fs_msg(sb, KERN_ERR,
>>>> +			"quota file may be corrupted, skip loading it");
>>>> +		return 0;
>>>> +	}
>>>> +
>>>> +	sb_dqopt(sb)->flags |= DQUOT_QUOTA_SYS_FILE;
>>>> +
>>>>  	for (type = 0; type < MAXQUOTAS; type++) {
>>>>  		qf_inum = f2fs_qf_ino(sb, type);
>>>>  		if (qf_inum) {
>>>> @@ -1773,6 +1787,8 @@ static int f2fs_enable_quotas(struct super_block *sb)
>>>>  					"fsck to fix.", type, err);
>>>>  				for (type--; type >= 0; type--)
>>>>  					dquot_quota_off(sb, type);
>>>> +				set_sbi_flag(F2FS_SB(sb),
>>>> +						SBI_QUOTA_NEED_REPAIR);
>>>>  				return err;
>>>>  			}
>>>>  		}
>>>> @@ -1780,35 +1796,51 @@ static int f2fs_enable_quotas(struct super_block *sb)
>>>>  	return 0;
>>>>  }
>>>>  
>>>> -static int f2fs_quota_sync(struct super_block *sb, int type)
>>>> +int f2fs_quota_sync(struct super_block *sb, int type)
>>>>  {
>>>> +	struct f2fs_sb_info *sbi = F2FS_SB(sb);
>>>>  	struct quota_info *dqopt = sb_dqopt(sb);
>>>>  	int cnt;
>>>>  	int ret;
>>>>  
>>>>  	ret = dquot_writeback_dquots(sb, type);
>>>>  	if (ret)
>>>> -		return ret;
>>>> +		goto out;
>>>>  
>>>>  	/*
>>>>  	 * Now when everything is written we can discard the pagecache so
>>>>  	 * that userspace sees the changes.
>>>>  	 */
>>>>  	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
>>>> +		struct address_space *mapping;
>>>> +
>>>>  		if (type != -1 && cnt != type)
>>>>  			continue;
>>>>  		if (!sb_has_quota_active(sb, cnt))
>>>>  			continue;
>>>>  
>>>> -		ret = filemap_write_and_wait(dqopt->files[cnt]->i_mapping);
>>>> +		mapping = dqopt->files[cnt]->i_mapping;
>>>> +
>>>> +		ret = filemap_fdatawrite(mapping);
>>>> +		if (ret)
>>>> +			goto out;
>>>> +
>>>> +		/* if we are using journalled quota */
>>>> +		if (is_journalled_quota(sbi))
>>>> +			continue;
>>>> +
>>>> +		ret = filemap_fdatawait(mapping);
>>>>  		if (ret)
>>>> -			return ret;
>>>> +			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
>>>>  
>>>>  		inode_lock(dqopt->files[cnt]);
>>>>  		truncate_inode_pages(&dqopt->files[cnt]->i_data, 0);
>>>>  		inode_unlock(dqopt->files[cnt]);
>>>>  	}
>>>> -	return 0;
>>>> +out:
>>>> +	if (ret)
>>>> +		set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
>>>> +	return ret;
>>>>  }
>>>>  
>>>>  static int f2fs_quota_on(struct super_block *sb, int type, int format_id,
>>>> @@ -1877,11 +1909,67 @@ void f2fs_quota_off_umount(struct super_block *sb)
>>>>  				"Fail to turn off disk quota "
>>>>  				"(type: %d, err: %d, ret:%d), Please "
>>>>  				"run fsck to fix it.", type, err, ret);
>>>> -			set_sbi_flag(F2FS_SB(sb), SBI_NEED_FSCK);
>>>> +			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
>>>>  		}
>>>>  	}
>>>>  }
>>>>  
>>>> +static int f2fs_dquot_commit(struct dquot *dquot)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	ret = dquot_commit(dquot);
>>>> +	if (ret < 0)
>>>> +		set_sbi_flag(F2FS_SB(dquot->dq_sb), SBI_QUOTA_NEED_REPAIR);
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static int f2fs_dquot_acquire(struct dquot *dquot)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	ret = dquot_acquire(dquot);
>>>> +	if (ret < 0)
>>>> +		set_sbi_flag(F2FS_SB(dquot->dq_sb), SBI_QUOTA_NEED_REPAIR);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static int f2fs_dquot_release(struct dquot *dquot)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	ret = dquot_release(dquot);
>>>> +	if (ret < 0)
>>>> +		set_sbi_flag(F2FS_SB(dquot->dq_sb), SBI_QUOTA_NEED_REPAIR);
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static int f2fs_dquot_mark_dquot_dirty(struct dquot *dquot)
>>>> +{
>>>> +	struct super_block *sb = dquot->dq_sb;
>>>> +	struct f2fs_sb_info *sbi = F2FS_SB(sb);
>>>> +	int ret;
>>>> +
>>>> +	ret = dquot_mark_dquot_dirty(dquot);
>>>> +
>>>> +	/* if we are using journalled quota */
>>>> +	if (is_journalled_quota(sbi))
>>>> +		set_sbi_flag(sbi, SBI_QUOTA_NEED_FLUSH);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static int f2fs_dquot_commit_info(struct super_block *sb, int type)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	ret = dquot_commit_info(sb, type);
>>>> +	if (ret < 0)
>>>> +		set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
>>>> +	return ret;
>>>> +}
>>>> +
>>>>  static int f2fs_get_projid(struct inode *inode, kprojid_t *projid)
>>>>  {
>>>>  	*projid = F2FS_I(inode)->i_projid;
>>>> @@ -1890,11 +1978,11 @@ static int f2fs_get_projid(struct inode *inode, kprojid_t *projid)
>>>>  
>>>>  static const struct dquot_operations f2fs_quota_operations = {
>>>>  	.get_reserved_space = f2fs_get_reserved_space,
>>>> -	.write_dquot	= dquot_commit,
>>>> -	.acquire_dquot	= dquot_acquire,
>>>> -	.release_dquot	= dquot_release,
>>>> -	.mark_dirty	= dquot_mark_dquot_dirty,
>>>> -	.write_info	= dquot_commit_info,
>>>> +	.write_dquot	= f2fs_dquot_commit,
>>>> +	.acquire_dquot	= f2fs_dquot_acquire,
>>>> +	.release_dquot	= f2fs_dquot_release,
>>>> +	.mark_dirty	= f2fs_dquot_mark_dquot_dirty,
>>>> +	.write_info	= f2fs_dquot_commit_info,
>>>>  	.alloc_dquot	= dquot_alloc,
>>>>  	.destroy_dquot	= dquot_destroy,
>>>>  	.get_projid	= f2fs_get_projid,
>>>> @@ -1912,6 +2000,11 @@ static const struct quotactl_ops f2fs_quotactl_ops = {
>>>>  	.get_nextdqblk	= dquot_get_next_dqblk,
>>>>  };
>>>>  #else
>>>> +int f2fs_quota_sync(struct super_block *sb, int type)
>>>> +{
>>>> +	return 0;
>>>> +}
>>>> +
>>>>  void f2fs_quota_off_umount(struct super_block *sb)
>>>>  {
>>>>  }
>>>> @@ -2951,6 +3044,9 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>>>>  		goto free_meta_inode;
>>>>  	}
>>>>  
>>>> +	if (__is_set_ckpt_flags(F2FS_CKPT(sbi), CP_QUOTA_NEED_FSCK_FLAG))
>>>> +		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
>>>> +
>>>>  	/* Initialize device list */
>>>>  	err = f2fs_scan_devices(sbi);
>>>>  	if (err) {
>>>> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
>>>> index 1d4b196291d6..aaca9f5d5f5c 100644
>>>> --- a/include/linux/f2fs_fs.h
>>>> +++ b/include/linux/f2fs_fs.h
>>>> @@ -115,6 +115,7 @@ struct f2fs_super_block {
>>>>  /*
>>>>   * For checkpoint
>>>>   */
>>>> +#define CP_QUOTA_NEED_FSCK_FLAG		0x00000800
>>>>  #define CP_LARGE_NAT_BITMAP_FLAG	0x00000400
>>>>  #define CP_NOCRC_RECOVERY_FLAG	0x00000200
>>>>  #define CP_TRIMMED_FLAG		0x00000100
>>>> -- 
>>>> 2.18.0
