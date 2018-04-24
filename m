Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751368AbeDXOvJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 10:51:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750778AbeDXOvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 10:51:07 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF82B20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 24 Apr 2018 10:51:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH] printk: do not call console drivers from
 printk_safe context
Message-ID: <20180424105104.792d2d80@gandalf.local.home>
In-Reply-To: <20180424022802.1330-1-sergey.senozhatsky@gmail.com>
References: <20180424022802.1330-1-sergey.senozhatsky@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2018 11:28:02 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

> Calling console drivers from printk_safe() context does not really
> make call_console_drivers() any safer, because printk_safe() has
> nothing to do with console drivers or the underlying code. At the
> same time printk()-s from console drivers are fine, they don't
> deadlock the system. We need printk_safe() because of the way
> vprintk_emit() works -- we protect logbuf lock, console_owner_lock
> and console_sem spin_lock with printk_safe, -- not because of the
> console drivers (which don't deal with logbuf, console_owner_lock
> or console_sem locks). Hence we can call console drivers outside
> of printk_safe() context.
> 
> Another thing to notice is that,
> printk_safe() introduces unneeded complexity, since any printk()
> message from console drivers has to be stored in per-CPU printk_safe()
> buffer first, then be flushed via IRQ work:
> 	call_console_drivers()
> 	 printk()
> 	  printk_safe_log_store()
> 	   IRQ_work()
> 	    printk_safe_flush_buffer()
> 	     printk_deferred()
> 	      log_store()
> 	       irq_work_queue()               *
> 	        wake_up_klogd_work_func()     *
> 
> Note that this also costs us extra IRQ work [along with the IRQ work
> that flushes printk_safe() buffer] - we flush per-CPU printk_safe()
> buffers via printk_deferred().
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> ---
>  kernel/printk/internal.h | 7 ++++++-
>  kernel/printk/printk.c   | 2 ++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
> index 2a7d04049af4..f3ba1bf08590 100644
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -55,8 +55,13 @@ void __printk_safe_exit(void);
>  	} while (0)
>  
>  #else
> +static void __printk_safe_enter(void) {}
> +static void __printk_safe_exit(void) {}
>  
> -__printf(1, 0) int vprintk_func(const char *fmt, va_list args) { return 0; }
> +static __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
> +{
> +	return 0;
> +}
>  
>  /*
>   * In !PRINTK builds we still export logbuf_lock spin_lock, console_sem
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 2f4af216bd6e..9acb25ce6081 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2391,9 +2391,11 @@ void console_unlock(void)
>  		 */
>  		console_lock_spinning_enable();
>  
> +		__printk_safe_exit();
>  		stop_critical_timings();	/* don't trace print latency */
>  		call_console_drivers(ext_text, ext_len, text, len);
>  		start_critical_timings();
> +		__printk_safe_enter();
>  

OK, I'm still confused (It's been that kind of week)

So, if we do this, and the consoles do a printk(), doesn't that fill
the logbuf? And then the loop this is in will just continue to perform
that loop? That is, we have:

  for (;;) {
	if (console_seq == log_next_seq)
		break;
	console_seq++;
	call_console_drives() {
		printk() {
			log_next_seq++;
		}
	}
  }

That looks like an infinite loop to me. Whereas the printk_safe keeps
from adding to the logbuf?

-- Steve


>  		if (console_lock_spinning_disable_and_check()) {
>  			printk_safe_exit_irqrestore(flags);
