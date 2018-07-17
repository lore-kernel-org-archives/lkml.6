Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AC5ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F9920837
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j7NSb+qu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F9920837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbeGQTVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 15:21:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41086 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729720AbeGQTVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 15:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rfmMnILmdpRZ1jiR9Zz/vQitnTWj/Y7Zpd3dxJjEQMA=; b=j7NSb+quIH3A+2jahkD0kazHc
        ULieKV5Cri6VZAZGa+nN4nhrXTt9k4hvJGGbUmxNx13Pwb+qG/iZ7K/fndW68hFxYb0t6/Oxautxt
        B6mLRYlz9PeZRMszm0YWOBZRN1Xga6VzHlTxFnCdRwax+lRArERKiKCwe+Du41crOMYQzXEca+ozC
        U3V0E+R3HAQJYTsIrMEh96aMF0CoFMYCvUFQ7yW4iMx0JNwYG9KOThdrcN7uv/6tCYKh68fmuXaOo
        TXaZWrZRGJGjtsuUEPdh5XFKG6JitYGIpuujr8xrA87Jwbjl/mhsYUjlfHwrQsoQK3Kj2wy550F0H
        W+m4g/24g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffUzr-0000Fv-JB; Tue, 17 Jul 2018 18:46:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 166CA20275F36; Tue, 17 Jul 2018 20:46:50 +0200 (CEST)
Date:   Tue, 17 Jul 2018 20:46:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>, stable@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Change definition of cpu_relax() for Loongson-3
Message-ID: <20180717184650.GN2494@hirez.programming.kicks-ass.net>
References: <1531467477-9952-1-git-send-email-chenhc@lemote.com>
 <20180717175232.ea7pi2bqswnzmznc@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717175232.ea7pi2bqswnzmznc@pburton-laptop>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 10:52:32AM -0700, Paul Burton wrote:
> On Fri, Jul 13, 2018 at 03:37:57PM +0800, Huacai Chen wrote:
> > Linux expects that if a CPU modifies a memory location, then that
> > modification will eventually become visible to other CPUs in the system.
> > 
> > On Loongson-3 processor with SFB (Store Fill Buffer), loads may be
> > prioritised over stores so it is possible for a store operation to be
> > postponed if a polling loop immediately follows it. If the variable
> > being polled indirectly depends on the outstanding store [for example,
> > another CPU may be polling the variable that is pending modification]
> > then there is the potential for deadlock if interrupts are disabled.
> > This deadlock occurs in qspinlock code.
> > 
> > This patch changes the definition of cpu_relax() to smp_mb() for
> > Loongson-3, forcing a flushing of the SFB on SMP systems before the
> > next load takes place. If the Kernel is not compiled for SMP support,
> > this will expand to a barrier() as before.
> > 
> > References: 534be1d5a2da940 (ARM: 6194/1: change definition of cpu_relax() for ARM11MPCore)
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > ---
> >  arch/mips/include/asm/processor.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
> > index af34afb..a8c4a3a 100644
> > --- a/arch/mips/include/asm/processor.h
> > +++ b/arch/mips/include/asm/processor.h
> > @@ -386,7 +386,17 @@ unsigned long get_wchan(struct task_struct *p);
> >  #define KSTK_ESP(tsk) (task_pt_regs(tsk)->regs[29])
> >  #define KSTK_STATUS(tsk) (task_pt_regs(tsk)->cp0_status)
> >  
> > +#ifdef CONFIG_CPU_LOONGSON3
> > +/*
> > + * Loongson-3's SFB (Store-Fill-Buffer) may get starved when stuck in a read
> > + * loop. Since spin loops of any kind should have a cpu_relax() in them, force
> > + * a Store-Fill-Buffer flush from cpu_relax() such that any pending writes will
> > + * become available as expected.
> > + */
> 
> I think "may starve writes" or "may queue writes indefinitely" would be
> clearer than "may get starved".

Agreed.

> > +#define cpu_relax()	smp_mb()
> > +#else
> >  #define cpu_relax()	barrier()
> > +#endif
> >  
> >  /*
> >   * Return_address is a replacement for __builtin_return_address(count)
> 
> Apart from the comment above though this looks better to me.
> 
> Re-copying the LKMM maintainers - are you happy(ish) with this?

Right, thanks for adding us back on :-)

Yes, this is much better, although I myself would also prefer explicit
mention that this is a work-around for a hardware bug.

But aside from the actual comment bike-shedding, this looks entirely
acceptible (also because ARM is already doing this -- and the Changelog
might want to refer to that particular patch).
