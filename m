Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B1AC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03D920685
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y4X3rum5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03D920685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733174AbeHGABP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 20:01:15 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40078 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729926AbeHGABP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 20:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ibZNl/FQwc0zqMbTozhOc3zzeXK3t8sC/vFRakqU7Q4=; b=y4X3rum5yGSOqsdRZY6fIF92e
        ZmEoa2FCFcHcDNqE8CGiS2EpCdLA2qPnZilkeldZ6Z/hGLhhCJp3tXUfjzktdsrQlHlZXl1OxVZHL
        EoOCAIUjsdwO7yEfXkrUMXXwBAGPzrcaCAoKRNrFX4FO7BbVd0jwyWXCBmrNmxbrAC09o6ARrA8wL
        jzXIaQDMcnlrIz7RicEPBH9wB40lRM/ZBYBy01HGaer4fyEDNJ0vWR76nuNEzIr6ka0xWOwaNObdY
        p/W46vPZQVujaAp/4xrzQlGgKQEoRP4L1pDaxvURvgCqKpuu1cVetpSM0aiesJzMqZEcHYVAMZUT5
        L+wMv9jDg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmnOB-0004HA-BL; Mon, 06 Aug 2018 21:50:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0ADE8205881DA; Mon,  6 Aug 2018 23:50:06 +0200 (CEST)
Date:   Mon, 6 Aug 2018 23:50:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kan.liang@linux.intel.com, tglx@linutronix.de, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH 2/3] x86, perf: Add a separate Arch Perfmon v4 PMI handler
Message-ID: <20180806215005.GU2494@hirez.programming.kicks-ass.net>
References: <1533576223-11588-1-git-send-email-kan.liang@linux.intel.com>
 <1533576223-11588-2-git-send-email-kan.liang@linux.intel.com>
 <20180806183515.GR2494@hirez.programming.kicks-ass.net>
 <20180806213323.GK4238@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806213323.GK4238@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 02:33:23PM -0700, Andi Kleen wrote:
> On Mon, Aug 06, 2018 at 08:35:15PM +0200, Peter Zijlstra wrote:
> > > +static bool disable_counter_freezing;
> > > +module_param(disable_counter_freezing, bool, 0444);
> > > +MODULE_PARM_DESC(disable_counter_freezing, "Disable counter freezing feature."
> > > +		"The PMI handler will fall back to generic handler."
> > > +		"Default is false (enable counter freezing feature).");
> > 
> > Why?
> 
> See the description. Counter freezing took some time to stabilize,
> so it seemed better to have a knob to ask users to try in case
> there are more problems.

But it is not a module.. did you want early_param() or __setup()?

> > > +	/*
> > > +	 * Ack the PMU late after the APIC.  This avoids bogus
> > 
> > > +	 * freezing on Skylake CPUs.  The acking unfreezes the PMU
> > > +	 */
> > That doesn't make sense. PMU and APIC do not have order.> 
> 
> It makes a difference for the hardware.

I still have no clue what it wants to say.

> > > +	/*
> > > +	 * For arch perfmon 4 use counter freezing to avoid
> > > +	 * several MSR accesses in the PMI.
> > > +	 */
> > > +	if (x86_pmu.counter_freezing) {
> > > +		x86_pmu.handle_irq = intel_pmu_handle_irq_v4;
> > > +		pr_cont("counter freezing, ");
> > > +	}
> > 
> > Lets not print the counter freezing, we already print v4, right?
> 
> I find it useful to see that the kernel has the support, otherwise
> you would need to look at the version number, but it gets difficult
> with backports. This is another paranoia bit, in case there
> are problems.

That line will get ver long if we keep adding every dinky bit to it.

> > > @@ -561,6 +566,7 @@ struct x86_pmu {
> > >  	struct x86_pmu_quirk *quirks;
> > >  	int		perfctr_second_write;
> > >  	bool		late_ack;
> > > +	bool		counter_freezing;
> > 
> > Please make the both of them int or something.
> 
> That would make them bigger for no reason?

Then use u8 or something, I just don't much like _Bool in composite
types.
