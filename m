Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36866C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6CB222A4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394919AbfBMVjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:39:32 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:47785 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbfBMVjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:39:32 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gu2FW-0006GL-7T; Wed, 13 Feb 2019 22:39:22 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
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
Subject: Re: [RFC PATCH v1 02/25] printk-rb: add prb locking functions
References: <20190212143003.48446-1-john.ogness@linutronix.de>
        <20190212143003.48446-3-john.ogness@linutronix.de>
        <20190213154541.wvft64nf352vghou@pathway.suse.cz>
Date:   Wed, 13 Feb 2019 22:39:20 +0100
Message-ID: <87pnrvs707.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-13, Petr Mladek <pmladek@suse.com> wrote:
>> Add processor-reentrant spin locking functions. These allow
>> restricting the number of possible contexts to 2, which can simplify
>> implementing code that also supports NMI interruptions.
>> 
>>     prb_lock();
>> 
>>     /*
>>      * This code is synchronized with all contexts
>>      * except an NMI on the same processor.
>>      */
>> 
>>     prb_unlock();
>> 
>> In order to support printk's emergency messages, a
>> processor-reentrant spin lock will be used to control raw access to
>> the emergency console. However, it must be the same
>> processor-reentrant spin lock as the one used by the ring buffer,
>> otherwise a deadlock can occur:
>> 
>>     CPU1: printk lock -> emergency -> serial lock
>>     CPU2: serial lock -> printk lock
>> 
>> By making the processor-reentrant implemtation available externally,
>> printk can use the same atomic_t for the ring buffer as for the
>> emergency console and thus avoid the above deadlock.
>
> Interesting idea. I just wonder if it might cause some problems
> when it is shared between printk() and many other consoles.
>
> It sounds like the big kernel lock or console_lock. They
> both caused many troubles.

It causes big troubles (deadlocks) if you have multiple instances of
it. Mainly because printk can be called from _any_ line of code in the
kernel. That is the reason I decided that it needs to be shared and only
used in call chains that are carefully constructed such as:

   printk -> write_atomic

and NMI contexts are _never_ allowed to do things that rely on waiting
forever for other CPUs. For that reason it does kinda feel like a BKL.

If we do find some problems, we may want to switch to a ringbuffer
implementation that is fully lockless for both multi-readers and
multi-writers. I have written such a beast, but it is less efficient and
more complex than the ringbuffer in this series. Also, that only shrinks
the window since write_atomic would still need to make use of the
processor-reentrant spinlock to synchronize the console output. That's
why I decided to RFC with the simpler ringbuffer implementation.

>> diff --git a/lib/printk_ringbuffer.c b/lib/printk_ringbuffer.c
>> new file mode 100644
>> index 000000000000..28958b0cf774
>> --- /dev/null
>> +++ b/lib/printk_ringbuffer.c
>> @@ -0,0 +1,77 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <linux/smp.h>
>> +#include <linux/printk_ringbuffer.h>
>> +
>> +static bool __prb_trylock(struct prb_cpulock *cpu_lock,
>> +			  unsigned int *cpu_store)
>> +{
>> +	unsigned long *flags;
>> +	unsigned int cpu;
>> +
>> +	cpu = get_cpu();
>> +
>> +	*cpu_store = atomic_read(&cpu_lock->owner);
>> +	/* memory barrier to ensure the current lock owner is visible */
>> +	smp_rmb();
>> +	if (*cpu_store == -1) {
>> +		flags = per_cpu_ptr(cpu_lock->irqflags, cpu);
>> +		local_irq_save(*flags);
>> +		if (atomic_try_cmpxchg_acquire(&cpu_lock->owner,
>> +					       cpu_store, cpu)) {
>> +			return true;
>> +		}
>> +		local_irq_restore(*flags);
>> +	} else if (*cpu_store == cpu) {
>> +		return true;
>> +	}
>> +
>> +	put_cpu();
>
> Is there any reason why you get/put CPU and enable/disable
> in each iteration?
>
> It is a spin lock after all. We do busy waiting anyway. This looks like
> burning CPU power for no real gain. Simple cpu_relax() should be
> enough.

Agreed.

>> +	return false;
>> +}
>> +
>> +/*
>> + * prb_lock: Perform a processor-reentrant spin lock.
>> + * @cpu_lock: A pointer to the lock object.
>> + * @cpu_store: A "flags" pointer to store lock status information.
>> + *
>> + * If no processor has the lock, the calling processor takes the lock and
>> + * becomes the owner. If the calling processor is already the owner of the
>> + * lock, this function succeeds immediately. If lock is locked by another
>> + * processor, this function spins until the calling processor becomes the
>> + * owner.
>> + *
>> + * It is safe to call this function from any context and state.
>> + */
>> +void prb_lock(struct prb_cpulock *cpu_lock, unsigned int *cpu_store)
>> +{
>> +	for (;;) {
>> +		if (__prb_trylock(cpu_lock, cpu_store))
>> +			break;
>> +		cpu_relax();
>> +	}
>> +}
>> +
>> +/*
>> + * prb_unlock: Perform a processor-reentrant spin unlock.
>> + * @cpu_lock: A pointer to the lock object.
>> + * @cpu_store: A "flags" object storing lock status information.
>> + *
>> + * Release the lock. The calling processor must be the owner of the lock.
>> + *
>> + * It is safe to call this function from any context and state.
>> + */
>> +void prb_unlock(struct prb_cpulock *cpu_lock, unsigned int cpu_store)
>> +{
>> +	unsigned long *flags;
>> +	unsigned int cpu;
>> +
>> +	cpu = atomic_read(&cpu_lock->owner);
>> +	atomic_set_release(&cpu_lock->owner, cpu_store);
>> +
>> +	if (cpu_store == -1) {
>> +		flags = per_cpu_ptr(cpu_lock->irqflags, cpu);
>> +		local_irq_restore(*flags);
>> +	}
>
> cpu_store looks like an implementation detail. The caller
> needs to remember it to handle the nesting properly.

It's really no different than "flags" in irqsave/irqrestore.

> We could achieve the same with a recursion counter hidden
> in struct prb_lock.

The only way I see how that could be implemented is if the cmpxchg
encoded the cpu owner and counter into a single integer. (Upper half as
counter, lower half as cpu owner.) Both fields would need to be updated
with a single cmpxchg. The critical cmpxchg being the one where the CPU
becomes unlocked (counter goes from 1 to 0 and cpu owner goes from N to
-1).

That seems like a lot of extra code just to avoid passing a "flags"
argument.

John Ogness
