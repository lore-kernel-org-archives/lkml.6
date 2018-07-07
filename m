Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F558C3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C112224DC
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWIHtntl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C112224DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932879AbeGGBmS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 21:42:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932239AbeGGBmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 21:42:17 -0400
Received: from [192.168.0.101] (unknown [49.77.239.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 385952240E;
        Sat,  7 Jul 2018 01:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530927737;
        bh=jXAMz8j/qgtg7WkhOQccMnpSNA5YSVHH4GvRUaG7PTY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BWIHtntlXbEuPoNWLjlCakhgQxt1UMu0kQz8moF/n3eLQWDTkParqrVSwpu0S8Fj1
         p0OCI0jOQvZWJ4o22IxlE8RGYUaO9e1/z9N3a2d5p4Co9139+/I56zv2bE2v89FvYK
         75WloHXKSi4ud7ZZKjZcptoC0kyG56mZ8fbysS3A=
Subject: Re: [PATCH v2] f2fs: give another chance to issue discard with
 current granularity
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20180705061551.2961-1-yuchao0@huawei.com>
 <20180706224902.GD77984@jaegeuk-macbookpro.roam.corp.google.com>
 <27b11cd2-921e-d0a8-1cfa-90349dc30ae7@kernel.org>
 <20180707011012.GB3767@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <f0ba7a45-15ff-4cb7-3f4a-84cd3665e7be@kernel.org>
Date:   Sat, 7 Jul 2018 09:42:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180707011012.GB3767@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/7 9:10, Jaegeuk Kim wrote:
> On 07/07, Chao Yu wrote:
>> Hi Jaegeuk,
>>
>> On 2018/7/7 6:49, Jaegeuk Kim wrote:
>>> On 07/05, Chao Yu wrote:
>>>> If discard IOs are blocked by user IO, do not skip to select and issue
>>>> discard with lower granularity, retry with current granularity.
>>>
>>> We need to stop as soon as possible since user activity comes. Later, discard
>>> thread will try it again in another idle time. What's your concern?
>>
>> Currently, our implementation is that we will try to issue
>> DEF_MAX_DISCARD_REQUEST discards as many as possible in batch, for example:
>>
>> If there is 4 discard entry in rb-tree, we will try to issue them by below order
>> in batch:
>>
>> No.		size		is_idle		op
>> #1 discard	2MB		false		skip
>> #2 discard	2MB		false		skip
>> #3 discard	256KB		true		issue
>> #4 discard	16KB		true		issue
>>
>> So if is_idle is false temporarily, we can still have chance to issue #3 & #4
>> discard in this round once is_idle is flipped?
>>
>> But the problem is we skip issue discard with big granularity, so I add this
>> patch to do retry with current granularity.
>>
>> Do you mean that we need to stop issuing discard immediately once we detect IO
>> is busy?
> 
> Yes. If we retry to issue discard continuously, it hurts normal IO latencies.

OK, I will send another patch to change the logic to terminate issuing discard
immediately if there is queued IO.

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>>>
>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>> ---
>>>> v2:
>>>> - fix deadloop.
>>>>  fs/f2fs/segment.c | 16 +++++++++++++---
>>>>  1 file changed, 13 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>> index 1f9ae8270f86..6e2b2e717a40 100644
>>>> --- a/fs/f2fs/segment.c
>>>> +++ b/fs/f2fs/segment.c
>>>> @@ -1191,7 +1191,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>>>>  	struct discard_cmd *dc, *tmp;
>>>>  	struct blk_plug plug;
>>>>  	int i, iter = 0, issued = 0;
>>>> -	bool io_interrupted = false;
>>>> +	bool io_interrupted = false, end_up = false;
>>>>  
>>>>  	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
>>>>  		if (i + 1 < dpolicy->granularity)
>>>> @@ -1199,6 +1199,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>>>>  		pend_list = &dcc->pend_list[i];
>>>>  
>>>>  		mutex_lock(&dcc->cmd_lock);
>>>> +retry:
>>>>  		if (list_empty(pend_list))
>>>>  			goto next;
>>>>  		if (unlikely(dcc->rbtree_check))
>>>> @@ -1217,14 +1218,23 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>>>>  			__submit_discard_cmd(sbi, dpolicy, dc);
>>>>  			issued++;
>>>>  skip:
>>>> -			if (++iter >= dpolicy->max_requests)
>>>> +			if (++iter >= dpolicy->max_requests) {
>>>> +				end_up = true;
>>>>  				break;
>>>> +			}
>>>>  		}
>>>>  		blk_finish_plug(&plug);
>>>> +
>>>> +		/*
>>>> +		 * if discard IO was interrupted by user IOs, give another
>>>> +		 * chance to issue discard with current granularity.
>>>> +		 */
>>>> +		if (io_interrupted && !end_up)
>>>> +			goto retry;
>>>>  next:
>>>>  		mutex_unlock(&dcc->cmd_lock);
>>>>  
>>>> -		if (iter >= dpolicy->max_requests)
>>>> +		if (end_up)
>>>>  			break;
>>>>  	}
>>>>  
>>>> -- 
>>>> 2.18.0.rc1
