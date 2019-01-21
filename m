Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87C0C2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFD820844
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbfAUQFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 11:05:05 -0500
Received: from netrider.rowland.org ([192.131.102.5]:54551 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728761AbfAUQFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 11:05:05 -0500
Received: (qmail 24530 invoked by uid 500); 21 Jan 2019 11:05:03 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Jan 2019 11:05:03 -0500
Date:   Mon, 21 Jan 2019 11:05:03 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Dmitry Vyukov <dvyukov@google.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
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
In-Reply-To: <20190121131816.GC17749@hirez.programming.kicks-ass.net>
Message-ID: <Pine.LNX.4.44L0.1901211103000.24162-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019, Peter Zijlstra wrote:

> On Mon, Jan 21, 2019 at 10:52:37AM +0100, Dmitry Vyukov wrote:
> > On Wed, Jan 16, 2019 at 1:51 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> 
> > > KCOV uses refcounts in a very simple canonical way, so no hidden
> > > ordering implied.
> > >
> > > Am I missing something or refcount_dec_and_test does not in fact
> > > provide ACQUIRE ordering?
> > >
> > > +case 5) - decrement-based RMW ops that return a value
> > > +-----------------------------------------------------
> > > +
> > > +Function changes:
> > > +                atomic_dec_and_test() --> refcount_dec_and_test()
> > > +                atomic_sub_and_test() --> refcount_sub_and_test()
> > > +                no atomic counterpart --> refcount_dec_if_one()
> > > +                atomic_add_unless(&var, -1, 1) --> refcount_dec_not_one(&var)
> > > +
> > > +Memory ordering guarantees changes:
> > > +                fully ordered --> RELEASE ordering + control dependency
> > >
> > > I think that's against the expected refcount guarantees. When I
> > > privatize an  atomic_dec_and_test I would expect that not only stores,
> > > but also loads act on a quiescent object. But loads can hoist outside
> > > of the control dependency.
> > >
> > > Consider the following example, is it the case that the BUG_ON can still fire?
> > >
> > > struct X {
> > >   refcount_t rc; // == 2
> > >   int done1, done2; // == 0
> > > };
> > >
> > > // thread 1:
> > > x->done1 = 1;
> > > if (refcount_dec_and_test(&x->rc))
> > >   BUG_ON(!x->done2);
> > >
> > > // thread 2:
> > > x->done2 = 1;
> > > if (refcount_dec_and_test(&x->rc))
> > >   BUG_ON(!x->done1);
> 
> I'm the one responsible for that refcount_t ordering.
> 
> The rationale for REL+CTRL is that for the final put we want to ensure
> all prior load/store are complete, because any later access could be a
> UAF; consider:
> 
> 
> P0()
> {
> 	x->foo=0;
> 	if (refcount_dec_and_test(&x->rc))
> 		free(x);
> }
> 
> P1()
> {
> 	x->bar=1;
> 	if (refcount_dec_and_test(&->rc))
> 		free(x);
> }
> 
> 
> without release, if would be possible for either (foo,bar) store to
> happen after the free().
> 
> Additionally we also need the CTRL to ensure that the actual free()
> happens _after_ the dec_and_test, freeing early would be bad.
> 
> But after these two requirements, the basic refcounting works.
> 
> > The refcount_dec_and_test guarantees look too weak to me, see the
> > example above. Shouldn't refcount_dec_and_test returning true give the
> > object in fully quiescent state? Why only control dependency? Loads
> > can hoist across control dependency, no?
> 
> Yes, loads can escape like you say.
> 
> Any additional ordering; like the one you have above; are not strictly
> required for the proper functioning of the refcount. Rather, you rely on
> additional ordering and will need to provide this explicitly:
> 
> 
> 	if (refcount_dec_and_text(&x->rc)) {
> 		/*
> 		 * Comment that explains what we order against....
> 		 */
> 		smp_mb__after_atomic();
> 		BUG_ON(!x->done*);
> 		free(x);
> 	}
> 
> 
> Also; these patches explicitly mention that refcount_t is weaker,
> specifically to make people aware of this difference.
> 
> A full smp_mb() (or two) would also be much more expensive on a number
> of platforms and in the vast majority of the cases it is not required.

How about adding smp_rmb() into refcount_dec_and_test()?  That would
give acq+rel semantics, which seems to be what people will expect.  And
it wouldn't be nearly as expensive as a full smp_mb().

Alan Stern

