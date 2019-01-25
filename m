Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89E2C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F26218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0mB3iUPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfAYKcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:32:04 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40378 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfAYKcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 05:32:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DtpvupyQ8gugIEqKFHIe1FVOq/MjQoGnEAn18erMFMo=; b=0mB3iUPTJjOYd7E5YQD1Ql/Dz
        IPq0N+eNw+A+Q6JhAZAEVUc0PA3dlMKN4ylkKrnNuMbSP8VejAYhEuZz6HOSH3TFO3xZUDcHY/dQF
        N/TCjiUBduBrrQOPgVv92eCWA5Mi0ToPHEXtVHgHBwqcFlDYy6ru0zVqxva+d2I9e2g1hljM97z+b
        tX1sbJCqs+fxGe872MaPkwBs7MueGU/UfleIOfBBFaOQy8s4hRUi9QFOUHsyEjKi2zHEvPuxP3MM5
        vFgbiPoMXUaeq8gDpzV3fmhN2QazlpGC3wpseB5Ic445wFkrzcVo/VUqNdrW6ITRCA6C1lzTmj9Gt
        PQlwOEZxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gmym4-0003vI-3o; Fri, 25 Jan 2019 10:31:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1F536200FC6DB; Fri, 25 Jan 2019 11:31:46 +0100 (CET)
Date:   Fri, 25 Jan 2019 11:31:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kcov: convert kcov.refcount to refcount_t
Message-ID: <20190125103146.GD4500@hirez.programming.kicks-ass.net>
References: <20190121131816.GC17749@hirez.programming.kicks-ass.net>
 <Pine.LNX.4.44L0.1901211103000.24162-100000@netrider.rowland.org>
 <20190122090456.GE13777@hirez.programming.kicks-ass.net>
 <CAGXu5jKHo4CZWAnn4Wvg=MV=xaf3j4mBvxggBHuZETTkMOxkOA@mail.gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4B92711@IRSMSX102.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4B92711@IRSMSX102.ger.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 09:02:42AM +0000, Reshetova, Elena wrote:
> > > I suppose we can add smp_acquire__after_ctrl_dep() on the true branch.
> > > Then it reall does become rel_acq.
> > >
> > > A wee something like so (I couldn't find an arm64 refcount, even though
> > > I have distinct memories of talk about it).
> > 
> > In the end, arm and arm64 chose to use REFCOUNT_FULL unconditionally,
> > so there's no arch-specific implementation.
> > 
> > > This isn't compiled, and obviously needs comment/documentation updates
> > > to go along with it.
> > 
> > Elena, can you do the doc updates?
> 
> Well, doc updates should go with below patch + and additional testing...
> 
> Peter, should I create a full version from below with doc/comments
> updates, run the whole thing via zero day and send to you if it all looks ok?

If you have to time to do so, yes please!
