Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EAAC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 01:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5627E20882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 01:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5627E20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbeILGPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 02:15:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11686 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728181AbeILGPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 02:15:09 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BD9E31529E67D;
        Wed, 12 Sep 2018 09:13:08 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.399.0; Wed, 12 Sep 2018
 09:13:05 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix quota info to adjust recovered data
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20180911201546.56566-1-jaegeuk@kernel.org>
 <7aa2e6f3-a4b2-dfdd-6205-f19c4bc952e6@kernel.org>
 <20180912000603.GA67662@jaegeuk-macbookpro.roam.corp.google.com>
 <20180912002700.GA69323@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <650f06f4-7ca3-a3ed-d149-88d1e9f93b7a@huawei.com>
Date:   Wed, 12 Sep 2018 09:13:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180912002700.GA69323@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/12 8:27, Jaegeuk Kim wrote:
> On 09/11, Jaegeuk Kim wrote:
>> On 09/12, Chao Yu wrote:
>>> On 2018/9/12 4:15, Jaegeuk Kim wrote:
>>>> fsck.f2fs is able to recover the quota structure, since roll-forward recovery
>>>> can recover it based on previous user information.
>>>
>>> I didn't get it, both fsck and kernel recover quota file based all inodes'
>>> uid/gid/prjid, if {x}id didn't change, wouldn't those two recovery result be the
>>> same?
>>
>> I thought that, but had to add this, since I was encountering quota errors right
>> after getting some files recovered. And, I thought it'd make it more safe to do
>> fsck after roll-forward recovery.
>>
>> Anyway, let me test again without this patch for a while.
> 
> Hmm, I just got a fsck failure right after some files recovered.

To make sure, do you test with "f2fs: guarantee journalled quota data by
checkpoint"? if not, I think there is no guarantee that f2fs can recover
quote info into correct quote file, because, in last checkpoint, quota file
may was corrupted/inconsistent. Right?

Thanks,

> 
>>
>> Thanks,
>>
>>
>>>
>>> Thanks,
>>>
>>>>
>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>> ---
>>>>  fs/f2fs/recovery.c | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
>>>> index 95511ed11a22..1fde86a2107e 100644
>>>> --- a/fs/f2fs/recovery.c
>>>> +++ b/fs/f2fs/recovery.c
>>>> @@ -675,6 +675,9 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
>>>>  
>>>>  	need_writecp = true;
>>>>  
>>>> +	/* quota is not fully updated due to the lack of user information. */
>>>> +	set_sbi_flag(sbi, SBI_NEED_FSCK);
>>>> +
>>>>  	/* step #2: recover data */
>>>>  	err = recover_data(sbi, &inode_list, &dir_list);
>>>>  	if (!err)
>>>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> .
> 

