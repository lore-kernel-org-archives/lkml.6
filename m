Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbeBCLgb (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 06:36:31 -0500
Received: from omr-m009e.mx.aol.com ([204.29.186.8]:41779 "EHLO
        omr-m009e.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751118AbeBCLgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 06:36:24 -0500
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to handle looped node chain during
 recovery
To: Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org,
        Yunlei He <heyunlei@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20180203094439.3913-1-yuchao0@huawei.com>
 <6fe55970-6e30-d144-86d4-68d6fbd80cf3@aol.com>
 <3a4a4906-1f2a-197a-bfe1-f636f9b5243c@aol.com>
From: Gao Xiang <hsiangkao@aol.com>
Message-ID: <34884138-31e6-566d-5be3-d62f61a3416e@aol.com>
Date: Sat, 3 Feb 2018 19:36:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <3a4a4906-1f2a-197a-bfe1-f636f9b5243c@aol.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
x-aol-global-disposition: G
x-aol-sid: 3039ac1add8d5a759eb541e1
X-AOL-IP: 112.64.61.200
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry, I saw the related code entirely, please ignore these replies.


On 2018/2/3 18:45, Gao Xiang wrote:
>
>
> On 2018/2/3 18:35, Gao Xiang wrote:
>> Hi Chao and YunLei,
>>
>>
>> On 2018/2/3 17:44, Chao Yu wrote:
>>> There is no checksum in node block now, so bit-transition from hardware
>>> can make node_footer.next_blkaddr being corrupted w/o any detection,
>>> result in node chain becoming looped one.
>>>
>>> For this condition, during recovery, in order to avoid running into 
>>> dead
>>> loop, let's detect it and just skip out.
>>>
>>> Signed-off-by: Yunlei He <heyunlei@huawei.com>
>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>> ---
>>>   fs/f2fs/recovery.c | 14 ++++++++++++++
>>>   1 file changed, 14 insertions(+)
>>>
>>> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
>>> index b6d1ec620a8c..60dd0cee4820 100644
>>> --- a/fs/f2fs/recovery.c
>>> +++ b/fs/f2fs/recovery.c
>>> @@ -243,6 +243,9 @@ static int find_fsync_dnodes(struct f2fs_sb_info 
>>> *sbi, struct list_head *head,
>>>       struct curseg_info *curseg;
>>>       struct page *page = NULL;
>>>       block_t blkaddr;
>>> +    unsigned int loop_cnt = 0;
>>> +    unsigned int free_blocks = sbi->user_block_count -
>>> +                    valid_user_blocks(sbi);
>> There exists another way to detect loop more faster but only using 
>> two variables.
>> The algorithm is described as simply "B goes forward a steps only A 
>> goes forwards 2 steps".
> "B goes forward a step only when A goes forward 2(or constant x, more 
> than 1) steps".
>
>> For example:
>> 1)
>>    1   2  3  4   5   6     7
>>    |             \             /
>>    |                \------/
>>   A, B
>> 2)
>>    1  2  3  4   5   6     7
>>     |   |        \             /
>>    B   A        \------/
>>  3)
>>    1  2  3  4   5   6     7
>>        |    |     \             /
>>       B   A      \------/
>>   4)
>>    1  2  3  4   5   6     7
>>        |       |\             /
>>       B      A \------/
>> 5)....
>>
>
>
> Sorry, it seems the encoded diagram is in a mess, I try again.
> 1)
>    1 -> 2 -> 3 -> 4 -> 5 ->  6 -> 7
>    |               \             /
>    |                \-----<-----/
>   A, B
> 2)
>    1 -> 2 -> 3 -> 4 -> 5 ->  6 -> 7
>    |    |          \             /
>    |    |           \-----<-----/
>    B    A
> 3)
>    1 -> 2 -> 3 -> 4 -> 5 ->  6 -> 7
>         |    |     \             /
>         |    |      \-----<-----/
>         B    A
> 4)
>    1 -> 2 -> 3 -> 4 -> 5 ->  6 -> 7
>         |         |\             /
>         |         | \-----<-----/
>         B         A
> 5)....
> if B catchs up A, there exists a cycle.
>
>
> Thanks,
>> B will equal A or beyoud A if and only if there has a cycle.
>> It's a more faster algorithm. :D
>>
>> Thanks,
>>
>>>       int err = 0;
>>>         /* get node pages in the current segment */
>>> @@ -295,6 +298,17 @@ static int find_fsync_dnodes(struct 
>>> f2fs_sb_info *sbi, struct list_head *head,
>>>           if (IS_INODE(page) && is_dent_dnode(page))
>>>               entry->last_dentry = blkaddr;
>>>   next:
>>> +        /* sanity check in order to detect looped node chain */
>>> +        if (++loop_cnt >= free_blocks ||
>>> +            blkaddr == next_blkaddr_of_node(page)) {
>>> +            f2fs_msg(sbi->sb, KERN_NOTICE,
>>> +                "%s: detect looped node chain, "
>>> +                "blkaddr:%u, next:%u",
>>> +                __func__, blkaddr, next_blkaddr_of_node(page));
>>> +            err = -EINVAL;
>>> +            break;
>>> +        }
>>> +
>>>           /* check next segment */
>>>           blkaddr = next_blkaddr_of_node(page);
>>>           f2fs_put_page(page, 1);
>>
>
