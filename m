Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C582DC46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 10:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B2121A2D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 10:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PniiL/Ss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B2121A2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbeHLNBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 09:01:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727549AbeHLNBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 09:01:51 -0400
Received: from [192.168.0.101] (unknown [58.212.144.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5BB121943;
        Sun, 12 Aug 2018 10:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534069458;
        bh=aWF/cCh1Q0V9uq0mFrSvZGGftqGlkKZRF4aMxKEm++0=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=PniiL/SsweYddA1UvHPN1MUs47yzqlV39bK+JoWS++lo6rFvFAlo0c9WeHN5kZHQn
         qxtTwp60RFdHvPVg2FdRezmgR/e+xSjtLZX4w9K4FgtSUZJjgrO+LUDMjtAXhoUooi
         pV7esAr3ciT/88zhAxQtbvwuFGYkLCpPe5wbWnWY=
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid fi->i_gc_rwsem[WRITE] lock in
 f2fs_gc
From:   Chao Yu <chao@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20180730013242.15647-1-jaegeuk@kernel.org>
 <f62425be-b378-1e6b-e305-64a61b139dd9@huawei.com>
 <20180730041805.GA20178@jaegeuk-macbookpro.roam.corp.google.com>
 <aa12112e-0ff3-997a-24bd-12db30ad7284@huawei.com>
 <20180730090849.GA22089@jaegeuk-macbookpro.roam.corp.google.com>
 <171084b5-acd5-97fa-205e-202b752baaf0@huawei.com>
 <20180730100039.GA25037@jaegeuk-macbookpro.roam.corp.google.com>
 <5dfbb141-9bd9-f4fe-6250-5ec0baddd0fd@kernel.org>
Message-ID: <d0cbc6bb-9e92-2803-b84d-729c78b21d5b@kernel.org>
Date:   Sun, 12 Aug 2018 18:24:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5dfbb141-9bd9-f4fe-6250-5ec0baddd0fd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/4 10:31, Chao Yu wrote:
> How about keep lock order as:
> 
> - inode_lock
>  - i_mmap_sem
>   - lock_all()
>   - unlock_all()
>   - i_gc_rwsem[WRITE]
>    - lock_op()

I got below warning when testing last dev-test:

- f2fs_direct_IO			current lock dependency
 - i_gc_rwsem[WRITE]
					- i_mmap_sem
  - do_blockdev_direct_IO
   - i_mmap_sem
					 - i_gc_rwsem[WRITE]

So I guess still we should grab i_gc_rwsem[WRITE] lock before i_mmap_sem, any idea?

run fstests generic/208 at 2018-08-12 18:10:39

======================================================
WARNING: possible circular locking dependency detected
4.18.0-rc2+ #39 Tainted: G           O
------------------------------------------------------
aio-dio-invalid/20621 is trying to acquire lock:
e47a5a00 (&mm->mmap_sem){++++}, at: get_user_pages_unlocked+0x38/0x1d0

but task is already holding lock:
82073b2b (&fi->i_gc_rwsem[WRITE]){++++}, at: f2fs_direct_IO+0x16c/0x590 [f2fs]

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&fi->i_gc_rwsem[WRITE]){++++}:
       lock_acquire+0xae/0x220
       down_write+0x38/0x60
       f2fs_setattr+0x187/0x5b0 [f2fs]
       notify_change+0x22b/0x400
       do_truncate+0x5c/0x90
       path_openat+0xaf5/0x1370
       do_filp_open+0x5c/0xb0
       do_sys_open+0xf8/0x1d0
       sys_open+0x22/0x30
       do_fast_syscall_32+0xaa/0x22c
       entry_SYSENTER_32+0x53/0x86

-> #1 (&fi->i_mmap_sem){++++}:
       lock_acquire+0xae/0x220
       down_read+0x38/0x60
       f2fs_filemap_fault+0x21/0x40 [f2fs]
       __do_fault+0x16/0x30
       handle_mm_fault+0xa37/0x10c0
       __do_page_fault+0x19f/0x530
       do_page_fault+0x20/0x280
       common_exception+0x89/0x8e

-> #0 (&mm->mmap_sem){++++}:
       __lock_acquire+0xe89/0x10e0
       lock_acquire+0xae/0x220
       down_read+0x38/0x60
       get_user_pages_unlocked+0x38/0x1d0
       get_user_pages_fast+0x70/0xe1
       iov_iter_get_pages+0x94/0x250
       do_blockdev_direct_IO+0x2191/0x25a0
       __blockdev_direct_IO+0x4a/0x50
       f2fs_direct_IO+0x332/0x590 [f2fs]
       generic_file_direct_write+0xe9/0x2c0
       __generic_file_write_iter+0x9a/0x1f0
       f2fs_file_write_iter+0xdd/0x3b0 [f2fs]
       aio_write.isra.20+0xe0/0x190
       sys_io_submit+0x464/0x650
       do_int80_syscall_32+0x6c/0x190
       restore_all+0x0/0x6a

other info that might help us debug this:

Chain exists of:
  &mm->mmap_sem --> &fi->i_mmap_sem --> &fi->i_gc_rwsem[WRITE]

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&fi->i_gc_rwsem[WRITE]);
                               lock(&fi->i_mmap_sem);
                               lock(&fi->i_gc_rwsem[WRITE]);
  lock(&mm->mmap_sem);

 *** DEADLOCK ***

