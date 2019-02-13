Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B48C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107B521B1A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733124AbfBMD0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:26:02 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3194 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727346AbfBMD0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 22:26:01 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0739BD5FABF699796367;
        Wed, 13 Feb 2019 11:26:00 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Wed, 13 Feb 2019
 11:25:55 +0800
Subject: Re: [f2fs-dev] [PATCH 2/7] f2fs: add quick mode of checkpoint=disable
 for QA
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190128234717.77225-1-jaegeuk@kernel.org>
 <20190128234717.77225-2-jaegeuk@kernel.org>
 <2221688e-4dfc-71d5-81c6-3cf12d18e64a@kernel.org>
 <20190204165559.GA15646@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <10954e88-9ad1-7eb3-6bde-2004c6384e19@huawei.com>
Date:   Wed, 13 Feb 2019 11:26:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190204165559.GA15646@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/5 0:55, Jaegeuk Kim wrote:
> On 02/01, Chao Yu wrote:
>> On 2019-1-29 7:47, Jaegeuk Kim wrote:
>>> This mode returns mount() quickly with EAGAIN. We can trigger this by
>>> shutdown(F2FS_GOING_DOWN_NEED_FSCK).
>>
>> Is the purpose of this patch making mount failed more quickly due to giving less
>> GC time in f2fs_disable_checkpoint(), so we can expect that the total test time
>> can be reduce?
> 
> Yup.

Got you. :)

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  fs/f2fs/checkpoint.c    | 5 +++++
>>>  fs/f2fs/f2fs.h          | 2 ++
>>>  fs/f2fs/file.c          | 6 +++---
>>>  fs/f2fs/segment.c       | 3 +++
>>>  fs/f2fs/super.c         | 5 +++++
>>>  include/linux/f2fs_fs.h | 1 +
>>>  6 files changed, 19 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>> index f955cd3e0677..622dca707752 100644
>>> --- a/fs/f2fs/checkpoint.c
>>> +++ b/fs/f2fs/checkpoint.c
>>> @@ -1259,6 +1259,11 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>  	else
>>>  		__clear_ckpt_flags(ckpt, CP_DISABLED_FLAG);
>>>  
>>> +	if (is_sbi_flag_set(sbi, SBI_CP_DISABLED_QUICK))
>>> +		__set_ckpt_flags(ckpt, CP_DISABLED_QUICK_FLAG);
>>> +	else
>>> +		__clear_ckpt_flags(ckpt, CP_DISABLED_QUICK_FLAG);
>>> +
>>>  	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
>>>  		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
>>>  	else
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index 6b6ec5600089..fe95abb05d40 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -191,6 +191,7 @@ enum {
>>>  #define DEF_CP_INTERVAL			60	/* 60 secs */
>>>  #define DEF_IDLE_INTERVAL		5	/* 5 secs */
>>>  #define DEF_DISABLE_INTERVAL		5	/* 5 secs */
>>> +#define DEF_DISABLE_QUICK_INTERVAL	1	/* 1 secs */
>>>  #define DEF_UMOUNT_DISCARD_TIMEOUT	5	/* 5 secs */
>>>  
>>>  struct cp_control {
>>> @@ -1101,6 +1102,7 @@ enum {
>>>  	SBI_IS_SHUTDOWN,			/* shutdown by ioctl */
>>>  	SBI_IS_RECOVERED,			/* recovered orphan/data */
>>>  	SBI_CP_DISABLED,			/* CP was disabled last mount */
>>> +	SBI_CP_DISABLED_QUICK,			/* CP was disabled quickly */
>>>  	SBI_QUOTA_NEED_FLUSH,			/* need to flush quota info in CP */
>>>  	SBI_QUOTA_SKIP_FLUSH,			/* skip flushing quota in current CP */
>>>  	SBI_QUOTA_NEED_REPAIR,			/* quota file may be corrupted */
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>> index 0d461321edfc..fe6f92fbba38 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -1972,11 +1972,11 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
>>>  		break;
>>>  	case F2FS_GOING_DOWN_NEED_FSCK:
>>>  		set_sbi_flag(sbi, SBI_NEED_FSCK);
>>> +		set_sbi_flag(sbi, SBI_CP_DISABLED_QUICK);
>>> +		set_sbi_flag(sbi, SBI_IS_DIRTY);
>>>  		/* do checkpoint only */
>>>  		ret = f2fs_sync_fs(sb, 1);
>>> -		if (ret)
>>> -			goto out;
>>> -		break;
>>> +		goto out;
>>>  	default:
>>>  		ret = -EINVAL;
>>>  		goto out;
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index 5b2b9be6f28d..342b720fb4db 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -868,6 +868,9 @@ int f2fs_disable_cp_again(struct f2fs_sb_info *sbi)
>>>  
>>>  	if (holes[DATA] > ovp || holes[NODE] > ovp)
>>>  		return -EAGAIN;
>>> +	if (is_sbi_flag_set(sbi, SBI_CP_DISABLED_QUICK) &&
>>> +		dirty_segments(sbi) > overprovision_segments(sbi))
>>> +		return -EAGAIN;
>>>  	return 0;
>>>  }
>>>  
>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>> index 24efd76ca151..5e1f8573a17f 100644
>>> --- a/fs/f2fs/super.c
>>> +++ b/fs/f2fs/super.c
>>> @@ -3205,6 +3205,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>>>  
>>>  	if (__is_set_ckpt_flags(F2FS_CKPT(sbi), CP_QUOTA_NEED_FSCK_FLAG))
>>>  		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
>>> +	if (__is_set_ckpt_flags(F2FS_CKPT(sbi), CP_DISABLED_QUICK_FLAG)) {
>>> +		set_sbi_flag(sbi, SBI_CP_DISABLED_QUICK);
>>> +		sbi->interval_time[DISABLE_TIME] = DEF_DISABLE_QUICK_INTERVAL;
>>> +	}
>>>  
>>>  	/* Initialize device list */
>>>  	err = f2fs_scan_devices(sbi);
>>> @@ -3392,6 +3396,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>>>  				cur_cp_version(F2FS_CKPT(sbi)));
>>>  	f2fs_update_time(sbi, CP_TIME);
>>>  	f2fs_update_time(sbi, REQ_TIME);
>>> +	clear_sbi_flag(sbi, SBI_CP_DISABLED_QUICK);
>>>  	return 0;
>>>  
>>>  free_meta:
>>> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
>>> index d7711048ef93..d6befe1f9dc7 100644
>>> --- a/include/linux/f2fs_fs.h
>>> +++ b/include/linux/f2fs_fs.h
>>> @@ -116,6 +116,7 @@ struct f2fs_super_block {
>>>  /*
>>>   * For checkpoint
>>>   */
>>> +#define CP_DISABLED_QUICK_FLAG		0x00002000
>>>  #define CP_DISABLED_FLAG		0x00001000
>>>  #define CP_QUOTA_NEED_FSCK_FLAG		0x00000800
>>>  #define CP_LARGE_NAT_BITMAP_FLAG	0x00000400
>>>
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> .
> 

