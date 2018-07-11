Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDCAC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972C520C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 972C520C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388233AbeGKQ4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:56:21 -0400
Received: from foss.arm.com ([217.140.101.70]:40478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387987AbeGKQ4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:56:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E184880D;
        Wed, 11 Jul 2018 09:51:09 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CCFC3F589;
        Wed, 11 Jul 2018 09:51:08 -0700 (PDT)
Date:   Wed, 11 Jul 2018 17:51:03 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: [Intel-gfx] [PATCH 11/12] sched: use for_each_if in topology.h
Message-ID: <20180711165103.hr7klbun2elfncfx@lakrids.cambridge.arm.com>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
 <20180709083650.23549-11-daniel.vetter@ffwll.ch>
 <20180709103656.GH2476@hirez.programming.kicks-ass.net>
 <CAKMK7uEr9PJ0mex5CWdws55OwaLuHCbLJ5vP8KA4ZQXdAVOTYQ@mail.gmail.com>
 <20180709151258.GV2476@hirez.programming.kicks-ass.net>
 <20180709155204.GD3008@phenom.ffwll.local>
 <20180709160342.GA2476@hirez.programming.kicks-ass.net>
 <20180709161232.up6vnuybvkxn76am@lakrids.cambridge.arm.com>
 <CAKMK7uHQz6+=30nCU-8CerC9eRrwnA_O-cxRSoHHbGf0uNMYmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uHQz6+=30nCU-8CerC9eRrwnA_O-cxRSoHHbGf0uNMYmA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 07:55:20PM +0200, Daniel Vetter wrote:
> On Mon, Jul 9, 2018 at 6:12 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Mon, Jul 09, 2018 at 06:03:42PM +0200, Peter Zijlstra wrote:
> >> On Mon, Jul 09, 2018 at 05:52:04PM +0200, Daniel Vetter wrote:
> >> > for_each_something(foo)
> >> >     if (foo->bla)
> >> >             call_bla(foo);
> >> >     else
> >> >             call_default(foo);
> >> >
> >> > Totally contrived, but this complains. Liberally sprinkling {} also shuts
> >> > up the compiler, but it's a bit confusing given that a plain for {;;} is
> >> > totally fine. And it's confusing since at first glance the compiler
> >> > complaining about nested if and ambigous else doesn't make sense since
> >> > clearly there's only 1 if there.
> >>
> >> Ah, so the pattern the compiler tries to warn about is:
> >>
> >>       if (foo)
> >>               if (bar)
> >>                       /* stmts1 */
> >>               else
> >>                       /* stmts2 *
> >>
> >> Because it might not be immediately obvious with which if the else goes.
> >> Which is fair enough I suppose.
> >>
> >> OK, ACK.
> >
> > Just to bikeshed, there could be macros other than for_each_*() macros
> > that will want to use this internally, so perhaps it would be worth the
> > generic version being named something like if_noelse().
> >
> > We could always add that as/when required, though.
> 
> I think a better name would be really good, but both when we added it
> for i915 and when we move it to drm headers we drew a blank.
> if_noelse() describes pretty good what it does, but kinda fails on the
> "where should I use it" departement. If there's some consensus I can
> sed the patches quickly.

Just to be clear: for_each_if() is fine by me, so no need to change
things.

Sorry for the noise!

Mark.
