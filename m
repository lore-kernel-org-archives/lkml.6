Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752358AbeBZP5i (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 10:57:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:55160 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752280AbeBZP5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 10:57:36 -0500
Date: Mon, 26 Feb 2018 16:57:34 +0100
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3] printk: Relocate wake_klogd check close to the end of
 console_unlock()
Message-ID: <20180226155734.dzwg3aovqnwtvkoy@pathway.suse.cz>
References: <20180208130402.15157-1-pmladek@suse.com>
 <20180219155817.yfo7yrnz4vyzxerx@pathway.suse.cz>
 <20180219160122.upqkpbbffm3rth6p@pathway.suse.cz>
 <20180226063735.GC12539@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226063735.GC12539@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-02-26 15:37:35, Sergey Senozhatsky wrote:
> On (02/19/18 17:01), Petr Mladek wrote:
> [..]
> > -	raw_spin_lock(&logbuf_lock);
> >  	retry = console_seq != log_next_seq;
> > +	/*
> > +	 * Check whether userland needs notification. Do this only when really
> > +	 * leaving to avoid race with console_trylock_spinning().
> > +	 */
> > +	if (seen_seq != log_next_seq && !retry) {
> > +		wake_klogd = true;
> > +		seen_seq = log_next_seq;
> > +	}
> 
> Let's add the "why" part. This "!retry" might be hard to understand. We
> are looking at
> 
> - CPUa is about to leave console_unlock()
> - printk on CPUb appends a new message
> - CPUa detects that `console_seq != log_next_seq', updates `seen_seq'
> - printk on CPUb is getting preempted
> - CPUa re-takes the console_sem via retry path
> - printk CPUb is becoming TASK_RUNNING again - it now spins for console_sem,
>   since we have an active console_sem owner
> - CPUa detects that there is a console_sem waiter, so it offloads the
>   printing task, without ever waking up klogd

Yes, this is the scenario. I agree that it is very tricky.

> Either we can have that complex "seen_seq != log_next_seq && !retry"
> check - or we simply can add
> 
> 	if (console_lock_spinning_disable_and_check()) {
> 		printk_safe_exit_irqrestore(flags);
> 		if (wake_klogd)
> 			wake_up_klogd();
> 	}
> 
> to the offloading return path.
> 
> The later is *may be* simpler to follow. The rule is: every
> !console_suspend and !cant-use-consoles return path from console_unlock()
> must wake_up_klogd() [if needed].

Yes, this looks more straighforward. It might cause earlier and more
often wakeup but we want to go this way anyway. I do not see any
real problem with it.

Okay, what about the following patch for 4.16-rc4?

>From 7450da0e7e0d7ee5926f09c8bbbaa44c67ae0b48 Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Mon, 26 Feb 2018 15:44:20 +0100
Subject: [PATCH] printk: Wake klogd when passing console_lock owner

wake_klogd is a local variable in console_unlock(). The information
is lost when the console_lock owner using the busy wait added by
the commit dbdda842fe96f8932 ("printk: Add console owner and waiter
logic to load balance console writes"). The following race is
possible:

CPU0				CPU1
console_unlock()

  for (;;)
     /* calling console for last message */

				printk()
				  log_store()
				    log_next_seq++;

     /* see new message */
     if (seen_seq != log_next_seq) {
	wake_klogd = true;
	seen_seq = log_next_seq;
     }

     console_lock_spinning_enable();

				  if (console_trylock_spinning())
				     /* spinning */

     if (console_lock_spinning_disable_and_check()) {
	printk_safe_exit_irqrestore(flags);
	return;

				  console_unlock()
				    if (seen_seq != log_next_seq) {
				    /* already seen */
				    /* nothing to do */

Result: Nobody would wakeup klogd.

One solution would be to make a global variable from wake_klogd.
But then we would need to manipulate it under a lock or so.

This patch wakes klogd also when console_lock is passed to the
spinning waiter. It looks like the right way to go. Also userspace
should have a chance to see and store any "flood" of messages.

Note that the very late klogd wake up was a historic solution.
It made sense on single CPU systems or when sys_syslog() operations
were synchronized using the big kernel lock like in v2.1.113.
But it is questionable these days.

Fixes: dbdda842fe96f8932 ("printk: Add console owner and waiter logic to load balance console writes")
Suggested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fc1123583fa6..f274fbef821d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2397,7 +2397,7 @@ void console_unlock(void)
 
 		if (console_lock_spinning_disable_and_check()) {
 			printk_safe_exit_irqrestore(flags);
-			return;
+			goto out;
 		}
 
 		printk_safe_exit_irqrestore(flags);
@@ -2430,6 +2430,7 @@ void console_unlock(void)
 	if (retry && console_trylock())
 		goto again;
 
+out:
 	if (wake_klogd)
 		wake_up_klogd();
 }
-- 
2.13.6
