Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754081AbeEHGGT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 02:06:19 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7238 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752497AbeEHGGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 02:06:18 -0400
Subject: Re: [PATCH] f2fs: fix to wait IO writeback in __revoke_inmem_pages()
To: Jaegeuk Kim <jaegeuk@kernel.org>
CC: Chao Yu <chao@kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20180426083247.86337-1-yuchao0@huawei.com>
 <20180426154817.GF68594@jaegeuk-macbookpro.roam.corp.google.com>
 <7810a3a3-70f3-9b37-e64a-f26dba72b0f9@kernel.org>
 <20180426163651.GL68594@jaegeuk-macbookpro.roam.corp.google.com>
 <3cae6be6-365d-8e48-b1db-8b04f96634e4@huawei.com>
 <20180507204630.GB83867@jaegeuk-macbookpro.roam.corp.google.com>
 <f986a4d9-e2d4-17d6-7179-53d353fae90d@huawei.com>
 <20180508033155.GC17507@jaegeuk-macbookpro.roam.corp.google.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <50b77166-754b-fe14-8dd4-b6e96790fe2e@huawei.com>
Date: Tue, 8 May 2018 14:06:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180508033155.GC17507@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/5/8 11:31, Jaegeuk Kim wrote:
> On 05/08, Chao Yu wrote:
>> On 2018/5/8 4:46, Jaegeuk Kim wrote:
>>> On 04/27, Chao Yu wrote:
>>>> On 2018/4/27 0:36, Jaegeuk Kim wrote:
>>>>> On 04/26, Chao Yu wrote:
>>>>>> On 2018/4/26 23:48, Jaegeuk Kim wrote:
>>>>>>> On 04/26, Chao Yu wrote:
>>>>>>>> Thread A				Thread B
>>>>>>>> - f2fs_ioc_commit_atomic_write
>>>>>>>>  - commit_inmem_pages
>>>>>>>>   - f2fs_submit_merged_write_cond
>>>>>>>>   : write data
>>>>>>>> 					- write_checkpoint
>>>>>>>> 					 - do_checkpoint
>>>>>>>> 					 : commit all node within CP
>>>>>>>> 					 -> SPO
>>>>>>>>   - f2fs_do_sync_file
>>>>>>>>    - file_write_and_wait_range
>>>>>>>>    : wait data writeback
>>>>>>>>
>>>>>>>> In above race condition, data/node can be flushed in reversed order when
>>>>>>>> coming a checkpoint before f2fs_do_sync_file, after SPOR, it results in
>>>>>>>> atomic written data being corrupted.
>>>>>>>
>>>>>>> Wait, what is the problem here? Thread B could succeed checkpoint, there is
>>>>>>> no problem. If it fails, there is no fsync mark where we can recover it, so
>>>>>>
>>>>>> Node is flushed by checkpoint before data, with reversed order, that's the problem.
>>>>>
>>>>> What do you mean? Data should be in disk, in order to proceed checkpoint.
>>>>
>>>> 1. thread A: commit_inmem_pages submit data into block layer, but haven't waited
>>>> it writeback.
>>>> 2. thread A: commit_inmem_pages update related node.
>>>> 3. thread B: do checkpoint, flush all nodes to disk
>>>
>>> How about, in block_operations(),
>>>
>>> 	down_read_trylock(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>>> 	if (fail)
>>> 		wait_on_all_pages_writeback(F2FS_WB_DATA);
>>> 	else
>>> 		up_read(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>>
>> I sent one patch for that, could you check it?
>>
>> Adding wait_on_all_pages_writeback in block_operations() can make checkpoint()
>> wait pages writeback one more time, which break IO flow, so what's your concern
>> here?
> 
> Performance. And I can see wait_on_all_pages_writeback() waits only for
> F2FS_WB_CP_DATA in checkpoint()?

Oh, you mean wait all F2FS_WB_DATA pages writeback, what about just treating
atomic write page as F2FS_WB_CP_DATA, and we can wait atomic pages in
wait_on_all_pages_writeback() in do_checkpoitn().

Thanks,

> 
> 
>>
>> Thanks,
>>
>>>
>>>
>>>> 4. SPOR
>>>>
>>>> Then, atomic file becomes corrupted since nodes is flushed before data.
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>>> we can just ignore the last written data as nothing.
>>>>>>>
>>>>>>>>
>>>>>>>> This patch adds f2fs_wait_on_page_writeback in __revoke_inmem_pages() to
>>>>>>>> keep data and node of atomic file being flushed orderly.
>>>>>>>>
>>>>>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>>>>>> ---
>>>>>>>>  fs/f2fs/file.c    | 4 ++++
>>>>>>>>  fs/f2fs/segment.c | 3 +++
>>>>>>>>  2 files changed, 7 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>>>>>> index be7578774a47..a352804af244 100644
>>>>>>>> --- a/fs/f2fs/file.c
>>>>>>>> +++ b/fs/f2fs/file.c
>>>>>>>> @@ -217,6 +217,9 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>>>>>>>>  
>>>>>>>>  	trace_f2fs_sync_file_enter(inode);
>>>>>>>>  
>>>>>>>> +	if (atomic)
>>>>>>>> +		goto write_done;
>>>>>>>> +
>>>>>>>>  	/* if fdatasync is triggered, let's do in-place-update */
>>>>>>>>  	if (datasync || get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks)
>>>>>>>>  		set_inode_flag(inode, FI_NEED_IPU);
>>>>>>>> @@ -228,6 +231,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>>>>>>>>  		return ret;
>>>>>>>>  	}
>>>>>>>>  
>>>>>>>> +write_done:
>>>>>>>>  	/* if the inode is dirty, let's recover all the time */
>>>>>>>>  	if (!f2fs_skip_inode_update(inode, datasync)) {
>>>>>>>>  		f2fs_write_inode(inode, NULL);
>>>>>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>>>>>> index 584483426584..9ca3d0a43d93 100644
>>>>>>>> --- a/fs/f2fs/segment.c
>>>>>>>> +++ b/fs/f2fs/segment.c
>>>>>>>> @@ -230,6 +230,8 @@ static int __revoke_inmem_pages(struct inode *inode,
>>>>>>>>  
>>>>>>>>  		lock_page(page);
>>>>>>>>  
>>>>>>>> +		f2fs_wait_on_page_writeback(page, DATA, true);
>>>>>>>> +
>>>>>>>>  		if (recover) {
>>>>>>>>  			struct dnode_of_data dn;
>>>>>>>>  			struct node_info ni;
>>>>>>>> @@ -415,6 +417,7 @@ static int __commit_inmem_pages(struct inode *inode)
>>>>>>>>  		/* drop all uncommitted pages */
>>>>>>>>  		__revoke_inmem_pages(inode, &fi->inmem_pages, true, false);
>>>>>>>>  	} else {
>>>>>>>> +		/* wait all committed IOs writeback and release them from list */
>>>>>>>>  		__revoke_inmem_pages(inode, &revoke_list, false, false);
>>>>>>>>  	}
>>>>>>>>  
>>>>>>>> -- 
>>>>>>>> 2.15.0.55.gc2ece9dc4de6
>>>>>
>>>>> .
>>>>>
>>>
>>> .
>>>
> 
> .
> 
