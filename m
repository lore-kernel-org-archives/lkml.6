Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E136C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1425C2081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N4UGcs+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1425C2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeLDPoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:44:12 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:43016 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbeLDPoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:44:12 -0500
Received: by mail-io1-f67.google.com with SMTP id f10so8163110iop.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 07:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ysPLc9vTvOK2EWdgx5z5B8rpOAQ2rRDlsvgkzpycaw8=;
        b=N4UGcs+/DSnkP3WagcOlyvwyp+3jfVDf4juqsyWCUJK57+bsHYx1QOrtLC5uXpNFY5
         FyzqbNVmLFspP1Bx1J6RDKpHj2m93YOrol20izkVajoLt9CL9fTMuDuDNuaubwJvDs+T
         H/yC2yVpi/TN24A/mYFwSyNx1vyJDzqg1Cf/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ysPLc9vTvOK2EWdgx5z5B8rpOAQ2rRDlsvgkzpycaw8=;
        b=s89Er/QDaPqC3l8Wa4lRszouXj6o0AnR2wBIEiqa2gG3VVIj5n0QjQeCC+aG9N8b3U
         mHL7AzG5XdMGh6BXSS7UzoBT/56Mf0Ny02FKYAei+WVK7B0sVe+iG9jY1B5AY9NisZ3q
         Eg9QkW/99tnI6nA63aZH0E+dDtE1qKqulh9FnRYcMpDbSGHXwWghdzM4NciYfV52cGc9
         EWGFGNhsUAZnM2cmnIS2Z9Zc7CPP1ThpNnyqwH0WYVBY4RlhrYFK0oyVoLmunOgo5xCM
         6/CUMWfrQdTG161Xl3gSsRXyd3Rb8x9l+I30Uhi7BKV0eEOvOzM9owI82c+/AJ+q8szO
         O+nA==
X-Gm-Message-State: AA+aEWYoPpEQhn6dtz9JBe2GICbfJyFMk/YkNEUNrEprX8CIFi1LzaT9
        Uszll5F3/AxEDvyKQAYZoMqFFOQUjKJBlDjn1Sfsjw==
X-Google-Smtp-Source: AFSGD/Ul5FWR/FRau4x3UbtKp/pBT7awPU+Tyo3JTi6j7Rlrmtk4YHzzBFAeDIOxs4aIAJDIkfmoms1SM23YMzb5Oas=
X-Received: by 2002:a6b:6b0d:: with SMTP id g13mr17121690ioc.18.1543938250444;
 Tue, 04 Dec 2018 07:44:10 -0800 (PST)
MIME-Version: 1.0
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org> <1539102302-9057-6-git-send-email-thara.gopinath@linaro.org>
In-Reply-To: <1539102302-9057-6-git-send-email-thara.gopinath@linaro.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 4 Dec 2018 16:43:58 +0100
Message-ID: <CAKfTPtB18Fh3neT7d6m0fgthE6Zo0am4i9WQ9OriD3FCuZgrRw@mail.gmail.com>
Subject: Re: [RFC PATCH 5/7] sched/fair: Enable CFS periodic tick to update
 thermal pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thara,

On Tue, 9 Oct 2018 at 18:25, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>
> Introduce support in CFS periodic tick to trigger the process of
> computing average thermal pressure for a cpu.
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  kernel/sched/fair.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b39fb59..7deb1d0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -21,6 +21,7 @@
>   *  Copyright (C) 2007 Red Hat, Inc., Peter Zijlstra
>   */
>  #include "sched.h"
> +#include "thermal.h"
>
>  #include <trace/events/sched.h>
>
> @@ -9557,6 +9558,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>
>         if (static_branch_unlikely(&sched_numa_balancing))
>                 task_tick_numa(rq, curr);
> +
> +       update_periodic_maxcap(rq);

You have to call update_periodic_maxcap() in update_blocked_averages() too
Otherwise, the thermal pressure will not always be updated correctly
for tickless system

>  }
>
>  /*
> --
> 2.1.4
>
