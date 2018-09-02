Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9ED4C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 12:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A39D20855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 12:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecsOmRxr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A39D20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbeIBRMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:12:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbeIBRMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:12:33 -0400
Received: from [192.168.0.101] (unknown [49.77.178.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CF5520835;
        Sun,  2 Sep 2018 12:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535893010;
        bh=Y9vY/Kv6tRQgB12tW04WItkhd+Z1/lrAp9V25KBS0WQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ecsOmRxraVRoMuen6WFxrVzpPs9yp+HgZPJ39ESJa7biA68sCGoKM8Jw4EN08dYU6
         PsTPlb7MwTeQvqGFaPeJz6ubMvQ1pFgNDeB58SQ0jp+GbHaGHN0fQn32WCOoeAA0Hr
         4hr5ws8WtWScJmxkbgVf0dH1FpR6som1ZvThrOKI=
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix unnecessary periodic wakeup of
 discard thread when dev is busy
To:     Sahitya Tummala <stummala@codeaurora.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <1535708366-11318-1-git-send-email-stummala@codeaurora.org>
 <ae0ec622-1fd3-d28a-019b-75a507e551f6@kernel.org>
 <20180902103411.GE12489@codeaurora.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <fdf4d391-4ec3-077f-c4b5-4c3785a153aa@kernel.org>
Date:   Sun, 2 Sep 2018 20:56:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180902103411.GE12489@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/2 18:34, Sahitya Tummala wrote:
> On Sun, Sep 02, 2018 at 04:52:40PM +0800, Chao Yu wrote:
>> On 2018/8/31 17:39, Sahitya Tummala wrote:
>>> When dev is busy, discard thread wake up timeout can be aligned with the
>>> exact time that it needs to wait for dev to come out of busy. This helps
>>> to avoid unnecessary periodic wakeups and thus save some power.
>>>
>>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
>>> ---
>>>  fs/f2fs/segment.c | 8 +++++++-
>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index 8bcbb50..df14030 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -1379,6 +1379,8 @@ static int issue_discard_thread(void *data)
>>>  	struct discard_policy dpolicy;
>>>  	unsigned int wait_ms = DEF_MIN_DISCARD_ISSUE_TIME;
>>>  	int issued;
>>> +	unsigned long interval = sbi->interval_time[REQ_TIME] * HZ;
>>> +	long delta;
>>>  
>>>  	set_freezable();
>>>  
>>> @@ -1410,7 +1412,11 @@ static int issue_discard_thread(void *data)
>>>  			__wait_all_discard_cmd(sbi, &dpolicy);
>>>  			wait_ms = dpolicy.min_interval;
>>>  		} else if (issued == -1){
>>> -			wait_ms = dpolicy.mid_interval;
>>> +			delta = (sbi->last_time[REQ_TIME] + interval) - jiffies;
>>
>> I agree that we need to consider power consumption. One more consideration is
>> that discard thread may need different submission frequency comparing to garbage
>> collection thread, maybe a little fast, would it be better to split
>> sbi->interval_time[REQ_TIME] according to gc/discard type.
>>
>> How do you think?
>>
>> Thanks,
>>
> 
> Thanks for the review.
> 
> You mean when GC type is urgent? I see that for that case, the discard policy is

Actually, I mean splitting sbi->interval_time[REQ_TIME] into:
- sbi->interval_time[GC_TIM] which can be used for GC thread.
- sbi->interval_time[DISCARD_TIME] which can be used for Discard thread.

Then we can configure sbi->interval_time[DISCARD_TIME] independently, and set
more suitable interval value for discard thread, since discard thread may need
to wake to submit discards more frequently.

I guess if we can accept above idea, it can be sent as another patch, so anyway,
I'm okay with your change. :)

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> changed to DPOLICY_FORCE, which sets dpolicy->io_aware as false and hence,
> cannot fall into this (issued == -1) case at all.
> 
>>> +			if (delta > 0)
>>> +				wait_ms = jiffies_to_msecs(delta);
>>> +			else
>>> +				wait_ms = dpolicy.mid_interval;
>>>  		} else {
>>>  			wait_ms = dpolicy.max_interval;
>>>  		}
>>>
> 
