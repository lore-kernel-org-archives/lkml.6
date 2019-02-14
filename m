Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC1BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8911218FF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m0dlD19x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439991AbfBNUlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:41:00 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42763 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391051AbfBNUk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 15:40:59 -0500
Received: by mail-pf1-f196.google.com with SMTP id n74so3665795pfi.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 12:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rE+1I4e02qONuID7pO2wPkFNejvw5RpujX6zFtQ1qlU=;
        b=m0dlD19xGtfxirkBzgVMUCiD4XR+XsKDrVifJWQsSv985ELaF9qw1sHq/AD0a0Po/V
         pnYEUFV9DdbFZSZcPnfGEMZ0UKRDCSQTxBpdJm2TwKqkEpC2+C1bNc+dSzV7YtrVERVO
         s/p2ZzfdQNUiEgvf7rO2FA3Ai3XlemSr7G2/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rE+1I4e02qONuID7pO2wPkFNejvw5RpujX6zFtQ1qlU=;
        b=qPmb2PakYjPYgb41zggDOjgc8+YNFHZEhr4NcuOyJn5bGNoU4sADoQb9tAgbmgtcEc
         ON7HVKRJDSs73E5Gs6RSZXQMeXLgFI2ATxHWYBLfVxgc1aAWC9gKBk2aCAXqk8iQEznJ
         m26tVwjf8Hgj+KORkizRqTUHgKkbIBvLY9H+lMo0IhPP3K+eTW6z2us9Is26patgylA/
         xMUbbaZjAb+9c4kgYeYA5EMijn4/7pkXp09sF0rMWrwUPhGwjP/FEmH1s7GZ1LqJaDmV
         jm9nhVSC0x9VrrHRDEOKGyu+rTSA2Y6bSRlTEtt0ZCApA7boycy96JsTI8yY1DxEo8uP
         G+XA==
X-Gm-Message-State: AHQUAuZMZ9TLejb0IoP7qAHrOSisRsscPtWlFKryyg8tGMY+byMQsD3Y
        CnCOwAxFmJwuLH1AbuyHeFvEx2G/JuU=
X-Google-Smtp-Source: AHgI3IZmO//dB4RgJNuiwNWiTQ5G0+AOIk5F7OgV+BVIugt47TEwZkSE57JATDKOsUAWQE22s7Ww5w==
X-Received: by 2002:a62:1f5c:: with SMTP id f89mr6089212pff.137.1550176858323;
        Thu, 14 Feb 2019 12:40:58 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id z62sm8282523pfi.4.2019.02.14.12.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 12:40:57 -0800 (PST)
Date:   Thu, 14 Feb 2019 12:40:56 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.zolnierkie@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        joel@joelfernandes.org, chris.diamand@arm.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 0/2] drivers: devfreq: fix and optimize workqueue
 mechanism
Message-ID: <20190214204056.GE117604@google.com>
References: <CGME20190211153030eucas1p19bd9a7eca565ca066ab00dc2243cfb46@eucas1p1.samsung.com>
 <1549899005-7760-1-git-send-email-l.luba@partner.samsung.com>
 <26e38213-630f-94bc-ff80-1cad708c7f83@samsung.com>
 <20190212193229.GT117604@google.com>
 <1356584e-1812-6768-72af-931c07d925a8@partner.samsung.com>
 <20190213003044.GV117604@google.com>
 <90bbff25-1c9c-127c-13a7-91a5f4fe666e@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90bbff25-1c9c-127c-13a7-91a5f4fe666e@partner.samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Wed, Feb 13, 2019 at 02:00:26PM +0100, Lukasz Luba wrote:
