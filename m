Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756756AbeDZPc3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 11:32:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756695AbeDZPcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 11:32:25 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 725C621745
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jaegeuk@kernel.org
Date: Thu, 26 Apr 2018 09:32:24 -0600
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 5/5] f2fs: enforce fsync_mode=strict for
 renamed directory
Message-ID: <20180426153224.GE68594@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180425054613.2700-1-jaegeuk@kernel.org>
 <20180425054613.2700-5-jaegeuk@kernel.org>
 <42858ef4-c1b8-c83e-4b47-39e28e161e16@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42858ef4-c1b8-c83e-4b47-39e28e161e16@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/25, Chao Yu wrote:
> On 2018/4/25 13:46, Jaegeuk Kim wrote:
> > This is to give a option for user to be able to recover B/foo in the below
> > case.
> > 
> > mkdir A
> > sync()
> > rename(A, B)
> > creat (B/foo)
> > fsync (B/foo)
> > ---crash---
> 
> That makes sense, IMO, it will be better to cover cross rename case as well?

file_lost_pino(old_inode) seems covering that.

> 
> Thanks,
> 
> > 
> > Sugessted-by: Velayudhan Pillai <vijay@cs.utexas.edu>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/namei.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> > index b5f404674cad..fef6e3ab2135 100644
> > --- a/fs/f2fs/namei.c
> > +++ b/fs/f2fs/namei.c
> > @@ -973,8 +973,11 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
> >  			f2fs_put_page(old_dir_page, 0);
> >  		f2fs_i_links_write(old_dir, false);
> >  	}
> > -	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
> > +	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT) {
> >  		add_ino_entry(sbi, new_dir->i_ino, TRANS_DIR_INO);
> > +		if (S_ISDIR(old_inode->i_mode))
> > +			add_ino_entry(sbi, old_inode->i_ino, TRANS_DIR_INO);
> > +	}
> >  
> >  	f2fs_unlock_op(sbi);
> >  
> > 
