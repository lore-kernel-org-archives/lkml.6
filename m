Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756816AbeDZP7e (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 11:59:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753207AbeDZP7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 11:59:33 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD0121789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=chao@kernel.org
Subject: Re: [PATCH] f2fs: fix to wait IO writeback in __revoke_inmem_pages()
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20180426083247.86337-1-yuchao0@huawei.com>
 <20180426154817.GF68594@jaegeuk-macbookpro.roam.corp.google.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <7810a3a3-70f3-9b37-e64a-f26dba72b0f9@kernel.org>
Date: Thu, 26 Apr 2018 23:59:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180426154817.GF68594@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/4/26 23:48, Jaegeuk Kim wrote:
> On 04/26, Chao Yu wrote:
>> Thread A				Thread B
>> - f2fs_ioc_commit_atomic_write
>>  - commit_inmem_pages
>>   - f2fs_submit_merged_write_cond
>>   : write data
>> 					- write_checkpoint
>> 					 - do_checkpoint
>> 					 : commit all node within CP
>> 					 -> SPO
>>   - f2fs_do_sync_file
>>    - file_write_and_wait_range
>>    : wait data writeback
>>
>> In above race condition, data/node can be flushed in reversed order when
>> coming a checkpoint before f2fs_do_sync_file, after SPOR, it results in
>> atomic written data being corrupted.
> 
> Wait, what is the problem here? Thread B could succeed checkpoint, there is
> no problem. If it fails, there is no fsync mark where we can recover it, so

Node is flushed by checkpoint before data, with reversed order, that's the problem.

Thanks,

> we can just ignore the last written data as nothing.
> 
>>
>> This patch adds f2fs_wait_on_page_writeback in __revoke_inmem_pages() to
>> keep data and node of atomic file being flushed orderly.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/file.c    | 4 ++++
>>  fs/f2fs/segment.c | 3 +++
>>  2 files changed, 7 insertions(+)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index be7578774a47..a352804af244 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -217,6 +217,9 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>>  
>>  	trace_f2fs_sync_file_enter(inode);
>>  
>> +	if (atomic)
>> +		goto write_done;
>> +
>>  	/* if fdatasync is triggered, let's do in-place-update */
>>  	if (datasync || get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks)
>>  		set_inode_flag(inode, FI_NEED_IPU);
>> @@ -228,6 +231,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>>  		return ret;
>>  	}
>>  
>> +write_done:
>>  	/* if the inode is dirty, let's recover all the time */
>>  	if (!f2fs_skip_inode_update(inode, datasync)) {
>>  		f2fs_write_inode(inode, NULL);
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 584483426584..9ca3d0a43d93 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -230,6 +230,8 @@ static int __revoke_inmem_pages(struct inode *inode,
>>  
>>  		lock_page(page);
>>  
>> +		f2fs_wait_on_page_writeback(page, DATA, true);
>> +
>>  		if (recover) {
>>  			struct dnode_of_data dn;
>>  			struct node_info ni;
>> @@ -415,6 +417,7 @@ static int __commit_inmem_pages(struct inode *inode)
>>  		/* drop all uncommitted pages */
>>  		__revoke_inmem_pages(inode, &fi->inmem_pages, true, false);
>>  	} else {
>> +		/* wait all committed IOs writeback and release them from list */
>>  		__revoke_inmem_pages(inode, &revoke_list, false, false);
>>  	}
>>  
>> -- 
>> 2.15.0.55.gc2ece9dc4de6
