Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845B5ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 01:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399B52083E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 01:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 399B52083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeJVJbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 05:31:49 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14102 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726181AbeJVJbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 05:31:49 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4C39A3569FF47;
        Mon, 22 Oct 2018 09:15:28 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Mon, 22 Oct 2018
 09:15:26 +0800
Subject: Re: [PATCH] f2fs: fix to account IO correctly
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20181017094954.67547-1-yuchao0@huawei.com>
 <20181018190612.GD50556@jaegeuk-macbookpro.roam.corp.google.com>
 <9e586616-5cfa-5515-008c-e7bba1e3c4a1@huawei.com>
 <20181019231212.GB11541@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <a0b8373d-8b5f-6502-a230-5a67a815caa3@huawei.com>
Date:   Mon, 22 Oct 2018 09:15:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181019231212.GB11541@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/20 7:12, Jaegeuk Kim wrote:
> On 10/19, Chao Yu wrote:
>> On 2018/10/19 3:06, Jaegeuk Kim wrote:
>>>
>>> On 10/17, Chao Yu wrote:
>>>> Below race can cause reversed reference on F2FS_RD_DATA, there is
>>>> the same issue in f2fs_submit_page_bio(), fix them by relocate
>>>> __submit_bio() and inc_page_count.
>>>>
>>>> Thread A			Thread B
>>>> - f2fs_write_begin
>>>>  - f2fs_submit_page_read
>>>>  - __submit_bio
>>>> 				- f2fs_read_end_io
>>>> 				 - __read_end_io
>>>> 				 - dec_page_count(, F2FS_RD_DATA)
>>>>  - inc_page_count(, F2FS_RD_DATA)
>>>
>>> Let me integrate the change into the original patch and test a bit.
>>
>> IMO, it will be better to split this change into two, we can fix the
>> location of inc_page_count(, F2FS_RD_DATA) directly in your patch,
>> meanwhile we can add one more patch to fix the same issue in
>> f2fs_submit_page_bio(), in where the problem exists for long time, it needs
>> to send fixing patch to stable kernel mailing list.
> 
> How about this?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=3cca724d115fc1590c46585e264a391da06c345a
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=8e3eed6f80c9c4cfe875f995b38dde590e444dc6

That's correct, I just modified the commit message a bit to adapt the
change and add 'Fixes' line in v2, could you merge that one?

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>> Thanks,
>>>
>>>>
>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>> ---
>>>>  fs/f2fs/data.c | 6 +++---
>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>> index c03bd0c2ed22..8b9240762156 100644
>>>> --- a/fs/f2fs/data.c
>>>> +++ b/fs/f2fs/data.c
>>>> @@ -480,10 +480,10 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
>>>>  	}
>>>>  	bio_set_op_attrs(bio, fio->op, fio->op_flags);
>>>>  
>>>> -	__submit_bio(fio->sbi, bio, fio->type);
>>>> -
>>>>  	inc_page_count(fio->sbi, is_read_io(fio->op) ?
>>>>  			__read_io_type(page): WB_DATA_TYPE(fio->page));
>>>> +
>>>> +	__submit_bio(fio->sbi, bio, fio->type);
>>>>  	return 0;
>>>>  }
>>>>  
>>>> @@ -612,8 +612,8 @@ static int f2fs_submit_page_read(struct inode *inode, struct page *page,
>>>>  		return -EFAULT;
>>>>  	}
>>>>  	ClearPageError(page);
>>>> -	__submit_bio(F2FS_I_SB(inode), bio, DATA);
>>>>  	inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
>>>> +	__submit_bio(F2FS_I_SB(inode), bio, DATA);
>>>>  	return 0;
>>>>  }
>>>>  
>>>> -- 
>>>> 2.18.0.rc1
>>>
>>> .
>>>
> 
> .
> 

