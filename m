Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EB7C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6B5208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h0q2L6IP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C6B5208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbeLMLEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 06:04:33 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:43704 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbeLMLEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 06:04:32 -0500
Received: by mail-io1-f65.google.com with SMTP id l3so1223050ioc.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 03:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=enYweZX3f/WdB3dmT0wulTDSB51hPA+7xIs7b/pAhuU=;
        b=h0q2L6IPMB/FZ9FngJ4jR6Cb3dfk8WHRyZeOpb+5QomPz4XS/qc5sdLYCsWjEw/BQE
         Jw6AsvvpsVQfxoxxPrOjGOOxxrtYczMoZUoujN/GBT9KZZQ/C8YktQokiWECFOEjZO43
         5ZtP75ZA86PrleEPxbLVj3WUTCOU+0iB5ojxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=enYweZX3f/WdB3dmT0wulTDSB51hPA+7xIs7b/pAhuU=;
        b=rX2i72UktDOBLNtf0CJ6Fo8Hm9edvaM5eW4hS+STJaq6GTE5cCiZQ6moz1eHFspIc4
         ChfQmEyML7KfLtGlY5NQyk6K/D+fBemU5Fiu79FtKhATW3msqN1tRqGQs30zphEyMrZP
         axGNZdc/HDKHoUxm9BFOdzB6WwMnxeuDhMTW3kbtkm2C6K24nvcXYBIz5mD0khbrRIHo
         VMcra6WHGSbewpUjGTCd5N1zY9dv9rEeUitRspG+5q+Vw6YO5ALCbJpUyLS5k3ndzmNa
         NTE107N9gJclmpvAheKQp2RW5eOkLk3dNkfn4vjjc65LkNZWW8ZuilCc8W7dAbq8Ifzu
         RmZQ==
X-Gm-Message-State: AA+aEWYP57YvXgZ1Gz23fNjYWWzJO/U3sGF+sU7HZn3jfcbOtAfxobsj
        21+znBPypskI6xfdvyGGWZ2rcwvG+qVH6OFgdZiVfA==
X-Google-Smtp-Source: AFSGD/WGdgTaGEt7oOXJiQlNjZqFNBl/Gdz/XTvE1B4kN875RD5rA8ghHeOSBrbvnO0s/iNsPtDJNFMuKqxEPHOph0U=
X-Received: by 2002:a6b:6b15:: with SMTP id g21mr6674854ioc.18.1544699071103;
 Thu, 13 Dec 2018 03:04:31 -0800 (PST)
MIME-Version: 1.0
References: <1536590589-437-1-git-send-email-vincent.guittot@linaro.org> <20181213104439.GG5289@hirez.programming.kicks-ass.net>
In-Reply-To: <20181213104439.GG5289@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 13 Dec 2018 12:04:20 +0100
Message-ID: <CAKfTPtBG_gcWzi4RUWF_c2aazqxDPHbb2rGWHvWND6pQHQxPGw@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: fix 1 task per CPU
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 at 11:44, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Sep 10, 2018 at 04:43:09PM +0200, Vincent Guittot wrote:
> > When CPUs have different capacity because of RT/DL tasks or
> > micro-architecture or max frequency differences, there are situation where
> > the imbalance is not correctly set to migrate waiting task on the idle CPU.
> >
> > The UC uses the force_balance case:
> >
> >       if (env->idle != CPU_NOT_IDLE && group_has_capacity(env, local) &&
> >           busiest->group_no_capacity)
> >               goto force_balance;
> >
> > But calculate_imbalance fails to set the right amount of load to migrate
> > a task because of the special condition:
> >
> >   busiest->avg_load <= sds->avg_load || local->avg_load >= sds->avg_load)
> >
> > Add in fix_small_imbalance, this special case that triggered the force
> > balance in order to make sure that the amount of load to migrate will be
> > enough.
>
> So I think this patch is going in the wrong direction for a number of
> reasons:
>
>  - we'd like to get rid of fix_small_imbalance(), and this adds to it;
>
>  - the whole load_per_task stuff is terminally broken, it _cannot_ work
>    right.
>
>
> What I've suggested in the past is parameterizing the load balancer and
> picking different criteria to balance on:

This patch is clearly a fix of the current implementation.
What you suggest below makes sense but implies a significant rework in
the calculate_imbalance and the load_balancer in general and will need
more time to reach a stable state.
Nevertheless, I will have a look at that

I imagine that your feedback for https://lkml.org/lkml/2018/10/2/283
will be the same ?

Vincent

>
>  - nr_running ; if there are idle CPUs around
>  - utilization ; if there's idle time (u<1)
>  - weight
>
> And I suppose you're hitting one of the nr_running cases here.
>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 309c93f..72bc5e8 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8048,6 +8048,20 @@ void fix_small_imbalance(struct lb_env *env, struct sd_lb_stats *sds)
> >       local = &sds->local_stat;
> >       busiest = &sds->busiest_stat;
> >
> > +     /*
> > +      * There is available capacity in local group and busiest group is
> > +      * overloaded but calculate_imbalance can't compute the amount of load
> > +      * to migrate because load_avg became meaningless due to asymetric
> > +      * capacity between groups. In such case, we only want to migrate at
> > +      * least one tasks of the busiest group and rely of the average load
> > +      * per task to ensure the migration.
> > +      */
> > +     if (env->idle != CPU_NOT_IDLE && group_has_capacity(env, local) &&
> > +         busiest->group_no_capacity) {
> > +             env->imbalance = busiest->load_per_task;
> > +             return;
> > +     }
> > +
> >       if (!local->sum_nr_running)
> >               local->load_per_task = cpu_avg_load_per_task(env->dst_cpu);
> >       else if (busiest->load_per_task > local->load_per_task)
> > --
> > 2.7.4
> >
