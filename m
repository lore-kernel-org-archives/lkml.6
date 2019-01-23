Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E58C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424E621726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TiFwK6Ou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfAWJtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 04:49:00 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40910 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfAWJtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 04:49:00 -0500
Received: by mail-it1-f193.google.com with SMTP id h193so2078040ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 01:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UcyHYJmnN6661+mRZvBDrL4fDfWTrfD43xwiIxE0YkY=;
        b=TiFwK6OugzDSgFVbnStiTCqlb/ErxfW17165brMuPMZmdUkRaeyxWt72S+OWkKH7hw
         Y2XT/q6di/RiE/0Qf4ok8HK5fKG2Rrrpm+8WeBkorwojDlbpT4vv5U6YTWisPXzXrW/5
         zSY96RnvOaLyZ0bI+jAgQQWAHtsJzlt9ex6TQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UcyHYJmnN6661+mRZvBDrL4fDfWTrfD43xwiIxE0YkY=;
        b=W5GpB4BSH4X5FROrvazpK0mg4ezuHPLeqz4IQNXhrzac8y8Qn0pC9eItm+TOQOwPp2
         Q+8iLUQ0o3p0WoXLjmRwQk6O93Xk93RrcL2urGSVWsBVyqV+pvwjxaH7mhwn25eCkQiL
         WPHXlAq6gB11SL0eWlNxGMc32cgiGer3M+g6TDQArNULZeIlEnSsJ1x1eAxmkxOQrMjE
         p93LQWRvsxsOiUjZp69fO0xBxSWXpnpvqD2D9h4zgQXcDkwDBOSmgmEYEltsOVQC0xYL
         VoIcV40GiC6PKpc+pHy+uIZbmCpIi4izUvDSxf8yVv8/DU2SQkW6jdPIn07Ve267Q5p9
         lC+g==
X-Gm-Message-State: AJcUukfup+Z1uyx3ug2fkVPLgaHj1AsXjkTNtM9jhUrlQDwfdmfsAajl
        hpOyfDlAqltYc6Xn8TEq8s7usjBjlC9L8MReAuVBig==
X-Google-Smtp-Source: ALg8bN7VAg0DeJ0ppM3c6BtCU8frcMpMunVk1jbXVHTdFz1s+tJGb6rfKgUXHjlz6gGbg2IfqIYJhDWapSZcDd4h+xI=
X-Received: by 2002:a02:6019:: with SMTP id i25mr906111jac.137.1548236939455;
 Wed, 23 Jan 2019 01:48:59 -0800 (PST)
MIME-Version: 1.0
References: <1547631791-16018-1-git-send-email-vincent.guittot@linaro.org>
 <1547631791-16018-3-git-send-email-vincent.guittot@linaro.org> <a3671d96-5003-6a50-ad2d-64833ca216a1@arm.com>
In-Reply-To: <a3671d96-5003-6a50-ad2d-64833ca216a1@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 23 Jan 2019 10:48:48 +0100
Message-ID: <CAKfTPtCjb2PRxgs9nABw2V_MJq2wi=0DTpm+wEvvSX7qnAp+VA@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] sched/fair: update scale invariance of PELT
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        pkondeti@codeaurora.org, Quentin Perret <quentin.perret@arm.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2019 at 09:26, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 1/16/19 10:43 AM, Vincent Guittot wrote:
>
> [...]
>
> > +static inline u64 rq_clock_pelt(struct rq *rq)
> > +{
>
> Doesn't this function need
>
>    lockdep_assert_held(&rq->lock);
>    assert_clock_updated(rq);

originally, it was replacing cfs_rq_clock_task which doesn't have this
debugging code.
But it also replaces rq_clock_task for deadline and rt so it's
probably worthing adding them for such case

>
> like rq_clock() and rq_clock_task()? Later to support commit
> cb42c9a3ebbb "sched/core: Add debugging code to catch missing
> update_rq_clock() calls".
>
> > +     return rq->clock_pelt - rq->lost_idle_time;
> > +}
>
> [...]
