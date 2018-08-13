Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC12C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ADBD21728
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fHUQfuGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ADBD21728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbeHMMjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 08:39:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39526 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbeHMMjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 08:39:39 -0400
Received: by mail-pf1-f195.google.com with SMTP id j8-v6so7438842pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 02:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6TgfYP2HjJYufJ4bDGv1+kU76xFQJuY8u768VQj2dks=;
        b=fHUQfuGnmPn5yfj8iSe70kR3tWhOvOMOiq8C/jJRrYYLQIEaLX80Nb+PRKSD+mAPrV
         Cf4H0TERs9c6BZtbK6jMG+YLj+C0rkktXWSijnWsrvv02n1z4HFJwR7rZHk+iYjIdzuX
         A49YI8i2WRJn9YiMmqTFxfP0Vt/hrxSi1DhJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6TgfYP2HjJYufJ4bDGv1+kU76xFQJuY8u768VQj2dks=;
        b=V68timxycTukoC05U7rGwoRSptc5PU2szyTc6gD0jhdIeGSUeP6tzbThqGGrUD4qNB
         4FxVFMb6gXAjPjKeTWv1a7tC1Vbc4NcIkiQfVJOqMTWO3hhGjpIjD05rdLj2hBsB9bUT
         2hhFk3OlWYvDWUMu/MSg8wbFwypJFHWuEP+HbsRuIPPcJBqhPlEtjjavnVpud6fu/Fme
         3ENFOUtJ8mSQl51uCEm3SxHomtQL0A4EJQr9BpOSP58oB2hbYwPC5KLYa/MeW6iH3/o7
         A0bNcQWI7b8N1M5W8B60rfuBSLqAcWlPU2sSWrY7FsqhYc998sieX3hC0CklzObw33mO
         Nv5g==
X-Gm-Message-State: AOUpUlELvWNRYcCQt18vXGj9RZO2cvs/IevWn+AE1NmuJce6GoiVgV/x
        DROXtQ4yAV68Rt5z4zZ1JPsMN2ratwCmDFvw
X-Google-Smtp-Source: AA+uWPw+jfRMYOLDW01Bjvwv3W6+PCj7OgM/6i89BrZhHhLlkeJjdPnroOtLc2C2Jhx/YrzhLaGK1Q==
X-Received: by 2002:a62:5613:: with SMTP id k19-v6mr18332637pfb.212.1534154287255;
        Mon, 13 Aug 2018 02:58:07 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li1431-29.members.linode.com. [45.33.104.29])
        by smtp.gmail.com with ESMTPSA id o84-v6sm29223208pfi.165.2018.08.13.02.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 02:58:06 -0700 (PDT)
Date:   Mon, 13 Aug 2018 17:58:01 +0800
From:   leo.yan@linaro.org
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [RESEND PATCH v1 1/2] cpuidle: menu: Correct the criteria for
 stopping tick
Message-ID: <20180813095801.GB11775@leoy-ThinkPad-X240s>
References: <1533835203-5789-1-git-send-email-leo.yan@linaro.org>
 <1533835203-5789-2-git-send-email-leo.yan@linaro.org>
 <CAJZ5v0hU3Qp3ycJ=aGHtPMMC_6A+XsByYALYN22dz2VJ1Z0MgQ@mail.gmail.com>
 <20180810071321.GC11817@leoy-ThinkPad-X240s>
 <CAJZ5v0iyGFFDO83KGcET9a+UpPCDQ=_sxZeGxuG6fL4O+hcw+w@mail.gmail.com>
 <20180810084906.GD11817@leoy-ThinkPad-X240s>
 <20180810090327.GE11817@leoy-ThinkPad-X240s>
 <CAJZ5v0gM+PNnMH=Myn5yRLYg4SVV3JnF-htO_gueJp4odivT6w@mail.gmail.com>
 <20180812160740.GC28966@leoy-ThinkPad-X240s>
 <CAJZ5v0g-ZaUe1AJ=4tixtacaGB-roMXLXj5HNHBqMk+jf3aYnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g-ZaUe1AJ=4tixtacaGB-roMXLXj5HNHBqMk+jf3aYnA@mail.gmail.com>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 10:01:20AM +0200, Rafael J. Wysocki wrote:
> On Sun, Aug 12, 2018 at 6:07 PM <leo.yan@linaro.org> wrote:
> >
> > On Sun, Aug 12, 2018 at 01:12:41PM +0200, Rafael J. Wysocki wrote:
> > > On Fri, Aug 10, 2018 at 11:03 AM <leo.yan@linaro.org> wrote:
> 
> [cut]
> 
> > >
> > > Assuming shot noise wakeups, if
> > > drv->states[drv->state_count-1].target_residency is less than
> > > TICK_USEC, the tick will be stopped for CPUs more often on average
> > > with the patch applied (simply because the idle duration range for
> > > which it will not be stopped is narrower then).
> >
> > Yes, good point, so in the new approach I try to change the code
> > to compare with next tick delta rather than TICK_USEC, it can keeps
> > running tick for the tick with long expire time (similiar with
> > comparing with TICK_USEC) but we also can stop tick if the tick is likely
> > to break idle residency.
> 
> We tried something similar and the results were not encouraging.
> Please see https://lore.kernel.org/lkml/079e16b6-2e04-2518-0553-66becab226a6@tu-dresden.de/

I reviewed the result, in the shared page, it said to use next tick
delta and results in the power data increasing, I think this can be
explained.

If we use prediction to compare with next tick delta rather than
TICK_USEC, Thomas gave the expectation is 'This works as a I expect in
the sense of stopping the tick more often and allowing deeper sleep
states in some cases.'; but we also need to expect the change will give
more chance for powernightmares to occurring, if the expect_interval
just falls into the range [delta_next_us..TICK_USEC) then idle
governor will stop tick after comparing with the next tick delta, but
at the meantime the idle governor is very likely to select one shallow
state for expect_interval is a small value.  So though the change
gives more chance for staying deeper state but it also give more
chance for staying in shallow state for longer time.

From the testing report, I don't find it do statistics for idle state
duration time.  The email said 'No more sched tick, no more C1E
requests, but increased power.', so this is just for statistics for
idle state requests (entering/exiting times), but not for duration
statistics.  So this isn't clear for me how the difference for idle
duration.

Because the change gives more chance for powernightmares, so we need
use extra method to avoid it.  This is why I add one extra patch for
this [1], it checks for shallow state with long expire timer, for this
case we should not stop the tick.

Actually the powernightmares issue is not completely resolved so it
still impact the power data; after we really get rid of the impaction
of powernightmares, I think we may have chance to see the benefits of
comparing with next tick delta.

Based on these ideas, I worked out the patch set 'Improvement stopping
tick decision making in 'menu' idle governor' [2], the testing result
supports the idle duration improvement, which shared in the cover letter.

Please help review and let me know if it's doable or not.  Thanks for
the suggestion.

Thanks,
Leo Yan

[1] https://lkml.org/lkml/2018/8/12/84
[2] https://lkml.org/lkml/2018/8/12/82
