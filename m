Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A67C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EBD62157F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nEsgx5dn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EBD62157F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732611AbeHGLtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 07:49:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47852 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727155AbeHGLtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 07:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HY7QpqVW4AViaztgmgor4HAX7kurzeDA+dNoapherbs=; b=nEsgx5dn3HuwCDqntcEaB2aPV
        FutWoBmj1WKtAotvLzVzNja2qdiTbVEYzozN4Uy4mtARtjwxUiq971IK+DDJhf6qHU9nOUtONYOBJ
        8/93mF24KugIpQbIGR0F4jrKocfGGErCJ2rmdMM3UWsB3lO3JCQcqkkcJc5sh50ac4rE2qyuUPVJl
        erZRoeAwV/gSksSYMHsYG8Ynzp/nLRyzt5RjnPXN+dViPUw9Jkd+RxIMxclthWj4UjkLC5q6G7/+G
        ps7RN1NcjSrD6IPjgf6UtoJ5UwNqDJrS9sJ85eCnNxCuiZjSK99rEXJUXTyFFHYYrLUX01Ij4qUQB
        aVvY+S13g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmyPa-0001nA-JS; Tue, 07 Aug 2018 09:36:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C4D1020588137; Tue,  7 Aug 2018 11:36:15 +0200 (CEST)
Date:   Tue, 7 Aug 2018 11:36:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
        jithu.joseph@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] x86/intel_rdt and perf/x86: Fix lack of coordination
 with perf
Message-ID: <20180807093615.GY2494@hirez.programming.kicks-ass.net>
References: <d64f85e8-98ca-a81d-bf2d-13dd72fc411e@intel.com>
 <20180802201312.GS2494@hirez.programming.kicks-ass.net>
 <086b93f5-da5b-b5e5-148a-cef25117b963@intel.com>
 <20180803104956.GU2494@hirez.programming.kicks-ass.net>
 <1eece033-fbae-c904-13ad-1904be91c049@intel.com>
 <20180803152523.GY2476@hirez.programming.kicks-ass.net>
 <d6df8a8a-f0f2-48f7-1c1d-c8893e1583c9@intel.com>
 <57c011e1-113d-c38f-c318-defbad085843@intel.com>
 <20180806221225.GO2458@hirez.programming.kicks-ass.net>
 <08d51131-7802-5bfe-2cae-d116807183d1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08d51131-7802-5bfe-2cae-d116807183d1@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 04:07:09PM -0700, Reinette Chatre wrote:

> I've modified your suggestion slightly in an attempt to gain accuracy.
> Now it looks like:
> 
> local_irq_disable();
> /* disable hw prefetchers */
> /* init local vars to loop through pseudo-locked mem */
> perf_event_read_local(l2_hit_event, &l2_hits_before, NULL, NULL);
> perf_event_read_local(l2_miss_event, &l2_miss_before, NULL, NULL);
> /* loop through pseudo-locked mem */
> perf_event_read_local(l2_hit_event, &l2_hits_after, NULL, NULL);
> perf_event_read_local(l2_miss_event, &l2_miss_after, NULL, NULL);
> /* enable hw prefetchers */
> local_irq_enable();
> 
> With the above I do not see the impact of an interference workload
> anymore but the results are not yet accurate:
> 
> pseudo_lock_mea-538   [002] ....   113.296084: pseudo_lock_l2: hits=4103
> miss=2

an error of ~0.2% sounds pretty good to me ;-)

FWIW, how long is that IRQ disabled section? It looks like something
that could be taking a bit of time. We have these people that care about
IRQ latency.

> While the results do seem close, reporting a cache miss on memory that
> is set up to be locked in cache is significant.

If it is 'locked' then how does perf causes misses? I suppose I should
go read that earlier email.

> In an attempt to improve the accuracy of the above I modified it to the
> following:
> 
> /* create the two events as before in "enabled" state */
> l2_hit_pmcnum = l2_hit_event->hw.event_base_rdpmc;
> l2_miss_pmcnum = l2_miss_event->hw.event_base_rdpmc;
> local_irq_disable();
> /* disable hw prefetchers */
> /* init local vars to loop through pseudo-locked mem */
> l2_hits_before = native_read_pmc(l2_hit_pmcnum);
> l2_miss_before = native_read_pmc(l2_miss_pmcnum);
> /* loop through pseudo-locked mem */
> l2_hits_after = native_read_pmc(l2_hit_pmcnum);
> l2_miss_after = native_read_pmc(l2_miss_pmcnum);
> /* enable hw prefetchers */
> local_irq_enable();

So the above has a number or practical problems:

 - event_base_rdpmc is subject to change as long as interrupts are
   enabled.

 - I don't much fancy people accessing the guts of events like that;
   would not an inline function like:

   static inline u64 x86_perf_rdpmc(struct perf_event *event)
   {
	u64 val;

	lockdep_assert_irqs_disabled();

	rdpmcl(event->hw.event_base_rdpmc, val);
	return val;
   }

   Work for you?

 - native_read_pmc(); are you 100% sure this code only ever runs on
   native and not in some dodgy virt environment?

   (also, I suppose all hardware supporting this resctl locking muck
   actually has rdpmc ;-))

 - You used perf_event_attr::pinned=1, this means we could have failed
   to schedule the event, you need to check error state somewhere and
   have a credible error handling.

   For checking error state; you could use perf_event_read_local() early
   after disabling IRQs, it needs a little extra test though:

	if (event->attr.pinned && event->oncpu != smp_processor_id())
		return -EBUSY;

   to correctly deal with pinned failure. Place it such that it becomes
   the last sanity check.


Also, while you disable IRQs, your fancy pants loop is still subject to
NMIs that can/will perturb your measurements, how do you deal with
those?
