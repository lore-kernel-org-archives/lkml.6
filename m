Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A18FC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 01:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290E02089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 01:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 290E02089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeJPJTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 05:19:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13656 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726946AbeJPJTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 05:19:24 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E341F8B841896;
        Tue, 16 Oct 2018 09:31:28 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.399.0; Tue, 16 Oct 2018
 09:31:26 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: clear cold data flag if IO is not
 counted
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20181010212217.52289-1-jaegeuk@kernel.org>
 <3f08031e-d195-5bc1-67e1-f3b6eab3506b@huawei.com>
 <20181015230807.GC1296@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <405b1521-cbfb-9f09-0d16-ae837b756cbb@huawei.com>
Date:   Tue, 16 Oct 2018 09:31:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181015230807.GC1296@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/16 7:08, Jaegeuk Kim wrote:
> On 10/15, Chao Yu wrote:
>> On 2018/10/11 5:22, Jaegeuk Kim wrote:
>>> If we clear the cold data flag out of the writeback flow, we can miscount
>>> -1 by end_io.
>>
>> I didn't get it, which count do you mean?
> 
> It's the number of dirty pages.
> 
> Balancing F2FS Async:
>   - IO (CP:    1, Data:   -1, Flush: (   0    0    1), Discard: (   0 129304)) cmd:    0 undiscard:   0
> 

So I guess the race should be:

GC thread:				IRQ
- move_data_page()
 - set_page_dirty()
  - clear_cold_data()
					- f2fs_write_end_io()
					 - type = WB_DATA_TYPE(page);
					   here, we get wrong type
					 - dec_page_count(sbi, type);
 - f2fs_wait_on_page_writeback()

How about relocate wait_writeback & set_page_dirty to avoid above race:

move_data_page()

retry:
		f2fs_wait_on_page_writeback(page, DATA, true);
		set_page_dirty(page);

Thanks,

>>
>> Thanks,
>>
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  fs/f2fs/data.c | 4 ----
>>>  1 file changed, 4 deletions(-)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index 29a9d3b8f709..4102799b5558 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -2636,10 +2636,6 @@ static int f2fs_set_data_page_dirty(struct page *page)
>>>  	if (!PageUptodate(page))
>>>  		SetPageUptodate(page);
>>>  
>>> -	/* don't remain PG_checked flag which was set during GC */
>>> -	if (is_cold_data(page))
>>> -		clear_cold_data(page);
>>> -
>>>  	if (f2fs_is_atomic_file(inode) && !f2fs_is_commit_atomic_write(inode)) {
>>>  		if (!IS_ATOMIC_WRITTEN_PAGE(page)) {
>>>  			f2fs_register_inmem_page(inode, page);
>>>
> 
> .
> 

