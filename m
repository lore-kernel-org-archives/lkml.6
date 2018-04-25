Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751201AbeDYB7q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 21:59:46 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:39074 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbeDYB7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 21:59:44 -0400
X-Google-Smtp-Source: AB8JxZoN7WDgy9d16I0LDRtTMnrjtFcq8mwkZbcQl5M98dCJYqzbQPLUc5lnLv3dNVK6B7WPOCMJuw==
Date: Wed, 25 Apr 2018 10:59:39 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC][PATCH] printk: do not call console drivers from
 printk_safe context
Message-ID: <20180425015917.GA11975@jagdpanzerIV>
References: <20180424022802.1330-1-sergey.senozhatsky@gmail.com>
 <20180424105104.792d2d80@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424105104.792d2d80@gandalf.local.home>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/24/18 10:51), Steven Rostedt wrote:
[..]
> >  		console_lock_spinning_enable();
> >  
> > +		__printk_safe_exit();
> >  		stop_critical_timings();	/* don't trace print latency */
> >  		call_console_drivers(ext_text, ext_len, text, len);
> >  		start_critical_timings();
> > +		__printk_safe_enter();
> >  
> 
> OK, I'm still confused (It's been that kind of week)

No worries, I'm here to help.
The email is, once again, a bit long, but hey at least I'm using
capitals now ;)

> So, if we do this, and the consoles do a printk(), doesn't that fill
> the logbuf?

Yes. It's been this way for many years, and, in fact, even with
printk_safe() we still add concole_drivers->printk() messages to
the logbuf ASAP, which mostly happens while the printing CPU is
still in console_unlock() loop [see #flushing below].

> And then the loop this is in will just continue to perform that loop?

Yes. And it's the same even with printk_safe(). Except that
printk_safe() costs us 2 extra IRQ works on that CPU.

In short, what printk_safe() does:

a) protects us from deadlocking on logbuf spin_lock

E.g.
       vprintk_emit()
       {
         raw_spin_lock(&logbuf_lock);
           vscnprintf(text, sizeof(textbuf), fmt, args)
:            WARN_ONCE(1, "Unsupported flags modifier....)
:             printk()
:              vprintk_emit()
:               raw_spin_lock(&logbuf_lock);                 <<<<<<<
         raw_spin_unlock(&logbuf_lock);
       }

b) protects us from deadlocking on console_sem (for example, console_sem
   ->lock spin_lock)

E.g.
     console_unlock()
     {
       for (;;) {
        if (console_seq == log_next_seq)
         break;
       }

       up()
:       raw_spin_lock_irqsave(&sem->lock, flags);
:        printk()
:         vprintk_emit()
:          if (console_trylock_spinning())
:           console_trylock()
:            down_trylock()
:             raw_spin_lock_irqsave(&sem->lock, flags);     <<<<<<<
     }


c) protects us from deadlocking on console_sem_owner spin_lock
  Basically, the same as (a) - deadlock on spin_lock, but at the moment
  I'd say a rather theoretical case.

d) protects us from deadlocking on _some_ external locks. For example,
   scheduler ->pi_lock lock


> That is, we have:
> 
>   for (;;) {
> 	if (console_seq == log_next_seq)
> 		break;
> 	console_seq++;
> 	call_console_drives() {
> 		printk() {
> 			log_next_seq++;
> 		}
> 	}
>   }
> 
> That looks like an infinite loop to me.

Correct, this is how it works. And I think we need to preserve that
"console drivers can add messages to the logbuf" and to avoid any
interference [and by interference I mean a deliberate message loss]
with the messages. I have provided some links [in another email] to
support that claim, let me know.


I'd love to see real backtraces/logs when we actually have that
infinite loop.

> Whereas the printk_safe keeps from adding to the logbuf?

#flushing

printk_safe() does not keep console drivers from adding new messages
to the logbuf. We flush [move messages to the logbuf] printk_safe()
per-CPU buffer the moment we enable local IRQ on that CPU: which is,
basically, right after call_console_drivers():

for (;;) {
	printk_safe_enter_irqsave(flags);
	raw_spin_lock(&logbuf_lock);

	if (console_seq == log_next_seq)
		break;
	console_seq++;
	raw_spin_unlock(&logbuf_lock);

	call_console_drives() {
		printk()
		 printk_safe_log_store()      ::
		  irq_work_queue()            ::
	}

	printk_safe_exit_irqrestore(flags);   ::

	 << IRQ >>
	   printk_safe_flush_buffer()
	    printk_deferred()
	     log_store()                        << log_next_seq++
	      irq_work_queue()
}

In it's current form printk_safe() is redundant here.

	-ss
