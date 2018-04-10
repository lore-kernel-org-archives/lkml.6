Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752623AbeDJGkx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 02:40:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751961AbeDJGkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 02:40:52 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E62205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jaegeuk@kernel.org
Date: Mon, 9 Apr 2018 23:40:50 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: don't use GFP_ZERO for page caches
Message-ID: <20180410064050.GA61388@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180409190012.21552-1-jaegeuk@kernel.org>
 <20180409204244.GA25905@jaegeuk-macbookpro.roam.corp.google.com>
 <20180410032934.GA47598@jaegeuk-macbookpro.roam.corp.google.com>
 <b891c25a-e95e-15ff-faf9-f263bbe05eb3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b891c25a-e95e-15ff-faf9-f263bbe05eb3@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10, Chao Yu wrote:
> On 2018/4/10 11:29, Jaegeuk Kim wrote:
> > Change log from v2:
> >  - consider IO error case when dealing with metapage
> >  - memset by fill_node_footer
> > 
> > Change log from v1:
> >  - don't memset for recovered page
> >  
> > Related to https://lkml.org/lkml/2018/4/8/661
> > 
> > Sometimes, we need to write meta data to new allocated block address,
> > then we will allocate a zeroed page in inner inode's address space, and
> > fill partial data in it, and leave other place with zero value which means
> > some fields are initial status.
> > 
> > There are two inner inodes (meta inode and node inode) setting __GFP_ZERO,
> > I have just checked them, for both of them, we can avoid using __GFP_ZERO,
> > and do initialization by ourselves to avoid unneeded/redundant zeroing
> > from mm.
> > 
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/checkpoint.c | 4 +++-
> >  fs/f2fs/inode.c      | 4 ++--
> >  fs/f2fs/segment.c    | 3 +++
> >  fs/f2fs/segment.h    | 1 +
> >  4 files changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index bf779461df13..2e23b953d304 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -100,8 +100,10 @@ static struct page *__get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index,
> >  	 * readonly and make sure do not write checkpoint with non-uptodate
> >  	 * meta page.
> >  	 */
> > -	if (unlikely(!PageUptodate(page)))
> > +	if (unlikely(!PageUptodate(page))) {
> > +		memset(page_address(page), 0, PAGE_SIZE);
> >  		f2fs_stop_checkpoint(sbi, false);
> > +	}
> >  out:
> >  	return page;
> >  }
> > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > index 417c9dcd0269..87535bf63421 100644
> > --- a/fs/f2fs/inode.c
> > +++ b/fs/f2fs/inode.c
> > @@ -320,10 +320,10 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
> >  make_now:
> >  	if (ino == F2FS_NODE_INO(sbi)) {
> >  		inode->i_mapping->a_ops = &f2fs_node_aops;
> > -		mapping_set_gfp_mask(inode->i_mapping, GFP_F2FS_ZERO);
> > +		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
> >  	} else if (ino == F2FS_META_INO(sbi)) {
> >  		inode->i_mapping->a_ops = &f2fs_meta_aops;
> > -		mapping_set_gfp_mask(inode->i_mapping, GFP_F2FS_ZERO);
> > +		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
> >  	} else if (S_ISREG(inode->i_mode)) {
> >  		inode->i_op = &f2fs_file_inode_operations;
> >  		inode->i_fop = &f2fs_file_operations;
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index a4b8e3e24ccb..1f5db557ab96 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -2021,6 +2021,7 @@ static void write_current_sum_page(struct f2fs_sb_info *sbi,
> >  	struct f2fs_summary_block *dst;
> >  
> >  	dst = (struct f2fs_summary_block *)page_address(page);
> > +	memset(dst, 0, PAGE_SIZE);
> 
> We will fill all summary page later, so we don't need initialize it?

I'd like to reserve the uninitialzed space as zeros for future reference.

> 
> >  
> >  	mutex_lock(&curseg->curseg_mutex);
> >  
> > @@ -3117,6 +3118,7 @@ static void write_compacted_summaries(struct f2fs_sb_info *sbi, block_t blkaddr)
> >  
> >  	page = grab_meta_page(sbi, blkaddr++);
> >  	kaddr = (unsigned char *)page_address(page);
> > +	memset(kaddr, 0, PAGE_SIZE);
> 
> I checked here, we will not use uninitialized space due to:
> 
> read_compacted_summaries()
> {
> ...
> 	if (offset + SUMMARY_SIZE <= PAGE_SIZE - SUM_FOOTER_SIZE)
> 		continue;
> ...
> }
> 
> Are we safe here?
> 
> >  
> >  	/* Step 1: write nat cache */
> >  	seg_i = CURSEG_I(sbi, CURSEG_HOT_DATA);
> > @@ -3141,6 +3143,7 @@ static void write_compacted_summaries(struct f2fs_sb_info *sbi, block_t blkaddr)
> >  			if (!page) {
> >  				page = grab_meta_page(sbi, blkaddr++);
> >  				kaddr = (unsigned char *)page_address(page);
> > +				memset(kaddr, 0, PAGE_SIZE);
> 
> Ditto.
> 
> >  				written_size = 0;
> >  			}
> >  			summary = (struct f2fs_summary *)(kaddr + written_size);
> > diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> > index 3325d0769723..492ad0c86fa9 100644
> > --- a/fs/f2fs/segment.h
> > +++ b/fs/f2fs/segment.h
> > @@ -375,6 +375,7 @@ static inline void seg_info_to_sit_page(struct f2fs_sb_info *sbi,
> >  	int i;
> >  
> >  	raw_sit = (struct f2fs_sit_block *)page_address(page);
> > +	memset(raw_sit, 0, PAGE_SIZE);
> 
> I suspect that root cause of panic is that we don't memset here?
> 
> Thanks,
> 
> >  	for (i = 0; i < end - start; i++) {
> >  		rs = &raw_sit->entries[i];
> >  		se = get_seg_entry(sbi, start + i);
> > 
