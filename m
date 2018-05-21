Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751368AbeEUXBv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 19:01:51 -0400
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:42174 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750942AbeEUXBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 19:01:47 -0400
Date: Tue, 22 May 2018 09:01:44 +1000
From: Dave Chinner <david@fromorbit.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@ZenIV.linux.org.uk, willy@infradead.org, andres@anarazel.de
Subject: Re: [RFC PATCH 08/11] xfs: have sync_fs op report writeback errors
 when passed a since pointer
Message-ID: <20180521230144.GQ10363@dastard>
References: <20180518123415.28181-1-jlayton@kernel.org>
 <20180518123415.28181-9-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518123415.28181-9-jlayton@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 08:34:12AM -0400, Jeff Layton wrote:
> From: Jeff Layton <jlayton@redhat.com>
> 
> Signed-off-by: Jeff Layton <jlayton@redhat.com>
> ---
>  fs/xfs/xfs_super.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 9255de2767b4..7dc847f48f9f 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1092,6 +1092,7 @@ xfs_fs_sync_fs(
>  	int			wait,
>  	errseq_t		*since)
>  {
> +	int			ret;
>  	struct xfs_mount	*mp = XFS_M(sb);
>  
>  	/*
> @@ -1110,7 +1111,13 @@ xfs_fs_sync_fs(
>  		flush_delayed_work(&mp->m_log->l_work);
>  	}
>  out:
> -	return __sync_blockdev(sb->s_bdev, wait);

Where did this come from? XFS doesn't use the underlying blockdev
address space, so this does nothing at all and should not be here.

> +	ret = __sync_blockdev(sb->s_bdev, wait);
> +	if (since) {
> +		int ret2 = errseq_check_and_advance(&sb->s_wb_err, since);
> +		if (ret == 0)
> +			ret = ret2;
> +	}
> +	return ret;
>  }

So to return errors correctly, xfs_fs_sync_fs() needs to capture
errors from the log force (i.e. metadata errors such as filesystem
shutdowns, journal IO errors, etc), then check for pending data IO
errors. i.e:


 STATIC int
 xfs_fs_sync_fs(
 	struct super_block      *sb,
 	int                     wait)
 {
 	struct xfs_mount        *mp = XFS_M(sb);
+	int			err;
 
 	/*
 	 * Doing anything during the async pass would be counterproductive.
 	 */
 	if (!wait)
 		return 0;
 
-	xfs_log_force(mp, XFS_LOG_SYNC);
+	err = xfs_log_force(mp, XFS_LOG_SYNC);
+	if (err)
+		return err;
+
 	if (laptop_mode) {
 		/*
 		 * The disk must be active because we're syncing.
 		 * We schedule log work now (now that the disk is
 		 * active) instead of later (when it might not be).
 		 */
 		flush_delayed_work(&mp->m_log->l_work);
 	}
 
-	return 0
+	return errseq_check_and_advance(&sb->s_wb_err, since);
 }

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
