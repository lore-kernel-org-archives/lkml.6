Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7387BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA6E20862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hs072k/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA6E20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbeKGS3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 13:29:16 -0500
Received: from merlin.infradead.org ([205.233.59.134]:54282 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbeKGS3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 13:29:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8YWMxjj5OCwP4xaGuR46tBO9eGmPGHKGyc50rtcYkwk=; b=Hs072k/tH3biSPs9VLxHpZmgs
        ThcEoQgxIW13ZoixLTIPBcwAfr2FprYCleVnWo0FqYetxfWtvXH4bfekXHMD8c2GqLRp+7KDGqV6h
        YneOmqFaZJsz0tYBW2FLhdzBGPUKvAuCqndjuFtUEbUeVg8joqK6Q+dK2GQ7BfJjcMI36dBIBP5dg
        RZ6jrD9PI8KzOeRS273jP+14wHwOO/Hx1mPn2u/sUhJ9X2fmE42hRy8dIp3Nu/7DighEsrWVhUqxG
        GwEw3+CX9/A0clHzl4w6mJLKdjlNLIMCP/77lhELP/EgCSQmyYFln26Pp7M4z9+IQ/bItYIcPbvzy
        0L0N/mejw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKJgZ-0003Sq-Id; Wed, 07 Nov 2018 08:59:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4CAC920284C61; Wed,  7 Nov 2018 09:59:36 +0100 (CET)
Date:   Wed, 7 Nov 2018 09:59:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC/RFT][PATCH v3] cpuidle: New timer events oriented governor
 for tickless systems
Message-ID: <20181107085936.GI9781@hirez.programming.kicks-ass.net>
References: <1556808.yKVbhZSazi@aspire.rjw.lan>
 <20181106170442.GC9781@hirez.programming.kicks-ass.net>
 <CAJZ5v0hmm2UWRt1j6hQo14nZLgPrE3DZkOznfo2kMxsZ1spo-Q@mail.gmail.com>
 <20181106195127.GD9781@hirez.programming.kicks-ass.net>
 <CAJZ5v0iPs8Wt0PneBVWptqJPP6dEze+=GvxjU=dHBRbmty+kOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iPs8Wt0PneBVWptqJPP6dEze+=GvxjU=dHBRbmty+kOw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 12:39:31AM +0100, Rafael J. Wysocki wrote:
> On Tue, Nov 6, 2018 at 8:51 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Nov 06, 2018 at 07:19:24PM +0100, Rafael J. Wysocki wrote:
> > > On Tue, Nov 6, 2018 at 6:04 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > > > Instead of this detector; why haven't you used the code from
> > > > kernel/irq/timings.c ?
> > >
> > > Because it doesn't help much AFAICS.
> > >
> > > Wakeups need not be interrupts in particular
> >
> > You're alluding to the MWAIT wakeup through the MONITOR address ?
> 
> Yes.

Right, those will not be accounted for and will need something else.

> > > and interrupt patterns that show up when the CPU is busy may not be
> > > relevant for when it is idle.
> >
> > I think that is not always true; consider things like the periodic
> > interrupt from frame rendering or audio; if there is nothing more going
> > on in the system than say playing your favourite tune, it gets the
> > 'need more data soon' interrupt from the audio card, wakes up, does a little
> > mp3/flac/ogg/whatever decode to fill up the buffer and goes back to
> > sleep. Same for video playback I assume, the vsync interrupt for buffer
> > flips is fairly predictable.
> >
> > The interrupt predictor we have in kernel/irq/timings.c should be very
> > accurate in predicting those interrupts.
> 
> In the above case the interrupts should produce a detectable pattern
> of wakeups anyway.

Ah, not so. Suppose you have both the audio and video interrupt going at
a steady rate but different rate, then the combined pattern isn't
trivial at all.

> In general, however, I need to be convinced that interrupts that
> didn't wake up the CPU from idle are relevant for next wakeup
> prediction.  I see that this may be the case, but to what extent is
> rather unclear to me and it looks like calling
> irq_timings_next_event() would add considerable overhead.

How about we add a (debug) knob so that people can play with it for now?
If it turns out to be useful, we'll learn.
