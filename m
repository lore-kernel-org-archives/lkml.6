Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFA6C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D40320855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1cZFzZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D40320855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbeIHC2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:28:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730188AbeIHC2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:28:31 -0400
Received: from localhost (unknown [104.132.0.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BE7C20869;
        Fri,  7 Sep 2018 21:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536356735;
        bh=NKA21g/K6yq6fS4ve81uhHzRS0HYr4p9/YxtClM4fNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I1cZFzZQ6bbzdA9IsWCICMwsSkNFddaoXQoxUYJtJZgcmgV/lJEHXf9g8r4/Exlv+
         R60xRuMZHRVh0ODIrg02AaK4GxV0q62o/yqJ2/y1tfF6NJwIpyvCbGvKlhHrUD5KuC
         xNRMQQ5glgeUr9Cp/tj7S/SjZUIWOokGpgvJBgHk=
Date:   Fri, 7 Sep 2018 14:45:32 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org,
        Weichao Guo <guoweichao@huawei.com>
Subject: Re: [PATCH v6] f2fs: guarantee journalled quota data by checkpoint
Message-ID: <20180907214532.GA93212@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180907103156.54471-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907103156.54471-1-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chao,

I was testing the previous patch and removed in the queue due to quota-related
hang during fault injection + shutdown test. Let me try this later.

Thanks,

On 09/07, Chao Yu wrote:
> For journalled quota mode, let checkpoint to flush dquot dirty data
> and quota file data to guarntee persistence of all quota sysfile in
> last checkpoint, by this way, we can avoid corrupting quota sysfile
> when encountering SPO.
> 
> The implementation is as below:
> 
> 1. add a global state SBI_QUOTA_NEED_FLUSH to indicate that there is
> cached dquot metadata changes in quota subsystem, and later checkpoint
> should:
>  a) flush dquot metadata into quota file.
>  b) flush quota file to storage to keep file usage be consistent.
> 
> 2. add a global state SBI_QUOTA_NEED_REPAIR to indicate that quota
> operation failed due to -EIO or -ENOSPC, so later,
>  a) checkpoint will skip syncing dquot metadata.
>  b) CP_QUOTA_NEED_FSCK_FLAG will be set in last cp pack to give a
>     hint for fsck repairing.
> 
> 3. add a global state SBI_QUOTA_SKIP_FLUSH, in checkpoint, if quota
> data updating is very heavy, it may cause hungtask in block_operation().
> To avoid this, if our retry time exceed threshold, let's just skip
> flushing and retry in next checkpoint().
> 
> Signed-off-by: Weichao Guo <guoweichao@huawei.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> v6:
> - don't discard quota file's cache on journalled quota mode, otherwise
> it can fail generic/417 testcase.
>  fs/f2fs/checkpoint.c    |  45 +++++++++++++++--
>  fs/f2fs/data.c          |   8 ++-
>  fs/f2fs/f2fs.h          |   7 +++
>  fs/f2fs/super.c         | 106 ++++++++++++++++++++++++++++++++++++----
>  include/linux/f2fs_fs.h |   1 +
>  5 files changed, 152 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index fa2e0d3c4945..b88a3e17ec1d 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1086,6 +1086,15 @@ static void __prepare_cp_block(struct f2fs_sb_info *sbi)
>  	ckpt->next_free_nid = cpu_to_le32(last_nid);
>  }
>  
> +static bool __need_flush_quota(struct f2fs_sb_info *sbi)
> +{
> +	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
> +		return false;
> +	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR))
> +		return false;
> +	return is_sbi_flag_set(sbi, SBI_QUOTA_NEED_FLUSH));
> +}
> +
>  /*
>   * Freeze all the FS-operations for checkpoint.
>   */
> @@ -1097,12 +1106,31 @@ static int block_operations(struct f2fs_sb_info *sbi)
>  		.for_reclaim = 0,
>  	};
>  	struct blk_plug plug;
> -	int err = 0;
> +	int err = 0, cnt = 0;
>  
>  	blk_start_plug(&plug);
>  
> -retry_flush_dents:
> +retry_flush_quotas:
> +	if (__need_flush_quota(sbi)) {
> +		if (++cnt > DEFAULT_RETRY_QUOTA_FLUSH_COUNT) {
> +			set_sbi_flag(sbi, SBI_QUOTA_SKIP_FLUSH);
> +			f2fs_lock_all(sbi);
> +			goto retry_flush_dents;
> +		}
> +		clear_sbi_flag(sbi, SBI_QUOTA_NEED_FLUSH);
> +		err = f2fs_quota_sync(sbi->sb, -1);
> +		if (err)
> +			goto out;
> +	}
> +
>  	f2fs_lock_all(sbi);
> +	if (__need_flush_quota(sbi)) {
> +		f2fs_unlock_all(sbi);
> +		cond_resched();
> +		goto retry_flush_quotas;
> +	}
> +
> +retry_flush_dents:
>  	/* write all the dirty dentry pages */
>  	if (get_pages(sbi, F2FS_DIRTY_DENTS)) {
>  		f2fs_unlock_all(sbi);
> @@ -1110,7 +1138,7 @@ static int block_operations(struct f2fs_sb_info *sbi)
>  		if (err)
>  			goto out;
>  		cond_resched();
> -		goto retry_flush_dents;
> +		goto retry_flush_quotas;
>  	}
>  
>  	/*
> @@ -1126,7 +1154,7 @@ static int block_operations(struct f2fs_sb_info *sbi)
>  		if (err)
>  			goto out;
>  		cond_resched();
> -		goto retry_flush_dents;
> +		goto retry_flush_quotas;
>  	}
>  
>  retry_flush_nodes:
> @@ -1217,6 +1245,14 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
>  		__set_ckpt_flags(ckpt, CP_FSCK_FLAG);
>  
> +	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
> +		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
> +	else
> +		__clear_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
> +
> +	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR))
> +		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
> +
>  	/* set this flag to activate crc|cp_ver for recovery */
>  	__set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG);
>  	__clear_ckpt_flags(ckpt, CP_NOCRC_RECOVERY_FLAG);
> @@ -1424,6 +1460,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  
>  	clear_sbi_flag(sbi, SBI_IS_DIRTY);
>  	clear_sbi_flag(sbi, SBI_NEED_CP);
> +	clear_sbi_flag(sbi, SBI_QUOTA_SKIP_FLUSH);
>  	__set_cp_next_pack(sbi);
>  
>  	/*
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 8c204f896c22..eb60a870a1df 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -49,7 +49,7 @@ static bool __is_cp_guaranteed(struct page *page)
>  			inode->i_ino ==  F2FS_NODE_INO(sbi) ||
>  			S_ISDIR(inode->i_mode) ||
>  			(S_ISREG(inode->i_mode) &&
> -			is_inode_flag_set(inode, FI_ATOMIC_FILE)) ||
> +			(f2fs_is_atomic_file(inode) || IS_NOQUOTA(inode))) ||
>  			is_cold_data(page))
>  		return true;
>  	return false;
> @@ -1711,6 +1711,8 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
>  		return true;
>  	if (S_ISDIR(inode->i_mode))
>  		return true;
> +	if (IS_NOQUOTA(inode))
> +		return true;
>  	if (f2fs_is_atomic_file(inode))
>  		return true;
>  	if (fio) {
> @@ -1955,7 +1957,7 @@ static int __write_data_page(struct page *page, bool *submitted,
>  	}
>  
>  	unlock_page(page);
> -	if (!S_ISDIR(inode->i_mode))
> +	if (!S_ISDIR(inode->i_mode) && !IS_NOQUOTA(inode))
>  		f2fs_balance_fs(sbi, need_balance_fs);
>  
>  	if (unlikely(f2fs_cp_error(sbi))) {
> @@ -2146,6 +2148,8 @@ static inline bool __should_serialize_io(struct inode *inode,
>  {
>  	if (!S_ISREG(inode->i_mode))
>  		return false;
> +	if (IS_NOQUOTA(inode))
> +		return false;
>  	if (wbc->sync_mode != WB_SYNC_ALL)
>  		return true;
>  	if (get_dirty_pages(inode) >= SM_I(F2FS_I_SB(inode))->min_seq_blocks)
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 3a8a60e6844c..b153f97de696 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -527,6 +527,9 @@ enum {
>  
>  #define DEFAULT_RETRY_IO_COUNT	8	/* maximum retry read IO count */
>  
> +/* maximum retry quota flush count */
> +#define DEFAULT_RETRY_QUOTA_FLUSH_COUNT		8
> +
>  #define F2FS_LINK_MAX	0xffffffff	/* maximum link count per file */
>  
>  #define MAX_DIR_RA_PAGES	4	/* maximum ra pages of dir */
> @@ -1089,6 +1092,9 @@ enum {
>  	SBI_NEED_CP,				/* need to checkpoint */
>  	SBI_IS_SHUTDOWN,			/* shutdown by ioctl */
>  	SBI_IS_RECOVERED,			/* recovered orphan/data */
> +	SBI_QUOTA_NEED_FLUSH,			/* need to flush quota info in CP */
> +	SBI_QUOTA_SKIP_FLUSH,			/* skip flushing quota in current CP */
> +	SBI_QUOTA_NEED_REPAIR,			/* quota file may be corrupted */
>  };
>  
>  enum {
> @@ -2828,6 +2834,7 @@ static inline int f2fs_add_link(struct dentry *dentry, struct inode *inode)
>  int f2fs_inode_dirtied(struct inode *inode, bool sync);
>  void f2fs_inode_synced(struct inode *inode);
>  int f2fs_enable_quota_files(struct f2fs_sb_info *sbi, bool rdonly);
> +int f2fs_quota_sync(struct super_block *sb, int type);
>  void f2fs_quota_off_umount(struct super_block *sb);
>  int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover);
>  int f2fs_sync_fs(struct super_block *sb, int sync);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index ad77994f47fa..73106c720fd0 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1688,6 +1688,13 @@ static qsize_t *f2fs_get_reserved_space(struct inode *inode)
>  
>  static int f2fs_quota_on_mount(struct f2fs_sb_info *sbi, int type)
>  {
> +
> +	if (is_set_ckpt_flags(sbi, CP_QUOTA_NEED_FSCK_FLAG)) {
> +		f2fs_msg(sbi->sb, KERN_ERR,
> +			"quota sysfile may be corrupted, skip loading it");
> +		return 0;
> +	}
> +
>  	return dquot_quota_on_mount(sbi->sb, F2FS_OPTION(sbi).s_qf_names[type],
>  					F2FS_OPTION(sbi).s_jquota_fmt, type);
>  }
> @@ -1758,7 +1765,14 @@ static int f2fs_enable_quotas(struct super_block *sb)
>  		test_opt(F2FS_SB(sb), PRJQUOTA),
>  	};
>  
> +	if (is_set_ckpt_flags(F2FS_SB(sb), CP_QUOTA_NEED_FSCK_FLAG)) {
> +		f2fs_msg(sb, KERN_ERR,
> +			"quota file may be corrupted, skip loading it");
> +		return 0;
> +	}
> +
>  	sb_dqopt(sb)->flags |= DQUOT_QUOTA_SYS_FILE | DQUOT_NOLIST_DIRTY;
> +
>  	for (type = 0; type < MAXQUOTAS; type++) {
>  		qf_inum = f2fs_qf_ino(sb, type);
>  		if (qf_inum) {
> @@ -1779,15 +1793,16 @@ static int f2fs_enable_quotas(struct super_block *sb)
>  	return 0;
>  }
>  
> -static int f2fs_quota_sync(struct super_block *sb, int type)
> +int f2fs_quota_sync(struct super_block *sb, int type)
>  {
> +	struct f2fs_sb_info *sbi = F2FS_SB(sb);
>  	struct quota_info *dqopt = sb_dqopt(sb);
>  	int cnt;
>  	int ret;
>  
>  	ret = dquot_writeback_dquots(sb, type);
>  	if (ret)
> -		return ret;
> +		goto out;
>  
>  	/*
>  	 * Now when everything is written we can discard the pagecache so
> @@ -1801,13 +1816,23 @@ static int f2fs_quota_sync(struct super_block *sb, int type)
>  
>  		ret = filemap_write_and_wait(dqopt->files[cnt]->i_mapping);
>  		if (ret)
> -			return ret;
> +			goto out;
> +
> +		/* if we are using journalled quota */
> +		if (f2fs_sb_has_quota_ino(sbi) ||
> +			F2FS_OPTION(sbi).s_qf_names[USRQUOTA] ||
> +			F2FS_OPTION(sbi).s_qf_names[GRPQUOTA] ||
> +			F2FS_OPTION(sbi).s_qf_names[PRJQUOTA])
> +			continue;
>  
>  		inode_lock(dqopt->files[cnt]);
>  		truncate_inode_pages(&dqopt->files[cnt]->i_data, 0);
>  		inode_unlock(dqopt->files[cnt]);
>  	}
> -	return 0;
> +out:
> +	if (ret)
> +		set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
> +	return ret;
>  }
>  
>  static int f2fs_quota_on(struct super_block *sb, int type, int format_id,
> @@ -1868,6 +1893,61 @@ void f2fs_quota_off_umount(struct super_block *sb)
>  		f2fs_quota_off(sb, type);
>  }
>  
> +static int f2fs_dquot_commit(struct dquot *dquot)
> +{
> +	int ret;
> +
> +	ret = dquot_commit(dquot);
> +	if (ret == -ENOSPC || ret == -EIO)
> +		set_sbi_flag(F2FS_SB(dquot->dq_sb), SBI_QUOTA_NEED_REPAIR);
> +	return ret;
> +}
> +
> +static int f2fs_dquot_acquire(struct dquot *dquot)
> +{
> +	int ret;
> +
> +	ret = dquot_acquire(dquot);
> +	if (ret == -ENOSPC || ret == -EIO)
> +		set_sbi_flag(F2FS_SB(dquot->dq_sb), SBI_QUOTA_NEED_REPAIR);
> +	return ret;
> +}
> +
> +static int f2fs_dquot_release(struct dquot *dquot)
> +{
> +	int ret;
> +
> +	ret = dquot_release(dquot);
> +	if (ret == -ENOSPC || ret == -EIO)
> +		set_sbi_flag(F2FS_SB(dquot->dq_sb), SBI_QUOTA_NEED_REPAIR);
> +	return ret;
> +}
> +
> +static int f2fs_dquot_mark_dquot_dirty(struct dquot *dquot)
> +{
> +	struct super_block *sb = dquot->dq_sb;
> +	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> +
> +	/* if we are using journalled quota */
> +	if (f2fs_sb_has_quota_ino(sb) ||
> +		F2FS_OPTION(sbi).s_qf_names[USRQUOTA] ||
> +		F2FS_OPTION(sbi).s_qf_names[GRPQUOTA] ||
> +		F2FS_OPTION(sbi).s_qf_names[PRJQUOTA])
> +		set_sbi_flag(sbi, SBI_QUOTA_NEED_FLUSH);
> +
> +	return dquot_mark_dquot_dirty(dquot);
> +}
> +
> +static int f2fs_dquot_commit_info(struct super_block *sb, int type)
> +{
> +	int ret;
> +
> +	ret = dquot_commit_info(sb, type);
> +	if (ret == -ENOSPC || ret == -EIO)
> +		set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
> +	return ret;
> +}
> +
>  static int f2fs_get_projid(struct inode *inode, kprojid_t *projid)
>  {
>  	*projid = F2FS_I(inode)->i_projid;
> @@ -1876,11 +1956,11 @@ static int f2fs_get_projid(struct inode *inode, kprojid_t *projid)
>  
>  static const struct dquot_operations f2fs_quota_operations = {
>  	.get_reserved_space = f2fs_get_reserved_space,
> -	.write_dquot	= dquot_commit,
> -	.acquire_dquot	= dquot_acquire,
> -	.release_dquot	= dquot_release,
> -	.mark_dirty	= dquot_mark_dquot_dirty,
> -	.write_info	= dquot_commit_info,
> +	.write_dquot	= f2fs_dquot_commit,
> +	.acquire_dquot	= f2fs_dquot_acquire,
> +	.release_dquot	= f2fs_dquot_release,
> +	.mark_dirty	= f2fs_dquot_mark_dquot_dirty,
> +	.write_info	= f2fs_dquot_commit_info,
>  	.alloc_dquot	= dquot_alloc,
>  	.destroy_dquot	= dquot_destroy,
>  	.get_projid	= f2fs_get_projid,
> @@ -1898,6 +1978,11 @@ static const struct quotactl_ops f2fs_quotactl_ops = {
>  	.get_nextdqblk	= dquot_get_next_dqblk,
>  };
>  #else
> +int f2fs_quota_sync(struct super_block *sb, int type)
> +{
> +	return 0;
> +}
> +
>  void f2fs_quota_off_umount(struct super_block *sb)
>  {
>  }
> @@ -2937,6 +3022,9 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  		goto free_meta_inode;
>  	}
>  
> +	if (__is_set_ckpt_flags(F2FS_CKPT(sbi), CP_QUOTA_NEED_FSCK_FLAG))
> +		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
> +
>  	/* Initialize device list */
>  	err = f2fs_scan_devices(sbi);
>  	if (err) {
> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index f70f8ac9c4f4..6a879a865343 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -118,6 +118,7 @@ struct f2fs_super_block {
>  /*
>   * For checkpoint
>   */
> +#define CP_QUOTA_NEED_FSCK_FLAG		0x00000800
>  #define CP_LARGE_NAT_BITMAP_FLAG	0x00000400
>  #define CP_NOCRC_RECOVERY_FLAG	0x00000200
>  #define CP_TRIMMED_FLAG		0x00000100
> -- 
> 2.18.0.rc1
