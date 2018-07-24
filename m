Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18501ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16CC20880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16CC20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbeGXNbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:31:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49804 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbeGXNbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:31:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4FC980D;
        Tue, 24 Jul 2018 05:25:32 -0700 (PDT)
Received: from e108498-lin.Emea.Arm.com (e108498-lin.emea.arm.com [10.4.13.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 830403F6A8;
        Tue, 24 Jul 2018 05:25:28 -0700 (PDT)
From:   Quentin Perret <quentin.perret@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org, quentin.perret@arm.com
Subject: [PATCH v5 00/14] Energy Aware Scheduling
Date:   Tue, 24 Jul 2018 13:25:07 +0100
Message-Id: <20180724122521.22109-1-quentin.perret@arm.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Energy Aware Scheduler (EAS) based on Morten Rasmussen's posting on
LKML [1] is currently part of the AOSP Common Kernel and runs on today's
smartphones with Arm's big.LITTLE CPUs. This series implements a new and
largely simplified version of EAS based on an Energy Model (EM) of the
platform with only costs information for the active states of the CPUs.

The patch-set is organized in three main parts.
1. Patches 01-04/14 introduce a centralized and independent EM
   management framework
2. Patches 05-12/14 make use of the EM in the scheduler to bias task
   placement decisions
3. Patches 13-14/14 give an Arm64 example on how to register an Energy
   Model in the new framework


1. The Energy Model Framework

The energy consumed by the CPUs can be provided to the OS in different
ways depending on the source of information (firmware or device tree for
example). The EM framework introduced in patch 03/14 addresses this
issue by aggregating the data coming from the drivers in a standard way
and making it available to interested clients (thermal or the task
scheduler, for example).

Although this series comprises patches for the task scheduler as a user
of the EM, the framework itself as introduced in patch 03/14 is meant to
be _independent_ from any other subsystem.

The overall design of the EM framework is depicted on the diagram below
(focused on Arm drivers for the example, but applicable to any
architecture).

      +---------------+  +-----------------+  +-------------+
      | Thermal (IPA) |  | Scheduler (EAS) |  |    Other    |
      +---------------+  +-----------------+  +-------------+
              |                   | em_fd_energy()   |
              |                   | em_cpu_get()     |
              +-----------+       |       +----------+
                          |       |       |
                          v       v       v
                       +---------------------+
                       |                     |
                       |    Energy Model     |
                       |                     |
                       |     Framework       |
                       |                     |
                       +---------------------+
                          ^       ^       ^
                          |       |       | em_register_freq_domain()
               +----------+       |       +---------+
               |                  |                 |
       +---------------+  +---------------+  +--------------+
       |  cpufreq-dt   |  |   arm_scmi    |  |    Other     |
       +---------------+  +---------------+  +--------------+
               ^                  ^                 ^
               |                  |                 |
       +--------------+   +---------------+  +--------------+
       | Device Tree  |   |   Firmware    |  |      ?       |
       +--------------+   +---------------+  +--------------+

Drivers can register data in the EM framework using the
em_register_freq_domain() API. They are expected to provide a callback
function that the EM framework can use to build energy cost tables and
store them in shared data structures. Then, clients such as the task
scheduler are allowed to read those shared structures using the
em_fd_energy() and em_cpu_get() APIs. More details about the different
APIs of the framework can be found in patch 03/14.


2. Energy-aware task placement in the task scheduler

Patches 05-12/14 make use of the newly introduced EM in the scheduler to
bias task placement decisions. When the system is detected as
non-”overutilized”, an EM is available, and the platform has an
asymmetric CPU capacity topology (e.g. big.LITTLE), the consequences on
energy of placing a waking task on a CPU are taken into account to avoid
energy-inefficient CPUs if possible. Patches 05-07/14 modify the
scheduler topology code in order to: 1) check if all conditions for EAS
are met when the scheduling domains are built; and 2) create data
structures holding references on the EM tables that can be accessed in
latency sensitive code paths (e.g. wake-up path).

An “overutilized” flag (patches 08-09/14) is attached to the root domain,
and is set whenever a CPU is utilized at more than 80% of its capacity.
Patches 10-12/14 introduce the new energy-aware wake-up path which makes
use of the data structures introduced in patches 05-07/14 whenever the
system isn’t overutilized.


3. Arm example of driver modifications to register an EM

