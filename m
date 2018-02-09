Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753573AbeBIN6u (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 08:58:50 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:46751 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751195AbeBIN6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 08:58:48 -0500
Subject: Re: [f2fs-dev] [PATCH] f2fs: add fi->commit_lock to protect commit
 GCed pages
To: Chao Yu <chao@kernel.org>, <jaegeuk@kernel.org>, <yuchao0@huawei.com>,
        <yunlong.song@icloud.com>
CC: <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <heyunlei@huawei.com>,
        <miaoxie@huawei.com>
References: <1517626068-49739-1-git-send-email-yunlong.song@huawei.com>
 <1517888990-96478-1-git-send-email-yunlong.song@huawei.com>
 <4493cbf2-6f37-6c04-a012-4b2516b3b4e7@kernel.org>
 <134848f9-2dd6-0efa-3ccf-3c29eeaf5534@huawei.com>
 <ae9a153e-4e9a-648d-3804-2a1e4a21a9c1@kernel.org>
 <a2f431bf-ac2f-0b03-6b7f-aeb51e815e17@huawei.com>
 <d67aae9c-778a-50bd-9f73-f90c3efd9b73@kernel.org>
 <33b262b8-7701-a150-09e5-9ae1b4733835@huawei.com>
 <0b3d2792-b3cf-3302-8313-404a25c86854@kernel.org>
From: Yunlong Song <yunlong.song@huawei.com>
Message-ID: <f87ba022-0959-e56e-6769-c8481a7054fc@huawei.com>
Date: Fri, 9 Feb 2018 21:57:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <0b3d2792-b3cf-3302-8313-404a25c86854@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.111.220.140]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is that you can not find a proper value of the threshold
time, when f2fs_gc select the GCed data page of the atomic file (which
has atomic started but not atomic committed yet), then f2fs_gc will
run into loop, and all the f2fs ops will be blocked in f2fs_balane_fs.
If the threshold time is set larger (e.g. 5s? Then all the f2fs ops will
block 5s, which will cause unexpected bad result of user experience).
And if the threshold time is set smaller (e.g. 500ms? Then the atomic
ops will probably fail frequently). BTW, some more patches are needed
to notify the atomic ops itself that it has run time out, and should
handle the inmem pages....

Back to these two patches, why not use them to separate inmem pages
and GCed data pages in such a simple way.

