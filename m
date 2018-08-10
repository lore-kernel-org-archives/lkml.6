Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15192C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8E820989
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LD3KJnsU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8E820989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbeHJLch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 07:32:37 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50924 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbeHJLcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 07:32:36 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so1109100wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 02:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VWvWTyo4FemfhaXHqoHLHvAi0AAe36O/E9EPdlFu26s=;
        b=LD3KJnsU0XIPxDGcw55of3pKfgE+oglqyE4dhZeA8XPF4cEaCilweemNgTXT5timAp
         CYLeQSrTm6ErrtNB4Rxmr3EwZv8BZu0IsQNTSp+A5GIq3P3/hfNXBPJ4HxE0VLuUfBwk
         sG0jG1dF/v1OMUrbEg9vmiABzO7ju47tKjwSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VWvWTyo4FemfhaXHqoHLHvAi0AAe36O/E9EPdlFu26s=;
        b=StCR8+miYqzUq9xwb7RKHQCnXiF2FKzd+No0o7+CS35SaVvyOymqBajkzG/1uFN+oL
         hXAGTOI9rCemNH1aVjqRpBQMD8wXm4aNlF2ltBr39tEsei8JxXVTQqQ9Ygge/EpV6Qps
         l6Lfj1+gZlNg6AmMTAngq4ycqc9ARponWoMLukdYQc/HWbWJRCSunOuQWHbKWWuozYh8
         0TQUkpPnBhE61w6DaEDJTa+hGcwMbgQtsCbGJ5Wzn4sA6p19T9wQmRzKWTSR5sD3seS0
         yhyhSgIQcAXs0cgzUtOya80uLGTbbSFVSpbIDtS80YdeE7aiKAolSg4O6JqrNXZVLIFC
         HDTQ==
X-Gm-Message-State: AOUpUlEm7s7bffkuv+v2Dg6sHZavf5bjbEWs4ZM85yWi7uzVo1YSQgnh
        poNdj9oqHGyYj7mJgP9uWvV1qg==
X-Google-Smtp-Source: AA+uWPyVkWLk7bHO63MX0rnU5Hw1oX8MeVtBn/YIPqeidAEA9d5NEiG80fuleyqUGtWcLsnlltx1Kg==
X-Received: by 2002:a1c:1bc2:: with SMTP id b185-v6mr1006589wmb.160.1533891816400;
        Fri, 10 Aug 2018 02:03:36 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id 31-v6sm17997170wra.26.2018.08.10.02.03.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 02:03:35 -0700 (PDT)
Date:   Fri, 10 Aug 2018 17:03:28 +0800
From:   leo.yan@linaro.org
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [RESEND PATCH v1 1/2] cpuidle: menu: Correct the criteria for
 stopping tick
Message-ID: <20180810090327.GE11817@leoy-ThinkPad-X240s>
References: <1533835203-5789-1-git-send-email-leo.yan@linaro.org>
 <1533835203-5789-2-git-send-email-leo.yan@linaro.org>
 <CAJZ5v0hU3Qp3ycJ=aGHtPMMC_6A+XsByYALYN22dz2VJ1Z0MgQ@mail.gmail.com>
 <20180810071321.GC11817@leoy-ThinkPad-X240s>
 <CAJZ5v0iyGFFDO83KGcET9a+UpPCDQ=_sxZeGxuG6fL4O+hcw+w@mail.gmail.com>
 <20180810084906.GD11817@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810084906.GD11817@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 04:49:06PM +0800, Leo Yan wrote:
