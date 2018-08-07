Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19113C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B829821527
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pLEDv39m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B829821527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389627AbeHGTrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:47:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39026 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732619AbeHGTrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BaP0nOX4KmOfyWqjxPQVOqTLtu4tkIW4uv3SsxPyv8w=; b=pLEDv39m7BnlRoc+rT9RV4aW6
        YTibb5uKod412sHTLR6fAFjBnNtnHfW7Af4IMMJmAiHlmQpxVGyDtIGXQGf8CorGhCSslNH7v/44W
        sPnoOK7EXp4O84AyEEblXHUw4NxKgLAqNrfOEzaTXd0TcGq42hklRYlV5MUQc9c8pUNZW9zqAsuFD
        CmJHkJ2q46/QYWo4I3Mf1ESjOIYIZ4qvupI9tA/KqrUNxeaYPZZYLDQmuDL1nUbO52v3OPpHMdrdA
        wLs0MYQBrbjmEDG0StfUMjGsLkQPX11bXYOdmgRGrY5T9fNCNePbZaaK/6oQj4yKuTeAY3i8BfgdC
        dLy2FhDQA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fn5pa-00056L-P1; Tue, 07 Aug 2018 17:31:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F9062058813A; Tue,  7 Aug 2018 19:31:37 +0200 (CEST)
Date:   Tue, 7 Aug 2018 19:31:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        ak@linux.intel.com, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH 2/3] x86, perf: Add a separate Arch Perfmon v4 PMI handler
Message-ID: <20180807173137.GG2494@hirez.programming.kicks-ass.net>
References: <1533576223-11588-1-git-send-email-kan.liang@linux.intel.com>
 <1533576223-11588-2-git-send-email-kan.liang@linux.intel.com>
 <20180806183515.GR2494@hirez.programming.kicks-ass.net>
 <fb5eb1f8-f071-d9e5-2ee3-372aa8f64525@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb5eb1f8-f071-d9e5-2ee3-372aa8f64525@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 11:29:54AM -0400, Liang, Kan wrote:
> On 8/6/2018 2:35 PM, Peter Zijlstra wrote:
> > On Mon, Aug 06, 2018 at 10:23:42AM -0700, kan.liang@linux.intel.com wrote:
> > > @@ -2044,6 +2056,14 @@ static void intel_pmu_disable_event(struct perf_event *event)
> > >   	if (unlikely(event->attr.precise_ip))
> > >   		intel_pmu_pebs_disable(event);
> > > +	/*
> > > +	 * We could disable freezing here, but doesn't hurt if it's on.
> > > +	 * perf remembers the state, and someone else will likely
> > > +	 * reinitialize.
> > > +	 *
> > > +	 * This avoids an extra MSR write in many situations.
> > > +	 */
> > > +
> > >   	if (unlikely(hwc->config_base == MSR_ARCH_PERFMON_FIXED_CTR_CTRL)) {
> > >   		intel_pmu_disable_fixed(hwc);
> > >   		return;
> > > @@ -2119,6 +2139,11 @@ static void intel_pmu_enable_event(struct perf_event *event)
> > >   	if (event->attr.exclude_guest)
> > >   		cpuc->intel_ctrl_host_mask |= (1ull << hwc->idx);
> > > +	if (x86_pmu.counter_freezing && !cpuc->frozen_enabled) {
> > > +		enable_counter_freeze();
> > > +		cpuc->frozen_enabled = 1;
> > > +	}
> > > +
> > >   	if (unlikely(event_is_checkpointed(event)))
> > >   		cpuc->intel_cp_status |= (1ull << hwc->idx);
> > 
> > Why here? That doesn't really make sense; should this not be in
> > intel_pmu_cpu_starting() or something?
> 
> 
> For Goldmont Plus, the counter freezing feature can be re-enabled at
> run-time by loading a newer microcode.
> We need to check the x86_pmu.counter_freezing every time.

Blergh, just don't go there. If we start with the wrong ucode, leave it
disabled.

We do that for most ucode stuff.
