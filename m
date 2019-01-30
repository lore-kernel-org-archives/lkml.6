Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48A2C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8955F20882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gnZcDxhu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfA3Oaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:30:30 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:34300 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbfA3Oaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:30:30 -0500
Received: by mail-io1-f68.google.com with SMTP id b16so19552201ior.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 06:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wFNhHmZP8t/NvS9JyJpa4C+y4vIpeaMDeoiX2ferCxI=;
        b=gnZcDxhuPfkNmgHd73u17sEZH2y1ZnYe4/FFlvi+38ET4uFI8i/Rfx0KcVmMhN2wMn
         L4t9YEi7knEhgbxtq0XJFz67GnuPThCOhoQ4zfao4g6Tjyzx2aPV3pcKcV6B9Grnt5wx
         MjbExnaauYyJDk3N9b5P6HVuxyaV2/ApbTvIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wFNhHmZP8t/NvS9JyJpa4C+y4vIpeaMDeoiX2ferCxI=;
        b=Q7ZEkUrCQYdvikN1MSU1jZFZf3wLbFteZMMw1Xt6u7S4+daAAUdux1rGsuZhM8UQ9x
         inV4NijvOQZhoc6B8P5WNdkClNdiExfKrPVM5sbXFwQMe+wGvNa7kgLrtJaQ/7ck2sg8
         T7f6/LaGaQNZzZ1/ywIETJIK3I6gwHBU7zNuQ1xJVFReUOrOnrpqcAOTVKXUZTEC+Lbp
         83gwwGp3Jg4l64vd/++22FE1cs/zh9jfrADRt+7HwYXDQv5tfkN8zZxDOIEVuk84QYMX
         kSxTTu0LpT7Jm6aNZrPaH3xox2quB2x+Ee2IRfisTi07KVDn+MI79ovGCH+y/35XDVBy
         wmoQ==
X-Gm-Message-State: AJcUukeOcsSWUSETuPDd3cTMCmoKmwcb5GS4OnyETmtXeRoVJyeX1BmE
        p9FhiWCWIAZewvTTAmDfr1/FacyZYWKbJzQR2H8Rvg==
X-Google-Smtp-Source: ALg8bN76Flam7FFn6ZDjmYK3+1ioY1sKclO7dUr58pNVtqrKVj2L8VvuDeEBaxP+ym3JspQXrmfwZXthF4wa6Lou/88=
X-Received: by 2002:a6b:6b02:: with SMTP id g2mr17177026ioc.18.1548858629211;
 Wed, 30 Jan 2019 06:30:29 -0800 (PST)
MIME-Version: 1.0
References: <1548782332-18591-1-git-send-email-vincent.guittot@linaro.org>
 <1548825767-10799-1-git-send-email-vincent.guittot@linaro.org> <20190130140104.GB2296@hirez.programming.kicks-ass.net>
In-Reply-To: <20190130140104.GB2296@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 30 Jan 2019 15:30:18 +0100
Message-ID: <CAKfTPtAAoXiFhL6SE1WvM7U5ZJodcPDuT_meL6uPbV9LYDAZbw@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Fix insertion in rq->leaf_cfs_rq_list
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Sargun Dhillon <sargun@sargun.me>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2019 at 15:01, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jan 30, 2019 at 06:22:47AM +0100, Vincent Guittot wrote:
> > Sargun reported a crash:
> >   "I picked up c40f7d74c741a907cfaeb73a7697081881c497d0 sched/fair: Fix
> >    infinite loop in update_blocked_averages() by reverting a9e7f6544b9c
> >    and put it on top of 4.19.13. In addition to this, I uninlined
> >    list_add_leaf_cfs_rq for debugging.
> >
> >    This revealed a new bug that we didn't get to because we kept getting
> >    crashes from the previous issue. When we are running with cgroups that
> >    are rapidly changing, with CFS bandwidth control, and in addition
> >    using the cpusets cgroup, we see this crash. Specifically, it seems to
> >    occur with cgroups that are throttled and we change the allowed
> >    cpuset."
> >
> > The algorithm used to order cfs_rq in rq->leaf_cfs_rq_list assumes that
> > it will walk down to root the 1st time a cfs_rq is used and we will finish
> > to add either a cfs_rq without parent or a cfs_rq with a parent that is
> > already on the list. But this is not always true in presence of throttling.
> > Because a cfs_rq can be throttled even if it has never been used but other CPUs
> > of the cgroup have already used all the bandwdith, we are not sure to go down to
> > the root and add all cfs_rq in the list.
> >
> > Ensure that all cfs_rq will be added in the list even if they are throttled.
> >
> > Reported-by: Sargun Dhillon <sargun@sargun.me>
> > Fixes: 9c2791f936ef ("Fix hierarchical order in rq->leaf_cfs_rq_list")
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> Given my previous patch; how about something like so instead?

