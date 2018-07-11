Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36441C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC802208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC802208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbeGKFrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 01:47:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56792 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbeGKFrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 01:47:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98E5680D;
        Tue, 10 Jul 2018 22:44:31 -0700 (PDT)
Received: from salmiak (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE5803F318;
        Tue, 10 Jul 2018 22:44:29 -0700 (PDT)
Date:   Wed, 11 Jul 2018 06:44:21 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] refcount: always allow checked forms
Message-ID: <20180711054421.qgsdctwtncr32r4y@salmiak>
References: <20180703100102.16615-1-mark.rutland@arm.com>
 <CAGXu5jLATGcq_mgetUurBriCaPmBQmBwxVW7aa9fAKM2XeSjHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLATGcq_mgetUurBriCaPmBQmBwxVW7aa9fAKM2XeSjHw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 11:30:38AM -0700, Kees Cook wrote:
> On Tue, Jul 3, 2018 at 3:01 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > In many cases, it would be useful to be able to use the full
> > sanity-checked refcount helpers regardless of CONFIG_REFCOUNT_FULL, as
> > this would help to avoid duplicate warnings where callers try to
> > sanity-check refcount manipulation.
> >
> > This patch refactors things such that the full refcount helpers were
> > always built, as refcount_${op}_checked(), such that they can be used
> > regardless of CONFIG_REFCOUNT_FULL. This will allow code which *always*
> > wants a checked refcount to opt-in, avoiding the need to duplicate the
> > logic for warnings.
> >
> > There should be no functional change as a result of this patch.
> >
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: David Sterba <dsterba@suse.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Will Deacon <will.deacon@arm.com>
> 
> Looks good to me! Thanks for doing this. :)

Thank David; I rather stole his thunder here.

> Acked-by: Kees Cook <keescook@chromium.org>
> 
> > ---
> >  include/linux/refcount.h | 27 +++++++++++++++++-------
> >  lib/refcount.c           | 53 +++++++++++++++++++++++-------------------------
> >  2 files changed, 45 insertions(+), 35 deletions(-)
> >
> > Dave pointed out that it would be useful to be able to opt-in to full checks
> > regardless of CONFIG_REFCOUNT_FULL, so that we can simplify callsites where we
> > always want checks. I've spotted a few of these in code which is still awaiting
> > conversion.
> 
> Yeah, I need to go through the cocci output -- Elena had several
> outstanding patches that never got picked up.
> 
> > I'm assuming that the atomics group is intended to own the refcount code, even
> > though this isn't currently the case in MAINTAINERS.
> 
> That's how it has landed in the past, yes, but if there is a
> dependency on these for code that will use it, maybe it should go that
> way?

That sounds reasonable to me. I was just wanted to be clear as to why I'd Cc'd
the atomics maintainers. :)

I'll spin a v2 with the fixup Andrea noted.

Thanks,
Mark.
