Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752126AbeBHQsX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 11:48:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:54705 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751094AbeBHQsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 11:48:22 -0500
Date: Thu, 8 Feb 2018 17:48:20 +0100
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] printk: Relocate wake_klogd check close to the end of
 console_unlock()
Message-ID: <20180208164820.qsotvvywds6z6le4@pathway.suse.cz>
References: <20180208130402.15157-1-pmladek@suse.com>
 <20180208145307.GA485@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208145307.GA485@tigerII.localdomain>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-02-08 23:53:07, Sergey Senozhatsky wrote:
> On (02/08/18 14:04), Petr Mladek wrote:
> > We mark for waking up klogd whenever we see a new message sequence in
> > the main loop.  However, the actual wakeup is always at the end of the
> > function and we can easily test for the wakeup condition when we do
> > the final should-we-repeat check.
> > 
> > Move the wake_klogd condition check out of the main loop.  This avoids
> > doing the same thing repeatedly and groups similar checks into a
> > common place.
> > 
> > This fixes a race introduced by the commit dbdda842fe96f8932 ("printk: Add
> > console owner and waiter logic to load balance console writes").
> > The current console owner might process the newly added message before
> > the related printk() start waiting for the console lock. Then the lock
> > is passed without waking klogd. The new owner sees the already updated
> > seen_seq and does not know that the wakeup is needed.
> 
> I need to do more "research" on this. I though about it some time ago,
> and I think that waking up klogd _only_ when we don't have any pending
> logbuf messages still can be pretty late. Can't it? We can spin in
> console_unlock() printing loop for a long time, probably passing
> console_sem ownership between CPUs, without waking up the log_wait waiter.
> May be we can wake it up from the printing loop, outside of logbuf_lock,
> and let klogd to compete for logbuf_lock with the printing CPU. Why do
> we wake it up only when we are done pushing messages to a potentially
> slow serial console?

I thought about this as well but I was lazy. You made me to do some
archaeology. It seems that it worked this way basically from the beginning.
I have a git tree with pre-git commits. The oldest printk changes are
there from 2.1.113.

In 2.1.113, logd was weaken directly from printk():


asmlinkage int printk(const char *fmt, ...)
{
	spin_lock_irqsave(&console_lock, flags);
[...]
		for (; p < buf_end; p++) {
			log_buf[(log_start+log_size) & (LOG_BUF_LEN-1)] = *p;
			if (log_size < LOG_BUF_LEN)
--->				log_size++;
			else {
--->				log_start++;
				log_start &= LOG_BUF_LEN-1;
			}
		if (msg_level < console_loglevel && console_drivers) {
			struct console *c = console_drivers;
			while(c) {
				if ((c->flags & CON_ENABLED) && c->write)
--->					c->write(c, msg, p - msg + line_feed);
				c = c->next;
			}
		}
	}
	spin_unlock_irqrestore(&console_lock, flags);
--->	wake_up_interruptible(&log_wait);


log_wait seems to be used only in sys_syslog():

asmlinkage int sys_syslog(int type, char * buf, int len)
{

	lock_kernel();

	switch (type) {

	case 2:		/* Read from log */
---->		while (!log_size) {
			if (signal_pending(current)) {
				sti();
				goto out;
			}
			interruptible_sleep_on(&log_wait);
		}
		i = 0;
		while (log_size && i < len) {
			c = *((char *) log_buf+log_start);
---->			log_start++;
---->			log_size--;
			log_start &= LOG_BUF_LEN-1;
			sti();
			__put_user(c,buf);
			buf++;
			i++;
			cli();
		}
		sti();
		error = i;
		break;
		spin_unlock_irq(&logbuf_lock);


There are few interesting things:

   + synchronization is done using console_lock and the big kernel
     lock
   + consoles are written directly from printk()
   + the big kernel lock is taken all the time in sys_syslog()
   + sys_syslog() basically removes the messages from the buffer


I am not sure how the console_lock and the big kernel lock worked
together. But it seems that it was not possible to call consoles
and call __put_user() in sys_syslog() in parallel.


My opinion:

IMHO, it would make perfect sense to wake klogd earlier and it should
be safe these days.

I am just slightly afraid of a potential contention on printk_lock.
Consoles and klogd might delay each other. Another question is
how to do so when console_unlock() is called with interrupts
disabled (irq_work is queued on the same CPU). This is why
I would suggest to do this change separately and not for 4.16.

Note that we need Tejun's patch for-4.16 because it fixes a potential
race introduced by the console waiter logic.

Best Regards,
Petr
