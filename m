Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4266DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E33721720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Db1GhGtJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733268AbeLTOWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 09:22:25 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42971 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729550AbeLTOWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 09:22:25 -0500
Received: by mail-io1-f68.google.com with SMTP id x6so931627ioa.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 06:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rJNQ/iRG4BcL8hZFV93iky8ciUz4TTLepjwEUHtVE+w=;
        b=Db1GhGtJgX2NTrgDs9ALSq2f0FKSdyBHWb7JAHIa1R+gDlFktsi6/Gw4riX/6u29Ix
         cxF7nUi/TxqoKlZ2RllzMegeIeQAQMMKv6mCviI8iV5sFyl+o6xC3FUC80vfrBC5zIyz
         RytbKantHi3z/GMyvr/b2aBtNI1GXQ0RhOKq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rJNQ/iRG4BcL8hZFV93iky8ciUz4TTLepjwEUHtVE+w=;
        b=WLe0Di7fefzXdeVFlJmMsy7LHf7Snt8Pr2K18WSW0RoLNqWQlhuVeSqVu5kmxtM79L
         yUbSxOu6dBG+McGTms5VSFOy43G2yeA7pJNP2Td+8b6kxiwcdKbHk7m7L+F2Mk6MrvhD
         NEvID++Au3tiyaEBS0lF+08nMGD6Kbj8XTpwcChd+7oVhPmtqHp+XTMP35dOg6yv6SCF
         UjgV7GOh3/7dMapjo+Fb5IsgB+IlE08aBDX9pi13f5EsbAjIk3U72beekWLQBHmYyYVO
         z04UNgtBziL/YX6uhQG8KjCfLvjW/dbv+bwxtIVP2HBBCaavzuN6vcrmBxHXqbZixeOo
         Ut6w==
X-Gm-Message-State: AA+aEWZJpyyOrEKIzwd0s2kHkt0XrJIffrA73fKZxsTO6DPC/QOtfyKf
        xFRJBiXmWQF3n7OwOgNG14DLbyskBakBArnrLQXLxrrPjVc=
X-Google-Smtp-Source: AFSGD/W8O4TVHG/9fwUv9409RdldNbaTqDzrZ5YfSrJUOs0vlYHpzCmX9TBbAMsR6cvJd3MfjpnoHkq/X0+JHbvhcD0=
X-Received: by 2002:a6b:fe13:: with SMTP id x19mr20119794ioh.294.1545315744150;
 Thu, 20 Dec 2018 06:22:24 -0800 (PST)
MIME-Version: 1.0
References: <1545292547-18770-1-git-send-email-vincent.guittot@linaro.org>
 <1545292547-18770-2-git-send-email-vincent.guittot@linaro.org> <ec8ccd83-0613-e37a-1a7b-ec680c4c4779@arm.com>
In-Reply-To: <ec8ccd83-0613-e37a-1a7b-ec680c4c4779@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 20 Dec 2018 15:22:10 +0100
Message-ID: <CAKfTPtBjfSTXqt4tks6eBzXi+w1wCOBQ23BJ2wcSzVWAQiW9oA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] sched/fair: fix rounding issue for asym packing
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

On Thu, 20 Dec 2018 at 12:16, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 20/12/2018 07:55, Vincent Guittot wrote:
> > When check_asym_packing() is triggered, the imbalance is set to :
> >   busiest_stat.avg_load * busiest_stat.group_capacity / SCHED_CAPACITY_SCALE
> > But busiest_stat.avg_load equals
> >   sgs->group_load *SCHED_CAPACITY_SCALE / sgs->group_capacity
> > These divisions can generate a rounding that will make imbalance slightly
> > lower than the weighted load of the cfs_rq.
> > But this is enough to skip the rq in find_busiest_queue and prevents asym
> > migration to happen.
> >
> > Directly set imbalance to sgs->group_load to remove the rounding.
>                             ^^^^^^^^^^^^^^^
> I see where that's coming from, but using 'sgs' here is tad confusing since
> 'sds->busiest_stat' is what's actually used.
>
> Maybe just something like 'the busiest's sgs->group_load' would be good
> enough to make things explicit.
>
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index ca46964..9b31247 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8476,9 +8476,7 @@ static int check_asym_packing(struct lb_env *env, struct sd_lb_stats *sds)
> >       if (sched_asym_prefer(busiest_cpu, env->dst_cpu))
> >               return 0;
> >
> > -     env->imbalance = DIV_ROUND_CLOSEST(
> > -             sds->busiest_stat.avg_load * sds->busiest_stat.group_capacity,
> > -             SCHED_CAPACITY_SCALE);
> > +     env->imbalance = sds->busiest_stat.avg_load;
>
> That should be group_load, not avg_load. With that fixed:

ah yes... too quick at changing it

>
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
>
> >
> >       return 1;
> >  }
> >
