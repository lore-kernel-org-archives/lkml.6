Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFC3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C140B2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406534AbfBNKd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:33:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:50284 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404171AbfBNKd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:33:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E63B7AF6E;
        Thu, 14 Feb 2019 10:33:25 +0000 (UTC)
Date:   Thu, 14 Feb 2019 11:33:24 +0100
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
Message-ID: <20190214103324.viexpifsyons5qya@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-3-john.ogness@linutronix.de>
 <20190213154541.wvft64nf352vghou@pathway.suse.cz>
 <87pnrvs707.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnrvs707.fsf@linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-02-13 22:39:20, John Ogness wrote:
> On 2019-02-13, Petr Mladek <pmladek@suse.com> wrote:
> >> +/*
> >> + * prb_unlock: Perform a processor-reentrant spin unlock.
> >> + * @cpu_lock: A pointer to the lock object.
> >> + * @cpu_store: A "flags" object storing lock status information.
> >> + *
> >> + * Release the lock. The calling processor must be the owner of the lock.
> >> + *
> >> + * It is safe to call this function from any context and state.
> >> + */
> >> +void prb_unlock(struct prb_cpulock *cpu_lock, unsigned int cpu_store)
> >> +{
> >> +	unsigned long *flags;
> >> +	unsigned int cpu;
> >> +
> >> +	cpu = atomic_read(&cpu_lock->owner);
> >> +	atomic_set_release(&cpu_lock->owner, cpu_store);
> >> +
> >> +	if (cpu_store == -1) {
> >> +		flags = per_cpu_ptr(cpu_lock->irqflags, cpu);
> >> +		local_irq_restore(*flags);
> >> +	}
> >
> > cpu_store looks like an implementation detail. The caller
> > needs to remember it to handle the nesting properly.
> 
> It's really no different than "flags" in irqsave/irqrestore.
> 
> > We could achieve the same with a recursion counter hidden
> > in struct prb_lock.
> 
> The only way I see how that could be implemented is if the cmpxchg
> encoded the cpu owner and counter into a single integer. (Upper half as
> counter, lower half as cpu owner.) Both fields would need to be updated
> with a single cmpxchg. The critical cmpxchg being the one where the CPU
> becomes unlocked (counter goes from 1 to 0 and cpu owner goes from N to
> -1).

The atomic operations are tricky. I feel other lost in them.
Well, I still think that it might easier to detect nesting
on the same CPU, see below.

Also there is no need to store irq flags in per-CPU variable.
Only the first owner of the lock need to store the flags. The others
are spinning or nested.

struct prb_cpulock {
	atomic_t		owner;
	unsigned int		flags;
	int			nesting; /* intialized to 0 */
};

void prb_lock(struct prb_cpulock *cpu_lock)
{
	unsigned int flags;
	int cpu;

	/*
	 * The next condition might be valid only when
	 * we are nested on the same CPU. It means
	 * the IRQs are already disabled and no
	 * memory barrier is needed.
	 */
	if (cpu_lock->owner == smp_processor_id()) {
		cpu_lock->nested++;
		return;
	}

	/* Not nested. Take the lock */
	local_irq_save(flags);
	cpu = smp_processor_id();

	for (;;) {
		if (atomic_try_cmpxchg_acquire(&cpu_lock->owner,
					       -1, cpu)) {
			cpu_lock->flags = flags;
			break;
		}

		cpu_relax();
	}
}

void prb_unlock(struct prb_cpulock *cpu_lock)
{
	unsigned int flags;

	if (cpu_lock->nested)
		cpu_lock->nested--;
		return;
	}

	/* We must be the first lock owner */
	flags = cpu_lock->flags;
	atomic_set_release(&cpu_lock->owner, -1);
	local_irq_restore(flags);
}

Or do I miss anything?

Best Regards,
Petr
