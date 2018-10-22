Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205C0ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 01:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9FA820652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 01:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9FA820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeJVKJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 06:09:36 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:49436 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725922AbeJVKJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 06:09:36 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07452554|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03310;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.D5d.IXV_1540173178;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.D5d.IXV_1540173178)
          by smtp.aliyun-inc.com(10.147.44.118);
          Mon, 22 Oct 2018 09:52:59 +0800
Date:   Mon, 22 Oct 2018 09:52:58 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, hch@infradead.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, robh@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, c-sky_gcc_upstream@c-sky.com,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH V9 11/21] csky: Atomic operations
Message-ID: <20181022015258.GA3649@guoren-Inspiron-7460>
References: <cover.1539655731.git.ren_guo@c-sky.com>
 <efb6c9bb87f68c6f579ef497096086413effa5c2.1539655732.git.ren_guo@c-sky.com>
 <20181021205508.GJ4931@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181021205508.GJ4931@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx Peter, 

Your review has been a great help.

On Sun, Oct 21, 2018 at 10:55:08PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 16, 2018 at 10:58:30AM +0800, Guo Ren wrote:
> > +	smp_mb();
> > +	lock->tickets.owner++;
> 
> 	WRITE_ONCE(lock->tickets.owner, lock->tickets.owner + 1);
Yes, approve! I should use WRITE_ONCE/READ_ONCE as necessary.

> > +/*
> > + * Test-and-set spin-locking.
> > + */
> 
> I'm still not entirely sure why you want to have two spinlock
> implementations; to me that is just extra maintenance overhead.
Test and set (spinlock & rwlock) is easier for debug :P, and I don't
know the details of queue-rwlock (maybe I should learn it).

From education's view, we could teach students both of them in
arch/csky :)

Anyway, I just want to keep both of them.

Thx

> > +	asm volatile (
> > +		"	movi		%0, 0    \n"
> > +		"	stw		%0, (%1) \n"
> > +		: "=&r" (tmp)
> > +		: "r"(p)
> > +		: "cc");
> 
> 	WRITE_ONCE(lock->lock, 0);
> ?
Cool ... I like WRITE_ONCE style. 

> > +
> > +#define arch_spin_is_locked(x)	(READ_ONCE((x)->lock) != 0)
> > +
> > +/*
> > + * read lock/unlock/trylock
> > + */
> 
> Idem, why do you want a second rwlock_t implementation?
The same as above of spinlock.

> > +	asm volatile (
> > +		"1:	ldex.w		%0, (%1) \n"
> > +		"	movi		%0, 0    \n"
> > +		"	stex.w		%0, (%1) \n"
> > +		"	bez		%0, 1b   \n"
> > +		: "=&r" (tmp)
> > +		: "r"(p)
> > +		: "cc");
> 
> Isn't that:
> 
> 	WRITE_ONCE(lock->lock, 0);
Yes, no need ldex/stex and you've mentioned in spinlock before :P

> > diff --git a/arch/csky/kernel/atomic.S b/arch/csky/kernel/atomic.S
> > new file mode 100644
> > index 0000000..d2357c8
> > --- /dev/null
> > +++ b/arch/csky/kernel/atomic.S
> > @@ -0,0 +1,87 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> > +
> > +#include <linux/linkage.h>
> > +#include <abi/entry.h>
> > +
> > +.text
> > +
> > +/*
> > + * int csky_cmpxchg(int oldval, int newval, int *ptr)
> > + *
> > + * If *ptr != oldval && return 1,
> > + * else *ptr = newval return 0.
> > + */
> > +#ifdef CONFIG_CPU_HAS_LDSTEX
> > +ENTRY(csky_cmpxchg)
> > +	USPTOKSP
> > +	mfcr	a3, epc
> > +	INCTRAP	a3
> > +
> > +	subi    sp, 8
> > +	stw     a3, (sp, 0)
> > +	mfcr    a3, epsr
> > +	stw     a3, (sp, 4)
> > + 
> > +	psrset	ee
> > +1:
> > +	ldex	a3, (a2)
> > +	cmpne	a0, a3
> > +	bt16	2f
> > +	mov	a3, a1
> > +	stex	a3, (a2)
> > +	bez	a3, 1b
> > +2:
> > +	sync.is
> > +	mvc	a0
> > +	ldw	a3, (sp, 0)
> > +	mtcr	a3, epc
> > +	ldw     a3, (sp, 4)
> > +	mtcr	a3, epsr
> > +	addi	sp, 8
> > +	KSPTOUSP
> > +	rte
> > +END(csky_cmpxchg)
> 
> I don't understand why you have this; if the CPU has ll/sc, why do you
> need syscall support?
I've really considered your advice before, but from abi view 610/807/810
all have csky_cmpxchg trap and we want to make them the same. Some apps
use the trap directly and not use libc api. Maybe we could delete the
trap in future version of kernel.

> 
> In any case, nothing terminally broken; so I suppose that's good enough
> for starters. I just really don't understand some decisions (like having
> two lock implementations and having that cmpxchg syscall when you have
> hardware ll/sc).
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Thx peter and the two questions which I've clarified in above.

Best Regards
 Guo Ren
