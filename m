Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5903C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6EF2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fbamxt0R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B6EF2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeJDPNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:13:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48574 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbeJDPNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:13:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aDrLXP3OZtrkPERNReDYxfeiCaeSlvYhIdU9q/+oa5A=; b=Fbamxt0R9eOcw/JBiGurk1FHJ
        gwguw1O3IHGzq1a2DNWSlMyp0fLOyPymgJqLnfpDYCR0Aji221oKBEnIgVMjtG4G0pa7Ho5Y/8Xh9
        /eL8bVxZSFxb0aKTyQiJDIe31e5vBdq3Qe3+yE14yEzWMqLrBKHU0SyN/f8xq2AS6PMtu9pUZOulg
        PMsaAHb5F2K75KoJ5fyuk+E0eo9pPbQzzY5vhArfhcEoEzwx59/lrDl5vZVFK4t2T6XHaAie/kShI
        vBjV0esGxxP4nQN2fikSjwT4kOTEUgjZBgY5pfFYTyI4GYhS37iTveE9M0gn6irhnVsto4RNXl2X6
        sdYZqviLw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7ysh-0007Bo-1B; Thu, 04 Oct 2018 08:21:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A5FFA202C1A0F; Thu,  4 Oct 2018 10:11:00 +0200 (CEST)
Date:   Thu, 4 Oct 2018 10:11:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        devel@linuxdriverproject.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI
 support
Message-ID: <20181004081100.GI19272@hirez.programming.kicks-ass.net>
References: <20180914125006.349747096@linutronix.de>
 <CALCETrU+jP2hPLoJWTYJKTvr7-=YLwtk1=cZ_uizHYQZ1z4P-w@mail.gmail.com>
 <87sh1ne64t.fsf@vitty.brq.redhat.com>
 <20181003190617.GC21381@amt.cnet>
 <87k1mycfju.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1mycfju.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 09:54:45AM +0200, Vitaly Kuznetsov wrote:
> I was hoping to hear this from you :-) If I am to suggest how we can
> move forward I'd propose:
> - Check if pure TSC can be used on SkyLake+ systems (where TSC scaling
> is supported).
> - Check if non-masterclock mode is still needed. E.g. HyperV's TSC page
> clocksource is a single page for the whole VM, not a per-cpu thing. Can
> we think that all the buggy hardware is already gone?

No, and it is not the hardware you have to worry about (mostly), it is
the frigging PoS firmware people put on it.

Ever since Nehalem TSC is stable (unless you get to >4 socket systems,
after which it still can be, but bets are off). But even relatively
recent systems fail the TSC sync test because firmware messes it up by
writing to either MSR_TSC or MSR_TSC_ADJUST.

But the thing is, if the TSC is not synced, you cannot use it for
timekeeping, full stop. So having a single page is fine, it either
contains a mult/shift that is valid, or it indicates TSC is messed up
and you fall back to something else.

There is no inbetween there.

For sched_clock we can still use the global page, because the rate will
still be the same for each cpu, it's just offset between CPUs and the
code compensates for that.
