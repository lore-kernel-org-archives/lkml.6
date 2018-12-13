Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E747C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C950120870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HA61QUkE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C950120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbeLMPg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:36:27 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38791 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbeLMPg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 10:36:27 -0500
Received: by mail-it1-f195.google.com with SMTP id h65so4413044ith.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 07:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=32ZhPyu2hLO8paPnfPzkD4x4r1Dp+eAZ8wUUn8wLWls=;
        b=HA61QUkEBvIAtEtreXj15JVRAREb/TdrKCh4IlG80+xhoz9ClW/LXyK8jhzqGt+qms
         J5UzlfqQT2m8rDJeA4GwN2apmTMtnoFMacYRgr0tcLAEgJ3/pHWB4libUfNEXSI3OTtV
         d3tn77hLmNTr04QZN/0LhlQDuRZzJCV2mEspY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=32ZhPyu2hLO8paPnfPzkD4x4r1Dp+eAZ8wUUn8wLWls=;
        b=nAVPO6sWiN5tsy5l9CqoLI5g1b7nHbk0vNueAWZZyqkt6UnboW3VkLWq5h+93o7qMt
         95UypK2emVrdigFLEE+kOwd17m90vupCSrr1KY9VaCJuJCiMSNZ7i1PQzHv726cRcHFq
         XKXyJw4YiS9680YwJMVHhFjimXlPSY3Q8ajjFuemVSX6xCr36rjkp6WG/TPucDWGyPZm
         L6nOxKmmlDR6AUEQUzgFyx0fUfGcFZT2FzSpYATUBTI78LGlD6y5M6C15A/DCDbMEk7b
         d+PxXpdzXf0Ks1g4Qe1SBniAx05DfMEzfb8ec4TpZwrQpKT2XKghiTb3lh5kF25e0EUE
         mZsQ==
X-Gm-Message-State: AA+aEWaoIgYiTqNrjXORQwXet/BinSbp8JVxV85BzYSU4WkEPTUhTH+1
        AG2wdIX1aO7uHAJlK6ektUTZCcol0B51NIhe3veJXw==
X-Google-Smtp-Source: AFSGD/XlyDcZd+itS+JBLmueFV6UJP2bH7x2yKyyYuZRqme5gFnOFemU/DuaIebeovIgab8R1z2L/1DFgCaytkxDQe0=
X-Received: by 2002:a24:a20e:: with SMTP id j14mr10472142itf.14.1544715385675;
 Thu, 13 Dec 2018 07:36:25 -0800 (PST)
MIME-Version: 1.0
References: <1533657387-29039-1-git-send-email-vincent.guittot@linaro.org>
 <1533657387-29039-4-git-send-email-vincent.guittot@linaro.org> <20181213135208.GI5289@hirez.programming.kicks-ass.net>
In-Reply-To: <20181213135208.GI5289@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 13 Dec 2018 16:36:14 +0100
Message-ID: <CAKfTPtBXTmX1p0-QCVGh9OAt5Yc6sA-GNvNh4pFr00GJytSkAA@mail.gmail.com>
Subject: Re: [PATCH 3/3] sched/fair: fix unnecessary increase of balance interval
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

On Thu, 13 Dec 2018 at 14:52, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Aug 07, 2018 at 05:56:27PM +0200, Vincent Guittot wrote:
> > +static inline bool
> > +asym_active_balance(enum cpu_idle_type idle, unsigned int flags, int dst, int src)
> >  {
> > +     if (idle != CPU_NOT_IDLE) {
> >
> >               /*
> >                * ASYM_PACKING needs to force migrate tasks from busy but
> >                * lower priority CPUs in order to pack all tasks in the
> >                * highest priority CPUs.
> >                */
> > +             if ((flags & SD_ASYM_PACKING) &&
> > +                 sched_asym_prefer(dst, src))
> > +                     return true;
> >       }
> >
> > +     return false;
> > +}
> > +
> > +static int need_active_balance(struct lb_env *env)
> > +{
> > +     struct sched_domain *sd = env->sd;
> > +
> > +
> > +     if (asym_active_balance(env->idle, sd->flags, env->dst_cpu, env->src_cpu))
> > +             return 1;
> > +
> >       /*
> >        * The dst_cpu is idle and the src_cpu CPU has only 1 CFS task.
> >        * It's worth migrating the task if the src_cpu's capacity is reduced
> > @@ -8650,7 +8660,8 @@ static int load_balance(int this_cpu, struct rq *this_rq,
> >       } else
> >               sd->nr_balance_failed = 0;
> >
> > +     if (likely(!active_balance) ||
> > +         asym_active_balance(env.idle, sd->flags, env.dst_cpu, env.src_cpu)) {
>
> Perhaps like the below?

Yes. Far more simple and readable

>
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8857,21 +8857,24 @@ static struct rq *find_busiest_queue(str
>   */
>  #define MAX_PINNED_INTERVAL    512
>
> +static inline bool
> +asym_active_balance(struct lb_env *env)
> +{
> +       /*
> +        * ASYM_PACKING needs to force migrate tasks from busy but
> +        * lower priority CPUs in order to pack all tasks in the
> +        * highest priority CPUs.
> +        */
> +       return env->idle != CPU_NOT_IDLE && (env->sd->flags & SD_ASYM_PACKING) &&
> +               sched_asym_prefer(env->dst_cpu, env->src_cpu);
> +}
> +
>  static int need_active_balance(struct lb_env *env)
>  {
>         struct sched_domain *sd = env->sd;
>
> -       if (env->idle != CPU_NOT_IDLE) {
> -
> -               /*
> -                * ASYM_PACKING needs to force migrate tasks from busy but
> -                * lower priority CPUs in order to pack all tasks in the
> -                * highest priority CPUs.
> -                */
> -               if ((sd->flags & SD_ASYM_PACKING) &&
> -                   sched_asym_prefer(env->dst_cpu, env->src_cpu))
> -                       return 1;
> -       }
> +       if (asym_active_balance(env))
> +               return 1;
>
>         /*
>          * The dst_cpu is idle and the src_cpu CPU has only 1 CFS task.
> @@ -9150,7 +9153,7 @@ static int load_balance(int this_cpu, st
>         } else
>                 sd->nr_balance_failed = 0;
>
> -       if (likely(!active_balance)) {
> +       if (likely(!active_balance) || asym_active_balance(&env)) {
>                 /* We were unbalanced, so reset the balancing interval */
>                 sd->balance_interval = sd->min_interval;
>         } else {
