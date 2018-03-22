Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbeCVWZV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 18:25:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751541AbeCVWZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 18:25:20 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F53E2183A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 22 Mar 2018 18:25:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: bugzilla-daemon@bugzilla.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, wen.yang99@zte.com.cn,
        Petr Mladek <pmladek@suse.com>, Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [Bug 199003] console stalled, cause Hard LOCKUP.
Message-ID: <20180322182517.511aad9d@gandalf.local.home>
In-Reply-To: <20180322021437.GA3181@jagdpanzerIV>
References: <bug-199003-8243@https.bugzilla.kernel.org/>
        <bug-199003-8243-Txkdkdv5Cm@https.bugzilla.kernel.org/>
        <20180321094422.6e099480@gandalf.local.home>
        <20180322021437.GA3181@jagdpanzerIV>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Mar 2018 11:14:37 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:


> Looking at
>  printk()->call_console_drivers()->serial8250_console_putchar()->wait_for_xmitr()
> 
> ... wait_for_xmitr() can spin for over 1 second waiting for the UART_MSR_CTS
> bit.
> 
> static void wait_for_xmitr(struct uart_8250_port *up, int bits)
> {
> 	unsigned int status, tmout = 10000;
> 
> 	/* Wait up to 10ms for the character(s) to be sent. */
> 	for (;;) {
> 		status = serial_in(up, UART_LSR);
> 
> 		up->lsr_saved_flags |= status & LSR_SAVE_FLAGS;
> 
> 		if ((status & bits) == bits)
> 			break;
> 		if (--tmout == 0)
> 			break;
> 		udelay(1);
> 		touch_nmi_watchdog();
> 	}
> 
> 	/* Wait up to 1s for flow control if necessary */
> 	if (up->port.flags & UPF_CONS_FLOW) {
> 		for (tmout = 1000000; tmout; tmout--) {
> 			unsigned int msr = serial_in(up, UART_MSR);
> 			up->msr_saved_flags |= msr & MSR_SAVE_FLAGS;
> 			if (msr & UART_MSR_CTS)
> 				break;
> 			udelay(1);
> 			touch_nmi_watchdog();
> 		}
> 	}
> 	...
> }
> 
> a 1+ second long busy loop in the console driver is quite close to

Yeah that's nasty but shouldn't ever hit 1 second unless there's
hardware issues.

> "problems guaranteed". But, wait, there is even more. This wait_for_xmitr()
> busy wait is happening after every character we print on the console. So
> printk("foo") will generate 5 * wait_for_xmitr() busy loops [foo + \r + \n].
> They punch&touch watchdog a lot, so at the least the system won't get killed
> by the hardlockup detector. But at the same time, it's still potentially a
> 1+ second busy loop in the console driver * strlen(message).
> 
> Sometimes I really wish we had detached consoles. Direct printk()->console
> is nice and cool, but... we can't have it. I don't want to pressure for
> printk_kthread, but look at all those consoles. There are not so many ways
> out. What do you think?

If anything, perhaps we could have a printk thread that is triggered to
wake up if any print is taking a long time, or if there's a lot of
prints happening. And then it could try to print anything in the
buffer. Just the mere printk() in the thread should do the hand off.

I wonder how bad it would be to wake the printk thread whenever a
printk() is executed. Printks really shouldn't be that common.

-- Steve
