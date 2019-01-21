Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A70CC2F3A6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514DD2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bKYauglH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfAUNWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:22:30 -0500
Received: from mail-io1-f47.google.com ([209.85.166.47]:38299 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbfAUNW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:22:29 -0500
Received: by mail-io1-f47.google.com with SMTP id l14so16340231ioj.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 05:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ViIwIisrts8lKS2nOKS8cQq7oIdtxCV2Zau1S1hVUx8=;
        b=bKYauglH3dvM2f450CRUZQGOfCefu32c+ygSYA5KVSS0UskvWRuixyn/Moj5QTLODl
         WTTiUVtcPtAjn5fpRt7lZmMRP1byOrxXOJ1UD0CDHO4rIdfX6qxvt7DVEWPThAye823o
         lyuWKyjb4o+anSBmy47vjjrL7/7r0JD4Abv48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ViIwIisrts8lKS2nOKS8cQq7oIdtxCV2Zau1S1hVUx8=;
        b=MmEr5cJeleaJoMCFzZJuoZqxQy5UUYWgxiEnqwIhhO7Wecd+Bc+7FAAhXTXOD+ekuQ
         BtQ6p7CGmINmwwcDI8mIzqUnA+eH9T0GnusPF4LaAEU0wTyb1SSn8Ml84iL0I0Jk2BvS
         /MViaeqdQq9UEHuA/XqDEwhGdXNsqfeO7PheHg0iVPEu8/xblBo8PqLLUtmZ1/xW6cxp
         aLureInswMooLSNg1FAcDzU+ycJCKrFE3Cb+I7p0RVJTo+DmjlSIlxUjxY2x+Jy0U4eO
         Z2loYdssCIdZw5tUuLxPPX2nw5eUK/oJqA8uWMKiMziQq9MWplUYThkNxjUrdY6rdoYS
         DBUQ==
X-Gm-Message-State: AJcUukeLjSUNYJ6J8D6BiCVH/E9H3VsNbZWC8xBpCu9GRnVZRJxdLhpM
        VorR77KSIWNtPc04x6B1hXOFs+HyPw+Wv74l2lMvfQ==
X-Google-Smtp-Source: ALg8bN7eBJpcSyu1NlfGq6SkziCeaLHMF/v2jLccuZxfYkPB5fx/f3RDkEE27IxmrZyPWlvGqIIBokhm/4wgatpwiP0=
X-Received: by 2002:a6b:c8c9:: with SMTP id y192mr15613351iof.183.1548076948669;
 Mon, 21 Jan 2019 05:22:28 -0800 (PST)
MIME-Version: 1.0
References: <tip-8d2ef665a9bbee36a2a9d855eb4e97d87953fee5@git.kernel.org> <20190121124752.GA17749@hirez.programming.kicks-ass.net>
In-Reply-To: <20190121124752.GA17749@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 21 Jan 2019 14:22:17 +0100
Message-ID: <CAKfTPtCJz2YDRirQ1JhrvtZMju-CkwzzxLk7JfMeGvVMKeScXA@mail.gmail.com>
Subject: Re: [tip:sched/core] sched/fair: Fix rounding bug for asym packing
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-tip-commits@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019 at 13:47, Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> Sorry guys, I seem to have messed this up :/
>
> Valentin pointed me out that I missed v3 and v4 of these patches; v3 got

I was about to sent an email about that too

> lost in the x-mas pile and v4 was actually on my todo list for this
> week, but I'd forgotten I'd already queued v2.
>
> I'll go queue delta patches.

Thanks

>
> On Mon, Jan 21, 2019 at 03:33:53AM -0800, tip-bot for Vincent Guittot wrote:
> > index 50aa2aba69bd..2ccd6e093326 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8190,6 +8190,12 @@ static inline void update_sg_lb_stats(struct lb_env *env,
> >       /* Adjust by relative CPU capacity of the group */
> >       sgs->group_capacity = group->sgc->capacity;
> >       sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) / sgs->group_capacity;
> > +     /*
> > +      * Prevent division rounding to make the computation of imbalance
> > +      * slightly less than original value and to prevent the rq to be then
> > +      * selected as busiest queue:
> > +      */
> > +     sgs->avg_load += 1;
> >
> >       if (sgs->sum_nr_running)
> >               sgs->load_per_task = sgs->sum_weighted_load / sgs->sum_nr_running;
>
>
