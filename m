Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4515DC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08942087C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 02:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08942087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeH2GKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 02:10:07 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11205 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725882AbeH2GKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 02:10:07 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B5D633A8C4600;
        Wed, 29 Aug 2018 10:15:30 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.399.0; Wed, 29 Aug 2018
 10:15:30 +0800
Subject: Re: [PATCH 1/2] f2fs: fix to avoid quota inode leak in ->put_super
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     Chao Yu <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20180817091840.50792-1-yuchao0@huawei.com>
 <20180818151600.GA84798@jaegeuk-macbookpro.roam.corp.google.com>
 <b10c4ae6-2a25-fb0b-cbfa-467b5e988b47@kernel.org>
 <20180821023840.GD20263@jaegeuk-macbookpro.roam.corp.google.com>
 <fbb9e77b-aca0-9ad9-cd06-503ec335370c@huawei.com>
 <20180829020531.GC27219@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <95e10716-d473-f362-6ef8-ac149f376f4e@huawei.com>
Date:   Wed, 29 Aug 2018 10:15:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180829020531.GC27219@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/29 10:05, Jaegeuk Kim wrote:
> On 08/21, Chao Yu wrote:
>> On 2018/8/21 10:38, Jaegeuk Kim wrote:
>>> On 08/20, Chao Yu wrote:
>>>> On 2018/8/18 23:16, Jaegeuk Kim wrote:
>>>>> On 08/17, Chao Yu wrote:
>>>>>> generic/019 reports below error:
>>>>>>
>>>>>>  __quota_error: 1160 callbacks suppressed
>>>>>>  Quota error (device zram1): write_blk: dquota write failed
>>>>>>  Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
>>>>>>  Quota error (device zram1): write_blk: dquota write failed
>>>>>>  Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
>>>>>>  Quota error (device zram1): write_blk: dquota write failed
>>>>>>  Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
>>>>>>  Quota error (device zram1): write_blk: dquota write failed
>>>>>>  Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
>>>>>>  Quota error (device zram1): write_blk: dquota write failed
>>>>>>  Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
>>>>>>  VFS: Busy inodes after unmount of zram1. Self-destruct in 5 seconds.  Have a nice day...
>>>>>>
>>>>>> If we failed in below path due to fail to write dquot block, we will miss
>>>>>> to release quota inode, fix it.
>>>>>>
>>>>>> - f2fs_put_super
>>>>>>  - f2fs_quota_off_umount
>>>>>>   - f2fs_quota_off
>>>>>>    - f2fs_quota_sync   <-- failed
>>>>>>    - dquot_quota_off   <-- missed to call
>>>>>>
>>>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>>>> ---
>>>>>>  fs/f2fs/super.c | 6 ++++--
>>>>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>>>>> index a5df9fbc6355..9647bbcdfd2b 100644
>>>>>> --- a/fs/f2fs/super.c
>>>>>> +++ b/fs/f2fs/super.c
>>>>>> @@ -1977,10 +1977,12 @@ void f2fs_quota_off_umount(struct super_block *sb)
>>>>>>  	for (type = 0; type < MAXQUOTAS; type++) {
>>>>>>  		err = f2fs_quota_off(sb, type);
>>>>>>  		if (err) {
>>>>>> +			int ret = dquot_quota_off(sb, type);
>>>>>> +
>>>>>
>>>>> Could you check the mainline version?
>>>>
>>>> I guess we missed to apply below patch? Could you check that?
>>>>
>>>> f2fs: report error if quota off error during umount
>>>
>>> I remember there was a bug in the patch.
>>
>> Yeah, I guess this patch can fix that one. So could you help trying to test
>> again with the two patches if you have time. :)
> 
> Let me merge two patch and try some tests again. :P

Thanks for helping. ;)

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>>>  			f2fs_msg(sb, KERN_ERR,
>>>>>>  				"Fail to turn off disk quota "
>>>>>> -				"(type: %d, err: %d), Please "
>>>>>> -				"run fsck to fix it.", type, err);
>>>>>> +				"(type: %d, err: %d, ret:%d), Please "
>>>>>> +				"run fsck to fix it.", type, err, ret);
>>>>>>  			set_sbi_flag(F2FS_SB(sb), SBI_NEED_FSCK);
>>>>>>  		}
>>>>>>  	}
>>>>>> -- 
>>>>>> 2.18.0.rc1
>>>
>>> .
>>>
> 
> .
> 