I still have to run some tests but this looks good to me

>
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -282,13 +282,15 @@ static inline struct cfs_rq *group_cfs_r
>         return grp->my_q;
>  }
>
> -static inline void list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
> +static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
>  {
>         struct rq *rq = rq_of(cfs_rq);
>         int cpu = cpu_of(rq);
>
>         if (cfs_rq->on_list)
> -               return;
> +               return rq->tmp_alone_branch == &rq->leaf_cfs_rq_list;
> +
> +       cfs_rq->on_list = 1;
>
>         /*
>          * Ensure we either appear before our parent (if already
> @@ -315,7 +317,10 @@ static inline void list_add_leaf_cfs_rq(
>                  * list.
>                  */
>                 rq->tmp_alone_branch = &rq->leaf_cfs_rq_list;
> -       } else if (!cfs_rq->tg->parent) {
> +               return true;
> +       }
> +
> +       if (!cfs_rq->tg->parent) {
>                 /*
>                  * cfs rq without parent should be put
>                  * at the tail of the list.
> @@ -327,23 +332,22 @@ static inline void list_add_leaf_cfs_rq(
>                  * tmp_alone_branch to the beginning of the list.
>                  */
>                 rq->tmp_alone_branch = &rq->leaf_cfs_rq_list;
> -       } else {
> -               /*
> -                * The parent has not already been added so we want to
> -                * make sure that it will be put after us.
> -                * tmp_alone_branch points to the begin of the branch
> -                * where we will add parent.
> -                */
> -               list_add_rcu(&cfs_rq->leaf_cfs_rq_list,
> -                       rq->tmp_alone_branch);
> -               /*
> -                * update tmp_alone_branch to points to the new begin
> -                * of the branch
> -                */
> -               rq->tmp_alone_branch = &cfs_rq->leaf_cfs_rq_list;
> +               return true;
>         }
>
> -       cfs_rq->on_list = 1;
> +       /*
> +        * The parent has not already been added so we want to
> +        * make sure that it will be put after us.
> +        * tmp_alone_branch points to the begin of the branch
> +        * where we will add parent.
> +        */
> +       list_add_rcu(&cfs_rq->leaf_cfs_rq_list, rq->tmp_alone_branch);
> +       /*
> +        * update tmp_alone_branch to points to the new begin
> +        * of the branch
> +        */
> +       rq->tmp_alone_branch = &cfs_rq->leaf_cfs_rq_list;
> +       return false;
>  }
>
>  static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
> @@ -4999,6 +5003,12 @@ static void __maybe_unused unthrottle_of
>  }
>
>  #else /* CONFIG_CFS_BANDWIDTH */
> +
> +static inline bool cfs_bandwidth_used(void)
> +{
> +       return false;
> +}
> +
>  static inline u64 cfs_rq_clock_task(struct cfs_rq *cfs_rq)
>  {
>         return rq_clock_task(rq_of(cfs_rq));
> @@ -5190,6 +5200,21 @@ enqueue_task_fair(struct rq *rq, struct
>
>         }
>
> +       if (cfs_bandwidth_used()) {
> +               /*
> +                * When bandwidth control is enabled; the cfs_rq_throttled()
> +                * breaks in the above iteration can result in incomplete
> +                * leaf list maintenance, resulting in triggering the assertion
> +                * below.
> +                */
> +               for_each_sched_entity(se) {
> +                       cfs_rq = cfs_rq_of(se);
> +
> +                       if (list_add_leaf_cfs_rq(cfs_rq))
> +                               break;
> +               }
> +       }
> +
>         assert_list_leaf_cfs_rq(rq);
>
>         hrtick_update(rq);
