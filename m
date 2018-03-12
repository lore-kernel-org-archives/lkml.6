Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932338AbeCLJzB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:55:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:43503 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751344AbeCLJzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:55:00 -0400
Subject: Re: [PATCH 1/2] direct-io: Remove unused DIO_ASYNC_EXTEND flag
To: axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, rgoldwyn@suse.de, linux-block@vger.kernel.org
References: <1519386329-2734-1-git-send-email-nborisov@suse.com>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <f0132588-86e0-1430-dd2c-157e59272f40@suse.com>
Date: Mon, 12 Mar 2018 11:54:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519386329-2734-1-git-send-email-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.02.2018 13:45, Nikolay Borisov wrote:
> This flag was added by 6039257378e4 ("direct-io: add flag to allow aio
> writes beyond i_size") to support XFS. However, with the rework of
> XFS' DIO's path to use iomap in acdda3aae146 ("xfs: use iomap_dio_rw")
> it became redundant. So let's remove it.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Jens,

On a second look I think you are the more appropriate person to take
these patches. SO do you have any objections to merging those via the
block tree. ( I did CC you but didn't cc linux-block).

> ---
>  fs/direct-io.c     | 3 +--
>  include/linux/fs.h | 3 ---
>  2 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index a0ca9e48e993..99a81c49bce9 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -1252,8 +1252,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>  	 */
>  	if (is_sync_kiocb(iocb))
>  		dio->is_async = false;
> -	else if (!(dio->flags & DIO_ASYNC_EXTEND) &&
> -		 iov_iter_rw(iter) == WRITE && end > i_size_read(inode))
> +	else if (iov_iter_rw(iter) == WRITE && end > i_size_read(inode))
>  		dio->is_async = false;
>  	else
>  		dio->is_async = true;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 2a815560fda0..260c233e7375 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2977,9 +2977,6 @@ enum {
>  	/* filesystem does not support filling holes */
>  	DIO_SKIP_HOLES	= 0x02,
>  
> -	/* filesystem can handle aio writes beyond i_size */
> -	DIO_ASYNC_EXTEND = 0x04,
> -
>  	/* inode/fs/bdev does not need truncate protection */
>  	DIO_SKIP_DIO_COUNT = 0x08,
>  };
> 
