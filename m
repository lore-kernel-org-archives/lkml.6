Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8ADC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE83222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i+Ip37rk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732527AbfBMAaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 19:30:46 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33370 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbfBMAaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 19:30:46 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so289939pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 16:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=h8xanRNj2xWMumTC4wtZ+WYwK9nlDVz5ZPnW6X3I18U=;
        b=i+Ip37rkCeKtaiRllfDq3NNqR2nDoAEKr0LHvHV3jQW9wOVfwXM07gYhjwk91eqB9f
         6UjUzXSlw+hGsuvGx8sfjFd0gJ0QpiapMSwd9HloO5OQtOdSQlk+OJpg6zwDZspQLQzQ
         ZCI+eH95G20pzMFO1nWbOaGJvHGMrYrGQW0IA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=h8xanRNj2xWMumTC4wtZ+WYwK9nlDVz5ZPnW6X3I18U=;
        b=pIWK6nVcE5/tD3vPH/X2TMmrtGNzemNkyqPovRxlIp+HRQd7oZHf+5E2gwzbw0M8Le
         5thGewjNf8H6hfRw5lSCFJxsZnuR4Jm5ykYx+KOfYklNecV+jPNwEqrc26uhYzTb75ln
         Bxc9MY1YOd1S7VPnLsylUjAOutuz7qnvJpVSUVl13R8XmgK9AWh54qunnGChsHivpV2J
         vBscwkXC3VraLh9/VEIsoDwwwJCq55hVPXcHCiCJtvKDYjjAHb9TGAZq8Hc5As4TjPsF
         Qk0MtkorHD8EwVeQZY9j184NqVNBxXnJmotSLDa/RTpUYRkLXX/jCx/mWNtLQyGAuPcL
         s/JQ==
X-Gm-Message-State: AHQUAuZyavtw+do/VBR4A5Hahj7CHjwk9JLYmf2wV85lP8xsgqptvRYC
        F9G6XfUBZgJwkZGkce46mGhENA==
X-Google-Smtp-Source: AHgI3IYP8LLK4myV674ei0CZ6EORv+VEHvRP1EeBoVG5S9EGoS1s6BFPwHu9WPYo8tOgQis7Mjv+FQ==
X-Received: by 2002:a62:2ad6:: with SMTP id q205mr6642689pfq.243.1550017845096;
        Tue, 12 Feb 2019 16:30:45 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id c7sm26593492pfa.24.2019.02.12.16.30.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 16:30:44 -0800 (PST)
Date:   Tue, 12 Feb 2019 16:30:44 -0800
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
Message-ID: <20190213003044.GV117604@google.com>
References: <CGME20190211153030eucas1p19bd9a7eca565ca066ab00dc2243cfb46@eucas1p1.samsung.com>
 <1549899005-7760-1-git-send-email-l.luba@partner.samsung.com>
 <26e38213-630f-94bc-ff80-1cad708c7f83@samsung.com>
 <20190212193229.GT117604@google.com>
 <1356584e-1812-6768-72af-931c07d925a8@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1356584e-1812-6768-72af-931c07d925a8@partner.samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Tue, Feb 12, 2019 at 10:20:07PM +0100, Lukasz Luba wrote:
> Hi Matthias,
> 
> On 2/12/19 8:32 PM, Matthias Kaehlcke wrote:
> > Hi,
> > 
> > On Tue, Feb 12, 2019 at 02:46:24PM +0900, Chanwoo Choi wrote:
> >> Hi Lukasz,
> >>
> >> On 19. 2. 12. 오전 12:30, Lukasz Luba wrote:
> >>> This patch set changes workqueue related features in devfreq framework.
> >>> First patch switches to delayed work instead of deferred.
> >>> The second switches to regular system work and deletes custom 'devfreq'.
> >>>
> >>> Using deferred work in this context might harm the system performance.
> >>> When the CPU enters idle, deferred work is not fired. The devfreq device's
> >>> utilization does not have to be connected with a particular CPU.
> >>> The drivers for GPUs, Network on Chip, cache L3 rely on devfreq governor.
> >>> They all are missing opportunity to check the HW state and react when
> >>> the deferred work is not fired.
> >>> A corner test case, when Dynamic Memory Controller is utilized by CPUs running
> >>> on full speed, might show x5 worse performance if the crucial CPU is in idle.
> >>
> >> The devfreq framework keeps the balancing between performance
> >> and power-consumption. It is wrong to focus on only either
> >> performance or power.
> >>
> >> This cover-letter focus on the only performance without any power-consumption
> >> disadvantages. It is easy to raise the performance with short sampling rate
> >> with polling modes. To get the performance, it is good as short as possible
> >> of period.
> >>
> >> Sometimes, when cpu is idle, the device might require the busy state.
> >> It is very difficult to catch the always right timing between them.
> >>
> >> Also, this patch cannot prevent the unneeded wakeup from idle state.
> >> Apparently, it only focuses on performance without considering
> >> the power-consumption disadvantage. In the embedded device,
> >> the power-consumption is very important point. We can not ignore
> >> the side effect.
> >>
> >> Always, I hope to improve the devfreq framwork more that older.
> >> But, frankly, it is difficult to agree because it only consider
> >> the performance without considering the side-effect.
> >>
> >> The power management framework always have to consider
> >> the power-consumption issue. This point is always true.
> > 
> > I missed the impact of forcing a CPU out of an idle state and/or not
> > allowing it to enter a more power efficient state. I agree that this
> > should be avoided.
> It would be good to have some real world scenarios for comparison:
> w/ and w/o this change, i.e. it is 5% or 50% more power used.

