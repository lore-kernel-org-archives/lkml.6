Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FF0C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC86218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5k+tBmfO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfAaUkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:40:25 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60100 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfAaUkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:40:25 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0VKd2Tn164436;
        Thu, 31 Jan 2019 20:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Lz5JHc+Ue+BmrKXLjFXGNF4LxQlSB+QOkl0q+V6XNq8=;
 b=5k+tBmfO1XidU4vgYSd65UjEKrHUAqzZMhZqcsOeT3jSvL64vmsgip7BagP6R8YlKjcX
 t20oDYvoY38zo9thiugJQkG0SK/SDhT9s1+VS4dZPYQB5qGCW/rCfAcLFgFBvs+MvK8w
 Tf6I6v8izo0WxFginA/R9rexuMJJYFlOjXjZai/RRayFChXfioT7yEYfmOuig3iA6RU4
 i6sRxi+YIXGirAPFW6sWdv5z1ZZfrGoZ+vp2lu4wwTWjRHzG0q9rtoYUcmTf70NeA8FX
 RLmy20EPZqNNSo66f4bgdRyJEl2NczbYnnDyo5EkiNYkQN9nEB61swfTwySXtyxejh1t Dg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2q8eyuu27k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Jan 2019 20:39:50 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0VKdiUt022582
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Jan 2019 20:39:44 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0VKdgEf006565;
        Thu, 31 Jan 2019 20:39:42 GMT
Received: from localhost (/10.159.246.84)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 31 Jan 2019 12:39:42 -0800
Date:   Thu, 31 Jan 2019 12:39:40 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jann Horn <jannh@google.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-alpha@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] fs: let filldir_t return bool instead of an error
 code
Message-ID: <20190131203940.GA27972@magnolia>
References: <20190118161440.220134-1-jannh@google.com>
 <20190118161440.220134-3-jannh@google.com>
 <20190120224059.GA4205@dastard>
 <CAG48ez3SgejgGbctHwxON1B1k26xk-z16xdozKZkx7=-Li0aHw@mail.gmail.com>
 <20190121222411.GD4205@dastard>
 <CAG48ez2UmgEkitbgyCCs9LLdgahweFFAJWCU_vcqES6YgN=gLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2UmgEkitbgyCCs9LLdgahweFFAJWCU_vcqES6YgN=gLw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9153 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1901310152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 04:07:59PM +0100, Jann Horn wrote:
