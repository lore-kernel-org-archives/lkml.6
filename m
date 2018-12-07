Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB1AC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411CB20882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411CB20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbeLGJlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:41:23 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15653 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725976AbeLGJlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:41:22 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9867CF3ED7496;
        Fri,  7 Dec 2018 17:41:18 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Fri, 7 Dec 2018
 17:41:11 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid frequent costly fsck triggers
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     Sheng Yong <shengyong1@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20181128073125.39102-1-jaegeuk@kernel.org>
 <724de929-6ee1-3ad7-cfa7-6e80d4e7a3da@huawei.com>
 <20181128081035.GA41969@jaegeuk-macbookpro.roam.corp.google.com>
 <4f43735a-d01f-f194-18ce-4fbbe10ad8d4@huawei.com>
 <20181128174805.GB41969@jaegeuk-macbookpro.roam.corp.google.com>
 <234cabcd-a1c1-9fb6-13aa-94fe681731dc@huawei.com>
 <afaee7a9-162a-b157-f0bc-de366cbb7b53@huawei.com>
 <20181130202807.GA71781@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <297bfe4f-8cc9-09af-8cc3-3b91755ea482@huawei.com>
Date:   Fri, 7 Dec 2018 17:41:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181130202807.GA71781@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/1 4:28, Jaegeuk Kim wrote:
> On 11/30, Chao Yu wrote:
>> On 2018/11/30 10:35, Sheng Yong wrote:
>>> Hi, Jaegeuk and Chao,
>>>
>>> On 2018/11/29 1:48, Jaegeuk Kim wrote:
>>>> On 11/28, Chao Yu wrote:
>>>>> On 2018/11/28 16:10, Jaegeuk Kim wrote:
>>>>>> On 11/28, Chao Yu wrote:
>>>>>>> Hi Jaeguek,
>>>>>>>
>>>>>>> On 2018/11/28 15:31, Jaegeuk Kim wrote:
>>>>>>>> If we want to re-enable nat_bits, we rely on fsck which requires full scan
>>>>>>>> of directory tree. Let's do that by regular fsck or unclean shutdown.
>>>>>>>
>>>>>>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>>>>>>
>>>>>>> BTW, I have patch made some month ago...
>>>>>>>
>>>>>>> In order to detect nat_bits disabling, could we introduce one more flag for
>>>>>>> fsck?
>>>>>>
>>>>>> Do we have a way to enable nat_bits very quickly in fsck?
>>>>>
>>>>> For image with SBI_NATBIT_NEED_REPAIR flag, can we just check metadata and
>>>>> rebuild nat_bits based on verified nat blocks/journals?
>>>>
>>>> I'm leaning to rely on full scan to enable nat_bits again. We may add a mount
>>>> count or timer to trigger fsck regularly?
>>>
>>> I'm afraid regular full fsck would give us bad experience of booting time.
>>> FYI, 256GB storage, which is filled with small files, costs almost 10 min
>>> to do a full fsck. And it seems larger capacity storages are on the way.
>>
>> Agreed.
> 
> Agreed. So, that's why I wrote this patch.

I see.

> 
>>
>>> So, is it worth doing that only to enable nat_bits (plus checking f2fs
>>> consistent not that necessarily)?
>>
>> In android environment, I think it may be too expensive for adding nat_bits
>> by triggering full scan by fsck during boot time.
> 
> That's why I'd like to enable this only when we need full scan.
> 
>>
>> If we can update all nat bitmap in free time after mount, maybe we can
>> rebuild nat_bits based on full nat bitmap during umount, which can be
>> cheaper than rebuiding in userspace.
> 
> Yeah, rebuiling nat_bits in run time would be better, but can be applied
> in future. But, since Android reboot procedure uses a timeout, if we exceed

It only need to write additional nat_bits blocks during last umount
checkpoint, why it can exceed the timeout period?

Thanks,

