Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3094BC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E4B218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391400AbfBMNoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:44:23 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:46539 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387886AbfBMNoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:44:04 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gtupL-0001ze-Ku; Wed, 13 Feb 2019 14:43:51 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190213013101.GA8097@jagdpanzerIV>
Date:   Wed, 13 Feb 2019 14:43:48 +0100
In-Reply-To: <20190213013101.GA8097@jagdpanzerIV> (Sergey Senozhatsky's
        message of "Wed, 13 Feb 2019 10:31:01 +0900")
Message-ID: <87d0nv248b.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

I am glad to see that you are getting involved here. Your previous
talks, work, and discussions were a large part of my research when
preparing for this work.

My response to your comments inline...

On 2019-02-13, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> On (02/12/19 15:29), John Ogness wrote:
>>
>> 1. The printk buffer is protected by a global raw spinlock for readers
>>    and writers. This restricts the contexts that are allowed to
>>   access the buffer.
>
> [..]
>
>> 2. Because of #1, NMI and recursive contexts are handled by deferring
>>    logging/printing to a spinlock-safe context. This means that
>>    messages will not be visible if (for example) the kernel dies in
>>    NMI context and the irq_work mechanism does not survive.
>
> panic() calls printk_safe_flush_on_panic(), which iterates all per-CPU
> buffers and moves data to the main logbuf; so then we can flush pending
> logbuf message
>
> 	panic()
> 	  printk_safe_flush_on_panic();
> 	  console_flush_on_panic();

If we are talking about an SMP system where logbuf_lock is locked, the
call chain is actually:

    panic()
      crash_smp_send_stop()
        ... wait for "num_online_cpus() == 1" ...
      printk_safe_flush_on_panic();
      console_flush_on_panic();

Is it guaranteed that the kernel will successfully stop the other CPUs
so that it can print to the console?

And then there is console_flush_on_panic(), which will ignore locks and
write to the consoles, expecting them to check "oops_in_progress" and
ignore their own internal locks.

Is it guaranteed that locks can just be ignored and backtraces will be
seen and legible to the user?

With the proposed emergency messages, panic() can write immediately to
the guaranteed NMI-safe write_atomic console without having to first do
anything with other CPUs (IPIs, NMIs, waiting, whatever) and without
ignoring locks.

> We don't really use irq_work mechanism for that.

Sorry. I didn't mean to imply that panic() uses irq_work. For non-panic
NMI situations irq_work is required (for example, WARN_ON). As an
example, if a WARN_ON occurred but the hardware locked up before the
irq_work engaged, the message is not seen.

Obviously I am talking about rare situations. But these situations do
occur and it is quite misfortunate (and frustrating!) when the kernel
has the important messages ready, but could not get them out.

>> 3. Because of #1, when *not* using features such as PREEMPT_RT, large
>>    latencies exist when printing to slow consoles.
>
> Because of #1? I'm not familiar with PREEMPT_RT; but logbuf spinlock
> should be unlocked while we print messages to slow consoles
> (call_consoles_drivers() is protected by console_sem, not logbuf
> lock).
>
> So it's
>
> 	spin_lock_irqsave(logbuf);
> 	vsprintf();
> 	memcpy();
> 	spin_unlock_irqrestore(logbuf);
>
> 	console_trylock();
> 	for (;;)
> 	    call_console_drivers();
> 	    				// console_owner handover
> 	console_unlock();
>
> Do you see large latencies because of logbuf spinlock?

Sorry. As you point out, this issue is not because of #1. It is because
of the call sequence:

    vprintk_emit()
      preempt_disable()
      console_unlock()
        call_console_drivers()
      preempt_enable()

For slow consoles, this can cause large latencies for some misfortunate
tasks.

>> 5. Printing to consoles is the responsibility of the printk caller
>>    and that caller may be required to print many messages that other
>>    printk callers inserted. Because of this there can be enormous
>>    variance in the runtime of a printk call.
>
> That's complicated. Steven's console_owner handover patch makes
> printk() more fair. We can have "winner takes it all" scenarios,
> but significantly less often, IMO. Do you have any data that
> suggest otherwise?

Steven's console_owner handover was a definite improvement. But as you
said, we can have "winner takes it all" scenarios (or rather "the last
one to leave the bar pays the bill"). This still should not be
acceptable. Let's let some some other _preemptible_ task pay the bill.

I am proposing to change printk so that a single pr_info() call can be
made without the fear that it might have to print thousands of messages
to multiple consoles, all with preemption disabled.

>> 7. Loglevel INFO is handled the same as ERR. There seems to be an
>>    endless effort to get printk to show _all_ messages as quickly as
>>    possible in case of a panic (i.e. printing from any context), but
>>    at the same time try not to have printk be too intrusive for the
>>    callers. These are conflicting requirements that lead to a printk
>>    implementation that does a sub-optimal job of satisfying both
>>    sides.
>
> Per my experience, fully preemptible "print it sometime maybe"
> printk() does not work equally well for everyone.

(I'm also including your previous relevant comment[0].)

> One thing that I have learned is that preemptible printk does not work
> as expected; it wants to be 'atomic' and just stay busy as long as it
> can.
> We tried preemptible printk at Samsung and the result was just bad:
>    preempted printk kthread + slow serial console = lots of lost
> messages

As long as all critical messages are print directly and immediately to
an emergency console, why is it is problem if the informational messages
to consoles are sometimes delayed or lost? And if those informational
messages _are_ so important, there are things the user can do. For
example, create a realtime userspace task to read /dev/kmsg.

> We also had preemptile printk in the upstream kernel and reverted the
> patch (see fd5f7cde1b85d4c8e09); same reasons - we had reports that
> preemptible printk could "stall" for minutes.

But in this case the preemptible task was used for printing critical
tasks as well. Then the stall really is a problem. I am proposing to
rely on emergency consoles for critical messages. By changing printk to
support 2 different channels (emergency and non-emergency), we can focus
on making each of those channels optimal.

This is exactly what point #7 is talking about: How we currently have
only 1 channel to try and satisfy all needs (whether critical or console
noise).

John Ogness

[0] http://lkml.kernel.org/r/20190212154736.GA3160@tigerII.localdomain
