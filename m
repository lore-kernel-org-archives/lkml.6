Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753653AbeDROEM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 10:04:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:35542 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752939AbeDROEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 10:04:10 -0400
Date: Wed, 18 Apr 2018 16:04:09 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] printk: wake up klogd in vprintk_emit
Message-ID: <20180418140409.6hvkbip4skfs4x7y@pathway.suse.cz>
References: <20180414030145.26304-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180414030145.26304-1-sergey.senozhatsky@gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2018-04-14 12:01:45, Sergey Senozhatsky wrote:
> We wake up klogd very late - only when current console_sem owner
> is done pushing pending kernel messages to the serial/net consoles.
> In some cases this results in lost syslog messages, because kernel
> log buffer is a circular buffer and if we don't wakeup syslog long
> enough there are chances that logbuf simply will wrap around.
> 
> The patch moves the klog wake up call to vprintk_emit(), which is
> the only legit way for a kernel message to appear in the logbuf,
> right before we attempt to grab the console_sem (possibly spinning
> on it waiting for the hand off) and call console drivers.
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> ---
>  kernel/printk/printk.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 2f4af216bd6e..86f0b337cbf6 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1888,6 +1888,7 @@ asmlinkage int vprintk_emit(int facility, int level,
>  
>  	printed_len = log_output(facility, level, lflags, dict, dictlen, text, text_len);
>  
> +	wake_up_klogd();
>  	logbuf_unlock_irqrestore(flags);

The change makes perfect sense and I am fine with the idea. I just
wonder if there is a strong reason to do the wake_up before
releasing the logbuf_lock. It makes an assumption that it needs
to be synchronized by logbuf_lock.

In fact, I would feel more comfortable if we move this to the end
of vprintk_emit() right before return printk_len. This will be
more close to the current behavior (console first). But it will
still wakeup klogd much earlier and regularly if there is
a flood of messages.

Best Regards,
Petr
