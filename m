Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751784AbeFEMrd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:47:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:40542 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751598AbeFEMrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:47:32 -0400
Date: Tue, 5 Jun 2018 14:47:29 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, "4 . 13+" <stable@vger.kernel.org>
Subject: Re: [PATCH] printk/nmi: Prevent deadlock when serializing NMI
 backtraces
Message-ID: <20180605124729.3vix5nlkjpjzdljx@pathway.suse.cz>
References: <20180517143903.19339-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517143903.19339-1-pmladek@suse.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-05-17 16:39:03, Petr Mladek wrote:
> The commit 719f6a7040f1bdaf96fcc ("printk: Use the main logbuf in NMI when
> logbuf_lock is available") tried to detect when logbuf_lock was taken
> on another CPU. Then it looked safe to wait for the lock even in NMI.
> 
> It would be safe if other locks were not involved. Ironically the same
> commit introduced an ABBA deadlock scenario. It added a spin lock into
> nmi_cpu_backtrace() to serialize logs from different CPUs. The effect
> is that also the NMI handlers are serialized. As a result, logbuf_lock
> might be blocked by NMI on another CPU:
> 
> CPU0			CPU1			CPU2
> 
> printk()
>   vprintk_emit()
>     spin_lock(&logbuf_lock)
> 
> 						trigger_all_cpu_backtrace()
> 						  raise()
> 
> 			nmi_enter()
> 			  printk_nmi_enter()
> 			    if (this_cpu_read(printk_context)
> 			      & PRINTK_SAFE_CONTEXT_MASK)
> 			      // false
> 			    else
> 			      // looks safe to use printk_deferred()
> 			      this_cpu_or(printk_context,
> 				PRINTK_NMI_DEFERRED_CONTEXT_MASK);
> 
> 			  nmi_cpu_backtrace()
> 			    arch_spin_lock(&lock);
> 			      show_regs()
> 
> nmi_enter()
>   nmi_cpu_backtrace()
>     arch_spin_lock(&lock);
> 
> 			      printk()
> 				vprintk_func()
> 				  vprintk_deferred()
> 				    vprintk_emit()
> 				      spin_lock(&logbuf_lock)
> 
> DEADLOCK: between &logbuf_lock from vprintk_emit() and
> 		  &lock from nmi_cpu_backtrace().
> 
> CPU0			CPU1
> lock(logbuf_lock)	lock(lock)
>   lock(lock)		  lock(logbuf_lock)
> 
> I have found this problem when stress testing trigger_all_cpu_backtrace()
> and the system frozen.
> 
> Note that lockdep is not able to detect these dependencies because
> there is no support for NMI context. Let's stay on the safe side
> and always use printk_safe buffers when logbuf_lock is taken
> when entering NMI.
> 
> Fixes: 719f6a7040f1bdaf96fcc ("printk: Use the main logbuf in NMI when logbuf_lock is available")
> Cc: 4.13+ <stable@vger.kernel.org> # v4.13+
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  kernel/printk/printk_safe.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
> index 449d67edfa4b..a2ebd749c053 100644
> --- a/kernel/printk/printk_safe.c
> +++ b/kernel/printk/printk_safe.c
> @@ -310,15 +310,12 @@ void printk_nmi_enter(void)
>  {
>  	/*
>  	 * The size of the extra per-CPU buffer is limited. Use it only when
> -	 * the main one is locked. If this CPU is not in the safe context,
> -	 * the lock must be taken on another CPU and we could wait for it.
> +	 * the main one is locked.
>  	 */
> -	if ((this_cpu_read(printk_context) & PRINTK_SAFE_CONTEXT_MASK) &&
> -	    raw_spin_is_locked(&logbuf_lock)) {
> +	if (raw_spin_is_locked(&logbuf_lock))
>  		this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);

Grr, the ABBA deadlock is still there. NMIs are not sent to the other
CPUs atomically. Even if we detect that logbuf_lock is available
in printk_nmi_enter() on some CPUs, it might still get locked on
another CPU before the other CPU gets NMI.

By other words, any check in printk_safe_enter() is racy and not
sufficient

  => I suggest to revert the commit 719f6a7040f1bdaf96fcc70
     "printk: Use the main logbuf in NMI when logbuf_lock is available"
     for-4.18 and stable until we get a better solution.

The only safe solution seems to be a trylock() in NMI in
vprintk_emit() and fallback to vprintk_safe() when the lock
is not taken. I mean something like:

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 247808333ba4..4a5a0bf221b3 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1845,7 +1845,13 @@ asmlinkage int vprintk_emit(int facility, int level,
 	printk_delay();
 
 	/* This stops the holder of console_sem just where we want him */
-	logbuf_lock_irqsave(flags);
+	printk_safe_enter_irqsave(flags);
+	if (in_nmi() && !raw_spin_trylock(&logbuf_lock)) {
+		vprintk_nmi(fmt, args);
+		printk_safe_exit_irqrestore(flags);
+		return;
+	} else
+		raw_spin_lock(&logbuf_lock);
 	/*
 	 * The printf needs to come first; we need the syslog
 	 * prefix which might be passed-in as a parameter.


Sigh, this looks like a material for-4.19. We might need to
revisit if printk_context still makes sense, ...

Best Regards,
Petr

PS: I realized this when writing the pull request for-4.18.
I removed this patch from the pull request.
