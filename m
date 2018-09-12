Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D73C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01A3204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01A3204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbeILOyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:54:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56784 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726082AbeILOyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:54:23 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9599C50F9E71B;
        Wed, 12 Sep 2018 17:50:35 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.399.0; Wed, 12 Sep 2018
 17:50:33 +0800
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add new idle interval timing for
 discard and gc paths
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
CC:     Chao Yu <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1536551252-24256-1-git-send-email-stummala@codeaurora.org>
 <5d74d46b-8141-f048-9c0a-459c82b2c449@kernel.org>
 <20180911220958.GC55456@jaegeuk-macbookpro.roam.corp.google.com>
 <20180912082740.GB22939@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <d79bf580-361f-7a13-7c86-a04637f27653@huawei.com>
Date:   Wed, 12 Sep 2018 17:50:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180912082740.GB22939@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/12 16:27, Sahitya Tummala wrote:
> On Tue, Sep 11, 2018 at 03:09:58PM -0700, Jaegeuk Kim wrote:
>> On 09/11, Chao Yu wrote:
>>> On 2018/9/10 11:47, Sahitya Tummala wrote:
>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>> index abf9256..6070681 100644
>>>> --- a/fs/f2fs/f2fs.h
>>>> +++ b/fs/f2fs/f2fs.h
>>>> @@ -1093,6 +1093,8 @@ enum {
>>>>  enum {
>>>>  	CP_TIME,
>>>>  	REQ_TIME,
>>>> +	DISCARD_TIME,
>>>> +	GC_TIME,
>>>>  	MAX_TIME,
>>>>  };
>>>>  
>>>> @@ -1347,14 +1349,35 @@ static inline void f2fs_update_time(struct f2fs_sb_info *sbi, int type)
>>>>  	sbi->last_time[type] = jiffies;
>>>>  }
>>>>  
>>>> -static inline bool f2fs_time_over(struct f2fs_sb_info *sbi, int type)
>>>> +static inline bool f2fs_time_over_cp(struct f2fs_sb_info *sbi)
>>
>> I don't see why we need this separately.
> 
> Yes, not really required. I will update it.
> 
>>
>>>> +{
>>>> +	unsigned long interval = sbi->interval_time[CP_TIME] * HZ;
>>>> +
>>>> +	return time_after(jiffies, sbi->last_time[CP_TIME] + interval);
>>>> +}
>>>> +
>>>> +static inline bool f2fs_time_over_req(struct f2fs_sb_info *sbi, int type)
>>>> +{
>>>> +	unsigned long interval = sbi->interval_time[type] * HZ;
>>>> +
>>>> +	return time_after(jiffies, sbi->last_time[REQ_TIME] + interval);
>>>> +}
>>>> +
>>>> +static inline unsigned int f2fs_get_wait_time(struct f2fs_sb_info *sbi,
>>>> +						int type)
>>
>> f2fs_time_to_wait()?
> 
> Sure.
> 
>>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>>> index 5c8d004..c0bafea 100644
>>>> --- a/fs/f2fs/gc.c
>>>> +++ b/fs/f2fs/gc.c
>>>> @@ -83,8 +83,10 @@ static int gc_thread_func(void *data)
>>>>  		if (!mutex_trylock(&sbi->gc_mutex))
>>>>  			goto next;
>>>>  
>>>> -		if (!is_idle(sbi)) {
>>>> -			increase_sleep_time(gc_th, &wait_ms);
>>>> +		if (!is_idle(sbi, GC_TIME)) {
>>>> +			wait_ms = f2fs_get_wait_time(sbi, GC_TIME);
>>>
>>> It seems this patch changes the method of increasing wait_ms here, if device is
>>> busy, we may wake up GC thread earlier than before, not sure we should do this.
>>>
>>> To Jaegeuk, how do you think of this?
>>
>> Yes, please let us discuss this in another patch.
> 
> Sure, I will submit this in another patch for discussion.

It's fine to me. :)

> 

