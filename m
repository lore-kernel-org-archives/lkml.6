Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755452AbeDWNxM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 09:53:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755126AbeDWNxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 09:53:10 -0400
Date: Mon, 23 Apr 2018 09:53:09 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 13/35] ovl: readd fsync
Message-ID: <20180423135309.GC2794@redhat.com>
References: <20180412150826.20988-1-mszeredi@redhat.com>
 <20180412150826.20988-14-mszeredi@redhat.com>
 <20180423133617.GB2794@redhat.com>
 <CAJfpegsmxOtn9yjy4fvsYOt7cL49mzOM00bh8+CgxJcT3meLBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsmxOtn9yjy4fvsYOt7cL49mzOM00bh8+CgxJcT3meLBQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 03:39:45PM +0200, Miklos Szeredi wrote:
> On Mon, Apr 23, 2018 at 3:36 PM, Vivek Goyal <vgoyal@redhat.com> wrote:
> > On Thu, Apr 12, 2018 at 05:08:04PM +0200, Miklos Szeredi wrote:
> >> Implement stacked fsync().
> >>
> >> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> >> ---
> >>  fs/overlayfs/file.c | 20 ++++++++++++++++++++
> >>  1 file changed, 20 insertions(+)
> >>
> >> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> >> index b98204c1c19c..4417527667ff 100644
> >> --- a/fs/overlayfs/file.c
> >> +++ b/fs/overlayfs/file.c
> >> @@ -222,10 +222,30 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
> >>       return ret;
> >>  }
> >>
> >> +static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
> >> +{
> >> +     struct fd real;
> >> +     const struct cred *old_cred;
> >> +     int ret;
> >> +
> >> +     ret = ovl_real_file(file, &real);
> >> +     if (ret)
> >> +             return ret;
> >> +
> >> +     old_cred = ovl_override_creds(file_inode(file)->i_sb);
> >> +     ret = vfs_fsync_range(real.file, start, end, datasync);
> >> +     revert_creds(old_cred);
> >
> > Can we avoid calling fsync() on real file if it is not upper. Is it worth
> > optimizing.
> 
> Not sure it's worth bothering with.   If caller of fsync(2) didn't
> worry about cost, then why should we?

I was thinking more from the point of view of metadata copy up patches.
For a metacopy file, I was thinking if I can just issue fsync() on upper
file and skip it on lower file.  

Anyway, I don't have any strong opinion here.

Vivek
