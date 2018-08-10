Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB340C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF1C223F6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF1C223F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbeHJKS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:18:57 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35906 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbeHJKS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:18:57 -0400
Received: by mail-wm0-f66.google.com with SMTP id w24-v6so891373wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 00:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=66FXGNKEEkD83aT56RybEirZWDS2WoHGxPa+eB2k8V4=;
        b=MB3l072tSM7eObh1a+qx82a1iS/1VZU0Oma78CwSzI/CpCgpGrnJpo/1EGG7XtnX/k
         Ruk3OcIQ8WqYF2Rt18ZasdnAU0e9p+chXKkXgFgvm4loEpJ5gMC3WAD0R7yyMcoe6hfN
         xOOYLXLLHQnU78E6tHCZx8rdBCLJFRIHdOaCwz8Y7bj/roANDZTnnbUjaiG0h6JEz1Ac
         a78GPIoj/hBg0EsN4r8XWDJjCQ2D4x7ryXwBLDqBJJDzhAWS9LRm9JeA4c6cTWsfWJMH
         yhjYDO1tkp6iaViZPnsejoaG4QaQJW1Gm2VyWjhb0WVnhfWnNO8Tu4pi2C8KY1fDo8tB
         deLA==
X-Gm-Message-State: AOUpUlF3+HMZm6/xptkcJLaYc1Fgtj//SOucYm0COEkx2/jeO4eTYpEp
        c8AgfnM9F6z9ih9Gois0Kk574w==
X-Google-Smtp-Source: AA+uWPy3M9bBaWYPyPVsX5xkMOm+6ttTkhCiQzE6AzzsII8l/TX9thjChYnN698mJTIpWvLZ0q9Tdg==
X-Received: by 2002:a1c:92:: with SMTP id 140-v6mr699979wma.87.1533887414396;
        Fri, 10 Aug 2018 00:50:14 -0700 (PDT)
Received: from localhost.localdomain (hsvpn34.hotsplots.net. [176.74.57.181])
        by smtp.gmail.com with ESMTPSA id l16-v6sm521810wme.36.2018.08.10.00.50.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 00:50:13 -0700 (PDT)
Date:   Fri, 10 Aug 2018 09:50:11 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 01/14] sched/core: uclamp: extend sched_setattr to
 support utilization clamping
Message-ID: <20180810075011.GA20366@localhost.localdomain>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-2-patrick.bellasi@arm.com>
 <20180807123550.GA3062@localhost.localdomain>
 <20180809091427.4p2c4fbxocpkjaby@darkstar>
 <20180809095043.GC22465@localhost.localdomain>
 <20180809152313.lewfhufidhxb2qrk@darkstar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809152313.lewfhufidhxb2qrk@darkstar>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/18 16:23, Patrick Bellasi wrote:
> On 09-Aug 11:50, Juri Lelli wrote:
> > On 09/08/18 10:14, Patrick Bellasi wrote:
> > > On 07-Aug 14:35, Juri Lelli wrote:
> > > > On 06/08/18 17:39, Patrick Bellasi wrote:
> 
> [...]
> 
> > > 1) make CAP_SYS_NICE protected the clamp groups, with an optional boot
> > >    time parameter to relax this check
> > 
> > It seems to me that this might work well with that the intended usage of
> > the interface that you depict above. SMS only (or any privileged user)
> > will be in control of how groups are configured, so no problem for
> > normal users.
> 
> Yes, well... apart normal users still getting a -ENOSPC is they are
> requesting one of the not pre-configured clamp values. Which is why
> the following bits can be helpful.
> 
> > > 2) add discretization support to clamp groups allocation
> > 
> > And this might also work well if we feel that we don't want to restrict
> > usage of the interface to admin only, however...
> > 
> > > This second feature specifically, will ensure that clamp values are
> > > always mapped into one of the available clamp groups. While the exact
> > > clamp value can always be used for tasks placement biasing, when it
> > > comes to frequency selection biasing, depending on concurrently
> > > running tasks, you can end up with an effective clamp value which is a
> > > rounded up.
> > 
> > what I'm not so sure about is that we might lose in flexibility if the
> > number of available discrete clamp groups is too small compared to the
> > number of available OPP on the platform.
> 
> Regarding this concern, I would say that we should consider that, for
> frequency biasing, we are in general not interested in nailing down
> the single 1% difference and/or exact OPP capacities

True.

> A certain coarse grained resolution is usually acceptable for many
> different reasons:
> a) schedutil already uses a 20% margin which can potentially eclipse
>    few OPP when we scale up/down
> b) tasks/CPUs utilization are good enough but never exact and precise
>    values
> c) reducing the number of OPP switches could have some benefits on
>    stability/latencies
> d) clamping is actually defining minimum/maximum preferred values, is
>    not to be considered a tool for "precise control"
> 
> All that considered, I would say that maybe a 5% resolution could
> still be considered an acceptable _worst case_ rounding since we don't
> have always to round up to the next 5%.
> 
> For example, if we have:
>  - TaskA: util_min=41%
>  - TaskB: util_nin=44%
> they will be both accounted in the 40-45% clamp group but the clamp
> group value can be modulated at run-time depending on RUNNABLE
> tasks. When TaskA is running alone, we can still set util_min to
> 41%, while we will use 44% (not 45%) when TaskB is (also) running.
> 
> It's worth to notice that we pre-allocated at compile time 20 clamp
> groups, but not necessarily all of them will be used at run-time.
> Indeed, we will still use a policy where only the actual required
> values are allocated at the beginning of the clamps map, thus
> optimizing max updates.

OK, so you'll only still iterate over the groups that are actually in
use, which is hopefully less than 20 and should keep overhead low. Makes
sense to me.
