Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A798C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 03:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC87920659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 03:14:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC87920659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeIFHrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 03:47:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11636 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725981AbeIFHrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 03:47:40 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 07F0EBD7C681A;
        Thu,  6 Sep 2018 11:14:27 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.399.0; Thu, 6 Sep 2018
 11:14:21 +0800
Subject: Re: [PATCH v4] f2fs: guarantee journalled quota data by checkpoint
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Weichao Guo <guoweichao@huawei.com>
References: <20180823112844.2092-1-yuchao0@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <54a6a441-6f38-9b38-01b3-958d934f713e@huawei.com>
Date:   Thu, 6 Sep 2018 11:14:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180823112844.2092-1-yuchao0@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping,

On 2018/8/23 19:28, Chao Yu wrote:
> For journalled quota mode, let checkpoint to flush dquot dirty data
> and quota file data to keep all file quota info are consisting in
> last checkpoint, so that we can avoid quota file being corrupted
> after SPO.
> 
> The implementation is that:
> 
> 1. add a global state SBI_QUOTA_NEED_FLUSH to indicate that there is
> cached dquot metadata changes in quota subsystem, and later checkpoint
> should:
>  a) flush dquot metadata into quota file.
>  b) flush quota file to storage to keep file usage be consistent.
> 
> 2. add a glabal state SBI_QUOTA_NEED_REPAIR to indicate that quota
> persisting is failed due to -EIO or -ENOSPC, and then,
>  a) checkpoint will skip syncing dquot metadata.
>  b) CP_QUOTA_NEED_FSCK_FLAG will be set in last cp pack to give a
>     hint for fsck repairing.
> 
> Signed-off-by: Weichao Guo <guoweichao@huawei.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> v4:
> - rebase to dev-test to avoid compiling error due to conflict with
> another cleanup patch.
>  fs/f2fs/checkpoint.c    | 21 +++++++++
>  fs/f2fs/data.c          |  8 +++-
>  fs/f2fs/f2fs.h          |  3 ++
>  fs/f2fs/super.c         | 95 +++++++++++++++++++++++++++++++++++++----
>  include/linux/f2fs_fs.h |  1 +
>  5 files changed, 117 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 59d0472013f4..c120d197b479 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1086,6 +1086,12 @@ static void __prepare_cp_block(struct f2fs_sb_info *sbi)
>  	ckpt->next_free_nid = cpu_to_le32(last_nid);
>  }
>  
> +static bool __need_flush_quota(struct f2fs_sb_info *sbi)
> +{
> +	return is_sbi_flag_set(sbi, SBI_QUOTA_NEED_FLUSH) &&
> +			!is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR);
> +}
> +
>  /*
>   * Freeze all the FS-operations for checkpoint.
>   */
> @@ -1102,7 +1108,19 @@ static int block_operations(struct f2fs_sb_info *sbi)
>  	blk_start_plug(&plug);
>  
>  retry_flush_dents:
> +	if (__need_flush_quota(sbi)) {
> +		clear_sbi_flag(sbi, SBI_QUOTA_NEED_FLUSH);
> +		err = f2fs_quota_sync(sbi->sb, -1);
> +		if (err)
> +			goto out;
> +	}
> +
>  	f2fs_lock_all(sbi);
> +	if (__need_flush_quota(sbi)) {
> +		f2fs_unlock_all(sbi);
> +		goto retry_flush_dents;
> +	}
> +
>  	/* write all the dirty dentry pages */
>  	if (get_pages(sbi, F2FS_DIRTY_DENTS)) {
>  		f2fs_unlock_all(sbi);
> @@ -1217,6 +1235,9 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
>  		__set_ckpt_flags(ckpt, CP_FSCK_FLAG);
>  
> +	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR))
> +		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
> +
>  	/* set this flag to activate crc|cp_ver for recovery */
>  	__set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG);
>  	__clear_ckpt_flags(ckpt, CP_NOCRC_RECOVERY_FLAG);
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 382c1ef9a9e4..dd51632f97ec 100644
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
> @@ -1705,6 +1705,8 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
>  		return true;
>  	if (S_ISDIR(inode->i_mode))
>  		return true;
> +	if (IS_NOQUOTA(inode))
> +		return true;
>  	if (f2fs_is_atomic_file(inode))
>  		return true;
>  	if (fio) {
> @@ -1949,7 +1951,7 @@ static int __write_data_page(struct page *page, bool *submitted,
>  	}
>  
>  	unlock_page(page);
> -	if (!S_ISDIR(inode->i_mode))
> +	if (!S_ISDIR(inode->i_mode) && !IS_NOQUOTA(inode))
>  		f2fs_balance_fs(sbi, need_balance_fs);
>  
>  	if (unlikely(f2fs_cp_error(sbi))) {
> @@ -2140,6 +2142,8 @@ static inline bool __should_serialize_io(struct inode *inode,
>  {
>  	if (!S_ISREG(inode->i_mode))
>  		return false;
> +	if (IS_NOQUOTA(inode))
> +		return false;
>  	if (wbc->sync_mode != WB_SYNC_ALL)
>  		return true;
>  	if (get_dirty_pages(inode) >= SM_I(F2FS_I_SB(inode))->min_seq_blocks)
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index da942ecf705e..f2241b001130 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1089,6 +1089,8 @@ enum {
>  	SBI_NEED_CP,				/* need to checkpoint */
>  	SBI_IS_SHUTDOWN,			/* shutdown by ioctl */
>  	SBI_IS_RECOVERED,			/* recovered orphan/data */
> +	SBI_QUOTA_NEED_FLUSH,			/* need to flush quota info in CP */
> +	SBI_QUOTA_NEED_REPAIR,			/* quota file may be corrupted */
>  };
>  
>  enum {
> @@ -2828,6 +2830,7 @@ static inline int f2fs_add_link(struct dentry *dentry, struct inode *inode)
>  int f2fs_inode_dirtied(struct inode *inode, bool sync);
>  void f2fs_inode_synced(struct inode *inode);
>  int f2fs_enable_quota_files(struct f2fs_sb_info *sbi, bool rdonly);
> +int f2fs_quota_sync(struct super_block *sb, int type);
>  void f2fs_quota_off_umount(struct super_block *sb);
>  int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover);
>  int f2fs_sync_fs(struct super_block *sb, int sync);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index ae22fb357ac0..9ea16111a19a 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1696,6 +1696,13 @@ static qsize_t *f2fs_get_reserved_space(struct inode *inode)
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
> @@ -1766,7 +1773,14 @@ static int f2fs_enable_quotas(struct super_block *sb)
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
> @@ -1787,7 +1801,7 @@ static int f2fs_enable_quotas(struct super_block *sb)
>  	return 0;
>  }
>  
> -static int f2fs_quota_sync(struct super_block *sb, int type)
> +int f2fs_quota_sync(struct super_block *sb, int type)
>  {
>  	struct quota_info *dqopt = sb_dqopt(sb);
>  	int cnt;
> @@ -1795,7 +1809,7 @@ static int f2fs_quota_sync(struct super_block *sb, int type)
>  
>  	ret = dquot_writeback_dquots(sb, type);
>  	if (ret)
> -		return ret;
> +		goto out;
>  
>  	/*
>  	 * Now when everything is written we can discard the pagecache so
> @@ -1809,13 +1823,16 @@ static int f2fs_quota_sync(struct super_block *sb, int type)
>  
>  		ret = filemap_write_and_wait(dqopt->files[cnt]->i_mapping);
>  		if (ret)
> -			return ret;
> +			goto out;
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
> @@ -1876,6 +1893,61 @@ void f2fs_quota_off_umount(struct super_block *sb)
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
> @@ -1884,11 +1956,11 @@ static int f2fs_get_projid(struct inode *inode, kprojid_t *projid)
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
> @@ -1906,6 +1978,11 @@ static const struct quotactl_ops f2fs_quotactl_ops = {
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
> 

