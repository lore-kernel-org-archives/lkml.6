Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B724C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC90217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbfBZS0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:26:31 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51928 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728937AbfBZS0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:26:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D1B8EBD;
        Tue, 26 Feb 2019 10:26:30 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05FDF3F738;
        Tue, 26 Feb 2019 10:26:26 -0800 (PST)
Date:   Tue, 26 Feb 2019 18:26:24 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Subject: Re: [RFC PATCH 01/20] asm-generic/mmiowb: Add generic implementation
 of mmiowb() tracking
Message-ID: <20190226182624.GC28709@fuggles.cambridge.arm.com>
References: <20190222185026.10973-1-will.deacon@arm.com>
 <20190222185026.10973-2-will.deacon@arm.com>
 <CAHk-=wgamK0=rNsCfDfDzmNXUF_MqUHb0okzqN1Tir9vm65pNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgamK0=rNsCfDfDzmNXUF_MqUHb0okzqN1Tir9vm65pNg@mail.gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Thanks for having a look.

On Fri, Feb 22, 2019 at 01:49:32PM -0800, Linus Torvalds wrote:
> On Fri, Feb 22, 2019 at 10:50 AM Will Deacon <will.deacon@arm.com> wrote:
> >
> > +#ifndef mmiowb_set_pending
> > +static inline void mmiowb_set_pending(void)
> > +{
> > +       __this_cpu_write(__mmiowb_state.mmiowb_pending, 1);
> > +}
> > +#endif
> > +
> > +#ifndef mmiowb_spin_lock
> > +static inline void mmiowb_spin_lock(void)
> > +{
> > +       if (__this_cpu_inc_return(__mmiowb_state.nesting_count) == 1)
> > +               __this_cpu_write(__mmiowb_state.mmiowb_pending, 0);
> > +}
> > +#endif
> 
> The case we want to go fast is the spin-lock and unlock case, not the
> "set pending" case.
> 
> And the way you implemented this, it's exactly the wrong way around.
> 
> So I'd suggest instead doing
> 
>   static inline void mmiowb_set_pending(void)
>   {
>       __this_cpu_write(__mmiowb_state.mmiowb_pending,
> __mmiowb_state.nesting_count);
>   }
> 
> and
> 
>   static inline void mmiowb_spin_lock(void)
>   {
>       __this_cpu_inc(__mmiowb_state.nesting_count);
>   }
> 
> which makes that spin-lock code much simpler and avoids the conditional there.

Makes sense; I'll hook that up for the next version.

> Then the unlock case could be something like
> 
>   static inline void mmiowb_spin_unlock(void)
>   {
>       if (unlikely(__this_cpu_read(__mmiowb_state.mmiowb_pending))) {
>           __this_cpu_write(__mmiowb_state.mmiowb_pending, 0);
>           mmiowb();
>       }
>       __this_cpu_dec(__mmiowb_state.nesting_count);
>   }
> 
> or something (xchg is generally much more expensive than read, and the
> common case for spinlocks is that nobody did IO inside of it).

So I *am* using __this_cpu_xchg() here, which means the architecture can
get away with plain old loads and stores (which is what RISC-V does, for
example), but I see that's not the case on e.g. x86 so I'll rework using
read() and write() because it doesn't hurt.

Will
