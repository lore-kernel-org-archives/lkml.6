Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAAAC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B473B21A13
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B473B21A13
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeHHRnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:43:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727202AbeHHRnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:43:21 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9C6E21990;
        Wed,  8 Aug 2018 15:23:10 +0000 (UTC)
Date:   Wed, 8 Aug 2018 11:23:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Joel Fernandes <joelaf@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v12 3/3] tracing: Centralize preemptirq tracepoints and
 unify their usage
Message-ID: <20180808112309.6edda174@gandalf.local.home>
In-Reply-To: <20180808150558.GO24813@linux.vnet.ibm.com>
References: <20180807215522.04114097@vmware.local.home>
        <CAJWu+opjqKgZj30PYpyvip=EtP8CuqaEy65++nuvj37QMT6GCw@mail.gmail.com>
        <20180807222856.3ede96e7@vmware.local.home>
        <CAJWu+oqcM_-rtuUe7hhMHyZ2UKZ5J4rBZO7UoHxxd2DAs=aHdA@mail.gmail.com>
        <CAJWu+oqPUuF4rFOQ8=G3+ZxXJxiiNRBYE8C=zZ93A8qA+muHEg@mail.gmail.com>
        <20180808084629.3290d1d6@gandalf.local.home>
        <20180808130302.GJ24813@linux.vnet.ibm.com>
        <20180808090724.41677176@gandalf.local.home>
        <20180808143310.GL24813@linux.vnet.ibm.com>
        <20180808104910.2ced5e51@gandalf.local.home>
        <20180808150558.GO24813@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Aug 2018 08:05:58 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> On Wed, Aug 08, 2018 at 10:49:10AM -0400, Steven Rostedt wrote:
> > On Wed, 8 Aug 2018 07:33:10 -0700
> > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> >   
> > > On Wed, Aug 08, 2018 at 09:07:24AM -0400, Steven Rostedt wrote:  
> > > > On Wed, 8 Aug 2018 06:03:02 -0700
> > > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > > >     
> > > > >  What's wrong with a this_cpu_inc()? It's atomic for the CPU. Although    
> > > > > > it wont be atomic for the capture of the idx. But I also don't see
> > > > > > interrupts being disabled, thus an NMI is no different than any
> > > > > > interrupt doing the same thing, right?      
> > > > > 
> > > > > On architectures without increment-memory instructions, if you take an NMI
> > > > > between the load from sp->sda->srcu_lock_count and the later store, you
> > > > > lose a count.  Note that both __srcu_read_lock() and __srcu_read_unlock()
> > > > > do increments of different locations, so you cannot rely on the usual
> > > > > "NMI fixes up before exit" semantics you get when incrementing and
> > > > > decrementing the same location.    
> > > > 
> > > > And how is this handled in the interrupt case? Interrupts are not
> > > > disabled here.    
> > > 
> > > Actually, on most architectures interrupts are in fact disabled:
> > > 
> > > #define this_cpu_generic_to_op(pcp, val, op)				\
> > > do {									\
> > > 	unsigned long __flags;						\
> > > 	raw_local_irq_save(__flags);					\
> > > 	raw_cpu_generic_to_op(pcp, val, op);				\
> > > 	raw_local_irq_restore(__flags);					\
> > > } while (0)
> > > 
> > > NMIs, not so much.  
> > 
> > And do these archs have NMIs?  
> 
> It would appear so:

Well the next question is, which of these archs that use it are in this
list.

> 
> $ find . -name 'Kconfig*' -exec grep -l 'select HAVE_NMI\>' {} \;
> ./arch/sparc/Kconfig
> ./arch/s390/Kconfig
> ./arch/arm/Kconfig
> ./arch/arm64/Kconfig
> ./arch/mips/Kconfig
> ./arch/sh/Kconfig
> ./arch/powerpc/Kconfig

Note, I know that powerpc "imitates" an NMI. It just sets the NMI as a
priority higher than other interrupts.

> ./arch/x86/Kconfig
> 

And we get this:

$ git grep this_cpu_add_4
arch/arm64/include/asm/percpu.h:#define this_cpu_add_4(pcp, val) _percpu_add(pcp, val)
arch/s390/include/asm/percpu.h:#define this_cpu_add_4(pcp, val) arch_this_cpu_to_op_simple(pcp, val, +)
arch/s390/include/asm/percpu.h:#define this_cpu_add_4(pcp, val) arch_this_cpu_add(pcp, val, "laa", "asi", int)
arch/x86/include/asm/percpu.h:#define this_cpu_add_4(pcp, val)  percpu_add_op((pcp), val)

Which leaves us with sparc, arm, mips, sh and powerpc.

sh is almost dead, and powerpc can be fixed, which I guess leaves us
with sparc, arm and mips.

-- Steve


> 							Thanx, Paul

