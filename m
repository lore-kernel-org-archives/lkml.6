Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2964C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 03:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA786217D8
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 03:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbeLSDV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 22:21:59 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16603 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726537AbeLSDV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 22:21:59 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EF9B0238E04BF;
        Wed, 19 Dec 2018 11:21:55 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Wed, 19 Dec 2018
 11:21:54 +0800
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: flush stale issued discard
 candidates
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20181214050127.45025-1-jaegeuk@kernel.org>
 <20181214050127.45025-3-jaegeuk@kernel.org>
 <639940cc-f7a8-e679-3b28-3b3b2485652b@huawei.com>
 <20181218224351.GC31062@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <b878570b-1e71-ab32-20a6-dd262f21348a@huawei.com>
Date:   Wed, 19 Dec 2018 11:21:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181218224351.GC31062@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/19 6:43, Jaegeuk Kim wrote:
> On 12/18, Chao Yu wrote:
>> On 2018/12/14 13:01, Jaegeuk Kim wrote:
>>> Sometimes, I could observe # of issuing_discard to be 1 which blocks background
>>> jobs due to is_idle()=false.
>>> The only way to get out of it was to trigger gc_urgent. This patch avoids that
>>> by checking any candidates as done in the list.
>>
>> Well, as below code, once we issued discard commands, we will wait all
>> queued discard end their IO, so do you know what flow can cause such
>> condition...?
> 
> It's very subtle, and I suspect somehow race condition not from here.
> 
>>
>> 		issued = __issue_discard_cmd(sbi, &dpolicy);
>> 		if (issued > 0) {
>> 			__wait_all_discard_cmd(sbi, &dpolicy);
>>
>> Or, I doubt that 'issued' statistical info could be wrong.
> 
> No, it simply came back to 0 with this patch. So, something is pending
> in the queue even if it is done.

__submit_discard_cmd()
{
....
	dc->len = 0;   <---- reset discard length here

	while (total_len && *issued < dpolicy->max_requests && !err) {
		struct bio *bio = NULL;
		unsigned long flags;
		bool last = true;

		if (len > max_discard_blocks) {
			len = max_discard_blocks;  <---- will truncate len to max_discard_blocks
			last = false;
		}

		(*issued)++;
		if (*issued == dpolicy->max_requests)
			last = true;

		dc->len += len;      <----- will update len into dc->len
...
}

__wait_discard_cmd_range()
{
...
		if (dc->len < dpolicy->granularity)
			continue;
So we can only remove discard entry which size is not smaller than
dpolicy->granularity, if max_discard_blocks is smaller than granularity,
after splitting discard in __submit_discard_cmd(), we may left small-sized
entry there.

...
}

Could you check that whether the left discard was skipped being removed due
to above reason?

Thanks

> 
> Thanks,
> 
>>
>> Thanks,
>>
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  fs/f2fs/segment.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index 49ea9009ab5a..acbbc924e518 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -1651,6 +1651,10 @@ static int issue_discard_thread(void *data)
>>>  		if (dcc->discard_wake)
>>>  			dcc->discard_wake = 0;
>>>  
>>> +		/* clean up pending candidates before going to sleep */
>>> +		if (atomic_read(&dcc->queued_discard))
>>> +			__wait_all_discard_cmd(sbi, NULL);
>>> +
>>>  		if (try_to_freeze())
>>>  			continue;
>>>  		if (f2fs_readonly(sbi->sb))
>>>
> 
> .
> 

