Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950F9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DBD320832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FaJ0UkVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DBD320832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbeK1Uz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:55:29 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34254 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbeK1Uz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:55:29 -0500
Received: by mail-io1-f67.google.com with SMTP id f6so19480693iob.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 01:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=asPHqtM9SwAdm0TIABcF60TM7XmwfRX+ZOZAFXz/aiI=;
        b=FaJ0UkVlA65ZwMkt+n+MqC8qSgHEySQWX5K5FIjZRGD6hP7at4F/IWvdlovAmufy74
         YxcHeFefK8wKsspDAFs1FXzHoCMa7lvkY/jAAp3AFqVzSNFTzzQ9wwv8C5sOXdXUVl2x
         kdE6R14TKevMsNkGPcNwp5Z5k1DzHh844TZ7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=asPHqtM9SwAdm0TIABcF60TM7XmwfRX+ZOZAFXz/aiI=;
        b=eWEssj0mP5CMdS6znrkFhNcfaVal0Nq+2n/a1VV7Iu9cZ0qBRwplJkT2RBGIDATC6v
         43yRireglnRXN9qkKJkubc45sMmd/r3q+s0N6yBEdU7Ugrt7baZvzT1LNMDnt3uqZf6U
         +1NNIW33m1rWpmLOT6Cdd8jTuVVsPP6Wv1okRv08zwOrLzD8jRGG7KLNpxt2HqkHKxY4
         azvbv+RGVZU8hoX+Pzxg5WYX/3YpscQadldjtuWYyM39qtsubFwVcJokqXce6oDYg0y4
         WFm8xmHO/ybQDWVEfI9mqDL5JKJvMGe3qHI5wNIemaYtCc0PkBP+3PZKn9QWmbnf79XI
         pMjg==
X-Gm-Message-State: AA+aEWa4/grASR1B4RCZhwVOHsluzv9ZXO5zngJl1r9hWeqXHcgac+an
        q/Et/t9cHgpjUrX0Db6uU4Xn6Vtk3/GoNylvzRyIjUu3
X-Google-Smtp-Source: AFSGD/W9+Iy2vLB92BbXvMSI79/a+C9+o2gCa8AHHCPkeVMwu8KBTXdgdKeRC7lIvuwJHLdIyBuuuaLZzWe08B1ogKU=
X-Received: by 2002:a6b:fe13:: with SMTP id x19mr26646740ioh.294.1543398864335;
 Wed, 28 Nov 2018 01:54:24 -0800 (PST)
MIME-Version: 1.0
References: <1542711308-25256-1-git-send-email-vincent.guittot@linaro.org> <1542711308-25256-3-git-send-email-vincent.guittot@linaro.org>
In-Reply-To: <1542711308-25256-3-git-send-email-vincent.guittot@linaro.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 28 Nov 2018 10:54:13 +0100
Message-ID: <CAKfTPtD=sV3zJiZMfCFi92_f6j-jTO9D5RsEBAXHVa6VN3Urwg@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] sched/fair: update scale invariance of PELT
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
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

Hi,

On Tue, 20 Nov 2018 at 11:55, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> The current implementation of load tracking invariance scales the
> contribution with current frequency and uarch performance (only for
> utilization) of the CPU. One main result of this formula is that the
> figures are capped by current capacity of CPU. Another one is that the
> load_avg is not invariant because not scaled with uarch.
>
> The util_avg of a periodic task that runs r time slots every p time slots
> varies in the range :
>
>     U * (1-y^r)/(1-y^p) * y^i < Utilization < U * (1-y^r)/(1-y^p)
>
> with U is the max util_avg value = SCHED_CAPACITY_SCALE
>
> At a lower capacity, the range becomes:
>
>     U * C * (1-y^r')/(1-y^p) * y^i' < Utilization <  U * C * (1-y^r')/(1-y^p)
>
> with C reflecting the compute capacity ratio between current capacity and
> max capacity.
>
> so C tries to compensate changes in (1-y^r') but it can't be accurate.
>
> Instead of scaling the contribution value of PELT algo, we should scale the
> running time. The PELT signal aims to track the amount of computation of
> tasks and/or rq so it seems more correct to scale the running time to
> reflect the effective amount of computation done since the last update.
>
> In order to be fully invariant, we need to apply the same amount of
> running time and idle time whatever the current capacity. Because running
> at lower capacity implies that the task will run longer, we have to ensure
> that the same amount of idle time will be applied when system becomes idle
> and no idle time has been "stolen". But reaching the maximum utilization
> value (SCHED_CAPACITY_SCALE) means that the task is seen as an
> always-running task whatever the capacity of the CPU (even at max compute
> capacity). In this case, we can discard this "stolen" idle times which
> becomes meaningless.
>
> In order to achieve this time scaling, a new clock_pelt is created per rq.
> The increase of this clock scales with current capacity when something
> is running on rq and synchronizes with clock_task when rq is idle. With
> this mechanism, we ensure the same running and idle time whatever the
> current capacity. This also enables to simplify the pelt algorithm by
> removing all references of uarch and frequency and applying the same
> contribution to utilization and loads. Furthermore, the scaling is done
> only once per update of clock (update_rq_clock_task()) instead of during
> each update of sched_entities and cfs/rt/dl_rq of the rq like the current
> implementation. This is interesting when cgroup are involved as shown in
> the results below:
>
> On a hikey (octo Arm64 platform).
> Performance cpufreq governor and only shallowest c-state to remove variance
> generated by those power features so we only track the impact of pelt algo.
>
> each test runs 16 times
>
> ./perf bench sched pipe
> (higher is better)
> kernel  tip/sched/core     + patch
>         ops/seconds        ops/seconds         diff
> cgroup
> root    59652(+/- 0.18%)   59876(+/- 0.24%)    +0.38%
> level1  55608(+/- 0.27%)   55923(+/- 0.24%)    +0.57%
> level2  52115(+/- 0.29%)   52564(+/- 0.22%)    +0.86%
>
> hackbench -l 1000
> (lower is better)
> kernel  tip/sched/core     + patch
>         duration(sec)      duration(sec)        diff
> cgroup
> root    4.453(+/- 2.37%)   4.383(+/- 2.88%)     -1.57%
> level1  4.859(+/- 8.50%)   4.830(+/- 7.07%)     -0.60%
> level2  5.063(+/- 9.83%)   4.928(+/- 9.66%)     -2.66%
>
> Then, the responsiveness of PELT is improved when CPU is not running at max
> capacity with this new algorithm. I have put below some examples of
> duration to reach some typical load values according to the capacity of the
> CPU with current implementation and with this patch. These values has been
> computed based on the geometric series and the half period value:
>
> Util (%)     max capacity  half capacity(mainline)  half capacity(w/ patch)
> 972 (95%)    138ms         not reachable            276ms
> 486 (47.5%)  30ms          138ms                     60ms
> 256 (25%)    13ms           32ms                     26ms
>
> On my hikey (octo Arm64 platform) with schedutil governor, the time to
> reach max OPP when starting from a null utilization, decreases from 223ms
> with current scale invariance down to 121ms with the new algorithm.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Is there anything else that I should do for these patches ?

Regards,
Vincent