> On Fri, Aug 10, 2018 at 09:22:10AM +0200, Rafael J. Wysocki wrote:
> > On Fri, Aug 10, 2018 at 9:13 AM,  <leo.yan@linaro.org> wrote:
> > > On Thu, Aug 09, 2018 at 10:47:17PM +0200, Rafael J. Wysocki wrote:
> > >> On Thu, Aug 9, 2018 at 7:20 PM, Leo Yan <leo.yan@linaro.org> wrote:
> > 
> > [cut]
> > 
> > >> And that will cause the tick to be stopped unnecessarily in certain
> > >> situations, so why is this better?
> > >
> > > Let's see below two cases, the first one case we configure
> > > TICK_USEC=1000 (1ms) and the second case we configure TICK_USEC=4000
> > > (4ms).
> > >
> > > Let's assume we do the testing one the same platform and have two runs,
> > > in the Case 1 we configure HZ=1000 so TICK_USEC=1ms, expected_interval
> > > is 3ms and deepest idle state target residency is 2ms, finally the idle
> > > governor will choose the deepest state and skip to calibrate to shallow
> > > state caused by 'expected_interval' > TICK_USEC;
> > >
> > > In the Case 2 we configure HZ=250 so TICK_USE=4ms, expected_interval
> > > (3ms) and deepest idle state target residency (2ms) are same with the
> > > Case 1; but because expected_interval < TICK_USEC so the idle governor
> > > will do calibration to select a shallower state.  If we image on one
> > > platform, the deepest idle state's target residency is smaller value,
> > > then it has bigger gap with TICK_USEC, the deepest idle state is harder
> > > to be selected due 'expected_interval' can be easily hit the range
> > > [Deepest target residency..TICK_USEC).
> > >
> > > This patch has no any change for Case 1 and it wants to optimize for
> > > Case 2 so Case 2 has chance to stay in deepest idle state.  I
> > > understand from the performance pespective, we need to avoid to stop
> > > tick for shallow states; on the other hand we cannot prevent CPU run
> > > into deepest idle state just only we want to keep the tick running,
> > > especially the expected interval is longer than the deepest state
> > > target residency.
> > >
> > > Case 1:
> > >       Deepest idle state's target residency=2ms
> > >                      |
> > >                      V
> > > |--------------------------------------------------------> time (ms)
> > >       ^                              ^
> > >       |                              |
> > > TICK_USEC=1ms           expected_interval=3ms
> > >
> > >
> > > Case 2:
> > >       Deepest idle state's target residency = 2ms
> > >                      |
> > >                      V
> > > |--------------------------------------------------------> time (ms)
> > >                                      ^                  ^
> > >                                      |                  |
> > >                           expected_interval = 3ms   TICK_USEC = 4ms
> > >
> > >
> > >
> > >> >                 unsigned int delta_next_us = ktime_to_us(delta_next);
> > >> >
> > >> >                 *stop_tick = false;
> > >> > --
> > 
> > Well, I don't quite agree with the approach here, then.
> > 
> > As I said in the previous reply, IMO restarting the stopped tick
> > before leaving the loop in do_idle() is pointless overhead.  It is not
> > necessary to do that to avoid leaving CPUs in shallow idle states for
> > too long (I'll send an alternative patch to fix this issue shortly).
> > 
> > While you may think that pointless overhead is not a problem, I don't
> > quite agree with that.
> 
> I disagree this patch will introduce any extra overhead.
> 
> Firstly, the idle loop doesn't support restarting tick even this patch
> tells idle loop to restart the tick; secondly this patch is mainly to
> resolve issue for the CPU cannot stay in deepest state in Case 2, as a
> side effect it also can tell idle loop to restart the tick for case 3
> in below, actually IMHO this makes sense to tell the idle loop to
> enable the tick but idle loop can ignore this info.
> 
> Furthermore, we have another thread for the patch to always stop
> tick after the the tick has been stopped in the idle loop.
> 
> So this patch is still valid.

Correct for Case 3 as below, actually this case will disappear if we
force to set expected_interval=ktime_to_us(delta_next) in another
proposaled patch.  If so, this patch will have no any chance to
introduce extra ticks.

 expected_interval                             Deepest idle state's
 = min(TICK_USEC,ktime_to_us(delta_next))      target residency = 2ms
 = TICK_USEC = 1ms                                    |
      |                                               |
      V                                               V
|--------------------------------------------------------> time (ms)
      ^
      |
TICK_USEC=1ms
