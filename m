Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751838AbeCCIQj (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 03:16:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:48850 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751566AbeCCIQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 03:16:38 -0500
Subject: Re: [PATCH] direct-io: Minor cleanups in do_blockdev_direct_IO
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
References: <1519638870-17756-1-git-send-email-nborisov@suse.com>
 <20180302162400.f36d0d068bd0a08442536a2c@linux-foundation.org>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <fcc65c30-c263-2a27-f7b0-7df6d047c21d@suse.com>
Date: Sat, 3 Mar 2018 10:16:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302162400.f36d0d068bd0a08442536a2c@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On  3.03.2018 02:24, Andrew Morton wrote:
> On Mon, 26 Feb 2018 11:54:30 +0200 Nikolay Borisov <nborisov@suse.com> wrote:
> 
>> We already get the block counts and the calculate the end block at the
>> beginning of the function. Let's use the local variables for consistency and
>> readability. No functional changes
>>
> 
> Fair enough.
> 
>> --- a/fs/direct-io.c
>> +++ b/fs/direct-io.c
>> @@ -1200,7 +1200,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>>  	}
>>  
>>  	/* watch out for a 0 len io from a tricksy fs */
>> -	if (iov_iter_rw(iter) == READ && !iov_iter_count(iter))
>> +	if (iov_iter_rw(iter) == READ && !count)
>>  		return 0;
>>  
>>  	dio = kmem_cache_alloc(dio_cache, GFP_KERNEL);
>> @@ -1316,8 +1316,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
>>  
>>  	dio->should_dirty = (iter->type == ITER_IOVEC);
>>  	sdio.iter = iter;
>> -	sdio.final_block_in_request =
>> -		(offset + iov_iter_count(iter)) >> blkbits;
>> +	sdio.final_block_in_request = end >> blkbits;
>>  
>>  	/*
>>  	 * In case of non-aligned buffers, we may need 2 more
> 
> It's always scary to see a local being used in this fashion so far away
> from where it was initialized.  However, we can get our warm fuzzy
> feelings by doing this:
> 

Good point !

> --- a/fs/direct-io.c~direct-io-minor-cleanups-in-do_blockdev_direct_io-fix
> +++ a/fs/direct-io.c
> @@ -1178,9 +1178,9 @@ do_blockdev_direct_IO(struct kiocb *iocb
>  	unsigned blkbits = i_blkbits;
>  	unsigned blocksize_mask = (1 << blkbits) - 1;
>  	ssize_t retval = -EINVAL;
> -	size_t count = iov_iter_count(iter);
> +	const size_t count = iov_iter_count(iter);
>  	loff_t offset = iocb->ki_pos;
> -	loff_t end = offset + count;
> +	const loff_t end = offset + count;
>  	struct dio *dio;
>  	struct dio_submit sdio = { 0, };
>  	struct buffer_head map_bh = { 0, };
> _

I assume you don't want me to resend but will just fold the changes
yourself?

> 
> 
