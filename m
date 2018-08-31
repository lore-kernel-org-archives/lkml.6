Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FDCC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D9120661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kZHJQdqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0D9120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbeHaTS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:18:29 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:41142 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbeHaTS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:18:28 -0400
Received: by mail-io0-f193.google.com with SMTP id q4-v6so10681405iob.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 08:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=78x1/SsFnvjMX5zWP++UiE5EOBVvjBzjxfzgfu0peLw=;
        b=kZHJQdqK9droyN1u1gUmKX0BBLs4M273hx8QA1MAqySq5CYVGj7y06o++u5CTXoIwD
         JdvblK3AxxjcfYluqYwXs5dwXI+bGjyNUVxX3SJFKFvxVXF5JGKtRAVFLupRtKgc1g7v
         JqGsbOJhA8D2Q/6VAe49iUqWGvVIlNv1k2ZiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=78x1/SsFnvjMX5zWP++UiE5EOBVvjBzjxfzgfu0peLw=;
        b=Ek+XziyQcznm6yGE77xnkcTUkyghkYIHHS23LNGgmy3JhBHA+B1dDBCUhsgbTnB3V0
         JeuWe49Xecg5EhAhzkq91ZZewsUTp7gN+fHCXRz3Pav6QHygpRLFgo0wfgbNpVU04HP+
         gRXw6g+wRKZXISFEUvPUwqQIV1FF91fQPE+FV1bkcGKkjo28lqsqM5pl07ErWG4K4Pt6
         cGJBCBHubgiQYybOWrqdu0YAGUnrmh5xIKxiQ2mL/3IViOiZk5+jM6r7BSgTR5CGaFL6
         zQ2K1ipBZ76fM6ay/ca8WnBk7IUYMrPk/bDrXhiioZQxw5SIK8fJdDr799+Ey23GFKJ3
         meGw==
X-Gm-Message-State: APzg51BYo4+A8xxuxxjmJ5TSX/izTs6DS65GTS6UdCNMsvl5316+uBWx
        R6nuGABqr31HQU03xj6w6gbvTBduMJ+DcCKvH9UMXQ==
X-Google-Smtp-Source: ANB0VdYYwC0BMPO5v8oPQFNDJpySJfipl4GKuiIEF635biY1saBUKnuaFuwGJ0lfHDJfnOp7km5qm19++X4whV/ppv0=
X-Received: by 2002:a5e:8a0a:: with SMTP id d10-v6mr11807518iok.183.1535728232764;
 Fri, 31 Aug 2018 08:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <1535727379-17133-1-git-send-email-vincent.guittot@linaro.org> <20180831150721.GP24124@hirez.programming.kicks-ass.net>
In-Reply-To: <20180831150721.GP24124@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 31 Aug 2018 17:10:21 +0200
Message-ID: <CAKfTPtBRsZcmZ-=QXWhkL55NsONi=GAxOeu3zPkTvwfnHZsLUw@mail.gmail.com>
Subject: Re: [PATCH v2] sched/pelt: fix update_blocked_averages() for dl and rt
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Aug 2018 at 17:07, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Aug 31, 2018 at 04:56:19PM +0200, Vincent Guittot wrote:
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 309c93f..bc1de21 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7262,6 +7262,7 @@ static void update_blocked_averages(int cpu)
> >  {
> >       struct rq *rq = cpu_rq(cpu);
> >       struct cfs_rq *cfs_rq, *pos;
> > +     const struct sched_class *curr_class = rq->curr->sched_class;
> >       struct rq_flags rf;
> >       bool done = true;
>
> Can you do me a v3 where you move that rq->curr dereference under the
> rq->lock?

Yes.
sorry for all these versions
>
> I _think_ it is actually OK, but it is really dodgy. Moving it under
> rq->lock makes it obvious correct.
>
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
