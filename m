Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D028C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D36620823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KCAZS5fw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfARKQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:16:50 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:53796 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfARKQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:16:50 -0500
Received: by mail-it1-f193.google.com with SMTP id g85so5982565ita.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 02:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0BABuzf4eLF/Sys6BG70N5bjxP6oWcLe5vbKBA8OU2U=;
        b=KCAZS5fwkuuIzWDxeoXeoqlGdP8tvbXBXM5BQgDqARV5RkJfu5oMElAEGCs7dCekpf
         4v2V8s1oIrSB69+DutqUmYobyCma4edGrU6mYgRv/0yPJjzQX8ClwHcmp0iM2KXFbsv4
         6WOzWMWVO6yrlPaNXGISO8TSjmkZbmTIG+N74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0BABuzf4eLF/Sys6BG70N5bjxP6oWcLe5vbKBA8OU2U=;
        b=N4a45LVnrnCCK00u9OBrM97x4mXtRVS2cysOgiK9eqN3l6gFA4xjd4f/4vzYcEHbyF
         0k+DjinlWTyN5H/UjD5RVqBSKrSjpSpqbrZ6xKnBCo/enkC2BHrcGPyJJaazRed6Qeak
         cD3tB9HMdDtHpl30qaFN7xjlOw6/7NO1ei3iV31g5URvBtqw+YDy3w3UDl5roCiUALmg
         RJdPWAKR0iiRt2CfGT6zN6VmszRSXC/DC83n3a51PiHUs8JUBOjibL+xmeq0QvbPguIB
         huUQIZadzORqxQJLeq42l7MCgAq04mOhN1Ml6zre1srbo1xPZxBHr1P8eh4ZjH+n3vMT
         myBg==
X-Gm-Message-State: AJcUukcLTAtJBt4obHcnB4v8A1pWYdX0MstQnJZgJk1HfnSfn8W+AnHD
        ezv37WCaqpfSL7Q8zt194v9E4/vaI5zQp33q9Poy/A==
X-Google-Smtp-Source: ALg8bN7UWp8K93GnpjrA6oD+5KlBkt4WjmFZq7c6Xer3qw+Tjqy1fx+ECoDBi0Uqls5xPIRmXQiueu3lGRNQzUu/aIA=
X-Received: by 2002:a02:6019:: with SMTP id i25mr10692804jac.137.1547806609265;
 Fri, 18 Jan 2019 02:16:49 -0800 (PST)
MIME-Version: 1.0
References: <CAMp4zn-w8y7ubvWoqTGSUycFJTd9ir5OikE9F4TiM_FtG4XdXQ@mail.gmail.com>
 <CAMp4zn-jZj9uLwfvM5uVm5hVPKYbu4FLNwD9g-xnbhmVqN1cZw@mail.gmail.com>
In-Reply-To: <CAMp4zn-jZj9uLwfvM5uVm5hVPKYbu4FLNwD9g-xnbhmVqN1cZw@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 18 Jan 2019 11:16:38 +0100
Message-ID: <CAKfTPtDkrf6YjrgQVgm52DAB9EWQe3q5BZZCvzm9g4k=BjCEUw@mail.gmail.com>
Subject: Re: Crash in list_add_leaf_cfs_rq due to bad tmp_alone_branch
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Gabriel Hartmann <ghartmann@netflix.com>,
        gabriel.hartmann@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2019 at 23:43, Sargun Dhillon <sargun@sargun.me> wrote:
>
> On Wed, Jan 9, 2019 at 2:14 PM Sargun Dhillon <sargun@sargun.me> wrote:
> >
> > I picked up c40f7d74c741a907cfaeb73a7697081881c497d0 sched/fair: Fix
> > infinite loop in update_blocked_averages() by reverting a9e7f6544b9c
> > and put it on top of 4.19.13. In addition to this, I uninlined
> > list_add_leaf_cfs_rq for debugging.
> >
> > This revealed a new bug that we didn't get to because we kept getting
> > crashes from the previous issue. When we are running with cgroups that
> > are rapidly changing, with CFS bandwidth control, and in addition
> > using the cpusets cgroup, we see this crash. Specifically, it seems to
> > occur with cgroups that are throttled and we change the allowed
> > cpuset.

Thanks for the context, I will try to reproduce the problem and
understand how we can stop in the middle of walking to the
sched_entity branch with a parent not already added

How many cgroup level have you got in you setup ?

> >
>
> This patch from Gabriel should fix the problem:
>
>
> [PATCH] sched/fair: Reset tmp_alone_branch on cfs_rq delete
>
> When a child cfs_rq is added to the leaf cfs_rq list before its parent
> tmp_alone_branch is set to point to the child in preparation for the
> parent being added.
>
> If the child is deleted before the parent is added then tmp_alone_branch
> points to a freed cfs_rq. Any future reference to tmp_alone_branch will
> result in a use after free.

So, the patch below is a temporary fix that helps to recover from the
situation where tmp_alone_branch doesn't finished back to
rq->leaf_cfs_rq_list
But this situation should not happened at the beginning

>
> Signed-off-by: Gabriel Hartmann <gabriel.hartmann@gmail.com>
> Reported-by: Sargun Dhillon <sargun@sargun.me>
> ---
>  kernel/sched/fair.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7137bc343b4a..0987629cbb76 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -347,6 +347,11 @@ static inline void list_add_leaf_cfs_rq(struct
> cfs_rq *cfs_rq)
>  static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
>  {
>      if (cfs_rq->on_list) {
> +        struct rq *rq = rq_of(cfs_rq);
> +
> +        if (rq->tmp_alone_branch == &cfs_rq->leaf_cfs_rq_list)
> +            rq->tmp_alone_branch = &rq->leaf_cfs_rq_list;
> +
>          list_del_rcu(&cfs_rq->leaf_cfs_rq_list);
>          cfs_rq->on_list = 0;
>      }