> On Mon, Jan 21, 2019 at 11:24 PM Dave Chinner <david@fromorbit.com> wrote:
> > On Mon, Jan 21, 2019 at 04:49:45PM +0100, Jann Horn wrote:
> > > On Sun, Jan 20, 2019 at 11:41 PM Dave Chinner <david@fromorbit.com> wrote:
> > > > On Fri, Jan 18, 2019 at 05:14:40PM +0100, Jann Horn wrote:
> > > > > As Al Viro pointed out, many filldir_t functions return error codes, but
> > > > > all callers of filldir_t functions just check whether the return value is
> > > > > non-zero (to determine whether to continue reading the directory); more
> > > > > precise errors have to be signalled via struct dir_context.
> > > > > Change all filldir_t functions to return bool instead of int.
> > > > >
> > > > > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > > > > Signed-off-by: Jann Horn <jannh@google.com>
> > > > > ---
> > > > >  arch/alpha/kernel/osf_sys.c | 12 +++----
> > > > >  fs/afs/dir.c                | 30 +++++++++--------
> > > > >  fs/ecryptfs/file.c          | 13 ++++----
> > > > >  fs/exportfs/expfs.c         |  8 ++---
> > > > >  fs/fat/dir.c                |  8 ++---
> > > > >  fs/gfs2/export.c            |  6 ++--
> > > > >  fs/nfsd/nfs4recover.c       |  8 ++---
> > > > >  fs/nfsd/vfs.c               |  6 ++--
> > > > >  fs/ocfs2/dir.c              | 10 +++---
> > > > >  fs/ocfs2/journal.c          | 14 ++++----
> > > > >  fs/overlayfs/readdir.c      | 24 +++++++-------
> > > > >  fs/readdir.c                | 64 ++++++++++++++++++-------------------
> > > > >  fs/reiserfs/xattr.c         | 20 ++++++------
> > > > >  fs/xfs/scrub/dir.c          |  8 ++---
> > > > >  fs/xfs/scrub/parent.c       |  4 +--
> > > > >  include/linux/fs.h          | 10 +++---
> > > > >  16 files changed, 125 insertions(+), 120 deletions(-)
> > > > >
> > > > > diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
> > > > > index db1c2144d477..14e5ae0dac50 100644
> > > > > --- a/arch/alpha/kernel/osf_sys.c
> > > > > +++ b/arch/alpha/kernel/osf_sys.c
> > > > > @@ -108,7 +108,7 @@ struct osf_dirent_callback {
> > > > >       int error;
> > > > >  };
> > > > >
> > > > > -static int
> > > > > +static bool
> > > > >  osf_filldir(struct dir_context *ctx, const char *name, int namlen,
> > > > >           loff_t offset, u64 ino, unsigned int d_type)
> > > > >  {
> > > > > @@ -120,14 +120,14 @@ osf_filldir(struct dir_context *ctx, const char *name, int namlen,
> > > > >
> > > > >       buf->error = check_dirent_name(name, namlen);
> > > > >       if (unlikely(buf->error))
> > > > > -             return -EFSCORRUPTED;
> > > > > +             return false;
> > > > >       buf->error = -EINVAL;   /* only used if we fail */
> > > > >       if (reclen > buf->count)
> > > > > -             return -EINVAL;
> > > > > +             return false;
> > > >
> > > > Oh, it's because the error being returned is being squashed by
> > > > dir_emit():
> > >
> > > Yeah.
> > >
> > > > >  struct dir_context {
> > > > > @@ -3469,17 +3471,17 @@ static inline bool dir_emit(struct dir_context *ctx,
> > > > >                           const char *name, int namelen,
> > > > >                           u64 ino, unsigned type)
> > > > >  {
> > > > > -     return ctx->actor(ctx, name, namelen, ctx->pos, ino, type) == 0;
> > > > > +     return ctx->actor(ctx, name, namelen, ctx->pos, ino, type);
> > > > >  }
> > > >
> > > > /me wonders if it would be cleaner to do:
> > > >
> > > > static inline bool dir_emit(...)
> > > > {
> > > >         buf->error = ctx->actor(....)
> > > >         if (buf->error)
> > > >                 return false;
> > > >         return true;
> > > > }
> > > >
> > > > And clean up all filldir actors just to return the error state
> > > > rather than have to jump through hoops to stash the error state in
> > > > the context buffer and return the error state?
> > >
> > > One negative thing about that, IMO, is that it mixes up the request
> > > for termination of the loop and the presence of an error.
> >
> > Doesn't the code already do that, only worse?
> 
> The current code does that, yes. But with this patch, I think that's
> not really the case anymore?
> 
> > > > That then allows callers who want/need the full error info can
> > > > continue to call ctx->actor directly,
> > >
> > > "continue to call ctx->actor directly"? I don't remember any code that
> > > calls ctx->actor directly.
> >
> > ovl_fill_real().
> 
> Ah, right.
> 
> 
> > And the XFS directory scrubber could probably make better use of the
> > error return from ctx->actor when validating the directory contents
> > rather than just calling dir_emit() and aborting the scan at the
> > first error encountered. We eventually want to know exactly what
> > error was encountered here to determine if it is safe to continue,
> > not just a "stop processing" flag. e.g. a bad name length will need
> > to stop traversal because we can't trust the underlying structure,
> > but an invalid file type isn't a structural flaw that prevents us
> > from continuing to traverse and check the rest of the directory....
> 
> Sorry, maybe I'm a bit dense right now, I don't get your point. Are
> you talking about filesystem errors detected in the actor? If so,
> doesn't it make *more* sense for non-fatal errors to put a note that
> an error happened into the xchk_dir_ctx (if that information should be
> kept around), then return a value that says "please continue"?

As I understand the scrub code, we /do/ stash the error state elsewhere
and set the xchk_dir_actor return value as appropriate to continue or
stop the directory iteration.  Granted, it's not very nuanced since
anything out of order sets the CORRUPT flag and aborts the iteration,
but in principle xchk_dir_actor could set the scrub warning flag and
return 0 if it wanted to.

(So maybe I'm dense too, but I don't know what Dave is talking
about...?)

--D

> Or are you talking about filesystem errors detected in the readdir
> implementation? In that case, you're AFAICS going to need special-case
> logic gated on ctx->actor==xchk_dir_actor anyway if you want the
> scrubber to continue while readdir() stops.
> 
> (But as I've said, I don't really care about this patch. If Al takes
> patches 1 and 2 from this series, I'm happy; this patch is just in
> response to <https://lore.kernel.org/lkml/20180731165112.GJ30522@ZenIV.linux.org.uk/>.)
