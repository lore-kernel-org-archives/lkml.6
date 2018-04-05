Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754316AbeDEDqM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 23:46:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754268AbeDEDqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 23:46:10 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA5320CAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jaegeuk@kernel.org
Date: Wed, 4 Apr 2018 20:46:09 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        chao@kernel.org
Subject: Re: [PATCH] f2fs: fix to show encrypt flag in FS_IOC_GETFLAGS
Message-ID: <20180405034609.GA50337@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180402102446.32832-1-yuchao0@huawei.com>
 <20180402202105.GB19195@jaegeuk-macbookpro.roam.corp.google.com>
 <3f76800a-8b68-b378-8b03-c14248966be4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f76800a-8b68-b378-8b03-c14248966be4@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03, Chao Yu wrote:
> On 2018/4/3 4:21, Jaegeuk Kim wrote:
> > On 04/02, Chao Yu wrote:
> >> This patch fixes to show encrypt flag in FS_IOC_GETFLAGS like ext4 does.
> > 
> > Actually, we have to show internal flags owned by f2fs, not generic ones.
> > We may need to define all of them separately?
> 
> Agreed, I wrote a patch, could check that? and in that patch, do we need to
> delete flag definition f2fs don't use?

IMO, we'd better keep the flags. I merged it and could you add encryption part
on top of it?

Thanks,

> 
> Thanks,
> 
> > 
> >>
> >> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >>  fs/f2fs/file.c | 9 +++++++--
> >>  1 file changed, 7 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >> index 8068b015ece5..271fadadaa36 100644
> >> --- a/fs/f2fs/file.c
> >> +++ b/fs/f2fs/file.c
> >> @@ -1584,8 +1584,13 @@ static int f2fs_ioc_getflags(struct file *filp, unsigned long arg)
> >>  {
> >>  	struct inode *inode = file_inode(filp);
> >>  	struct f2fs_inode_info *fi = F2FS_I(inode);
> >> -	unsigned int flags = fi->i_flags &
> >> -			(FS_FL_USER_VISIBLE | FS_PROJINHERIT_FL);
> >> +	unsigned int flags = fi->i_flags;
> >> +
> >> +	if (file_is_encrypt(inode))
> >> +		flags |= FS_ENCRYPT_FL;
> >> +
> >> +	flags &= FS_FL_USER_VISIBLE | FS_PROJINHERIT_FL;
> >> +
> >>  	return put_user(flags, (int __user *)arg);
> >>  }
> >>  
> >> -- 
> >> 2.15.0.55.gc2ece9dc4de6
> > 
> > .
> > 