On 2018/2/9 21:38, Chao Yu wrote:
> On 2018/2/9 21:29, Yunlong Song wrote:
>> Back to the problem, if we skip out, then the f2fs_gc will go
>> into dead loop if the apps only atomic start but never atomic
> 
> That's another issue, which I have suggest to set a threshold time
> to release atomic/volatile pages by balance_fs_bg.
> 
> Thanks,
> 
>> commit. The main aim of my two patches is to remove the skip
>> action to avoid the dead loop.
>>
>> On 2018/2/9 21:26, Chao Yu wrote:
>>> On 2018/2/9 20:56, Yunlong Song wrote:
>>>> As what I point in last mail, if the atomic file is not committed
>>>> yet, gc_data_segment will register_inmem_page the GCed data pages.
>>>
>>> We will skip GCing that page as below check:
>>>
>>> - move_data_{page,block}
>>>    - f2fs_is_atomic_file()
>>>      skip out;
>>>
>>> No?
>>>
>>> Thanks,
>>>
>>>> This will cause these data pages written twice, the first write
>>>> happens in move_data_page->do_write_data_page, and the second
>>>> write happens in later __commit_inmem_pages->do_write_data_page.
>>>>
>>>> On 2018/2/9 20:44, Chao Yu wrote:
>>>>> On 2018/2/8 11:11, Yunlong Song wrote:
>>>>>> Then the GCed data pages are totally mixed with the inmem atomic pages,
>>>>>
>>>>> If we add dio_rwsem, GC flow is exclude with atomic write flow. There
>>>>> will be not race case to mix GCed page into atomic pages.
>>>>>
>>>>> Or you mean:
>>>>>
>>>>>                       - gc_data_segment
>>>>>                        - move_data_page
>>>>>                         - f2fs_is_atomic_file
>>>>> - f2fs_ioc_start_atomic_write
>>>>>     - set_inode_flag(inode, FI_ATOMIC_FILE);
>>>>>                         - f2fs_set_data_page_dirty
>>>>>                          - register_inmem_page
>>>>>
>>>>> In this case, GCed page can be mixed into database transaction, but could
>>>>> it cause any problem except break rule of isolation for transaction.
>>>>>
>>>>>> this will cause the atomic commit ops write the GCed data pages twice
>>>>>> (the first write happens in GC).
>>>>>>
>>>>>> How about using the early two patches to separate the inmem data pages
>>>>>> and GCed data pages, and use dio_rwsem instead of this patch to fix the
>>>>>> dnode page problem (dnode page commited but data page are not committed
>>>>>> for the GCed page)?
>>>>>
>>>>> Could we fix the race case first, based on that fixing, and then find the
>>>>> place that we can improve?
>>>>>
>>>>>>
>>>>>>
>>>>>> On 2018/2/7 20:16, Chao Yu wrote:
>>>>>>> On 2018/2/6 11:49, Yunlong Song wrote:
>>>>>>>> This patch adds fi->commit_lock to avoid the case that GCed node pages
>>>>>>>> are committed but GCed data pages are not committed. This can avoid the
>>>>>>>> db file run into inconsistent state when sudden-power-off happens if
>>>>>>>> data pages of atomic file is allowed to be GCed before.
>>>>>>>
>>>>>>> do_fsync:                GC:
>>>>>>> - mutex_lock(&fi->commit_lock);
>>>>>>>                        - lock_page()
>>>>>>>                         - mutex_lock(&fi->commit_lock);
>>>>>>>      - lock_page()
>>>>>>>
>>>>>>>
>>>>>>> Well, please consider lock dependency & code complexity, IMO, reuse
>>>>>>> fi->dio_rwsem[WRITE] will be enough as below:
>>>>>>>
>>>>>>> ---
>>>>>>>      fs/f2fs/file.c | 3 +++
>>>>>>>      fs/f2fs/gc.c   | 5 -----
>>>>>>>      2 files changed, 3 insertions(+), 5 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>>>>> index 672a542e5464..1bdc11feb8d0 100644
>>>>>>> --- a/fs/f2fs/file.c
>>>>>>> +++ b/fs/f2fs/file.c
>>>>>>> @@ -1711,6 +1711,8 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
>>>>>>>
>>>>>>>          inode_lock(inode);
>>>>>>>
>>>>>>> +    down_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
>>>>>>> +
>>>>>>>          if (f2fs_is_volatile_file(inode))
>>>>>>>              goto err_out;
>>>>>>>
>>>>>>> @@ -1729,6 +1731,7 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
>>>>>>>              ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 1, false);
>>>>>>>          }
>>>>>>>      err_out:
>>>>>>> +    up_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
>>>>>>>          inode_unlock(inode);
>>>>>>>          mnt_drop_write_file(filp);
>>>>>>>          return ret;
>>>>>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>>>>>> index b9d93fd532a9..e49416283563 100644
>>>>>>> --- a/fs/f2fs/gc.c
>>>>>>> +++ b/fs/f2fs/gc.c
>>>>>>> @@ -622,9 +622,6 @@ static void move_data_block(struct inode *inode, block_t bidx,
>>>>>>>          if (!check_valid_map(F2FS_I_SB(inode), segno, off))
>>>>>>>              goto out;
>>>>>>>
>>>>>>> -    if (f2fs_is_atomic_file(inode))
>>>>>>> -        goto out;
>>>>>
>>>>> Seems that we need this check.
>>>>>
>>>>>>> -
>>>>>>>          if (f2fs_is_pinned_file(inode)) {
>>>>>>>              f2fs_pin_file_control(inode, true);
>>>>>>>              goto out;
>>>>>>> @@ -729,8 +726,6 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
>>>>>>>          if (!check_valid_map(F2FS_I_SB(inode), segno, off))
>>>>>>>              goto out;
>>>>>>>
>>>>>>> -    if (f2fs_is_atomic_file(inode))
>>>>>>> -        goto out;
>>>>>
>>>>> Ditto.
>>>>>
>>>>> Thanks,
>>>>>
>>>>>>>          if (f2fs_is_pinned_file(inode)) {
>>>>>>>              if (gc_type == FG_GC)
>>>>>>>                  f2fs_pin_file_control(inode, true);
>>>>>>>
>>>>>>
>>>>>
>>>>> .
>>>>>
>>>>
>>>
>>> .
>>>
>>
> 
> .
> 

-- 
Thanks,
Yunlong Song
