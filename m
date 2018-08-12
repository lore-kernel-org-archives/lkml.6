Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7111C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 16:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6E8216F2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 16:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gPj8ddSW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6E8216F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbeHLSqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 14:46:21 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:45751 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727699AbeHLSqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 14:46:21 -0400
Received: by mail-wr1-f50.google.com with SMTP id f12-v6so12183719wrv.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Aug 2018 09:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lJDv/KvrmcYy5h/dzyVvArwZEHrF9dhdGQPO6C4/JoU=;
        b=gPj8ddSWquhc7l0IuEEtF8a3IKizEw0H+1w1o6ltEZRb28z7mK4hqVDe29RAeUhbif
         QZWqTK3Pc8jyknownGMcfNPS+qxbbwaDaWVk4HvoDy44REmxqbUyaDwQ9PEpPOgF7pob
         e3jibs5HTnT9z93t13ruR7PNTG3geZwNJr8To=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lJDv/KvrmcYy5h/dzyVvArwZEHrF9dhdGQPO6C4/JoU=;
        b=byOta/B2dvz0wsQ86xxbd4hz+ELfK3Pr8tpNWHt5ZYElv40v2uCMHRe0iW+D3UBvAX
         iP9DslKQydlL7BX3M2/yYKaIu3Fyzj34YBOwPTlLCpOxw6U3b2T0rJQdH8ZZF+s4i8iK
         3fpht50UFiJE7AZTVuLHCfHfmHUuq0fglOpQoQVhYdnFgHuxYafYb3aB/VyEy5zs5+HF
         n8afIamVzGuxOS3OiZNDb4NLQHNBSeekIG0P2wZ0u7a1slyMxM0Pd7JvNebdLNmrqor7
         onYFnQPhXiSrV9eyOf1bYURbW1VSbVv6PjtUp6ksuL5asVv/Qhd6d4c6v0btKUPmid/u
         9xhw==
X-Gm-Message-State: AOUpUlEdjvnZS6F0vbdhGyhuSXLD41RlX1xXPqzHM4XZBLcChHwRKfn2
        k0r7ggALSKe7N0YD63rb/N18kg==
X-Google-Smtp-Source: AA+uWPwYd2BZrWnM9ltKZJq0B2MSgs5qd4SPcO6o9VrSLFFuVmL3a5vkqc7xeNYEfSixgpu1EWZTOw==
X-Received: by 2002:a5d:5201:: with SMTP id j1-v6mr8691049wrv.198.1534090068662;
        Sun, 12 Aug 2018 09:07:48 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id n14-v6sm4590630wmc.14.2018.08.12.09.07.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Aug 2018 09:07:47 -0700 (PDT)
Date:   Mon, 13 Aug 2018 00:07:40 +0800
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
Message-ID: <20180812160740.GC28966@leoy-ThinkPad-X240s>
References: <1533835203-5789-1-git-send-email-leo.yan@linaro.org>
 <1533835203-5789-2-git-send-email-leo.yan@linaro.org>
 <CAJZ5v0hU3Qp3ycJ=aGHtPMMC_6A+XsByYALYN22dz2VJ1Z0MgQ@mail.gmail.com>
 <20180810071321.GC11817@leoy-ThinkPad-X240s>
 <CAJZ5v0iyGFFDO83KGcET9a+UpPCDQ=_sxZeGxuG6fL4O+hcw+w@mail.gmail.com>
 <20180810084906.GD11817@leoy-ThinkPad-X240s>
 <20180810090327.GE11817@leoy-ThinkPad-X240s>
 <CAJZ5v0gM+PNnMH=Myn5yRLYg4SVV3JnF-htO_gueJp4odivT6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gM+PNnMH=Myn5yRLYg4SVV3JnF-htO_gueJp4odivT6w@mail.gmail.com>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 12, 2018 at 01:12:41PM +0200, Rafael J. Wysocki wrote:
