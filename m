Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7754DC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A7421F43
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ch0a3KeM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A7421F43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732633AbeHITau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 15:30:50 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35727 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732236AbeHITau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 15:30:50 -0400
Received: by mail-wm0-f67.google.com with SMTP id o18-v6so1020011wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 10:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BzrxkPljpKwUyvPB0HIFRD6+y3tMqA1b77j6EgbaPMo=;
        b=ch0a3KeMha38r6dD6WxihinCVdqKnmAzTIZuCeBlqxfC2Vtn73HV5F/LmJRSJpvHf/
         C7dgrgfr5xr4C15oNmNbLb6g/WWfwn+X8MrKEna0xdl4800s7bh9lUpGMsXMGXXP7gRe
         Q1AkGaGNTBkyCXozdB82bPWDIDUUwMUe0q0jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BzrxkPljpKwUyvPB0HIFRD6+y3tMqA1b77j6EgbaPMo=;
        b=tz7cfZuKM+4dw1h7EisAdFN7lmGfW4pRuAcKVJt5CDMVvZEezqaRcRefQ9Ze6eQSRq
         gKqO5K0el0Q85DXSl2towtLHv0meW41US+XGPtSdzUqm0BjKxm/r+BuPprrEQznfz6hr
         d+wdBlt0gkBGobjI6jT9DdbHuFKIoiQxoMDgIY5iXGLYYyYm2kk48hYcE0vv8lsJTnTh
         38EZqiYY3DPS8e6Y/smhQCsbJTp9DUiUsAGI09an2l8b32/dh7Nhm4tNBU3stEn3kMfa
         PWZX2s4MfGvjYu8lJ7HNiOeUjxfWBW/wQvg20eklW+2K1gfJZI/kXcO/qR0KCWiyc43k
         sv5Q==
X-Gm-Message-State: AOUpUlHtKEy8NqQK8MjH/YOVlVUBTWxLtwlEu3vWPYdw/ZRN6XeEn7v+
        ur7PUxf1SjipuA6NGU+HY2QCtw==
X-Google-Smtp-Source: AA+uWPzM1nYqp//X0vbo/UmnT2RhNLf1OcTirYaeBzp9ZQaQ5xgQT59ElCuMyRLVjz41xldWx+tQbg==
X-Received: by 2002:a1c:3a8f:: with SMTP id h137-v6mr2184720wma.72.1533834302603;
        Thu, 09 Aug 2018 10:05:02 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id v10-v6sm8204921wrm.18.2018.08.09.10.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 10:05:01 -0700 (PDT)
Date:   Fri, 10 Aug 2018 01:04:50 +0800
From:   leo.yan@linaro.org
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] sched: idle: Reenable sched tick for cpuidle request
Message-ID: <20180809170449.GE14362@leoy-ThinkPad-X240s>
References: <1533793647-5628-1-git-send-email-leo.yan@linaro.org>
 <2704016.RYJlhC2yyo@aspire.rjw.lan>
 <CAJZ5v0goNUVR8UZPnBegVZjBshkt+G-D7UK_x5dOi+BCjAr5Yg@mail.gmail.com>
 <20180809162957.GD14362@leoy-ThinkPad-X240s>
 <CAJZ5v0it0XM29OGnNfanrRAH3E8uHkJjXVwgHBQRiT9aZ0747A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0it0XM29OGnNfanrRAH3E8uHkJjXVwgHBQRiT9aZ0747A@mail.gmail.com>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 06:43:55PM +0200, Rafael J. Wysocki wrote:
> On Thu, Aug 9, 2018 at 6:29 PM,  <leo.yan@linaro.org> wrote:
> > On Thu, Aug 09, 2018 at 05:42:30PM +0200, Rafael J. Wysocki wrote:
> >
> > [...]
> >
> >> >> This issue can be easily reproduce with the case on Arm Hikey board: use
> >> >> CPU0 to send IPI to CPU7, CPU7 receives the IPI and in the callback
> >> >> function it start a hrtimer with 4ms, so the 4ms timer delta value can
> >> >> let 'menu' governor to choose deepest state in the next entering idle
> >> >> time.  From then on, CPU7 restarts hrtimer with 1ms interval for total
> >> >> 10 times, so this can utilize the typical pattern in 'menu' governor to
> >> >> have prediction for 1ms duration, finally idle governor is easily to
> >> >> select a shallow state, on Hikey board it usually is to select CPU off
> >> >> state.  From then on, CPU7 stays in this shallow state for long time
> >> >> until there have other interrupts on it.
> >> >
> >> > And which means that the above-mentioned code misses this case.
> >>
> >> And I don't really understand how this happens. :-/
> >>
> >> If menu sees that the tick has been stopped, it sets
> >> data->predicted_us to the minimum of TICK_USEC and
> >> ktime_to_us(delta_next) and the latency requirements comes from PM QoS
> >> (no interactivity boost).  Thus the only case when it will say "do not
> >> stop the tick" is when delta_next is below the tick period length, but
> >> that's OK, because it means that there is a timer pending that much
> >> time away, so it doesn't make sense to select a deeper idle state
> >> then.
> >>
> >> If there is a short-interval timer pending every time we go idle, it
> >> doesn't matter that the tick is stopped really, because the other
> >> timer will wake the CPU up anyway.
> >>
> >> Have I missed anything?
> >
> > Yeah, you miss one case is if there haven't anymore timer event, for this
> > case the ktime_to_us(delta_next) is a quite large value and
> > data->predicted_us will be to set TICK_USEC; if HZ=1000 then TICK_USEC is
> > 1000us, on Hikey board if data->predicted_us is 1000us then it's easily
> > to set shallow state (C1) rather than C2.  Unfortunately, this is the
> > last time the CPU can predict idle state before it will stay in idle
> > for long period.
> 
> Fair enough, but in that case the governor will want the tick to be
> stopped, because expected_interval is TICK_USEC then, so I'm not sure
> how the patch helps?

Correct, I might introduce confusion at here and I mentioned in
another email I have one prerequisite patch [1]: "cpuidle: menu: Correct
the criteria for stopping tick", if without this dependency patch, the idle
governor will always stop the tick even it selects one shallow state.

Sorry when I sent patchs with [1], I didn't send to linux-pm mailing list,
do you want me to send these patches to linux-pm?

[...]

Thanks,
Leo Yan

[1] https://lkml.org/lkml/2018/8/7/407
