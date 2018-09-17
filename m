Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEED8ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093A72147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WUUgCXdb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 093A72147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbeIQNoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:44:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39556 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbeIQNoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TIB7yQjYE+QqzbG9qBOn5wslTKOBRUoBSfFZzVS80jg=; b=WUUgCXdbSoAHxqGq+qz2/beaW
        H3+0mSWPrVGBn86QF/VPWQXuaULNeqb4K79BmlM/EZqG/G8jf8oeD68tCj2V5PorF5FPtXFNeXsmR
        Wtjg7zOUoIMKJFMB3CbojwKvudsnJ1FuuX9WFZ9qYYgqID+Wcx8YOLWSmffko+BKJY5tnBLdFYsmr
        42KyUj6wZM01DX7vUllVtbLCcFW0kvl2mqT8kF4b71B4dPmpwhzcAKOPVkipOMOrGMJbjkqBv3mxO
        w7bIhIokG5ECSckKWmVJDADKtpqCrG98g2uwDlFyBb9ENCQ92M1zI74EE+aI+IqdSh6ayhXK5r2FF
        Yx/mv2RHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g1ojG-0001n4-A5; Mon, 17 Sep 2018 08:17:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A254E2058A23B; Mon, 17 Sep 2018 10:17:55 +0200 (CEST)
Date:   Mon, 17 Sep 2018 10:17:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, devicetree@vger.kernel.org,
        andrea.parri@amarulasolutions.com, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, green.hu@gmail.com
Subject: Re: [PATCH V3 11/27] csky: Atomic operations
Message-ID: <20180917081755.GO24124@hirez.programming.kicks-ass.net>
References: <cover.1536757532.git.ren_guo@c-sky.com>
 <93e8b592e429c156ad4d4ca5d85ef48fd0ab8b70.1536757532.git.ren_guo@c-sky.com>
 <20180912155514.GV24082@hirez.programming.kicks-ass.net>
 <20180915145512.GA18355@guoren-Inspiron-7460>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180915145512.GA18355@guoren-Inspiron-7460>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 15, 2018 at 10:55:13PM +0800, Guo Ren wrote:
> > > +#define ATOMIC_OP_RETURN(op, c_op)					\

> > > +#define ATOMIC_FETCH_OP(op, c_op)					\

> > For these you could generate _relaxed variants and not provide smp_mb()
> > inside them.
> Ok, but I'll modify it in next commit.

That's fine. Just wanted to let you know about _relaxed() since it will
benefit your platform.

> > > +#define ATOMIC_OP(op, c_op)						\
> > > +static inline void atomic_##op(int i, atomic_t *v)			\
> > > +{									\
> > > +	unsigned long tmp, flags;					\
> > > +									\
> > > +	raw_local_irq_save(flags);					\
> > > +									\
> > > +	asm volatile (							\
> > > +	"	ldw		%0, (%2) \n"				\
> > > +	"	" #op "		%0, %1   \n"				\
> > > +	"	stw		%0, (%2) \n"				\
> > > +		: "=&r" (tmp)						\
> > > +		: "r" (i), "r"(&v->counter)				\
> > > +		: "memory");						\
> > > +									\
> > > +	raw_local_irq_restore(flags);					\
> > > +}
> > 
> > Is this really 'better' than the generic UP fallback implementation?
> There is a lock irq instruction "idly4" with out irq_save. eg:
> 	asm volatile (							\
> 	"	idly4			 \n"				\
> 	"	ldw		%0, (%2) \n"				\
> 	"	" #op "		%0, %1   \n"				\
> 	"	stw		%0, (%2) \n"				\
> I'll change to that after full tested.

That is pretty nifty, could you explain (or reference me to a arch doc
that does) the exact semantics of that "idly4" instruction?

> > > +static inline void arch_spin_lock(arch_spinlock_t *lock)
> > > +{
> > > +	arch_spinlock_t lockval;
> > > +	u32 ticket_next = 1 << TICKET_NEXT;
> > > +	u32 *p = &lock->lock;
> > > +	u32 tmp;
> > > +
> > > +	smp_mb();
> > 
> > spin_lock() doesn't need smp_mb() before.
> read_lock and write_lock also needn't smp_mb() before, isn't it?

Correct. The various *_lock() functions only need imply an ACQUIRE
barrier, such that the critical section happens after the lock is taken.

> > > +
> > > +static inline void arch_spin_unlock(arch_spinlock_t *lock)
> > > +{
> > > +	smp_mb();
> > > +	lock->tickets.owner++;
> > > +	smp_mb();
> > 
> > spin_unlock() doesn't need smp_mb() after.
> read_unlock and write_unlock also needn't smp_mb() after, isn't it?

Indeed so, the various *_unlock() functions only need imply a RELEASE
barrier, such that the critical section happend before the lock is
released.

In both cases (lock and unlock) there is a great amount of subtle
details, but most of that is irrelevant if all you have is smp_mb().


> > > +/*
> > > + * Test-and-set spin-locking.
> > > + */
> > 
> > Why retain that?
> > 
> > same comments; it has far too many smp_mb()s in.
> I'm not sure about queued_rwlocks and just for 2-cores-smp test-and-set is
> faster and simpler, isn't it?

Even on 2 cores I think you can create starvation cases with
test-and-set spinlocks. And the maintenace overhead of carrying two lock
implementations is non trivial.

As to performance; I cannot say, but the ticket lock isn't very
expensive, you could benchmark of course.
