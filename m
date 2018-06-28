Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811A2C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C0827288
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C0827288
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753643AbeF1LlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 07:41:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45624 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752369AbeF1LlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 07:41:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 642BB80D;
        Thu, 28 Jun 2018 04:41:00 -0700 (PDT)
Received: from e108498-lin.cambridge.arm.com (e108498-lin.cambridge.arm.com [10.1.211.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F09023F266;
        Thu, 28 Jun 2018 04:40:55 -0700 (PDT)
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
Subject: [RFC PATCH v4 00/12] Energy Aware Scheduling
Date:   Thu, 28 Jun 2018 12:40:31 +0100
Message-Id: <20180628114043.24724-1-quentin.perret@arm.com>
X-Mailer: git-send-email 2.17.1
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
1. Patches 01-04/12 introduce a centralized and independent EM
   management framework
2. Patches 05-10/12 make use of the EM in the scheduler to bias task
   placement decisions
3. Patches 11-12/12 give an Arm64 example on how to register an Energy
   Model in the new framework


1. The Energy Model Framework

The energy consumed by the CPUs can be provided to the OS in different
ways depending on the source of information (firmware or device tree for
example). The EM framework introduced in patch 03/12 addresses this
issue by aggregating the data coming from the drivers in a standard way
and making it available to interested clients (thermal or the task
scheduler, for example).

Although this series comprises patches for the task scheduler as a user
of the EM, the framework itself as introduced in patch 03/12 is meant to
be _independent_ from any other subsystem.

The overall design of the EM framework is depicted on the diagram below
(focused on Arm drivers for the example, but applicable to any
architecture).

   +---------------+  +-----------------+  +---------+
   | Thermal (IPA) |  | Scheduler (EAS) |  | Other ? |
   +---------------+  +-----------------+  +---------+
           |                 | em_fd_energy()   |
           |                 | em_cpu_get()     |
           +-----------+     |         +--------+
                       |     |         |
                       v     v         v
                    +---------------------+
                    |                     |         +---------------+
                    |    Energy Model     |         | arch_topology |
                    |                     |<--------|    driver     |
                    |     Framework       |         +---------------+
                    |                     | em_rescale_cpu_capacity()
                    +---------------------+
                       ^       ^       ^
                       |       |       | em_register_freq_domain()
            +----------+       |       +---------+
            |                  |                 |
    +---------------+  +---------------+  +--------------+
    |  cpufreq-dt   |  |   arm_scmi    |  |    Other     |
    +---------------+  +---------------+  +--------------+
            ^                  ^                 ^
            |                  |                 |
    +--------------+   +---------------+  +--------------+
    | Device Tree  |   |   Firmware    |  |      ?       |
    +--------------+   +---------------+  +--------------+

Drivers can register data in the EM framework using the
em_register_freq_domain() API. They are expected to provide a callback

function that the EM framework can use to build energy cost tables and
store them in shared data structures. Then, clients such as the task
scheduler are allowed to read those shared structures using the
em_fd_energy() and em_cpu_get() APIs. The EM framework also provides
another API enabling to dynamically re-scale the CPU capacity values of
the EM, if needed. The rationale behind this need for dynamic re-scaling
and more details about the different APIs of the framework can be found
in patch 03/12.


2. Energy-aware task placement in the task scheduler

Patches 05-10/12 make use of the newly introduced EM in the scheduler to
bias task placement decisions. When the system is detected as
non-”overutilized”, an EM is available, and the platform has an
asymmetric CPU capacity topology (e.g. big.LITTLE), the consequences on
energy of placing a waking task on a CPU are taken into account to avoid
energy-inefficient CPUs if possible. Patches 05-07/12 modify the
scheduler topology code in order to: 1) check if all conditions for EAS
are met when the scheduling domains are built; and 2) create data
structures holding references on the EM tables that can be accessed in
latency sensitive code paths (e.g. wake-up path).

An “overutilized” flag (patch 08/12) is attached to the root domain,
and is set whenever a CPU is utilized at more than 80% of its capacity.
Patches 09-10/12 introduce the new energy-aware wake-up path which makes
use of the data structures introduced in patches 05-07/10 whenever the
system isn’t overutilized.


3. Arm example of driver modifications to register an EM

Patches 11-12/12 show an example of how drivers should be modified to
register an EM in the new framework and potentially re-scale it. The
patches target Arm drivers, as an example, but the same ideas should be
applicable for others architectures. Patch 11/12 calls the re-scaling
API of the EM framework from the arch_topology driver which changes the
CPU capacity values after CPUFreq is up and running. Patch 12/12 changes
the cpufreq-dt driver (used for testing on Hikey960, see Section 4.) to
provide estimated power values to the EM framework using coefficients
read from DT. This patch has been made simple and self-contained
intentionally in order to show an example of usage of the EM framework.


4. Test results

Two fundamentally different tests were executed. Firstly the energy test
case shows the impact on energy consumption this patch-set has using a
synthetic set of tasks. Secondly the performance test case provides the
conventional hackbench metric numbers.

The tests run on two arm64 big.LITTLE platforms: Hikey960 (4xA73 +
4xA53) and Juno r0 (2xA57 + 4xA53).

