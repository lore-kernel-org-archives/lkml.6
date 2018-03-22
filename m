Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751912AbeCVCOp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 22:14:45 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37529 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751854AbeCVCOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 22:14:42 -0400
X-Google-Smtp-Source: AG47ELtYTKXGxWUsklw/EDIZPq8HhaobpaQ3Zfagjy4kQse4wmZ8F2esZcp0axsBwoh7B6s7Jlf2ew==
Date: Thu, 22 Mar 2018 11:14:37 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: bugzilla-daemon@bugzilla.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, wen.yang99@zte.com.cn,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [Bug 199003] console stalled, cause Hard LOCKUP.
Message-ID: <20180322021437.GA3181@jagdpanzerIV>
References: <bug-199003-8243@https.bugzilla.kernel.org/>
 <bug-199003-8243-Txkdkdv5Cm@https.bugzilla.kernel.org/>
 <20180321094422.6e099480@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180321094422.6e099480@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Steven,

On (03/21/18 09:44), Steven Rostedt wrote:
[..]
> >  #4 [ffff881ffb0b7540] delay_tsc at ffffffff81326724
> >  #5 [ffff881ffb0b7548] __const_udelay at ffffffff81326678
> >  #6 [ffff881ffb0b7558] wait_for_xmitr at ffffffff814056e0
> >  #7 [ffff881ffb0b7580] serial8250_console_putchar at ffffffff814058ac
> >  #8 [ffff881ffb0b75a0] uart_console_write at ffffffff8140035a
> >  #9 [ffff881ffb0b75d0] serial8250_console_write at ffffffff814057fe
> > #10 [ffff881ffb0b7618] call_console_drivers.constprop.17 at ffffffff81087011
> > #11 [ffff881ffb0b7640] console_unlock at ffffffff810889e9
> > #12 [ffff881ffb0b7680] vprintk_emit at ffffffff81088df4
> > #13 [ffff881ffb0b76f0] dev_vprintk_emit at ffffffff81428e72
> > #14 [ffff881ffb0b77a8] dev_printk_emit at ffffffff81428eee
> > #15 [ffff881ffb0b7808] __dev_printk at ffffffff8142937e
> > #16 [ffff881ffb0b7818] dev_printk at ffffffff8142942d
> > #17 [ffff881ffb0b7888] sdev_prefix_printk at ffffffff81463771
> > #18 [ffff881ffb0b7918] scsi_prep_state_check at ffffffff814598e4
> > #19 [ffff881ffb0b7928] scsi_prep_fn at ffffffff8145992d
> > #20 [ffff881ffb0b7960] blk_peek_request at ffffffff812f0826
> > #21 [ffff881ffb0b7988] scsi_request_fn at ffffffff8145b588
> > #22 [ffff881ffb0b79f0] __blk_run_queue at ffffffff812ebd63
> > #23 [ffff881ffb0b7a08] blk_queue_bio at ffffffff812f1013        -----》acquired q->queue_lock and wait for console_write to finish
> 
> What do you mean by "wait for console_write to finish" here?

*My guess*

I suppose a typical "printk->console_unlock() under spin_lock" thing

	CPU0						CPU1
	spin_lock(&lock)
	 printk						spin_lock(&lock)
	  console_unlock()
	   for (;;)
	    call_console_drivers()

While other CPUs printk->log_store() and some (or may be just one) is locked
up on spin_lock(&lock). So we have several lockup vectors here - one is
console_unlock() under spin_lock and the other one is CPUs spinning on the
very same spin_lock. So handoff should help here, no doubt. But it cannot help
if other CPUs will start to printk_deferred() instead of printk().


Looking at
 printk()->call_console_drivers()->serial8250_console_putchar()->wait_for_xmitr()

... wait_for_xmitr() can spin for over 1 second waiting for the UART_MSR_CTS
bit.

static void wait_for_xmitr(struct uart_8250_port *up, int bits)
{
	unsigned int status, tmout = 10000;

	/* Wait up to 10ms for the character(s) to be sent. */
	for (;;) {
		status = serial_in(up, UART_LSR);

		up->lsr_saved_flags |= status & LSR_SAVE_FLAGS;

		if ((status & bits) == bits)
			break;
		if (--tmout == 0)
			break;
		udelay(1);
		touch_nmi_watchdog();
	}

	/* Wait up to 1s for flow control if necessary */
	if (up->port.flags & UPF_CONS_FLOW) {
		for (tmout = 1000000; tmout; tmout--) {
			unsigned int msr = serial_in(up, UART_MSR);
			up->msr_saved_flags |= msr & MSR_SAVE_FLAGS;
			if (msr & UART_MSR_CTS)
				break;
			udelay(1);
			touch_nmi_watchdog();
		}
	}
	...
}

a 1+ second long busy loop in the console driver is quite close to
"problems guaranteed". But, wait, there is even more. This wait_for_xmitr()
busy wait is happening after every character we print on the console. So
printk("foo") will generate 5 * wait_for_xmitr() busy loops [foo + \r + \n].
They punch&touch watchdog a lot, so at the least the system won't get killed
by the hardlockup detector. But at the same time, it's still potentially a
1+ second busy loop in the console driver * strlen(message).

Sometimes I really wish we had detached consoles. Direct printk()->console
is nice and cool, but... we can't have it. I don't want to pressure for
printk_kthread, but look at all those consoles. There are not so many ways
out. What do you think?

	-ss
