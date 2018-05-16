Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbeEPEtW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 00:49:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:1167 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751046AbeEPEtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 00:49:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="41300339"
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: srinivas.pandruvada@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, bp@suse.de, lenb@kernel.org,
        rjw@rjwysocki.net, mgorman@techsingularity.net
Cc: x86@kernel.org, linux-pm@vger.kernel.org, viresh.kumar@linaro.org,
        juri.lelli@arm.com, linux-kernel@vger.kernel.org
Subject: [RFC/RFT] [PATCH 00/10] Intel_pstate: HWP Dynamic performance boost
Date: Tue, 15 May 2018 21:49:01 -0700
Message-Id: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series tries to address some concern in performance particularly with IO
workloads (Reported by Mel Gorman), when HWP is using intel_pstate powersave
policy.

Background
HWP performance can be controlled by user space using sysfs interface for
max/min frequency limits and energy performance preference settings. Based on
workload characteristics these can be adjusted from user space. These limits
are not changed dynamically by kernel based on workload.

By default HWP defaults to energy performance preference value of 0x80 on
majority of platforms(Scale is 0-255, 0 is max performance and 255 is min).
This value offers best performance/watt and for majority of server workloads
performance doesn't suffer. Also users always have option to use performance
policy of intel_pstate, to get best performance. But user tend to run with
out of box configuration, which is powersave policy on most of the distros.

In some case it is possible to dynamically adjust performance, for example,
when a CPU is woken up due to IO completion or thread migrate to a new CPU. In
this case HWP algorithm will take some time to build utilization and ramp up
P-states. So this may results in lower performance for some IO workloads and
workloads which tend to migrate. The idea of this patch series is to
temporarily boost performance dynamically in these cases. This is only
applicable only when user is using powersave policy, not in performance policy.

Results on a Skylake server:

Benchmark                       Improvement %
----------------------------------------------------------------------
dbench                          50.36
thread IO bench (tiobench)      10.35
File IO                         9.81
sqlite                          15.76
X264 -104 cores                 9.75

Spec Power                      (Negligible impact 7382 Vs. 7378)
Idle Power                      No change observed
-----------------------------------------------------------------------

HWP brings in best performace/watt at EPP=0x80. Since we are boosting
EPP here to 0, the performance/watt drops upto 10%. So there is a power
penalty of these changes.

Also Mel Gorman provided test results on a prior patchset, which shows
benifits of this series.

Peter Zijlstra (1):
  x86,sched: Add support for frequency invariance

Srinivas Pandruvada (9):
  cpufreq: intel_pstate: Conditional frequency invariant accounting
  cpufreq: intel_pstate: Utility functions to boost HWP performance
    limits
  cpufreq: intel_pstate: Add update_util_hook for HWP
  cpufreq: intel_pstate: HWP boost performance on IO Wake
  cpufreq / sched: Add interface to get utilization values
  cpufreq: intel_pstate: HWP boost performance on busy task migrate
  cpufreq: intel_pstate: Dyanmically update busy pct
  cpufreq: intel_pstate: New sysfs entry to control HWP boost
  cpufreq: intel_pstate: enable boost for SKX

 arch/x86/include/asm/topology.h |  29 +++++
 arch/x86/kernel/smpboot.c       | 196 +++++++++++++++++++++++++++++-
 drivers/cpufreq/intel_pstate.c  | 260 +++++++++++++++++++++++++++++++++++++++-
 include/linux/sched/cpufreq.h   |   2 +
 kernel/sched/core.c             |   1 +
 kernel/sched/cpufreq.c          |  23 ++++
 kernel/sched/sched.h            |   7 ++
 7 files changed, 513 insertions(+), 5 deletions(-)

-- 
2.9.5
