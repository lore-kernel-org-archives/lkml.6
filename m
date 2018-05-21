Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbeEUOZZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 10:25:25 -0400
Received: from foss.arm.com ([217.140.101.70]:50838 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752536AbeEUOZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 10:25:23 -0400
From: Quentin Perret <quentin.perret@arm.com>
To: peterz@infradead.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com,
        joelaf@google.com, smuckle@google.com, adharmap@quicinc.com,
        skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org, quentin.perret@arm.com
Subject: [RFC PATCH v3 00/10] Energy Aware Scheduling
Date: Mon, 21 May 2018 15:24:55 +0100
Message-Id: <20180521142505.6522-1-quentin.perret@arm.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Overview

The Energy Aware Scheduler (EAS) based on Morten Rasmussen's posting on
LKML [1] is currently part of the AOSP Common Kernel and runs on today's
smartphones with Arm's big.LITTLE CPUs. This series implements a new and
largely simplified version of EAS based on an Energy Model (EM) of the
platform with only costs for the active states of the CPUs.

Previous versions of this patch-set (i.e. [2]) relied on the PM_OPP
framework to provide the scheduler with an Energy Model. As agreed during
the 2nd OSPM sumit, this new revision removes this dependency by
implementing a new independent EM framework. This framework aggregates
the power values provided by drivers into a table for each frequency
domain in the system. Those tables are then available to interested
clients (e.g. the task scheduler or the thermal subsystem) via
platform-agnostic APIs. The topology code of the scheduler is modified
accordingly to take a reference on the online frequency domains, hence
guaranteeing a fast access to the shared EM data structures in
latency-sensitive code paths. The modifications required to make the
thermal subsystem use the new Energy Model framework are not covered by
this patch-set.

The v2 of this patch-set used a per-scheduling domain overutilization
flag, which has been abandoned in v3 in favour of a simpler but equally
efficient system-wide implementation attached to the root domain (like
the existing overload flag). Consequently, the integration of EAS in the
wake-up path has been reworked to accommodate this change using a
scheduling domain shortcut.

The patch-set is now arranged as follows:
 - Patches 1-2 refactor code from schedutil and the scheduler to
   simplify the implementation of the EM framework;
 - Patches 3-4 introduce the centralized EM framework;
 - Patch 5 changes the scheduler topology code to make it aware of the EM;
 - Patch 6 implements the overutilization mechanism;
 - Patches 7-9 introduce the energy-aware wake-up path in the CFS class;
 - Patch 10 starts EAS for arm/arm64 from the arch_topology driver.

2. Test results

Two fundamentally different tests were executed. Firstly the energy
test case shows the impact on energy consumption this patch-set has
using a synthetic set of tasks. Secondly the performance test case
provides the conventional hackbench metric numbers.

The tests run on two arm64 big.LITTLE platforms: Hikey960 (4xA73 +
4xA53) and Juno r0 (2xA57 + 4xA53).

Base kernel is tip/sched/core (4.17-rc3), with some Hikey960 and
Juno specific patches, the SD_ASYM_CPUCAPACITY flag set at DIE sched
domain level for arm64 and schedutil as cpufreq governor [4].

2.1 Energy test case

10 iterations of between 10 and 50 periodic rt-app tasks (16ms period,
5% duty-cycle) for 30 seconds with energy measurement. Unit is Joules.
The goal is to save energy, so lower is better.

2.1.1 Hikey960

Energy is measured with an ACME Cape on an instrumented board. Numbers
include consumption of big and little CPUs, LPDDR memory, GPU and most
of the other small components on the board. They do not include
consumption of the radio chip (turned-off anyway) and external
connectors.

+----------+-----------------+------------------------+
|          | Without patches | With patches           |
+----------+--------+--------+-----------------+------+
| Tasks nb |  Mean  | RSD*   | Mean            | RSD* |
+----------+--------+--------+-----------------+------+
|       10 |  33.45 |   1.2% | 28.97 (-13.39%) | 2.0% |
|       20 |  45.45 |   1.7% | 42.76 (-5.92%)  | 0.8% |
|       30 |  65.06 |   0.2% | 64.85 (-0.32%)  | 4.7% |
|       40 |  85.67 |   0.7% | 77.98 (-8.98%)  | 2.8% |
|       50 | 110.14 |   0.9% | 99.34 (-9.81%)  | 2.0% |
+----------+--------+--------+-----------------+------+

2.1.2 Juno r0

Energy is measured with the onboard energy meter. Numbers include
consumption of big and little CPUs.

+----------+-----------------+------------------------+
|          | Without patches | With patches           |
+----------+--------+--------+-----------------+------+
| Tasks nb |  Mean  | RSD*   | Mean            | RSD* |
+----------+--------+--------+-----------------+------+
|       10 |  10.40 |   3.0% |  7.00 (-32.69%) | 2.5% |
|       20 |  18.47 |   1.1% | 12.88 (-30.27%) | 2.4% |
|       30 |  27.97 |   2.2% | 21.26 (-23.99%) | 0.2% |
|       40 |  36.86 |   1.2% | 30.63 (-16.90%) | 0.4% |
|       50 |  46.79 |   0.5% | 45.85 ( -0.02%) | 0.7% |
+----------+--------+--------+------------------+------+

2.2 Performance test case

30 iterations of perf bench sched messaging --pipe --thread --group G
--loop L with G=[1 2 4 8] and L=50000 (Hikey960)/16000 (Juno r0).

2.2.1 Hikey960

The impact of thermal capping was mitigated thanks to a heatsink, a
fan, and a 10 sec delay between two successive executions.

+----------------+-----------------+------------------------+
|                | Without patches | With patches           |
+--------+-------+---------+-------+----------------+-------+
| Groups | Tasks | Mean    | RSD*  | Mean           | RSD*  |
+--------+-------+---------+-------+----------------+-------+
|      1 |    40 |    8.75 | 0.99% |  9.46 (+8.11%) | 3.34% |
|      2 |    80 |   15.64 | 0.68% | 15.96 (+2.05%) | 0.71% |
|      4 |   160 |   31.58 | 0.65% | 32.22 (+2.03%) | 0.61% |
|      8 |   320 |   65.53 | 0.37% | 66.43 (+1.37%) | 0.36% |
+--------+-------+---------+-------+----------------+-------+

2.2.2 Juno r0

+----------------+-----------------+------------------------+
|                | Without patches | With patches           |
+--------+-------+---------+-------+----------------+-------+
| Groups | Tasks | Mean    | RSD*  | Mean           | RSD*  |
+--------+-------+---------+-------+----------------+-------+
|      1 |    40 |    8.25 | 0.11% |  8.21 ( 0.00%) | 0.10% |
|      2 |    80 |   14.40 | 0.14% | 14.37 ( 0.00%) | 0.12% |
|      4 |   160 |   26.72 | 0.24% | 26.73 ( 0.00%) | 0.14% |
|      8 |   320 |   52.89 | 0.10% | 52.87 ( 0.00%) | 0.23% |
+--------+-------+---------+-------+----------------+-------+

*RSD: Relative Standard Deviation (std dev / mean)

3. Changes between versions

Changes v2[2]->v3:
- Removed the PM_OPP dependency by implementing a new EM framework
- Modified the scheduler topology code to take references on the EM data
  structures
- Simplified the overutilization mechanism into a system-wide flag
- Reworked the integration in the wake-up path using the sd_ea shortcut
- Rebased on tip/sched/core (247f2f6f3c70 "sched/core: Don't schedule
  threads on pre-empted vCPUs")

Changes v1[3]->v2:
- Reworked interface between fair.c and energy.[ch] (Remove #ifdef
  CONFIG_PM_OPP from energy.c) (Greg KH)
- Fixed licence & header issue in energy.[ch] (Greg KH)
- Reordered EAS path in select_task_rq_fair() (Joel)
- Avoid prev_cpu if not allowed in select_task_rq_fair() (Morten/Joel)
- Refactored compute_energy() (Patrick)
- Account for RT/IRQ pressure in task_fits() (Patrick)
- Use UTIL_EST and DL utilization during OPP estimation (Patrick/Juri)
- Optimize selection of CPU candidates in the energy-aware wake-up path
- Rebased on top of tip/sched/core (commit b720342849fe “sched/core:
  Update Preempt_notifier_key to modern API”)

[1] https://lkml.org/lkml/2015/7/7/754
[2] https://marc.info/?l=linux-kernel&m=152302902427143&w=2
[3] https://marc.info/?l=linux-kernel&m=152153905805048&w=2
[4] http://linux-arm.org/git?p=linux-qp.git;a=shortlog;h=refs/heads/upstream/eas_v3

Morten Rasmussen (1):
  sched: Add over-utilization/tipping point indicator

Quentin Perret (9):
  sched: Relocate arch_scale_cpu_capacity
  sched/cpufreq: Factor out utilization to frequency mapping
  PM: Introduce an Energy Model management framework
  PM / EM: Expose the Energy Model in sysfs
  sched/topology: Reference the Energy Model of CPUs when available
  sched/fair: Introduce an energy estimation helper function
  sched: Lowest energy aware balancing sched_domain level pointer
  sched/fair: Select an energy-efficient CPU on task wake-up
  arch_topology: Start Energy Aware Scheduling

 drivers/base/arch_topology.c     |  19 ++
 include/linux/energy_model.h     | 123 +++++++++++
 include/linux/sched/cpufreq.h    |   6 +
 include/linux/sched/topology.h   |  19 ++
 kernel/power/Kconfig             |  15 ++
 kernel/power/Makefile            |   2 +
 kernel/power/energy_model.c      | 343 +++++++++++++++++++++++++++++++
 kernel/sched/cpufreq_schedutil.c |   3 +-
 kernel/sched/fair.c              | 186 ++++++++++++++++-
 kernel/sched/sched.h             |  51 +++--
 kernel/sched/topology.c          | 117 +++++++++++
 11 files changed, 860 insertions(+), 24 deletions(-)
 create mode 100644 include/linux/energy_model.h
 create mode 100644 kernel/power/energy_model.c

-- 
2.17.0
