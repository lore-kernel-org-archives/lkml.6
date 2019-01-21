Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E28C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7162F2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c5LlThnU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfAUNSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:18:33 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49984 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbfAUNSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:18:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=37mhoiETsTi7VwP6ypHPIl+yQHcVuxg4WC4ZT2N3owk=; b=c5LlThnUXKhpPGrKVDYSug9un
        oOAYvbArqZT6euaTG7Ij2LvUEV72UoLNuYmgLnk6wLZ6uhwo+r05W4okiSRyZ44XrR39PYo6xfcxw
        aNo205i7eMszSakbK9vLCRh4tHlTyl3MVyq4n2WsW7JY+QHsv0NSKh1EsXADk1bMN5RALOSAPicTH
        l11y/uI0sDIlLQJDX1SJ4itQARLC6ONCloKKwoQTxMccHNcFpH6NlbQE0vh424yOj/yDq3bpMLyCJ
        jZwgCw+Q6vQDqY/RtLZCDkrwDcGKXYXa7P5BSXq6GM1+4+Ol7vRXN10KOEn3JG1TByt/rtKOXjtoE
        TZO90Qb2A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1glZSz-00048R-Ss; Mon, 21 Jan 2019 13:18:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A5E252846CDD7; Mon, 21 Jan 2019 14:18:16 +0100 (CET)
Date:   Mon, 21 Jan 2019 14:18:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Elena Reshetova <elena.reshetova@intel.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Kees Cook <keescook@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kcov: convert kcov.refcount to refcount_t
Message-ID: <20190121131816.GC17749@hirez.programming.kicks-ass.net>
References: <1547634429-772-1-git-send-email-elena.reshetova@intel.com>
 <CACT4Y+bWgcS=c=KrthWyyjjBpc72DEK-=czLYK8=SkmOsZ_-jg@mail.gmail.com>
 <CACT4Y+a6-YyrwZ9qX+yhhMuoPoZ5=B-NKxkn-EyFqijNBf4N+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+a6-YyrwZ9qX+yhhMuoPoZ5=B-NKxkn-EyFqijNBf4N+g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 10:52:37AM +0100, Dmitry Vyukov wrote:
> On Wed, Jan 16, 2019 at 1:51 PM Dmitry Vyukov <dvyukov@google.com> wrote:

> > KCOV uses refcounts in a very simple canonical way, so no hidden
> > ordering implied.
> >
> > Am I missing something or refcount_dec_and_test does not in fact
> > provide ACQUIRE ordering?
> >
> > +case 5) - decrement-based RMW ops that return a value
> > +-----------------------------------------------------
> > +
> > +Function changes:
> > +                atomic_dec_and_test() --> refcount_dec_and_test()
> > +                atomic_sub_and_test() --> refcount_sub_and_test()
> > +                no atomic counterpart --> refcount_dec_if_one()
> > +                atomic_add_unless(&var, -1, 1) --> refcount_dec_not_one(&var)
> > +
> > +Memory ordering guarantees changes:
> > +                fully ordered --> RELEASE ordering + control dependency
> >
> > I think that's against the expected refcount guarantees. When I
> > privatize an  atomic_dec_and_test I would expect that not only stores,
> > but also loads act on a quiescent object. But loads can hoist outside
> > of the control dependency.
> >
> > Consider the following example, is it the case that the BUG_ON can still fire?
> >
> > struct X {
> >   refcount_t rc; // == 2
> >   int done1, done2; // == 0
> > };
> >
> > // thread 1:
> > x->done1 = 1;
> > if (refcount_dec_and_test(&x->rc))
> >   BUG_ON(!x->done2);
> >
> > // thread 2:
> > x->done2 = 1;
> > if (refcount_dec_and_test(&x->rc))
> >   BUG_ON(!x->done1);

I'm the one responsible for that refcount_t ordering.

The rationale for REL+CTRL is that for the final put we want to ensure
all prior load/store are complete, because any later access could be a
UAF; consider:


P0()
{
	x->foo=0;
	if (refcount_dec_and_test(&x->rc))
		free(x);
}

P1()
{
	x->bar=1;
	if (refcount_dec_and_test(&->rc))
		free(x);
}


without release, if would be possible for either (foo,bar) store to
happen after the free().

Additionally we also need the CTRL to ensure that the actual free()
happens _after_ the dec_and_test, freeing early would be bad.

But after these two requirements, the basic refcounting works.

> The refcount_dec_and_test guarantees look too weak to me, see the
> example above. Shouldn't refcount_dec_and_test returning true give the
> object in fully quiescent state? Why only control dependency? Loads
> can hoist across control dependency, no?

Yes, loads can escape like you say.

Any additional ordering; like the one you have above; are not strictly
required for the proper functioning of the refcount. Rather, you rely on
additional ordering and will need to provide this explicitly:


	if (refcount_dec_and_text(&x->rc)) {
		/*
		 * Comment that explains what we order against....
		 */
		smp_mb__after_atomic();
		BUG_ON(!x->done*);
		free(x);
	}


Also; these patches explicitly mention that refcount_t is weaker,
specifically to make people aware of this difference.

A full smp_mb() (or two) would also be much more expensive on a number
of platforms and in the vast majority of the cases it is not required.
