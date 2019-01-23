Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2311C282C5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACB220870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfAWOZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:25:02 -0500
Received: from foss.arm.com ([217.140.101.70]:41906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfAWOZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:25:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D969A78;
        Wed, 23 Jan 2019 06:25:01 -0800 (PST)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78BE93F6A8;
        Wed, 23 Jan 2019 06:24:58 -0800 (PST)
Date:   Wed, 23 Jan 2019 14:24:55 +0000
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v6 08/16] sched/cpufreq: uclamp: Add utilization clamping
 for FAIR tasks
Message-ID: <20190123142455.454u4w253xaxzar3@e110439-lin>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-9-patrick.bellasi@arm.com>
 <20190122171314.GS27931@hirez.programming.kicks-ass.net>
 <20190122181831.a4w65qcivx4hua6d@e110439-lin>
 <20190123095219.GV27931@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123095219.GV27931@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-Jan 10:52, Peter Zijlstra wrote:
> On Tue, Jan 22, 2019 at 06:18:31PM +0000, Patrick Bellasi wrote:
> > On 22-Jan 18:13, Peter Zijlstra wrote:
> > > On Tue, Jan 15, 2019 at 10:15:05AM +0000, Patrick Bellasi wrote:

[...]

> > If a task is not clamped we execute it at its required utilization or
> > even max frequency in case of wakeup from IO.
> > 
> > When a task is util_max clamped instead, we are saying that we don't
> > care to run it above the specified clamp value and, if possible, we
> > should run it below that capacity level.
> > 
> > If that's the case, why this clamping hints should not be enforced on
> > IO wakeups too?
> > 
> > At the end it's still a user-space decision, we basically allow
> > userspace to defined what's the max IO boost they like to get.
> 
> Because it is the wrong knob for it.
> 
> Ideally we'd extend the IO-wait state to include the device-busy state
> at the time of sleep. At the very least double state io_schedule() state
> space from 1 to 2 bits, where we not only indicate: yes this is an
> IO-sleep, but also can indicate device saturation. When the device is
> saturated, we don't need to boost further.
> 
> (this binary state will ofcourse cause oscilations where we drop the
> freq, drop device saturation, then ramp the freq, regain device
> saturation etc..)
> 
> However, doing this is going to require fairly massive surgery on our
> whole IO stack.
> 
> Also; how big of a problem is 'supriouos' boosting really? Joel tried to
> introduce a boost_max tunable, but the grandual boosting thing was good
> enough at the time.

Ok then, I'll drop the clamp on IOBoost... you right and moreover we
can always investigate for a better solution in the future with a
real use-case on hand.

Cheers.

-- 
#include <best/regards.h>

Patrick Bellasi
