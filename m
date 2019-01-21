Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74C2C7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224082085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="eX0V9y6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbfAULpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:45:15 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44978 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbfAULpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:45:15 -0500
Received: by mail-ed1-f66.google.com with SMTP id y56so16286554edd.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 03:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=brxv/tjPVpV8ykPLBSI3YsolLBU8qbUq7D6kX/iBZA0=;
        b=eX0V9y6NVRBULPJE+6gFY+Oi35pr3mfL9L8xfLA4cNwnGrm2kEZD9Llc0/MMf70GiX
         m/nNLXRNvWQGMucA6yYH3o02a2hpwe33TtrK0R85NO9f6j+dnUKvfIpEZSSn80cQlMdU
         dAOehnSttB0aTQElOHcwZtw1XMlx4RgGzFjlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=brxv/tjPVpV8ykPLBSI3YsolLBU8qbUq7D6kX/iBZA0=;
        b=FOcY+sRFc9CfELyujJznynCeQ7sscRDXn083qNF6gGfgFIV/N6XlVMFx4tOxUq+bt0
         HllZ7U+l5MGUJartvllVT8adSkOSk1YOZvV2m1QPmRpBQa3NN96tInERIjcpWChBeSbC
         zND9GXeOCP3V/ZNB+1MABDr7G2h8b6D9Y8fCOl1dU1ACYZ/Qh66DvM5NIo2lRrO4zMQD
         /jWUn58h57vDH9CjVv2ADz7MFE2ukTy2J+HjXcD3d1eAmxr/3UF0q/XjGUB4jiV1SJZm
         2LdPtdI/9GfyOFxnzKEjkEUM+/Sptyxp7Gx0BkMLN5UqzQBSKALeExB0k53PE5C+uCVO
         9Wcw==
X-Gm-Message-State: AJcUukeS9o5vu2Ax//ANrPkD6IcEMlPeGyjycm2TjbwtudoAkzzSu/F4
        G2Pr0rfucr17nASxvbFKrCJ8cg==
X-Google-Smtp-Source: ALg8bN6VtQFKn7ne/75hu+34CB9xm5M7MPO9xy7gymjh9LakHTe8QaksYaq2sHrHoH7LjlZG2ifRqQ==
X-Received: by 2002:a50:c20a:: with SMTP id n10mr27327731edf.60.1548071112463;
        Mon, 21 Jan 2019 03:45:12 -0800 (PST)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id p1-v6sm4663904ejo.49.2019.01.21.03.45.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 03:45:11 -0800 (PST)
Date:   Mon, 21 Jan 2019 12:45:05 +0100
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
Message-ID: <20190121114505.GA7307@andrea>
References: <1547634429-772-1-git-send-email-elena.reshetova@intel.com>
 <CACT4Y+bWgcS=c=KrthWyyjjBpc72DEK-=czLYK8=SkmOsZ_-jg@mail.gmail.com>
 <CACT4Y+a6-YyrwZ9qX+yhhMuoPoZ5=B-NKxkn-EyFqijNBf4N+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+a6-YyrwZ9qX+yhhMuoPoZ5=B-NKxkn-EyFqijNBf4N+g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 10:52:37AM +0100, Dmitry Vyukov wrote:

[...]

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

Can't it fire in an SC world? (wrong example, or a Monday morning? ;D)


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
> 
> +more people knowledgeable in memory ordering
> 
> Unfortunately I can't find a way to reply to the
> Documentation/core-api/refcount-vs-atomic.rst patch review thread.
> 
> The refcount_dec_and_test guarantees look too weak to me, see the
> example above. Shouldn't refcount_dec_and_test returning true give the
> object in fully quiescent state? Why only control dependency? Loads
> can hoist across control dependency, no?

As you remarked, the doc. says CTRL+RELEASE (so yes, loads can hoist);
AFAICR, implementations do comply to this requirement.

(FWIW, I sometimes think at this "weird" ordering as a weak "acq_rel",
 the latter, acq_rel, being missing from the current APIs.)

 Andrea


> 
> 
> 
> > > Suggested-by: Kees Cook <keescook@chromium.org>
> > > Reviewed-by: David Windsor <dwindsor@gmail.com>
> > > Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
> > > Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> > > ---
> > >  kernel/kcov.c | 9 +++++----
> > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/kernel/kcov.c b/kernel/kcov.c
> > > index c2277db..051e86e 100644
> > > --- a/kernel/kcov.c
> > > +++ b/kernel/kcov.c
> > > @@ -20,6 +20,7 @@
> > >  #include <linux/debugfs.h>
> > >  #include <linux/uaccess.h>
> > >  #include <linux/kcov.h>
> > > +#include <linux/refcount.h>
> > >  #include <asm/setup.h>
> > >
> > >  /* Number of 64-bit words written per one comparison: */
> > > @@ -44,7 +45,7 @@ struct kcov {
> > >          *  - opened file descriptor
> > >          *  - task with enabled coverage (we can't unwire it from another task)
> > >          */
> > > -       atomic_t                refcount;
> > > +       refcount_t              refcount;
> > >         /* The lock protects mode, size, area and t. */
> > >         spinlock_t              lock;
> > >         enum kcov_mode          mode;
> > > @@ -228,12 +229,12 @@ EXPORT_SYMBOL(__sanitizer_cov_trace_switch);
> > >
> > >  static void kcov_get(struct kcov *kcov)
> > >  {
> > > -       atomic_inc(&kcov->refcount);
> > > +       refcount_inc(&kcov->refcount);
> > >  }
> > >
> > >  static void kcov_put(struct kcov *kcov)
> > >  {
> > > -       if (atomic_dec_and_test(&kcov->refcount)) {
> > > +       if (refcount_dec_and_test(&kcov->refcount)) {
> > >                 vfree(kcov->area);
> > >                 kfree(kcov);
> > >         }
> > > @@ -312,7 +313,7 @@ static int kcov_open(struct inode *inode, struct file *filep)
> > >         if (!kcov)
> > >                 return -ENOMEM;
> > >         kcov->mode = KCOV_MODE_DISABLED;
> > > -       atomic_set(&kcov->refcount, 1);
> > > +       refcount_set(&kcov->refcount, 1);
> > >         spin_lock_init(&kcov->lock);
> > >         filep->private_data = kcov;
> > >         return nonseekable_open(inode, filep);
> > > --
> > > 2.7.4
> > >
