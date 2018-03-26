Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752703AbeCZS5l (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 14:57:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750983AbeCZS5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 14:57:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693672177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 26 Mar 2018 14:57:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Yury Norov <ynorov@caviumnetworks.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christopher Lameter <cl@linux.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        kvm-ppc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] smp: introduce kick_active_cpus_sync()
Message-ID: <20180326145735.57ba306b@gandalf.local.home>
In-Reply-To: <20180326085313.GA4016@andrea>
References: <20180325175004.28162-1-ynorov@caviumnetworks.com>
        <20180325175004.28162-3-ynorov@caviumnetworks.com>
        <20180326085313.GA4016@andrea>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Mar 2018 10:53:13 +0200
Andrea Parri <andrea.parri@amarulasolutions.com> wrote:

> > --- a/kernel/smp.c
> > +++ b/kernel/smp.c
> > @@ -724,6 +724,30 @@ void kick_all_cpus_sync(void)
> >  }
> >  EXPORT_SYMBOL_GPL(kick_all_cpus_sync);
> >  
> > +/**
> > + * kick_active_cpus_sync - Force CPUs that are not in extended
> > + * quiescent state (idle or nohz_full userspace) sync by sending
> > + * IPI. Extended quiescent state CPUs will sync at the exit of
> > + * that state.
> > + */
> > +void kick_active_cpus_sync(void)
> > +{
> > +	int cpu;
> > +	struct cpumask kernel_cpus;
> > +
> > +	smp_mb();  
> 
> (A general remark only:)
> 
> checkpatch.pl should have warned about the fact that this barrier is
> missing an accompanying comment (which accesses are being "ordered",
> what is the pairing barrier, etc.).

He could have simply copied the comment above the smp_mb() for
kick_all_cpus_sync():

	/* Make sure the change is visible before we kick the cpus */

The kick itself is pretty much a synchronization primitive.

That is, you make some changes and then you need all CPUs to see it,
and you call: kick_active_cpus_synch(), which is the barrier to make
sure you previous changes are seen on all CPUS before you proceed
further. Note, the matching barrier is implicit in the IPI itself.

-- Steve


> 
> Moreover if, as your reply above suggested, your patch is relying on
> "implicit barriers" (something I would not recommend) then even more
> so you should comment on these requirements.
> 
> This could: (a) force you to reason about the memory ordering stuff,
> (b) easy the task of reviewing and adopting your patch, (c) easy the
> task of preserving those requirements (as implementations changes).
> 
>   Andrea
> 
> 
> > +
> > +	cpumask_clear(&kernel_cpus);
> > +	preempt_disable();
> > +	for_each_online_cpu(cpu) {
> > +		if (!rcu_eqs_special_set(cpu))
> > +			cpumask_set_cpu(cpu, &kernel_cpus);
> > +	}
> > +	smp_call_function_many(&kernel_cpus, do_nothing, NULL, 1);
> > +	preempt_enable();
> > +}
> > +EXPORT_SYMBOL_GPL(kick_active_cpus_sync);
> > +
> >  /**
> >   * wake_up_all_idle_cpus - break all cpus out of idle
> >   * wake_up_all_idle_cpus try to break all cpus which is in idle state even
> > diff --git a/mm/slab.c b/mm/slab.c
> > index 324446621b3e..678d5dbd6f46 100644
> > --- a/mm/slab.c
> > +++ b/mm/slab.c
> > @@ -3856,7 +3856,7 @@ static int __do_tune_cpucache(struct kmem_cache *cachep, int limit,
> >  	 * cpus, so skip the IPIs.
> >  	 */
> >  	if (prev)
> > -		kick_all_cpus_sync();
> > +		kick_active_cpus_sync();
> >  
> >  	check_irq_on();
> >  	cachep->batchcount = batchcount;
> > -- 
> > 2.14.1
> >   
