Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 330CB60555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932619AbeFFKiP (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:38:15 -0400
Received: from foss.arm.com ([217.140.101.70]:39190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932518AbeFFKiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:38:14 -0400
Date: Wed, 6 Jun 2018 11:38:09 +0100
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>, Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH 2/2] sched/fair: util_est: add running_sum tracking
Message-ID: <20180606103809.GG31675@e110439-lin>
References: <20180604160600.22052-1-patrick.bellasi@arm.com>
 <20180604160600.22052-3-patrick.bellasi@arm.com>
 <CAKfTPtD8RDxT=-oO2VYJRbtwoEyEKEAau-Ad-bAd8L2T2zKWEg@mail.gmail.com>
 <20180605151129.GC32302@e110439-lin>
 <20180606082640.GA14694@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606082640.GA14694@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On 06-Jun 10:26, Vincent Guittot wrote:

[...]

> For the above 2 tasks of the example example we have the pattern
> 
> Task 1
> state       RRRRSSSSSSERRRRSSSSSSERRRRSSSSSS
> util_avg    AAAADDDDDD AAAADDDDDD AAAADDDDDD
> 
> Task 2
> state       WWWWRRRRSSEWWWWRRRRSSEWWWWRRRRSS
> util_avg    DDDDAAAADD DDDDAAAADD DDDDAAAADD
> running_avg     AAAADDC    AAAADDC    AAAADD
> 
> R : Running 1ms, S: Sleep 1ms , W: Wait 1ms, E: Enqueue event 
> A: Accumulate 1ms, D: Decay 1ms, C: Copy util_avg value
> 
> the util_avg of T1 and T2 have the same pattern which is:
>   AAAADDDDDDAAAADDDDDDAAAADDDDDD
> and as a result, the same value which represents their utilization
> 
> For the running_avg of T2, there is only 2 decays aftert the last running
> phase and before the next enqueue
> so the pattern will be AAAADDAAAA
> instead of the         AAAADDDDDDAAAA
> 
> the runninh_avg will report a higher value than reality

Right!... Your example above is really useful, thanks.

Reasoning on the same line, we can easily see that a 50% CFS task
co-scheduled with a 50% RT task, which delays the CFS one and has the
same period,  will make the CFS task appear as a 100% task.

Which is definitively not what we want to sample as estimated
utilization.

The good news, if we like, is instead that util_avg is already
correctly reporting 50% at the end of each activation and thus, when
we collect util_est samples we already have the best utilization value
we can collect for a task.

The only time we collect "wrong" estimation samples is when there
is not idle time, thus eventually util_est should be improved by
discarding samples in that cases... but I'm not entirely sure if and
how we can detect them.

Or just to ensure we have idle time... as you are proposing in
the other thread.

Thanks again for pointing out the issue above.

-- 
#include <best/regards.h>

Patrick Bellasi
