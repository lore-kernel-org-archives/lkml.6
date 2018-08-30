Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980E7C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51806205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CRAIUUrW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51806205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeHaAtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 20:49:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33554 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbeHaAtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 20:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Cjky/mM1tjSK/MV1yu9uHtt6HigDi4I+7M1zq65dyMg=; b=CRAIUUrWqXf+NZL/BkReCCWUQ
        jkClMthPDm9mrWlk/LUh/aYKf0xhGtiQlL940iS9VDtI7aymZffu/QolYEfild8n9mGxIjuxh9cZe
        Vu2GFwYSGZDPXjDmrw3/Y/WV+6K0Bws9zHPlMU5DwBj81rlsAM66/28Udhp83aFuaJTZBAleF+ZEI
        n+EXKi+fiOVxXkZH/MsVzC+mgQa+OLjFmzKfDuIPwIgqfUOkR+CO/m/6Ojgj0dmKyDSVvfok06iOR
        qC9KRz+sGrQn0uEmkvUjZf9hJcOtX2QPRQ/d7OqUMUOc2vXrQVuI2AC+GWtrEz3Xh4YjCin8uOz/3
        pbzpmN6Lw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvTob-0007Ym-Bn; Thu, 30 Aug 2018 20:45:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AF59820255987; Thu, 30 Aug 2018 22:45:15 +0200 (CEST)
Date:   Thu, 30 Aug 2018 22:45:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
Message-ID: <20180830204515.GC24124@hirez.programming.kicks-ass.net>
References: <1535567633.4465.23.camel@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
 <20180830094411.GX24124@hirez.programming.kicks-ass.net>
 <20180830095148.GB5942@arm.com>
 <1535629996.4465.44.camel@synopsys.com>
 <20180830141713.GN24082@hirez.programming.kicks-ass.net>
 <20180830142354.GB13005@arm.com>
 <20180830142920.GO24082@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075012B090EA4@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075012B090EA4@us01wembx1.internal.synopsys.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 08:31:59PM +0000, Vineet Gupta wrote:
> On 08/30/2018 07:29 AM, Peter Zijlstra wrote:
> > On Thu, Aug 30, 2018 at 03:23:55PM +0100, Will Deacon wrote:
> >
> >> Yes, that would be worth trying. However, I also just noticed that the
> >> fetch-ops (which are now used to implement test_and_set_bit_lock()) seem
> >> to be missing the backwards branch in the LL/SC case. Yet another diff
> >> below.
> >>
> >> Will
> >>
> >> --->8
> >>
> >> diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
> >> index 4e0072730241..f06c5ed672b3 100644
> >> --- a/arch/arc/include/asm/atomic.h
> >> +++ b/arch/arc/include/asm/atomic.h
> >> @@ -84,7 +84,7 @@ static inline int atomic_fetch_##op(int i, atomic_t *v)			\
> >>  	"1:	llock   %[orig], [%[ctr]]		\n"		\
> >>  	"	" #asm_op " %[val], %[orig], %[i]	\n"		\
> >>  	"	scond   %[val], [%[ctr]]		\n"		\
> >> -	"						\n"		\
> >> +	"	bnz	1b				\n"		\
> >>  	: [val]	"=&r"	(val),						\
> >>  	  [orig] "=&r" (orig)						\
> >>  	: [ctr]	"r"	(&v->counter),					\
> > ACK!! sorry about that, no idea how I messed that up.
> >
> > Also, once it all works, they should look at switching to _relaxed
> > atomics for LL/SC.
> 
> Indeed this is the mother of all issues, I tried and system is clearly hosed with
> and works after.
> What's amazing is the commit 4aef66c8ae9 which introduced it is from 2016 ;-)
> Back then we had a retry branch with backoff stuff which I'd reverted for new
> cores and the merge conflict somehow missed it.
> 
> @PeterZ I'll create a patch with you as author ? do I need any formal sign offs,
> acks etc ?

Well, Will spotted it, give authorship to him, you have my ack per the
above.

> So after this there are 2 other things to be addresses / looked at still while we
> are still here.
> 
> 1. After 84c6591103db __clear_bit_lock() implementation will be broken (or atleast
> not consistent with what we had after), do we need to reinstate it.
> 2. Will's proposed change to remove the underlying issue, but the issue in #1
> remains ?

No, like explained, for spinlock based atomics the issue _should_ not
exist, and if you look at your atomic_set() implementation for that
variant, you'll see it does the right thing by taking the lock.

Basically atomic_set() for spinlock based atomics ends up being
(void)atomic_xchg().

FWIW, also ACK on Will's patch to switch you over to asm-generic bitops
entirely.
