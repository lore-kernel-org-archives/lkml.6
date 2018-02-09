Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751166AbeBIKjP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 05:39:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:60847 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750993AbeBIKjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 05:39:14 -0500
Date: Fri, 9 Feb 2018 11:39:11 +0100
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] printk: Relocate wake_klogd check close to the end of
 console_unlock()
Message-ID: <20180209103911.mljxpgkw6njyoibe@pathway.suse.cz>
References: <20180208130402.15157-1-pmladek@suse.com>
 <20180208145307.GA485@tigerII.localdomain>
 <20180208164820.qsotvvywds6z6le4@pathway.suse.cz>
 <20180209032830.GA689@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209032830.GA689@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-02-09 12:28:30, Sergey Senozhatsky wrote:
> On (02/08/18 17:48), Petr Mladek wrote:
> By postponing klogd wakeup we don't really address logbuf_lock
> contention. We have no guarantees that no new printk will come
> while klogd is active. Besides, consoles don't really delay
> klogd - I tend to ignore the impact of msg_print_text(), it should
> be fast. We call console drivers outside of logbuf_lock scope, so
> everything should fine (tm).

First, I am all for waking klogd earlier.

Second, sigh, I do not have much experience with kernel performace issues.
It is very likely that we really do not need to mind about it.
But the following questions come to my mind:

1. Yes, new printk() might come when klogd is active. But how often
   this happens? But if we wakeup klogd before handling consoles,
   we basically schedule two parallel readers. There might be quite
   big chance of a contention even if not serious. But maybe not.
   Wakeup != running. In practice, it might take some time until
   klogd processes are scheduled and running.


2. If we wake klogd processes then they might get scheduled instead
   of the process calling printk(). This might happen if klogd
   processes have higher priority than the process calling
   printk(). As a result, this might delay getting messages
   to the console.

   Of course, this might happen already now. But we probably
   should not make it much more likely ?


> Another question - do we need to wake it up from console_unlock()?
> 
> Basically,
> - if consoles are suspended, we also "suspend" user space klogd.
>   Does it really make sense?
> 
> - if console_lock is acquired by a preemptible task and that task
>   is getting scheduled out for a long time (OOM, etc) then we postpone
>   user space logging for unknown period of time. First the console_lock
>   will have to flush pending messages and only afterwards it will wakeup
>   klogd. Does it really make sense?
> 
> - If current console_lock owner jumps to retry (new pending messages
>   were appended to the logbuf) label, user space klogd wakeup is getting
>   postponed even further.
> 
> So, the final question is - since there in only one legitimate way
> (modulo user space writes to kmsg) to append new messages to the
> logbuf, shall we put klogd wakeup there? IOW, to vprintk_emit().

Good points! In fact, if we wakeup klogd before calling consoles,
we would need to do it for every new message. Otherwise, klogd
processes might miss new messages that are added in parallel
when console_lock is taken.

I mean that klogd might process the new messages faster
than console_unlock(). Then klogd might start sleeping while
new messages are still comming and are being handled by
the same console_unlock() call.


Now, your proposed solution looked fine. Just note that we do not need
seen_seq. vprintk_emit() knows when log_next_seq is increased.
It would always wake klogd in this case.

Anyway, I think about slightly different way that would prevent
scheduling klogd intead of the vprintk_emit() caller. The trick
is to do the wakeup with preemtion disabled. I mean something like:


diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index db4b9b8929eb..1bdfb6ed93f0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1899,9 +1899,13 @@ asmlinkage int vprintk_emit(int facility, int level,
 		 */
 		preempt_disable();
 		/*
+		 * Wake klogd with disabled preemtion so that they can run
+		 * in parallel but they could not delay console_handling.
+		 */
+		wake_up_klogd();
+		/*
 		 * Try to acquire and then immediately release the console
-		 * semaphore.  The release will print out buffers and wake up
-		 * /dev/kmsg and syslog() users.
+		 * semaphore.  The release will print out buffers.
 		 */
 		if (console_trylock_spinning())
 			console_unlock();
@@ -2289,9 +2293,7 @@ void console_unlock(void)
 {
 	static char ext_text[CONSOLE_EXT_LOG_MAX];
 	static char text[LOG_LINE_MAX + PREFIX_MAX];
-	static u64 seen_seq;
 	unsigned long flags;
-	bool wake_klogd = false;
 	bool do_cond_resched, retry;
 
 	if (console_suspended) {
@@ -2335,10 +2337,6 @@ void console_unlock(void)
 
 		printk_safe_enter_irqsave(flags);
 		raw_spin_lock(&logbuf_lock);
-		if (seen_seq != log_next_seq) {
-			wake_klogd = true;
-			seen_seq = log_next_seq;
-		}
 
 		if (console_seq < log_first_seq) {
 			len = sprintf(text, "** %u printk messages dropped **\n",
@@ -2429,9 +2427,6 @@ void console_unlock(void)
 
 	if (retry && console_trylock())
 		goto again;
-
-	if (wake_klogd)
-		wake_up_klogd();
 }
 EXPORT_SYMBOL(console_unlock);
 
@@ -2858,14 +2853,14 @@ static void wake_up_klogd_work_func(struct irq_work *irq_work)
 {
 	int pending = __this_cpu_xchg(printk_pending, 0);
 
+	/* Wake up loggers even for pending output. */
+	if (pending)
+		wake_up_interruptible(&log_wait);
+
 	if (pending & PRINTK_PENDING_OUTPUT) {
 		/* If trylock fails, someone else is doing the printing */
 		if (console_trylock())
 			console_unlock();
-	}
-
-	if (pending & PRINTK_PENDING_WAKEUP)
-		wake_up_interruptible(&log_wait);
 }
 
 static DEFINE_PER_CPU(struct irq_work, wake_up_klogd_work) = {
