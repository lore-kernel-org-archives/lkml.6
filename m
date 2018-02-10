Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751003AbeBJHdk (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 02:33:40 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44858 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbeBJHdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 02:33:39 -0500
X-Google-Smtp-Source: AH8x225xzE+0INTQVw8pX/3R1X/DefgMoBdFEkFjqtkrlneYZZ4byQ7jOkHAJiO7ncPi17aOpxkNfA==
Date: Sat, 10 Feb 2018 16:33:33 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] printk: Relocate wake_klogd check close to the end of
 console_unlock()
Message-ID: <20180210073333.GC485@tigerII.localdomain>
References: <20180208130402.15157-1-pmladek@suse.com>
 <20180208145307.GA485@tigerII.localdomain>
 <20180208164820.qsotvvywds6z6le4@pathway.suse.cz>
 <20180209032830.GA689@jagdpanzerIV>
 <20180209103911.mljxpgkw6njyoibe@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209103911.mljxpgkw6njyoibe@pathway.suse.cz>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On (02/09/18 11:39), Petr Mladek wrote:
> On Fri 2018-02-09 12:28:30, Sergey Senozhatsky wrote:
> > On (02/08/18 17:48), Petr Mladek wrote:
> > By postponing klogd wakeup we don't really address logbuf_lock
> > contention. We have no guarantees that no new printk will come
> > while klogd is active. Besides, consoles don't really delay
> > klogd - I tend to ignore the impact of msg_print_text(), it should
> > be fast. We call console drivers outside of logbuf_lock scope, so
> > everything should fine (tm).
> 
> First, I am all for waking klogd earlier.
> 
> Second, sigh, I do not have much experience with kernel performace issues.
> It is very likely that we really do not need to mind about it.

I really don't think we need to bother.
klogd loggers are as important as consoles, we need to run them anyway.

> > Basically,
> > - if consoles are suspended, we also "suspend" user space klogd.
> >   Does it really make sense?
> > 
> > - if console_lock is acquired by a preemptible task and that task
> >   is getting scheduled out for a long time (OOM, etc) then we postpone
> >   user space logging for unknown period of time. First the console_lock
> >   will have to flush pending messages and only afterwards it will wakeup
> >   klogd. Does it really make sense?
> > 
> > - If current console_lock owner jumps to retry (new pending messages
> >   were appended to the logbuf) label, user space klogd wakeup is getting
> >   postponed even further.
> > 
> > So, the final question is - since there in only one legitimate way
> > (modulo user space writes to kmsg) to append new messages to the
> > logbuf, shall we put klogd wakeup there? IOW, to vprintk_emit().
> 
> Good points! In fact, if we wakeup klogd before calling consoles,
> we would need to do it for every new message. Otherwise, klogd
> processes might miss new messages that are added in parallel
> when console_lock is taken.
[..]
> Then klogd might start sleeping while new messages are still comming

Loggers sleep when `user->seq == log_next_seq' or when
`syslog_seq == log_next_seq'. We need to just wakeup them.
Once woken up they will check the condition again, if there
are no new messages, they will schedule.

> Now, your proposed solution looked fine. Just note that we do not need
> seen_seq. vprintk_emit() knows when log_next_seq is increased.
> It would always wake klogd in this case.

Probably can wake_up_klogd() unconditionally.

> Anyway, I think about slightly different way that would prevent
> scheduling klogd intead of the vprintk_emit() caller. The trick
> is to do the wakeup with preemtion disabled. I mean something like:
[..]
> @@ -1899,9 +1899,13 @@ asmlinkage int vprintk_emit(int facility, int level,
>  		 */
>  		preempt_disable();
>  		/*
> +		 * Wake klogd with disabled preemtion so that they can run
> +		 * in parallel but they could not delay console_handling.
> +		 */
> +		wake_up_klogd();
> +		/*
>  		 * Try to acquire and then immediately release the console
> -		 * semaphore.  The release will print out buffers and wake up
> -		 * /dev/kmsg and syslog() users.
> +		 * semaphore.  The release will print out buffers.
>  		 */
>  		if (console_trylock_spinning())
>  			console_unlock();
[..]

It doesn't wakeup loggers for printk_deferred() output this way.
I want to wakeup them for every new logbuf message.

If logger preempts current printk() that it's for 1 message only.
printk() will return back and finish printing. If there will be another
printk()-s from other CPUs, then one of those CPUs will print messages
to the consoles - CPU that woke up logger had not acquired console_sem
before it was preempted by logger.

	-ss
