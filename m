Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4A0C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0085020893
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fu+mC4fw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0085020893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbeHRSnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 14:43:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbeHRSnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 14:43:25 -0400
Received: from localhost (c-67-160-202-76.hsd1.ca.comcast.net [67.160.202.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E863D2175E;
        Sat, 18 Aug 2018 15:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534606519;
        bh=DQd9eCh4ACgvP6Mlg1Xxj4tJ7yOXDrfbiLCBQFkY0tw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fu+mC4fw1Ss0It+ShQk9XXngc9HNZZWnX3hm0vsxVtkH8E0dAxp7qDaeNAQQnn1Hr
         Zukp6+YM9X5TtNDaZCLfhKg0hG+wMjWDEL7qQjPP7oy6GtOdjOVpGswLD473PePHpP
         +Jqfe05iwhtXVP4UjpLAH6LpQpEzWona3fMhe9zA=
Date:   Sat, 18 Aug 2018 08:35:18 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org,
        Weichao Guo <guoweichao@huawei.com>
Subject: Re: [PATCH 2/2] f2fs: guarantee journalled quota data by checkpoint
Message-ID: <20180818153518.GB84798@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180817091840.50792-1-yuchao0@huawei.com>
 <20180817091840.50792-2-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817091840.50792-2-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/17, Chao Yu wrote:
> For journalled quota mode, let checkpoint to flush dquot dirty data
> and quota file data to keep all file quota info are consisting in
> last checkpoint, so that we can avoid quota file being corrupted
> after SPO.

This breaks fault injection + shutdown loop like below.

[736914.430526] WARNING: CPU: 1 PID: 22233 at fs/quota/dquot.c:626 dquot_writeback_dquots+0x27d/0x290
[736914.434605] Modules linked in: f2fs(OE) quota_v2 quota_tree brd sb_edac crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc aesni_intel aes_x86_64 crypto_simd cryptd glue_helper vmw_balloon intel_rapl_perf joydev input_leds serio_raw i2c_piix4 mac_hid vmw_vsock_vmci_transport vsock vmw_vmci ip_tables x_tables autofs4 vmwgfx ttm drm_kms_helper syscopyarea mptspi sysfillrect mptscsih sysimgblt mptbase fb_sys_fops psmouse pata_acpi scsi_transport_spi ahci drm e1000 libahci [last unloaded: f2fs]
[736914.450269] CPU: 1 PID: 22233 Comm: fsstress Tainted: G        W  OE     4.18.0-rc3+ #5
[736914.453262] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 05/19/2017
[736914.457537] RIP: 0010:dquot_writeback_dquots+0x27d/0x290
[736914.459664] Code: 4d 89 7f 08 4c 89 f7 e8 51 17 70 00 8b 54 24 0c e9 e2 fe ff ff 0f 0b e9 7d fe ff ff 0f 0b e9 67 fe ff ff 0f 0b e9 51 fe ff ff <0f> 0b e9 a2 fd ff ff 66 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44
[736914.467064] RSP: 0018:ffffb1f20111bb40 EFLAGS: 00010246
[736914.469132] RAX: 0000000000000000 RBX: ffff8e93f284a000 RCX: 0000000000000000
[736914.471581] RDX: ffffb1f20111bbf0 RSI: 00000000ffffffff RDI: ffff8e93f0674000
[736914.474043] RBP: ffff8e93f0674000 R08: ffffffffc06a9aa0 R09: 0000000000000000
[736914.476470] R10: ffffb1f20111bcc0 R11: 0000000000000000 R12: 00000000ffffffff
[736914.479092] R13: ffff8e93f0674000 R14: 0000000000000001 R15: ffff8e93f0674000
[736914.481765] FS:  00007f2b98aa3b80(0000) GS:ffff8e93f9640000(0000) knlGS:0000000000000000
[736914.484568] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[736914.486713] CR2: 00007f2b98aa2000 CR3: 0000000131c3c001 CR4: 00000000003606e0
[736914.489213] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[736914.491660] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[736914.494085] Call Trace:
[736914.495365]  f2fs_quota_sync+0x1a/0xd0 [f2fs]
[736914.497054]  block_operations+0x94/0x2c0 [f2fs]
[736914.499032]  ? f2fs_write_checkpoint+0x50/0x11e0 [f2fs]
[736914.500897]  ? f2fs_write_checkpoint+0xbb/0x11e0 [f2fs]
[736914.502770]  f2fs_write_checkpoint+0xbb/0x11e0 [f2fs]
[736914.504580]  ? f2fs_sync_fs+0xb0/0x1f0 [f2fs]
[736914.506252]  ? __mutex_lock+0x7f/0xa10
[736914.507710]  ? f2fs_sync_fs+0xb0/0x1f0 [f2fs]
[736914.509333]  ? pagevec_lookup_range_tag+0x24/0x30
[736914.510989]  ? __filemap_fdatawait_range+0x7d/0x150
[736914.512724]  f2fs_sync_fs+0xbd/0x1f0 [f2fs]
[736914.514344]  f2fs_do_sync_file+0x196/0xa30 [f2fs]
[736914.515995]  do_fsync+0x38/0x60
[736914.517289]  __x64_sys_fdatasync+0x13/0x20
[736914.518912]  do_syscall_64+0x60/0x1b0
[736914.520398]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
...
[736920.063443] BUG: unable to handle kernel paging request at ffffffffd9c019eb
[736920.066262] PGD 78414067 P4D 78414067 PUD 78416067 PMD 0 
[736920.068403] Oops: 0000 [#1] SMP PTI
[736920.070055] CPU: 2 PID: 22236 Comm: fsstress Tainted: G        W  OE     4.18.0-rc3+ #5
[736920.072792] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 05/19/2017
[736920.076756] RIP: 0010:do_raw_spin_lock+0x6/0xc0
[736920.078644] Code: 49 89 f9 48 c7 c7 c8 8b ee b3 65 8b 15 13 c0 30 4d e8 2c 00 01 00 e9 5e 50 92 00 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 53 <81> 7f 04 ad 4e ad de 48 89 fb 75 43 65 48 8b 04 25 c0 5d 01 00 48 
[736920.085417] RSP: 0018:ffffb1f20128fbc8 EFLAGS: 00010286
[736920.087505] RAX: ffffffffb2f4a1d3 RBX: ffffffffd9c01927 RCX: 0000000000000000
[736920.090068] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffffffffd9c019e7
[736920.092589] RBP: 0000000000000001 R08: ffffffffb2f4a1d3 R09: 0000000000000000
[736920.095009] R10: ffffb1f20128fb58 R11: 0000000000000000 R12: ffffb1f20128fc58
[736920.097437] R13: ffffffffd9c019e7 R14: 0000000000000000 R15: ffff8e934fe29788
[736920.099823] FS:  00007f2b98aa3b80(0000) GS:ffff8e93f9680000(0000) knlGS:0000000000000000
[736920.102469] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[736920.104569] CR2: ffffffffd9c019eb CR3: 00000001282dc002 CR4: 00000000003606e0
[736920.107140] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[736920.109517] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[736920.111845] Call Trace:
[736920.113111]  dquot_add_inodes+0x23/0x1a0
[736920.114665]  __dquot_transfer+0x3d6/0x5f0
[736920.116233]  ? lock_acquire+0xb4/0x220
[736920.117718]  ? dqput.part.14+0x35/0x200
[736920.119212]  ? online_pages+0x1a0/0x2d0
[736920.120699]  ? dqget+0x424/0x490
[736920.122038]  dquot_transfer+0xce/0x150
[736920.123500]  f2fs_setattr+0xba/0x420 [f2fs]
[736920.125138]  ? current_time+0x4d/0x90
[736920.126676]  notify_change+0x2eb/0x440
[736920.128117]  chown_common+0x1ac/0x1d0
[736920.129670]  do_fchownat+0xc7/0xe0
[736920.131070]  __x64_sys_lchown+0x21/0x30
[736920.132559]  do_syscall_64+0x60/0x1b0
[736920.134011]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[736920.135699] RIP: 0033:0x7f2b97f893a7

> 
> Signed-off-by: Weichao Guo <guoweichao@huawei.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/checkpoint.c | 12 ++++++++
>  fs/f2fs/data.c       |  4 ++-
>  fs/f2fs/f2fs.h       |  2 ++
>  fs/f2fs/super.c      | 67 ++++++++++++++++++++++++++++++++++++++++----
>  4 files changed, 78 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 0274446f585e..cf8d1bb8ec3e 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1100,7 +1100,19 @@ static int block_operations(struct f2fs_sb_info *sbi)
>  	blk_start_plug(&plug);
>  
>  retry_flush_dents:
> +	if (is_sbi_flag_set(sbi, SBI_NEED_FLUSH_QUOTA)) {
> +		clear_sbi_flag(sbi, SBI_NEED_FLUSH_QUOTA);
> +		err = f2fs_quota_sync(sbi->sb, -1);
> +		if (err)
> +			goto out;
> +	}
> +
>  	f2fs_lock_all(sbi);
> +	if (is_sbi_flag_set(sbi, SBI_NEED_FLUSH_QUOTA)) {
> +		f2fs_unlock_all(sbi);
> +		goto retry_flush_dents;
> +	}
> +
>  	/* write all the dirty dentry pages */
>  	if (get_pages(sbi, F2FS_DIRTY_DENTS)) {
>  		f2fs_unlock_all(sbi);
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 8e754710c746..0bfb10cd9ad2 100644
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
> @@ -1721,6 +1721,8 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
>  	}
>  	if (S_ISDIR(inode->i_mode))
>  		return true;
> +	if (IS_NOQUOTA(inode))
> +		return true;
>  	if (f2fs_is_atomic_file(inode))
>  		return true;
>  	if (fio) {
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 54ee8217092e..b7ba5aaeb61e 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1093,6 +1093,7 @@ enum {
>  	SBI_NEED_CP,				/* need to checkpoint */
>  	SBI_IS_SHUTDOWN,			/* shutdown by ioctl */
>  	SBI_CP_DISABLED,			/* CP was disabled last mount */
> +	SBI_NEED_FLUSH_QUOTA,			/* need to flush quota info in CP */
>  };
>  
>  enum {
> @@ -2888,6 +2889,7 @@ static inline int f2fs_add_link(struct dentry *dentry, struct inode *inode)
>  int f2fs_inode_dirtied(struct inode *inode, bool sync);
>  void f2fs_inode_synced(struct inode *inode);
>  int f2fs_enable_quota_files(struct f2fs_sb_info *sbi, bool rdonly);
> +int f2fs_quota_sync(struct super_block *sb, int type);
>  void f2fs_quota_off_umount(struct super_block *sb);
>  int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover);
>  int f2fs_sync_fs(struct super_block *sb, int sync);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 9647bbcdfd2b..f1482363b4eb 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1886,7 +1886,7 @@ static int f2fs_enable_quotas(struct super_block *sb)
>  	return 0;
>  }
>  
> -static int f2fs_quota_sync(struct super_block *sb, int type)
> +int f2fs_quota_sync(struct super_block *sb, int type)
>  {
>  	struct quota_info *dqopt = sb_dqopt(sb);
>  	int cnt;
> @@ -1988,6 +1988,61 @@ void f2fs_quota_off_umount(struct super_block *sb)
>  	}
>  }
>  
> +static int f2fs_dquot_commit(struct dquot *dquot)
> +{
> +	int ret;
> +
> +	ret = dquot_commit(dquot);
> +	if (ret == -ENOSPC || ret == -EIO)
> +		set_sbi_flag(F2FS_SB(dquot->dq_sb), SBI_NEED_FSCK);
> +	return ret;
> +}
> +
> +static int f2fs_dquot_acquire(struct dquot *dquot)
> +{
> +	int ret;
> +
> +	ret = dquot_acquire(dquot);
> +	if (ret == -ENOSPC || ret == -EIO)
> +		set_sbi_flag(F2FS_SB(dquot->dq_sb), SBI_NEED_FSCK);
> +	return ret;
> +}
> +
> +static int f2fs_dquot_release(struct dquot *dquot)
> +{
> +	int ret;
> +
> +	ret = dquot_release(dquot);
> +	if (ret == -ENOSPC || ret == -EIO)
> +		set_sbi_flag(F2FS_SB(dquot->dq_sb), SBI_NEED_FSCK);
> +	return ret;
> +}
> +
> +static int f2fs_dquot_mark_dquot_dirty(struct dquot *dquot)
> +{
> +	struct super_block *sb = dquot->dq_sb;
> +	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> +
> +	/* if we are using journalled quota */
> +	if (f2fs_sb_has_quota_ino(sbi) ||
> +		F2FS_OPTION(sbi).s_qf_names[USRQUOTA] ||
> +		F2FS_OPTION(sbi).s_qf_names[GRPQUOTA] ||
> +		F2FS_OPTION(sbi).s_qf_names[PRJQUOTA])
> +		set_sbi_flag(sbi, SBI_NEED_FLUSH_QUOTA);
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
> +		set_sbi_flag(F2FS_SB(sb), SBI_NEED_FSCK);
> +	return ret;
> +}
> +
>  static int f2fs_get_projid(struct inode *inode, kprojid_t *projid)
>  {
>  	*projid = F2FS_I(inode)->i_projid;
> @@ -1996,11 +2051,11 @@ static int f2fs_get_projid(struct inode *inode, kprojid_t *projid)
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
> -- 
> 2.18.0.rc1
