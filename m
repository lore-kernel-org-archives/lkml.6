Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752887AbeEGUqc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 16:46:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752693AbeEGUqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 16:46:31 -0400
Date: Mon, 7 May 2018 13:46:30 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix to wait IO writeback in __revoke_inmem_pages()
Message-ID: <20180507204630.GB83867@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180426083247.86337-1-yuchao0@huawei.com>
 <20180426154817.GF68594@jaegeuk-macbookpro.roam.corp.google.com>
 <7810a3a3-70f3-9b37-e64a-f26dba72b0f9@kernel.org>
 <20180426163651.GL68594@jaegeuk-macbookpro.roam.corp.google.com>
 <3cae6be6-365d-8e48-b1db-8b04f96634e4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cae6be6-365d-8e48-b1db-8b04f96634e4@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/27, Chao Yu wrote:
> On 2018/4/27 0:36, Jaegeuk Kim wrote:
> > On 04/26, Chao Yu wrote:
> >> On 2018/4/26 23:48, Jaegeuk Kim wrote:
> >>> On 04/26, Chao Yu wrote:
> >>>> Thread A				Thread B
> >>>> - f2fs_ioc_commit_atomic_write
> >>>>  - commit_inmem_pages
> >>>>   - f2fs_submit_merged_write_cond
> >>>>   : write data
> >>>> 					- write_checkpoint
> >>>> 					 - do_checkpoint
> >>>> 					 : commit all node within CP
> >>>> 					 -> SPO
> >>>>   - f2fs_do_sync_file
> >>>>    - file_write_and_wait_range
> >>>>    : wait data writeback
> >>>>
> >>>> In above race condition, data/node can be flushed in reversed order when
> >>>> coming a checkpoint before f2fs_do_sync_file, after SPOR, it results in
> >>>> atomic written data being corrupted.
> >>>
> >>> Wait, what is the problem here? Thread B could succeed checkpoint, there is
> >>> no problem. If it fails, there is no fsync mark where we can recover it, so
> >>
> >> Node is flushed by checkpoint before data, with reversed order, that's the problem.
> > 
> > What do you mean? Data should be in disk, in order to proceed checkpoint.
> 
> 1. thread A: commit_inmem_pages submit data into block layer, but haven't waited
> it writeback.
> 2. thread A: commit_inmem_pages update related node.
> 3. thread B: do checkpoint, flush all nodes to disk

How about, in block_operations(),

	down_read_trylock(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
	if (fail)
		wait_on_all_pages_writeback(F2FS_WB_DATA);
	else
		up_read(&F2FS_I(inode)->i_gc_rwsem[WRITE]);


> 4. SPOR
> 
> Then, atomic file becomes corrupted since nodes is flushed before data.
> 
> Thanks,
> 
> > 
> >>
> >> Thanks,
> >>
> >>> we can just ignore the last written data as nothing.
> >>>
> >>>>
> >>>> This patch adds f2fs_wait_on_page_writeback in __revoke_inmem_pages() to
> >>>> keep data and node of atomic file being flushed orderly.
> >>>>
> >>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >>>> ---
> >>>>  fs/f2fs/file.c    | 4 ++++
> >>>>  fs/f2fs/segment.c | 3 +++
> >>>>  2 files changed, 7 insertions(+)
> >>>>
> >>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >>>> index be7578774a47..a352804af244 100644
> >>>> --- a/fs/f2fs/file.c
> >>>> +++ b/fs/f2fs/file.c
> >>>> @@ -217,6 +217,9 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
> >>>>  
> >>>>  	trace_f2fs_sync_file_enter(inode);
> >>>>  
> >>>> +	if (atomic)
> >>>> +		goto write_done;
> >>>> +
> >>>>  	/* if fdatasync is triggered, let's do in-place-update */
> >>>>  	if (datasync || get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks)
> >>>>  		set_inode_flag(inode, FI_NEED_IPU);
> >>>> @@ -228,6 +231,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
> >>>>  		return ret;
> >>>>  	}
> >>>>  
> >>>> +write_done:
> >>>>  	/* if the inode is dirty, let's recover all the time */
> >>>>  	if (!f2fs_skip_inode_update(inode, datasync)) {
> >>>>  		f2fs_write_inode(inode, NULL);
> >>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >>>> index 584483426584..9ca3d0a43d93 100644
> >>>> --- a/fs/f2fs/segment.c
> >>>> +++ b/fs/f2fs/segment.c
> >>>> @@ -230,6 +230,8 @@ static int __revoke_inmem_pages(struct inode *inode,
> >>>>  
> >>>>  		lock_page(page);
> >>>>  
> >>>> +		f2fs_wait_on_page_writeback(page, DATA, true);
> >>>> +
> >>>>  		if (recover) {
> >>>>  			struct dnode_of_data dn;
> >>>>  			struct node_info ni;
> >>>> @@ -415,6 +417,7 @@ static int __commit_inmem_pages(struct inode *inode)
> >>>>  		/* drop all uncommitted pages */
> >>>>  		__revoke_inmem_pages(inode, &fi->inmem_pages, true, false);
> >>>>  	} else {
> >>>> +		/* wait all committed IOs writeback and release them from list */
> >>>>  		__revoke_inmem_pages(inode, &revoke_list, false, false);
> >>>>  	}
> >>>>  
> >>>> -- 
> >>>> 2.15.0.55.gc2ece9dc4de6
> > 
> > .
> > 
