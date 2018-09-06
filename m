Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF16C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 03:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAAF920659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 03:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAAF920659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbeIFHrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 03:47:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49871 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725981AbeIFHrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 03:47:12 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A33E9EADFAA35;
        Thu,  6 Sep 2018 11:13:58 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.399.0; Thu, 6 Sep 2018
 11:13:58 +0800
Subject: Re: [PATCH v4] f2fs: fix to flush all dirty inodes recovered in
 readonly fs
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20180822091105.33973-1-yuchao0@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <6a980c80-58b0-f3b4-39f5-f4ab1795993d@huawei.com>
Date:   Thu, 6 Sep 2018 11:13:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180822091105.33973-1-yuchao0@huawei.com>
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

On 2018/8/22 17:11, Chao Yu wrote:
> generic/417 reported as blow:
> 
> ------------[ cut here ]------------
> kernel BUG at /home/yuchao/git/devf2fs/inode.c:695!
> invalid opcode: 0000 [#1] PREEMPT SMP
> CPU: 1 PID: 21697 Comm: umount Tainted: G        W  O      4.18.0-rc2+ #39
> Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
> EIP: f2fs_evict_inode+0x556/0x580 [f2fs]
> Call Trace:
>  ? _raw_spin_unlock+0x2c/0x50
>  evict+0xa8/0x170
>  dispose_list+0x34/0x40
>  evict_inodes+0x118/0x120
>  generic_shutdown_super+0x41/0x100
>  ? rcu_read_lock_sched_held+0x97/0xa0
>  kill_block_super+0x22/0x50
>  kill_f2fs_super+0x6f/0x80 [f2fs]
>  deactivate_locked_super+0x3d/0x70
>  deactivate_super+0x40/0x60
>  cleanup_mnt+0x39/0x70
>  __cleanup_mnt+0x10/0x20
>  task_work_run+0x81/0xa0
>  exit_to_usermode_loop+0x59/0xa7
>  do_fast_syscall_32+0x1f5/0x22c
>  entry_SYSENTER_32+0x53/0x86
> EIP: f2fs_evict_inode+0x556/0x580 [f2fs]
> 
> It can simply reproduced with scripts:
> 
> Enable quota feature during mkfs.
> 
> Testcase1:
> 1. mkfs.f2fs /dev/zram0
> 2. mount -t f2fs /dev/zram0 /mnt/f2fs
> 3. xfs_io -f /mnt/f2fs/file -c "pwrite 0 4k" -c "fsync"
> 4. godown /mnt/f2fs
> 5. umount /mnt/f2fs
> 6. mount -t f2fs -o ro /dev/zram0 /mnt/f2fs
> 7. umount /mnt/f2fs
> 
> Testcase2:
> 1. mkfs.f2fs /dev/zram0
> 2. mount -t f2fs /dev/zram0 /mnt/f2fs
> 3. touch /mnt/f2fs/file
> 4. create process[pid = x] do:
> 	a) open /mnt/f2fs/file;
> 	b) unlink /mnt/f2fs/file
> 5. godown -f /mnt/f2fs
> 6. kill process[pid = x]
> 7. umount /mnt/f2fs
> 8. mount -t f2fs -o ro /dev/zram0 /mnt/f2fs
> 9. umount /mnt/f2fs
> 
> The reason is: during recovery, i_{c,m}time of inode will be updated, then
> the inode can be set dirty w/o being tracked in sbi->inode_list[DIRTY_META]
> global list, so later write_checkpoint will not flush such dirty inode into
> node page.
> 
> Once umount is called, sync_filesystem() in generic_shutdown_super() will
> skip syncng dirty inodes due to sb_rdonly check, leaving dirty inodes
> there.
> 
> To solve this issue, during umount, add remove SB_RDONLY flag in
> sb->s_flags, to make sure sync_filesystem() will not be skipped.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> v4:
> - fix to use set_sbi_flag.
> - clean up with f2fs_readonly.
>  fs/f2fs/checkpoint.c |  2 ++
>  fs/f2fs/f2fs.h       |  1 +
>  fs/f2fs/recovery.c   | 14 +++++++++-----
>  fs/f2fs/super.c      |  3 +++
>  4 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 0274446f585e..5f61e9b8c678 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -696,6 +696,8 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
>  	/* clear Orphan Flag */
>  	clear_ckpt_flags(sbi, CP_ORPHAN_PRESENT_FLAG);
>  out:
> +	set_sbi_flag(sbi, SBI_IS_RECOVERED);
> +
>  #ifdef CONFIG_QUOTA
>  	/* Turn quotas off */
>  	if (quota_enabled)
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index e100af9afe38..e9009e8d30e2 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1091,6 +1091,7 @@ enum {
>  	SBI_NEED_SB_WRITE,			/* need to recover superblock */
>  	SBI_NEED_CP,				/* need to checkpoint */
>  	SBI_IS_SHUTDOWN,			/* shutdown by ioctl */
> +	SBI_IS_RECOVERED,			/* recovered orphan/data */
>  };
>  
>  enum {
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index 95511ed11a22..e3aa6eee7a8b 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -697,11 +697,15 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
>  	/* let's drop all the directory inodes for clean checkpoint */
>  	destroy_fsync_dnodes(&dir_list);
>  
> -	if (!err && need_writecp) {
> -		struct cp_control cpc = {
> -			.reason = CP_RECOVERY,
> -		};
> -		err = f2fs_write_checkpoint(sbi, &cpc);
> +	if (need_writecp) {
> +		set_sbi_flag(sbi, SBI_IS_RECOVERED);
> +
> +		if (!err) {
> +			struct cp_control cpc = {
> +				.reason = CP_RECOVERY,
> +			};
> +			err = f2fs_write_checkpoint(sbi, &cpc);
> +		}
>  	}
>  
>  	kmem_cache_destroy(fsync_entry_slab);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index ab9e0921f207..9587e57f8d93 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3215,6 +3215,9 @@ static void kill_f2fs_super(struct super_block *sb)
>  			};
>  			f2fs_write_checkpoint(sbi, &cpc);
>  		}
> +
> +		if (is_sbi_flag_set(sbi, SBI_IS_RECOVERED) && f2fs_readonly(sb))
> +			sb->s_flags &= ~SB_RDONLY;
>  	}
>  	kill_block_super(sb);
>  }
> 

