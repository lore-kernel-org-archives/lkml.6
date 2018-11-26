Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB7AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 12:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5CA20660
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 12:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5CA20660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbeKZXbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 18:31:50 -0500
Received: from foss.arm.com ([217.140.101.70]:35614 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbeKZXbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 18:31:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81F6B355D;
        Mon, 26 Nov 2018 04:37:49 -0800 (PST)
Received: from queper01-ThinkPad-T460s (queper01-thinkpad-t460s.cambridge.arm.com [10.1.32.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F11E53F5AF;
        Mon, 26 Nov 2018 04:37:46 -0800 (PST)
Date:   Mon, 26 Nov 2018 12:37:41 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, tkjos@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        quentin.perret@linaro.org, chris.redpath@arm.com,
        Dietmar.Eggemann@arm.com
Subject: Re: [RFC][PATCH 2/2] sched: Enqueue tasks on a cpu with only
 SCHED_IDLE tasks
Message-ID: <20181126123738.mrjlykxhohttbef2@queper01-ThinkPad-T460s>
References: <cover.1543229820.git.viresh.kumar@linaro.org>
 <71a578a0c5b39169fe74ad378ee41eaf546844ac.1543229820.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71a578a0c5b39169fe74ad378ee41eaf546844ac.1543229820.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On Monday 26 Nov 2018 at 16:50:24 (+0530), Viresh Kumar wrote:
> The scheduler tries to schedule a newly wakeup task on an idle CPU to
> make sure the new task gets chance to run as soon as possible, for
> performance reasons.
> 
> The SCHED_IDLE scheduling policy is used for tasks which have the lowest
> priority and there is no hurry in running them. If all the tasks
> currently enqueued on a CPU have their policy set to SCHED_IDLE, then
> any new task (non SCHED_IDLE) enqueued on that CPU should normally get a
> chance to run immediately. This patch takes advantage of this to save
> power in some cases by avoiding waking up an idle CPU (which may be in
> some deep idle state) and enqueuing the new task on a CPU which only has
> SCHED_IDLE tasks.

So, avoiding to wake-up a CPU isn't always good for energy. You may
prefer to spread tasks in order to keep the OPP low, for example. What
you're trying to achieve here can be actively harmful for both energy
and performance in some cases, I think.

Also, packing will reduce your chances to go cluster idle (yes you're
not guaranteed to go cluster idle either if you spread depending how
the tasks align in time, but at least there's a chance). So, even from
the idle perspective it's not obvious we actually want to do that.

And finally, the placement that this patch tries to achieve is
inherently unbalanced IIUC. So, unless you hide this behind the EAS
static key, you'll need to make sure the periodic/idle load balance code
doesn't kill all the work you do in the wake-up path. So I'm not sure
this patch really works in practice in its current state.

Now, I think you have a point by saying we could possibly be a bit
smarter with the way we deal with SCHED_IDLE tasks, especially if they
are going to be used more (is that a certainty BTW ?), I'm just not
entirely convinced with the 'power' argument yet.

Maybe there is something we could do if, say we need to schedule a
SCHED_NORMAL task and all CPUs have roughly the same load and/or
utilization numbers, then if a CPU is busy running SCHED_IDLE tasks we
should select it in priority since we know for a fact it's not running
anything important.

What do you think ?

Thanks,
Quentin
