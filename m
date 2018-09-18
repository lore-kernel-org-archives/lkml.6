Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C9CECE560
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396072146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CwB/O0Rk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 396072146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbeIRSUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 14:20:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54022 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbeIRSUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 14:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=meVvnGJ/ZpoQL/RyVdnVPz0EGiXzy8+NhM7Xubw+vZc=; b=CwB/O0Rk0/mhMsG4Ss9xSykid
        rezVVrmZsi+d2nDNVjTjsGoX+Pik//UmWKbQuGXEbaGIg7hAc+3bqaVm7ckW7fE5dZJqGYV2gH5hx
        BeQnxjgZJgMcVFlinA5yYWv379Sbq/oKczdwwUuparM0grPp0fwGECh8wzseRg0Ps00sjXr/zhoaZ
        BeqsVUHvELFaDua75mcP+L54CAEAIDWzBTI+P9A+sfyrrkubrLFLj4Q19sac/Yq9dsuuREkRl/XhU
        7jzN5a8EpeTkuFApCD+7aEmrwjReh55nF5LMjQ6wsyeHW60k2F3e2BdFmW/sJW/SNlNdbvgmnq0wz
        41owmMCtA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2FQ9-0004Zu-Vg; Tue, 18 Sep 2018 12:48:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3B42C202C1A35; Tue, 18 Sep 2018 14:48:00 +0200 (CEST)
Date:   Tue, 18 Sep 2018 14:48:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <john.stultz@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        devel@linuxdriverproject.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
Subject: Re: [patch 09/11] x86/vdso: Simplify the invalid vclock case
Message-ID: <20180918124800.GL24106@hirez.programming.kicks-ass.net>
References: <20180914125006.349747096@linutronix.de>
 <20180914125118.909646643@linutronix.de>
 <CALCETrXh70oFHfT0Z-JXcnAumhAgLqSea5UiPY3WXu=v2GcKTg@mail.gmail.com>
 <CALAqxLUv9Rd_eA7u9gZNFvTNrT1Z67RpHLozdeNC0W2yZm=Heg@mail.gmail.com>
 <alpine.DEB.2.21.1809180948570.3558@nanos.tec.linutronix.de>
 <20180918083055.GJ24106@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1809181050020.4167@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1809181204460.4167@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1809181237140.4167@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809181237140.4167@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 12:41:57PM +0200, Thomas Gleixner wrote:
> On Tue, 18 Sep 2018, Thomas Gleixner wrote:
> > On Tue, 18 Sep 2018, Thomas Gleixner wrote:
> > > On Tue, 18 Sep 2018, Peter Zijlstra wrote:
> > > > > Your memory serves you right. That's indeed observable on CPUs which
> > > > > lack TSC_ADJUST.
> > > > 
> > > > But, if the gtod code can observe this, then why doesn't the code that
> > > > checks the sync?
> > > 
> > > Because it depends where the involved CPUs are in the topology. The sync
> > > code might just run on the same package an simply not see it. Yes, w/o
> > > TSC_ADJUST the TSC sync code can just fail to see the havoc.
> > 
> > Even with TSC adjust the TSC can be slightly off by design on multi-socket
> > systems.
> 
> Here are the gory details:
> 
>    https://lore.kernel.org/lkml/3c1737210708230408i7a8049a9m5db49e6c4d89ab62@mail.gmail.com/
> 
> The changelog has an explanation as well.
> 
>     d8bb6f4c1670 ("x86: tsc prevent time going backwards")
> 
> I still have one of the machines which is affected by this.

Are we sure this isn't a load vs rdtsc reorder? Because if I look at the
current code:

notrace static u64 vread_tsc(void)
{
	u64 ret = (u64)rdtsc_ordered();
	u64 last = gtod->cycle_last;

	if (likely(ret >= last))
		return ret;

	/*
	 * GCC likes to generate cmov here, but this branch is extremely
	 * predictable (it's just a function of time and the likely is
	 * very likely) and there's a data dependence, so force GCC
	 * to generate a branch instead.  I don't barrier() because
	 * we don't actually need a barrier, and if this function
	 * ever gets inlined it will generate worse code.
	 */
	asm volatile ("");
	return last;
}

That does:

	lfence
	rdtsc
	load gtod->cycle_last

Which obviously allows us to observe a cycles_last that is later than
the rdtsc itself, and thus time can trivially go backwards.

The new code:

		last = gtod->cycle_last;
		cycles = vgetcyc(gtod->vclock_mode);
		if (unlikely((s64)cycles < 0))
			return vdso_fallback_gettime(clk, ts);
		if (cycles > last)
			ns += (cycles - last) * gtod->mult;

looks like:

	load gtod->cycle_last
	lfence
	rdtsc

which avoids that possibility, the cycle_last load must have completed
before the rdtsc.


