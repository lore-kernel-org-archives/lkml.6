Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413B2C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 00:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6DF2124D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 00:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iDo5rYMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6DF2124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbeHSDqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 23:46:14 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37697 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbeHSDqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 23:46:14 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11-v6so10519754wmc.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 17:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IFrmbTnqSnrk5FeJYP7qhIzTD608sNaGx4Jn5CDGWeI=;
        b=iDo5rYMMwavSVzdmhUpJI1rQm3S9AiJiZyiuGG1vF9ehKqdQoJ1F/VVAPRU4FnfS7a
         3jDEmrvwK8/+ReqZQS0UvI1AW/eLjQq7wPh5mNPhHSDZ5tSN12zHHPrt2cz6jprwFa9k
         3N6ysRuAwNYZZ2LiabF1l3QMZ+YLNqysIEGPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IFrmbTnqSnrk5FeJYP7qhIzTD608sNaGx4Jn5CDGWeI=;
        b=WQUBSKiVGOs8Ar32DzcIF9CFVv4es6gB/9SBDdcEpqw3Z22ji5CJDTLZIS922Km5Tf
         fwUvhKEmoGr+qjs2qJvRl79TXroYSjsAuxci9zOwCLSOaarfgC2zr8b0/Y1FLR6aSXFX
         RM+4AMq6n9ch89Aq7ODprBexf6wP5tEmHnUWZAXMvGS/mNThA7qJMxqCZctcH7jURW+l
         R3ZYZqyatMYXv4VeUU1zxLdrAE4UiKN/Lcdx3Ymehk/xPioQyIhh1hLTzfLX96aBkrUL
         NTPWaWcUo5a7/J4nol8Yg2aLjL2MEtpPaDmYPDqBEzWdCYW4fkcsVkRLkdqrrYZuOapV
         yFNg==
X-Gm-Message-State: AOUpUlEdV2p+VgiyGHuVdxShQPBa84CsOHBYDOCHagzLFRwqyZ7why4u
        UwltjDGBTn081unEwGudMeoFDg==
X-Google-Smtp-Source: AA+uWPxkciNQVr1Q9HDcY7zSr5DppAJEOtqmQyIDjiwfdHVOWLe02dk2ZRBsN9iPTWhHw+5Kdy3wVA==
X-Received: by 2002:a1c:8f50:: with SMTP id r77-v6mr22896684wmd.44.1534639000308;
        Sat, 18 Aug 2018 17:36:40 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id n14-v6sm5654996wmc.14.2018.08.18.17.36.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 17:36:39 -0700 (PDT)
Date:   Sun, 19 Aug 2018 08:36:32 +0800
From:   leo.yan@linaro.org
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] sched: idle: Avoid retaining the tick when it has been
 stopped
Message-ID: <20180819003632.GA11280@leoy-ThinkPad-X240s>
References: <2161372.IsD4PDzmmY@aspire.rjw.lan>
 <20180816132723.GA6010@lerouge>
 <10817203.8q7neLTJVD@aspire.rjw.lan>
 <20180817141252.GA12426@lerouge>
 <CAJZ5v0gD79NuTgr3dVS_3cBFz5Q1JtQTP8mDfSM1tvwDcYkFAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gD79NuTgr3dVS_3cBFz5Q1JtQTP8mDfSM1tvwDcYkFAQ@mail.gmail.com>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2018 at 11:57:00PM +0200, Rafael J. Wysocki wrote:

[...]

> > > > Otherwise we can have something like this:
> > > >
> > > > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > > > index da9455a..408c985 100644
> > > > --- a/kernel/time/tick-sched.c
> > > > +++ b/kernel/time/tick-sched.c
> > > > @@ -806,6 +806,9 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
> > > >  static void tick_nohz_retain_tick(struct tick_sched *ts)
> > > >  {
> > > >     ts->timer_expires_base = 0;
> > > > +
> > > > +   if (ts->tick_stopped)
> > > > +           tick_nohz_restart(ts, ktime_get());
> > > >  }
> > > >
> > > >  #ifdef CONFIG_NO_HZ_FULL
> > > >
> > >
> > > We could do that, but my concern with that approach is that we may end up
> > > stopping and starting the tick back and forth without exiting the loop
> > > in do_idle() just because somebody uses a periodic timer behind our
> > > back and the governor gets confused.
> > >
> > > Besides, that would be a change in behavior, while the $subject patch
> > > simply fixes a mistake in the original design.
> >
> > Ok, let's take the safe approach for now as this is a fix and it should even be
> > routed to stable.
> 
> Right.  I'll queue up this patch, then.
> 
> > But then in the longer term, perhaps cpuidle_select() should think that
> > through.
> 
> So I have given more consideration to this and my conclusion is that
> restarting the tick between cpuidle_select() and call_cpuidle() is a
> bad idea.
> 
> First off, if need_resched() is "false", the primary reason for
> running the tick on the given CPU is not there, so it only might be
> useful as a "backup" timer to wake up the CPU from an inadequate idle
> state.
> 
> Now, in general, there are two reasons for the idle governor (whatever
> it is) to select an idle state with a target residency below the tick
> period length.  The first reason is when the governor knows that the
> closest timer event is going to occur in this time frame, but in that
> case (as stated above), it is not necessary to worry about the tick,
> because the other timer will trigger soon enough anyway.  The second
> reason is when the governor predicts a wakeup which is not by a timer
> in this time frame and it is quite arguable what the governor should
> do then.  IMO it at least is not unreasonable to throw the prediction
> away and still go for the closest timer event in that case (which is
> the current approach).
> 
> There's more, though.  Restarting the tick between cpuidle_select()
> and call_cpuidle() might introduce quite a bit of latency into that
> point and that would mess up with the idle state selection (e.g.
> selecting a very shallow idle state might not make a lot of sense if
> that latency was high enough, because the expected wakeup might very
> well take place when the tick was being restarted), so it should
> rather be avoided IMO.

I expect the idle governor doesn't introduce many restarting tick
operations, the reason is if there have a close timer event than idle
governor can trust it to wake up CPU so in this case the idle governor
will not restart tick;  if the the timer event is long delta and the
shallow state selection is caused by factors (e.g. typical pattern),
then we need restart tick to avoid powernightmares, for this case we
can restart tick only once at the beginning for the typical pattern
interrupt events; after the typical pattern interrupt doesn't continue
then we can rely on the tick to rescue the idle state to deep one.

Thanks,
Leo Yan
