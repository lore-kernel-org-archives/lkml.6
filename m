Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933291AbeBVQEg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:04:36 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39004 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933029AbeBVQEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:04:34 -0500
Date: Thu, 22 Feb 2018 11:04:32 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Aliaksei Karaliou <akaraliou.dev@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Biggers <ebiggers@google.com>, linux-kernel@vger.kernel.org
Subject: Re: dm-bufio: avoid false-positive Wmaybe-uninitialized warning
Message-ID: <20180222160432.GA16971@redhat.com>
References: <20180222155627.1800948-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222155627.1800948-1-arnd@arndb.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22 2018 at 10:56am -0500,
Arnd Bergmann <arnd@arndb.de> wrote:

> gcc-6.3 and earlier show a new warning after a seemingly unrelated change
> to the arm64 PAGE_KERNEL definition:
> 
> In file included from drivers/md/dm-bufio.c:14:0:
> drivers/md/dm-bufio.c: In function 'alloc_buffer':
> include/linux/sched/mm.h:182:56: warning: 'noio_flag' may be used uninitialized in this function [-Wmaybe-uninitialized]
>   current->flags = (current->flags & ~PF_MEMALLOC_NOIO) | flags;
>                                                         ^
> 
> The same warning happened earlier on linux-3.18 for MIPS and I did a
> workaround for that, but now it's come back.
> 
> gcc-7 and newer are apparently smart enough to figure this out, and
> other architectures don't show it, so the best I could come up with is
> to rework the caller slightly in a way that makes it obvious enough to
> all arm64 compilers what is happening here.
> 
> Fixes: 41acec624087 ("arm64: kpti: Make use of nG dependent on arm64_kernel_unmapped_at_el0()")
> Link: https://patchwork.kernel.org/patch/9692829/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/md/dm-bufio.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
> index 414c9af54ded..e7ad6fc6a5ea 100644
> --- a/drivers/md/dm-bufio.c
> +++ b/drivers/md/dm-bufio.c
> @@ -413,13 +413,13 @@ static void *alloc_buffer_data(struct dm_bufio_client *c, gfp_t gfp_mask,
>  	 * as if GFP_NOIO was specified.
>  	 */
>  
> -	if (gfp_mask & __GFP_NORETRY)
> +	if (gfp_mask & __GFP_NORETRY) {
>  		noio_flag = memalloc_noio_save();
> -
> -	ptr = __vmalloc(c->block_size, gfp_mask, PAGE_KERNEL);
> -
> -	if (gfp_mask & __GFP_NORETRY)
> +		ptr = __vmalloc(c->block_size, gfp_mask, PAGE_KERNEL);
>  		memalloc_noio_restore(noio_flag);
> +	} else {
> +		ptr = __vmalloc(c->block_size, gfp_mask, PAGE_KERNEL);
> +	}
>  
>  	return ptr;
>  }

Mikulas already sent a fix for this:
https://patchwork.kernel.org/patch/10211631/

But I like yours a bit better, though I'll likely move the declaration
of 'noio_flag' temporary inside the conditional.

Anyway, I'll get this fixed up shortly, thanks.

Mike
