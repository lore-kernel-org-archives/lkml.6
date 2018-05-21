Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751251AbeEUXXO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 19:23:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751050AbeEUXXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 19:23:13 -0400
Message-ID: <8d77f3d146c5b922efac398dbdce3dd920142446.camel@kernel.org>
Subject: Re: [RFC PATCH 08/11] xfs: have sync_fs op report writeback errors
 when passed a since pointer
From: Jeff Layton <jlayton@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@ZenIV.linux.org.uk, willy@infradead.org, andres@anarazel.de
Date: Mon, 21 May 2018 19:23:10 -0400
In-Reply-To: <20180521230144.GQ10363@dastard>
References: <20180518123415.28181-1-jlayton@kernel.org>
         <20180518123415.28181-9-jlayton@kernel.org>
         <20180521230144.GQ10363@dastard>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-05-22 at 09:01 +1000, Dave Chinner wrote:
> On Fri, May 18, 2018 at 08:34:12AM -0400, Jeff Layton wrote:
> > From: Jeff Layton <jlayton@redhat.com>
> > 
> > Signed-off-by: Jeff Layton <jlayton@redhat.com>
> > ---
> >  fs/xfs/xfs_super.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > index 9255de2767b4..7dc847f48f9f 100644
> > --- a/fs/xfs/xfs_super.c
> > +++ b/fs/xfs/xfs_super.c
> > @@ -1092,6 +1092,7 @@ xfs_fs_sync_fs(
> >  	int			wait,
> >  	errseq_t		*since)
> >  {
> > +	int			ret;
> >  	struct xfs_mount	*mp = XFS_M(sb);
> >  
> >  	/*
> > @@ -1110,7 +1111,13 @@ xfs_fs_sync_fs(
> >  		flush_delayed_work(&mp->m_log->l_work);
> >  	}
> >  out:
> > -	return __sync_blockdev(sb->s_bdev, wait);
> 
> Where did this come from? XFS doesn't use the underlying blockdev
> address space, so this does nothing at all and should not be here.
> 

An earlier patch that pushed this down into the sync_fs routines. We
call this today for all filesystems, and I wasn't sure about xfs.

Christoph already pointed out that it's not needed so it's removed from
my current branch.
 
> > +	ret = __sync_blockdev(sb->s_bdev, wait);
> > +	if (since) {
> > +		int ret2 = errseq_check_and_advance(&sb->s_wb_err, since);
> > +		if (ret == 0)
> > +			ret = ret2;
> > +	}
> > +	return ret;
> >  }
> 
> So to return errors correctly, xfs_fs_sync_fs() needs to capture
> errors from the log force (i.e. metadata errors such as filesystem
> shutdowns, journal IO errors, etc), then check for pending data IO
> errors. i.e:
> 
> 
>  STATIC int
>  xfs_fs_sync_fs(
>  	struct super_block      *sb,
>  	int                     wait)
>  {
>  	struct xfs_mount        *mp = XFS_M(sb);
> +	int			err;
>  
>  	/*
>  	 * Doing anything during the async pass would be counterproductive.
>  	 */
>  	if (!wait)
>  		return 0;
>  
> -	xfs_log_force(mp, XFS_LOG_SYNC);
> +	err = xfs_log_force(mp, XFS_LOG_SYNC);
> +	if (err)
> +		return err;
> +
>  	if (laptop_mode) {
>  		/*
>  		 * The disk must be active because we're syncing.
>  		 * We schedule log work now (now that the disk is
>  		 * active) instead of later (when it might not be).
>  		 */
>  		flush_delayed_work(&mp->m_log->l_work);
>  	}
>  
> -	return 0
> +	return errseq_check_and_advance(&sb->s_wb_err, since);
>  }
> 

Ok, sounds good. I'll fix that too.

FWIW, we'll actually want to advance the cursor even if xfs_log_force
returns an error to ensure that we don't end up reporting errors twice,
but that's simple enough to do.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>
