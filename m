Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932641AbeEHOiZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 10:38:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54984 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932375AbeEHOiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 10:38:23 -0400
Date: Tue, 8 May 2018 07:38:02 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 21/35] ovl: add reflink/copyfile/dedup support
Message-ID: <20180508143802.GC9510@magnolia>
References: <20180507083807.28792-1-mszeredi@redhat.com>
 <20180507083807.28792-22-mszeredi@redhat.com>
 <20180507204350.GB9510@magnolia>
 <CAJfpegu_iYLUeYU_OgZryFmCqa_a9MHt32nnsu7h_+JVXJ2d4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegu_iYLUeYU_OgZryFmCqa_a9MHt32nnsu7h_+JVXJ2d4w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8886 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805080140
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 04:13:01PM +0200, Miklos Szeredi wrote:
> On Mon, May 7, 2018 at 10:43 PM, Darrick J. Wong
> <darrick.wong@oracle.com> wrote:
> > On Mon, May 07, 2018 at 10:37:53AM +0200, Miklos Szeredi wrote:
> >> Since set of arguments are so similar, handle in a common helper.
> >>
> >> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> >> ---
> >>  fs/overlayfs/file.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 88 insertions(+)
> >>
> >> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> >> index ce871a15e185..2ac95c95e8e6 100644
> >> --- a/fs/overlayfs/file.c
> >> +++ b/fs/overlayfs/file.c
> >> @@ -382,6 +382,90 @@ static long ovl_compat_ioctl(struct file *file, unsigned int cmd,
> >>       return ovl_ioctl(file, cmd, arg);
> >>  }
> >>
> >> +enum ovl_copyop {
> >> +     OVL_COPY,
> >> +     OVL_CLONE,
> >> +     OVL_DEDUPE,
> >> +};
> >> +
> >> +static s64 ovl_copyfile(struct file *file_in, loff_t pos_in,
> >> +                     struct file *file_out, loff_t pos_out,
> >> +                     u64 len, unsigned int flags, enum ovl_copyop op)
> >> +{
> >> +     struct inode *inode_out = file_inode(file_out);
> >> +     struct fd real_in, real_out;
> >> +     const struct cred *old_cred;
> >> +     s64 ret;
> >> +
> >> +     ret = ovl_real_fdget(file_out, &real_out);
> >> +     if (ret)
> >> +             return ret;
> >> +
> >> +     ret = ovl_real_fdget(file_in, &real_in);
> >> +     if (ret) {
> >> +             fdput(real_out);
> >> +             return ret;
> >> +     }
> >> +
> >> +     old_cred = ovl_override_creds(file_inode(file_out)->i_sb);
> >> +     switch (op) {
> >> +     case OVL_COPY:
> >> +             ret = vfs_copy_file_range(real_in.file, pos_in,
> >> +                                       real_out.file, pos_out, len, flags);
> >> +             break;
> >> +
> >> +     case OVL_CLONE:
> >> +             ret = vfs_clone_file_range(real_in.file, pos_in,
> >> +                                        real_out.file, pos_out, len);
> >> +             break;
> >> +
> >> +     case OVL_DEDUPE:
> >> +             ret = vfs_dedupe_file_range_one(real_in.file, pos_in,
> >> +                                             real_out.file, pos_out, len);
> >> +             break;
> >> +     }
> >> +     revert_creds(old_cred);
> >> +
> >> +     /* Update size */
> >> +     ovl_copyattr(ovl_inode_real(inode_out), inode_out);
> >> +
> >> +     fdput(real_in);
> >> +     fdput(real_out);
> >> +
> >> +     return ret;
> >> +}
> >> +
> >> +static ssize_t ovl_copy_file_range(struct file *file_in, loff_t pos_in,
> >> +                                struct file *file_out, loff_t pos_out,
> >> +                                size_t len, unsigned int flags)
> >> +{
> >> +     return ovl_copyfile(file_in, pos_in, file_out, pos_out, len, flags,
> >> +                         OVL_COPY);
> >> +}
> >> +
> >> +static int ovl_clone_file_range(struct file *file_in, loff_t pos_in,
> >> +                             struct file *file_out, loff_t pos_out, u64 len)
> >> +{
> >> +     return ovl_copyfile(file_in, pos_in, file_out, pos_out, len, 0,
> >> +                         OVL_CLONE);
> >> +}
> >> +
> >> +static s64 ovl_dedupe_file_range(struct file *file_in, loff_t pos_in,
> >> +                              struct file *file_out, loff_t pos_out,
> >> +                              u64 len)
> >> +{
> >> +     /*
> >> +      * Don't copy up because of a dedupe request, this wouldn't make sense
> >> +      * most of the time (data would be duplicated instead of deduplicated).
> >> +      */
> >> +     if (!ovl_inode_upper(file_inode(file_in)) ||
> >> +         !ovl_inode_upper(file_inode(file_out)))
> >> +             return -EPERM;
> >
> > /me wonders, why not EOPNOTSUPP?  That's what we've been using (in xfs
> > anyway) for "filesystem doesn't want to let you do this".
> 
> EOPNOTSUPP might be interpreted as "this filesystem doesn't support
> dedupe", even though here it's just "these two particular files don't
> support dedupe".

ocfs2 already uses EOPNOTSUPP for 'these two particular files don't
support dedupe/reflink'.  Granted, the manpage would seem to leave open
the possibility of using EOPNOTSUPP or EINVAL for the "can't do it to
these two files" case.

--D

> >
> > (Or I guess EXDEV, but "cross-device link not supported" might not be
> > quite what you want users to see...)
> 
> Hmm, I like EPERM better.   EPERM means something like  "you can't do
> this for some unspecified reason".  This is exactly the case here.
> 
> Thanks,
> Miklos
