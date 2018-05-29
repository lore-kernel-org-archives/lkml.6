Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966152AbeE2SgV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:36:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965885AbeE2SgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:36:19 -0400
Date: Tue, 29 May 2018 20:35:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>, Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH 1/7] atomics/tty: add missing atomic_long_t * cast
Message-ID: <20180529183558.GC10359@kroah.com>
References: <20180529180746.29684-1-mark.rutland@arm.com>
 <20180529180746.29684-2-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529180746.29684-2-mark.rutland@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 07:07:40PM +0100, Mark Rutland wrote:
> In ldsem_cmpxchg a pointer to unsigned long is passed to
> atomic_long_cmpxchg(), which expects a pointer to atomic_long_t.
> 
> In preparation for making the atomic_long_* APIs type safe, add a cast
> before passing the value to atomic_long_cmpxchg(). Similar is already
> done in ldsem_atomic_update() when it calls atomic_long_add_return().
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> ---
>  drivers/tty/tty_ldsem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/tty_ldsem.c b/drivers/tty/tty_ldsem.c
> index 37a91b3df980..5f8aef97973f 100644
> --- a/drivers/tty/tty_ldsem.c
> +++ b/drivers/tty/tty_ldsem.c
> @@ -86,7 +86,7 @@ static inline long ldsem_atomic_update(long delta, struct ld_semaphore *sem)
>   */
>  static inline int ldsem_cmpxchg(long *old, long new, struct ld_semaphore *sem)
>  {
> -	long tmp = atomic_long_cmpxchg(&sem->count, *old, new);
> +	long tmp = atomic_long_cmpxchg((atomic_long_t *)&sem->count, *old, new);
>  	if (tmp == *old) {
>  		*old = new;
>  		return 1;
> -- 
> 2.11.0

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