2 locks held by aio-dio-invalid/20621:
 #0: ca54a0ec (&sb->s_type->i_mutex_key#17){+.+.}, at:
f2fs_file_write_iter+0x6f/0x3b0 [f2fs]
 #1: 82073b2b (&fi->i_gc_rwsem[WRITE]){++++}, at: f2fs_direct_IO+0x16c/0x590 [f2fs]

stack backtrace:
CPU: 1 PID: 20621 Comm: aio-dio-invalid Tainted: G           O      4.18.0-rc2+ #39
Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
Call Trace:
 dump_stack+0x5f/0x86
 print_circular_bug.isra.35+0x1b6/0x1c0
 check_prev_add.constprop.44+0x67a/0x6a0
 __lock_acquire+0xe89/0x10e0
 lock_acquire+0xae/0x220
 ? get_user_pages_unlocked+0x38/0x1d0
 down_read+0x38/0x60
 ? get_user_pages_unlocked+0x38/0x1d0
 get_user_pages_unlocked+0x38/0x1d0
 ? mark_held_locks+0x5d/0x80
 ? get_user_pages_fast+0xb7/0xe1
 ? trace_hardirqs_on_caller+0xdd/0x1c0
 get_user_pages_fast+0x70/0xe1
 iov_iter_get_pages+0x94/0x250
 ? lockdep_init_map+0x12/0x20
 ? __raw_spin_lock_init+0x31/0x60
 do_blockdev_direct_IO+0x2191/0x25a0
 ? __blockdev_direct_IO+0x4a/0x50
 ? __this_cpu_preempt_check+0xf/0x20
 ? free_unref_page_list+0x1c7/0x2a0
 ? trace_hardirqs_on_caller+0xdd/0x1c0
 ? __get_data_block+0xc0/0xc0 [f2fs]
 __blockdev_direct_IO+0x4a/0x50
 ? __get_data_block+0xc0/0xc0 [f2fs]
 f2fs_direct_IO+0x332/0x590 [f2fs]
 ? __get_data_block+0xc0/0xc0 [f2fs]
 generic_file_direct_write+0xe9/0x2c0
 __generic_file_write_iter+0x9a/0x1f0
 f2fs_file_write_iter+0xdd/0x3b0 [f2fs]
 aio_write.isra.20+0xe0/0x190
 ? sys_io_submit+0x1ab/0x650
 sys_io_submit+0x464/0x650
 ? sys_io_submit+0x13a/0x650
 do_int80_syscall_32+0x6c/0x190
 entry_INT80_32+0x36/0x36


