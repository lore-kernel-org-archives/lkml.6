Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F137AC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93212190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392530AbfBMPpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:45:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:42496 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726317AbfBMPpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:45:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6B0F9AD1A;
        Wed, 13 Feb 2019 15:45:42 +0000 (UTC)
Date:   Wed, 13 Feb 2019 16:45:41 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
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
Message-ID: <20190213154541.wvft64nf352vghou@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212143003.48446-3-john.ogness@linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-02-12 15:29:40, John Ogness wrote:
> Add processor-reentrant spin locking functions. These allow
> restricting the number of possible contexts to 2, which can simplify
> implementing code that also supports NMI interruptions.
> 
>     prb_lock();
> 
>     /*
>      * This code is synchronized with all contexts
>      * except an NMI on the same processor.
>      */
> 
>     prb_unlock();
> 
> In order to support printk's emergency messages, a
> processor-reentrant spin lock will be used to control raw access to
> the emergency console. However, it must be the same
> processor-reentrant spin lock as the one used by the ring buffer,
> otherwise a deadlock can occur:
> 
>     CPU1: printk lock -> emergency -> serial lock
>     CPU2: serial lock -> printk lock
> 
> By making the processor-reentrant implemtation available externally,
> printk can use the same atomic_t for the ring buffer as for the
> emergency console and thus avoid the above deadlock.

Interesting idea. I just wonder if it might cause some problems
when it is shared between printk() and many other consoles.

It sounds like the big kernel lock or console_lock. They
both caused many troubles.


> diff --git a/lib/printk_ringbuffer.c b/lib/printk_ringbuffer.c
> new file mode 100644
> index 000000000000..28958b0cf774
> --- /dev/null
> +++ b/lib/printk_ringbuffer.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/smp.h>
> +#include <linux/printk_ringbuffer.h>
> +
> +static bool __prb_trylock(struct prb_cpulock *cpu_lock,
> +			  unsigned int *cpu_store)
> +{
> +	unsigned long *flags;
> +	unsigned int cpu;
> +
> +	cpu = get_cpu();
> +
> +	*cpu_store = atomic_read(&cpu_lock->owner);
> +	/* memory barrier to ensure the current lock owner is visible */
> +	smp_rmb();
> +	if (*cpu_store == -1) {
> +		flags = per_cpu_ptr(cpu_lock->irqflags, cpu);
> +		local_irq_save(*flags);
> +		if (atomic_try_cmpxchg_acquire(&cpu_lock->owner,
> +					       cpu_store, cpu)) {
> +			return true;
> +		}
> +		local_irq_restore(*flags);
> +	} else if (*cpu_store == cpu) {
> +		return true;
> +	}
> +
> +	put_cpu();

Is there any reason why you get/put CPU and enable/disable
in each iteration?

It is a spin lock after all. We do busy waiting anyway. This looks like
burning CPU power for no real gain. Simple cpu_relax() should be enough.

> +	return false;
> +}
> +
> +/*
> + * prb_lock: Perform a processor-reentrant spin lock.
> + * @cpu_lock: A pointer to the lock object.
> + * @cpu_store: A "flags" pointer to store lock status information.
> + *
> + * If no processor has the lock, the calling processor takes the lock and
> + * becomes the owner. If the calling processor is already the owner of the
> + * lock, this function succeeds immediately. If lock is locked by another
> + * processor, this function spins until the calling processor becomes the
> + * owner.
> + *
> + * It is safe to call this function from any context and state.
> + */
> +void prb_lock(struct prb_cpulock *cpu_lock, unsigned int *cpu_store)
> +{
> +	for (;;) {
> +		if (__prb_trylock(cpu_lock, cpu_store))
> +			break;
> +		cpu_relax();
> +	}
> +}
> +
> +/*
> + * prb_unlock: Perform a processor-reentrant spin unlock.
> + * @cpu_lock: A pointer to the lock object.
> + * @cpu_store: A "flags" object storing lock status information.
> + *
> + * Release the lock. The calling processor must be the owner of the lock.
> + *
> + * It is safe to call this function from any context and state.
> + */
> +void prb_unlock(struct prb_cpulock *cpu_lock, unsigned int cpu_store)
> +{
> +	unsigned long *flags;
> +	unsigned int cpu;
> +
> +	cpu = atomic_read(&cpu_lock->owner);
> +	atomic_set_release(&cpu_lock->owner, cpu_store);
> +
> +	if (cpu_store == -1) {
> +		flags = per_cpu_ptr(cpu_lock->irqflags, cpu);
> +		local_irq_restore(*flags);
> +	}

cpu_store looks like an implementation detail. The caller
needs to remember it to handle the nesting properly.

We could achieve the same with a recursion counter hidden
in struct prb_lock.

Best Regards,
Petr


PS: This is the most complex patchset that I have ever reviewed.
I am not sure what is the best approach. I am going to understand
it and comment on what touches my eye. I will comment the overall
design later after I have a better understanding.

The first feeling is that it would be nice to be able to
store messages into a single log buffer from every context.
It will depend if the new approach is safe and maintainable.

The offloading of console handling into a kthread might be
problematic. We were pushing it for years and never succeeded.
People preferred to minimize the risk that messages would never
appear on the console.

Well, I still think that it might be needed because Steven's
console waiter logic does not prevent softlockups completely.
And realtime has much bigger problems with unpredictable
random printk-console-lockups requirements. IMHO, we need
a solution for the realtime mode and normal one could just benefit
from it. We have some ideas in the drawer. And this patchset
brings some new. Let's see.

Best Regards,
Petr
