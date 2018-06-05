Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbeFEK54 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 06:57:56 -0400
Received: from foss.arm.com ([217.140.101.70]:54506 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751707AbeFEK5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 06:57:54 -0400
Date: Tue, 5 Jun 2018 11:57:36 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH v5 00/10] track CPU utilization
Message-ID: <20180605105721.GA12193@e108498-lin.cambridge.arm.com>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <CAKfTPtB0MHN3=VbS4mYqVH_0fv1WwKq6N1-ogU84mNUAxfCwjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtB0MHN3=VbS4mYqVH_0fv1WwKq6N1-ogU84mNUAxfCwjw@mail.gmail.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Tuesday 05 Jun 2018 at 10:36:26 (+0200), Vincent Guittot wrote:
> Hi Quentin,
> 
> On 25 May 2018 at 15:12, Vincent Guittot <vincent.guittot@linaro.org> wrote:
> > This patchset initially tracked only the utilization of RT rq. During
> > OSPM summit, it has been discussed the opportunity to extend it in order
> > to get an estimate of the utilization of the CPU.
> >
> > - Patches 1-3 correspond to the content of patchset v4 and add utilization
> >   tracking for rt_rq.
> >
> > When both cfs and rt tasks compete to run on a CPU, we can see some frequency
> > drops with schedutil governor. In such case, the cfs_rq's utilization doesn't
> > reflect anymore the utilization of cfs tasks but only the remaining part that
> > is not used by rt tasks. We should monitor the stolen utilization and take
> > it into account when selecting OPP. This patchset doesn't change the OPP
> > selection policy for RT tasks but only for CFS tasks
> >
> > A rt-app use case which creates an always running cfs thread and a rt threads
> > that wakes up periodically with both threads pinned on same CPU, show lot of
> > frequency switches of the CPU whereas the CPU never goes idles during the
> > test. I can share the json file that I used for the test if someone is
> > interested in.
> >
> > For a 15 seconds long test on a hikey 6220 (octo core cortex A53 platfrom),
> > the cpufreq statistics outputs (stats are reset just before the test) :
> > $ cat /sys/devices/system/cpu/cpufreq/policy0/stats/total_trans
> > without patchset : 1230
> > with patchset : 14
> 
> I have attached the rt-app json file that I use for this test

Thank you very much ! I did a quick test with a much simpler fix to this
RT-steals-time-from-CFS issue using just the existing scale_rt_capacity().
I get the following results on Hikey960:

Without patch:
   cat /sys/devices/system/cpu/cpufreq/policy0/stats/total_trans
   12
   cat /sys/devices/system/cpu/cpufreq/policy4/stats/total_trans
   640
With patch
   cat /sys/devices/system/cpu/cpufreq/policy0/stats/total_trans
   8
   cat /sys/devices/system/cpu/cpufreq/policy4/stats/total_trans
   12

Yes the rt_avg stuff is out of sync with the PELT signal, but do you think
this is an actual issue for realistic use-cases ?

What about the diff below (just a quick hack to show the idea) applied
on tip/sched/core ?

---8<---
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index a8ba6d1f262a..23a4fb1c2c25 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -180,9 +180,12 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
 	sg_cpu->util_dl  = cpu_util_dl(rq);
 }
 
+unsigned long scale_rt_capacity(int cpu);
 static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 {
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
+	int cpu = sg_cpu->cpu;
+	unsigned long util, dl_bw;
 
 	if (rq->rt.rt_nr_running)
 		return sg_cpu->max;
@@ -197,7 +200,14 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 	 * util_cfs + util_dl as requested freq. However, cpufreq is not yet
 	 * ready for such an interface. So, we only do the latter for now.
 	 */
-	return min(sg_cpu->max, (sg_cpu->util_dl + sg_cpu->util_cfs));
+	util = arch_scale_cpu_capacity(NULL, cpu) * scale_rt_capacity(cpu);
+	util >>= SCHED_CAPACITY_SHIFT;
+	util = arch_scale_cpu_capacity(NULL, cpu) - util;
+	util += sg_cpu->util_cfs;
+	dl_bw = (rq->dl.this_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
+
+	/* Make sure to always provide the reserved freq to DL. */
+	return max(util, dl_bw);
 }
 
 static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time, unsigned int flags)
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f01f0f395f9a..0e87cbe47c8b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7868,7 +7868,7 @@ static inline int get_sd_load_idx(struct sched_domain *sd,
 	return load_idx;
 }
 
