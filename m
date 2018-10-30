Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06363C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9DF20823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VsAmCtQy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9DF20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeJ3TnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:43:15 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39324 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeJ3TnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 15:43:15 -0400
Received: by mail-io1-f66.google.com with SMTP id n11-v6so6927522iob.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 03:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lzRoMU4impDSED4h46mcBk6ZnbgDMA6xGDTL7GNHkHM=;
        b=VsAmCtQyfe8Tny/saKUdg/Gcop2CLD/ALqB70M1MJS9hugr7PbZAYt+qf7C8NlvUt/
         Dyh7R/iOL7DhXcHhFjF+ODNu/T/euaLhheMgCMxMMLJUC2swMc5MfkkG20myXbNj8+rY
         YKYMTcLW5kxbJXRxf8HQaRi9s+TQkF6obq7kY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lzRoMU4impDSED4h46mcBk6ZnbgDMA6xGDTL7GNHkHM=;
        b=PC7f73efxtNLT3yHfJNj2Rf9qUohfL4s/qJArzYCH4gafZs55qTA1YEK1pmXgO+Ijw
         FjVDhX5xsWyt+kc92ldQNMHzTq9P89J2TT8K4YLaVkPx4D+qCd1mqpMPzJNSToi5ljyV
         z8DCwjCvk97bbXPKQYMQedyCnZ0+IkCJ1eryA14kv1wdM7LfjW2VGVF8DPeXa008qPKJ
         rzqaz8UoRda3PWuho3VVG5/3sukBxBbh8keN0PhwMiGam2gT94zloCJVW4+2PHHE/EG9
         vMMN70CnaaGCJVE9K5JP7jx5+aRb3e11O8RdT6bCf8CxtZUVk6NAcvnlrog5VDwcRptT
         Iw+Q==
X-Gm-Message-State: AGRZ1gKzo1/4NcdQVMO04cRHsc05tpApaOwFLWBE+QygZBRolaTVI4E7
        WIEmfpvFa4Tnbm6WVzkcGiBHVCCC8VIO/Kj3P9FxAA==
X-Google-Smtp-Source: AJdET5fY84I78Ofby6A6NdXCIt7TNcQ/zfIlrAhzBkNzigu7E9vx4mUikA3XMqy2sJMWcmD3nyxUn+PIxbw+MAzQTbI=
X-Received: by 2002:a6b:ea13:: with SMTP id m19-v6mr10264721ioc.18.1540896616363;
 Tue, 30 Oct 2018 03:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <1540570303-6097-1-git-send-email-vincent.guittot@linaro.org>
 <1540570303-6097-3-git-send-email-vincent.guittot@linaro.org> <20181030091938.GE27587@codeaurora.org>
In-Reply-To: <20181030091938.GE27587@codeaurora.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 30 Oct 2018 11:50:05 +0100
Message-ID: <CAKfTPtCFop-mxb206HkFva4vOEWpc4r-DVfEkVMKPZf8C1V-eA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] sched/fair: update scale invariance of PELT
To:     pkondeti@codeaurora.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thara Gopinath <thara.gopinath@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavan,

On Tue, 30 Oct 2018 at 10:19, Pavan Kondeti <pkondeti@codeaurora.org> wrote:
>
> Hi Vincent,
>
> On Fri, Oct 26, 2018 at 06:11:43PM +0200, Vincent Guittot wrote:
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 6806c27..7a69673 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -674,9 +674,8 @@ static u64 sched_vslice(struct cfs_rq *cfs_rq, struct sched_entity *se)
> >       return calc_delta_fair(sched_slice(cfs_rq, se), se);
> >  }
> >
> > -#ifdef CONFIG_SMP
> >  #include "pelt.h"
> > -#include "sched-pelt.h"
> > +#ifdef CONFIG_SMP
> >
> >  static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu);
> >  static unsigned long task_h_load(struct task_struct *p);
> > @@ -764,7 +763,7 @@ void post_init_entity_util_avg(struct sched_entity *se)
> >                        * such that the next switched_to_fair() has the
> >                        * expected state.
> >                        */
> > -                     se->avg.last_update_time = cfs_rq_clock_task(cfs_rq);
> > +                     se->avg.last_update_time = cfs_rq_clock_pelt(cfs_rq);
> >                       return;
> >               }
> >       }
> > @@ -3466,7 +3465,7 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> >  /* Update task and its cfs_rq load average */
> >  static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> >  {
> > -     u64 now = cfs_rq_clock_task(cfs_rq);
> > +     u64 now = cfs_rq_clock_pelt(cfs_rq);
> >       struct rq *rq = rq_of(cfs_rq);
> >       int cpu = cpu_of(rq);
> >       int decayed;
> > @@ -6694,6 +6693,12 @@ done: __maybe_unused;
> >       if (new_tasks > 0)
> >               goto again;
> >
> > +     /*
> > +      * rq is about to be idle, check if we need to update the
> > +      * lost_idle_time of clock_pelt
> > +      */
> > +     update_idle_rq_clock_pelt(rq);
> > +
> >       return NULL;
> >  }
>
> Do you think it is better to call this from pick_next_task_idle()? I don't see
> any functional difference, but it may be easier to follow.

Yes there is no functional difference. I have put it there just for
simplicity as there is no pelt related code in idle.c and keep things
contained

>
> Thanks,
> Pavan
> --
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
>
