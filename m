Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775CFC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2188820839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fQx7CntO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2188820839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeHaLbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 07:31:10 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44000 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeHaLbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 07:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PV2Vqjf8NoBURjcZwFikIbC9a6IezCdTW5yUO030lxE=; b=fQx7CntOITHBTQQJsmEUp0r0p
        LiPUgbrzIttmu5G3YyPUyh/j9+Rb2lMS8T9iyld7MRucDUdatFA6Bt9nUt87eSrPzEtZK6TWY0LgO
        u1buFIJ/Nf2jVO8+9UgLIdmDNd4qeth1sKaR1Lb0exnOR5JEbng1Fa+FouEt44jz49+7KIchYppqw
        WbhzIyhb0JobwMIexskarZMHbQyNF9AT+C9gUOG5EfRx8jJEfNJOlHhSSyy/QZcJrkI1xkuKZymY/
        tG44lic2+xvD0p0vSR7D18JjCqb9lZhN/8/0H4QxPLEpm9eb776mASSTYbSAuxDJuSW+nmM/0Y8u9
        pEXBLzW9Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvdnZ-0005KE-1I; Fri, 31 Aug 2018 07:24:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5B8052024D444; Fri, 31 Aug 2018 09:24:44 +0200 (CEST)
Date:   Fri, 31 Aug 2018 09:24:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: __clear_bit_lock to use atomic clear_bit (was Re: Patch
 "asm-generic/bitops/lock.h)
Message-ID: <20180831072444.GD24124@hirez.programming.kicks-ass.net>
References: <1535567633.4465.23.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
 <20180830094411.GX24124@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075012B090FE0@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075012B090FE0@us01wembx1.internal.synopsys.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 12:29:27AM +0000, Vineet Gupta wrote:
> On 08/30/2018 02:44 AM, Peter Zijlstra wrote:
> >> Back in 2016, Peter had fixed this file due to a problem I reported on ARC. See
> >> commit f75d48644c56a ("bitops: Do not default to __clear_bit() for
> >> __clear_bit_unlock()")
> >> That made __clear_bit_unlock() use the atomic clear_bit() vs. non-atomic
> >> __clear_bit(), effectively making clear_bit_unlock() and __clear_bit_unlock() same.
> >>
> >> This patch undoes that which could explain the issues you see. @Peter, @Will ?
> > Right, so the thinking is that on platforms that suffer that issue,
> > atomic_set*() should DTRT. And if you look at your spinlock based atomic
> > implementation, you'll note that atomic_set() does indeed do the right
> > thing.
> >
> > arch/arc/include/asm/atomic.h:108
> 
> For !LLSC atomics, ARC has always had atomic_set() DTRT even in the git revision
> of 2016. The problem was not in atomics, but the asymmetric way slub bit lock etc
> worked (haven't checked if this changed), i.e.
> 
>      slab_lock() -> bit_spin_lock() -> test_and_set_bit()    # atomic
>      slab_unlock() -> __bit_spin_unlock() -> __clear_bit()    # non-atomic
> 
> And with v4.19-rc1, we have essentially reverted f75d48644c56a due to 84c6591103db
> ("locking/atomics, asm-generic/bitops/lock.h: Rewrite using atomic_fetch_*()")
> 
> So what we have with 4.19-rc1 is
> 
>    static inline void __clear_bit_unlock(unsigned int nr, volatile unsigned long *p)
>    {
>      unsigned long old;
>      p += ((nr) / 32);
>      old = // some typecheck magic on *p
>      old &= ~(1UL << ((nr) % 32));
>      atomic_long_set_release((atomic_long_t *)p, old);
>    }
> 
> So @p is being r-m-w non atomically. The lock variant uses atomic op...
> 
>    int test_and_set_bit_lock(unsigned int nr, volatile unsigned long *p)
>    { 
>       ...
>       old = atomic_long_fetch_or_acquire(mask, (atomic_long_t *)p);
>       ....
>    }
> 
> Now I don't know why we don't see the issue with LLSC atomics, perhaps race window
> reduces due to less verbose code itself etc..
> 
> Am I missing something still ?

Yes :-) So there are 2 things to consider:

 1) this whole test_and_set_bit() + __clear_bit() combo only works if we
    have the guarantee that no other bit will change while we have our
    'lock' bit set.

    This means that @old is invariant.

 2) atomic ops and stores work as 'expected' -- which is true for all
    hardware LL/SC or CAS implementations, but not for spinlock based
    atomics.

The bug in f75d48644c56a was the atomic test_and_set loosing the
__clear_bit() store.

With LL/SC this cannot happen, because the competing store (__clear_bit)
will cause the SC to fail, then we'll retry, the second LL observes the
new value.

So the main point is that test_and_set must not loose a store.
atomic_fetch_or() vs atomic_set() ensures this.


NOTE: another possible solution for spinlock based bitops is making
test_and_set 'smarter':

	spin_lock();
	val = READ_ONCE(word);
	if (!(val & bit)) {
		val |= bit;
		WRITE_ONCE(word, val);
	}
	spin_unlock();

But that is not something that works in generic (the other atomic ops),
and therefore atomic_set() is required to take the spinlock too, which
also cures the problem.
