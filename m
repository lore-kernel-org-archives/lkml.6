Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48ABAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E4720817
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KRvY4a3I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E4720817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbeK0VWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:22:12 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40007 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeK0VWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:22:11 -0500
Received: by mail-pl1-f194.google.com with SMTP id u18so2823557plq.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 02:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Io+WlZd7LaxgfYug7ec/W5K4V6/qrDcCjSx+d9nJMVQ=;
        b=KRvY4a3IdHBP3MF9dHlqnzyio7e2PnmJdTtQwrXEvyDSI0J0/3tYTXM9+NLzs4/+s+
         zl78s/3sAAxS1ziiQmiKHsXWPATAUehDDftAfPVDvVrSLMQnu3lMz8ZkvwhuT+PPO1s6
         D/iysAH138jEaCJnRv+jqvwe7LrHFxvYBIUL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Io+WlZd7LaxgfYug7ec/W5K4V6/qrDcCjSx+d9nJMVQ=;
        b=SOsKpEAGKulXweAXeaH5zn/rWcJKpBcJYrcS8Nq9B5+Z0jqskdxNsM+yVvjKhYTUzX
         NFN0gWF9maiaN7itE2N6717Teq0ocSK2HEUoeFQ5QcNrZKAyjaoxjMaxKx+gpZH7ic5n
         F+LXDVbwLNs03H/0YQkg4D3sqReDoDtTkLfPkUHdLqAmsLfgT6J6v90rDWMPhQ+MvJZe
         MTuZJZYGxRqSVtRjyrehxsmE2whzoJAl6rCvTj8vqGmIRmaL43LCTXS/AfZC4L+FeDpW
         Y/27dVrJqmb5mmrr7Md9LQMUF57ZApwb37jjFrB8Ar6B65j+h0oBcty5i3lmj9v9deNS
         8LCg==
X-Gm-Message-State: AA+aEWb/ihoYcJKKtm4bLpQ12/EY1n0heU6yJ+9vuHf2kXP7GUcBCoVC
        0Kqs83D2+WiVOQIbFx+C0jwQug==
X-Google-Smtp-Source: AFSGD/WywBcgbc1JCs9csHJSRnWLjciplDABZ1d1SavajXeUXpNe8vAI/ohhVcm5cW56mWV8+UwQCw==
X-Received: by 2002:a17:902:f091:: with SMTP id go17mr32520656plb.235.1543314285216;
        Tue, 27 Nov 2018 02:24:45 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id n66sm7519331pfk.19.2018.11.27.02.24.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 02:24:44 -0800 (PST)
Date:   Tue, 27 Nov 2018 15:54:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, tkjos@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        quentin.perret@linaro.org, chris.redpath@arm.com,
        Dietmar.Eggemann@arm.com
Subject: Re: [RFC][PATCH 2/2] sched: Enqueue tasks on a cpu with only
 SCHED_IDLE tasks
Message-ID: <20181127102442.er4b6ita6ux6ipdq@vireshk-i7>
References: <cover.1543229820.git.viresh.kumar@linaro.org>
 <71a578a0c5b39169fe74ad378ee41eaf546844ac.1543229820.git.viresh.kumar@linaro.org>
 <20181126123738.mrjlykxhohttbef2@queper01-ThinkPad-T460s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126123738.mrjlykxhohttbef2@queper01-ThinkPad-T460s>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On 26-11-18, 12:37, Quentin Perret wrote:
> On Monday 26 Nov 2018 at 16:50:24 (+0530), Viresh Kumar wrote:
> > The scheduler tries to schedule a newly wakeup task on an idle CPU to
> > make sure the new task gets chance to run as soon as possible, for
> > performance reasons.
> > 
> > The SCHED_IDLE scheduling policy is used for tasks which have the lowest
> > priority and there is no hurry in running them. If all the tasks
> > currently enqueued on a CPU have their policy set to SCHED_IDLE, then
> > any new task (non SCHED_IDLE) enqueued on that CPU should normally get a
> > chance to run immediately. This patch takes advantage of this to save
> > power in some cases by avoiding waking up an idle CPU (which may be in
> > some deep idle state) and enqueuing the new task on a CPU which only has
> > SCHED_IDLE tasks.
> 
> So, avoiding to wake-up a CPU isn't always good for energy. You may
> prefer to spread tasks in order to keep the OPP low, for example. What
> you're trying to achieve here can be actively harmful for both energy
> and performance in some cases, I think.

Yeah, we may end up packing SCHED_IDLE tasks to a single CPU in this case.

We know that dynamic energy is significantly more than static energy and that is
what we should care more about. Yes, higher OPP should be avoided (apart from
performance reasons), but isn't it better (for power) to run a single CPU at
somewhat higher OPP (1GHz ?) instead of running four of them at lower OPPs (500
MHz) ?

> Also, packing will reduce your chances to go cluster idle (yes you're
> not guaranteed to go cluster idle either if you spread depending how
> the tasks align in time, but at least there's a chance). So, even from
> the idle perspective it's not obvious we actually want to do that.

But do we really want to fire all CPUs of a cluster to finish the work earlier
and go cluster idle ? We don't really believe in race-to-idle as that's why we
have the whole DVFS thing here, right ?

> And finally, the placement that this patch tries to achieve is
> inherently unbalanced IIUC. So, unless you hide this behind the EAS
> static key, you'll need to make sure the periodic/idle load balance code
> doesn't kill all the work you do in the wake-up path. So I'm not sure
> this patch really works in practice in its current state.

True, I intentionally left the load-balancer code as is to avoid larger diff for
now. The idea was to get more feedback on the whole thing before investing too
much on it.

> Now, I think you have a point by saying we could possibly be a bit
> smarter with the way we deal with SCHED_IDLE tasks, especially if they
> are going to be used more (is that a certainty BTW ?), I'm just not
> entirely convinced with the 'power' argument yet.

Todd confirmed earlier (privately) that most (?) of the android background tasks
can actually be migrated to use SCHED_IDLE stuff as there is no urgency in
scheduling them normally.

@Todd, can you please provide some inputs here as well ?

> Maybe there is something we could do if, say we need to schedule a
> SCHED_NORMAL task and all CPUs have roughly the same load and/or
> utilization numbers, then if a CPU is busy running SCHED_IDLE tasks we
> should select it in priority since we know for a fact it's not running
> anything important.
> 
> What do you think ?

Sure, I am not saying that the approach taken by this patch is the best or the
worst. We need to come up with better policy on how we can benefit from the
SCHED_IDLE policy and that's where I am looking for inputs from all of you.

Thanks for the feedback.

-- 
viresh
