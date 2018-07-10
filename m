Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187F1C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6BB42087C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6BB42087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933220AbeGJLul (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 07:50:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:47944 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752029AbeGJLuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 07:50:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 40B2DAE07;
        Tue, 10 Jul 2018 11:50:38 +0000 (UTC)
Date:   Tue, 10 Jul 2018 13:50:36 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: printk() from NMI backtrace can delay a lot
Message-ID: <20180710115036.parj36owujllwr2i@pathway.suse.cz>
References: <bf037670-c647-b34a-486b-53ec3661b48e@i-love.sakura.ne.jp>
 <20180703043021.GA547@jagdpanzerIV>
 <20180703152944.GQ533219@devbig577.frc2.facebook.com>
 <20180703163145.GB391@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703163145.GB391@tigerII.localdomain>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-07-04 01:31:45, Sergey Senozhatsky wrote:
> Hello, Tejun
> 
> On (07/03/18 08:29), Tejun Heo wrote:
> > Hello, Sergey.
> > 
> > On Tue, Jul 03, 2018 at 01:30:21PM +0900, Sergey Senozhatsky wrote:
> > > Cc-ing Linus, Tejun, Andrew
> > > [I'll keep the entire lockdep report]
> > > 
> > > On (07/02/18 19:26), Tetsuo Handa wrote:
> > > [..]
> > > > 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606834] swapper/0/0 is trying to acquire lock:
> > > > 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606835] 00000000316e1432 (console_owner){-.-.}, at: console_unlock+0x1ce/0x8b0
> > > > 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606840] 
> > > > 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606841] but task is already holding lock:
> > > > 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606842] 000000009b45dcb4 (&(&pool->lock)->rlock){-.-.}, at: show_workqueue_state+0x3b2/0x900
> > > > 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606847] 
> > > > 2018-07-02 12:13:13 192.168.159.129:6666 [  151.606848] which lock already depends on the new lock.
> > ...
> > > But anyway. So we can have [but I'm not completely sure. Maybe lockdep has
> > > something else on its mind] something like this:
> > > 
> > > 	CPU1					CPU0
> > > 
> > > 	#IRQ					#soft irq
> > > 	serial8250_handle_irq()			wq_watchdog_timer_fn()
> > > 	 spin_lock(&uart_port->lock)		 show_workqueue_state()
> > > 	  serial8250_rx_chars()			   spin_lock(&pool->lock)
> > > 	   tty_flip_buffer_push()		    printk()
> > > 	    tty_schedule_flip()			     serial8250_console_write()
> > > 	     queue_work()			      spin_lock(&uart_port->lock)
> > > 	      __queue_work()
> > > 	       spin_lock(&pool->lock)
> > > 
> > > We need to break the pool->lock -> uart_port->lock chain.
> > > 
> > > - use printk_deferred() to show WQs states [show_workqueue_state() is
> > >   a timer callback, so local IRQs are enabled]. But show_workqueue_state()
> > >   is also available via sysrq.
> > > 
> > > - what Alan Cox suggested: use spin_trylock() in serial8250_console_write()
> > >   and just discard (do not print anything on console) console->writes() that
> > >   can deadlock us [uart_port->lock is already locked]. This basically means
> > >   that sometimes there will be no output on a serial console, or there
> > >   will be missing line. Which kind of contradicts the purpose of print
> > >   out.
> > > 
> > > We are facing the risk of no output on serial consoles in both case. Thus
> > > there must be some other way out of this.
> > 
> > show_workqueue_state() is only used when something is already horribly
> > broken or when invoked through sysrq.
> 
> Tetsuo is hammering sysrq for fun and profit ;)
> 
> > I'm not sure it's worthwhile to make invasive changes to avoid lockdep
> > warnings.  If anything, we should make show_workqueue_state() avoid
> > grabbing pool->lock (e.g. use trylock and fallback to probe_kernel_reads
> > if that fails).  I'm a bit skeptical how actually useful that'd be tho.
> 
> So, I agree.
> 
> Another option *possibly* could be...
> 
> ... maybe we can brake another lock dependency. I don't quite understand,
> and surely I'm missing something here, why serial driver call
> tty_flip_buffer_push() under uart_port->lock. E.g.
> 
> 	serial_driver_handle_irq()
> 	{
> 		spin_lock(uart_port->lock);
> 
> 		.. TX() / RX()
> 
> 		tty_flip_buffer_push(uart_port->tty_port);
> 		spin_unlock(uart_port->lock);
> 	}
> 
> it might be the case that we can do
> 
> 	serial_driver_handle_irq()
> 	{
> 		spin_loc(uart_port->lock);
> 
> 		.. TX / RX
> 
> 		spin_unlock(uart_port->lock);
> 
> 		tty_flip_buffer_push(uart_port->tty_port);

Hmm, this looks racy. For example, I see the following in
serial_lpc32xx_interrupt():

		tty_insert_flip_char(tport, 0, TTY_OVERRUN);
		tty_schedule_flip(tport);

where tty_insert_flip_char() manipulates flag/char/used:

			*flag_buf_ptr(tb, tb->used) = flag;
		*char_buf_ptr(tb, tb->used++) = ch;

and tty_schedule_flip() copies "used" -> "commit":

	smp_store_release(&buf->tail->commit, buf->tail->used);
	queue_work(system_unbound_wq, &buf->work);

I do not have the entire picture but I guess that we need to
commit only correctly set characters and flags. Therefore
the manipulation of flag/ch/used/commit need to be synchronized.
It seems that &port->lock is used for this.


Sigh, I am not aware of any good solution.

I agree with Tejun that using printk_deferred() in
show_workqueue_state() is questionable. Basically any deferring
is risky. There is no guarantee that the deferred operation will
get realized.

Also Alan Cox's idea: "use spin_trylock() in
serial8250_console_write()" has problems. Sergey already mentioned
that we might then miss random lines on a particular console.

So far, the best (and realistic?) idea seems to be switching to
printk_deferred() context when port->lock is taken. It would
be a well defined pattern that people might get used to.

Of course, the best solution would be to have printk and
console->write() lock-less. But this would mean a lot of
tricky code unless anyone comes with a brilliant design.

Best Regards,
Petr
