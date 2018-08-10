Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FFAC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8588D217C6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GqH/WRAS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8588D217C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbeHJLSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 07:18:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32975 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbeHJLSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 07:18:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id g6-v6so7609282wrp.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 01:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t8gXVZ5/MV7r48hJFU6RmmGuGoeboxqn6oRjSnS3SgU=;
        b=GqH/WRASX9piKa83/i5c4EcnwW+WEZqGgavqZU+2e61ZFMUwUnpdBbc0pyQiy0qNDm
         C2WIcV2muhv6zBBodB/OAj55HHj/dMZv8/dariFQQsT28PPDOAifvjAH6nJgSFSmibh7
         TdyLMIukOWkY6itv7IFIbZxoduep2c/b88L38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t8gXVZ5/MV7r48hJFU6RmmGuGoeboxqn6oRjSnS3SgU=;
        b=gZjFw+sZVHnEbt2A+kqwJyPN3ubLgUHrEWG5kvRWHSqj90nUAwy4W/GJC7KQGCAlOd
         TXWm5+WFXj5MX40sNESvfpqnV8XBPz/1O0Ke6n8d6mST3zLbnUKJo2zR1lAaLq6/bVON
         +KsuWbZDHkvogszKgeVEC1sfNQoHmkd5KHR7FsC/Sx2HGl8zeDaPXCLsC4IePIizkvSs
         4n3pZQeFZQC4bztBjRsaPM8IBkAP9+Bos4xeMKw23+1Xew+yCmI/B303R5v7HUHl7oUI
         kUgvhGSMapGgMBBJp2JLQb5HOrjH9htMG1/UCWkz64q2Q/tdMM6kKdCYvtZaPhIBVF3O
         ngkQ==
X-Gm-Message-State: AOUpUlFO6CkpCgABxTzbWRt6lvHrjm7xJU7FyWldUG2+EnQzNYXwkuUw
        hQiC/Qefr7BVQ6wvBeA1x0JNug==
X-Google-Smtp-Source: AA+uWPyFxq3IMriRXtcobVdM7X0M2vRsyePt+J/cySYco5zdcOSsXuTxzhVcOIMAXgew+iRK6UmfLw==
X-Received: by 2002:adf:f60a:: with SMTP id t10-v6mr3319051wrp.170.1533890956366;
        Fri, 10 Aug 2018 01:49:16 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id o14-v6sm1743524wmd.35.2018.08.10.01.49.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 01:49:15 -0700 (PDT)
Date:   Fri, 10 Aug 2018 16:49:06 +0800
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
Message-ID: <20180810084906.GD11817@leoy-ThinkPad-X240s>
References: <1533835203-5789-1-git-send-email-leo.yan@linaro.org>
 <1533835203-5789-2-git-send-email-leo.yan@linaro.org>
 <CAJZ5v0hU3Qp3ycJ=aGHtPMMC_6A+XsByYALYN22dz2VJ1Z0MgQ@mail.gmail.com>
 <20180810071321.GC11817@leoy-ThinkPad-X240s>
 <CAJZ5v0iyGFFDO83KGcET9a+UpPCDQ=_sxZeGxuG6fL4O+hcw+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iyGFFDO83KGcET9a+UpPCDQ=_sxZeGxuG6fL4O+hcw+w@mail.gmail.com>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 09:22:10AM +0200, Rafael J. Wysocki wrote:
> On Fri, Aug 10, 2018 at 9:13 AM,  <leo.yan@linaro.org> wrote:
> > On Thu, Aug 09, 2018 at 10:47:17PM +0200, Rafael J. Wysocki wrote:
> >> On Thu, Aug 9, 2018 at 7:20 PM, Leo Yan <leo.yan@linaro.org> wrote:
> 
> [cut]
> 
> >> And that will cause the tick to be stopped unnecessarily in certain
> >> situations, so why is this better?
> >
> > Let's see below two cases, the first one case we configure
> > TICK_USEC=1000 (1ms) and the second case we configure TICK_USEC=4000
> > (4ms).
> >
> > Let's assume we do the testing one the same platform and have two runs,
> > in the Case 1 we configure HZ=1000 so TICK_USEC=1ms, expected_interval
> > is 3ms and deepest idle state target residency is 2ms, finally the idle
> > governor will choose the deepest state and skip to calibrate to shallow
> > state caused by 'expected_interval' > TICK_USEC;
> >
> > In the Case 2 we configure HZ=250 so TICK_USE=4ms, expected_interval
> > (3ms) and deepest idle state target residency (2ms) are same with the
> > Case 1; but because expected_interval < TICK_USEC so the idle governor
> > will do calibration to select a shallower state.  If we image on one
> > platform, the deepest idle state's target residency is smaller value,
> > then it has bigger gap with TICK_USEC, the deepest idle state is harder
> > to be selected due 'expected_interval' can be easily hit the range
> > [Deepest target residency..TICK_USEC).
> >
> > This patch has no any change for Case 1 and it wants to optimize for
> > Case 2 so Case 2 has chance to stay in deepest idle state.  I
> > understand from the performance pespective, we need to avoid to stop
> > tick for shallow states; on the other hand we cannot prevent CPU run
> > into deepest idle state just only we want to keep the tick running,
> > especially the expected interval is longer than the deepest state
> > target residency.
> >
> > Case 1:
> >       Deepest idle state's target residency=2ms
> >                      |
> >                      V
> > |--------------------------------------------------------> time (ms)
> >       ^                              ^
> >       |                              |
> > TICK_USEC=1ms           expected_interval=3ms
> >
> >
> > Case 2:
> >       Deepest idle state's target residency = 2ms
> >                      |
> >                      V
> > |--------------------------------------------------------> time (ms)
> >                                      ^                  ^
> >                                      |                  |
> >                           expected_interval = 3ms   TICK_USEC = 4ms
> >
> >
> >
> >> >                 unsigned int delta_next_us = ktime_to_us(delta_next);
> >> >
> >> >                 *stop_tick = false;
> >> > --
> 
> Well, I don't quite agree with the approach here, then.
> 
> As I said in the previous reply, IMO restarting the stopped tick
> before leaving the loop in do_idle() is pointless overhead.  It is not
> necessary to do that to avoid leaving CPUs in shallow idle states for
> too long (I'll send an alternative patch to fix this issue shortly).
> 
> While you may think that pointless overhead is not a problem, I don't
> quite agree with that.

I disagree this patch will introduce any extra overhead.

Firstly, the idle loop doesn't support restarting tick even this patch
tells idle loop to restart the tick; secondly this patch is mainly to
resolve issue for the CPU cannot stay in deepest state in Case 2, as a
side effect it also can tell idle loop to restart the tick for case 3
in below, actually IMHO this makes sense to tell the idle loop to
enable the tick but idle loop can ignore this info.

Furthermore, we have another thread for the patch to always stop
tick after the the tick has been stopped in the idle loop.

So this patch is still valid.

Case 3:
      Deepest idle state's target residency = 2ms
                     |
                     V
|--------------------------------------------------------> time (ms)
      ^        `
      |         \
TICK_USEC=1ms   expected_interval = 1.5ms


