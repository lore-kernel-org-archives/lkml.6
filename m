Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756648AbeDZPQw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 11:16:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756597AbeDZPQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 11:16:49 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C9620C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jaegeuk@kernel.org
Date: Thu, 26 Apr 2018 09:16:47 -0600
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] f2fs: clear page_error for all the writebacking pages
Message-ID: <20180426151647.GA68594@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180423224914.46640-1-jaegeuk@kernel.org>
 <7512323f-3bea-d9ce-e0f0-e48571f93415@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7512323f-3bea-d9ce-e0f0-e48571f93415@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/24, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2018/4/24 6:49, Jaegeuk Kim wrote:
> > This patch clear page_error bit, if the page is going to be writebacked.
> 
> This patch is similar to previous patch ("f2fs: clear PageError on writepage"),
> only coverage is different, could you merge them?

Yeah, done.

> 
> Thanks,
> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/gc.c      | 1 +
> >  fs/f2fs/inline.c  | 1 +
> >  fs/f2fs/node.c    | 1 +
> >  fs/f2fs/segment.c | 1 +
> >  4 files changed, 4 insertions(+)
> > 
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index 70418b34c5f6..a7de8b3431a9 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -693,6 +693,7 @@ static void move_data_block(struct inode *inode, block_t bidx,
> >  		dec_page_count(fio.sbi, F2FS_DIRTY_META);
> >  
> >  	set_page_writeback(fio.encrypted_page);
> > +	ClearPageError(page);
> >  
> >  	/* allocate block address */
> >  	f2fs_wait_on_page_writeback(dn.node_page, NODE, true);
> > diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> > index b50e36351280..1eaa2049eafa 100644
> > --- a/fs/f2fs/inline.c
> > +++ b/fs/f2fs/inline.c
> > @@ -139,6 +139,7 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
> >  
> >  	/* write data page to try to make data consistent */
> >  	set_page_writeback(page);
> > +	ClearPageError(page);
> >  	fio.old_blkaddr = dn->data_blkaddr;
> >  	set_inode_flag(dn->inode, FI_HOT_DATA);
> >  	write_data_page(dn, &fio);
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > index ae83ca9d2d31..3a3d38b3e9ec 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -1394,6 +1394,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
> >  		fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
> >  
> >  	set_page_writeback(page);
> > +	ClearPageError(page);
> >  	fio.old_blkaddr = ni.blk_addr;
> >  	write_node_page(nid, &fio);
> >  	set_node_addr(sbi, &ni, fio.new_blkaddr, is_fsync_dnode(page));
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 3325b9959119..a99c30b4eec9 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -2758,6 +2758,7 @@ void write_meta_page(struct f2fs_sb_info *sbi, struct page *page,
> >  		fio.op_flags &= ~REQ_META;
> >  
> >  	set_page_writeback(page);
> > +	ClearPageError(page);
> >  	f2fs_submit_page_write(&fio);
> >  
> >  	f2fs_update_iostat(sbi, io_type, F2FS_BLKSIZE);
> > 
