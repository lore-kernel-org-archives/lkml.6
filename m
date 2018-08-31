Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D48C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA2A20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CqOEwXME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA2A20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbeHaSxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:53:14 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37689 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbeHaSxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:53:14 -0400
Received: by mail-io0-f196.google.com with SMTP id v14-v6so10610152iob.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 07:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Qz8Kz1wIUkVJsNPiip3hX8FZFk4JWKS58U7cHDxgPo=;
        b=CqOEwXMEQxpWYhg20f21rc7QCPySzEoziwXqW03BHd/KA4ubvD+HWI/s5D9bDj2lsr
         ngjSsYnNyABNRZDA7L+qAReVeeilRQFtpq4shLDkqgmq94w2qZMAavIQlnKyH2aRMi7Q
         593iTcGcl5kR+atSxy9EYAJyLF/P3LuAM53YU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Qz8Kz1wIUkVJsNPiip3hX8FZFk4JWKS58U7cHDxgPo=;
        b=TbKesHyyBbEXoc6dfGT0gJDP/sFTGf7y4AhrrkklnwvwEtyqhTZ0LHfEbBO8wx+2Fp
         ReL9UfnVRu76rp0AvcQCzxOW6HFjT+cdGEPfMtrLNLsxQUC+OMY1vOLUYPCQ7HyW72R6
         3TpPPlxdZYllmd5sVdDoreksoUvqHWL3uLL4Ickarn8qMh7FmcVSepE05u+8h82Qnnmz
         m9VctamaELjwROFKbsmadItQIbxh3qrGmwkH+K9BmNAXT8YhIZ3L53dB1fK3HOMELy1M
         Rq6wfTfMU/4jokBYqHAXNsdBYrPoca2WzztkEnmA53Qr4QGn/uVj6a0RvjBv78WFBQQp
         bSrQ==
X-Gm-Message-State: APzg51BuQ9fYxngARWO4iAdua2FeSLODbxBQAwNXdISoROTGkk9ftina
        OJAvYnux6xfLHJ7O45TWuLNgN+xeAsuBjoSFjGoXdg==
X-Google-Smtp-Source: ANB0VdZLRMRm9sZSPdfukCJMDAAt+f59Zu7Ngo0hkAbCnhoeO6eijzqtDf1GizrtWbVnvvtVxSPEW220yY2agk4gFps=
X-Received: by 2002:a6b:ea0a:: with SMTP id m10-v6mr12576590ioc.18.1535726724466;
 Fri, 31 Aug 2018 07:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <1535723908-10779-1-git-send-email-vincent.guittot@linaro.org> <20180831144146.GO24124@hirez.programming.kicks-ass.net>
In-Reply-To: <20180831144146.GO24124@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 31 Aug 2018 16:45:13 +0200
Message-ID: <CAKfTPtBPmQBtq5xvpVP59X4OqQcodTpT2djqVWKeW8X-CkhwOA@mail.gmail.com>
Subject: Re: [PATCH] sched/pelt: fix update_blocked_averages() for dl and rt
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Aug 2018 at 16:41, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Aug 31, 2018 at 03:58:28PM +0200, Vincent Guittot wrote:
> > update_blocked_averages() is called to periodiccally decay the stalled load
> > of idle CPUs and to sync all loads before running load balance.
> >
> > When cfs rq is idle, it trigs a load balance during pick_next_task_fair()
> > in order to potentially pull tasks and to use this newly idle CPU. This
> > load balance happens whereas prev task from another class has not been put
> > and its utilization updated yet. This may lead to wrongly account running
> > time as idle time for rt or dl classes.
> >
> > Test that no rt or dl task is running when updating their utilization in
> > update_blocked_averages().
> >
> > We still update rt and dl utilization instead of simply skipping them to
> > make sure that all metrics are synced when used during load balance.
> >
>
> Fixes: 371bf4273269 ("sched/rt: Add rt_rq utilization tracking")
> Fixes: 3727e0e16340 ("sched/dl: Add dl_rq utilization tracking")
>
> Right?

Yes

>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 309c93f..a1babaf 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7262,6 +7262,7 @@ static void update_blocked_averages(int cpu)
> >  {
> >       struct rq *rq = cpu_rq(cpu);
> >       struct cfs_rq *cfs_rq, *pos;
> > +     const struct sched_class *curr_class = rq->curr->sched_class;
> >       struct rq_flags rf;
> >       bool done = true;
> >
> > @@ -7298,8 +7299,8 @@ static void update_blocked_averages(int cpu)
> >               if (cfs_rq_has_blocked(cfs_rq))
> >                       done = false;
> >       }
> > -     update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
> > -     update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
> > +     update_rt_rq_load_avg(rq_clock_task(rq), rq, curr_class == &rt_sched_class);
> > +     update_dl_rq_load_avg(rq_clock_task(rq), rq, curr_class == &dl_sched_class);
> >       update_irq_load_avg(rq, 0);
> >       /* Don't need periodic decay once load/util_avg are null */
> >       if (others_have_blocked(rq))
>
> Did you forget to update the second implementation of
> update_blocked_averages() ?

Yes. I have sent this version to quickly.
I'm going to send an update
