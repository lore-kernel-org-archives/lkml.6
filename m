Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753265AbeBSP6V (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 10:58:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:51485 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753124AbeBSP6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 10:58:19 -0500
Date: Mon, 19 Feb 2018 16:58:17 +0100
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] printk: Relocate wake_klogd check close to the end of
 console_unlock()
Message-ID: <20180219155817.yfo7yrnz4vyzxerx@pathway.suse.cz>
References: <20180208130402.15157-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208130402.15157-1-pmladek@suse.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-02-08 14:04:02, Petr Mladek wrote:
> From: Tejun Heo <tj@kernel.org>
> 
> We mark for waking up klogd whenever we see a new message sequence in
> the main loop.  However, the actual wakeup is always at the end of the
> function and we can easily test for the wakeup condition when we do
> the final should-we-repeat check.
> 
> Move the wake_klogd condition check out of the main loop.  This avoids
> doing the same thing repeatedly and groups similar checks into a
> common place.
> 
> This fixes a race introduced by the commit dbdda842fe96f8932 ("printk: Add
> console owner and waiter logic to load balance console writes").
> The current console owner might process the newly added message before
> the related printk() start waiting for the console lock. Then the lock
> is passed without waking klogd. The new owner sees the already updated
> seen_seq and does not know that the wakeup is needed.
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index db4b9b8929eb..2682209b1c90 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2417,12 +2413,17 @@ void console_unlock(void)
>  	up_console_sem();
>  
>  	/*
> -	 * Someone could have filled up the buffer again, so re-check if there's
> -	 * something to flush. In case we cannot trylock the console_sem again,
> -	 * there's a new owner and the console_unlock() from them will do the
> -	 * flush, no worries.
> +	 * Check whether userland needs notification.  Also, someone could
> +	 * have filled up the buffer again, so re-check if there's
> +	 * something to flush. In case we cannot trylock the console_sem
> +	 * again, there's a new owner and the console_unlock() from them
> +	 * will do the flush, no worries.
>  	 */
>  	raw_spin_lock(&logbuf_lock);
> +	if (seen_seq != log_next_seq) {
> +		wake_klogd = true;
> +		seen_seq = log_next_seq;

Sigh, there is actually still a race with console_trylock_spinning().
We might see the updated log_next_seq here while the related
printk() might steal the lock in retry path.

The simplest solution seems to be to do this only when !retry.
I am going to send v3.

> +	}
>  	retry = console_seq != log_next_seq;
>  	raw_spin_unlock(&logbuf_lock);
>  	printk_safe_exit_irqrestore(flags);

Best Regards,
Petr
