Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0136C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19462084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544477818;
	bh=n0vhkUlLbGMAru4y4wqR/TMS+g1WDWkZEhh/m2tNA90=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=o94oeDv6aTC5kaaROF8RKZyCcXDYAD4m5Otcp7+6RfUIp9r4m137p+Lrr27hlqN0h
	 ITyTdfjBXel7bhmKqv1owSP0DPHCTYB074rmSxW6JmNu9c7CLiU80lVllfOV2Cc3f3
	 Am3cciOcAydPEGW6L57CvBOwlmcZ+LP0vib+pmp0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B19462084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbeLJVg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:36:57 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46204 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbeLJVgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:36:54 -0500
Received: by mail-oi1-f193.google.com with SMTP id x202so10254676oif.13;
        Mon, 10 Dec 2018 13:36:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dr8hiCyXQo1hX2X5cWuN+3q50xv31unul6ES2t08gWQ=;
        b=b4CBCNIBD4qHDcquWq8V2GmPk8K+qYv/R8K88/4wPGEr6OrmFY/E8V/M+wf5/Kjh7X
         dd/1D1M4YqlowpN9VbXMyjB5mirgJndxe6j+HAqHFfZ7WH5gCmuYgNa0AU9Q+18H9NtT
         xc4lrMrPbxsbud1k9L15zexoZx6EMpfzbmNPICNj8qHEkkIgHFwoMzPf/sRd75mADouf
         aYKbL9GgJVV8EtLBE86S6T+neuM4GH8wrDwLzE4B+Ggs1L3mP4Zm+SjydvU0txmFnMRB
         DfZDmHc0m/WY1j1j6Omy/Q02iJ0pQjXnlKWs0LuuoMkO93cEOQV3pUF9dKaaXtn9CR1f
         Xf1g==
X-Gm-Message-State: AA+aEWZeJIIswYSvobPDwMF6PsjNCaw+/8i0NspHNdj0/9H6LaTua3Ey
        7k2LgVnrYJgr3Guk439ybHxDWc12XqnE795WJCg=
X-Google-Smtp-Source: AFSGD/V68YN4KJdP+oM/xNtL9uLLfSwoeX+Ydrgm6FK2g8sG5+h2zscYEIHBxqi95P28qyjJIHQqV8UI4ogvC6ndEgU=
X-Received: by 2002:aca:b642:: with SMTP id g63mr7945600oif.195.1544477813386;
 Mon, 10 Dec 2018 13:36:53 -0800 (PST)
MIME-Version: 1.0
References: <3514439.dzOWKx1Cjx@aspire.rjw.lan> <20181210122104.GL5289@hirez.programming.kicks-ass.net>
In-Reply-To: <20181210122104.GL5289@hirez.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 10 Dec 2018 22:36:40 +0100
Message-ID: <CAJZ5v0j-a6cHayRtcsUPbUTBT0iBSUvmcUy6pfSSvUVcTMBxbw@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: Add 'above' and 'below' idle state metrics
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 1:21 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Dec 10, 2018 at 12:30:23PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Add two new metrics for CPU idle states, "above" and "below", to count
> > the number of times the given state had been asked for (or entered
> > from the kernel's perspective), but the observed idle duration turned
> > out to be too short or too long for it (respectively).
> >
> > These metrics help to estimate the quality of the CPU idle governor
> > in use.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> > @@ -260,6 +262,33 @@ int cpuidle_enter_state(struct cpuidle_d
> >               dev->last_residency = (int)diff;
> >               dev->states_usage[entered_state].time += dev->last_residency;
> >               dev->states_usage[entered_state].usage++;
> > +
> > +             if (diff < drv->states[entered_state].target_residency) {
> > +                     for (i = entered_state - 1; i >= 0; i--) {
> > +                             if (drv->states[i].disabled ||
> > +                                 dev->states_usage[i].disable)
> > +                                     continue;
> > +
> > +                             /* Shallower states are enabled, so update. */
> > +                             dev->states_usage[entered_state].above++;
> > +                             break;
> > +                     }
> > +             } else if (diff > delay) {
> > +                     for (i = entered_state + 1; i < drv->state_count; i++) {
> > +                             if (drv->states[i].disabled ||
> > +                                 dev->states_usage[i].disable)
> > +                                     continue;
> > +
> > +                             /*
> > +                              * Update if a deeper state would have been a
> > +                              * better match for the observed idle duration.
> > +                              */
> > +                             if (diff - delay >= drv->states[i].target_residency)
> > +                                     dev->states_usage[entered_state].below++;
> > +
> > +                             break;
> > +                     }
> > +             }
>
> One question on this; why is this tracked unconditionally?

Because I didn't quite see how to make that conditional in a sensible way.

These things are counters and counting with the help of tracepoints
isn't particularly convenient (and one needs debugfs to be there to
use tracepoints and they require root access etc).

> Would not a tracepoint be better?; then there is no overhead in the
> normal case where nobody gives a crap about these here numbers.

There is an existing tracepoint that in principle could be used to
produce this information, but it is such a major PITA in practice that
nobody does that.  Guess why. :-)

Also, the "usage" and "time" counters are there in sysfs, so why not these two?

And is the overhead really that horrible?
