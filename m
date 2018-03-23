Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753426AbeCWMGb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 08:06:31 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37713 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753330AbeCWMG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 08:06:27 -0400
X-Google-Smtp-Source: AG47ELsIVnGvteziI65sq1FBvPAQc0S0qVlnNxBOOfpH3A7xwXGuYRO1j5URbiMT9CPZnKfbgHJY+A==
Date: Fri, 23 Mar 2018 21:06:22 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        bugzilla-daemon@bugzilla.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, wen.yang99@zte.com.cn,
        Petr Mladek <pmladek@suse.com>, Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [Bug 199003] console stalled, cause Hard LOCKUP.
Message-ID: <20180323120622.GA510@jagdpanzerIV>
References: <bug-199003-8243@https.bugzilla.kernel.org/>
 <bug-199003-8243-Txkdkdv5Cm@https.bugzilla.kernel.org/>
 <20180321094422.6e099480@gandalf.local.home>
 <20180322021437.GA3181@jagdpanzerIV>
 <20180322182517.511aad9d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322182517.511aad9d@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Steven,

On (03/22/18 18:25), Steven Rostedt wrote:
> > static void wait_for_xmitr(struct uart_8250_port *up, int bits)
> > {
> > 	unsigned int status, tmout = 10000;
> > 
> > 	/* Wait up to 10ms for the character(s) to be sent. */
> > 	for (;;) {
			....
> > 		if (--tmout == 0)
> > 			break;
> > 		udelay(1);
> > 		touch_nmi_watchdog();
> > 	}
> > 
> > 	/* Wait up to 1s for flow control if necessary */
> > 	if (up->port.flags & UPF_CONS_FLOW) {
> > 		for (tmout = 1000000; tmout; tmout--) {
			....
> > 			udelay(1);
> > 			touch_nmi_watchdog();
> > 		}
> > 	}
> > 	...
> > }
> > 
> > a 1+ second long busy loop in the console driver is quite close to
> 
> Yeah that's nasty but shouldn't ever hit 1 second unless there's
> hardware issues.

Would probably agree. But even without that 1 second UPF_CONS_FLOW loop
(it seems that there are not so many consoles that have that flag set),
we have a 10ms [10000 * udelay(1)] loop after every character. So if we
print a 512-bytes kernel message [1/2 of a max printk message length]
than its 0.01 * (512 + \r + \n) seconds. Which is a lot, unless I
miscalculated 10000 * udelay(1). Delays in the first loop are normal,
probably not always 10ms, tho, but still.

[..]
> > Sometimes I really wish we had detached consoles. Direct printk()->console
> > is nice and cool, but... we can't have it. I don't want to pressure for
> > printk_kthread, but look at all those consoles. There are not so many ways
> > out. What do you think?
> 
> If anything, perhaps we could have a printk thread that is triggered to
> wake up if any print is taking a long time, or if there's a lot of
> prints happening. And then it could try to print anything in the
> buffer. Just the mere printk() in the thread should do the hand off.

OK. Let's think more about this. I have that "wake up printk_kthread if
any print is taking a long time, or if there's a lot of prints happening"
patch set: a watchdog threshold based solution. I didn't update it for a
while, but can take a look. Detaching printouts does look to me like
something we need to do.

Offloading does not work well enough with hand off (in its current
form). Because the CPU that we offloaded printing from can re-take
console_sem the very next time it calls printk().

Something like

       spin_lock(&lock)
	printk() -> 8250
	 console_unlock()
	 offload		printk_kthread
	printk() -> 8250	 console_unlock()
	printk() -> 8250	  hand off
	 console_unlock()

so if printk() -> 8250 is very slow and is under some spin_lock
(like in case of Bug 199003) then offloading doesn't make that much
difference here. Right? If we don't hand off from printk_kthread
then things do look different.

> I wonder how bad it would be to wake the printk thread whenever a
> printk() is executed. Printks really shouldn't be that common.

That didn't work quite well for me. But I must admit that my previous
printk_kthread version had some major design problems - preemption in
printk path [including printk_kthread preemption], the lack of any
reliable way for any CPU to control what printk_kthread is doing, and
so on and on. Current version, I guess, is better. But I don't do
"vprintk_emit() -> wake_up(printk_kthread)", instead I let "direct"
printks and wake_up(printk_kthread) only when current CPU spent too
much time in call_console_drivers(); it's quite easy to track given
that printk->console_unlock() is preempt_disable() now. Besides,
offloading from console_unlock() automatically handles various cases
for use. Like printk_deferred() -> IRQ -> console_unlock() and so on.

What do you think?

	-ss