Patches 13-14/14 show an example of how drivers should be modified to
register an EM in the new framework. The patches target Arm drivers,
as an example, but the same ideas should be applicable for others
architectures. Patch 13/14 rebuilds the scheduling domains once CPUFreq
is up and running, and after the asymmetry of the system has been
discovered. Patch 14/14 changes the cpufreq-dt driver (used for testing
on Hikey960, see Section 4.) to provide estimated power values to the
EM framework using coefficients read from DT. This patch has been made
simple and self-contained intentionally in order to show an example of
usage of the EM framework.


4. Test results

Two fundamentally different tests were executed. Firstly the energy test
case shows the impact on energy consumption this patch-set has using a
synthetic set of tasks. Secondly the performance test case provides the
conventional hackbench metric numbers.

The tests run on two arm64 big.LITTLE platforms: Hikey960 (4xA73 +
4xA53) and Juno r0 (2xA57 + 4xA53).

Base kernel is tip/sched/core (4.18-rc5), with some Hikey960 and Juno
specific patches, the SD_ASYM_CPUCAPACITY flag set at DIE sched domain
level for arm64 and schedutil as cpufreq governor [2].

4.1 Energy test case

10 iterations of between 10 and 50 periodic rt-app tasks (16ms period,
5% duty-cycle) for 30 seconds with energy measurement. Unit is Joules.
The goal is to save energy, so lower is better.

4.1.1 Hikey960

Energy is measured with an ACME Cape on an instrumented board. Numbers
include consumption of big and little CPUs, LPDDR memory, GPU and most
of the other small components on the board. They do not include
consumption of the radio chip (turned-off anyway) and external
connectors.

+----------+-----------------+-------------------------+
|          | Without patches | With patches            |
+----------+--------+--------+------------------+------+
| Tasks nb |  Mean  | RSD*   | Mean             | RSD* |
+----------+--------+--------+------------------+------+

|       10 |  32.16 |   1.3% |  30.36  (-5.60%) | 1.2% |
|       20 |  50.28 |   1.3% |  44.79 (-10.92%) | 0.6% |
|       30 |  67.59 |   6.1% |  59.32 (-12.24%) | 1.4% |
|       40 |  91.47 |   2.8% |  85.96  (-6.02%) | 3.7% |
|       50 | 131.39 |   6.6% | 111.42 (-15.20%) | 4.8% |
+----------+--------+--------+------------------+------+

4.1.2 Juno r0

Energy is measured with the onboard energy meter. Numbers include
consumption of big and little CPUs.

+----------+-----------------+------------------------+
|          | Without patches | With patches           |
+----------+--------+--------+-----------------+------+
| Tasks nb |  Mean  | RSD*   | Mean            | RSD* |
+----------+--------+--------+-----------------+------+
|       10 |  11.07 |   3.2% |  8.04 (-27.37%) | 2.2% |
|       20 |  20.14 |   4.2% | 14.20 (-29.49%) | 1.4% |
|       30 |  32.67 |   3.5% | 24.06 (-26.35%) | 3.0% |
|       40 |  46.23 |   1.0% | 36.87 (-20.24%) | 7.3% |
|       50 |  57.36 |   0.5% | 54.69 ( -4.65%) | 0.7% |
+----------+--------+--------+-----------------+------+

4.2 Performance test case

30 iterations of perf bench sched messaging --pipe --thread --group G
--loop L with G=[1 2 4 8] and L=50000 (Hikey960)/16000 (Juno r0).

4.2.1 Hikey960

The impact of thermal capping was mitigated thanks to a heatsink, a
fan, and a 10 sec delay between two successive executions.

+----------------+-----------------+------------------------+
|                | Without patches | With patches           |
+--------+-------+---------+-------+----------------+-------+
| Groups | Tasks | Mean    | RSD*  | Mean           | RSD*  |
+--------+-------+---------+-------+----------------+-------+
|      1 |    40 |    8.01 | 1.13% |  8.01 (+0.00%) | 1.40% |
|      2 |    80 |   14.57 | 0.53% | 14.57 (+0.00%) | 0.63% |
|      4 |   160 |   29.92 | 0.60% | 30.79 (+2.91%) | 0.49% |
|      8 |   320 |   63.42 | 0.68% | 65.27 (+2.92%) | 0.43% |
+--------+-------+---------+-------+----------------+-------+

4.2.2 Juno r0

+----------------+-----------------+-----------------------+
|                | Without patches | With patches          |
+--------+-------+---------+-------+---------------+-------+
| Groups | Tasks | Mean    | RSD*  | Mean          | RSD*  |
+--------+-------+---------+-------+---------------+-------+
|      1 |    40 |    7.76 | 0.11% |  7.83 (0.01%) | 0.11% |
|      2 |    80 |   14.22 | 0.14% | 14.41 (0.01%) | 0.15% |
|      4 |   160 |   26.95 | 0.34% | 27.08 (0.01%) | 0.24% |
|      8 |   320 |   54.38 | 1.65% | 55.94 (0.03%) | 3.70% |
+--------+-------+---------+-------+---------------+-------+

