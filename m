Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7033EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C58421566
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C58421566
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbeI0LYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 07:24:20 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:49181 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726590AbeI0LYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 07:24:20 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07437524|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07408;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=19;RT=19;SR=0;TI=SMTPD_---.CwOqUFU_1538024862;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CwOqUFU_1538024862)
          by smtp.aliyun-inc.com(10.147.40.44);
          Thu, 27 Sep 2018 13:07:42 +0800
Date:   Thu, 27 Sep 2018 13:07:42 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, robh@kernel.org, robh+dt@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, devicetree@vger.kernel.org,
        green.hu@gmail.com, palmer@sifive.com
Subject: Re: [PATCH V5 17/30] csky: Misc headers
Message-ID: <20180927050739.GA27703@guoren>
References: <cover.1537789736.git.ren_guo@c-sky.com>
 <5ae1990e1863fe2293bba1e5ec0408892a9a7f0c.1537789737.git.ren_guo@c-sky.com>
 <20180925100803.GA6891@andrea>
 <20180925104541.GA27311@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925104541.GA27311@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 12:45:41PM +0200, Peter Zijlstra wrote:
> On Tue, Sep 25, 2018 at 12:08:03PM +0200, Andrea Parri wrote:
> > Hi Guo,
> > 
> > > +/*
> > > + * set_bit - Atomically set a bit in memory
> > > + * @nr: the bit to set
> > > + * @addr: the address to start counting from
> > > + *
> > > + * This function is atomic and may not be reordered.  See __set_bit()
> > > + * if you do not require the atomic guarantees.
> > > + *
> > > + * Note: there are no guarantees that this function will not be reordered
> > > + * on non x86 architectures, so if you are writing portable code,
> > > + * make sure not to rely on its reordering guarantees.
> > > + *
> > > + * Note that @nr may be almost arbitrarily large; this function is not
> > > + * restricted to acting on a single-word quantity.
> > > + */
> > > +static inline void set_bit(int nr, volatile unsigned long *addr)
> > > +{
> > > +	unsigned long mask = BIT_MASK(nr);
> > > +	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> > > +	unsigned long tmp;
> > > +
> > > +	/* *p  |= mask; */
> > > +	smp_mb();
> > > +	asm volatile (
> > > +		"1:	ldex.w		%0, (%2)	\n"
> > > +		"	or32		%0, %0, %1	\n"
> > > +		"	stex.w		%0, (%2)	\n"
> > > +		"	bez		%0, 1b		\n"
> > > +		: "=&r"(tmp)
> > > +		: "r"(mask), "r"(p)
> > > +		: "memory");
> > > +	smp_mb();
> > > +}
> > > +
> > > +/**
> > > + * clear_bit - Clears a bit in memory
> > > + * @nr: Bit to clear
> > > + * @addr: Address to start counting from
> > > + *
> > > + * clear_bit() is atomic and may not be reordered.  However, it does
> > > + * not contain a memory barrier, so if it is used for locking purposes,
> > > + * you should call smp_mb__before_atomic() and/or smp_mb__after_atomic()
> > > + * in order to ensure changes are visible on other processors.
> > > + */
> > > +static inline void clear_bit(int nr, volatile unsigned long *addr)
> > > +{
> > > +	unsigned long mask = BIT_MASK(nr);
> > > +	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> > > +	unsigned long tmp;
> > > +
> > > +	/* *p &= ~mask; */
> > > +	mask = ~mask;
> > > +	smp_mb();
> > > +	asm volatile (
> > > +		"1:	ldex.w		%0, (%2)	\n"
> > > +		"	and32		%0, %0, %1	\n"
> > > +		"	stex.w		%0, (%2)	\n"
> > > +		"	bez		%0, 1b		\n"
> > > +		: "=&r"(tmp)
> > > +		: "r"(mask), "r"(p)
> > > +		: "memory");
> > > +	smp_mb();
> > > +}
> > > +
> > > +/**
> > > + * change_bit - Toggle a bit in memory
> > > + * @nr: Bit to change
> > > + * @addr: Address to start counting from
> > > + *
> > > + * change_bit() is atomic and may not be reordered. It may be
> > > + * reordered on other architectures than x86.
> > > + * Note that @nr may be almost arbitrarily large; this function is not
> > > + * restricted to acting on a single-word quantity.
> > > + */
> > > +static inline void change_bit(int nr, volatile unsigned long *addr)
> > > +{
> > > +	unsigned long mask = BIT_MASK(nr);
> > > +	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> > > +	unsigned long tmp;
> > > +
> > > +	/* *p ^= mask; */
> > > +	smp_mb();
> > > +	asm volatile (
> > > +		"1:	ldex.w		%0, (%2)	\n"
> > > +		"	xor32		%0, %0, %1	\n"
> > > +		"	stex.w		%0, (%2)	\n"
> > > +		"	bez		%0, 1b		\n"
> > > +		: "=&r"(tmp)
> > > +		: "r"(mask), "r"(p)
> > > +		: "memory");
> > > +	smp_mb();
> > > +}
> > 
> > The {set,clear,change}_bit() operations don't have to be ordered: you
> > might want to remove the above smp_mb()s (and adjust the comments).
I confused it with cmpxchg, seems cmpxchg need smp_mb() before&after.
See: https://lkml.org/lkml/2018/7/6/383

> Better yet, you can entirely delete all that and use
> asm-generic/bitops/atomic.h instead.
Yes, approve. Seems I only need care about asm/atomic.h, it's good for
me.

Best Regards
 Guo Ren