> it, we'll get unclean unmount which triggers another fsck, which doesn't
> make sense at all.
> 
>>
>> Thanks,
>>
>>>
>>> Thanks
>>>>
>>>>>
>>>>> Thanks,
>>>>>
>>>>>>
>>>>>>>
>>>>>>> >From 86e8bdb2faeec904944bb6621073f4f7de51cc2d Mon Sep 17 00:00:00 2001
>>>>>>> From: Chao Yu <yuchao0@huawei.com>
>>>>>>> Date: Sun, 9 Sep 2018 05:40:20 +0800
>>>>>>> Subject: [PATCH] f2fs: set specified flag after invalidating nat_bits
>>>>>>>
>>>>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>>>>> ---
>>>>>>>   fs/f2fs/checkpoint.c    | 12 +++++++++++-
>>>>>>>   fs/f2fs/f2fs.h          |  3 ++-
>>>>>>>   fs/f2fs/node.c          |  3 +++
>>>>>>>   include/linux/f2fs_fs.h |  1 +
>>>>>>>   4 files changed, 17 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>>>>>> index 7e17bb3dfcb1..f7fb14e0f5f9 100644
>>>>>>> --- a/fs/f2fs/checkpoint.c
>>>>>>> +++ b/fs/f2fs/checkpoint.c
>>>>>>> @@ -1226,13 +1226,16 @@ static void update_ckpt_flags(struct f2fs_sb_info
>>>>>>> *sbi, struct cp_control *cpc)
>>>>>>>   	unsigned long orphan_num = sbi->im[ORPHAN_INO].ino_num;
>>>>>>>   	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
>>>>>>>   	unsigned long flags;
>>>>>>> +	bool disable_natbits = false;
>>>>>>>
>>>>>>>   	spin_lock_irqsave(&sbi->cp_lock, flags);
>>>>>>>
>>>>>>>   	if ((cpc->reason & CP_UMOUNT) &&
>>>>>>>   			le32_to_cpu(ckpt->cp_pack_total_block_count) >
>>>>>>> -			sbi->blocks_per_seg - NM_I(sbi)->nat_bits_blocks)
>>>>>>> +			sbi->blocks_per_seg - NM_I(sbi)->nat_bits_blocks) {
>>>>>>>   		disable_nat_bits(sbi, false);
>>>>>>> +		disable_natbits = true;
>>>>>>> +	}
>>>>>>>
>>>>>>>   	if (cpc->reason & CP_TRIMMED)
>>>>>>>   		__set_ckpt_flags(ckpt, CP_TRIMMED_FLAG);
>>>>>>> @@ -1270,11 +1273,18 @@ static void update_ckpt_flags(struct f2fs_sb_info
>>>>>>> *sbi, struct cp_control *cpc)
>>>>>>>   	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR))
>>>>>>>   		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
>>>>>>>
>>>>>>> +	if (is_sbi_flag_set(sbi, SBI_NATBIT_NEED_REPAIR))
>>>>>>> +		__set_ckpt_flags(ckpt, CP_NATBIT_NEED_FSCK_FLAG);
>>>>>>> +
>>>>>>>   	/* set this flag to activate crc|cp_ver for recovery */
>>>>>>>   	__set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG);
>>>>>>>   	__clear_ckpt_flags(ckpt, CP_NOCRC_RECOVERY_FLAG);
>>>>>>>
>>>>>>>   	spin_unlock_irqrestore(&sbi->cp_lock, flags);
>>>>>>> +
>>>>>>> +	if (disable_natbits)
>>>>>>> +		f2fs_msg(sbi->sb, KERN_NOTICE,
>>>>>>> +			"No enough space in CP area, disable nat_bits.");
>>>>>>>   }
>>>>>>>
>>>>>>>   static void commit_checkpoint(struct f2fs_sb_info *sbi,
>>>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>>>>> index f0cedbe0c536..b55341c269b2 100644
>>>>>>> --- a/fs/f2fs/f2fs.h
>>>>>>> +++ b/fs/f2fs/f2fs.h
>>>>>>> @@ -1107,6 +1107,7 @@ enum {
>>>>>>>   	SBI_QUOTA_NEED_FLUSH,			/* need to flush quota info in CP */
>>>>>>>   	SBI_QUOTA_SKIP_FLUSH,			/* skip flushing quota in current CP */
>>>>>>>   	SBI_QUOTA_NEED_REPAIR,			/* quota file may be corrupted */
>>>>>>> +	SBI_NATBIT_NEED_REPAIR,			/* nat full/empty bitmaps need repair */
>>>>>>>   };
>>>>>>>
>>>>>>>   enum {
>>>>>>> @@ -1628,7 +1629,7 @@ static inline void disable_nat_bits(struct
>>>>>>> f2fs_sb_info *sbi, bool lock)
>>>>>>>   {
>>>>>>>   	unsigned long flags;
>>>>>>>
>>>>>>> -	set_sbi_flag(sbi, SBI_NEED_FSCK);
>>>>>>> +	set_sbi_flag(sbi, SBI_NATBIT_NEED_REPAIR);
>>>>>>>
>>>>>>>   	if (lock)
>>>>>>>   		spin_lock_irqsave(&sbi->cp_lock, flags);
>>>>>>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>>>>>>> index e57add1e8966..0c6f8312a087 100644
>>>>>>> --- a/fs/f2fs/node.c
>>>>>>> +++ b/fs/f2fs/node.c
>>>>>>> @@ -2902,6 +2902,9 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
>>>>>>>
>>>>>>>   	cp_ver |= (cur_cp_crc(ckpt) << 32);
>>>>>>>   	if (cpu_to_le64(cp_ver) != *(__le64 *)nm_i->nat_bits) {
>>>>>>> +		f2fs_msg(sbi->sb, KERN_NOTICE,
>>>>>>> +			"Disable nat_bits due to incorrect cp_ver (%llu, %llu)",
>>>>>>> +			cp_ver, le64_to_cpu(*(__le64 *)nm_i->nat_bits));
>>>>>>>   		disable_nat_bits(sbi, true);
>>>>>>>   		return 0;
>>>>>>>   	}
>>>>>>> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
>>>>>>> index 7196653833fa..1f3ae1504573 100644
>>>>>>> --- a/include/linux/f2fs_fs.h
>>>>>>> +++ b/include/linux/f2fs_fs.h
>>>>>>> @@ -117,6 +117,7 @@ struct f2fs_super_block {
>>>>>>>   /*
>>>>>>>    * For checkpoint
>>>>>>>    */
>>>>>>> +#define CP_NATBIT_NEED_FSCK_FLAG	0X00002000
>>>>>>>   #define CP_DISABLED_FLAG		0x00001000
>>>>>>>   #define CP_QUOTA_NEED_FSCK_FLAG		0x00000800
>>>>>>>   #define CP_LARGE_NAT_BITMAP_FLAG	0x00000400
>>>>>>> -- 
>>>>>>> 2.18.0.rc1
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>>>>> ---
>>>>>>>>   fs/f2fs/f2fs.h | 6 +++++-
>>>>>>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>>>>>> index c28a9d1cb278..aa500239baf2 100644
>>>>>>>> --- a/fs/f2fs/f2fs.h
>>>>>>>> +++ b/fs/f2fs/f2fs.h
>>>>>>>> @@ -1621,7 +1621,11 @@ static inline void disable_nat_bits(struct f2fs_sb_info *sbi, bool lock)
>>>>>>>>   {
>>>>>>>>   	unsigned long flags;
>>>>>>>>   
>>>>>>>> -	set_sbi_flag(sbi, SBI_NEED_FSCK);
>>>>>>>> +	/*
>>>>>>>> +	 * In order to re-enable nat_bits we need to call fsck.f2fs by
>>>>>>>> +	 * set_sbi_flag(sbi, SBI_NEED_FSCK). But it may give huge cost,
>>>>>>>> +	 * so let's rely on regular fsck or unclean shutdown.
>>>>>>>> +	 */
>>>>>>>>   
>>>>>>>>   	if (lock)
>>>>>>>>   		spin_lock_irqsave(&sbi->cp_lock, flags);
>>>>>>>>
>>>>>>
>>>>>> .
>>>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> Linux-f2fs-devel mailing list
>>>> Linux-f2fs-devel@lists.sourceforge.net
>>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>>
>>>> .
>>>>
>>>
>>>
>>> .
>>>
> 
> .
> 

