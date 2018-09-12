Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF3CC07520
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5621E21471
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvK7klkS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5621E21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbeIMEfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 00:35:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbeIMEfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 00:35:31 -0400
Received: from [192.168.0.101] (unknown [49.77.238.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE3B82146E;
        Wed, 12 Sep 2018 23:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536794925;
        bh=tQBBDYaJIizt/HN/HGiEb1gGnd6G6476tN2JL2YK7KU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SvK7klkSzHANj6Tik7eRHRwN2ciyanVgFS3PRw/3UWBKyKfRv+rrkKyxLzJPsflMj
         jmy42li3AO19f2vvZK1viZxc3KOKv9G2gbYIaaKZ7hhmDvLDQn/nOs3Wwdc1NZrmGE
         /ZBuTJ2fL0m+89lkAQtt7epDKsF+AbcRlcMWYG/c=
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix quota info to adjust recovered data
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20180911201546.56566-1-jaegeuk@kernel.org>
 <7aa2e6f3-a4b2-dfdd-6205-f19c4bc952e6@kernel.org>
 <20180912000603.GA67662@jaegeuk-macbookpro.roam.corp.google.com>
 <20180912002700.GA69323@jaegeuk-macbookpro.roam.corp.google.com>
 <650f06f4-7ca3-a3ed-d149-88d1e9f93b7a@huawei.com>
 <20180912012550.GA71953@jaegeuk-macbookpro.roam.corp.google.com>
 <ffbfbc85-f7ac-dd5c-b20f-d08868adb4ee@huawei.com>
 <24ee1c19-ccc1-31db-12d0-30ac76fd645e@huawei.com>
 <20180912195406.GB8356@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <bbdc2ae6-591a-ffaf-ff51-e0884ef475ca@kernel.org>
Date:   Thu, 13 Sep 2018 07:28:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180912195406.GB8356@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/13 3:54, Jaegeuk Kim wrote:
> On 09/12, Chao Yu wrote:
>> On 2018/9/12 9:40, Chao Yu wrote:
>>> On 2018/9/12 9:25, Jaegeuk Kim wrote:
>>>> On 09/12, Chao Yu wrote:
>>>>> On 2018/9/12 8:27, Jaegeuk Kim wrote:
>>>>>> On 09/11, Jaegeuk Kim wrote:
>>>>>>> On 09/12, Chao Yu wrote:
>>>>>>>> On 2018/9/12 4:15, Jaegeuk Kim wrote:
>>>>>>>>> fsck.f2fs is able to recover the quota structure, since roll-forward recovery
>>>>>>>>> can recover it based on previous user information.
>>>>>>>>
>>>>>>>> I didn't get it, both fsck and kernel recover quota file based all inodes'
>>>>>>>> uid/gid/prjid, if {x}id didn't change, wouldn't those two recovery result be the
>>>>>>>> same?
>>>>>>>
>>>>>>> I thought that, but had to add this, since I was encountering quota errors right
>>>>>>> after getting some files recovered. And, I thought it'd make it more safe to do
>>>>>>> fsck after roll-forward recovery.
>>>>>>>
>>>>>>> Anyway, let me test again without this patch for a while.
>>>>>>
>>>>>> Hmm, I just got a fsck failure right after some files recovered.
>>>>>
>>>>> To make sure, do you test with "f2fs: guarantee journalled quota data by
>>>>> checkpoint"? if not, I think there is no guarantee that f2fs can recover
>>>>> quote info into correct quote file, because, in last checkpoint, quota file
>>>>> may was corrupted/inconsistent. Right?
>>>
>>> Oh, I forget to mention that, I add a patch to fsck to let it noticing
>>> CP_QUOTA_NEED_FSCK_FLAG flag, and by default, fsck will fix corrupted quote
>>> file if the flag is set, but w/o this flag, quota file is still corrupted
>>> detected by fsck, I guess there is bug in v8.
>>
>> In v8, there are two cases we didn't guarantee quota file's consistence:
>> 1. flush time in block_operation exceed a threshold.
>> 2. dquot subsystem error occurs.
>>
>> For above case, fsck should repair the quota file by default.
> 
> Okay, I got another failure and it seems CP_QUOTA_NEED_FSCK_FLAG was not set
> during the recovery. So, we have something missing in the recovery in terms
> of quota updates.

Yeah, I checked the code, just found one suspected place:

find_fsync_dnodes()
 - f2fs_recover_inode_page
  - inc_valid_node_count
   - dquot_reserve_block  dquot info is not initialized now
 - add_fsync_inode
  - dquot_initialize

I think we should reserve block for inode block after dquot_initialize(), can
you confirm this?

> 
>>
>>>
>>> Can you add that in fsck too? so we can separate real kernel bug and quota
>>> file corruption due to dquot subsystem error caused like below case:
>>>
>>> +static int f2fs_dquot_acquire(struct dquot *dquot)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = dquot_acquire(dquot);
>>> +	if (ret == -ENOSPC || ret == -EIO)
>>> +		set_sbi_flag(F2FS_SB(dquot->dq_sb), SBI_QUOTA_NEED_REPAIR);
>>> +	return ret;
>>> +}
>>>
>>>>
>>>> I hit the failure with v8. And, the test scenario is 1) enable fault injection
>>>> 2) run fsstress, 3) call shutdowon, 4) kill fsstress, 5) unmount, 6) fsck, 7)
>>>> mount, 8) fsck, 9) go 1).
>>
>> 8) fsck is do fscking in a mounted image?
> 
> Missing unmount before 8). :P

Alright. :)

Thanks,

> 
>>
>> Thanks,
>>
>>>>
>>>> So, I'm hitting failure in 8) fsck. I expect 6) fsck should fix any corruption
>>>> and 7) recovered some files on clean checkpoint.
>>>
>>> I see, I can add this case too, does this exist in your xfstest tree in github?
>>>
>>> Thanks,
>>>
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>> Thanks,
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>>>>>> ---
>>>>>>>>>  fs/f2fs/recovery.c | 3 +++
>>>>>>>>>  1 file changed, 3 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
>>>>>>>>> index 95511ed11a22..1fde86a2107e 100644
>>>>>>>>> --- a/fs/f2fs/recovery.c
>>>>>>>>> +++ b/fs/f2fs/recovery.c
>>>>>>>>> @@ -675,6 +675,9 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
>>>>>>>>>  
>>>>>>>>>  	need_writecp = true;
>>>>>>>>>  
>>>>>>>>> +	/* quota is not fully updated due to the lack of user information. */
>>>>>>>>> +	set_sbi_flag(sbi, SBI_NEED_FSCK);
>>>>>>>>> +
>>>>>>>>>  	/* step #2: recover data */
>>>>>>>>>  	err = recover_data(sbi, &inode_list, &dir_list);
>>>>>>>>>  	if (!err)
>>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> _______________________________________________
>>>>>>> Linux-f2fs-devel mailing list
>>>>>>> Linux-f2fs-devel@lists.sourceforge.net
>>>>>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>>>>
>>>>>> .
>>>>>>
>>>>
>>>> .
>>>>
>>>
>>>
>>> .
>>>
