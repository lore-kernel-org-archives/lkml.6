Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbeC3QbE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 12:31:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751749AbeC3QbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 12:31:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 142BF217A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jaegeuk@kernel.org
Date: Fri, 30 Mar 2018 09:31:02 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] f2fs: remain written times to update inode during fsync
Message-ID: <20180330163102.GD44823@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180330055126.36202-1-jaegeuk@kernel.org>
 <f25729ee-cd16-0029-a8ff-1daa5b82dd06@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f25729ee-cd16-0029-a8ff-1daa5b82dd06@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/30, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2018/3/30 13:51, Jaegeuk Kim wrote:
> > This fixes xfstests/generic/392.
> 
> Hmm... Could you please give more details about this issue and solution in
> commit message, since I can catch up the solution only with the code.

Yeah, I missed some explanation. :P

> 
> Thanks,
> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/f2fs.h  | 15 +++++++++++++++
> >  fs/f2fs/inode.c |  4 ++++
> >  2 files changed, 19 insertions(+)
> > 
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 000f93f6767e..675c39d85111 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -664,6 +664,7 @@ struct f2fs_inode_info {
> >  	kprojid_t i_projid;		/* id for project quota */
> >  	int i_inline_xattr_size;	/* inline xattr size */
> >  	struct timespec i_crtime;	/* inode creation time */
> > +	struct timespec i_disk_time[4];	/* inode disk times */
> >  };
> >  
> >  static inline void get_extent_info(struct extent_info *ext,
> > @@ -2457,6 +2458,11 @@ static inline void clear_file(struct inode *inode, int type)
> >  	f2fs_mark_inode_dirty_sync(inode, true);
> >  }
> >  
> > +static inline bool time_equal(struct timespec a, struct timespec b)
> > +{
> > +	return (a.tv_sec == b.tv_sec) && (a.tv_nsec == b.tv_nsec);
> > +}
> > +
> >  static inline bool f2fs_skip_inode_update(struct inode *inode, int dsync)
> >  {
> >  	bool ret;
> > @@ -2474,6 +2480,15 @@ static inline bool f2fs_skip_inode_update(struct inode *inode, int dsync)
> >  			i_size_read(inode) & ~PAGE_MASK)
> >  		return false;
> >  
> > +	if (!time_equal(F2FS_I(inode)->i_disk_time[0], inode->i_atime))
> > +		return false;
> > +	if (!time_equal(F2FS_I(inode)->i_disk_time[1], inode->i_ctime))
> > +		return false;
> > +	if (!time_equal(F2FS_I(inode)->i_disk_time[2], inode->i_mtime))
> > +		return false;
> > +	if (!time_equal(F2FS_I(inode)->i_disk_time[3], F2FS_I(inode)->i_crtime))
> > +		return false;
> > +
> >  	down_read(&F2FS_I(inode)->i_sem);
> >  	ret = F2FS_I(inode)->last_disk_size == i_size_read(inode);
> >  	up_read(&F2FS_I(inode)->i_sem);
> > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > index 401f09ccce7e..70aba580f4b0 100644
> > --- a/fs/f2fs/inode.c
> > +++ b/fs/f2fs/inode.c
> > @@ -444,6 +444,10 @@ void update_inode(struct inode *inode, struct page *node_page)
> >  	if (inode->i_nlink == 0)
> >  		clear_inline_node(node_page);
> >  
> > +	F2FS_I(inode)->i_disk_time[0] = inode->i_atime;
> > +	F2FS_I(inode)->i_disk_time[1] = inode->i_ctime;
> > +	F2FS_I(inode)->i_disk_time[2] = inode->i_mtime;
> > +	F2FS_I(inode)->i_disk_time[3] = F2FS_I(inode)->i_crtime;
> >  }
> >  
> >  void update_inode_page(struct inode *inode)
> > 
