Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbeDZBgv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 21:36:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51180 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750949AbeDZBgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 21:36:47 -0400
Subject: Re: [PATCH v2] f2fs: wait IO writeback in commit_inmem_pages()
To: Chao Yu <chao@kernel.org>, <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20180423151425.5019-1-chao@kernel.org>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <6e6fecdc-9411-09b6-a13a-ec0395826556@huawei.com>
Date: Thu, 26 Apr 2018 09:36:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180423151425.5019-1-chao@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaegeuk,

I just look into this flow again, found that in previous patch ("f2fs: fix to
wait page writeback during revoking atomic write") we have already called
f2fs_wait_on_page_writeback in __revoke_inmem_pages, so we don't need to call
redundant filemap_fdatawait here.

Anyway, let me merge these two patches.

Thanks,

On 2018/4/23 23:14, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> Thread A				Thread B
> - f2fs_ioc_commit_atomic_write
>  - commit_inmem_pages
>   - f2fs_submit_merged_write_cond
>   : write data
> 					- write_checkpoint
> 					 - do_checkpoint
> 					 : commit all node within CP
> 					 -> SPO
>   - f2fs_do_sync_file
>    - file_write_and_wait_range
>    : wait data writeback
> 
> In above race condition, data/node can be flushed in reversed order when
> coming a checkpoint before f2fs_do_sync_file, after SPOR, it results in
> atomic written data being corrupted.
> 
> This patch adds filemap_fdatawait() in commit_inmem_pages() to keep data
> and node of atomic file being flushed orderly.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> v2:
> - clean up codes suggested by Jaegeuk.
>  fs/f2fs/file.c    | 4 ++++
>  fs/f2fs/segment.c | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index bac059474342..0cfa65c21d3f 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -217,6 +217,9 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>  
>  	trace_f2fs_sync_file_enter(inode);
>  
> +	if (atomic)
> +		goto write_done;
> +
>  	/* if fdatasync is triggered, let's do in-place-update */
>  	if (datasync || get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks)
>  		set_inode_flag(inode, FI_NEED_IPU);
> @@ -228,6 +231,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>  		return ret;
>  	}
>  
> +write_done:
>  	/* if the inode is dirty, let's recover all the time */
>  	if (!f2fs_skip_inode_update(inode, datasync)) {
>  		f2fs_write_inode(inode, NULL);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 710d817c4350..31336fc54d8e 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -419,6 +419,8 @@ static int __commit_inmem_pages(struct inode *inode)
>  		__revoke_inmem_pages(inode, &fi->inmem_pages, true, false);
>  	} else {
>  		__revoke_inmem_pages(inode, &revoke_list, false, false);
> +
> +		err = filemap_fdatawait(inode->i_mapping);
>  	}
>  
>  	return err;
> 
