Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752497AbeBFCSK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 21:18:10 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4765 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752069AbeBFCSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 21:18:04 -0500
Subject: Re: [PATCH 1/2] f2fs: enable to gc page whose inode already atomic
 commit
To: Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>,
        <jaegeuk@kernel.org>, <yunlong.song@icloud.com>
CC: <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1517626068-49739-1-git-send-email-yunlong.song@huawei.com>
 <a094cd40-d042-2a43-4e9a-e34c31e61d28@kernel.org>
 <f4e7b403-4945-a7f9-6bdc-214dc61c9160@huawei.com>
 <312d70f3-b1ae-9ced-44cb-fde83de362ff@huawei.com>
 <b39adaf3-f727-e6ad-ef0d-4789cdc38de5@huawei.com>
 <f3c1c01d-3d82-5546-7aec-73c2e69cd17a@huawei.com>
 <3182ade9-4153-9e47-f8a5-5c87371a3900@huawei.com>
 <6716d2f9-ee89-0f30-2332-5aee48530a12@huawei.com>
From: Yunlong Song <yunlong.song@huawei.com>
Message-ID: <11fcb5ec-eb91-7d55-2ea4-41cc4f4ca0f4@huawei.com>
Date: Tue, 6 Feb 2018 10:15:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <6716d2f9-ee89-0f30-2332-5aee48530a12@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.111.220.140]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, now I got it, thanks for the explanation. Then the point is to avoid
set_page_dirty between file_write_and_wait_range and fsync_node_pages,
so we can lock before file_write_and_wait_range and unlock after 
fsync_node_pages, and lock before set_page_dirty and unlock after
set_page_dirty. These patches and the locks can make sure the GCed data
pages are all committed to nand flash with their nodes.

On 2018/2/5 19:10, Chao Yu wrote:
> On 2018/2/5 17:37, Yunlong Song wrote:
>>
>>> OK, details as I explained before:
>>>
>>> atomic_commit				GC
>>> - file_write_and_wait_range
>>> 					- move_data_block
>>> 					 - f2fs_submit_page_write
>>> 					  - f2fs_update_data_blkaddr
>>> 					   - set_page_dirty
>>>    - fsync_node_pages
>>>
>>> 1. atomic writes data page #1 & update node #1
>>> 2. GC data page #2 & update node #2
>>> 3. page #1 & node #1 & #2 can be committed into nand flash before page #2 be
>>> committed.
>>>
>>> After a sudden pow-cut, database transaction will be inconsistent. So I think
>>> there will be better to exclude gc/atomic_write to each other, with a lock
>>> instead of flag checking.
>>>
>>
>> I do not understand why this transaction is inconsistent, is it a
>> problem that page #2 is not committed into nand flash? Since normal
> 
> Yes, node #2 contains newly updated LBAx of page #2, but if page #2 is not
> committed to LBAx, after recovery, page #2 's block address in node #2 will
> point to LBAx which contains random data, result in corrupted db file.
> 
>> gc also has this problem:
>>
>> Suppose that there is db file A, f2fs_gc moves data page #1 of db file
>> A. But if write checkpoint only commit node page #1 and then a sudden
> 
> f2fs will ensure GCed data being persisted during checkpoint, so migrated page
> #1 and updated node #1 will both be committed in this checkpoint.
> 
> Please check WB_DATA_TYPE macro to see how we define data type that cp
> guarantees to writeback.
> 
>> power-cut happens. Data page #1 is not committed to nand flash, but
>> node page #1 is committed. Is the db transaction broken and
>> inconsistent?
>>
>> Come back to your example, I think data page 2 of atomic file does not
>> belong to this transaction, so even node page 2 is committed, it is just
> 
> If node #2 is committed only, it will be harmful to db transaction due to the
> reason I said above.
> 
> Thanks,
> 
>> the same problem as what I have listed above(db file A), and it does not
>> break this transaction.
>>
>>> Thanks,
>>>
>>>>>>>
>>>>>>> So how about just using dio_rwsem[WRITE] during atomic committing to exclude
>>>>>>> GCing data block of atomic opened file?
>>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>>>
>>>>>>>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>>>>>>>> ---
>>>>>>>>      fs/f2fs/data.c | 5 ++---
>>>>>>>>      fs/f2fs/gc.c   | 6 ++++--
>>>>>>>>      2 files changed, 6 insertions(+), 5 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>>>>>> index 7435830..edafcb6 100644
>>>>>>>> --- a/fs/f2fs/data.c
>>>>>>>> +++ b/fs/f2fs/data.c
>>>>>>>> @@ -1580,14 +1580,13 @@ bool should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
>>>>>>>>      		return true;
>>>>>>>>      	if (S_ISDIR(inode->i_mode))
>>>>>>>>      		return true;
>>>>>>>> -	if (f2fs_is_atomic_file(inode))
>>>>>>>> -		return true;
>>>>>>>>      	if (fio) {
>>>>>>>>      		if (is_cold_data(fio->page))
>>>>>>>>      			return true;
>>>>>>>>      		if (IS_ATOMIC_WRITTEN_PAGE(fio->page))
>>>>>>>>      			return true;
>>>>>>>> -	}
>>>>>>>> +	} else if (f2fs_is_atomic_file(inode))
>>>>>>>> +		return true;
>>>>>>>>      	return false;
>>>>>>>>      }
>>>>>>>>      
>>>>>>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>>>>>>> index b9d93fd..84ab3ff 100644
>>>>>>>> --- a/fs/f2fs/gc.c
>>>>>>>> +++ b/fs/f2fs/gc.c
>>>>>>>> @@ -622,7 +622,8 @@ static void move_data_block(struct inode *inode, block_t bidx,
>>>>>>>>      	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
>>>>>>>>      		goto out;
>>>>>>>>      
>>>>>>>> -	if (f2fs_is_atomic_file(inode))
>>>>>>>> +	if (f2fs_is_atomic_file(inode) &&
>>>>>>>> +		!f2fs_is_commit_atomic_write(inode))
>>>>>>>>      		goto out;
>>>>>>>>      
>>>>>>>>      	if (f2fs_is_pinned_file(inode)) {
>>>>>>>> @@ -729,7 +730,8 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
>>>>>>>>      	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
>>>>>>>>      		goto out;
>>>>>>>>      
>>>>>>>> -	if (f2fs_is_atomic_file(inode))
>>>>>>>> +	if (f2fs_is_atomic_file(inode) &&
>>>>>>>> +		!f2fs_is_commit_atomic_write(inode))
>>>>>>>>      		goto out;
>>>>>>>>      	if (f2fs_is_pinned_file(inode)) {
>>>>>>>>      		if (gc_type == FG_GC)
>>>>>>>>
>>>>>>>
>>>>>>> .
>>>>>>>
>>>>>>
>>>>>
>>>>>
>>>>> .
>>>>>
>>>>
>>>
>>>
>>> .
>>>
>>
> 
> 
> .
> 

-- 
Thanks,
Yunlong Song