> Hi Matthias,
> 
> On 2/13/19 1:30 AM, Matthias Kaehlcke wrote:
> > Hi Lukasz,
> > 
> > On Tue, Feb 12, 2019 at 10:20:07PM +0100, Lukasz Luba wrote:
> >> Hi Matthias,
> >>
> >> On 2/12/19 8:32 PM, Matthias Kaehlcke wrote:
> >>> Hi,
> >>>
> >>> On Tue, Feb 12, 2019 at 02:46:24PM +0900, Chanwoo Choi wrote:
> >>>> Hi Lukasz,
> >>>>
> >>>> On 19. 2. 12. 오전 12:30, Lukasz Luba wrote:
> >>>>> This patch set changes workqueue related features in devfreq framework.
> >>>>> First patch switches to delayed work instead of deferred.
> >>>>> The second switches to regular system work and deletes custom 'devfreq'.
> >>>>>
> >>>>> Using deferred work in this context might harm the system performance.
> >>>>> When the CPU enters idle, deferred work is not fired. The devfreq device's
> >>>>> utilization does not have to be connected with a particular CPU.
> >>>>> The drivers for GPUs, Network on Chip, cache L3 rely on devfreq governor.
> >>>>> They all are missing opportunity to check the HW state and react when
> >>>>> the deferred work is not fired.
> >>>>> A corner test case, when Dynamic Memory Controller is utilized by CPUs running
> >>>>> on full speed, might show x5 worse performance if the crucial CPU is in idle.
> >>>>
> >>>> The devfreq framework keeps the balancing between performance
> >>>> and power-consumption. It is wrong to focus on only either
> >>>> performance or power.
> >>>>
> >>>> This cover-letter focus on the only performance without any power-consumption
> >>>> disadvantages. It is easy to raise the performance with short sampling rate
> >>>> with polling modes. To get the performance, it is good as short as possible
> >>>> of period.
> >>>>
> >>>> Sometimes, when cpu is idle, the device might require the busy state.
> >>>> It is very difficult to catch the always right timing between them.
> >>>>
> >>>> Also, this patch cannot prevent the unneeded wakeup from idle state.
> >>>> Apparently, it only focuses on performance without considering
> >>>> the power-consumption disadvantage. In the embedded device,
> >>>> the power-consumption is very important point. We can not ignore
> >>>> the side effect.
> >>>>
> >>>> Always, I hope to improve the devfreq framwork more that older.
> >>>> But, frankly, it is difficult to agree because it only consider
> >>>> the performance without considering the side-effect.
> >>>>
> >>>> The power management framework always have to consider
> >>>> the power-consumption issue. This point is always true.
> >>>
> >>> I missed the impact of forcing a CPU out of an idle state and/or not
> >>> allowing it to enter a more power efficient state. I agree that this
> >>> should be avoided.
> >> It would be good to have some real world scenarios for comparison:
> >> w/ and w/o this change, i.e. it is 5% or 50% more power used.
> > 
> > If you have data please share :)
> I will try to measure it. I have some data which refer to CPU hotplug
> and generic data regarding ARM big.LITTLE.
> It is a mobile on my desk.
> When one CPU of ARM big is sent offline power drops ~12mW comparing
> to WFI idle which was previous state. The same for LITTLE ~12mW.
> When the last CPU in the cluster is sent offline, whole culster
> is switched off and power drops ~50mW.
> The LITTLE core can consume ~250mW at max speed.
> Energy Aware Scheduler is now merged IIRC, so if it has to choose
> which core wake up for idle, it will take LITTLE not big.

I'm not sure that EAS will make a difference in this case:

"We queue the work to the CPU on which it was submitted, but if the
CPU dies it can be processed by another CPU." (queue_work() comment).

