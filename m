Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751921AbeERBIa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 21:08:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751642AbeERBI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 21:08:29 -0400
Date: Thu, 17 May 2018 18:08:26 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Cc: Sahitya Tummala <stummala@codeaurora.org>,
        linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: Fix deadlock in shutdown ioctl
Message-ID: <20180518010826.GC33876@jaegeuk-macbookpro.roam.corp.google.com>
References: <1526544211-26218-1-git-send-email-stummala@codeaurora.org>
 <b7d045f3-f37b-46da-3c1c-2b6d99efc9e7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7d045f3-f37b-46da-3c1c-2b6d99efc9e7@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/17, Chao Yu wrote:
> On 2018/5/17 16:03, Sahitya Tummala wrote:
> > f2fs_ioc_shutdown() ioctl gets stuck in the below path
> > when issued with F2FS_GOING_DOWN_FULLSYNC option.
> > 
> > __switch_to+0x90/0xc4
> > percpu_down_write+0x8c/0xc0
> > freeze_super+0xec/0x1e4
> > freeze_bdev+0xc4/0xcc
> > f2fs_ioctl+0xc0c/0x1ce0
> > f2fs_compat_ioctl+0x98/0x1f0
> > 
> > Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> > ---
> > v2:
> > remove lock coverage for only F2FS_GOING_DOWN_FULLSYNC case as suggested by Chao.
> > 
> >  fs/f2fs/file.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 6b94f19..5a132c9 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -1857,6 +1857,7 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
> 
> How about:
> 
> if (in != F2FS_GOING_DOWN_FULLSYNC)
> 	mnt_want_write_file();
> 
> switch()
> {
> 	handle command;
> }
> 
> if (in != F2FS_GOING_DOWN_FULLSYNC)
> 	mnt_drop_write_file();
> 
> Thanks,

if (in == F2FS_GOING_DOWN_FULLSYNC) {
	sb = freeze_bdev();
	if (IS_ERR(sb))
		return PTR_ERR(sb);
	if (unlikely(!sb))
		return -EINVAL;
}

ret = mnt_want_write_file();
...
switch() {
case F2FS_GOING_DOWN_FULLSYNC:
	f2fs_stop_checkpoint();
	dhaw_bdev();
	break;
...
}

drop:
...


> 
> >  
> >  	switch (in) {
> >  	case F2FS_GOING_DOWN_FULLSYNC:
> > +		mnt_drop_write_file(filp);
> >  		sb = freeze_bdev(sb->s_bdev);
> >  		if (IS_ERR(sb)) {
> >  			ret = PTR_ERR(sb);
> > @@ -1894,7 +1895,8 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
> >  
> >  	f2fs_update_time(sbi, REQ_TIME);
> >  out:
> > -	mnt_drop_write_file(filp);
> > +	if (in != F2FS_GOING_DOWN_FULLSYNC)
> > +		mnt_drop_write_file(filp);
> >  	return ret;
> >  }
> >  
> > 
