Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE6FC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27F421E20
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F27F421E20
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732494AbeHISVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 14:21:34 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55932 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732432AbeHISVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 14:21:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96F5D7A9;
        Thu,  9 Aug 2018 08:56:01 -0700 (PDT)
Received: from queper01-lin (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C95BF3F5B3;
        Thu,  9 Aug 2018 08:55:58 -0700 (PDT)
Date:   Thu, 9 Aug 2018 16:55:53 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 06/14] sched/cpufreq: uclamp: add utilization clamping
 for RT tasks
Message-ID: <20180809155551.bp46sixk4u3ilcnh@queper01-lin>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-7-patrick.bellasi@arm.com>
 <20180807135403.s7jktvxmhycujeht@queper01-lin>
 <20180809154156.gdsx2vacjmp6p6dp@darkstar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809154156.gdsx2vacjmp6p6dp@darkstar>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick,

On Thursday 09 Aug 2018 at 16:41:56 (+0100), Patrick Bellasi wrote:
> > IIUC, not far below this you should still have something like:
> > 
> > 	if (rt_rq_is_runnable(&rq->rt))
> > 		return max;
> 
> Do you mean that when RT tasks are RUNNABLE we still want to got to
> MAX? Not sure to understand... since this patch is actually to clamp
> the RT class...

Argh, reading my message again it wasn't very clear indeed. Sorry about
that ...

What I'm try to say is that your patch does _not_ remove the snippet of code
above from sugov_get_util(). So I think that when a RT task is runnable,
you will not reach the end of the function where the clamping is done.
And this is not what you want AFAICT.

Does that make any sense ?

> 
> > So you won't reach the actual clamping code at the end of the function
> > when a RT task is runnable no?
> 
> ... mmm... no... this patch is to clamp RT tasks... Am I missing
> something?
> 
> > Also, I always had the feeling that the default for RT should be
> > util_min == 1024, and then users could decide to lower the bar if they
> > want to.
> 
> Mmm... good point! This would keep the policy unaltered for RT tasks.
> 
> I want to keep sched class specific code in uclamp at minimum but
> likely this should be achievable by just properly initializing the
> task-specific util_min for RT tasks, if the original task has
> UCLAM_NOT_VALID.

+1, it'd be nice to keep the cross-class mess to a minimum IMO. But
hopefully this RT thing isn't too ugly to implement ...

> 
> > For the specific case of RT, that feels more natural than
> > applying a max util clamp IMO. What do you think ?
> 
> I'll look better into this for the next posting!

Sounds good :-)

Thanks,
Quentin
