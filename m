Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id XJHQDOzrGFslbAAAmS7hNA
	; Thu, 07 Jun 2018 08:25:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7E38E607F7; Thu,  7 Jun 2018 08:25:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EE3776063F;
	Thu,  7 Jun 2018 08:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EE3776063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932708AbeFGIZ3 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:25:29 -0400
Received: from foss.arm.com ([217.140.101.70]:48138 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932240AbeFGIZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:25:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1F7480D;
        Thu,  7 Jun 2018 01:25:25 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.210.84])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCE913F59D;
        Thu,  7 Jun 2018 01:25:23 -0700 (PDT)
Date: Thu, 7 Jun 2018 09:25:22 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: luca abeni <luca.abeni@santannapisa.it>
Cc: Claudio Scordino <claudio@evidence.eu.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH v5 00/10] track CPU utilization
Message-ID: <20180607082522.GM10870@e108498-lin.cambridge.arm.com>
References: <CAKfTPtB0MHN3=VbS4mYqVH_0fv1WwKq6N1-ogU84mNUAxfCwjw@mail.gmail.com>
 <20180605105721.GA12193@e108498-lin.cambridge.arm.com>
 <20180605121153.GD16081@localhost.localdomain>
 <20180605130548.GB12193@e108498-lin.cambridge.arm.com>
 <20180605131518.GG16081@localhost.localdomain>
 <20180605140101.GE12193@e108498-lin.cambridge.arm.com>
 <20180605141317.GJ16081@localhost.localdomain>
 <6c2dc1aa-3e19-be14-0ed8-b29003c72e61@evidence.eu.com>
 <20180606132046.GC10870@e108498-lin.cambridge.arm.com>
 <20180606230536.2c0ae587@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606230536.2c0ae587@nowhere>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

On Wednesday 06 Jun 2018 at 23:05:36 (+0200), luca abeni wrote:
> Hi,
> 
> On Wed, 6 Jun 2018 14:20:46 +0100
> Quentin Perret <quentin.perret@arm.com> wrote:
> [...]
> > > However, IMHO, these are corner cases and in the average case it is
> > > better to rely on running_bw and reduce the CPU frequency
> > > accordingly.  
> > 
> > My point was that accepting to go at a lower frequency than required
> > by this_bw is fundamentally unsafe. If you're at a low frequency when
> > a DL task starts, there are real situations where you won't be able
> > to increase the frequency immediately, which can eventually lead to
> > missing deadlines. Now, if this risk is known, has been discussed,
> > and is accepted, that's fair enough. I'm just too late for the
> > discussion :-)
> 
> Well, our conclusion was that this issue can be addressed when
> designing the scheduling parameters:
> - If we do not consider frequency scaling, a task can respect its
>   deadlines if the SCHED_DEADLINE runtime is larger than the task's
>   execution time and the SCHED_DEADLINE period is smaller than the
>   task's period (and if some kind of "global" admission test is
>   respected)
> - Considering frequency scaling (and 0-time frequency switches), the
>   SCHED_DEADLINE runtime must be larger than the task execution time at
>   the highest frequency
> - If the frequency switch time is larger than 0, then the
>   SCHED_DEADLINE runtime must be larger than the task execution time
>   (at the highest frequency) plus the frequency switch time
> 
> If this third condition is respected, I think that deadline misses can
> be avoided even if running_bw is used (and the CPU takes a considerable
> time to switch frequency). Of course, this requires an over-allocation
> of runtime (and the global admission test has more probabilities to
> fail)...

Ah, right, this third condition should definitely be a valid workaround
to the issue I mentioned earlier. And the runtime parameter is already
very much target-dependent I guess, so it should be fine to add another
target-specific component (the frequency-switching time) to the runtime
estimation.

And, if you really need to have tight runtimes to fit all of your tasks,
then you should just use a fixed frequency I guess ... At least the
current implementation gives a choice to the user between being
energy-efficient using sugov with over-allocated runtimes and having
tighter runtimes with the performance/powersave/userspace governor, so
that's all good :-)

Thank you very much,
Quentin
