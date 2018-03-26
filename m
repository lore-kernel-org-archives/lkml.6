Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbeCZJ0r (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 05:26:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:45846 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750864AbeCZJ0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 05:26:46 -0400
Date: Mon, 26 Mar 2018 11:26:44 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        bugzilla-daemon@bugzilla.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, wen.yang99@zte.com.cn,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [Bug 199003] console stalled, cause Hard LOCKUP.
Message-ID: <20180326092644.c3urr5j26pw5f7ve@pathway.suse.cz>
References: <bug-199003-8243@https.bugzilla.kernel.org/>
 <bug-199003-8243-Txkdkdv5Cm@https.bugzilla.kernel.org/>
 <20180321094422.6e099480@gandalf.local.home>
 <20180322021437.GA3181@jagdpanzerIV>
 <20180322182517.511aad9d@gandalf.local.home>
 <20180323120622.GA510@jagdpanzerIV>
 <20180323131653.4bsco3v7xdb7ifvu@pathway.suse.cz>
 <20180326051222.GA7779@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326051222.GA7779@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-03-26 14:12:22, Sergey Senozhatsky wrote:
> Given how slow serial8250_console_putchar()->wait_for_xmitr() can be -
> 10ms of delay for every char - it's possible that we had no concurrent
> printk()-s from other CPUs. So may be we had just one printing CPU,
> and several CPUs spinning on a spin_lock which was owned by the printing
> CPU.
> 
> So that's why printk_deferred() helped here. It simply detached 8250
> and made spin_lock critical secrtion to be as fast as printk->log_store().
>
> But here comes the tricky part. Suppose that we:
> a) have at least two CPUs that call printk concurrently
> b) have hand off enabled
> 
> 
> Now, what will happen if we have something like this
> 
> CPU0					CPU1				CPU2
> 					spin_lock(queue_lock)
> 					 printk				printk
> cfqg_print_rwstat_recursive()		  serial8250
>  spin_lock(queue_lock)			 printk				 serial8250
>  					  serial8250			printk
> 									 serial8250
> 
> 
> I suspect that handoff may not be very helpful. CPU1 and CPU2 will wait for
> each to finish serial8250 and to hand off printing to each other. So CPU1
> will do 2 serial8250 invocations to printk its messages, and in between it
> will spin waiting for CPU2 to do its printk->serial8250 and to handoff
> printing to CPU1. The problem is that CPU1 will be under spin_lock() all
> that time, so CPU0 is going to suffer just like before.
> 
> Opinions?

It would help if Wen Yang could provide the entire log and also try the
Steven's patches. Otherwise, we are too speculating.

The 10ms delay-per-char looks scarry. But if I get it correctly, it
would happen only if we hit the deadline for each character. So,
a question is if the serial port is really that busy and if so why.

Also I wonder how many messages were actually printed under the
queue_lock. printk_deferred() seems to help but it is an immediate
offload. I wonder if the offload from console_unlock() would actually
help. It might fail to detect the critic situation if too many lines
are printed inside the lock and console_unlock() is called for each
line separately. Also it would fail when only single line caused that
big delay.

Best Regards,
Petr
