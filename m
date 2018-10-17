Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28D5C5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C92214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C92214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeJQJXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 05:23:37 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14085 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726936AbeJQJXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 05:23:36 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3CFDB17BB7B88;
        Wed, 17 Oct 2018 09:30:21 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.399.0; Wed, 17 Oct 2018
 09:30:13 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: clear cold data flag if IO is not
 counted
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20181010212217.52289-1-jaegeuk@kernel.org>
 <3f08031e-d195-5bc1-67e1-f3b6eab3506b@huawei.com>
 <20181015230807.GC1296@jaegeuk-macbookpro.roam.corp.google.com>
 <405b1521-cbfb-9f09-0d16-ae837b756cbb@huawei.com>
 <20181016031052.GA19956@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <b3f5fe2f-e082-5641-372a-2a7bb331a20c@huawei.com>
Date:   Wed, 17 Oct 2018 09:30:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181016031052.GA19956@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/16 11:10, Jaegeuk Kim wrote:
> On 10/16, Chao Yu wrote:
>> On 2018/10/16 7:08, Jaegeuk Kim wrote:
>>> On 10/15, Chao Yu wrote:
>>>> On 2018/10/11 5:22, Jaegeuk Kim wrote:
>>>>> If we clear the cold data flag out of the writeback flow, we can miscount
>>>>> -1 by end_io.
>>>>
>>>> I didn't get it, which count do you mean?
>>>
>>> It's the number of dirty pages.
>>>
>>> Balancing F2FS Async:
>>>   - IO (CP:    1, Data:   -1, Flush: (   0    0    1), Discard: (   0 129304)) cmd:    0 undiscard:   0

Better to add such info in commit message. :)

>>>
>>
>> So I guess the race should be:
>>
>> GC thread:				IRQ
>> - move_data_page()
>>  - set_page_dirty()
>>   - clear_cold_data()
>> 					- f2fs_write_end_io()
>> 					 - type = WB_DATA_TYPE(page);
>> 					   here, we get wrong type
>> 					 - dec_page_count(sbi, type);
>>  - f2fs_wait_on_page_writeback()
>>
>> How about relocate wait_writeback & set_page_dirty to avoid above race:
> 
> Well, wait_on_stable_page() doesn't guarantee its end_io. So, I'm not sure
> this is the only case.

Yes, you're right, I missed that case.

Can you use git-revert to generate the patch? so we can remain original
commit info for better backward tracking.

How do you think pick up original patch I submitted:

https://lkml.org/lkml/2018/7/27/415

Thanks,

> 
>>
>> move_data_page()
>>
>> retry:
>> 		f2fs_wait_on_page_writeback(page, DATA, true);
>> 		set_page_dirty(page);
>>
>> Thanks,
>>
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>> ---
>>>>>  fs/f2fs/data.c | 4 ----
>>>>>  1 file changed, 4 deletions(-)
>>>>>
>>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>>> index 29a9d3b8f709..4102799b5558 100644
>>>>> --- a/fs/f2fs/data.c
>>>>> +++ b/fs/f2fs/data.c
>>>>> @@ -2636,10 +2636,6 @@ static int f2fs_set_data_page_dirty(struct page *page)
>>>>>  	if (!PageUptodate(page))
>>>>>  		SetPageUptodate(page);
>>>>>  
>>>>> -	/* don't remain PG_checked flag which was set during GC */
>>>>> -	if (is_cold_data(page))
>>>>> -		clear_cold_data(page);
>>>>> -
>>>>>  	if (f2fs_is_atomic_file(inode) && !f2fs_is_commit_atomic_write(inode)) {
>>>>>  		if (!IS_ATOMIC_WRITTEN_PAGE(page)) {
>>>>>  			f2fs_register_inmem_page(inode, page);
>>>>>
>>>
>>> .
>>>
> 
> .
> 

