Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752879AbeEKNPZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 09:15:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41170 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750758AbeEKNPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 09:15:23 -0400
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Subject: [PATCH v2 0/3] Improve schedutil integration for FAIR tasks
Date: Fri, 11 May 2018 14:15:06 +0100
Message-Id: <20180511131509.16275-1-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an update of:

   https://lkml.org/lkml/2018/5/10/346

Where, apart from some minor clean-ups, I've added a cpufreq_enqueue() wrapper
function for cpufreq_update_util() to be used in enqueue_task_fair().
That's because:
 - it helps to keep more clean the enqueue_task_fair()
   by collecting all cpufreq related code into a single function
 - it fixes the flags masking issue reported by Peter
 - it allows to add a compilation guard for !SMP systems
   where we never migrate tasks and thus we should never set the
   SCHED_CPUFREQ_MIGRATION flag.

The SCHED_CPUFREQ_MIGRATION flag was previously set from update_load_avg()
which is empty defined for !SMP. Now that we update schedutil at the end of
enqueue_task_fair, we have to specifically address this case.

Still, the resulting code, it's more clean in defining when schedutil is going
to be updated and under which conditions/flags.

Again, I want to call out that with the last patch there is one function change
wrt mainline. When the CPU controller is in use, and a task is queued into a
throttled RQ, the behavior of the IOWAIT flag is different.
Currently we set the flag (and thus boost the frequency to max) even tough we
know the task is not going to run. With the patch the flag is not set, and thus
the frequency not bumped, which seems to most correct behavior to me.

Moreover, the IOWAIT flag for this task is lost forever, since when the RQ in
unthrottled we do not walk the tasks to collect their flags. However, given the
task has been already delayed because of the throttled RQ, perhaps a delayed
IOWAIT boost also does not make a lot of sense. What do you think?

Finally, Viresh suggested some patches could/should have "stable" in
Cc but I was not entirely sure. Thus, I've left it as a maintainers call.

Cheers Patrick

Changes in v2:
 - improved comment in enqueue_task_fair (Peter)
 - fixed flags masking (Peter)
 - fixed !CONFIG_SMP build (0-DAY)
   by using a cpufreq_enqueue wrapper to avoid setting the
   SCHED_CPUFREQ_MIGRATION flag on !SMP systems
 - removed blank lines (Viresh)
 - add "Acked-by" Viresh tag to the first two patches

Patrick Bellasi (3):
  sched/cpufreq: always consider blocked FAIR utilization
  sched/fair: util_est: update before schedutil
  sched/fair: schedutil: explicit update only when required

 kernel/sched/cpufreq_schedutil.c | 17 ++++----
 kernel/sched/fair.c              | 93 +++++++++++++++++++++-------------------
 2 files changed, 56 insertions(+), 54 deletions(-)

-- 
2.15.1
