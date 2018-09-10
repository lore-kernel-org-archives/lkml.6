Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8B1C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A2420833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V5TBTK4d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A2420833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbeIJTQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:16:47 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:45359 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbeIJTQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:16:47 -0400
Received: by mail-io0-f194.google.com with SMTP id e12-v6so741984iok.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 07:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=60r9U3XXXbtkSBdILfHjvqYhBzSX6HxPDc0Av1lx2Vc=;
        b=V5TBTK4dTlGXthIGB1hdMIkIssd1nRORlg06uOYSZ1eLqfhU3BC4J8hQbmZP9/XUmS
         ikKxD64FRDd1/BgIMyeB/HAVuEHm5ok1SRVLlaafTsrJFKCFwtDcX3gTzSCVbaxYM7zt
         uvHdpVksu1XezIpmo5gfemJbI2joCc1tp7tmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=60r9U3XXXbtkSBdILfHjvqYhBzSX6HxPDc0Av1lx2Vc=;
        b=q/F+saAongvr+wYQAcCUgdPGXilq3qzmMorICCoIEm0yfwTqZomagUh6tsU3KxS26I
         VVnZXwtUGxvQPDDIvOZNessoEAh6INUVzW0wCDM5jy3KIuA7W4UzZnE7VpKdwUmAYOY8
         UYDysy4myLyNVnYWyoJJvRrw2qqnxAuCyAPZ/ArHe9vv/1jQaO1AHC7P98BSFx3Q0oZs
         EtQ4t5zF9aUK9AA/BzU+i2PXYswatcaFSoyLL+TSuAOhX93LWhiMiYv2hBiK4+mafK2i
         pwAlQGgTUoOZtLm/UBwrxTUQsljGj2ZfGq/pVOborQQNgsGl8OB6C9XZAUzcSuGdseGG
         OkHw==
X-Gm-Message-State: APzg51AJvtevrAunyZOqBUtembytelHxC1wLx/HF3X4ys4+E4L3fNAzq
        iKcQcGRjCTllKuhm8+OTnz0D2veAag0zwnXUg7MyEA==
X-Google-Smtp-Source: ANB0VdZ70qhjgJgCcZs79+5KRUpwRO3Geyd1OXmy45Ma+wXEug8DZ51+DftSAjZahKAr8wYtnAiQKXSoGQiBhexdo6g=
X-Received: by 2002:a5e:8a0a:: with SMTP id d10-v6mr15825715iok.183.1536589346781;
 Mon, 10 Sep 2018 07:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <1536334803-21059-1-git-send-email-vincent.guittot@linaro.org> <60ace509-8a90-f8eb-3d22-a5be6e3d863a@arm.com>
In-Reply-To: <60ace509-8a90-f8eb-3d22-a5be6e3d863a@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 10 Sep 2018 16:22:15 +0200
Message-ID: <CAKfTPtBpEkEmWGX=HUEygTg0jWX_-rTFXSgwhBWULM6LDvP44Q@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: fix 1 task per CPU
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Sep 2018 at 22:17, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> Hi Vincent,
>
> On 07/09/18 08:40, Vincent Guittot wrote:
> > When CPUs have different capacity because of RT/DL tasks or
> > micro-architecture or max frequency differences, there are situation where
> > the imbalance is not correctly set to migrate waiting task on the idle CPU.
> >
>
> This is essentially always for down migrations (high capacity src CPU to lower
> capacity dst CPU), right?

At least for the UC that I have created

>
> For instance, I've often seen that issue on HiKey960 (4x4 big.LITTLE) where
> if you spawn 8 CPU-hogs you can end up with 5 on the bigs and 3 on the
> LITTLES, but since avg_load scales with the inverse of group_capacity it's
> seen as balanced. I don't recall seeing this problem for low capacity ->
> big capacity migration, especially with the misfit logic that makes this a
> non-problem.
>
> Also, a nit on the commit header: although we've called it "1 task per CPU"
> in the past, it might be more explicit to call it "1 long running task per
> CPU", if just for the sake of clarity for people not directly involved in
> our previous discussions.

In fact it's not only long running task, I can reproduce the problem
with 1 task with a load of 30%

The problem comes from busiest->avg_load <= sds->avg_load ||
local->avg_load >= sds->avg_load

>
> > The UC uses the force_balance case :
> >       if (env->idle != CPU_NOT_IDLE && group_has_capacity(env, local) &&
> >           busiest->group_no_capacity)
> >               goto force_balance;
> >
> > But calculate_imbalance fails to set the right amount of load to migrate
> > a task because of the special condition:
> >   busiest->avg_load <= sds->avg_load || local->avg_load >= sds->avg_load)
> >
> > Add in fix_small_imbalance, this special case that triggered the force
> > balance in order to make sure that the amount of load to migrate will be
> > enough.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
>
> So we happen to have come up with a (relatively) similar patch for Android
> (see [1]) which also stemmed from the 1 always running task per CPU issue. It
> only applies to SD_ASYM_CPUCAPACITY sched domains though, and targets
> down-migrations (local->group_capacity < busiest->group_capacity).
>
> I'd argue that we should make it so this kind of imbalance gets detected way
> before we hit fix_small_imbalance(), but until we get there I think we do want
> an extra condition like this.
>
> >  kernel/sched/fair.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 309c93f..57b4d83 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8048,6 +8048,20 @@ void fix_small_imbalance(struct lb_env *env, struct sd_lb_stats *sds)
> >       local = &sds->local_stat;
> >       busiest = &sds->busiest_stat;
> >
> > +     /*
> > +      * There is available capacity in local group and busiest group is
> > +      * overloaded but calculate_imbalance can't compute the amount of load
> > +      * to migrate because they became meaningless because asymetric
>
> What do you mean by 'they'?

The loads

>
> Also, s/because/due to/ on the second "because".

ok

>
> > +      * capacity between group. In such case, we only want to migrate at
> > +      * least one tasks of the busiest group and rely of the average load
> > +      * per task to ensure the migration.
> > +      */
> > +     if (env->idle != CPU_NOT_IDLE && group_has_capacity(env, local) &&
> > +         busiest->group_no_capacity) {
> > +             env->imbalance = busiest->load_per_task;
> > +             return;
> > +     }
> > +
>
> The condition is an exact copy of the one in that goto force_balance
> path you mention (in find_busiest_group()), is that just a coincidence? If

it's not a coincidence, it's to catch what have been missed by
calculate_imbalance

> not you might want to mention it in the comment.
>
> >       if (!local->sum_nr_running)
> >               local->load_per_task = cpu_avg_load_per_task(env->dst_cpu);
> >       else if (busiest->load_per_task > local->load_per_task)
> >
>
> [1]: https://android.googlesource.com/kernel/common/+/9fae72e924961f3b32816193fcb56d19c1f644c2%5E%21/#F0