> On Fri, Aug 10, 2018 at 11:03 AM <leo.yan@linaro.org> wrote:
> >
> > On Fri, Aug 10, 2018 at 04:49:06PM +0800, Leo Yan wrote:
> > > On Fri, Aug 10, 2018 at 09:22:10AM +0200, Rafael J. Wysocki wrote:
> > > > On Fri, Aug 10, 2018 at 9:13 AM,  <leo.yan@linaro.org> wrote:
> > > > > On Thu, Aug 09, 2018 at 10:47:17PM +0200, Rafael J. Wysocki wrote:
> > > > >> On Thu, Aug 9, 2018 at 7:20 PM, Leo Yan <leo.yan@linaro.org> wrote:
> > > >
> > > > [cut]
> > > >
> > > > >> And that will cause the tick to be stopped unnecessarily in certain
> > > > >> situations, so why is this better?
> > > > >
> > > > > Let's see below two cases, the first one case we configure
> > > > > TICK_USEC=1000 (1ms) and the second case we configure TICK_USEC=4000
> > > > > (4ms).
> > > > >
> > > > > Let's assume we do the testing one the same platform and have two runs,
> > > > > in the Case 1 we configure HZ=1000 so TICK_USEC=1ms, expected_interval
> > > > > is 3ms and deepest idle state target residency is 2ms, finally the idle
> > > > > governor will choose the deepest state and skip to calibrate to shallow
> > > > > state caused by 'expected_interval' > TICK_USEC;
> > > > >
> > > > > In the Case 2 we configure HZ=250 so TICK_USE=4ms, expected_interval
> > > > > (3ms) and deepest idle state target residency (2ms) are same with the
> > > > > Case 1; but because expected_interval < TICK_USEC so the idle governor
> > > > > will do calibration to select a shallower state.  If we image on one
> > > > > platform, the deepest idle state's target residency is smaller value,
> > > > > then it has bigger gap with TICK_USEC, the deepest idle state is harder
> > > > > to be selected due 'expected_interval' can be easily hit the range
> > > > > [Deepest target residency..TICK_USEC).
> > > > >
> > > > > This patch has no any change for Case 1 and it wants to optimize for
> > > > > Case 2 so Case 2 has chance to stay in deepest idle state.  I
> > > > > understand from the performance pespective, we need to avoid to stop
> > > > > tick for shallow states; on the other hand we cannot prevent CPU run
> > > > > into deepest idle state just only we want to keep the tick running,
> > > > > especially the expected interval is longer than the deepest state
> > > > > target residency.
> > > > >
> > > > > Case 1:
> > > > >       Deepest idle state's target residency=2ms
> > > > >                      |
> > > > >                      V
> > > > > |--------------------------------------------------------> time (ms)
> > > > >       ^                              ^
> > > > >       |                              |
> > > > > TICK_USEC=1ms           expected_interval=3ms
> > > > >
> > > > >
> > > > > Case 2:
> > > > >       Deepest idle state's target residency = 2ms
> > > > >                      |
> > > > >                      V
> > > > > |--------------------------------------------------------> time (ms)
> > > > >                                      ^                  ^
> > > > >                                      |                  |
> > > > >                           expected_interval = 3ms   TICK_USEC = 4ms
> > > > >
> > > > >
> > > > >
> > > > >> >                 unsigned int delta_next_us = ktime_to_us(delta_next);
> > > > >> >
> > > > >> >                 *stop_tick = false;
> > > > >> > --
> > > >
> > > > Well, I don't quite agree with the approach here, then.
> > > >
> > > > As I said in the previous reply, IMO restarting the stopped tick
> > > > before leaving the loop in do_idle() is pointless overhead.  It is not
> > > > necessary to do that to avoid leaving CPUs in shallow idle states for
> > > > too long (I'll send an alternative patch to fix this issue shortly).
> > > >
> > > > While you may think that pointless overhead is not a problem, I don't
> > > > quite agree with that.
> > >
> > > I disagree this patch will introduce any extra overhead.
> > >
> > > Firstly, the idle loop doesn't support restarting tick even this patch
> > > tells idle loop to restart the tick;
> 
> I'm not talking about restarting the tick, but about stopping it more
> often on average.

Ah, yes, I agree.

> > > secondly this patch is mainly to
> > > resolve issue for the CPU cannot stay in deepest state in Case 2,
> 
> I understand what you are trying to achieve here, but I don't agree with it.

I agree we need find more general method for fixing.

> The condition modified by this patch is not about how much time the
> CPU can potentially be idle, but about when it is expected to wake up.
> The "expected" part is really key here.
> 
> The governor has gone through the effort of making an idle duration
> prediction and it now it has a certain expectation regarding when the
> CPU will wake up.  If the governor's prediction is any good at all and
> this expectation is in the tick range, the CPU will be woken up by
> something close enough to the tick in the majority of cases, so there
> is no need to stop the tick.  Not because the CPU cannot be idle
> longer, but because it is expected to wake up early enough anyway (and
> yes, you can argue that 2 times the tick range may still be "early
> enough" and so on, but then I'd like to see numbers in support of
> that).

Thanks for explaination; I also think this is good methodology, but
just want to improve a bit based on this.  For example, the governor
is always to use 'expectation' to compare with TICK_USEC, TICK_USEC is a
predefined interval as a boundary, but in reality the tick incoming time
is in the range of [0..TICK_USEC]; so currently method we cannot make
decision according to the tick's delta in realtime.

I'd like take this issue as 'how to improve the decision for stopping
tick?', if we can make better decision for stopping tick, then it's
possible to resolve Case 2 and without stopping tick more offten, e.g.
the CPU even can run into deepest idle state without stopping the tick
if the prediction is less than the tick.

I will send out a new patch set based on these ideas for reviewing.

> Now, if the governor is junk and its predictions are useless, the
> above will not be the case any more, but then I'm not sure what the
> benefit from using that governor at all is. :-)

I really don't think the governor and predictions are useless :)

Just want to remind the side topic, after introducing tick in idle loop,
the tick also can impact the predictions (e.g. it have some impactions
on correction factors but need more time for modeling on this).

> > > as a side effect it also can tell idle loop to restart the tick for case 3
> > > in below, actually IMHO this makes sense to tell the idle loop to
> > > enable the tick but idle loop can ignore this info.
> > >
> > > Furthermore, we have another thread for the patch to always stop
> > > tick after the the tick has been stopped in the idle loop.
> > >
> > > So this patch is still valid.
> >
> > Correct for Case 3 as below, actually this case will disappear if we
> > force to set expected_interval=ktime_to_us(delta_next) in another
> > proposaled patch.  If so, this patch will have no any chance to
> > introduce extra ticks.
> 
> Yes, it will or at least it may.
> 
> Assuming shot noise wakeups, if
> drv->states[drv->state_count-1].target_residency is less than
> TICK_USEC, the tick will be stopped for CPUs more often on average
> with the patch applied (simply because the idle duration range for
> which it will not be stopped is narrower then).

Yes, good point, so in the new approach I try to change the code
to compare with next tick delta rather than TICK_USEC, it can keeps
running tick for the tick with long expire time (similiar with
comparing with TICK_USEC) but we also can stop tick if the tick is likely
to break idle residency.

Thanks,
Leo Yan
