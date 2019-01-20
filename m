Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8721CC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6018620823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbfAUID2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:03:28 -0500
Received: from ipmail03.adl6.internode.on.net ([150.101.137.143]:52895 "EHLO
        ipmail03.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728530AbfAUID2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:03:28 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail03.adl6.internode.on.net with ESMTP; 21 Jan 2019 09:11:01 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1glLlz-0000DZ-A3; Mon, 21 Jan 2019 09:40:59 +1100
Date:   Mon, 21 Jan 2019 09:40:59 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jann Horn <jannh@google.com>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v4 3/3] fs: let filldir_t return bool instead of an error
 code
Message-ID: <20190120224059.GA4205@dastard>
References: <20190118161440.220134-1-jannh@google.com>
 <20190118161440.220134-3-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118161440.220134-3-jannh@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 05:14:40PM +0100, Jann Horn wrote:
> As Al Viro pointed out, many filldir_t functions return error codes, but
> all callers of filldir_t functions just check whether the return value is
> non-zero (to determine whether to continue reading the directory); more
> precise errors have to be signalled via struct dir_context.
> Change all filldir_t functions to return bool instead of int.
> 
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  arch/alpha/kernel/osf_sys.c | 12 +++----
>  fs/afs/dir.c                | 30 +++++++++--------
>  fs/ecryptfs/file.c          | 13 ++++----
>  fs/exportfs/expfs.c         |  8 ++---
>  fs/fat/dir.c                |  8 ++---
>  fs/gfs2/export.c            |  6 ++--
>  fs/nfsd/nfs4recover.c       |  8 ++---
>  fs/nfsd/vfs.c               |  6 ++--
>  fs/ocfs2/dir.c              | 10 +++---
>  fs/ocfs2/journal.c          | 14 ++++----
>  fs/overlayfs/readdir.c      | 24 +++++++-------
>  fs/readdir.c                | 64 ++++++++++++++++++-------------------
>  fs/reiserfs/xattr.c         | 20 ++++++------
>  fs/xfs/scrub/dir.c          |  8 ++---
>  fs/xfs/scrub/parent.c       |  4 +--
>  include/linux/fs.h          | 10 +++---
>  16 files changed, 125 insertions(+), 120 deletions(-)
> 
> diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
> index db1c2144d477..14e5ae0dac50 100644
> --- a/arch/alpha/kernel/osf_sys.c
> +++ b/arch/alpha/kernel/osf_sys.c
> @@ -108,7 +108,7 @@ struct osf_dirent_callback {
>  	int error;
>  };
>  
> -static int
> +static bool
>  osf_filldir(struct dir_context *ctx, const char *name, int namlen,
>  	    loff_t offset, u64 ino, unsigned int d_type)
>  {
> @@ -120,14 +120,14 @@ osf_filldir(struct dir_context *ctx, const char *name, int namlen,
>  
>  	buf->error = check_dirent_name(name, namlen);
>  	if (unlikely(buf->error))
> -		return -EFSCORRUPTED;
> +		return false;
>  	buf->error = -EINVAL;	/* only used if we fail */
>  	if (reclen > buf->count)
> -		return -EINVAL;
> +		return false;

Oh, it's because the error being returned is being squashed by
dir_emit():

>  struct dir_context {
> @@ -3469,17 +3471,17 @@ static inline bool dir_emit(struct dir_context *ctx,
>  			    const char *name, int namelen,
>  			    u64 ino, unsigned type)
>  {
> -	return ctx->actor(ctx, name, namelen, ctx->pos, ino, type) == 0;
> +	return ctx->actor(ctx, name, namelen, ctx->pos, ino, type);
>  }

/me wonders if it would be cleaner to do:

static inline bool dir_emit(...)
{
	buf->error = ctx->actor(....)
	if (buf->error)
		return false;
	return true;
}

And clean up all filldir actors just to return the error state
rather than have to jump through hoops to stash the error state in
the context buffer and return the error state?

That then allows callers who want/need the full error info can
continue to call ctx->actor directly, while all those that just want
to terminate their loops on error can continue just to call
dir_emit()...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
