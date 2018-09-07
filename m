Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65F0C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D152083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 12:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hbCOTBWn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D152083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbeIGRg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:36:56 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:52819 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbeIGRgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:36:55 -0400
Received: by mail-it0-f65.google.com with SMTP id h3-v6so20429064ita.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 05:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WeeQRZI4KYL3oCoaS+LzCVvpB3a/VLwcpy7xvbahLUA=;
        b=hbCOTBWnoE/8pBdJTAu6NWyIXpE7rj6hYqMuW0dmSt2hBaOvkPZCcjktWO2lfTXxfo
         GQuuHgxDkaPh+1UfPLeBVcGzWTYKn1Xnd8YP4EF6XS9cwTBiB79MNoSyFYVhAHCuko+8
         8zsct9OmhdS13LNMg2wM7drEwtwTR45m7wTig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WeeQRZI4KYL3oCoaS+LzCVvpB3a/VLwcpy7xvbahLUA=;
        b=qDV+3j/N/WoteO3jaRnNVGiMUYSpZoirgRixGBNlgYO1E3z7mxEWyW793nyZKnT4ct
         QED8E+QvBGlpDIZ4O98liLfnWapBDWWgJzPMVgnNngpNR2ixW3RNpE691wNw+XKxkT5V
         PuFXYxUdQGsCzGYDsNQG8XvwE2IW+34Labcr3PMH0iGNG4uJ52ro0gFiRNNDx9jm4j/z
         0zHph4Qo3b0t30Y3+lX9t2+9Y4tjMwodyJKmgBvklMg/K3I6i24tOHTknHQP6QI0tkRD
         YrJqBoyvEAPmJXa2bcOSLsPUrmXoNlqah2DY0RsU7SZ2T6ckWh4CcdOiKUBmlbpiv5m/
         KuKw==
X-Gm-Message-State: APzg51Dp9o3d1WryMchKO/dFeu6Jx3xcM9NCuSVAmQqZHYuF5kL3eanC
        abCRk77Te9A8wKlJ74GMcCuvbVL/gNyvPtm57tWoLZq7
X-Google-Smtp-Source: ANB0VdaMaa0o6kcGeBZWR20OOdALY0gIeUV/sNZbCpuhcwIrYK9rbXqLlkKOBQJw9uuP21xJGy5i2tHZjx96BsXj7qc=
X-Received: by 2002:a24:3a88:: with SMTP id m130-v6mr6365909itm.151.1536324965107;
 Fri, 07 Sep 2018 05:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <1536306664-29827-1-git-send-email-vincent.guittot@linaro.org>
 <20180907113748.GV24106@hirez.programming.kicks-ass.net> <20180907123551.GA9955@linaro.org>
In-Reply-To: <20180907123551.GA9955@linaro.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 7 Sep 2018 14:55:54 +0200
Message-ID: <CAKfTPtBZhJToDAvre1Gvz1oBUZy893_p44JpDPMOWWk7-SXAyQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: fix load_balance redo for null imbalance
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        jhugo@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Sep 2018 at 14:35, Vincent Guittot <vincent.guittot@linaro.org> w=
rote:
>
> Le Friday 07 Sep 2018 =C3=A0 13:37:49 (+0200), Peter Zijlstra a =C3=A9cri=
t :
> > On Fri, Sep 07, 2018 at 09:51:04AM +0200, Vincent Guittot wrote:
> > > It can happen that load_balance finds a busiest group and then a busi=
est rq
> > > but the calculated imbalance is in fact null.
> >
> > Cute. Does that happen often?
>
> I have a use case with RT tasks that reproduces the problem regularly.
> It happens at least when we have CPUs with different capacity either beca=
use
> of heterogeous CPU or because of RT/DL reducing available capacity for cf=
s
> I have put the call path that trigs the problem below and accroding to th=
e
> comment it seems that we can reach similar state when playing with priori=
ty.
>
> >
> > > If the calculated imbalance is null, it's useless to try to find a bu=
siest
> > > rq as no task will be migrated and we can return immediately.
> > >
> > > This situation can happen with heterogeneous system or smp system whe=
n RT
> > > tasks are decreasing the capacity of some CPUs.
> >
> > Is it the result of one of those "force_balance" conditions in
> > find_busiest_group() ? Should we not fix that to then return NULL
> > instead?
>
> The UC is:
> We have a newly_idle load balance that is triggered when RT task becomes =
idle
> ( but I think that I have seen that with idle load balance too)
>
> we trigs:
>         if (env->idle !=3D CPU_NOT_IDLE && group_has_capacity(env, local)=
 &&
>             busiest->group_no_capacity)
>                 goto force_balance;
>
> In calculate_imbalance we use the path
>         /*
>          * Avg load of busiest sg can be less and avg load of local sg ca=
n
>          * be greater than avg load across all sgs of sd because avg load
>          * factors in sg capacity and sgs with smaller group_type are
>          * skipped when updating the busiest sg:
>          */
>         if (busiest->avg_load <=3D sds->avg_load ||
>             local->avg_load >=3D sds->avg_load) {
>                 env->imbalance =3D 0;
>                 return fix_small_imbalance(env, sds);
>         }
>
> but fix_small_imbalance finally decides to return without modifying imbal=
ance
> like here
>         if (busiest->avg_load + scaled_busy_load_per_task >=3D
>             local->avg_load + (scaled_busy_load_per_task * imbn)) {
>                 env->imbalance =3D busiest->load_per_task;
>                 return;
>         }
>
> Beside this patch, I'm preparing another patch in fix small imbalance to
> ensure 1 task per CPU in similar situation but according to the comment a=
bove,
> we can reach this situation because of tasks priority

I have just done a quick test on my smp hikey board (dual quad core
arm64) by adding a log in dmesg each time we have the condition
busiest !=3D null and imbalance =3D=3D 0. The log happens from time to time
when I generate some activity on the baord like syncing the filesystem
before running a test. But I don't have the details. The logs happen
with and without the next patch that I mentioned above. So it probably
means that we can trig this situation with other UCs

>