> For older platforms which has Cortex-A9 500mW is also better estimation.
> 
> > 
> > Though I also imagine there will be quite some variation between
> > different systems/platforms.
> True.
> > 
> >> I have patches that tries to mitigate wake-ups when there is small
> >> utilization. Let's make it tunable and involve driver developers.
> >> They will decide how much impact on the system power usage they
> >> introduce.
> > 
> > Great!
> > 
> >>> I wonder if using a power-efficient workqueue could help here:
> >>>
> >>>     Instead of running work on the local CPU, the workqueue core asks the
> >>>     scheduler to provide the target CPU for the work queued on unbound
> >>>     workqueues (which includes those marked as power-efficient). So they
> >>>     will not get pinned on a single CPU as can happen with regular
> >>>     workqueues.
> >>>
> >>>     https://lwn.net/Articles/731052/
> >>>
> >>>
> >>> Since this series also changes from a custom to system workqueue it
> >>> seems worth to mention that there are power-efficient system workqueues:
> >>>
> >>> system_power_efficient_wq
> >>> system_freezable_power_efficient_wq
> >>>
> >>>
> >>> In case a power-efficient workqueue is suitable in principle there
> >>> would still be a problem though: the feature is currently disabled by
> >>> default, hence devfreq couldn't really rely on it. It is enabled in
> >>> the arm64 defconfig though, so at least devices on this architecture
> >>> would benefit from it. Also power-efficient workqueues might be
> >>> enabled by default in the future as the scheduler becomes more energy
> >>> aware.
> >> Regarding this CPU idle cost worries.
> >> IIRC the new energy model does not even consider idle costs of the CPU.
> >> It would be good to know the measurements, i.e. worst case scenario:
> >> waking up 1 (of 4 or 8) CPU from idle 30 times per second for let's
> >> say 100 us. It is 3 ms / 1000 ms * running energy cost i.e. 250mW.
> >> Thus, 0.75mW.
> > 
> > I'm not an expert in this area, but your example seems too optimistic
> > You are just accounting for the pure runtime, not for the cost of
> > entering and exiting an idle state. Let's take a SDM845 idle state as
> > example:
> > 
> > C0_CPU_PD: c0-power-down {
> >    ...
> >    entry-latency-us = <350>;
> >    exit-latency-us = <461>;
> >    min-residency-us = <1890>;
> >    ...
> > };
> > 
> > https://patchwork.kernel.org/patch/10661319/
> > 
> > That's 811us for entering and exiting the idle state. At an
> > intermediate OPP (1.8 GHz) the power consumption is 505mW, according
> > to the Energy Model. I'm ignoring the actual execution time, since I
> > tend to agree with you that the monitoring should be done, unless it
> > has a really unreasonable cost. That leaves us with 30 * 811us =
> > 24.3ms and 24.3ms / 1000 ms * 505mW = 12.3mW.
> You are probably taking ARM 'big' core wake-up from deeper that WFI 
> idle. I was referring to ARM LITTLE 250mW.

Yes, it's a big core in a deep state.

> It is also not 100% that the schedule work will wake up CPU which
> is currently in deepest idle.

true :)

> A short array would create a better picture of the use cases.
> The question is also probability of occurrence for each of these cases.
> For first two CPU state it would be a power cost lost during additional
> rescheduling to/from workqueue task, which takes i.e. 2*5 us * 30 times.
> 
> CPU state ->|  running | idle    | idle clock | idle, pwr  |
> ------------|   (C0)   | WFI (C1)|  gated (C2)| gated (C3) |
> architecture|          |         |            |            |
> ------V-----------------------------------------------------
> ARM big     |    <1mW  | <1mW    |   ~12mW    |  ~12mW     |
> ARM LITTLE  |    <1mW  | <1mW    |   ~6mW     |  ~6mW      |
> MIPS
> PowerPC
> 
> 
> > 
> >> In my opinion it is not a big cost. In most cases the system is still
> >> doing some other work. It is worth to mention here that on mobiles
> >> when the power button is hit the full suspend is called which freezes
> >> all tasks, devices and power consumption is ~15mW. Thus, the system
> >> suspend is out of scope here.
> > 
> > I agree that system suspend is out of scope.
> > 
> >> As I replayed to Chanwoon for the same email: in my opinion current
> >> devfreq is broken.
> >> It was probably developed in times where there was 1 CPU (maybe 2)
> >> and idle state of CPU would be a good hint to not to check devfreq
> >> devices.
> > 
> > IIUC the use of a power-efficient workqueues would address the problem
> > of waking up a CPU in idle state, however as mentioned earlier by
> > default this feature is disabled (except for arm64). How about
> > switching to system_power_efficient_wq and use INIT_DELAYED_WORK if
> > CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y (or check if the workqueue in
> > question has WQ_UNBOUND set?) and INIT_DEFERRABLE_WORK otherwise? It's
> > not ideal, but a possible improvement.
> I think it would be to complicated to maintain because different
> platforms might use different mechanisms.
> I would suggests that we could just follow mechanism in thermal
> framework. I have never faced any issue with delayed work there,
> while working on IPA.
> They use 'system_freezable_power_efficient_wq' and INIT_DELAYED_WORK().
> https://elixir.bootlin.com/linux/v5.0-rc6/source/drivers/thermal/thermal_core.c#L293
> https://elixir.bootlin.com/linux/v5.0-rc6/source/drivers/thermal/thermal_core.c#L1281
> They have these two polling intervals, though.

I think system_power_efficient_wq would be suitable if load monitoring
is stopped on suspend.

In any case it seems Chanwoo wants you to keep providing at least the
option of using a deferrable work. If you end up doing that it
probably would make sense to use always a delayed work for
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y.

Cheers

Matthias
