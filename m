Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F4DC46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A9B20892
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A9B20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbeKGVkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 16:40:17 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34490 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbeKGVkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 16:40:17 -0500
Received: by mail-oi1-f195.google.com with SMTP id i138-v6so10617546oib.1;
        Wed, 07 Nov 2018 04:10:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aNBV8O4UWxL6yl74jBOnzUsZz7Qhj2Vhoe/FAYVFy90=;
        b=uea5LH3KLdETiUMMhU4mQWo3cRsiikD33vETbB4Nl074xs8zxhglVukq+SeJkn/G5A
         SUNiINwETeL5Eu36Lp1+AUQ7Q98GBoCITQuusDUMpQQ+pAeg9A2fTrEtiL2OAJiNA3x7
         e94uLHQJKPzDBrPa6K0HTzGqKnj9X8KPPKe5BGd9BouuqEsb1i+6I+s1Jy+gUf2r34iX
         cOenIciqizXHm2qeS/gw25Ij2QIJ4GVOuaBYGNRiPFwL0xF2Y4I1tUfq94f6tSloeq5c
         yooObd5ahX3sqRI7v5308eHksijTUC3vQw0Iplxiy6PV0z1f4WFniNZHwhDUqxJtzDMk
         TDQQ==
X-Gm-Message-State: AGRZ1gKOsVqum8ic9cWUXbY8c58ceqJSMu/w15DGzbhyJwBwhsQg+jq8
        nfqwkijUs+8u0NwRJxSV2luhp5nrqxgMZ21tKoViTqMQ
X-Google-Smtp-Source: AJdET5ddltPQCVgVKnzsxXNABjMULLFH6hDE/pKeDYLdiHRdTheUgJRXNsQ4JnkB/enIsYJvgCTmqUj7h82glicHZgo=
X-Received: by 2002:aca:c2c3:: with SMTP id s186-v6mr846599oif.193.1541592610035;
 Wed, 07 Nov 2018 04:10:10 -0800 (PST)
MIME-Version: 1.0
References: <1556808.yKVbhZSazi@aspire.rjw.lan> <20181106170442.GC9781@hirez.programming.kicks-ass.net>
 <CAJZ5v0hmm2UWRt1j6hQo14nZLgPrE3DZkOznfo2kMxsZ1spo-Q@mail.gmail.com>
 <20181106195127.GD9781@hirez.programming.kicks-ass.net> <CAJZ5v0iPs8Wt0PneBVWptqJPP6dEze+=GvxjU=dHBRbmty+kOw@mail.gmail.com>
 <20181107085936.GI9781@hirez.programming.kicks-ass.net>
In-Reply-To: <20181107085936.GI9781@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 7 Nov 2018 13:09:58 +0100
Message-ID: <CAJZ5v0i4_TX_F=2hYKNpsG_QUPsn5EKiyfx2poE6SqsWyEp2Nw@mail.gmail.com>
Subject: Re: [RFC/RFT][PATCH v3] cpuidle: New timer events oriented governor
 for tickless systems
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 9:59 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Nov 07, 2018 at 12:39:31AM +0100, Rafael J. Wysocki wrote:
> > On Tue, Nov 6, 2018 at 8:51 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Tue, Nov 06, 2018 at 07:19:24PM +0100, Rafael J. Wysocki wrote:
> > > > On Tue, Nov 6, 2018 at 6:04 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > > > Instead of this detector; why haven't you used the code from
> > > > > kernel/irq/timings.c ?
> > > >
> > > > Because it doesn't help much AFAICS.
> > > >
> > > > Wakeups need not be interrupts in particular
> > >
> > > You're alluding to the MWAIT wakeup through the MONITOR address ?
> >
> > Yes.
>
> Right, those will not be accounted for and will need something else.

Precisely. :-)

> > > > and interrupt patterns that show up when the CPU is busy may not be
> > > > relevant for when it is idle.
> > >
> > > I think that is not always true; consider things like the periodic
> > > interrupt from frame rendering or audio; if there is nothing more going
> > > on in the system than say playing your favourite tune, it gets the
> > > 'need more data soon' interrupt from the audio card, wakes up, does a little
> > > mp3/flac/ogg/whatever decode to fill up the buffer and goes back to
> > > sleep. Same for video playback I assume, the vsync interrupt for buffer
> > > flips is fairly predictable.
> > >
> > > The interrupt predictor we have in kernel/irq/timings.c should be very
> > > accurate in predicting those interrupts.
> >
> > In the above case the interrupts should produce a detectable pattern
> > of wakeups anyway.
>
> Ah, not so. Suppose you have both the audio and video interrupt going at
> a steady rate but different rate, then the combined pattern isn't
> trivial at all.

It isn't trivial, but it will appear as a "pattern" to the pattern
detector in v4 of the patch.

Basically, all of that is about looking for a reason to select a
shallower idle state than indicated by the time till the closest timer
alone.

From that standpoint it makes sense to look at several most recent
wakeups and see if a pattern is forming in there, which is what the
code in v4 of the patch does.  It also makes sense to look at
interrupt patters, but that is costly, so the overhead needs to be
justified.  The question to me is whether or not there is any
additional value in that given that the most recent wakeups are (and
IMO need to be) taken into consideration anyway.

> > In general, however, I need to be convinced that interrupts that
> > didn't wake up the CPU from idle are relevant for next wakeup
> > prediction.  I see that this may be the case, but to what extent is
> > rather unclear to me and it looks like calling
> > irq_timings_next_event() would add considerable overhead.
>
> How about we add a (debug) knob so that people can play with it for now?
> If it turns out to be useful, we'll learn.

So I'm inclined to try to invoke irq_timings_next_event() in addition
to looking at the most recent wakeups and see how far that can get us.

With some extra instrumentation in place it should be possible to
verify how much value that brings to the table.