-static unsigned long scale_rt_capacity(int cpu)
+unsigned long scale_rt_capacity(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 	u64 total, used, age_stamp, avg;
--->8---



> 
> >
> > If we replace the cfs thread of rt-app by a sysbench cpu test, we can see
> > performance improvements:
> >
> > - Without patchset :
> > Test execution summary:
> >     total time:                          15.0009s
> >     total number of events:              4903
> >     total time taken by event execution: 14.9972
> >     per-request statistics:
> >          min:                                  1.23ms
> >          avg:                                  3.06ms
> >          max:                                 13.16ms
> >          approx.  95 percentile:              12.73ms
> >
> > Threads fairness:
> >     events (avg/stddev):           4903.0000/0.00
> >     execution time (avg/stddev):   14.9972/0.00
> >
> > - With patchset:
> > Test execution summary:
> >     total time:                          15.0014s
> >     total number of events:              7694
> >     total time taken by event execution: 14.9979
> >     per-request statistics:
> >          min:                                  1.23ms
> >          avg:                                  1.95ms
> >          max:                                 10.49ms
> >          approx.  95 percentile:              10.39ms
> >
> > Threads fairness:
> >     events (avg/stddev):           7694.0000/0.00
> >     execution time (avg/stddev):   14.9979/0.00
> >
> > The performance improvement is 56% for this use case.
> >
> > - Patches 4-5 add utilization tracking for dl_rq in order to solve similar
> >   problem as with rt_rq
> >
> > - Patches 6 uses dl and rt utilization in the scale_rt_capacity() and remove
> >   dl and rt from sched_rt_avg_update
> >
> > - Patches 7-8 add utilization tracking for interrupt and use it select OPP
> >   A test with iperf on hikey 6220 gives:
> >     w/o patchset            w/ patchset
> >     Tx 276 Mbits/sec        304 Mbits/sec +10%
> >     Rx 299 Mbits/sec        328 Mbits/sec +09%
> >
> >     8 iterations of iperf -c server_address -r -t 5
> >     stdev is lower than 1%
> >     Only WFI idle state is enable (shallowest arm idle state)
> >
> > - Patches 9 removes the unused sched_avg_update code
> >
> > - Patch 10 removes the unused sched_time_avg_ms
> >
> > Change since v3:
> > - add support of periodic update of blocked utilization
> > - rebase on lastest tip/sched/core
> >
> > Change since v2:
> > - move pelt code into a dedicated pelt.c file
> > - rebase on load tracking changes
> >
> > Change since v1:
> > - Only a rebase. I have addressed the comments on previous version in
> >   patch 1/2
> >
> > Vincent Guittot (10):
> >   sched/pelt: Move pelt related code in a dedicated file
> >   sched/rt: add rt_rq utilization tracking
> >   cpufreq/schedutil: add rt utilization tracking
> >   sched/dl: add dl_rq utilization tracking
> >   cpufreq/schedutil: get max utilization
> >   sched: remove rt and dl from sched_avg
> >   sched/irq: add irq utilization tracking
> >   cpufreq/schedutil: take into account interrupt
> >   sched: remove rt_avg code
> >   proc/sched: remove unused sched_time_avg_ms
> >
> >  include/linux/sched/sysctl.h     |   1 -
> >  kernel/sched/Makefile            |   2 +-
> >  kernel/sched/core.c              |  38 +---
> >  kernel/sched/cpufreq_schedutil.c |  24 ++-
> >  kernel/sched/deadline.c          |   7 +-
> >  kernel/sched/fair.c              | 381 +++----------------------------------
> >  kernel/sched/pelt.c              | 395 +++++++++++++++++++++++++++++++++++++++
> >  kernel/sched/pelt.h              |  63 +++++++
> >  kernel/sched/rt.c                |  10 +-
> >  kernel/sched/sched.h             |  57 ++++--
> >  kernel/sysctl.c                  |   8 -
> >  11 files changed, 563 insertions(+), 423 deletions(-)
> >  create mode 100644 kernel/sched/pelt.c
> >  create mode 100644 kernel/sched/pelt.h
> >
> > --
> > 2.7.4
> >
