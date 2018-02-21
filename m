Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751385AbeBUV4J (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:56:09 -0500
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:51436 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750790AbeBUV4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 16:56:08 -0500
Date: Thu, 22 Feb 2018 08:56:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: Garry McNulty <garrmcnu@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, hch@lst.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/iomap: fix memory leak on error condition
Message-ID: <20180221215605.GK6778@dastard>
References: <20180221204128.5846-1-garrmcnu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221204128.5846-1-garrmcnu@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 08:41:28PM +0000, Garry McNulty wrote:
> If the call to is_sync_kiocb() fails an error is returned without
> freeing dio. Set the return code and jump to out_free_dio.
> 
> Detected by CoverityScan, CID 1429424 ("Resource leak")

Coverity is wrong.

> Signed-off-by: Garry McNulty <garrmcnu@gmail.com>
> ---
>  fs/iomap.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap.c b/fs/iomap.c
> index afd163586aa0..65c5db38c15a 100644
> --- a/fs/iomap.c
> +++ b/fs/iomap.c
> @@ -1063,8 +1063,10 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		iomap_dio_set_error(dio, ret);
>  
>  	if (!atomic_dec_and_test(&dio->ref)) {
> -		if (!is_sync_kiocb(iocb))
> -			return -EIOCBQUEUED;
> +		if (!is_sync_kiocb(iocb)) {
> +			ret = -EIOCBQUEUED;
> +			goto out_free_dio;
> +		}

This is where we return after AIO submission. The struct dio has
already been attached to the bio we have submitted, and will be
freed on IO completion.  We are simply not waiting for IO completion
here, instead leaving it to the completion code to free the struct
dio and pass the completion status to the AIO code appropriately.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
