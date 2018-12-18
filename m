Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A85FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016B0217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PUwwpP58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbeLRIR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:17:57 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36872 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeLRIR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:17:57 -0500
Received: by mail-it1-f196.google.com with SMTP id b5so3073501iti.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 00:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VspT+YoGe1b2wOtJh/49PGdGjBXvbYgklkIjG+r7qLk=;
        b=PUwwpP58gsHb54vfXnh9Gq+m7zlhL4cXPju/w7oeBII2Wjiwfctdlt56bN+pKrerow
         rLhM1dVAhSDdStqpgBH4qznvYOynmFXNo5ASogYgl6kOJIzgmFDhCw6y8JtA2LxyObiC
         Jhi7VSpFmbyCZUjA9kTR3Z+tUmCzypUphtX18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VspT+YoGe1b2wOtJh/49PGdGjBXvbYgklkIjG+r7qLk=;
        b=ZuJtEPZD9CD5iBmHIiAW8Wt1zfFHUCNXONwziUK9qmp1fOeEOIHepuYJl09ARKR/By
         cFTYzgvit89if7YML6S7gzlyqtTN5/AqpjUk2FrAVlh9qW1PRNTnFAUfjZXTlsRncFDi
         bQMMUKy21S+81QNtgqbiUR9lMhyewBjBA7QHe/sQa1xSukpB4jH0RiaEzMAcBFlcIteU
         zLPSKtrzn7HC3+4M8NlzNT9rHCrzHa9nHWjooMWiRiNN0Jt04fRZlsmdFXx8+HJfRo4x
         /K6qzfx2Zmy9IN943nsAcxX+sPvPYZc4LQfvkmv/ppf8lsKp+dfOe4PkEUtZLRSi+Ddo
         rlyQ==
X-Gm-Message-State: AA+aEWYC7UQzuIoBezhpdnLcdQWYn3C18XFPdjEzDfqCcbyKwnSyYW3R
        ln0W/8qzz5zkLQUlUiYI959kIjNv+Okx9yiyHboJ8QnahjZfkg==
X-Google-Smtp-Source: AFSGD/Uzc9sBUEwoD88UnlWEzWzGh3WIgnoKiiggAwwHONo8dB81ZOrglIvM2qW3gv7nxiu5P4jP+AINuKyGXudixGU=
X-Received: by 2002:a05:660c:a8f:: with SMTP id m15mr2018652itk.114.1545121076027;
 Tue, 18 Dec 2018 00:17:56 -0800 (PST)
MIME-Version: 1.0
References: <1544803317-7610-1-git-send-email-vincent.guittot@linaro.org>
 <1544803317-7610-3-git-send-email-vincent.guittot@linaro.org> <ff8844de-8dd7-c5b8-a90e-e15899d081af@arm.com>
In-Reply-To: <ff8844de-8dd7-c5b8-a90e-e15899d081af@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 18 Dec 2018 09:17:44 +0100
Message-ID: <CAKfTPtDKy07v6YUgz1fegTtsg_K-AcbU+t7y5wFQaTu0TK+_fA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] sched/fair: trigger asym_packing during idle load balance
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 at 17:59, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> Hi Vincent,
>
> On 14/12/2018 16:01, Vincent Guittot wrote:
> > newly idle load balance is not always triggered when a cpu becomes idle.
> > This prevent the scheduler to get a chance to migrate task for asym packing.
> > Enable active migration because of asym packing during idle load balance too.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index c215f7a..9591e7a 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8861,7 +8861,7 @@ static int need_active_balance(struct lb_env *env)
> >  {
> >       struct sched_domain *sd = env->sd;
> >
> > -     if (env->idle == CPU_NEWLY_IDLE) {
> > +     if (env->idle != CPU_NOT_IDLE) {
> >
> >               /*
> >                * ASYM_PACKING needs to force migrate tasks from busy but
> >
>
> That change looks fine. However, you're mentioning newidle load_balance()
> not being triggered - you'd want to set root_domain->overload for any
> newidle pull to happen, probably with something like this:

It's not needed in this case because the dst cpu is already the target
cpu and the migration will happen during this idle load balance.
Setting root_domain->overload is useful only if you want another cpu
to pull the task during another coming load_balance (newly or normal
idle ones) which is not the case here.

>
> -----8<-----
> @@ -8398,6 +8408,9 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>                 sg = sg->next;
>         } while (sg != env->sd->groups);
>
> +       if (check_asym_packing(env, sds))
> +               sg_status |= SG_OVERLOAD;
> +
>  #ifdef CONFIG_NO_HZ_COMMON
>         if ((env->flags & LBF_NOHZ_AGAIN) &&
>             cpumask_subset(nohz.idle_cpus_mask, sched_domain_span(env->sd))) {
> ----->8-----
>
> It's similar to what is done for misfit, although that's yet another
> 'twisted' use of that flag which we might want to rename (I suggested
> something like 'need_idle_balance' a while back but it wasn't really
> popular).
