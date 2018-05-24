Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935350AbeEXBsB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 21:48:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:42101 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935217AbeEXBr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 21:47:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,435,1520924400";
   d="scan'208";a="41747912"
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: lenb@kernel.org, rjw@rjwysocki.net, peterz@infradead.org,
        mgorman@techsingularity.net
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, viresh.kumar@linaro.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC/RFT] [PATCH v2 0/6] Intel_pstate: HWP Dynamic performance boost
Date: Wed, 23 May 2018 18:47:32 -0700
Message-Id: <20180524014738.52924-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2
This is a much simpler version than the previous one and only consider IO
boost, using the existing mechanism. There is no change in this series
beyond intel_pstate driver.

Once PeterZ finishes his work on frequency invariant, I will revisit
thread migration optimization in HWP mode.

Other changes:
- Gradual boost instead of single step as suggested by PeterZ.
- Cross CPU synchronization concerns identified by Rafael.
- Split the patch for HWP MSR value caching as suggested by PeterZ.

Not changed as suggested:
There is no architecture way to identify platform with Per-core
P-states, so still have to enable feature based on CPU model.

-----------
v1

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

Srinivas Pandruvada (6):
  cpufreq: intel_pstate: Cache last HWP capability/request value
  cpufreq: intel_pstate: Add HWP boost utility functions
  cpufreq: intel_pstate: Add update_util_hook for HWP
  cpufreq: intel_pstate: HWP boost performance on IO wakeup
  cpufreq: intel_pstate: New sysfs entry to control HWP boost
  cpufreq: intel_pstate: enable boost for SKX

 drivers/cpufreq/intel_pstate.c | 183 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 179 insertions(+), 4 deletions(-)

-- 
2.13.6
