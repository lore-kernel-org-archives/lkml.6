Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935573AbeCCAYD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 19:24:03 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:39862 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935479AbeCCAYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 19:24:02 -0500
Date: Fri, 2 Mar 2018 16:24:00 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Nikolay Borisov <nborisov@suse.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH] direct-io: Minor cleanups in do_blockdev_direct_IO
Message-Id: <20180302162400.f36d0d068bd0a08442536a2c@linux-foundation.org>
In-Reply-To: <1519638870-17756-1-git-send-email-nborisov@suse.com>
References: <1519638870-17756-1-git-send-email-nborisov@suse.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Feb 2018 11:54:30 +0200 Nikolay Borisov <nborisov@suse.com> wrote:

> We already get the block counts and the calculate the end block at the
> beginning of the function. Let's use the local variables for consistency and
> readability. No functional changes
> 

Fair enough.

> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -1200,7 +1200,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>  	}
>  
>  	/* watch out for a 0 len io from a tricksy fs */
> -	if (iov_iter_rw(iter) == READ && !iov_iter_count(iter))
> +	if (iov_iter_rw(iter) == READ && !count)
>  		return 0;
>  
>  	dio = kmem_cache_alloc(dio_cache, GFP_KERNEL);
> @@ -1316,8 +1316,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>  
>  	dio->should_dirty = (iter->type == ITER_IOVEC);
>  	sdio.iter = iter;
> -	sdio.final_block_in_request =
> -		(offset + iov_iter_count(iter)) >> blkbits;
> +	sdio.final_block_in_request = end >> blkbits;
>  
>  	/*
>  	 * In case of non-aligned buffers, we may need 2 more

It's always scary to see a local being used in this fashion so far away
from where it was initialized.  However, we can get our warm fuzzy
feelings by doing this:

--- a/fs/direct-io.c~direct-io-minor-cleanups-in-do_blockdev_direct_io-fix
+++ a/fs/direct-io.c
@@ -1178,9 +1178,9 @@ do_blockdev_direct_IO(struct kiocb *iocb
 	unsigned blkbits = i_blkbits;
 	unsigned blocksize_mask = (1 << blkbits) - 1;
 	ssize_t retval = -EINVAL;
-	size_t count = iov_iter_count(iter);
+	const size_t count = iov_iter_count(iter);
 	loff_t offset = iocb->ki_pos;
-	loff_t end = offset + count;
+	const loff_t end = offset + count;
 	struct dio *dio;
 	struct dio_submit sdio = { 0, };
 	struct buffer_head map_bh = { 0, };
_
