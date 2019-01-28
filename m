Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94193C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB8620880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XMyKgx8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfA1J2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:28:18 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33780 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfA1J2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=q07BdVLL3C99fU5+GZcl5MQksCE2HUN5ZMQmAGIoYN0=; b=XMyKgx8VAHbVNB+UmtHmmJznF
        C0GcNUhwUcoM+5f7dMSZo/NGqQl7cNc5XxNSt0XC8YkJ/A/2ZcaYeeUQ92Xl41XMAs+calSFJiIA7
        I2u5YmXOqDVp1FOEboNVHjy6ui1QmLCfS/dQhJbEL+X4DKaPLQirUJc5pqUGew8pntstqSNeJWBaS
        FeJuUvr7MtlhASwaMgBfodecqw25ybj/Hfvuup1TZL766b5QWgbJZUVlw93FK5rOL/Wippxibl+07
        pgaQWa6hX5iuf5EB4iPRmdE83Dlt80Lrm9geRhLk9pmBJ1XkT52oXUzDliyF/A2eekgHQoVwv5kIQ
        QIx1yN39g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1go3D0-000615-58; Mon, 28 Jan 2019 09:28:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8A92820101B91; Mon, 28 Jan 2019 10:28:00 +0100 (CET)
Date:   Mon, 28 Jan 2019 10:28:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kcov: convert kcov.refcount to refcount_t
Message-ID: <20190128092800.GE28467@hirez.programming.kicks-ass.net>
References: <20190121131816.GC17749@hirez.programming.kicks-ass.net>
 <Pine.LNX.4.44L0.1901211103000.24162-100000@netrider.rowland.org>
 <20190122090456.GE13777@hirez.programming.kicks-ass.net>
 <2236FBA76BA1254E88B949DDB74E612BA4B944B3@IRSMSX102.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4B944B3@IRSMSX102.ger.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2019 at 06:41:38PM +0000, Reshetova, Elena wrote:
> > On Mon, Jan 21, 2019 at 11:05:03AM -0500, Alan Stern wrote:
> > > On Mon, 21 Jan 2019, Peter Zijlstra wrote:

> > Yes, that's a very good suggestion.
> > 
> > I suppose we can add smp_acquire__after_ctrl_dep() on the true branch.
> > Then it reall does become rel_acq.
> > 
> > A wee something like so (I couldn't find an arm64 refcount, even though
> > I have distinct memories of talk about it).
> > 
> > This isn't compiled, and obviously needs comment/documentation updates
> > to go along with it.
> > 
> > ---
> >  arch/x86/include/asm/refcount.h | 9 ++++++++-
> >  lib/refcount.c                  | 7 ++++++-
> >  2 files changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
> > index dbaed55c1c24..6f7a1eb345b4 100644
> > --- a/arch/x86/include/asm/refcount.h
> > +++ b/arch/x86/include/asm/refcount.h
> > @@ -74,9 +74,16 @@ bool refcount_sub_and_test(unsigned int i, refcount_t *r)
> > 
> >  static __always_inline __must_check bool refcount_dec_and_test(refcount_t *r)
> >  {
> > -	return GEN_UNARY_SUFFIXED_RMWcc(LOCK_PREFIX "decl",
> > +	bool ret = GEN_UNARY_SUFFIXED_RMWcc(LOCK_PREFIX "decl",
> > 
> > 	REFCOUNT_CHECK_LT_ZERO,
> >  					r-
> > >refs.counter, e, "cx");
> > +
> > +	if (ret) {
> > +		smp_acquire__after_ctrl_dep();
> > +		return true;
> > +	}
> > +
> > +	return false;
> >  }
> 
> Actually as I started to do this, any reason why the change here only
> for dec_and_test and not for sub_and _test also? Should not the arch.
> specific logic follow the generic?

Yes, sub_and_test also needs it; I simply overlooked it.
