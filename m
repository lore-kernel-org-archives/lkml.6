Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937295AbeE3IsI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 04:48:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:37550 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935976AbeE3IsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 04:48:04 -0400
Date: Wed, 30 May 2018 10:48:01 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] printk: drop in_nmi check from
 printk_safe_flush_on_panic()
Message-ID: <20180530084801.i5mzqhlw2w5o2eod@pathway.suse.cz>
References: <20180530070350.10131-1-sergey.senozhatsky@gmail.com>
 <20180530072419.jqoohtcvenlnym6h@pathway.suse.cz>
 <20180530075105.GA12230@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530075105.GA12230@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-05-30 16:51:05, Sergey Senozhatsky wrote:
> On (05/30/18 09:24), Petr Mladek wrote:
> > Acked-by: Petr Mladek <pmladek@suse.com>
> 
> Thanks.
> 
> > Just to be sure. IMHO, it is not worth nominating this patch for
> > stable. It is not a regression fix. I see it as a continuous
> > improving of the handling in various corner cases. And I see this
> > as a distant corner case.
> 
> Yep, agreed.
> 
> ***
> 
> A random thought [not suggesting anything]:
> 
> Given that we call printk() before SMP stop and that some of
> smp_send_stop() call printk(), may be we can switch panic()
> to printk_safe() mode and return it back to normal printk()
> mode right before printk_safe_flush_on_panic(). So all possible
> printk()-s that can happen in between (printk_safe_enter()
> printk_safe_exit()) will not access the logbuf spin lock, yet
> we still will try to flush all per-CPU buffers a bit later.
> 
> It probably doesn't sound like a very good/solid idea, just
> wondering what will people say.
> 
> Very schematically,
> 
> ---
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 42e487488554..98a0493a59d3 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -148,6 +148,7 @@ void panic(const char *fmt, ...)
>  	 * after setting panic_cpu) from invoking panic() again.
>  	 */
>  	local_irq_disable();
> +	__printk_safe_enter();

I understand why you came with it but I am against this change without
a proper research. This would redirect too valuable messages into
a buffer of a limited size and postpone flushing them to the consoles.

We would need to really carefully compare chances where this would
help and where it would make things worse. There is a high chance
that we could come with a better solution once we have the analyze.

Best Regards,
Petr
