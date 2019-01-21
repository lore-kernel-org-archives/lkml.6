Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD19C2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89B12085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WAa/hXx6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbfAUOo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:44:59 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46946 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729279AbfAUOo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:44:59 -0500
Received: by mail-ed1-f66.google.com with SMTP id o10so16725522edt.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 06:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t71UswEWBFZkCe082TYkv1u+bc2P8dUcKTngMR/LjjU=;
        b=WAa/hXx6GW8lrjNRTKGp8NMMwpFxMm7O9y2g7JXZQo4ZfF3OHRojFxIwyQ1fPMW4Ie
         HIm8GtcbR97kTLu9y48f0sUAIxi9ZZum2YpJ9I9ZehzCV2O7A9DKIq3Dz8VdcC+Ruv3G
         cKZsZfiZshA0loGFCo/5/eNQGkhc9kROwVex8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t71UswEWBFZkCe082TYkv1u+bc2P8dUcKTngMR/LjjU=;
        b=MOZ+fE/bUiKxCdPVXkm0gG4rZjJfFqAddqf8iqD/4wRNGg6qBdC58S2qQ96WiNEnUC
         w9OPj/3dPqpENokeopXfgn9qJg5oVEWOUv4+wImYxy1kaaJ6LQuTXy220fbfh7ED/9oe
         TRJUf4f5JWcOL3NRtCYZ1CQMv3MhLwciW25X3ZCw9Tii8Ta/X4lptA7tvYVU4oRvM0E1
         VpLAqVu6+IrsTZtdfMlAMFNkUDHCQ8NJSHMwwslVaqBCz/Bz3rzpZqFUQpNPmA8FXqD/
         PRAWPBWHSAUcmGaHMS0mAaLvBpBnJLCV9s3qwOFxejDjzG5jcdeTnbU8HRQvD46vBNEQ
         X49w==
X-Gm-Message-State: AJcUukchsEIiSHXc1tBXQRBrpCFjNz55og2QRVr6N1l31hh8bm0siWjQ
        rvXorEhI28tlYUBLM+wNxU8eWw==
X-Google-Smtp-Source: ALg8bN4YFL1X7uSuW+Rv1Ugfp77BdADswilwJykaNF5t9OLwKowUJVap+5HfYu4alD6MJ51gBcdKGA==
X-Received: by 2002:a17:906:4684:: with SMTP id a4-v6mr24600628ejr.24.1548081896851;
        Mon, 21 Jan 2019 06:44:56 -0800 (PST)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id d56sm9206090ede.76.2019.01.21.06.44.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 06:44:56 -0800 (PST)
Date:   Mon, 21 Jan 2019 15:44:46 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Elena Reshetova <elena.reshetova@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kcov: convert kcov.refcount to refcount_t
Message-ID: <20190121144446.GA8926@andrea>
References: <1547634429-772-1-git-send-email-elena.reshetova@intel.com>
 <CACT4Y+bWgcS=c=KrthWyyjjBpc72DEK-=czLYK8=SkmOsZ_-jg@mail.gmail.com>
 <CACT4Y+a6-YyrwZ9qX+yhhMuoPoZ5=B-NKxkn-EyFqijNBf4N+g@mail.gmail.com>
 <20190121114505.GA7307@andrea>
 <CACT4Y+aF8+RqEk8RJn3G4nN8bCAxuci5W9YXa=cFq4c-QC3kgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aF8+RqEk8RJn3G4nN8bCAxuci5W9YXa=cFq4c-QC3kgg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 01:29:11PM +0100, Dmitry Vyukov wrote:
>  On Mon, Jan 21, 2019 at 12:45 PM Andrea Parri
> <andrea.parri@amarulasolutions.com> wrote:
> >
> > On Mon, Jan 21, 2019 at 10:52:37AM +0100, Dmitry Vyukov wrote:
> >
> > [...]
> >
> > > > Am I missing something or refcount_dec_and_test does not in fact
> > > > provide ACQUIRE ordering?
> > > >
> > > > +case 5) - decrement-based RMW ops that return a value
> > > > +-----------------------------------------------------
> > > > +
> > > > +Function changes:
> > > > +                atomic_dec_and_test() --> refcount_dec_and_test()
> > > > +                atomic_sub_and_test() --> refcount_sub_and_test()
> > > > +                no atomic counterpart --> refcount_dec_if_one()
> > > > +                atomic_add_unless(&var, -1, 1) --> refcount_dec_not_one(&var)
> > > > +
> > > > +Memory ordering guarantees changes:
> > > > +                fully ordered --> RELEASE ordering + control dependency
> > > >
> > > > I think that's against the expected refcount guarantees. When I
> > > > privatize an  atomic_dec_and_test I would expect that not only stores,
> > > > but also loads act on a quiescent object. But loads can hoist outside
> > > > of the control dependency.
> > > >
> > > > Consider the following example, is it the case that the BUG_ON can still fire?
> >
> > Can't it fire in an SC world? (wrong example, or a Monday morning? ;D)
> 
> I don't see how. Maybe there is a stupid off-by-one, but overall
> that's the example I wanted to show. refcount is 2, each thread sets
> own done flag, drops refcount, last thread checks done flag of the
> other thread.

You're right: looking at the example again, I think that the BUG_ON()
in your example can indeed trigger with a CTRL+RELEASE semantics (but
_not with the fully-ordered semantics).

I apologize for the confusion (it must have been _my Monday...  ;-/).

  Andrea


> 
> 
> 
> > > > struct X {
> > > >   refcount_t rc; // == 2
> > > >   int done1, done2; // == 0
> > > > };
> > > >
> > > > // thread 1:
> > > > x->done1 = 1;
> > > > if (refcount_dec_and_test(&x->rc))
> > > >   BUG_ON(!x->done2);
> > > >
> > > > // thread 2:
> > > > x->done2 = 1;
> > > > if (refcount_dec_and_test(&x->rc))
> > > >   BUG_ON(!x->done1);
