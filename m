Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D642C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC04A21719
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dx44y9b4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC04A21719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbeHHKK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:10:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39902 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeHHKK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/q2/4T+CGaQK9BqUsgCCY2Twi01mcXQ6Qjq7DyFqy9M=; b=dx44y9b45Hz73ZJjRfMSfwrqH
        VExQfvj/SmRkx3ybp41RA163Lu9uOhw1vWiUhuQ/0cHryRMAYDgzeJpf06vRhuSeEaUTOFxq7aoti
        2d9nD5DWBqK9DfUxo1Un7JSw2s37TA/SRJtSXIeZDEvmKUrRLkWfs5ARYWGMpLTBlQzfBUBFbnFIS
        udZppYurv990ChLw8vZCfByWqmA2joIcq1Do6dfS9VSi9EmP9hLxSRpFnMcffl13JFlRABKNmdiXa
        i2lH1FGMCADuPXzVb1So7LrM6fd2KkRje4ijijOF6N62yGaICD1WsDS/FhWLSIqBWwE+4EnXac5mt
        YP7HjelVw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fnJG8-0000ZV-Fu; Wed, 08 Aug 2018 07:51:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ED9F320163EBC; Wed,  8 Aug 2018 09:51:54 +0200 (CEST)
Date:   Wed, 8 Aug 2018 09:51:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
        jithu.joseph@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] x86/intel_rdt and perf/x86: Fix lack of coordination
 with perf
Message-ID: <20180808075154.GN2494@hirez.programming.kicks-ass.net>
References: <086b93f5-da5b-b5e5-148a-cef25117b963@intel.com>
 <20180803104956.GU2494@hirez.programming.kicks-ass.net>
 <1eece033-fbae-c904-13ad-1904be91c049@intel.com>
 <20180803152523.GY2476@hirez.programming.kicks-ass.net>
 <d6df8a8a-f0f2-48f7-1c1d-c8893e1583c9@intel.com>
 <57c011e1-113d-c38f-c318-defbad085843@intel.com>
 <20180806221225.GO2458@hirez.programming.kicks-ass.net>
 <08d51131-7802-5bfe-2cae-d116807183d1@intel.com>
 <20180807093615.GY2494@hirez.programming.kicks-ass.net>
 <ace0bebb-91ab-5d40-e7d7-d72d48302fa8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ace0bebb-91ab-5d40-e7d7-d72d48302fa8@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 03:47:15PM -0700, Reinette Chatre wrote:
> > FWIW, how long is that IRQ disabled section? It looks like something
> > that could be taking a bit of time. We have these people that care about
> > IRQ latency.
> 
> We work closely with customers needing low latency as well as customers
> needing deterministic behavior.
> 
> This measurement is triggered by the user as a validation mechanism of
> the pseudo-locked memory region after it has been created as part of
> system setup as well as during runtime if there are any concerns with
> the performance of an application that uses it.
> 
> This measurement would thus be triggered before the sensitive workloads
> start - during system setup, or if an issue is already present. In
> either case the measurement is triggered by the administrator via debugfs.

That does not in fact include the answer to the question. Also, it
assumes a competent operator (something I've found is not always true).

> >  - I don't much fancy people accessing the guts of events like that;
> >    would not an inline function like:
> > 
> >    static inline u64 x86_perf_rdpmc(struct perf_event *event)
> >    {
> > 	u64 val;
> > 
> > 	lockdep_assert_irqs_disabled();
> > 
> > 	rdpmcl(event->hw.event_base_rdpmc, val);
> > 	return val;
> >    }
> > 
> >    Work for you?
> 
> No. This does not provide accurate results. Implementing the above produces:
> pseudo_lock_mea-366   [002] ....    34.950740: pseudo_lock_l2: hits=4096
> miss=4

But it being an inline function should allow the compiler to optimize
and lift the event->hw.event_base_rdpmc load like you now do manually.
Also, like Tony already suggested, you can prime that load just fine by
doing an extra invocation.

(and note that the above function is _much_ simpler than
perf_event_read_local())

> >  - native_read_pmc(); are you 100% sure this code only ever runs on
> >    native and not in some dodgy virt environment?
> 
> My understanding is that a virtual environment would be a customer of a
> RDT allocation (cache or memory bandwidth). I do not see if/where this
> is restricted though - I'll move to rdpmcl() but the usage of a cache
> allocation feature like this from a virtual machine needs more
> investigation.

I can imagine that hypervisors that allow physical partitioning could
allow delegating the rdt crud to their guests when they 'own' a full
socket or whatever the domain is for this.

> Will do. I created the following helper function that can be used after
> interrupts are disabled:
> 
> static inline int perf_event_error_state(struct perf_event *event)
> {
>         int ret = 0;
>         u64 tmp;
> 
>         ret = perf_event_read_local(event, &tmp, NULL, NULL);
>         if (ret < 0)
>                 return ret;
> 
>         if (event->attr.pinned && event->oncpu != smp_processor_id())
>                 return -EBUSY;
> 
>         return ret;
> }

Nah, stick the test in perf_event_read_local(), that actually needs it.

> > Also, while you disable IRQs, your fancy pants loop is still subject to
> > NMIs that can/will perturb your measurements, how do you deal with
> > those?

> Customers interested in this feature are familiar with dealing with them
> (and also SMIs). The user space counterpart is able to detect such an
> occurrence.

You're very optimistic about your customers capabilities. And this might
be true for the current people you're talking to, but once this is
available and public, joe monkey will have access and he _will_ screw it
up.

> Please note that if an NMI arrives it would be handled with the
> currently active cache capacity bitmask so none of the pseudo-locked
> memory will be evicted since no capacity bitmask overlaps with the
> pseudo-locked region.

So exceptions change / have their own bitmask?