> 
> Thanks,
> 
>>
>> From f6341121ee0c07fa834960a7c86cb0ea3f824231 Mon Sep 17 00:00:00 2001
>> From: Jaegeuk Kim <jaegeuk@kernel.org>
>> Date: Wed, 25 Jul 2018 12:11:56 +0900
>> Subject: [PATCH] f2fs: avoid fi->i_gc_rwsem[WRITE] lock in f2fs_gc
>>
>> The f2fs_gc() called by f2fs_balance_fs() requires to be called outside of
>> fi->i_gc_rwsem[WRITE], since f2fs_gc() can try to grab it in a loop.
>>
>> If it hits the miximum retrials in GC, let's give a chance to release
>> gc_mutex for a short time in order not to go into live lock in the worst
>> case.
>>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> ---
>> v2:
>>  - add rwsem on start_atomic_write
>>
>>  fs/f2fs/f2fs.h    |  1 +
>>  fs/f2fs/file.c    | 71 ++++++++++++++++++++++++-----------------------
>>  fs/f2fs/gc.c      | 22 +++++++++++----
>>  fs/f2fs/segment.c |  5 +++-
>>  fs/f2fs/segment.h |  2 +-
>>  5 files changed, 58 insertions(+), 43 deletions(-)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index a9447c7d6570..50349780001b 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -1223,6 +1223,7 @@ struct f2fs_sb_info {
>>  	unsigned int gc_mode;			/* current GC state */
>>  	/* for skip statistic */
>>  	unsigned long long skipped_atomic_files[2];	/* FG_GC and BG_GC */
>> +	unsigned long long skipped_gc_rwsem;		/* FG_GC only */
>>  
>>  	/* threshold for gc trials on pinned files */
>>  	u64 gc_pin_file_threshold;
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 78c1bd6b8497..a960869bf60f 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -1179,10 +1179,12 @@ static int __exchange_data_block(struct inode *src_inode,
>>  	return ret;
>>  }
>>  
>> -static int f2fs_do_collapse(struct inode *inode, pgoff_t start, pgoff_t end)
>> +static int f2fs_do_collapse(struct inode *inode, loff_t offset, loff_t len)
>>  {
>>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>  	pgoff_t nrpages = (i_size_read(inode) + PAGE_SIZE - 1) / PAGE_SIZE;
>> +	pgoff_t start = offset >> PAGE_SHIFT;
>> +	pgoff_t end = (offset + len) >> PAGE_SHIFT;
>>  	int ret;
>>  
>>  	f2fs_balance_fs(sbi, true);
>> @@ -1190,14 +1192,18 @@ static int f2fs_do_collapse(struct inode *inode, pgoff_t start, pgoff_t end)
>>  
>>  	f2fs_drop_extent_tree(inode);
>>  
>> +	/* avoid gc operation during block exchange */
>> +	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>> +	truncate_pagecache(inode, offset);
>>  	ret = __exchange_data_block(inode, inode, end, start, nrpages - end, true);
>> +	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>> +
>>  	f2fs_unlock_op(sbi);
>>  	return ret;
>>  }
>>  
>>  static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
>>  {
>> -	pgoff_t pg_start, pg_end;
>>  	loff_t new_size;
>>  	int ret;
>>  
>> @@ -1212,21 +1218,13 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
>>  	if (ret)
>>  		return ret;
>>  
>> -	pg_start = offset >> PAGE_SHIFT;
>> -	pg_end = (offset + len) >> PAGE_SHIFT;
>> -
>> -	/* avoid gc operation during block exchange */
>> -	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>> -
>>  	down_write(&F2FS_I(inode)->i_mmap_sem);
>>  	/* write out all dirty pages from offset */
>>  	ret = filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
>>  	if (ret)
>>  		goto out_unlock;
>>  
>> -	truncate_pagecache(inode, offset);
>> -
>> -	ret = f2fs_do_collapse(inode, pg_start, pg_end);
>> +	ret = f2fs_do_collapse(inode, offset, len);
>>  	if (ret)
>>  		goto out_unlock;
>>  
>> @@ -1242,7 +1240,6 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
>>  		f2fs_i_size_write(inode, new_size);
>>  out_unlock:
>>  	up_write(&F2FS_I(inode)->i_mmap_sem);
>> -	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>>  	return ret;
>>  }
>>  
>> @@ -1417,9 +1414,6 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
>>  
>>  	f2fs_balance_fs(sbi, true);
>>  
>> -	/* avoid gc operation during block exchange */
>> -	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>> -
>>  	down_write(&F2FS_I(inode)->i_mmap_sem);
>>  	ret = f2fs_truncate_blocks(inode, i_size_read(inode), true);
>>  	if (ret)
>> @@ -1430,13 +1424,15 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
>>  	if (ret)
>>  		goto out;
>>  
>> -	truncate_pagecache(inode, offset);
>> -
>>  	pg_start = offset >> PAGE_SHIFT;
>>  	pg_end = (offset + len) >> PAGE_SHIFT;
>>  	delta = pg_end - pg_start;
>>  	idx = (i_size_read(inode) + PAGE_SIZE - 1) / PAGE_SIZE;
>>  
>> +	/* avoid gc operation during block exchange */
>> +	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>> +	truncate_pagecache(inode, offset);
>> +
>>  	while (!ret && idx > pg_start) {
>>  		nr = idx - pg_start;
>>  		if (nr > delta)
>> @@ -1450,6 +1446,7 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
>>  					idx + delta, nr, false);
>>  		f2fs_unlock_op(sbi);
>>  	}
>> +	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>>  
>>  	/* write out all moved pages, if possible */
>>  	filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
>> @@ -1459,7 +1456,6 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
>>  		f2fs_i_size_write(inode, new_size);
>>  out:
>>  	up_write(&F2FS_I(inode)->i_mmap_sem);
>> -	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>>  	return ret;
>>  }
>>  
>> @@ -1706,8 +1702,6 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
>>  
>>  	inode_lock(inode);
>>  
>> -	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>> -
>>  	if (f2fs_is_atomic_file(inode)) {
>>  		if (is_inode_flag_set(inode, FI_ATOMIC_REVOKE_REQUEST))
>>  			ret = -EINVAL;
>> @@ -1718,6 +1712,8 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
>>  	if (ret)
>>  		goto out;
>>  
>> +	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>> +
>>  	if (!get_dirty_pages(inode))
>>  		goto skip_flush;
>>  
>> @@ -1725,18 +1721,20 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
>>  		"Unexpected flush for atomic writes: ino=%lu, npages=%u",
>>  					inode->i_ino, get_dirty_pages(inode));
>>  	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
>> -	if (ret)
>> +	if (ret) {
>> +		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>>  		goto out;
>> +	}
>>  skip_flush:
>>  	set_inode_flag(inode, FI_ATOMIC_FILE);
>>  	clear_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
>> -	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
>> +	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>>  
>> +	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
>>  	F2FS_I(inode)->inmem_task = current;
>>  	stat_inc_atomic_write(inode);
>>  	stat_update_max_atomic_write(inode);
>>  out:
>> -	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>>  	inode_unlock(inode);
>>  	mnt_drop_write_file(filp);
>>  	return ret;
>> @@ -1754,9 +1752,9 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
>>  	if (ret)
>>  		return ret;
>>  
>> -	inode_lock(inode);
>> +	f2fs_balance_fs(F2FS_I_SB(inode), true);
>>  
>> -	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>> +	inode_lock(inode);
>>  
>>  	if (f2fs_is_volatile_file(inode)) {
>>  		ret = -EINVAL;
>> @@ -1782,7 +1780,6 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
>>  		clear_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
>>  		ret = -EINVAL;
>>  	}
>> -	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>>  	inode_unlock(inode);
>>  	mnt_drop_write_file(filp);
>>  	return ret;
>> @@ -2378,15 +2375,10 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
>>  	}
>>  
>>  	inode_lock(src);
>> -	down_write(&F2FS_I(src)->i_gc_rwsem[WRITE]);
>>  	if (src != dst) {
>>  		ret = -EBUSY;
>>  		if (!inode_trylock(dst))
>>  			goto out;
>> -		if (!down_write_trylock(&F2FS_I(dst)->i_gc_rwsem[WRITE])) {
>> -			inode_unlock(dst);
>> -			goto out;
>> -		}
>>  	}
>>  
>>  	ret = -EINVAL;
>> @@ -2432,6 +2424,14 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
>>  
>>  	f2fs_balance_fs(sbi, true);
>>  	f2fs_lock_op(sbi);
>> +
>> +	down_write(&F2FS_I(src)->i_gc_rwsem[WRITE]);
>> +	if (src != dst) {
>> +		ret = -EBUSY;
>> +		if (!down_write_trylock(&F2FS_I(dst)->i_gc_rwsem[WRITE]))
>> +			goto out_src;
>> +	}
>> +
>>  	ret = __exchange_data_block(src, dst, pos_in >> F2FS_BLKSIZE_BITS,
>>  				pos_out >> F2FS_BLKSIZE_BITS,
>>  				len >> F2FS_BLKSIZE_BITS, false);
>> @@ -2442,14 +2442,15 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
>>  		else if (dst_osize != dst->i_size)
>>  			f2fs_i_size_write(dst, dst_osize);
>>  	}
>> +	if (src != dst)
>> +		up_write(&F2FS_I(dst)->i_gc_rwsem[WRITE]);
>> +out_src:
>> +	up_write(&F2FS_I(src)->i_gc_rwsem[WRITE]);
>>  	f2fs_unlock_op(sbi);
>>  out_unlock:
>> -	if (src != dst) {
>> -		up_write(&F2FS_I(dst)->i_gc_rwsem[WRITE]);
>> +	if (src != dst)
>>  		inode_unlock(dst);
>> -	}
>>  out:
>> -	up_write(&F2FS_I(src)->i_gc_rwsem[WRITE]);
>>  	inode_unlock(src);
>>  	return ret;
>>  }
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index e352fbd33848..cac317e37306 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -884,6 +884,7 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>>  			if (!down_write_trylock(
>>  				&F2FS_I(inode)->i_gc_rwsem[WRITE])) {
>>  				iput(inode);
>> +				sbi->skipped_gc_rwsem++;
>>  				continue;
>>  			}
>>  
>> @@ -913,6 +914,7 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>>  					continue;
>>  				if (!down_write_trylock(
>>  						&fi->i_gc_rwsem[WRITE])) {
>> +					sbi->skipped_gc_rwsem++;
>>  					up_write(&fi->i_gc_rwsem[READ]);
>>  					continue;
>>  				}
>> @@ -1062,6 +1064,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>>  				prefree_segments(sbi));
>>  
>>  	cpc.reason = __get_cp_reason(sbi);
>> +	sbi->skipped_gc_rwsem = 0;
>>  gc_more:
>>  	if (unlikely(!(sbi->sb->s_flags & SB_ACTIVE))) {
>>  		ret = -EINVAL;
>> @@ -1103,7 +1106,8 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>>  	total_freed += seg_freed;
>>  
>>  	if (gc_type == FG_GC) {
>> -		if (sbi->skipped_atomic_files[FG_GC] > last_skipped)
>> +		if (sbi->skipped_atomic_files[FG_GC] > last_skipped ||
>> +						sbi->skipped_gc_rwsem)
>>  			skipped_round++;
>>  		last_skipped = sbi->skipped_atomic_files[FG_GC];
>>  		round++;
>> @@ -1112,15 +1116,21 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
>>  	if (gc_type == FG_GC)
>>  		sbi->cur_victim_sec = NULL_SEGNO;
>>  
>> -	if (!sync) {
>> -		if (has_not_enough_free_secs(sbi, sec_freed, 0)) {
>> -			if (skipped_round > MAX_SKIP_ATOMIC_COUNT &&
>> -				skipped_round * 2 >= round)
>> -				f2fs_drop_inmem_pages_all(sbi, true);
>> +	if (sync)
>> +		goto stop;
>> +
>> +	if (has_not_enough_free_secs(sbi, sec_freed, 0)) {
>> +		if (skipped_round <= MAX_SKIP_GC_COUNT ||
>> +					skipped_round * 2 < round) {
>>  			segno = NULL_SEGNO;
>>  			goto gc_more;
>>  		}
>>  
>> +		if (sbi->skipped_atomic_files[FG_GC] == last_skipped) {
>> +			f2fs_drop_inmem_pages_all(sbi, true);
>> +			segno = NULL_SEGNO;
>> +			goto gc_more;
>> +		}
>>  		if (gc_type == FG_GC)
>>  			ret = f2fs_write_checkpoint(sbi, &cpc);
>>  	}
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 3662e1f429b4..15b3b095fd58 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -444,10 +444,12 @@ int f2fs_commit_inmem_pages(struct inode *inode)
>>  	struct f2fs_inode_info *fi = F2FS_I(inode);
>>  	int err;
>>  
>> -	f2fs_balance_fs(sbi, true);
>> +	f2fs_balance_fs(F2FS_I_SB(inode), true);
>> +
>>  	f2fs_lock_op(sbi);
>>  
>>  	set_inode_flag(inode, FI_ATOMIC_COMMIT);
>> +	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>>  
>>  	mutex_lock(&fi->inmem_lock);
>>  	err = __f2fs_commit_inmem_pages(inode);
>> @@ -458,6 +460,7 @@ int f2fs_commit_inmem_pages(struct inode *inode)
>>  	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
>>  	mutex_unlock(&fi->inmem_lock);
>>  
>> +	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>>  	clear_inode_flag(inode, FI_ATOMIC_COMMIT);
>>  
>>  	f2fs_unlock_op(sbi);
>> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
>> index 50495515f0a0..b3d9e317ff0c 100644
>> --- a/fs/f2fs/segment.h
>> +++ b/fs/f2fs/segment.h
>> @@ -215,7 +215,7 @@ struct segment_allocation {
>>  #define IS_DUMMY_WRITTEN_PAGE(page)			\
>>  		(page_private(page) == (unsigned long)DUMMY_WRITTEN_PAGE)
>>  
>> -#define MAX_SKIP_ATOMIC_COUNT			16
>> +#define MAX_SKIP_GC_COUNT			16
>>  
>>  struct inmem_pages {
>>  	struct list_head list;
>>
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
