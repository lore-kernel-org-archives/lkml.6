Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78F0C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F97420854
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SlThV/EA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F97420854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbeKES3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:29:30 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:37127 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeKES33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:29:29 -0500
Received: by mail-io1-f68.google.com with SMTP id k17-v6so5945086ioc.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 01:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7lOqJouOVsIdClifOwBjLiSRytE2GZe9OIrdEAvf0xg=;
        b=SlThV/EAqQNE2JKMccaki+XzjJ93FRA9a0UdQsOQM/VloHnUTzo4oyXQW2bhuAyoye
         ElMKj5DJP0Glws6BAUSdWV0aggHyE6wM88e99puEX+hFjkfg/pQz67lsV+du4Aur1G6+
         O3OSdJDtwIR24mo/gj0XN7EydwvYLDNxIewqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7lOqJouOVsIdClifOwBjLiSRytE2GZe9OIrdEAvf0xg=;
        b=iAVBKYoZ2hthjyunNVS1RgurdgsREQx4kXD2wPcG/1TWw7iUSpSPUlBUO+cuFFD7SJ
         3mXB4ncAdT8ry2Je3rZNz5gv46zy/2VsW92iUMl7smIBT0bEjsojwJ/R0oAatDOyUB4U
         66Nzbt2afbiUoh1Dy53W02WPc81R7azKJyJKnxKjTj37fjIEnLCRiLMAbsQavLH3avLj
         +Hs7OiIYP5rgCVuAbV+x5aSjJZsF99gprj6/XIwelBrlyto+pVQZOKjrdfVZEJHDBUDX
         10KnNpfnVDMu9lqX5w/D+yNFzBipuNOWV7ptn1vw4ipTXjwNAtog18wxpK87EPE5qFph
         3i8w==
X-Gm-Message-State: AGRZ1gIRBT7OsuNDAADuns5umCIo0kHelIzuopQqX/uf4bOthwKBjJAt
        /nSXNaML8bCnQpH9zVaunuAiszX/hR6VGlqVQkO1FA==
X-Google-Smtp-Source: AJdET5cHYDS5QaHdwtv4oZm74NKxPV8MUAdqq347oKx7PUcqY6OolaTFOU5KCAs4GZizPrASwaM7Z2sFVEXiIqIGbFA=
X-Received: by 2002:a6b:244:: with SMTP id 65-v6mr16451451ioc.183.1541409046410;
 Mon, 05 Nov 2018 01:10:46 -0800 (PST)
MIME-Version: 1.0
References: <1540570303-6097-1-git-send-email-vincent.guittot@linaro.org>
 <1540570303-6097-3-git-send-email-vincent.guittot@linaro.org> <b89b6805-45c0-8462-b75b-b7da4a35c022@arm.com>
In-Reply-To: <b89b6805-45c0-8462-b75b-b7da4a35c022@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 5 Nov 2018 10:10:34 +0100
Message-ID: <CAKfTPtBapA3JvbgUyESzE=2ZXOGLRLmZh7oi8N=H9PHubCCuNg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] sched/fair: update scale invariance of PELT
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        pkondeti@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Nov 2018 at 16:36, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 10/26/18 6:11 PM, Vincent Guittot wrote:
> > The current implementation of load tracking invariance scales the
> > contribution with current frequency and uarch performance (only for
> > utilization) of the CPU. One main result of this formula is that the
> > figures are capped by current capacity of CPU. Another one is that the
> > load_avg is not invariant because not scaled with uarch.
> >
> > The util_avg of a periodic task that runs r time slots every p time slots
> > varies in the range :
> >
> >      U * (1-y^r)/(1-y^p) * y^i < Utilization < U * (1-y^r)/(1-y^p)
> >
> > with U is the max util_avg value = SCHED_CAPACITY_SCALE
> >
> > At a lower capacity, the range becomes:
> >
> >      U * C * (1-y^r')/(1-y^p) * y^i' < Utilization <  U * C * (1-y^r')/(1-y^p)
> >
> > with C reflecting the compute capacity ratio between current capacity and
> > max capacity.
> >
> > so C tries to compensate changes in (1-y^r') but it can't be accurate.
> >
> > Instead of scaling the contribution value of PELT algo, we should scale the
> > running time. The PELT signal aims to track the amount of computation of
> > tasks and/or rq so it seems more correct to scale the running time to
> > reflect the effective amount of computation done since the last update.
> >
> > In order to be fully invariant, we need to apply the same amount of
> > running time and idle time whatever the current capacity. Because running
> > at lower capacity implies that the task will run longer, we have to ensure
> > that the same amount of idle time will be apply when system becomes idle
> > and no idle time has been "stolen". But reaching the maximum utilization
> > value (SCHED_CAPACITY_SCALE) means that the task is seen as an
> > always-running task whatever the capacity of the CPU (even at max compute
> > capacity). In this case, we can discard this "stolen" idle times which
> > becomes meaningless.
> >
> > In order to achieve this time scaling, a new clock_pelt is created per rq.
> > The increase of this clock scales with current capacity when something
> > is running on rq and synchronizes with clock_task when rq is idle. With
> > this mecanism, we ensure the same running and idle time whatever the
> > current capacity.
>
> Thinking about this new approach on a big.LITTLE platform:
>
> CPU Capacities big: 1024 LITTLE: 512, performance CPUfreq governor
>
> A 50% (runtime/period) task on a big CPU will become an always running
> task on the little CPU. The utilization signal of the task and the
> cfs_rq of the little CPU converges to 1024.
>
> With contrib scaling the utilization signal of the 50% task converges to
> 512 on the little CPU, even it is always running on it, and so does the
> one of the cfs_rq.
>
> Two 25% tasks on a big CPU will become two 50% tasks on a little CPU.
> The utilization signal of the tasks converges to 512 and the one of the
> cfs_rq of the little CPU converges to 1024.
>
> With contrib scaling the utilization signal of the 25% tasks converges
> to 256 on the little CPU, even they run each 50% on it, and the one of
> the cfs_rq converges to 512.
>
> So what do we consider system-wide invariance? I thought that e.g. a 25%
> task should have a utilization value of 256 no matter on which CPU it is
> running?
>
> In both cases, the little CPU is not going idle whereas the big CPU does.

IMO, the key point here is that there is no idle time. As soon as
there is no idle time, you don't know if a task has enough compute
capacity so you can't make difference between the 50% running task or
an always running task on the little core.
That's also interesting to noticed that the task will reach the always
running state after more than 600ms on little core with utilization
starting from 0.

Then considering the system-wide invariance, the task are not really
invariant. If we take a 50% running task that run 40ms in a period of
80ms, the max utilization of the task will be 721 on the big core and
512 on the little core.
Then, if you take a 39ms running task instead, the utilization on the
big core will reach 709 but it will be 507 on little core. So your
utilization depends on the current capacity
With the new proposal, the max utilization will be 709 on big and
little cores for the 39ms running task. For the 40ms running task, the
utilization will be 721 on big core. then if the task moves on the
little, it will reach the value 721 after 80ms,  then 900 after more
than 160ms and 1000 after 320ms
