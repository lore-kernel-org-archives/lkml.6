Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932111AbeEHJmr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 05:42:47 -0400
Received: from foss.arm.com ([217.140.101.70]:54992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754413AbeEHJmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 05:42:46 -0400
Date: Tue, 8 May 2018 10:42:37 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        linux-pm@vger.kernel.org, Pavan Kondeti <pkondeti@codeaurora.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH] Revert "cpufreq: schedutil: Don't restrict kthread to
 related_cpus unnecessarily"
Message-ID: <20180508094237.GA3752@e108498-lin.cambridge.arm.com>
References: <20180508073340.13114-1-dietmar.eggemann@arm.com>
 <20180508082242.bre6sjfvefhz6xc3@vireshk-i7>
 <8cf21b1a-ca6e-fed7-43c5-94c66ff5986b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cf21b1a-ca6e-fed7-43c5-94c66ff5986b@arm.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 May 2018 at 11:09:57 (+0200), Dietmar Eggemann wrote:
> On 05/08/2018 10:22 AM, Viresh Kumar wrote:
> > On 08-05-18, 08:33, Dietmar Eggemann wrote:
> > > This reverts commit e2cabe48c20efb174ce0c01190f8b9c5f3ea1d13.
> > > 
> > > Lifting the restriction that the sugov kthread is bound to the
> > > policy->related_cpus for a system with a slow switching cpufreq driver,
> > > which is able to perform DVFS from any cpu (e.g. cpufreq-dt), is not
> > > only not beneficial it also harms Enery-Aware Scheduling (EAS) on
> > > systems with asymmetric cpu capacities (e.g. Arm big.LITTLE).
> > > 
> > > The sugov kthread which does the update for the little cpus could
> > > potentially run on a big cpu. It could prevent that the big cluster goes
> > > into deeper idle states although all the tasks are running on the little
> > > cluster.
> > 
> > I think the original patch did the right thing, but that doesn't suit
> > everybody as you explained.
> > 
> > I wouldn't really revert the patch but fix my platform's cpufreq
> > driver to set dvfs_possible_from_any_cpu = false, so that other
> > platforms can still benefit from the original commit.
> 
> This would make sure that the kthreads are bound to the correct set of cpus
> for platforms with those cpufreq drivers (cpufreq-dt (h960), scmi-cpufreq,
> scpi-cpufreq) but it will also change the logic (e.g.
> sugov_should_update_freq() -> cpufreq_can_do_remote_dvfs()).
> 
> I'm still struggling to understand when a driver/platform should set
> dvfs_possible_from_any_cpu to true and what the actual benefit would be.

I assume it might be beneficial to have the kthread moving around freely
in some cases, but since it is a SCHED_DEADLINE task now it can't really
migrate anywhere anyway. So I'm not sure either if this commits still makes
sense now. Or is there another use case for this ?

Thanks,
Quentin