Base kernel is tip/sched/core (4.17-rc6), with some Hikey960 and Juno
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
|       10 | 33.15  |   1.8% |  28.36 (-14.45%) | 1.3% |
|       20 | 50.91  |   3.1% |  42.79 (-15.95%) | 1.4% |
|       30 | 63.97  |   5.0% |  57.35 (-10.35%) | 2.4% |
|       40 | 92.99  |   4.7% |  82.10 (-11.71%) | 6.3% |
|       50 | 133.08 |   5.1% | 106.89 (-19.68%) | 5.8% |
+----------+--------+--------+------------------+------+

4.1.2 Juno r0

Energy is measured with the onboard energy meter. Numbers include
consumption of big and little CPUs.

+----------+-----------------+------------------------+
|          | Without patches | With patches           |
+----------+--------+--------+-----------------+------+
| Tasks nb |  Mean  | RSD*   | Mean            | RSD* |
+----------+--------+--------+-----------------+------+

|       10 |  11.97 |   2.2% |  7.64 (-36.17%) | 2.7% |
|       20 |  20.66 |   2.9% | 13.92 (-29.74%) | 2.2% |
|       30 |  33.18 |   1.9% | 23.22 (-30.02%) | 2.7% |
|       40 |  45.71 |   0.7% | 33.99 (-25.64%) | 5.9% |
|       50 |  56.92 |   0.4% | 53.58 ( -5.87%) | 1.0% |
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
|      1 |    40 |    8.24 | 0.96% |  8.36 (+1.56%) | 1.48% |
|      2 |    80 |   15.53 | 0.74% | 15.72 (+1.23%) | 0.65% |
|      4 |   160 |   31.97 | 0.50% | 32.35 (+1.18%) | 0.44% |
|      8 |   320 |   66.31 | 0.47% | 67.11 (+1.20%) | 0.37% |
+--------+-------+---------+-------+----------------+-------+

4.2.2 Juno r0

+----------------+-----------------+------------------------+
|                | Without patches | With patches           |
+--------+-------+---------+-------+----------------+-------+
| Groups | Tasks | Mean    | RSD*  | Mean           | RSD*  |
+--------+-------+---------+-------+----------------+-------+
|      1 |    40 |    7.70 | 0.96% |  7.63 (-0.91%) | 1.14% |
|      2 |    80 |   13.94 | 1.05% | 13.88 (-0.43%) | 1.20% |
|      4 |   160 |   26.32 | 1.66% | 26.04 (-1.06%) | 1.38% |
|      8 |   320 |   52.41 | 2.86% | 52.07 (-0.65%) | 2.41% |
+--------+-------+---------+-------+----------------+-------+

*RSD: Relative Standard Deviation (std dev / mean)


5. Version history:

Changes v3[3]->v4:
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

Changes v2[4]->v3:
- Removed the PM_OPP dependency by implementing a new EM framework
- Modified the scheduler topology code to take references on the EM data
  structures
- Simplified the overutilization mechanism into a system-wide flag
- Reworked the integration in the wake-up path using the sd_ea shortcut
- Rebased on tip/sched/core (247f2f6f3c70 "sched/core: Don't schedule
  threads on pre-empted vCPUs")

Changes v1[5]->v2:
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
[2] http://www.linux-arm.org/git?p=linux-qp.git;a=shortlog;h=refs/heads/upstream/eas_v4
[3] https://marc.info/?l=linux-kernel&m=152691273111941&w=2
[4] https://marc.info/?l=linux-kernel&m=152302902427143&w=2
[5] https://marc.info/?l=linux-kernel&m=152153905805048&w=2

Morten Rasmussen (1):
  sched: Add over-utilization/tipping point indicator

Quentin Perret (11):
  sched: Relocate arch_scale_cpu_capacity
  sched/cpufreq: Factor out utilization to frequency mapping
  PM: Introduce an Energy Model management framework
  PM / EM: Expose the Energy Model in sysfs
  sched/topology: Reference the Energy Model of CPUs when available
  sched/topology: Lowest energy aware balancing sched_domain level
    pointer
  sched/topology: Introduce sched_energy_present static key
  sched/fair: Introduce an energy estimation helper function
  sched/fair: Select an energy-efficient CPU on task wake-up
  OPTIONAL: arch_topology: Start Energy Aware Scheduling
  OPTIONAL: cpufreq: dt: Register an Energy Model

 drivers/base/arch_topology.c     |  15 ++
 drivers/cpufreq/cpufreq-dt.c     |  45 +++-
 include/linux/energy_model.h     | 141 ++++++++++++
 include/linux/sched/cpufreq.h    |   6 +
 include/linux/sched/topology.h   |  19 ++
 kernel/power/Kconfig             |  15 ++
 kernel/power/Makefile            |   2 +
 kernel/power/energy_model.c      | 367 +++++++++++++++++++++++++++++++
 kernel/sched/cpufreq_schedutil.c |   3 +-
 kernel/sched/fair.c              | 238 +++++++++++++++++++-
 kernel/sched/sched.h             |  64 ++++--
 kernel/sched/topology.c          | 203 +++++++++++++++++
 12 files changed, 1090 insertions(+), 28 deletions(-)
 create mode 100644 include/linux/energy_model.h
 create mode 100644 kernel/power/energy_model.c

-- 
2.17.1