If you have data please share :)

Though I also imagine there will be quite some variation between
different systems/platforms.

> I have patches that tries to mitigate wake-ups when there is small
> utilization. Let's make it tunable and involve driver developers.
> They will decide how much impact on the system power usage they
> introduce.

Great!

> > I wonder if using a power-efficient workqueue could help here:
> > 
> >    Instead of running work on the local CPU, the workqueue core asks the
> >    scheduler to provide the target CPU for the work queued on unbound
> >    workqueues (which includes those marked as power-efficient). So they
> >    will not get pinned on a single CPU as can happen with regular
> >    workqueues.
> > 
> >    https://lwn.net/Articles/731052/
> > 
> > 
> > Since this series also changes from a custom to system workqueue it
> > seems worth to mention that there are power-efficient system workqueues:
> > 
> > system_power_efficient_wq
> > system_freezable_power_efficient_wq
> > 
> > 
> > In case a power-efficient workqueue is suitable in principle there
> > would still be a problem though: the feature is currently disabled by
> > default, hence devfreq couldn't really rely on it. It is enabled in
> > the arm64 defconfig though, so at least devices on this architecture
> > would benefit from it. Also power-efficient workqueues might be
> > enabled by default in the future as the scheduler becomes more energy
> > aware.
> Regarding this CPU idle cost worries.
> IIRC the new energy model does not even consider idle costs of the CPU.
> It would be good to know the measurements, i.e. worst case scenario:
> waking up 1 (of 4 or 8) CPU from idle 30 times per second for let's
> say 100 us. It is 3 ms / 1000 ms * running energy cost i.e. 250mW.
> Thus, 0.75mW.

I'm not an expert in this area, but your example seems too optimistic
You are just accounting for the pure runtime, not for the cost of
entering and exiting an idle state. Let's take a SDM845 idle state as
example:

C0_CPU_PD: c0-power-down {
  ...
  entry-latency-us = <350>;
  exit-latency-us = <461>;
  min-residency-us = <1890>;
  ...
};

https://patchwork.kernel.org/patch/10661319/

That's 811us for entering and exiting the idle state. At an
intermediate OPP (1.8 GHz) the power consumption is 505mW, according
to the Energy Model. I'm ignoring the actual execution time, since I
tend to agree with you that the monitoring should be done, unless it
has a really unreasonable cost. That leaves us with 30 * 811us =
24.3ms and 24.3ms / 1000 ms * 505mW = 12.3mW.

> In my opinion it is not a big cost. In most cases the system is still
> doing some other work. It is worth to mention here that on mobiles
> when the power button is hit the full suspend is called which freezes
> all tasks, devices and power consumption is ~15mW. Thus, the system
> suspend is out of scope here.

I agree that system suspend is out of scope.

> As I replayed to Chanwoon for the same email: in my opinion current
> devfreq is broken.
> It was probably developed in times where there was 1 CPU (maybe 2)
> and idle state of CPU would be a good hint to not to check devfreq
> devices.

IIUC the use of a power-efficient workqueues would address the problem
of waking up a CPU in idle state, however as mentioned earlier by
default this feature is disabled (except for arm64). How about
switching to system_power_efficient_wq and use INIT_DELAYED_WORK if
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y (or check if the workqueue in
question has WQ_UNBOUND set?) and INIT_DEFERRABLE_WORK otherwise? It's
not ideal, but a possible improvement.

Cheers

Matthias
