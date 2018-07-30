Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65584C46462
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 01:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0122120873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 01:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0122120873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbeG3D1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 23:27:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10154 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728696AbeG3D1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 23:27:54 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 36F1F1BB3FBF6;
        Mon, 30 Jul 2018 09:55:13 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.399.0; Mon, 30 Jul 2018
 09:55:09 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid race between zero_range and
 background GC
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20180726104536.114340-1-yuchao0@huawei.com>
 <20180727102916.GI16155@jaegeuk-macbookpro.roam.corp.google.com>
 <10d7814b-06d0-6751-ca56-85e7c8b92a27@kernel.org>
 <20180729020254.GH83620@jaegeuk-macbookpro.roam.corp.google.com>
 <6d86bad1-52fa-2309-9403-47490345e372@kernel.org>
 <20180729025930.GA95148@jaegeuk-macbookpro.roam.corp.google.com>
 <d6e6a1c0-c56a-aac8-a210-945cce17f5b3@kernel.org>
 <20180729051459.GB97518@jaegeuk-macbookpro.roam.corp.google.com>
 <20180730013816.GA15708@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <c4640220-b294-c801-fc41-b5b0bab007d5@huawei.com>
Date:   Mon, 30 Jul 2018 09:55:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180730013816.GA15708@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/30 9:38, Jaegeuk Kim wrote:
> On 07/28, Jaegeuk Kim wrote:
>> On 07/29, Chao Yu wrote:
>>> On 2018/7/29 10:59, Jaegeuk Kim wrote:
>>>> On 07/29, Chao Yu wrote:
>>>>> On 2018/7/29 10:02, Jaegeuk Kim wrote:
>>>>>> On 07/27, Chao Yu wrote:
>>>>>>> On 2018/7/27 18:29, Jaegeuk Kim wrote:
>>>>>>>> On 07/26, Chao Yu wrote:
>>>>>>>>> Thread A				Background GC
>>>>>>>>> - f2fs_zero_range
>>>>>>>>>  - truncate_pagecache_range
>>>>>>>>> 					- gc_data_segment
>>>>>>>>> 					 - get_read_data_page
>>>>>>>>> 					  - move_data_page
>>>>>>>>> 					   - set_page_dirty
>>>>>>>>> 					   - set_cold_data
>>>>>>>>>  - f2fs_do_zero_range
>>>>>>>>>   - dn->data_blkaddr = NEW_ADDR;
>>>>>>>>>   - f2fs_set_data_blkaddr
>>>>>>>>>
>>>>>>>>> Actually, we don't need to set dirty & checked flag on the page, since
>>>>>>>>> all valid data in the page should be zeroed by zero_range().
>>>>>>>>
>>>>>>>> But, it doesn't matter too much, right?
>>>>>>>
>>>>>>> No, if the dirtied page is writebacked after f2fs_do_zero_range(), result of
>>>>>>> zero_range() should be wrong, as zeroed page contains valid user data.
>>>>>>
>>>>>> How about truncating page caches after block address change or doing it twice
>>>>>> before and after?
>>>>>
>>>>> Thread A				Background GC
>>>>> - f2fs_zero_range
>>>>>  - truncate_pagecache_range
>>>>> 					- gc_data_segment
>>>>> 					 - get_read_data_page
>>>>> 					  - move_data_page
>>>>> 					   - set_page_dirty
>>>>> 					   - set_cold_data
>>>>>  - f2fs_do_zero_range
>>>>>   - dn->data_blkaddr = NEW_ADDR;
>>>>>   - f2fs_set_data_blkaddr
>>>>> 					bdi-flusher
>>>>> 					- __write_data_page
>>>>> 					 - f2fs_update_data_blkaddr
>>>>> 					 : data_blkaddr has been updated here.
>>>>>  - truncate_pagecache_range
>>>>>  : data & dnode has been writebacked before page cache truncation?
>>>>>
>>>>> How about this case?
>>>>
>>>> So, truncating pages under dnode lock can address it?
>>>
>>> Normally, our lock dependency is
>>>
>>> ->writepage()
>>> lock data page -> lock dnode page
>>>
>>> here
>>> lock dnode page -> truncate_pagecache_range::lock data page
>>>
>>> Will easily cause deadlock?
>>
>> Yeah. Can we add an inode flag to bypass GC in this case, then?
> 
> Hmm, BTW, how about using i_gc_rwsem[WRITE] in a very narrow scope?

Oh, I can see that you submitted a patch to change lock dependency to:

f2fs_lock_op() -> down_write(i_gc_rwsem[WRITE])

At a glance, I haven't see any place can cause deadlock now.

> 
> for (index = pg_start; index < pg_end;) {
> 	f2fs_lock_op();
> 	down_write(i_gc_rwsem[WRITE]);
> 	truncate_page_cache_range(index, index + 4k);
> 	f2fs_do_zero_range(&dn, index, end);
> 	up_write(i_gc_rwsem[WRITE]);
> 	f2fs_unlock_op();
> 	f2fs_balance_fs();
> }

Let me update the patch as you suggested.

Thanks,

> 
>>
>>>
>>> Thanks,
>>>
>>>>
>>>>>
>>>>> Thanks,
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>> Use i_gc_rwsem[WRITE] to avoid such race condition.
>>>>>>>>
>>>>>>>> Hope to avoid abusing i_gc_rwsem[] tho.
>>>>>>>
>>>>>>> Agreed, let's try avoiding until we have to use it.
>>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>>>>>>> ---
>>>>>>>>>  fs/f2fs/file.c | 2 ++
>>>>>>>>>  1 file changed, 2 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>>>>>>> index 267ec3794e1e..7bd2412a8c37 100644
>>>>>>>>> --- a/fs/f2fs/file.c
>>>>>>>>> +++ b/fs/f2fs/file.c
>>>>>>>>> @@ -1309,6 +1309,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
>>>>>>>>>  	if (ret)
>>>>>>>>>  		return ret;
>>>>>>>>>  
>>>>>>>>> +	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>>>>>>>>>  	down_write(&F2FS_I(inode)->i_mmap_sem);
>>>>>>>>>  	ret = filemap_write_and_wait_range(mapping, offset, offset + len - 1);
>>>>>>>>>  	if (ret)
>>>>>>>>> @@ -1389,6 +1390,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
>>>>>>>>>  	}
>>>>>>>>>  out_sem:
>>>>>>>>>  	up_write(&F2FS_I(inode)->i_mmap_sem);
>>>>>>>>> +	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>>>>>>>>>  
>>>>>>>>>  	return ret;
>>>>>>>>>  }
>>>>>>>>> -- 
>>>>>>>>> 2.18.0.rc1
>>
>> ------------------------------------------------------------------------------
>> Check out the vibrant tech community on one of the world's most
>> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> .
> 

