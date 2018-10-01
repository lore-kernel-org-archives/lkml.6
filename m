Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B382EC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 01:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6536B20840
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 01:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxclRteh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6536B20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbeJAINI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 04:13:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbeJAINI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 04:13:08 -0400
Received: from [192.168.0.101] (unknown [121.237.253.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E4362083C;
        Mon,  1 Oct 2018 01:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538357867;
        bh=katPvRt4mRPeCvxXprsrMKHiOIN9GTCt2Dz9M9jpk1Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UxclRteh1MzUMARgRTX73YsPK3c6C+6/5wks0LJt3+ozQCrKiM6TssqG5Wb5k3JcM
         VPgUIgCOwlJCSa7plqfFZLkyZEcSLBrEWw6gX+g6ILIQrAtRwCDempIm24s15pbjw7
         DnbuNMzaG1kFB1EykKf4I1n1uhE+uHIUsG7fww6I=
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix quota info to adjust recovered data
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <b45beb50-c814-5fb4-63da-060871e33553@huawei.com>
 <20180926014418.GE3829@jaegeuk-macbookpro.roam.corp.google.com>
 <e1e855e5-2aaf-6560-d69d-2b7b0f60404e@huawei.com>
 <20180926020921.GG3829@jaegeuk-macbookpro.roam.corp.google.com>
 <d4279226-ca5c-8905-f6e9-c660c3aad6a0@huawei.com>
 <20180928173721.GB64391@jaegeuk-macbookpro.roam.corp.google.com>
 <20180928234025.GA94043@jaegeuk-macbookpro.roam.corp.google.com>
 <2c6db622-ef6d-c3c7-cf54-4dd708bd54e3@huawei.com>
 <20180930235827.GB17407@jaegeuk-macbookpro.roam.corp.google.com>
 <227e112e-a462-6803-5c41-dad47569a55b@kernel.org>
 <20181001012734.GE17407@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <ce333f2e-b6ef-18cf-3ca4-e4c30829071c@kernel.org>
Date:   Mon, 1 Oct 2018 09:37:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181001012734.GE17407@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-1 9:27, Jaegeuk Kim wrote:
> On 10/01, Chao Yu wrote:
>> On 2018-10-1 7:58, Jaegeuk Kim wrote:
>>> On 09/29, Chao Yu wrote:
>>>> On 2018/9/29 7:40, Jaegeuk Kim wrote:
>>>>> Testing other fix.
>>>>>
>>>>> ---
>>>>>  fs/f2fs/checkpoint.c |  7 +++++++
>>>>>  fs/f2fs/f2fs.h       |  1 +
>>>>>  fs/f2fs/gc.c         | 10 +++++++++-
>>>>>  fs/f2fs/super.c      | 22 +++++++++++++++++++++-
>>>>>  4 files changed, 38 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>>>> index 524b87667cf4..3fde91f41a91 100644
>>>>> --- a/fs/f2fs/checkpoint.c
>>>>> +++ b/fs/f2fs/checkpoint.c
>>>>> @@ -1494,6 +1494,7 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>>>  {
>>>>>  	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
>>>>>  	unsigned long long ckpt_ver;
>>>>> +	bool need_up = false;
>>>>>  	int err = 0;
>>>>>  
>>>>>  	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
>>>>> @@ -1506,6 +1507,10 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>>>  		f2fs_msg(sbi->sb, KERN_WARNING,
>>>>>  				"Start checkpoint disabled!");
>>>>>  	}
>>>>> +	if (!is_sbi_flag_set(sbi, SBI_QUOTA_INIT)) {
>>>>> +		need_up = true;
>>>>> +		down_read(&sbi->sb->s_umount);
>>>>
>>>> This is to avoid show warning when calling dquot_writeback_dquots() in
>>>> f2fs_quota_sync(), right?
>>>
>>> Yup. Unfortunately, this can't fix all the issues, so I'm testing trylock
>>> simply in this case.
>>
>> Oh, that's just warning, it could not be harmful, I think we can simply remove
>> WARN_ON_ONCE in dquot_writeback_dquots to fix this?
> 
> Well, I think it'd be better to keep it.

We'd better to ask suggestion from maintainer of quota subsystem?

Thanks,

> 
>>
>>>
>>>>
>>>>> +	}
>>>>>  	mutex_lock(&sbi->cp_mutex);
>>>>>  
>>>>>  	if (!is_sbi_flag_set(sbi, SBI_IS_DIRTY) &&
>>>>> @@ -1582,6 +1587,8 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>>>  	trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, "finish checkpoint");
>>>>>  out:
>>>>>  	mutex_unlock(&sbi->cp_mutex);
>>>>> +	if (need_up)
>>>>> +		up_read(&sbi->sb->s_umount);
>>>>>  	return err;
>>>>>  }
>>>>>  
>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>>> index 57c829dd107e..30194f2f108e 100644
>>>>> --- a/fs/f2fs/f2fs.h
>>>>> +++ b/fs/f2fs/f2fs.h
>>>>> @@ -1096,6 +1096,7 @@ enum {
>>>>>  	SBI_IS_SHUTDOWN,			/* shutdown by ioctl */
>>>>>  	SBI_IS_RECOVERED,			/* recovered orphan/data */
>>>>>  	SBI_CP_DISABLED,			/* CP was disabled last mount */
>>>>> +	SBI_QUOTA_INIT,				/* avoid sb->s_umount lock */
>>>>>  	SBI_QUOTA_NEED_FLUSH,			/* need to flush quota info in CP */
>>>>>  	SBI_QUOTA_SKIP_FLUSH,			/* skip flushing quota in current CP */
>>>>>  	SBI_QUOTA_NEED_REPAIR,			/* quota file may be corrupted */
>>>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>>>> index adaf5a695b12..deece448cb3b 100644
>>>>> --- a/fs/f2fs/gc.c
>>>>> +++ b/fs/f2fs/gc.c
>>>>> @@ -55,9 +55,14 @@ static int gc_thread_func(void *data)
>>>>>  			f2fs_stop_checkpoint(sbi, false);
>>>>>  		}
>>>>>  
>>>>> -		if (!sb_start_write_trylock(sbi->sb))
>>>>> +		if (!down_read_trylock(&sbi->sb->s_umount))
>>>>>  			continue;
>>>>>  
>>>>> +		set_sbi_flag(sbi, SBI_QUOTA_INIT);
>>>>> +
>>>>> +		if (!sb_start_write_trylock(sbi->sb))
>>>>> +			goto next_umount;
>>>>> +
>>>>>  		/*
>>>>>  		 * [GC triggering condition]
>>>>>  		 * 0. GC is not conducted currently.
>>>>> @@ -104,6 +109,9 @@ static int gc_thread_func(void *data)
>>>>>  		f2fs_balance_fs_bg(sbi);
>>>>>  next:
>>>>>  		sb_end_write(sbi->sb);
>>>>> +next_umount:
>>>>> +		clear_sbi_flag(sbi, SBI_QUOTA_INIT);
>>>>> +		up_read(&sbi->sb->s_umount);
>>>>>  
>>>>>  	} while (!kthread_should_stop());
>>>>>  	return 0;
>>>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>>>> index a28c245b1288..40a77a4eb465 100644
>>>>> --- a/fs/f2fs/super.c
>>>>> +++ b/fs/f2fs/super.c
>>>>> @@ -1029,6 +1029,8 @@ static void f2fs_put_super(struct super_block *sb)
>>>>>  	int i;
>>>>>  	bool dropped;
>>>>>  
>>>>> +	set_sbi_flag(sbi, SBI_QUOTA_INIT);
>>>>> +
>>>>>  	f2fs_quota_off_umount(sb);
>>>>>  
>>>>>  	/* prevent remaining shrinker jobs */
>>>>> @@ -1122,11 +1124,17 @@ int f2fs_sync_fs(struct super_block *sb, int sync)
>>>>>  
>>>>>  	if (sync) {
>>>>>  		struct cp_control cpc;
>>>>> +		bool keep = is_sbi_flag_set(sbi, SBI_QUOTA_INIT);
>>>>>  
>>>>>  		cpc.reason = __get_cp_reason(sbi);
>>>>>  
>>>>>  		mutex_lock(&sbi->gc_mutex);
>>>>> +		if (sbi->sb->s_writers.frozen >= SB_FREEZE_WRITE)
>>>>> +			set_sbi_flag(sbi, SBI_QUOTA_INIT);
>>>>> +
>>>>>  		err = f2fs_write_checkpoint(sbi, &cpc);
>>>>> +		if (!keep)
>>>>> +			clear_sbi_flag(sbi, SBI_QUOTA_INIT);
>>>>>  		mutex_unlock(&sbi->gc_mutex);
>>>>>  	}
>>>>>  	f2fs_trace_ios(NULL, 1);
>>>>> @@ -1534,6 +1542,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>>>>>  		}
>>>>>  	}
>>>>>  #endif
>>>>> +	set_sbi_flag(sbi, SBI_QUOTA_INIT);
>>>>>  
>>>>>  	/* recover superblocks we couldn't write due to previous RO mount */
>>>>>  	if (!(*flags & SB_RDONLY) && is_sbi_flag_set(sbi, SBI_NEED_SB_WRITE)) {
>>>>> @@ -1653,6 +1662,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>>>>>  		(test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
>>>>>  
>>>>>  	limit_reserve_root(sbi);
>>>>> +	clear_sbi_flag(sbi, SBI_QUOTA_INIT);
>>>>>  	*flags = (*flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
>>>>>  	return 0;
>>>>>  restore_gc:
>>>>> @@ -1673,6 +1683,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>>>>>  #endif
>>>>>  	sbi->mount_opt = org_mount_opt;
>>>>>  	sb->s_flags = old_sb_flags;
>>>>> +	clear_sbi_flag(sbi, SBI_QUOTA_INIT);
>>>>>  	return err;
>>>>>  }
>>>>>  
>>>>> @@ -1706,6 +1717,7 @@ static ssize_t f2fs_quota_read(struct super_block *sb, int type, char *data,
>>>>>  				congestion_wait(BLK_RW_ASYNC, HZ/50);
>>>>>  				goto repeat;
>>>>>  			}
>>>>> +			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
>>>>>  			return PTR_ERR(page);
>>>>>  		}
>>>>>  
>>>>> @@ -1717,6 +1729,7 @@ static ssize_t f2fs_quota_read(struct super_block *sb, int type, char *data,
>>>>>  		}
>>>>>  		if (unlikely(!PageUptodate(page))) {
>>>>>  			f2fs_put_page(page, 1);
>>>>> +			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
>>>>>  			return -EIO;
>>>>>  		}
>>>>>  
>>>>> @@ -1758,6 +1771,7 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
>>>>>  				congestion_wait(BLK_RW_ASYNC, HZ/50);
>>>>>  				goto retry;
>>>>>  			}
>>>>> +			set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_NEED_REPAIR);
>>>>>  			break;
>>>>
>>>> I added these before, but later I didn't encounter quota corruption w/o
>>>> them, so I removed them.
>>>>
>>>> Do you still hit corruption after this change?
>>>
>>> I found one issue where we must avoid roll-forward recovery, if fsck overwrote some
>>> blocks to fix quota which will be used for recovery.
>>
>> That's correct, IMO, the right way is that fsck needs to be aware of whole dnode
>> chain and block address in dnode block, when doing allocation, it needs to
>> bypass those block address of dnode and block which can be recovered later by
>> kernel, so that fsynced data can not be lost.
>>
>> But, in order to trouble shoot current problem more quickly, we can just disable
>> kernel recovery once fsck recovers quota file for now.
>>
>> Thanks,
>>
>>>
>>>>
>>>> Thanks,
>>>>
>>>>>  		}
>>>>>  
>>>>> @@ -1794,7 +1808,6 @@ static qsize_t *f2fs_get_reserved_space(struct inode *inode)
>>>>>  
>>>>>  static int f2fs_quota_on_mount(struct f2fs_sb_info *sbi, int type)
>>>>>  {
>>>>> -
>>>>>  	if (is_set_ckpt_flags(sbi, CP_QUOTA_NEED_FSCK_FLAG)) {
>>>>>  		f2fs_msg(sbi->sb, KERN_ERR,
>>>>>  			"quota sysfile may be corrupted, skip loading it");
>>>>> @@ -1958,7 +1971,9 @@ static int f2fs_quota_on(struct super_block *sb, int type, int format_id,
>>>>>  	if (err)
>>>>>  		return err;
>>>>>  
>>>>> +	set_sbi_flag(F2FS_SB(sb), SBI_QUOTA_INIT);
>>>>>  	err = dquot_quota_on(sb, type, format_id, path);
>>>>> +	clear_sbi_flag(F2FS_SB(sb), SBI_QUOTA_INIT);
>>>>>  	if (err)
>>>>>  		return err;
>>>>>  
>>>>> @@ -3179,6 +3194,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>>>>>  		goto free_meta_inode;
>>>>>  	}
>>>>>  
>>>>> +	set_sbi_flag(sbi, SBI_QUOTA_INIT);
>>>>>  	if (__is_set_ckpt_flags(F2FS_CKPT(sbi), CP_QUOTA_NEED_FSCK_FLAG))
>>>>>  		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
>>>>>  
>>>>> @@ -3370,6 +3386,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>>>>>  				cur_cp_version(F2FS_CKPT(sbi)));
>>>>>  	f2fs_update_time(sbi, CP_TIME);
>>>>>  	f2fs_update_time(sbi, REQ_TIME);
>>>>> +
>>>>> +	clear_sbi_flag(sbi, SBI_QUOTA_INIT);
>>>>>  	return 0;
>>>>>  
>>>>>  free_meta:
>>>>> @@ -3434,6 +3452,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>>>>>  		shrink_dcache_sb(sb);
>>>>>  		goto try_onemore;
>>>>>  	}
>>>>> +	clear_sbi_flag(sbi, SBI_QUOTA_INIT);
>>>>>  	return err;
>>>>>  }
>>>>>  
>>>>> @@ -3449,6 +3468,7 @@ static void kill_f2fs_super(struct super_block *sb)
>>>>>  		struct f2fs_sb_info *sbi = F2FS_SB(sb);
>>>>>  
>>>>>  		set_sbi_flag(sbi, SBI_IS_CLOSE);
>>>>> +		set_sbi_flag(sbi, SBI_QUOTA_INIT);
>>>>>  		f2fs_stop_gc_thread(sbi);
>>>>>  		f2fs_stop_discard_thread(sbi);
>>>>>  
>>>>>
>>>
>>>
>>> _______________________________________________
>>> Linux-f2fs-devel mailing list
>>> Linux-f2fs-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>