*RSD: Relative Standard Deviation (std dev / mean)


5. Version history:

Changes v4[3]->v5:
- Removed the RCU protection of the EM tables and the associated
  need for em_rescale_cpu_capacity().
- Factorized schedutil’s PELT aggregation function with EAS
- Improved comments/doc in the EM framework
- Added check on the uarch of CPUs in one fd in the EM framework
- Reduced CONFIG_ENERGY_MODEL ifdefery in kernel/sched/topology.c
- Cleaned-up update_sg_lb_stats parameters
- Improved comments in compute_energy() to explain the multi-rd
  scenarios

Changes v3[4]->v4:
- Replaced spinlock in EM framework by smp_store_release/READ_ONCE
- Fixed missing locks to protect rcu_assign_pointer in EM framework
- Fixed capacity calculation in EM framework on 32 bits system
- Fixed compilation issue for CONFIG_ENERGY_MODEL=n
- Removed cpumask from struct em_freq_domain, now dynamically allocated
- Power costs of the EM are specified in milliwatts
- Added example of CPUFreq driver modification
- Added doc/comments in the EM framework and better commit header
- Fixed integration issue with util_est in cpu_util_next()
- Changed scheduler topology code to have one freq. dom. list per rd
- Split sched topology patch in smaller patches
- Added doc/comments explaining the heuristic in the wake-up path
- Changed energy threshold for migration to from 1.5% to 6%

Changes v2[5]->v3:
- Removed the PM_OPP dependency by implementing a new EM framework
- Modified the scheduler topology code to take references on the EM data
  structures
- Simplified the overutilization mechanism into a system-wide flag
- Reworked the integration in the wake-up path using the sd_ea shortcut
- Rebased on tip/sched/core (247f2f6f3c70 "sched/core: Don't schedule
  threads on pre-empted vCPUs")

Changes v1[6]->v2:
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
[2] http://www.linux-arm.org/git?p=linux-qp.git;a=shortlog;h=refs/heads/upstream/eas_v5
[3] https://marc.info/?l=linux-kernel&m=153018606728533&w=2
[4] https://marc.info/?l=linux-kernel&m=152691273111941&w=2
[5] https://marc.info/?l=linux-kernel&m=152302902427143&w=2
[6] https://marc.info/?l=linux-kernel&m=152153905805048&w=2


Morten Rasmussen (1):
  sched: Add over-utilization/tipping point indicator

Quentin Perret (13):
  sched: Relocate arch_scale_cpu_capacity
  sched/cpufreq: Factor out utilization to frequency mapping
  PM: Introduce an Energy Model management framework
  PM / EM: Expose the Energy Model in sysfs
  sched/topology: Reference the Energy Model of CPUs when available
  sched/topology: Lowest energy aware balancing sched_domain level
    pointer
  sched/topology: Introduce sched_energy_present static key
  sched/fair: Clean-up update_sg_lb_stats parameters
  sched/cpufreq: Refactor the utilization aggregation method
  sched/fair: Introduce an energy estimation helper function
  sched/fair: Select an energy-efficient CPU on task wake-up
  OPTIONAL: arch_topology: Start Energy Aware Scheduling
  OPTIONAL: cpufreq: dt: Register an Energy Model

 drivers/base/arch_topology.c     |   2 +
 drivers/cpufreq/cpufreq-dt.c     |  45 ++++-
 include/linux/energy_model.h     | 162 +++++++++++++++++
 include/linux/sched/cpufreq.h    |   6 +
 include/linux/sched/topology.h   |  19 ++
 kernel/power/Kconfig             |  15 ++
 kernel/power/Makefile            |   2 +
 kernel/power/energy_model.c      | 289 +++++++++++++++++++++++++++++++
 kernel/sched/cpufreq_schedutil.c |  89 ++++++----
 kernel/sched/fair.c              | 273 ++++++++++++++++++++++++++---
 kernel/sched/sched.h             |  85 ++++++---
 kernel/sched/topology.c          | 214 ++++++++++++++++++++++-
 12 files changed, 1125 insertions(+), 76 deletions(-)
 create mode 100644 include/linux/energy_model.h
 create mode 100644 kernel/power/energy_model.c

-- 
2.18.0

