Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465F1C32788
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 22:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C08B2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 22:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fWmGQxgq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C08B2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbeKUIsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 03:48:23 -0500
Received: from merlin.infradead.org ([205.233.59.134]:35886 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeKUIsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 03:48:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SoppcZ4H3ZDInKleFzp7j+ay3HqLr+HiBj8M9YISW3w=; b=fWmGQxgqlHLPoSFsgr5uDfVUT
        MOyUbOki+fcM90UGLbDH8XpSqZIyoEzNepjwNiHrsWzgbcy3Y+FCFfLJjmc+s+RgqF7rTK02UrDac
        Rg0qlK0Sn9WZBnhzEOxfYgjCiJItsvF52erUNaa+YQy/8vEMqI3cqWL5TMvV7WZJHf1jWMg4OwwGV
        4Fvt2CETfLChcZ19ySWCJm3usoOyQVxANFz7HCzNPkV4szp9/7TaLlnTTY4p58xu7gPlqNoRGsx9Q
        ph/txAeUkePhKqhZV9W5pwnZl4y4xDLcigk6ptt3G3CSEHYcAIpgRnFLDFEb2s5s3AnA8IyH9+ZK0
        dsXbLSuCw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPEK7-0000GA-Q5; Tue, 20 Nov 2018 22:16:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CFC6F2029FD58; Tue, 20 Nov 2018 23:16:42 +0100 (CET)
Date:   Tue, 20 Nov 2018 23:16:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Kyle Huey <me@kylehuey.com>, Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Robert O'Callahan <robert@ocallahan.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, acme@kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] x86, perf: counter freezing breaks rr
Message-ID: <20181120221642.GE2131@hirez.programming.kicks-ass.net>
References: <CAP045Ap6Mm+r_44YmxNbz6HWtYArg3SAFgzk4Cm_K5HRJaRG7w@mail.gmail.com>
 <20181120194129.GC13936@tassilo.jf.intel.com>
 <CAP045ApoZamGdgVd=-MJE52rUU5hnOg=j95B1WV2x_bVtRQpWA@mail.gmail.com>
 <20181120201144.GD13936@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120201144.GD13936@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 12:11:44PM -0800, Andi Kleen wrote:
> > > > Given that we're already at rc3, and that this renders rr unusable,
> > > > we'd ask that counter freezing be disabled for the 4.20 release.
> > >
> > > The boot option should be good enough for the release?
> > 
> > I'm not entirely sure what you mean here. We want you to flip the
> > default boot option so this feature is off for this release. i.e. rr
> > should work by default on 4.20 and people should have to opt into the
> > inaccurate behavior if they want faster PMI servicing.
> 
> I don't think it's inaccurate, it's just different 
> than what you are used to.
> 
> For profiling including the kernel it's actually far more accurate
> because the count is stopped much earlier near the sampling
> point. Otherwise there is a considerable over count into
> the PMI handler.
> 
> In your case you limit the count to ring 3 so it's always cut off
> at the transition point into the kernel, while with freezing
> it's at the overflow point.

Ooh, so the thing does FREEZE_ON_OVERFLOW _not_ FREEZE_ON_PMI. Yes, that
can be a big difference.

See, FREEZE_ON_PMI, as advertised by the name, should have no observable
effect on counters limited to USR. But something like FREEZE_ON_OVERFLOW
will loose everything between the overflow and the eventual PMI, and by
freezing early we can't even compensate for it anymore either,
introducing drift in the period.

And I don't buy the over-count argument, the counter register shows how
far over you are; it triggers the overflow when we cross 0, it then
continues counting. So if you really care, you can throw away the
'over-count' at PMI time. That doesn't make it more reliable. We don't
magically get pt_regs from earlier on or any other state.

The only thing where it might make a difference is if you're running
multiple counters (groups in perf speak) and want to correlate the count
values. Then, and only then, does it matter.

Bah.
