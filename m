Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809B9C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDC1208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="heDdPktu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BDC1208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965430AbeFSItN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:49:13 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34485 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756459AbeFSItK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:49:10 -0400
Received: by mail-pg0-f66.google.com with SMTP id q4-v6so8857776pgr.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 01:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y6B6ehP4WMNrEB1YI+wWEPK7JftTyPfiBMW+2r0RQMc=;
        b=heDdPktulGJZn0wmGgClraZg/zWIjDYvIJLkJ7aSMa8NsSfKeYoO1LidIaJRfC/WOg
         kdiQXfZ946Xok5Hz6Z6/3KSWn602IBWGGc5KFlLIIAX3+RbH4PHv0Y4mS06Zcmk063jb
         qaPSXb+XmaXeTMC18CPedR27Yk1k+JG/gfRqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y6B6ehP4WMNrEB1YI+wWEPK7JftTyPfiBMW+2r0RQMc=;
        b=pdTKaFh/i8D03VCm080HHcenYp43UW4T7o31XmQbZv8QWbkHccjs0Yov1x57v3cgm6
         7BhF07DldyHrkJqnkspuI4FFfa3V0hBBTI2D2L1ydWycdtpfD2kOY8AI9TqM22BlNPld
         z4u7wu5nAst6FddCWJ7ic4KhOBfBMolEsw971n2wjLve4lS4yFm+DFrS7xxNTYMXVF/x
         hAG8/uUTFCN7q7i+/8syJwdvRu0BKqMLRnmamMvz0Xwlf3MqF1a3+MWeWWa7vdTUSRWs
         14rU1mJB9WG3+lWU+4nrfXErlEntAHLC2uY8+rCSB0BkJRC0qglHRIrge/SIKNMBxpUE
         WaHA==
X-Gm-Message-State: APt69E1Xo7QjKLKOdJs/DjMZi0XqJ3waPAAO2CRbbRGwJRKoYyFhJGAK
        QEgQ62BnC+Vtzl1/RNlfoc398g==
X-Google-Smtp-Source: ADUXVKKy1GmP+/kWaPVlxbj08HPQFPn7mAl3GHlLIUYa9/AwQck0EFcQYGk8iAlhU2Y3RP/Ze9mLeA==
X-Received: by 2002:a63:79c5:: with SMTP id u188-v6mr13955826pgc.111.1529398149864;
        Tue, 19 Jun 2018 01:49:09 -0700 (PDT)
Received: from localhost ([122.171.103.96])
        by smtp.gmail.com with ESMTPSA id p22-v6sm38374769pfj.166.2018.06.19.01.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 01:49:09 -0700 (PDT)
Date:   Tue, 19 Jun 2018 14:19:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v8] powercap/drivers/idle_injection: Add an idle
 injection framework
Message-ID: <20180619084907.3ccawclk4dqzixrl@vireshk-i7>
References: <1529387906-3838-1-git-send-email-daniel.lezcano@linaro.org>
 <20180619062227.uyan2t63fqwxj3eb@vireshk-i7>
 <bbc73374-194d-2c3f-fce7-e4b6de0a12bb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbc73374-194d-2c3f-fce7-e4b6de0a12bb@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-06-18, 10:00, Daniel Lezcano wrote:
> On 19/06/2018 08:22, Viresh Kumar wrote:
> > On 19-06-18, 07:58, Daniel Lezcano wrote:
> >> +++ b/drivers/powercap/idle_injection.c
> >> @@ -0,0 +1,375 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright 2018 Linaro Limited
> >> + *
> >> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> + *
> >> + * The idle injection framework proposes a way to force a cpu to enter
> >> + * an idle state during a specified amount of time for a specified
> >> + * period.
> >> + *
> >> + * It relies on the smpboot kthreads which handles, via its main loop,
> >> + * the common code for hotplugging and [un]parking.
> >> + *
> >> + * At init time, all the kthreads are created.
> >> + *
> >> + * A cpumask is specified as parameter for the idle injection
> >> + * registering function. The kthreads will be synchronized regarding
> >> + * this cpumask.
> >> + *
> >> + * The idle + run duration is specified via the helpers and then the
> >> + * idle injection can be started at this point.
> >> + *
> >> + * A kthread will call play_idle() with the specified idle duration
> >> + * from above.
> >> + *
> >> + * A timer is set after waking up all the tasks, to the next idle
> >> + * injection cycle.
> >> + *
> >> + * The task handling the timer interrupt will wakeup all the kthreads
> >> + * belonging to the cpumask.
> >> + *
> >> + * Stopping the idle injection is synchonuous, when the function
> > 
> >                                      synchronous
> > 
> >> + * returns, there is the guarantee there is no more idle injection
> >> + * kthread in activity.
> >> + *
> >> + * It is up to the user of this framework to provide a lock at an
> >> + * upper level to prevent stupid things to happen, like starting while
> >> + * we are unregistering.
> >> + */
> > 
> >> +static void idle_injection_wakeup(struct idle_injection_device *ii_dev)
> >> +{
> >> +	struct idle_injection_thread *iit;
> >> +	unsigned int cpu;
> >> +
> >> +	for_each_cpu_and(cpu, to_cpumask(ii_dev->cpumask), cpu_online_mask) {
> >> +		iit = per_cpu_ptr(&idle_injection_thread, cpu);
> >> +		iit->should_run = 1;
> >> +		wake_up_process(iit->tsk);
> >> +	}
> >> +}
> > 
> > Thread A                                        Thread B
> > 
> >                                                 CPU3 hotplug out
> >                                                 -> idle_injection_park()
> >                                                   iit(of-CPU3)->should_run = 0;
> > 
> > idle_injection_wakeup()
> >  for_each_cpu_and(online)..
> >    CPU3-selected
> >                                                 clear CPU3 from cpu-online mask.
> > 
> > 
> >    iit(of-CPU3)->should_run = 1;
> >    wake_up_process()
> > 
> > With the above sequence of events, is it possible that the iit->should_run
> > variable is set to 1 while the CPU is offlined ? And so the crash we discussed
> > in the previous version may still exist ? Sorry I am not able to take my mind
> > away from thinking about these stupid races :(
> 
> If I refer to previous Peter's comment about a similar race, I think it
> is possible.
> 
> I guess setting the should_run flag to zero in the unpark() must fix the
> issue also.

Right. But since you are already taking the hotplug lock in stop-idle-injection,
you can iterate over all CPUs of a mask instead of the online ones. That would
be one callback less to run at every unpark (though there wouldn't be so many of
them I believe).

-- 
viresh
